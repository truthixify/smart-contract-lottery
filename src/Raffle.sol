// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// internal & private view & pure functions
// external & public view & pure functions

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title A Raffle Contract
 * @author truthixify
 * @notice This contract is a raffle contract
 * @dev Implements Chainlink VRFv2.5
 */
contract Raffle {
    /* Errors */
    error Raffle__SendMoreToEnterRaffle();
    error Raffle__NotEnoughTimePassed();

    uint256 private immutable i_entranceFee;
    // @dev Duration of lottery in seconds
    uint256 private immutable i_interval;
    address payable[] private s_players;
    uint256 private s_lastTimeStamp;

    /* Evemts */
    event RaffleEntered(address indexed player);

    constructor(uint256 entranceFee, uint256 interval) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
    }

    function enterRaffle() external payable {
        // Enter the raffle
        // require(msg.value >= i_entranceFee, "Not enough ETH sent!");
        // require(msg.value >= i_entranceFee, SendMoreToEnterRaffle());
        if (msg.value < i_entranceFee) {
            revert Raffle__SendMoreToEnterRaffle();
        }

        s_players.push(payable(msg.sender));

        emit RaffleEntered(msg.sender);
    }

    function pickWinner() external {
        // Check to see if enough time has passed
        // require(block.timestamp - s_lastTimeStamp > i_interval, "Not enough time has passed!");
        if (block.timestamp - s_lastTimeStamp <= i_interval) {
            revert Raffle__NotEnoughTimePassed();
        }

        // Get our random number from Chainlink VRFv2.5
    }

    /**
     * @notice Get the entrance fee
     * @return The entrance fee
     */
    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
