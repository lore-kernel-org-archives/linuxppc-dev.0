Date: Sat, 1 Feb 2003 11:31:05 -0800
From: Chris Zimman <chris@cryptoapps.com>
To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ebony/440GP boot problems
Message-ID: <20030201193105.GA2379@mail.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <995FF289C9D69747A09E42992644595405B23640@penguin.adic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <995FF289C9D69747A09E42992644595405B23640@penguin.adic.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Feb 01, 2003 at 11:10:28AM -0800, brian.auld@adic.com wrote:

> As shown below, after reset, if I enter the 'ti' command, we start single
> stepping from 0xfffff000. Each time I 'ti', the PC gets incremented by a 32
> bit word. It would then appear that code is not running and I start frozen
> at 0xfffff000. Can anyone make sense of this?
>
> ==========================================
> BDI>reset
> - TARGET: processing user reset request
> - TARGET: reseting target passed
> - TARGET: processing target startup ....
> - TARGET: processing target startup passed
> BDI>
> BDI>
> BDI>
> BDI>
> BDI>
> BDI>ti
>     Target state      : debug mode
>     Debug entry cause : single step
>     Current PC        : 0xfffff000
>     Current CR        : 0xab355bb5
>     Current MSR       : 0x00000000
>     Current LR        : 0x840208d5
> BDI>ti
>     Target state      : debug mode
>     Debug entry cause : single step
>     Current PC        : 0xfffff004
>     Current CR        : 0xab355bb5
>     Current MSR       : 0x00000000
>     Current LR        : 0x840208d5
> BDI>ti
>     Target state      : debug mode
>     Debug entry cause : single step
>     Current PC        : 0xfffff008
>     Current CR        : 0xab355bb5
>     Current MSR       : 0x00000000
>     Current LR        : 0x840208d5
> BDI>ti
>     Target state      : debug mode
>     Debug entry cause : single step
>     Current PC        : 0xfffff00c
>     Current CR        : 0xab355bb5
>     Current MSR       : 0x00000000
>     Current LR        : 0x840208d5
> BDI>ti
>     Target state      : debug mode
>     Debug entry cause : single step
>     Current PC        : 0xfffff010
>     Current CR        : 0xab355bb5
>     Current MSR       : 0x00000000
>     Current LR        : 0x840208d5
> BDI>
> ===========================================

0xfffff000 is the start of ppc/u-boot.  Break out a copy of GDB and start
tracing into it to find out where it's blowing up.

Build ppc/u-boot with "-fno-schedule-insns -fno-schedule-insns2" added
to the compile line.

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
