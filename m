Message-ID: <3BC50510.33553593@india.infogain.com>
Date: Thu, 11 Oct 2001 08:03:52 +0530
From: ashish anand <ashisha@india.infogain.com>
MIME-Version: 1.0
To: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem on ADS board
References: <619D608DD3F0D311882C009027732E1A83626B@ntserver.act.domain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


you mentioned two problems

a> unintentioned operation on flash
b> unintentioned operation on kernel memory by a user space flow.

as per my understanding , Memory controller is under doubt.. it is not properly
decoding addresses and hence wrong unintentioned operations.

put breakpoints on addreses(mapped for flash lock bit , and physical tranform of kernel virtual
address on which it crashees) and do few operations as a check.can try on another board if you have.



> I am running Linux 2.4.6 on Motorola 8260ADS board.
>
> I can start kernel (I use ppcboot) and get it booting and run simple
> applications.  If I try to run a complex application, board crashes without
> any warning and it also writes to the FLASH memory, corrupting it and
> setting lock bits on one of the 4 chips on Flash SIMM.
>
> Flash is not mapped into Linux memory space at all as far as I can see, so I
> do not quite understand how it can write there. Also to write to the flash,
> it has to execute a sequence of specific commands and there is no code to do
> so. At least I did not put in any and I could not see any.
>
> Some additional information that may be useful:
> I downloaded a program called memtester. This program tries to allocate as
> much memory as it can, then mlock it and run some tests on it. Allocation
> succeds, but somewhere in the locking part, system crashes. This program
> executes in the user space, so it should not crash the kernel, but it does.
> Also, I tried to see with BDI2000 what is going on. Results I am getting are
> somewhat strange:
> Most of the times, when board crashes, BDI2000 prompt says "Target reset
> detected" and it tries to re-initialize the board.
> In some cases, BDI2000 was saying that board is still running. Halting it
> reveals that it tries to execute something out of addresses in the beginnig
> of SDRAM (SDRAM starts at 0x0000_0000). Address translation is turned on, so
> I would really expect to see addresses offset of 0xC000_0000, because Linux
> was executing on board. If I let board run (with BDI2000 "go" command) and
> then halt it again, I may see that it halted in the kernel (addresses are
> offset). Starting and stopping the program in this manner shows me that
> current execution address jumps between offsetted and non-offsetetd
> addresses.
>
> I would appreciate any ideas on the subject.
>
> BTW, same version of kernel is running on 750 CPU runnign same memtester and
> there are no problems at all.
>
> Thank you,
>
> /************************/
> Rudolf Ladyzhenskii
> Senior DSP Engineer
> Advanced Communication Technologies
> ph.  +61 3 8080 8215
> fax. +61 3 9672 8800
> Level 9, 190 Queen Street,
> Melbourne, 3000
> Australia
> /***********************/
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
