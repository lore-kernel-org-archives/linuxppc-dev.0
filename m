Reply-To: <jwalden@digitalatlantic.com>
From: "Jerry Walden" <jwalden@digitalatlantic.com>
To: "Gary D. Thomas" <gary.thomas@mind.be>
Cc: "Linux PPC embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Stack Frame Calc Problem in head_4xx.S
Date: Sat, 3 May 2003 19:08:22 -0400
Message-ID: <EGEGIJHKDKJGAJMGIDPNCEPBCLAA.jwalden@digitalatlantic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1052000497.2537.5413.camel@hermes>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Duh! - I was debugging late last night, and I must have misread the value
in r1.

Thanks for pointing out the obvious, and correcting me.

The problem I am having is that I set a breakpoint with my
BDI-2000 at start kernel, and the first instruction is:

stwu r1, -32(r1)

If I step through that instruction, I get a debug exception.
If I just "go" the console hangs, and when I halt the processor
with the BDI, it is still at a debug exception (PC=0x2204).

I can't figure out what is going on.  I've been trolling through
the lists for other folks that may have had a similar problem,
and have found several with a similar problem - I found a response
from Wolfgang Denk:

"Well, did you (a) follow the description in the BDI2000 manual and
initialize the page table pointer manually, or (b) did you use a
kernel which has the necessary extension to do it automagically?
Wolfgang Denk"

and my answer is that I am running with the Monta Vista Linux
2.4.18_MVL30, with V1.11 of the BDI-2000 firmware, and I am
booting with the latest version of u-boot.  The kernel
in head_4xx.S has "the automagic extension" that sets the
Abatron PTE pointers.

So I am tearing my hair out...


Jerry Walden
-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Gary D.
Thomas
Sent: Saturday, May 03, 2003 6:22 PM
To: jwalden@digitalatlantic.com
Cc: Linux PPC embedded
Subject: Re: Stack Frame Calc Problem in head_4xx.S



On Sat, 2003-05-03 at 15:20, Jerry Walden wrote:
> Greetings:
>
> I am having trouble understanding what is happening to my stack pointer.
>
> At line 1 r1 = 0x03f9_ebe8
>
> After line 15 executes r1 = 0xc00f4ff0
> which seems fine so far (according to the map file it is pointing to the
> proper location)
>
> After line 16 executes r1=0xc00f6ff0
> which is still within the bounds of init_task_union
>
> After line 17 execute r1 = 0xc00f6fe0 which seems like a problem to me,
> because it is not with the
> bounds of init_task_union - (see map file below)
>

Why do you think this?  It seems that init_task_union comprises the
space from 0xc00f4ff0..0xc00f6ff0.  That value is certainly within
that range.

> I would expect r1 to be within the bounds of init_task_union after this
code
> is executed -
> is my guess correct?  If so how is it possible that line 17 comes up with
> the result
> that it did?

Read how 'stwu' works.  After the store takes place, r1 is updated
with the new value.  In other words
  stwu r0,-STACK_FRAME_OVERHEAD(r1)
means
  [r1] = r0
  r1 = r1 - STACK_FRAME_OVERHEAD(r1)
which is exactly the results you are getting.

>
> TASK_UNION_SIZE = 8192
> STACK_FRAME_OVERHEAD = 16
>
> Thanks for any help
>
> Jerry
>
> 1 start_here:
> 2
> 3	/* ptr to current */
> 4	lis	r2,init_task_union@h
> 5	ori	r2,r2,init_task_union@l
> 6
> 7	/* ptr to phys current thread */
> 8	tophys(r4,r2)
> 9	addi	r4,r4,THREAD	/* init task's THREAD */
> 10	mtspr	SPRG3,r4
> 11	li	r3,0
> 12	mtspr	SPRG2,r3	/* 0 => r1 has kernel sp */
> 13
> 14	/* stack */
> 15	addi	r1,r2,TASK_UNION_SIZE
> 16	li	r0,0
> 17	stwu	r0,-STACK_FRAME_OVERHEAD(r1)
>
>
> c00f4ff0 D init_task_union
> c00f6ff0 d aligninfo
> c00f70f0 D cpuinfo_op
> c00f7100 D cpu_specs
> c00f7280 D ppc_htab_operations
>
>
>
> Jerry Walden
> Program Manager
> Digital Atlantic Inc
> http://www.digitalatlantic.com
> jwalden@digitalatlantic.com
> 1-877-494-6073 x407
> cell - 703-431-2413
>
>
--
Gary D. Thomas <gary.thomas@mind.be>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
