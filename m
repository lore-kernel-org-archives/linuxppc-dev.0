Message-Id: <4.3.2.20010130095138.00baf2a0@falcon.si.com>
Date: Tue, 30 Jan 2001 10:27:20 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Initial stack frame 
In-Reply-To: <200101301446.f0UEkTO10556@denx.local.net>
References: <Your message of "Tue, 30 Jan 2001 08:26:45 EST." <4.3.2.20010130074919.00bb0a80@falcon.si.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 03:46 PM 1/30/01 +0100, Wolfgang Denk wrote:

>In message <4.3.2.20010130074919.00bb0a80@falcon.si.com>
>Jerry Van Baren wrote:
> >
> > One of the differences between the ABI and EABI is that the EABI
> > requires 8 byte alignment of the stack and the ABI requires 16 byte
> > alignment (EABI, p.28).
>
>Yes, ok. But what is implemented by GCC and glibc? The SVR4 ABI or
>the EABI?
>
>In other words: Wolfgang Grandegger wants to know if  we  must  align
>"private" stack frames on 8 or 16 byte boundaries...
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>Visit us at Embedded Systems: Feb 14-16 2001, Nuremberg, Halle 12/K01
>(with TQ Components); our presentation "Starke Zwerge: Embedded Linux
>auf PowerPC-Systemen" on Thursday, Feb 15 2001, 13:30 Forum Halle 11.

The stack frame alignment shouldn't matter as long as it doesn't matter
to the processor (there may be efficiency reasons to align to 16 bytes,
but there doesn't appear to be any operational problems aligning to 8
bytes -- I never knowingly misaligned to 4 bytes so I don't know if
that works).

The difference between 8 and 16 byte alignment is extra padding words
inside the stack frame.  Since C doesn't allow you to access a
function's variables from within a nested function (Pascal is the only
language I can think of that does this), nobody but the local function
should need to know where the variables are inside a given stack
frame.  Since that is the routine that put in the padding, it would
know where the the registers and variables are.  Well, on second
thought, the debugger (gdb) needs to know where the padding is in order
to display variables and parameters of the function, but that is
getting pretty deep into the system.  Stack back-tracing should use the
frame back chain, which is independent of the alignment padding.

The ABI/EABI doesn't specify where the padding should be put in the
frame, but it would logically go in the "Area for constructing
parameter lists for callees" portion of the frame.  The simplest thing
to do would be to compile some example functions and look at the
disassembled output, and then do the same thing -- my favorite method
of programming (plagiarism is a Good Thing in programming :-).

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
