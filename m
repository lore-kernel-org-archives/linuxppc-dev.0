From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B23640@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Ebony/440GP boot problems
Date: Sat, 1 Feb 2003 11:10:28 -0800 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


As shown below, after reset, if I enter the 'ti' command, we start single
stepping from 0xfffff000. Each time I 'ti', the PC gets incremented by a 32
bit word. It would then appear that code is not running and I start frozen
at 0xfffff000. Can anyone make sense of this?

==========================================
BDI>reset
- TARGET: processing user reset request
- TARGET: reseting target passed
- TARGET: processing target startup ....
- TARGET: processing target startup passed
BDI>
BDI>
BDI>
BDI>
BDI>
BDI>ti
    Target state      : debug mode
    Debug entry cause : single step
    Current PC        : 0xfffff000
    Current CR        : 0xab355bb5
    Current MSR       : 0x00000000
    Current LR        : 0x840208d5
BDI>ti
    Target state      : debug mode
    Debug entry cause : single step
    Current PC        : 0xfffff004
    Current CR        : 0xab355bb5
    Current MSR       : 0x00000000
    Current LR        : 0x840208d5
BDI>ti
    Target state      : debug mode
    Debug entry cause : single step
    Current PC        : 0xfffff008
    Current CR        : 0xab355bb5
    Current MSR       : 0x00000000
    Current LR        : 0x840208d5
BDI>ti
    Target state      : debug mode
    Debug entry cause : single step
    Current PC        : 0xfffff00c
    Current CR        : 0xab355bb5
    Current MSR       : 0x00000000
    Current LR        : 0x840208d5
BDI>ti
    Target state      : debug mode
    Debug entry cause : single step
    Current PC        : 0xfffff010
    Current CR        : 0xab355bb5
    Current MSR       : 0x00000000
    Current LR        : 0x840208d5
BDI>
===========================================


-- Brian


-----Original Message-----
From: Chris Zimman [mailto:chris@cryptoapps.com]
Sent: Saturday, February 01, 2003 1:37 PM
To: brian.auld@adic.com
Subject: Re: Ebony/440GP boot problems

On Sat, Feb 01, 2003 at 09:38:38AM -0800, brian.auld@adic.com wrote:
> To recap:
>
> I am trying to get embedded linux running on the Ebony 440GP eval board
with
> u-boot as the boot loader.
>
> I believe I've successfully programmed u-boot into the upper 0.5MB of the
> 32bit memory map. I don't want to print out the entire memory dump, but
I'll
> attach the beginning and end of the top 0.5MB chunk of memory (i.e.
u-boot).
>
> When I reset the board, the serial console is dead. I've tried every
> imaginable baud rate and the serial console is still dead. Even if I had
the
> wrong baud, I'd at least expect to see jibberish on the serial console,
> which I don't.
>
> Any suggestions? The third clip below, showing the top 256 bytes of the
boot
> area, has data content of 0x4bfff004. In what I have gotten so far out of
> 440GP manuals, this address is the reset vector. Well, if that's the case,
> 0x4bfff0004 does not sound like a good number, does it. Or, am I looking
in
> the wrong place. I thought the contents of addr 0xfffffffc would point to
> the start of u-boot at addr 0xfff80000, which it doesn't appear to.

Go into the debugger and do a "ti" immediately after reset.

BDI> ti

That way you'll see where the next instruction is being executed from.

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
