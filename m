Message-ID: <A109131318C4D1119AC20060088DECE330F37A@amwmail.adaptivemicro.com>
From: Lucinda Schafer <lucsch@adaptivemicro.com>
To: Dan Malek <dan@netx4.com>, Wolfgang Denk <wd@denx.de>,
        "Wohlgemuth, Jason" <jason.wohlgemuth@marconi.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: RE: Software Emulation Kernel Panic
Date: Mon, 12 Jun 2000 15:16:01 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for answering so promptly.

Some more information...

We are using the mpc8xx-2.2.13 Kernel (Dan's) with the FPU and Memory
Management patches. We are using glibc 2.1 (compiled ourselves) for our
application (linking statically) and libc 1.99 for everything else.

Our system is stand-alone, running from flash, although at times we have the
ethernet connected for mounting our development box's drive. We have
multiple boards running. Some boards do seem more likely than others to
panic.

This is a very intermittent problem. I have a special application program
that will run automatically at bootup and shut the processor power down for
a minute, powerup, and then have the reboot sequence starts over again. I've
seen it run 21 hours like this before a panic occurs.

I have another system (2 boards that communicate every 4 minutes using
AX.25) that ran all weekend but I did not reboot the board--just kept the
application running--with no panic problem.

This seems to be a boot related problem, although we have observed that
usually the panic occurs on running a program from bash; although, one time
I saw it panic in the init process (exec from main.c). The panic usually if
not always occurs on the FIRST run of a program. If it works once, it will
not panic on this particular bootup ever.

Wolfgang's suggestion makes a lot of sense to me:
"Usually this means that you are running on an old  mask  revision  of
the  CPU,  which  still  has  the  (in)famous  "Cache Corruption When
Writing to Special Registers" bug."

I read in the MPC823 user's manual that accessing some off-core SFR's can
cause the software emulation exception with PR=0 if there is a bus error
(why should there be a bus error?? this isn't answered), which would cause
the particular message of "Kernel Mode Software FPU Emulation".

We will try turning off the cache as a test.

Lucinda Schafer
Adaptive Micro-Ware, Inc.
Staff Software Engineer

-----Original Message-----
From: Dan Malek [mailto:dan@netx4.com]
Sent: Monday, June 12, 2000 2:44 PM
To: Lucinda Schafer
Cc: linuxppc-embedded@lists.linuxppc.org; cort@cs.nmt.edu;
paulus@cs.anu.edu.au
Subject: Re: Software Emulation Kernel Panic


Lucinda Schafer wrote:

> On our MPC823-based custom boards, we are experiencing the "Kernel Mode
> Software FPU Emulation" panic


This has little to do with floating point.  Nearly all instructions
the processor can't decode are vectored to this function.  It assumes
the primary reason you are here is to emulate floating point instructions.
If the function can't decode the instruction as a floating point operation,
it is really something the processor can't execute, so the panic message
spews forth.

> Could you shed some light on some situations where this may happen?

This can be either a software or hardware bug.  If it is a software
bug, just unravel the stack backtrace and debug it.  It could be a
trashed stack frame, resulting in a bad function return address, or
some indirect function call that was not properly computed.

It could also happen because of a hardware bug while fetching instructions
from memory.  Verify the NIP instruction that it tried to decode is
what is really supposed to be at that location in memory.  This is
a typical failure when the UPM is not programmed correctly.  Since
this is a custom board, have you verified all memory cycles?  Disable
the cache and try again, you will probably get a different result.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
