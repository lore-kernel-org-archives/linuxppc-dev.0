Message-ID: <37BD4FF7.D77C6019@email.sps.mot.com>
Date: Fri, 20 Aug 1999 14:54:15 +0200
From: "Pierre Juste" <r41805@email.sps.mot.com>
Reply-To: Pierre_Juste@email.mot.com
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: PPC Linux crash resulting MMU problem !!
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


We are working for a port of Linux PPC on a system based on 860 PowerPC.
Quick overview of the PB: Our system is crashing fastly after boot resulting of
MMU error. We are very interseting by any one feedback concerning solving
PB of MMU on PowerPC specialy on MPC8xx under Linux.

Thanks

Pierre

PB:

We have connect for debug purpose of out target the FADS860 (Emulator)
through the serial BDM connector (SRESET, HRESET, DIN, DOUT, CLK
+ 2 observation pins).

Our software PB is the following one:

We are debugging Linux. We are very near to satisfaction; the OS performs well
if our PowerPC board is started with FADS on (we do only configure the DER
register, enable the monitor ROM and run it), but "random" errors appear when
PowerPC board is standalone.

The errors are fairly stable (not fully) when using a given binary code.
When a few dummy lines of code are added (anywhere), the program stops
anywhere else (not at the same location as before, mostoften  the
execution is stopped much before the code that has been added should be
executed). To understand what happens, we added code to every exception
to track code execution (we suspected that the kind of behaviour we
describe here had to do with the MMU operation). Some registers have
been traced; the tracing methodology is to use part of the existing
memory (not made available to OS) as a trace pad. When the program is
obviously stuck, we perform a software reset via SRESET on the BDM;
inside the 0x100 routine, we trace which instruction we have been
interrupting, enable branch tracing and return to normal execution (this
is to see if something executes thereafter). Then we perform a harware
reset (PORESET) and look at the content of the scratchpad memory.

Here is the result of seven trials with PowerPC board standelone (each
corresponds to a different binary code, the difference being dummy code
- only printfs at the end of OS boot, which is most of time not
reached). We did omit the beginning of the trace, emphasizing only the
content of the last TLB miss when necessary, the soft reset trace, and
when relevant the trace following. These results are not a selection :
these are seven consecutive logged trials :

Trial 1 :    1 ITLB miss @ 0xC009A000
                1 Sreset : SRR0 = 0xC009A000 SRR1 = 0x00000040

Comment : The TLB miss occurs at an exact page boundary. We cannot be
sure nothing is executed after the ITLB miss exception ends (logging
occurs after standard code execution), but the software reset interrupts
exactly the address pointed by ITLB miss ! In addition, SRR1 content is
strange (very invalid MSR content to save).

Trial 2 :    nothing very special about previous interrupts. Program
stopped. Sreset results are :
                1 Sreset : SRR0 = 0xC001D000    SRR1=0.

Trial 3 :    nothing very special about previous interrupts. Program
stopped. Sreset results are :
                1 Sreset : SRR0 = 0xC0079000    SRR1=0.

Comment : here again exact page boundaries ore observed when resetting
the program after blocking.

Trial 4 :    1 ITLB miss @ 0x C0012FD8
                1 Sreset : SRR0 = 0xC0012FD8 SRR1 = 0x08209032

Comment : here the ITLB miss does not occur at a page boundary, but it
seems the execution stops here, since the reset we perform after a while
indicates the same address as the ITLB miss. Question : what happens of
the SRR1 reserved bits after an exception is handled (0820 bits of SRR1
after ITLB miss exception for instance) ?

Trial 5 :    nothing very special about previous interrupts. Program
stopped. Sreset results are :
                1 Sreset : SRR0 = 0xC00A4000    SRR1=0x00000040.

Trial 6 :    1 DTLB miss at code address 0xC0006638
                1 Sreset : SRR0 = 0xC0006638    SRR1=0x00009032
                1 DTLB error at code address 0xC0006638

Comment : here we have a data TLB miss causing the stop. The code does
not progress thereafter, as indicated by the SRR0 at Sreset, but it
seems the Sreset has unlocked something, because execution tries to
restart this time, but with little success since a DTLB error is
observed immediately.

Trial 7 :    nothing very special about previous interrupts. Program
stopped. Sreset results are :
                1 Sreset : SRR0 = 0xC0060000    SRR1=0x00000040.

Comment : out of seven trials, five have their execution stopped at a
program page boundary, among these only one signalling a immediately
preceding ITLB miss at that address... For the DTLB miss, we did not
find any simple means to identify which data address had been causing
the miss.

Most of time, the reset enables to know where the program is stuck, but
when perchance it resumes execution after reset, the context seems to be
corrupted because nothing coherent is made by the CPU, that often ends
up with infinite loops. The software reset seems though to be a good
means to get the information we want, which is basically the saved
program counter (SRR0) and machnie state register (SRR1); on the
contrary, either the error that occured makes the resume impossible, or
the software reset modifies context too much, but the program flow after
incident it too erratic to be interpreted.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
