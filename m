Message-ID: <39453D7A.10E9AF8C@embeddededge.com>
Date: Mon, 12 Jun 2000 15:43:54 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Lucinda Schafer <lucsch@adaptivemicro.com>
CC: linuxppc-embedded@lists.linuxppc.org, cort@cs.nmt.edu,
        paulus@cs.anu.edu.au
Subject: Re: Software Emulation Kernel Panic
References: <A109131318C4D1119AC20060088DECE330F374@amwmail.adaptivemicro.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
