Return-Path: <xenidis@gmail.com>
Received: from mail-yh0-f43.google.com (mail-yh0-f43.google.com
 [209.85.213.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 158612C023D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2012 16:56:11 +1100 (EST)
Received: by mail-yh0-f43.google.com with SMTP id 3so484744yhp.16
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Dec 2012 21:56:09 -0800 (PST)
Sender: Jimi Xenidis <xenidis@gmail.com>
References: <958841B4-9626-48A2-A28A-13EA3F1D52AE@pobox.com>
 <22874.1354859652@neuling.org>
 <F49F5B26-671F-4D3F-BAC3-67F852E03798@pobox.com>
 <1ECB6402-9BC0-4468-B405-A6F6E971486B@pobox.com>
 <3051.1355100425@neuling.org>
Mime-Version: 1.0 (1.0)
In-Reply-To: <3051.1355100425@neuling.org>
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <FAE4A73A-BDC0-43E3-A416-E8F0F161C5B4@pobox.com>
From: Jimi Xenidis <jimix@pobox.com>
Subject: Re: [RFC] Add IBM Blue Gene/Q Platform
Date: Sun, 9 Dec 2012 23:56:07 -0600
To: Michael Neuling <mikey@neuling.org>
Cc: Andrew T Tauferner <ataufer@us.ibm.com>, Kumar Gala <kumar.gala@gmail.com>,
 Jay Bryant <jsbryant@us.ibm.com>, Josh Boyer <jwboyer@linux.vnet.ibm.com>,
 Todd Inglett <tinglett@us.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Dec 9, 2012, at 6:47 PM, Michael Neuling <mikey@neuling.org> wrote:

> Jimi Xenidis <jimix@pobox.com> wrote:
>=20
>>=20
>> On Dec 7, 2012, at 7:38 AM, Jimi Xenidis <jimix@pobox.com> wrote:
>>=20
>>>=20
>>> On Dec 6, 2012, at 11:54 PM, Michael Neuling <mikey@neuling.org> wrote:
>>>=20
>>>>> commit 279c0615917b959a652e81f4ad0d886e2d426d85
>>>>> Author: Jimi Xenidis <jimix@pobox.com>
>>>>> Date:   Wed Dec 5 13:43:22 2012 -0500
>>>>>=20
>>>>>  powerpc/book3e: IBM Blue Gene/Q Quad Processing eXtention (QPX)
>>>>>=20
>>>>>  This enables kernel support for the QPX extention and is intended for=

>>>>>  processors that support it, usually an IBM Blue Gene processor.
>>>>>  Turning it on does not effect other processors but it does add code
>>>>>  and will quadruple the per thread save and restore area for the FPU
>>>>>  (hense the name).  If you have enabled VSX it will only double the
>>>>>  space.
>>>>>=20
>>>>>  Signed-off-by: Jimi Xenidis <jimix@pobox.com>
>>=20
>> <<snip>>
>>>>=20
>>>>=20
>>>>=20
>>>> +BEGIN_FTR_SECTION                            \
>>>> +    SAVE_32VSRS(n,c,base);                        \
>>>> +END_FTR_SECTION_IFSET(CPU_FTR_VSX);                    \
>>>> +BEGIN_FTR_SECTION                            \
>>>> +    SAVE_32QRS(n,c,base);                        \
>>>> +END_FTR_SECTION_IFSET(CPU_FTR_QPX);   =20
>>>>=20
>>>> I don't think we want to do this.  We are going to end up with 64
>>>> NOPS here somewhere.
>>>=20
>>> Excellent point, NOPs are cheap on most processors but not A2 and a lot o=
f embedded, I can wrap some branches with the FTR instead.
>>> Do you have a concern on the code size?
>>=20
>> Thought about it a bit and came up with this solution for arch/powerpc/ke=
rnel/fpu.S.
>> This should address the following issues
>> - MSR_VSX vs MSR_VEC
>> - Big chunks of NOPs in the code path
>> - Less FTR space fixups at boot time.
>> - IMNHSO easier to read especially when disassembled
>=20
> Indeed, I think it looks better.  I was going to mention that it was
> already pretty complex to read, so a rewrite like this was probably
> needed.  So thanks!!
>=20
> That being said, there is a pretty complex testing matrix of
> CONFIG_VSX/VMX/FPU/QPX/SMP/64/32 CPU_FTR/VSX/FPU/QPX/VMX so I'd need to
> look/test more carefully to make sure all of these are covered.
>=20
> Also, transactional memory (see
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2012-November/102216.html)
> will change this code.  You should rebase on top of that if you really
> want it considered for upstream.

Is this in a git tree anywhere? perhaps BenH's next branch?
-jx

>=20
> Mikey
>=20
>>=20
>> I did consider using the LR and BLR, but the !CONFIG_SMP case only adds o=
ne more special block and uses a different register set.
>> Also if this is agreeable I would like us to consider removing the *_32FP=
VSRS* macros entirely and put the FTR tests in the actual code.
>> This would allow us to use #ifdefs and reduce the amount of code that act=
ually gets compiled.
>>=20
>> Thoughts?
>>=20
>> diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
>> index e0ada05..5964067 100644
>> --- a/arch/powerpc/kernel/fpu.S
>> +++ b/arch/powerpc/kernel/fpu.S
>> @@ -25,30 +25,81 @@
>> #include <asm/asm-offsets.h>
>> #include <asm/ptrace.h>
>>=20
>> -#ifdef CONFIG_VSX
>> -#define __REST_32FPVSRS(n,c,base)                    \
>> -BEGIN_FTR_SECTION                            \
>> -    b    2f;                            \
>> -END_FTR_SECTION_IFSET(CPU_FTR_VSX);                    \
>> -    REST_32FPRS(n,base);                        \
>> -    b    3f;                            \
>> -2:    REST_32VSRS(n,c,base);                        \
>> -3:
>> -
>> -#define __SAVE_32FPVSRS(n,c,base)                    \
>> -BEGIN_FTR_SECTION                            \
>> -    b    2f;                            \
>> -END_FTR_SECTION_IFSET(CPU_FTR_VSX);                    \
>> -    SAVE_32FPRS(n,base);                        \
>> -    b    3f;                            \
>> -2:    SAVE_32VSRS(n,c,base);                        \
>> -3:
>> -#else
>> -#define __REST_32FPVSRS(n,b,base)    REST_32FPRS(n, base)
>> -#define __SAVE_32FPVSRS(n,b,base)    SAVE_32FPRS(n, base)
>> -#endif
>> -#define REST_32FPVSRS(n,c,base) __REST_32FPVSRS(n,__REG_##c,__REG_##base=
)
>> -#define SAVE_32FPVSRS(n,c,base) __SAVE_32FPVSRS(n,__REG_##c,__REG_##base=
)
>> +
>> +/*
>> + * Restore subroutines, R4 is scratch and R5 is base
>> + */
>> +vsx_restore:
>> +    REST_32VSRS(0, __REG_R4, __REG_R5)
>> +    b after_restore
>> +qpx_restore:
>> +    REST_32QRS(0, __REG_R4, __REG_R5)
>> +    b after_restore
>> +fpu_restore:
>> +    REST_32FPRS(0, __REG_R5)
>> +    b after_restore
>> +
>> +#define REST_32FPVSRS(n, c, base)        \
>> +BEGIN_FTR_SECTION                \
>> +    b vsx_restore;                \
>> +END_FTR_SECTION_IFSET(CPU_FTR_VSX)        \
>> +BEGIN_FTR_SECTION                \
>> +    b qpx_restore;                \
>> +END_FTR_SECTION_IFSET(CPU_FTR_QPX)        \
>> +    b fpu_restore;                \
>> +after_restore:
>> +
>> +/*
>> + * Save subroutines, R4 is scratch and R3 is base
>> + */
>> +vsx_save:
>> +    SAVE_32VSRS(0, __REG_R4, __REG_R3)
>> +    b after_save
>> +qpx_save:
>> +    SAVE_32QRS(0, __REG_R4, __REG_R3)
>> +    b after_save
>> +fpu_save:
>> +    SAVE_32FPRS(0, __REG_R3)
>> +    b after_save
>> +
>> +#define SAVE_32FPVSRS(n, c, base)        \
>> +BEGIN_FTR_SECTION                \
>> +    b vsx_save;                \
>> +END_FTR_SECTION_IFSET(CPU_FTR_VSX)        \
>> +BEGIN_FTR_SECTION                \
>> +    b qpx_save;                \
>> +END_FTR_SECTION_IFSET(CPU_FTR_QPX)        \
>> +    b fpu_save;                \
>> +after_save:
>> +
>> +#ifndef CONFIG_SMP
>> +/*
>> + * we need an extra save set for the !CONFIG_SMP case, see below
>> + * Scratch it R5 and base is R4
>> + */
>> +vsx_save_nosmp:
>> +    SAVE_32VSRS(0,R5,R4)
>> +    b after_save_nosmp
>> +
>> +qpx_save_nosmp:
>> +    SAVE_32QRS(0,R5,R4)
>> +    b after_save_nosmp
>> +
>> +fpu_save_nosmp:
>> +    SAVE_32FPRS(0,R4)
>> +    b after_save_nosmp
>> +
>> +#define SAVE_32FPVSRS_NOSMP(n,c,base)        \
>> +BEGIN_FTR_SECTION                \
>> +    b vsx_save_nosmp;            \
>> +END_FTR_SECTION_IFSET(CPU_FTR_VSX)        \
>> +BEGIN_FTR_SECTION                \
>> +    b qpx_save_nosmp;            \
>> +END_FTR_SECTION_IFSET(CPU_FTR_QPX)        \
>> +    b fpu_save_nosmp;            \
>> +after_save_nosmp:
>> +
>> +#endif /* !CONFIG_SMP */
>>=20
>> /*
>>  * This task wants to use the FPU now.
>> @@ -65,6 +116,11 @@ BEGIN_FTR_SECTION
>>    oris    r5,r5,MSR_VSX@h
>> END_FTR_SECTION_IFSET(CPU_FTR_VSX)
>> #endif
>> +#ifdef CONFIG_PPC_QPX
>> +BEGIN_FTR_SECTION
>> +    oris    r5,r5,MSR_VEC@h
>> +END_FTR_SECTION_IFSET(CPU_FTR_QPX)
>> +#endif
>>    SYNC
>>    MTMSRD(r5)            /* enable use of fpu now */
>>    isync
>> @@ -81,7 +137,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
>>    beq    1f
>>    toreal(r4)
>>    addi    r4,r4,THREAD        /* want last_task_used_math->thread */
>> -    SAVE_32FPVSRS(0, R5, R4)
>> +    SAVE_32FPVSRS_NOSMP(0, R5, R4)
>>    mffs    fr0
>>    stfd    fr0,THREAD_FPSCR(r4)
>>    PPC_LL    r5,PT_REGS(r4)
>> @@ -94,7 +150,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
>> #endif /* CONFIG_SMP */
>>    /* enable use of FP after return */
>> #ifdef CONFIG_PPC32
>> -    mfspr    r5,SPRN_SPRG_THREAD        /* current task's THREAD (phys) *=
/
>> +    mfspr    r5,SPRN_SPRG_THREAD    /* current task's THREAD (phys) */
>>    lwz    r4,THREAD_FPEXC_MODE(r5)
>>    ori    r9,r9,MSR_FP        /* enable FP for current */
>>    or    r9,r9,r4
>> @@ -132,6 +188,11 @@ BEGIN_FTR_SECTION
>>    oris    r5,r5,MSR_VSX@h
>> END_FTR_SECTION_IFSET(CPU_FTR_VSX)
>> #endif
>> +#ifdef CONFIG_PPC_QPX
>> +BEGIN_FTR_SECTION
>> +    oris    r5,r5,MSR_VEC@h
>> +END_FTR_SECTION_IFSET(CPU_FTR_QPX)
>> +#endif
>>    SYNC_601
>>    ISYNC_601
>>    MTMSRD(r5)            /* enable use of fpu now */
>> @@ -148,10 +209,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
>>    beq    1f
>>    PPC_LL    r4,_MSR-STACK_FRAME_OVERHEAD(r5)
>>    li    r3,MSR_FP|MSR_FE0|MSR_FE1
>> -#ifdef CONFIG_VSX
>> +#if defined(CONFIG_VSX) || defined(CONFIG_PPC_QPX)
>> BEGIN_FTR_SECTION
>>    oris    r3,r3,MSR_VSX@h
>> -END_FTR_SECTION_IFSET(CPU_FTR_VSX)
>> +END_FTR_SECTION_IFSET(CPU_FTR_VSX | CPU_FTR_QPX)
>> #endif
>>    andc    r4,r4,r3        /* disable FP for previous task */
>>    PPC_STL    r4,_MSR-STACK_FRAME_OVERHEAD(r5)
>>=20
>> -jx
>>=20
>>=20
>>>=20
>>>>=20
>>>> I'd like to see this patch broken into different parts.
>>>=20
>>> I'm not sure how _this_ patch:
>>> <https://github.com/jimix/linux-bgq/commit/279c0615917b959a652e81f4ad0d8=
86e2d426d85>
>>> could be broken up, please advise.
>>>=20
>>>>=20
>>>> Also, have you boot tested this change on a VSX enabled box?
>>>=20
>>> I can try, I may bug you for help.
>>> Is there a commonly test (or apps) I should run?
>>>=20
>>> -jx
>>>=20
>>>=20
>>>>=20
>>>> Mikey
>>=20
