Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 09163DDFC9
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 05:54:13 +1100 (EST)
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E816A47@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E816A47@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=GB2312; delsp=yes; format=flowed
Message-Id: <F723B551-5777-4697-A269-D3E1BA5B5421@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch][5/5] powerpc: Add the general support for Embedded
	Floating-Point instructions
Date: Fri, 12 Jan 2007 12:53:28 -0600
To: Zhu Ebony-r57400 <ebony.zhu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 12, 2007, at 1:45 AM, Zhu Ebony-r57400 wrote:

> Hi Kumar
>
> Please see my inline comments.
>
> Ebony
>
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: 2007=C4=EA1=D4=C212=C8=D5 14:41
>> To: Zhu Ebony-r57400
>> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
>> Subject: Re: [patch][5/5] powerpc: Add the general support
>> for Embedded Floating-Point instructions
>>
>>
>> On Jan 11, 2007, at 11:31 PM, ebony.zhu@freescale.com wrote:
>>
>>> Add the general support for Embedded Floating-Point instructions to
>>> fully comply with IEEE-754.
>>>
>>> Signed-off-by:Ebony Zhu <ebony.zhu@freescale.com>
>>> ---
>>>  arch/powerpc/Makefile                |    5 +
>>>  arch/powerpc/kernel/entry_32.S       |   50 ++++++
>>>  arch/powerpc/kernel/head_booke.h     |    4
>>>  arch/powerpc/kernel/head_fsl_booke.S |   22 ++-
>>>  arch/powerpc/kernel/traps.c          |   17 ++
>>>  arch/powerpc/math-emu/Makefile       |   29 ++-
>>>  arch/powerpc/math-emu/sfp-machine.h  |    4
>>>  arch/powerpc/sysdev/sigfpe_handler.c |  298 +++++++++++++++++++++++
>>> +++++++++++
>>>  arch/powerpc/sysdev/Makefile         |    1
>>>  9 files changed, 421 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile index
>>> a00fe72..dd0b4b8 100644
>>> --- a/arch/powerpc/Makefile
>>> +++ b/arch/powerpc/Makefile
>>> @@ -134,6 +134,11 @@ core-y				+=3D
>> arch/powerpc/kernel/ \
>>>  				   arch/powerpc/lib/ \
>>>  				   arch/powerpc/sysdev/ \
>>>  				   arch/powerpc/platforms/
>>> +ifeq ($(CONFIG_SPE),y)
>>> +ifneq ($(CONFIG_MATH_EMULATION),y)
>>> +core-y				+=3D arch/powerpc/math-emu/
>>> +endif
>>> +endif
>>>  core-$(CONFIG_MATH_EMULATION)	+=3D arch/powerpc/math-emu/
>>>  core-$(CONFIG_XMON)		+=3D arch/powerpc/xmon/
>>>
>>> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/
>>> entry_32.S index c03e829..a3d4ece 100644
>>> --- a/arch/powerpc/kernel/entry_32.S
>>> +++ b/arch/powerpc/kernel/entry_32.S
>>> @@ -616,6 +616,56 @@ END_FTR_SECTION_IFSET(CPU_FTR_601)
>>>  	.long	ret_from_except
>>>  #endif
>>>
>>> +#ifdef CONFIG_SPE
>>> +	.globl  ret_from_except_spe_full
>>> +ret_from_except_spe_full:
>>> +	REST_NVGPRS(r1)
>>> +	/* fall through */
>>> +	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
>>> +	SYNC			/* Some chip revs have problems
>> here... */
>>> +	MTMSRD(r10)		/* disable interrupts */
>>> +
>>> +	lwz     r0,THREAD+THREAD_SPEFSCR(r2)
>>> +	mtspr   SPRN_SPEFSCR,r0		/* restore SPEFSCR reg */
>>> +
>>> +	lwz     r0,GPR0(r1)
>>> +	lwz     r2,GPR2(r1)
>>> +	REST_4GPRS(3, r1)
>>> +	REST_2GPRS(7, r1)
>>> +=09
>>> +	lwz     r10,_XER(r1)
>>> +	lwz     r11,_CTR(r1)
>>> +	mtspr   SPRN_XER,r10
>>> +	mtctr   r11
>>> +
>>> +	stwcx.  r0,0,r1                 /* to clear the reservation */
>>> +
>>> +	lwz     r11,_LINK(r1)
>>> +	mtlr    r11
>>> +	lwz     r10,_CCR(r1)
>>> +	mtcrf   0xff,r10
>>> +	REST_2GPRS(9, r1)
>>> +
>>> +	mtspr   SPRN_SPRG0,r11
>>> +	mtspr   SPRN_SPRG1,r12
>>> +	mfmsr   r11
>>> +	oris  r11, r11, MSR_SPE@h
>>> +	mtmsr   r11
>>> +	mfspr   r12,SPRN_SPRG3
>>> +	REST_32EVRS(0, r11,r12)
>>> +	mfspr   r11,SPRN_SPRG0
>>> +	mfspr   r12,SPRN_SPRG1
>>> +
>>> +	lwz     r11,_NIP(r1)
>>> +	lwz     r12,_MSR(r1)
>>> +	mtspr   SPRN_SRR0,r11
>>> +	mtspr   SPRN_SRR1,r12
>>> +	REST_2GPRS(11, r1)
>>> +	lwz     r1,GPR1(r1)
>>> +
>>> +	rfi
>>> +	b	.		/* prevent prefetch past rfi */
>>
>> Why do we need a separate ret_from_except_spe_full?
>
> I'm not sure if the kernel will return from exception in a multi-=20
> thread
> way, but the truth is if restoring EVRs in exsiting =20
> ret_from_except_full,
> some non-SPE exception will try to retore EVR. At that time, the
> MSR[SPE] may not be enabled, which will cause error.

Well, with EE disabled nothing is going to interrupt the exception =20
thread, so you can do all this in C code.

>>> +#endif
>>>  	.globl	ret_from_except_full
>>>  ret_from_except_full:
>>>  	REST_NVGPRS(r1)
>>> diff --git a/arch/powerpc/kernel/head_booke.h
>> b/arch/powerpc/kernel/
>>> head_booke.h index 8536e76..1e14d3e 100644
>>> --- a/arch/powerpc/kernel/head_booke.h
>>> +++ b/arch/powerpc/kernel/head_booke.h
>>> @@ -195,6 +195,10 @@ #define EXC_XFER_EE(n, hdlr)		\
>>>  	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, COPY_EE,
>>> transfer_to_handler_full, \
>>>  			  ret_from_except_full)
>>>
>>> +#define EXC_XFER_EE_SPE(n, hdlr)	\
>>> +	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, COPY_EE,
>>> transfer_to_handler_full, \
>>> +			  ret_from_except_spe_full)
>>> +
>>>  #define EXC_XFER_EE_LITE(n, hdlr)	\
>>>  	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, COPY_EE,
>>> transfer_to_handler, \
>>>  			  ret_from_except)
>>> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/
>>> kernel/head_fsl_booke.S index 66877bd..56200b6 100644
>>> --- a/arch/powerpc/kernel/head_fsl_booke.S
>>> +++ b/arch/powerpc/kernel/head_fsl_booke.S
>>> @@ -699,7 +699,25 @@ #endif /* CONFIG_SPE */
>>>
>>>  	/* SPE Floating Point Data */
>>>  #ifdef CONFIG_SPE
>>> -	EXCEPTION(0x2030, SPEFloatingPointData,
>>> SPEFloatingPointException, EXC_XFER_EE);
>>> +	START_EXCEPTION(SPEFloatingPointData)
>>> +	mtspr   SPRN_SPRG0,r3
>>> +	mtspr   SPRN_SPRG1,r4
>>> +	mfmsr   r3
>>> +	oris    r3, r3, MSR_SPE@h
>>> +	mtmsr   r3
>>> +	mfspr   r3, SPRN_SRR0
>>> +	lwz     r3, 0(r3)
>>> +	lis     r4, speinsn@ha
>>> +	stw     r3, speinsn@l(r4)
>>> +	mfspr   r4, SPRN_SPRG3
>>> +	mfspr   r3, SPRN_SPEFSCR
>>> +	stw     r3, THREAD_SPEFSCR(r4)
>>> +	SAVE_32EVRS(0, r3, r4)
>>> +	mfspr   r3, SPRN_SPRG0
>>> +	mfspr   r4, SPRN_SPRG1
>>> +	NORMAL_EXCEPTION_PROLOG
>>> +	addi    r3,r1,STACK_FRAME_OVERHEAD
>>> +	EXC_XFER_EE_SPE(0x2030, SPEFloatingPointException)
>>
>> Why do we have to do any of this in the exception path?
>>
>> SPEFloatingPointException can have something like:
>>
>> 	unsigned long pc =3D regs->nip;
>> 	flush_spe_to_thread(current);
>>
>> 	if (get_user(insn, (u32 *)pc))
>> 		return -EFAULT;
>>
>> 	...
>>
>
> Since I want to save EVRs before entering the =20
> SPEFloatingPointException. Thanks
> for providing an alternative way, I can try to see if it works.
>
>>>  #else
>>>  	EXCEPTION(0x2040, SPEFloatingPointData, unknown_exception,
>>> EXC_XFER_EE)
>>>  #endif /* CONFIG_SPE */
>>> @@ -840,6 +858,8 @@ load_up_spe:
>>>  	oris	r5,r5,MSR_SPE@h
>>>  	mtmsr	r5			/* enable use of SPE now */
>>>  	isync
>>> +	li      r5,(SPEFSCR_FINVE | SPEFSCR_FDBZE | SPEFSCR_FUNFE |
>>> SPEFSCR_FOVFE)
>>> +	mtspr   SPRN_SPEFSCR,r5
>>
>> If you want to initialize spefscr so the enables are set do
>> it in INIT_THREAD.  I need to think more about if we should
>> even be doing that in the kernel.
>
> Ok, let's keep discussing this.
>
>>
>>>  /*
>>>   * For SMP, we don't do lazy SPE switching because it just gets too
>>>   * horrendously complex, especially when a task switches
>> from one CPU
>>> diff --git a/arch/powerpc/kernel/traps.c
>> b/arch/powerpc/kernel/traps.c
>>> index 535f506..68407d4 100644
>>> --- a/arch/powerpc/kernel/traps.c
>>> +++ b/arch/powerpc/kernel/traps.c
>>> @@ -986,6 +986,22 @@ #endif /* CONFIG_FSL_BOOKE */  #ifdef
>> CONFIG_SPE
>>> void SPEFloatingPointException(struct pt_regs *regs)  {
>>> +#ifdef CONFIG_E500
>>> +	extern int sigfpe_handler(struct pt_regs *regs);
>>> +	int err;
>>> +	if (current->thread.spefscr & ~0x3f) {
>>> +		err =3D sigfpe_handler(regs);
>>> +		if (err =3D=3D 0) {
>>> +			regs->nip +=3D 4;
>>> +			return;
>>> +		} else {
>>> +			current->thread.spefscr =3D 0x0;
>>
>> Why do clear spefscr and re-execute?
>
> I tried to make the code more robust here. Currently, all the SPE =20
> instructions
> that may cause execption are handled. But someday if the =20
> instruction set is extended and
> not supported by software, this code can make sure we handle it =20
> with powerpc
> default value, which won't make kernel crash.

Lets worry about that when it occurs, its probably better that the =20
apps crash and we fixup the kernel when it happens.

>>> +			return;
>>> +		}
>>> +	} else {
>>> +		return;
>>
>> How else would we get here if not by having spefscr bit set?
>
> As above, I want to make it more robust. If no unexpected condition =20=

> would happen, we can
> remove this off.

Lets remove it since it shouldn't happen

>>> +	}
>>> +#else
>>>  	unsigned long spefscr;
>>>  	int fpexc_mode;
>>>  	int code =3D 0;
>>> @@ -1016,6 +1032,7 @@ void SPEFloatingPointException(struct pt
>>>
>>>  	_exception(SIGFPE, regs, code, regs->nip);
>>>  	return;
>>
>> Your code should supersede the handling code that's currently there.
>
> OK, I agree.
>
>>
>>> +#endif
>>>  }
>>>  #endif
>>>
>>> diff --git a/arch/powerpc/math-emu/Makefile
>> b/arch/powerpc/math-emu/
>>> Makefile index 29bc912..dbb3e26 100644
>>> --- a/arch/powerpc/math-emu/Makefile
>>> +++ b/arch/powerpc/math-emu/Makefile
>>> @@ -1,16 +1,29 @@
>>>
>>> -obj-y				:=3D math.o fmr.o lfd.o stfd.o
>>> -
>>> -obj-$(CONFIG_MATH_EMULATION)	+=3D fabs.o fadd.o
>> fadds.o fcmpo.o
>>> fcmpu.o \
>>> -					fctiw.o fctiwz.o fdiv.o
>> fdivs.o \
>>> +obj-y				:=3D fabs.o fadd.o fdiv.o fmul.o =
\
>>> +					fneg.o fsub.o types.o
>> udivmodti4.o
>>> +				=09
>>> +obj-$(CONFIG_MATH_EMULATION)	+=3D math.o fmr.o lfd.o stfd.o \
>>> +					fadds.o fcmpo.o fcmpu.o \
>>> +					fctiw.o fctiwz.o fdivs.o \
>>>  					fmadd.o fmadds.o
>> fmsub.o fmsubs.o \
>>> -					fmul.o fmuls.o fnabs.o
>> fneg.o types.o \
>>> +					fmuls.o fnabs.o \
>>>  					fnmadd.o fnmadds.o
>> fnmsub.o fnmsubs.o \
>>>  					fres.o frsp.o frsqrte.o
>> fsel.o lfs.o \
>>> -					fsqrt.o	fsqrts.o fsub.o
>> fsubs.o \
>>> +					fsqrt.o	fsqrts.o fsubs.o \
>>>  					mcrfs.o mffs.o mtfsb0.o
>> mtfsb1.o \
>>> -					mtfsf.o mtfsfi.o
>> stfiwx.o stfs.o \
>>> -					udivmodti4.o
>>> +					mtfsf.o mtfsfi.o stfiwx.o stfs.o
>>> +
>>> +obj-$(CONFIG_SPE)		+=3D efsabs.o efsadd.o efscfd.o
>> efscmpeq.o \
>>> +					efscmpgt.o efscmplt.o
>> efsctsf.o efsctsi.o \
>>> +					efsctsiz.o efsctuf.o
>> efsctui.o efsctuiz.o \
>>> +					efsdiv.o efsmul.o
>> efsnabs.o efsneg.o efssub.o \
>>> +					evfsabs.o evfsadd.o
>> evfscmpeq.o evfscmpgt.o \
>>> +					evfscmplt.o evfsctsf.o
>> evfsctsi.o evfsctsiz.o \
>>> +					evfsctuf.o evfsctui.o
>> evfsctuiz.o evfsdiv.o \
>>> +					evfsmul.o evfsnabs.o
>> evfsneg.o evfssub.o \
>>> +					efdcfs.o efdcmpeq.o
>> efdcmpgt.o efdcmplt.o efdctsf.o \
>>> +					efdctsi.o efdctsidz.o
>> efdctsiz.o efdctuf.o \
>>> +					efdctui.o efdctuidz.o
>> efdctuiz.o efdnabs.o
>>>
>>>  CFLAGS_fabs.o =3D -fno-builtin-fabs
>>>  CFLAGS_math.o =3D -fno-builtin-fabs
>>> diff --git a/arch/powerpc/math-emu/sfp-machine.h b/arch/powerpc/
>>> math-emu/sfp-machine.h index 4b17d83..313734d 100644
>>> --- a/arch/powerpc/math-emu/sfp-machine.h
>>> +++ b/arch/powerpc/math-emu/sfp-machine.h
>>> @@ -166,7 +166,11 @@ #define __FP_PACK_RAW_2(fs, val, X)=09
>> 		\
>>>  #include <linux/kernel.h>
>>>  #include <linux/sched.h>
>>>
>>> +#ifdef CONFIG_SPE
>>> +#define __FPU_FPSCR	(current->thread.spefscr)
>>> +#else
>>>  #define __FPU_FPSCR	(current->thread.fpscr.val)
>>> +#endif
>>>
>>>  /* We only actually write to the destination register
>>>   * if exceptions signalled (if any) will not trap.
>>> diff --git a/arch/powerpc/sysdev/sigfpe_handler.c b/arch/powerpc/
>>> sysdev/sigfpe_handler.c new file mode 100644 index 0000000..6e809b2
>>> --- /dev/null
>>> +++ b/arch/powerpc/sysdev/sigfpe_handler.c
>>> @@ -0,0 +1,298 @@
>>> +/*
>>> + * arch/powerpc/sysdev/sigfpe_handler.c
>>> + *
>>> + * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights
>>> reserved.
>>> + *
>>> + * Author: Ebony Zhu, ebony.zhu@freescale.com
>>> + *
>>> + * Derived from arch/powerpc/math-emu/math.c
>>> + * Copyright (C) 1999  Eddie C. Dost  (ecd@atecom.com)
>>> + *
>>> + * Description:
>>> + * This file is the exception handler to make E500 SPE instructions
>>> + * fully comply with IEEE-754 floating point standard.
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License
>>> + * as published by the Free Software Foundation; either version
>>> + * 2 of the License, or (at your option) any later version.
>>> + */
>>> +
>>> +#include <linux/types.h>
>>> +
>>> +#include <asm/uaccess.h>
>>> +#include <asm/reg.h>
>>> +
>>> +#define SPEFUNC(x)	extern int x(void *, void *, void *, void *)
>>> +#define efdabs	fabs
>>> +#define efdadd	fadd
>>> +#define efdsub	fsub
>>> +#define efddiv	fdiv
>>> +#define efdmul	fmul
>>> +#define efdneg	fneg
>>> +
>>> +/* Scalar SPFP functions */
>>> +SPEFUNC(efsabs);
>>> +SPEFUNC(efsadd);
>>> +SPEFUNC(efscfd);
>>> +SPEFUNC(efscmpeq);
>>> +SPEFUNC(efscmpgt);
>>> +SPEFUNC(efscmplt);
>>> +SPEFUNC(efsctsf);
>>> +SPEFUNC(efsctsi);
>>> +SPEFUNC(efsctsiz);
>>> +SPEFUNC(efsctuf);
>>> +SPEFUNC(efsctui);
>>> +SPEFUNC(efsctuiz);
>>> +SPEFUNC(efsdiv);
>>> +SPEFUNC(efsmul);
>>> +SPEFUNC(efsnabs);
>>> +SPEFUNC(efsneg);
>>> +SPEFUNC(efssub);
>>> +
>>> +/* Vector Floating-Point functions */ SPEFUNC(evfsabs);
>>> +SPEFUNC(evfsadd); SPEFUNC(evfscmpeq); SPEFUNC(evfscmpgt);
>>> +SPEFUNC(evfscmplt); SPEFUNC(evfsctsf); SPEFUNC(evfsctsi);
>>> +SPEFUNC(evfsctsiz); SPEFUNC(evfsctuf); SPEFUNC(evfsctui);
>>> +SPEFUNC(evfsctuiz); SPEFUNC(evfsdiv); SPEFUNC(evfsmul);
>>> +SPEFUNC(evfsnabs); SPEFUNC(evfsneg); SPEFUNC(evfssub);
>>> +
>>> +/* Scalar DPFP functions */
>>> +SPEFUNC(efdabs);
>>> +SPEFUNC(efdadd);
>>> +SPEFUNC(efdcfs);
>>> +SPEFUNC(efdcmpeq);
>>> +SPEFUNC(efdcmpgt);
>>> +SPEFUNC(efdcmplt);
>>> +SPEFUNC(efdctsf);
>>> +SPEFUNC(efdctsi);
>>> +SPEFUNC(efdctsidz);
>>> +SPEFUNC(efdctsiz);
>>> +SPEFUNC(efdctuf);
>>> +SPEFUNC(efdctui);
>>> +SPEFUNC(efdctuidz);
>>> +SPEFUNC(efdctuiz);
>>> +SPEFUNC(efddiv);
>>> +SPEFUNC(efdmul);
>>> +SPEFUNC(efdnabs);
>>> +SPEFUNC(efdneg);
>>> +SPEFUNC(efdsub);
>>> +
>>> +#define VCT		0x4
>>
>> not used?
>
> Currently not. We can remove it then.
>
>
>>
>>> +#define SPFP		0x6
>>> +#define DPFP		0x7
>>> +#define EFAPU		0x4
>>> +
>>> +#define EFSADD		0x2c0
>>> +#define EFSSUB		0x2c1
>>> +#define EFSABS		0x2c4
>>> +#define EFSNABS		0x2c5
>>> +#define EFSNEG		0x2c6
>>> +#define EFSMUL		0x2c8
>>> +#define EFSDIV		0x2c9
>>> +#define EFSCMPGT	0x2cc
>>> +#define EFSCMPLT	0x2cd
>>> +#define EFSCMPEQ	0x2ce
>>> +#define EFSCFD		0x2cf
>>> +#define EFSCTUI		0x2d4
>>> +#define EFSCTSI		0x2d5
>>> +#define EFSCTUF		0x2d6
>>> +#define EFSCTSF		0x2d7
>>> +#define EFSCTUIZ	0x2d8
>>> +#define EFSCTSIZ	0x2da
>>> +
>>> +#define EVFSADD		0x280
>>> +#define EVFSSUB		0x281
>>> +#define EVFSABS		0x284
>>> +#define EVFSNABS	0x285
>>> +#define EVFSNEG		0x286
>>> +#define EVFSMUL		0x288
>>> +#define EVFSDIV		0x289
>>> +#define EVFSCMPGT	0x28c
>>> +#define EVFSCMPLT	0x28d
>>> +#define EVFSCMPEQ	0x28e
>>> +#define EVFSCTUI	0x294
>>> +#define EVFSCTSI	0x295
>>> +#define EVFSCTUF	0x296
>>> +#define EVFSCTSF	0x297
>>> +#define EVFSCTUIZ	0x298
>>> +#define EVFSCTSIZ	0x29a
>>> +
>>> +#define EFDADD		0x2e0
>>> +#define EFDSUB		0x2e1
>>> +#define EFDABS		0x2e4
>>> +#define EFDNABS		0x2e5
>>> +#define EFDNEG		0x2e6
>>> +#define EFDMUL		0x2e8
>>> +#define EFDDIV		0x2e9
>>> +#define EFDCTUIDZ	0x2ea
>>> +#define EFDCTSIDZ	0x2eb
>>> +#define EFDCMPGT	0x2ec
>>> +#define EFDCMPLT	0x2ed
>>> +#define EFDCMPEQ	0x2ee
>>> +#define EFDCFS		0x2ef
>>> +#define EFDCTUI		0x2f4
>>> +#define EFDCTSI		0x2f5
>>> +#define EFDCTUF		0x2f6
>>> +#define EFDCTSF		0x2f7
>>> +#define EFDCTUIZ	0x2f8
>>> +#define EFDCTSIZ	0x2fa
>>> +
>>> +#define AB	2
>>> +#define XA	3
>>> +#define XB	4
>>> +#define XCR	5=09
>>> +
>>> +static u64 fullgprs[32];
>>> +u32 speinsn;
>>> +
>>> +int
>>> +sigfpe_handler(struct pt_regs *regs)
>>> +{
>>> +	void *op0 =3D 0, *op1 =3D 0, *op2 =3D 0, *op3 =3D 0;
>>> +	int i;
>>> +	int (*func)(void *, void *, void *, void *);
>>> +	int type =3D 0;
>>> +	int flag;
>>> +=09
>>> +	switch ((speinsn >> 5) & 0x7 ) {
>>> +	case SPFP:
>>> +		for(i =3D 0; i < 32; i++) {
>>> +			fullgprs[i] =3D regs->gpr[i];
>>> +			fullgprs[i] =3D fullgprs[i] << 32 |
>> current->thread.evr[i];
>>> +		};
>>> +		break;
>>> +	default:
>>> +		for(i =3D 0; i < 32; i++) {
>>> +			fullgprs[i] =3D current->thread.evr[i];
>>> +			fullgprs[i] =3D (fullgprs[i] << 32) |
>> (regs->gpr[i]);
>>> +		};
>>> +	}
>>> +
>>> +	switch (speinsn >> 26) {
>>> +=09
>>> +	case EFAPU:
>>> +		switch (speinsn & 0x7ff) {
>>> +		case EFSABS:	func =3D efsabs;		type =3D
>> XA;	break;
>>> +		case EFSADD:	func =3D efsadd;		type =3D
>> AB;      break;
>>> +		case EFSCFD:	func =3D efscfd;		type =3D
>> XB;	break;
>>> +		case EFSCMPEQ:	func =3D efscmpeq;	type =3D
>> XCR;	break;
>>> +		case EFSCMPGT:	func =3D efscmpgt;	type =3D
>> XCR;	break;
>>> +		case EFSCMPLT:	func =3D efscmplt;	type =3D
>> XCR;	break;
>>> +		case EFSCTSF:	func =3D efsctsf;		type =3D
>> XB;	break;
>>> +		case EFSCTSI:	func =3D efsctsi;		type =3D
>> XB;	break;
>>> +		case EFSCTSIZ:	func =3D efsctsiz;	type =3D
>> XB;	break;
>>> +		case EFSCTUF:	func =3D efsctuf;		type =3D
>> XB;	break;
>>> +		case EFSCTUI:	func =3D efsctui;		type =3D
>> XB;	break;
>>> +		case EFSCTUIZ:	func =3D efsctuiz;	type =3D
>> XB;	break;
>>> +		case EFSDIV:	func =3D efsdiv;		type =3D
>> AB;	break;
>>> +		case EFSMUL:	func =3D efsmul;		type =3D
>> AB;	break;
>>> +		case EFSNABS:	func =3D efsnabs;		type =3D
>> XA;	break;
>>> +		case EFSNEG:	func =3D efsneg;		type =3D
>> XA;	break;
>>> +		case EFSSUB:	func =3D efssub;		type =3D
>> AB;	break;
>>> +
>>> +		case EVFSABS:	func =3D evfsabs;		type =3D
>> XA;	break;
>>> +		case EVFSADD:	func =3D evfsadd;		type =3D
>> AB;      break;
>>> +		case EVFSCMPEQ:	func =3D evfscmpeq;	type =3D
>> XCR;	break;
>>> +		case EVFSCMPGT:	func =3D evfscmpgt;	type =3D
>> XCR;	break;
>>> +		case EVFSCMPLT:	func =3D evfscmplt;	type =3D
>> XCR;	break;
>>> +		case EVFSCTSF:	func =3D evfsctsf;	type =3D
>> XB;	break;
>>> +		case EVFSCTSI:	func =3D evfsctsi;	type =3D
>> XB;	break;
>>> +		case EVFSCTSIZ:	func =3D evfsctsiz;	type =3D
>> XB;	break;
>>> +		case EVFSCTUF:	func =3D evfsctuf;	type =3D
>> XB;	break;
>>> +		case EVFSCTUI:	func =3D evfsctui;	type =3D
>> XB;	break;
>>> +		case EVFSCTUIZ:	func =3D evfsctuiz;	type =3D
>> XB;	break;
>>> +		case EVFSDIV:	func =3D evfsdiv;		type =3D
>> AB;	break;
>>> +		case EVFSMUL:	func =3D evfsmul;		type =3D
>> AB;	break;
>>> +		case EVFSNABS:	func =3D evfsnabs;	type =3D
>> XA;	break;
>>> +		case EVFSNEG:	func =3D evfsneg;		type =3D
>> XA;	break;
>>> +		case EVFSSUB:	func =3D evfssub;		type =3D
>> AB;	break;
>>> +
>>> +		case EFDABS:	func =3D efdabs;		type =3D
>> XA;	break;
>>> +		case EFDADD:	func =3D efdadd;		type =3D
>> AB;	break;
>>> +		case EFDCFS:	func =3D efdcfs;		type =3D
>> XB;	break;
>>> +		case EFDCMPEQ:	func =3D efdcmpeq;	type =3D
>> XCR;	break;
>>> +		case EFDCMPGT:	func =3D efdcmpgt;	type =3D
>> XCR;	break;
>>> +		case EFDCMPLT:	func =3D efdcmplt;	type =3D
>> XCR;	break;
>>> +		case EFDCTSF:	func =3D efdctsf;		type =3D
>> XB;	break;
>>> +		case EFDCTSI:	func =3D efdctsi;		type =3D
>> XB;	break;
>>> +		case EFDCTSIDZ:	func =3D efdctsidz;	type =3D
>> XB;	break;
>>> +		case EFDCTSIZ:	func =3D efdctsiz;	type =3D
>> XB;	break;
>>> +		case EFDCTUF:	func =3D efdctuf;		type =3D
>> XB;	break;
>>> +		case EFDCTUI:	func =3D efdctui;		type =3D
>> XB;	break;
>>> +		case EFDCTUIDZ:	func =3D efdctuidz;	type =3D
>> XB;	break;
>>> +		case EFDCTUIZ:	func =3D efdctuiz;	type =3D
>> XB;	break;
>>> +		case EFDDIV:	func =3D efddiv;		type =3D
>> AB;	break;
>>> +		case EFDMUL:	func =3D efdmul;		type =3D
>> AB;	break;
>>> +		case EFDNABS:	func =3D efdnabs;		type =3D
>> XA;	break;
>>> +		case EFDNEG:	func =3D efdneg;		type =3D
>> XA;	break;
>>> +		case EFDSUB:	func =3D efdsub;		type =3D
>> AB;	break;	=09
>>> +		default:
>>> +			goto illegal;
>>> +		}
>>> +		break;
>>> +	default:
>>> +		goto illegal;
>>> +	}
>>> +
>>> +	switch (type) {
>>> +	case AB:
>>> +		op0 =3D &fullgprs[(speinsn >> 21) & 0x1f];
>>> +		op1 =3D &fullgprs[(speinsn >> 16) & 0x1f];
>>> +		op2 =3D &fullgprs[(speinsn >> 11) & 0x1f];
>>> +		break;
>>> +
>>> +	case XA:
>>> +		op0 =3D &fullgprs[(speinsn >> 21) & 0x1f];
>>> +		op1 =3D &fullgprs[(speinsn >> 16) & 0x1f];
>>> +		break;
>>> +
>>> +	case XB:
>>> +		op0 =3D &fullgprs[(speinsn >> 21) & 0x1f];
>>> +		op1 =3D &fullgprs[(speinsn >> 11) & 0x1f];
>>> +		break;
>>> +=09
>>> +	case XCR:
>>> +		op0 =3D (void *)&regs->ccr;
>>> +		op1 =3D (void *)((speinsn >> 23) & 0x7);
>>> +		op2 =3D &fullgprs[(speinsn >> 16) & 0x1f];
>>> +		op3 =3D &fullgprs[(speinsn >> 11) & 0x1f];
>>> +		break;
>>> +
>>> +	default:
>>> +		goto illegal;
>>> +	}
>>> +
>>> +	flag =3D func(op0, op1, op2, op3);
>>> +=09
>>> +	switch ((speinsn >> 5) & 0x7 ) {
>>> +	case SPFP:
>>> +		for (i =3D 0; i < 32; i++) {
>>> +			regs->gpr[i] =3D fullgprs[i] >> 32;
>>> +		};
>>> +		break;
>>> +	default:
>>> +		for (i =3D 0; i < 32; i++) {
>>> +			regs->gpr[i] =3D fullgprs[i];
>>> +			current->thread.evr[i] =3D fullgprs[i] >> 32;
>>> +		};
>>> +	}
>>> +=09
>>> +	current->thread.spefscr &=3D 0x3f;
>>
>> can't clear spefscr this way.
>>
>> Need to do what the existing handler was doing here.
>
> Do you mean I need to do it like this:
>
> 	unsigned long spefscr;
> 	spefscr =3D current->thread.spefscr;
> 	spefscr =3D 0x3f;
> 	current->spefscr =3D spefscr ;
>
> I'm not really understand...

What I meant is the existing handler uses the thread.fpexc_mode to =20
keep track of the "exception" flags that an application may want to =20
enable as part of the STND-C fpenv support (find a copy of the ANSI =20
spec and read up on Floating-point Environment).  The std c-lib =20
provides functions like fesetexceptflag(), fetestexcept(), fesetround=20
(), etc..

Some of this will end up calling into set_fpexc_mode() in the kernel =20
via the prctl system call.

The idea was we use thread.fpexc_mode to keep track of what the C =20
runtime env wants the flags to be, than in the exception handler we =20
can use those flags to decide if we should raise an software SIGFPE =20
exception on the process.

So when you emulate the instructions you need to handle determining =20
if a software SIGFPE should be sent or not.

I hope that makes sense.

- k

>>> +	return 0;
>>> +
>>> +illegal:
>>> +	printk(KERN_ERR "\nOoops! IEEE-754 compliance handler
>> encountered
>>> un-supported instruction.\n");
>>> +	return -ENOSYS;
>>> +}
>>> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/
>>> Makefile index 04d4917..1e74e15 100644
>>> --- a/arch/powerpc/sysdev/Makefile
>>> +++ b/arch/powerpc/sysdev/Makefile
>>> @@ -13,6 +13,7 @@ obj-$(CONFIG_FSL_SOC)		+=3D fsl_soc.o
>>>  obj-$(CONFIG_TSI108_BRIDGE)	+=3D tsi108_pci.o tsi108_dev.o
>>>  obj-$(CONFIG_QUICC_ENGINE)	+=3D qe_lib/
>>>  obj-$(CONFIG_MTD)		+=3D rom.o
>>> +obj-$(CONFIG_SPE)		+=3D sigfpe_handler.o
>>>
>>>  ifeq ($(CONFIG_PPC_MERGE),y)
>>>  obj-$(CONFIG_PPC_I8259)		+=3D i8259.o
>>> --
>>> 1.4.0
>>
>>
