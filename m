Message-Id: <4.2.2.20000120193004.00cdd900@mail.munich.netsurf.de>
Date: Thu, 20 Jan 2000 19:46:17 +0100
To: khendricks@ivey.uwo.ca
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <00012013133502.00819@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 19:12 20.01.00 , Kevin Hendricks wrote:
>Hi,
>
>Can anyone explain this to me?
>
> > Finally I got it!
>
> >   asm("stwbrx %0,%1,%2": : "r"(regdata), "r"(regindex), "r"(base_addr));
>
> >   asm("lwbrx %0,%1,%2": "=r"(val):"r"(regindex), "r"(base_addr));
>
> >   asm("stwbrx %0,%1,%2": : "r"(regdata), "b"(regindex), "r"(base_addr));
>
> >   asm("lwbrx %0,%1,%2": "=r"(val):"b"(regindex), "r"(base_addr));
>
>
> > Don't know if this is correct (no clue about ppc assembly), but it works...
>
>Well I did the following with the attached sample program:
>
>gcc -O0 -S testit.c
>
>then I looked at testit.s  (the assembler).
>
>old_regw:
>         stwu 1,-32(1)
>         stw 31,28(1)
>         mr 31,1
>         stw 3,8(31)
>         mr 0,4
>         lis 11,mach64MemReg@ha
>         lwz 9,mach64MemReg@l(11)
>         lwz 11,8(31)
>         stwbrx 0,11,9
>.L2:
>         lwz 11,0(1)
>         lwz 31,-4(11)
>         mr 1,11
>         blr
>.Lfe2:
>         .size    old_regw,.Lfe2-old_regw
>         .align 2
>         .type    old_regr,@function
>old_regr:
>         stwu 1,-32(1)
>         stw 31,28(1)
>         mr 31,1
>         stw 3,8(31)
>         lis 9,mach64MemReg@ha
>         lwz 0,mach64MemReg@l(9)
>         lwz 11,8(31)
>         lwbrx 9,11,0
>         mr 3,9
>         b .L3
>.L3:
>         lwz 11,0(1)
>         lwz 31,-4(11)
>         mr 1,11
>         blr
>.Lfe3:
>         .size    old_regr,.Lfe3-old_regr
>         .align 2
>:regw:
>         stwu 1,-32(1)
>         stw 31,28(1)
>         mr 31,1
>         stw 3,8(31)
>         mr 0,4
>         lis 11,mach64MemReg@ha
>         lwz 9,mach64MemReg@l(11)
>         lwz 11,8(31)
>         stwbrx 0,11,9
>.L4:
>         lwz 11,0(1)
>         lwz 31,-4(11)
>         mr 1,11
>         blr
>.Lfe4:
>         .size    regw,.Lfe4-regw
>         .align 2
>         .type    regr,@function
>regr:
>         stwu 1,-32(1)
>         stw 31,28(1)
>         mr 31,1
>         stw 3,8(31)
>         lis 9,mach64MemReg@ha
>         lwz 0,mach64MemReg@l(9)
>         lwz 11,8(31)
>         lwbrx 9,11,0
>         mr 3,9
>         b .L5
>.L5:
>         lwz 11,0(1)
>         lwz 31,-4(11)
>         mr 1,11
>         blr
>
>And I simply can not see any difference in the actual code produced by each
>bunch of asm statements which leads me to believe that there is something else
>going on here.
>
>I would love to know exactly what.
>
>Will you please try compiling the code I attached to get the assembler out and
>compare old_regr and regr and old_rew and regw and see if you find any
>differences.

Kevin,
the fix is correct, you cannot use "r" (allow r0-r31) as a base register
constraint, you have to use "b" (allow r1-r31). This is not easy to
reproduce with a small testprogram, because it will only fail if r0 is
assigned for the inline assembly by the compiler, which depends on a lot of
factors. In practice the outdated egcs-1.1.2 seems to have a lower
probability to trigger this bug than the current gcc-2.95.2, probably due
to the better optimizers in gcc-2.95.2 producing higher register pressure.

Additionally with inline assembly you should always be as explicit as
possible, so for stuff possible relying on ordering, you should add
'volatile', and a "memory" clobber for writes:

asm volatile ("stwbrx %0,%1,%2" : :"r"(regdata), "b"(regindex),
"r"(base_addr) : "memory");
asm volatile ("lwbrx %0,%1,%2" : "=r"(val) : "b"(regindex), "r"(base_addr));

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
