Message-Id: <4.3.2.20000621110151.00b74730@falcon.si.com>
Date: Wed, 21 Jun 2000 11:22:04 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: MMU problems on YellowKnife board (PPC750) with
  SmartFirmware
In-Reply-To: <3950D6BE.8E51A444@essegi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This sounds exactly like an issue we went through with the 8260 on an
EST eval board (Jon, correct me out if you remember better than me).

Our problem, and probably yours too, is that the JTAG debugger doesn't
understand the MMU operation.  As soon as you turn on the MMU, the PPC
goes fetching from logical location 0xC0xxxxxx but it is really
_physical_ location 0x00xxxxxx.  The JTAG debugger doesn't understand
the translation, so it goes ahead and looks at _physical_ location
0xC0xxxxxxx for the next instruction which causes untold grief.  This
problem also occurs even if you don't step through the RFI but set
breakpoints to stop the processor: if you set a breakpoint in
0xC0xxxxxx land, you are writing to invalid memory.  If you set a
breakpoint in 0x00xxxxxx land, the breakpoint will work but the JTAG
debugger will get horribly confused because the PC says 0xC0xxxxxx but
there isn't any memory there.  The JTAG debugger just doesn't understand.

What we did to understand the problem may or may not be useful to
you.  The technique should work on the 750 but it relies on having
extra mappable memory.  We are using an EST 8260 eval board: it has
some local bus memory as well as 60x bus memory.  The local bus memory
wasn't being (profitably) used, so I set a breakpoint just before the
RFI and then modified the 8260 configuration (by hand via the JTAG
debugger) to remap the local bus memory to 0xC0000000 and copied the
memory starting at 0x00000000 to the 0xC0000000 space.  Now I had
physical memory in the logical space.  The processor didn't use the
0xC0xxxxxxx physical memory, but I was able to single step the
processor (and I believe set breakpoints - you have to be careful to
set the breakpoints in 0x00xxxxxx space not 0xC0xxxxxx space) because
the JTAG debugger could disassemble based on the logical addresses
which actually hit the remapped local bus physical memory.  It was
working out of the wrong memory, but it didn't know different and, as
long both memory areas matched, it didn't matter.

The bottom line is, as soon as you turn on the MMU, the JTAG debugger
is not going to be very useful.  We determined to our satisfaction that
enabling the MMU was not our problem and then reverted to blinking LEDs
to indicate how far we got before crashing.  It just was too painful to
try to fix up the environment to use the JTAG debugger except when we
ran really stuck.  Theoretically, you or the JTAG debugger vendor could
enhance the JTAG debugger to understand the MMU, but that would be a
fair amount of work and would _really_ slow down the debugger
operation.  It would be awfully nice to have that as an option, however.

gvb



At 04:52 PM 6/21/00 +0200, Stefano Totaro wrote:

>Hi guys,
>I am trying to port linux (kernel 2.4.0 and I tried also the 2.2.14 for
>ppc7xx from MontaVista) on a Motorola YellowKnife development board
>(CHRP like) based on the PPC750 running CodeGen
>SmartFirmware (it should be openfirmware compliant but the one I am
>using is
>an evaluation and so I am not sure of its behavior).
>
>I am experiencing problems in setting up the MMU.
>I had to move the kernel from the original running address (0x100000)
>because it overwrote the firmware. So I moved it to 0x30100000 and then
>after then it relocates in 0.
>
>The problem raises when head.S tries to turn on the MMU exactly after
>the rfi
>
>turn_on_mmu:
>         mfmsr   r0
>         ori     r0,r0,MSR_DR|MSR_IR
>         mtspr   SRR1,r0
>         lis     r0,start_here@h
>         ori     r0,r0,start_here@l
>         mtspr   SRR0,r0
>         SYNC
>         rfi
>
>I am not able to understand exactly what is going on because I am using
>a JTAG debugger but I cannot put breakpoints near the rfi.
>It looks like the CPU jumps at the right address but there is INVALID
>code only and then it jumps to 0x700 (I have set up the exception prefix
>to 0x0000_0).
>The DBAT0L, DBAT0U, IBAT0L and IBAT0U seems to be correctly setup to map
>the first 256Meg to c0000000 with read and write privilegies and the
>code is at the right physical address but something does not work.
>
>I have tried also to turn on the MMU without jumping to 0xC000... as
>described in the Motorola Application Note "A Minimal PowerPC Boot
>Sequence for Executing Compiled C Programs"
>
>address_translation_on:
>         mfmsr r5
>         ori r5,r5,0x0030
>         mtmsr r5
>         isync
>         blr
>
>I did it to avoid to use the rfi, but when I put back r5 to MSR the cpu
>jumps to 0x700. Moreover, the MSR IR and DR bit do not look to be setup.
>
>I have no more ideas I am reading all the application but I do not find
>an explaination of this behavior.
>
>Can someone of you help me in solving this problem?
>
>Thanks in advance
>
>Best wishes,
>Stefano
>
>
>p.s.
>
>I have noticed many MMU setup problems reported in this  mail list but I
>didn't find one that exactly matches mine.  However, just in case, I
>apologise if some of you as yet answered to this question.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
