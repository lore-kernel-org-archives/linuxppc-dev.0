Message-ID: <385703C2.AA4298E7@netx4.com>
Date: Tue, 14 Dec 1999 21:58:10 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: bsimon@ctam.com.au
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc embedded boot problems.
References: <3856C0D7.4E1404C9@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brendan Simon wrote:


> I have HAD linuxppc (embedded-2.2.5) working on a custom MPC860 board.
> By working I mean booting to the bash prompt and being able to view the
> initrd filesystem with ls.


Debug-101.....Back out the changes until you get to the
original working version.  That usually helps uncover information
necessary to solve the problem.


> ....  I have compiled some simple apps that print
> things to the console but they only work if I compile with -static
> option.


Perhaps because you are compiling/linking on a system with
different libraries that are running on the target.


> .......  I decided to put a whole lot of
> printk statements in the enet.c code to see what was happening.


Bad idea.  Maybe one or two that you keep moving around as you
discover information.


> ........  Cool, but the
> console hung and there is no bash shell.  I put some more printks in
> init/main.c to see how far the code was getting.

Again, just one or two around some key functions calls will tell
you lots of information.


> loaded at:     FF801000 FF812BAC
> relocated to:  00100000 00111BAC
> board data at: 001001C4 001001E0
> relocated to:  00200100 0020011C
> zimage at:     FF807000 FF868100
> avail ram:     00201000 01000000
> 

> Sections:
> Idx Name          Size      VMA       LMA       File off  Algn
>   0 .text         00004870  ff801000  ff801000  00001000  2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
>   1 .rodata       00000470  ff805870  ff805870  00005870  2**4
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>   2 .data         00000300  ff806000  ff806000  00006000  2**2
>                   CONTENTS, ALLOC, LOAD, DATA
>   3 .bss          0000bbac  ff807000  ff807000  00007000  2**2
>                   ALLOC
>   4 image         00061104  ff807000  ff807000  00007000  2**0
>                   CONTENTS, ALLOC, LOAD, DATA


Well, the output above doesn't match this set of headers.  The
VMA/LMA are not supposed to be the Flash ROM offsets, they are
supposed to be the 0x00100000 addresses where the code
really belongs in RAM.  The first stage of the Linux boot will
discover it is running at some address other than RAM, and
relocate itself to the linked address.

Do not ever change the load/offset addresses in Makefiles.
Use or write a program that will take the exact bits and place
them into a flash rom.  It couldn't be easier.  The zImage is
a perfect bag of bits that can be loaded (almost) anywhere
into memory or a flash rom without any modification.


Good Luck.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
