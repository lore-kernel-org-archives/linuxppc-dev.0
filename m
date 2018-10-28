Return-Path: <SRS0=mX83=NI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6F9C6786F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Oct 2018 17:59:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58882082D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Oct 2018 17:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58882082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42jlpy409VzDsMm
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 04:59:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42jlmy0rr2zDrb6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 04:57:20 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42jlmg4yvtz9ttBp;
 Sun, 28 Oct 2018 18:57:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id DjRXH4rWwmTF; Sun, 28 Oct 2018 18:57:07 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42jlmg4CcJz9ttBm;
 Sun, 28 Oct 2018 18:57:07 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id 52CAB42E; Sun, 28 Oct 2018 18:57:06 +0100 (CET)
Received: from 37-170-85-49.coucou-networks.fr
 (37-170-85-49.coucou-networks.fr [37.170.85.49]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Sun, 28 Oct 2018 18:57:06 +0100
Date: Sun, 28 Oct 2018 18:57:06 +0100
Message-ID: <20181028185706.Horde.lU9x8hQG5ISmBGg3l1SFdw1@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH 1/5] powerpc/64s: Guarded Userspace Access Prevention
References: <20181026063513.30806-1-ruscur@russell.cc>
 <20181026063513.30806-2-ruscur@russell.cc>
In-Reply-To: <20181026063513.30806-2-ruscur@russell.cc>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Russell Currey <ruscur@russell.cc> a =C3=A9crit=C2=A0:

> Guarded Userspace Access Prevention (GUAP)  utilises a feature of
> the Radix MMU which disallows read and write access to userspace
> addresses.  By utilising this, the kernel is prevented from accessing
> user data from outside of trusted paths that perform proper safety checks=
,
> such as copy_{to/from}_user() and friends.
>
> Userspace access is disabled from early boot and is only enabled when:
>
> 	- exiting the kernel and entering userspace
> 	- performing an operation like copy_{to/from}_user()
> 	- context switching to a process that has access enabled
>
> and similarly, access is disabled again when exiting userspace and enteri=
ng
> the kernel.
>
> This feature has a slight performance impact which I roughly measured to =
be
> 3% slower in the worst case (performing 1GB of 1 byte read()/write()
> syscalls), and is gated behind the CONFIG_PPC_RADIX_GUAP option for
> performance-critical builds.
>
> This feature can be tested by using the lkdtm driver (CONFIG_LKDTM=3Dy) a=
nd
> performing the following:
>
> 	echo ACCESS_USERSPACE > [debugfs]/provoke-crash/DIRECT
>
> if enabled, this should send SIGSEGV to the thread.
>
> Signed-off-by: Russell Currey <ruscur@russell.cc>

I think this patch should be split in at least two parts:
First part for implementing the generic part, including the changes to=20=
=20
futex=20and csum, and a second part implementing the radix part.
> ---
> Since the previous version of this patchset (named KHRAP) there have been
> several changes, some of which include:
>
>         - macro naming, suggested by Nick
>         - builds should be fixed outside of 64s
>         - no longer unlock heading out to userspace
>         - removal of unnecessary isyncs
>         - more config option testing
>         - removal of save/restore
>         - use pr_crit() and reword message on fault
>
>  arch/powerpc/include/asm/exception-64e.h |  3 ++
>  arch/powerpc/include/asm/exception-64s.h | 19 +++++++-
>  arch/powerpc/include/asm/mmu.h           |  7 +++
>  arch/powerpc/include/asm/paca.h          |  3 ++
>  arch/powerpc/include/asm/reg.h           |  1 +
>  arch/powerpc/include/asm/uaccess.h       | 57 ++++++++++++++++++++----
>  arch/powerpc/kernel/asm-offsets.c        |  1 +
>  arch/powerpc/kernel/dt_cpu_ftrs.c        |  4 ++
>  arch/powerpc/kernel/entry_64.S           | 17 ++++++-
>  arch/powerpc/mm/fault.c                  | 12 +++++
>  arch/powerpc/mm/pgtable-radix.c          |  2 +
>  arch/powerpc/mm/pkeys.c                  |  7 ++-
>  arch/powerpc/platforms/Kconfig.cputype   | 15 +++++++
>  13 files changed, 135 insertions(+), 13 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/exception-64e.h=20=20
>=20b/arch/powerpc/include/asm/exception-64e.h
> index 555e22d5e07f..bf25015834ee 100644
> --- a/arch/powerpc/include/asm/exception-64e.h
> +++ b/arch/powerpc/include/asm/exception-64e.h
> @@ -215,5 +215,8 @@ exc_##label##_book3e:
>  #define RFI_TO_USER							\
>  	rfi
>
> +#define UNLOCK_USER_ACCESS(reg)
> +#define LOCK_USER_ACCESS(reg)
> +
>  #endif /* _ASM_POWERPC_EXCEPTION_64E_H */
>
> diff --git a/arch/powerpc/include/asm/exception-64s.h=20=20
>=20b/arch/powerpc/include/asm/exception-64s.h
> index 3b4767ed3ec5..0cac5bd380ca 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -264,6 +264,19 @@ BEGIN_FTR_SECTION_NESTED(943)						\
>  	std	ra,offset(r13);						\
>  END_FTR_SECTION_NESTED(ftr,ftr,943)
>
> +#define LOCK_USER_ACCESS(reg)							\
> +BEGIN_MMU_FTR_SECTION_NESTED(944)					\
> +	LOAD_REG_IMMEDIATE(reg,AMR_LOCKED);				\
> +	mtspr	SPRN_AMR,reg;						\
> +END_MMU_FTR_SECTION_NESTED(MMU_FTR_RADIX_GUAP,MMU_FTR_RADIX_GUAP,944)
> +
> +#define UNLOCK_USER_ACCESS(reg)							\
> +BEGIN_MMU_FTR_SECTION_NESTED(945)					\
> +	li	reg,0;							\
> +	mtspr	SPRN_AMR,reg;						\
> +	isync								\
> +END_MMU_FTR_SECTION_NESTED(MMU_FTR_RADIX_GUAP,MMU_FTR_RADIX_GUAP,945)
> +
>  #define EXCEPTION_PROLOG_0(area)					\
>  	GET_PACA(r13);							\
>  	std	r9,area+EX_R9(r13);	/* save r9 */			\
> @@ -500,7 +513,11 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
>  	beq	4f;			/* if from kernel mode		*/ \
>  	ACCOUNT_CPU_USER_ENTRY(r13, r9, r10);				   \
>  	SAVE_PPR(area, r9);						   \
> -4:	EXCEPTION_PROLOG_COMMON_2(area)					   \
> +4:	lbz	r9,PACA_USER_ACCESS_ALLOWED(r13);			   \
> +	cmpwi	cr1,r9,0;						   \
> +	beq	5f;							   \
> +	LOCK_USER_ACCESS(r9);							   \
> +5:	EXCEPTION_PROLOG_COMMON_2(area)					\
>  	EXCEPTION_PROLOG_COMMON_3(n)					   \
>  	ACCOUNT_STOLEN_TIME
>
> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mm=
u.h
> index eb20eb3b8fb0..3b31ed702785 100644
> --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -107,6 +107,10 @@
>   */
>  #define MMU_FTR_1T_SEGMENT		ASM_CONST(0x40000000)
>
> +/* Supports GUAP (key 0 controlling userspace addresses) on radix
> + */
> +#define MMU_FTR_RADIX_GUAP		ASM_CONST(0x80000000)
> +
>  /* MMU feature bit sets for various CPUs */
>  #define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	\
>  	MMU_FTR_HPTE_TABLE | MMU_FTR_PPCAS_ARCH_V2
> @@ -143,6 +147,9 @@ enum {
>  		MMU_FTR_KERNEL_RO | MMU_FTR_68_BIT_VA |
>  #ifdef CONFIG_PPC_RADIX_MMU
>  		MMU_FTR_TYPE_RADIX |
> +#endif
> +#ifdef CONFIG_PPC_RADIX_GUAP
> +		MMU_FTR_RADIX_GUAP |

Can this exist without MMT_FTR_TYPE_RADIX ?

>  #endif
>  		0,
>  };
> diff --git a/arch/powerpc/include/asm/paca.h=20=20
>=20b/arch/powerpc/include/asm/paca.h
> index e843bc5d1a0f..e905f09b2d38 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -169,6 +169,9 @@ struct paca_struct {
>  	u64 saved_r1;			/* r1 save for RTAS calls or PM or EE=3D0 */
>  	u64 saved_msr;			/* MSR saved here by enter_rtas */
>  	u16 trap_save;			/* Used when bad stack is encountered */
> +#ifdef CONFIG_PPC_RADIX_GUAP
> +	u8 user_access_allowed;		/* set when AMR allows user accesses */
> +#endif
>  	u8 irq_soft_mask;		/* mask for irq soft masking */
>  	u8 irq_happened;		/* irq happened while soft-disabled */
>  	u8 io_sync;			/* writel() needs spin_unlock sync */
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/re=
g.h
> index 640a4d818772..b994099a906b 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -246,6 +246,7 @@
>  #define SPRN_DSCR	0x11
>  #define SPRN_CFAR	0x1c	/* Come From Address Register */
>  #define SPRN_AMR	0x1d	/* Authority Mask Register */
> +#define   AMR_LOCKED	0xC000000000000000ULL /* Read & Write disabled */

Why ULL ? mtspr() takes unsigned long arg.

>  #define SPRN_UAMOR	0x9d	/* User Authority Mask Override Register */
>  #define SPRN_AMOR	0x15d	/* Authority Mask Override Register */
>  #define SPRN_ACOP	0x1F	/* Available Coprocessor Register */
> diff --git a/arch/powerpc/include/asm/uaccess.h=20=20
>=20b/arch/powerpc/include/asm/uaccess.h
> index 15bea9a0f260..209bfc47c340 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -62,6 +62,27 @@ static inline int __access_ok(unsigned long addr,=20=
=20
>=20unsigned long size,
>
>  #endif
>
> +static inline void unlock_user_access(void)
> +{
> +#ifdef CONFIG_PPC_RADIX_GUAP
> +	if (mmu_has_feature(MMU_FTR_RADIX_GUAP)) {

You need to include the .h which provides mmu_has_feature()

I think uaccess.h should only include the empty function for when=20=20
CONFIG_PPC_GUAP=20is not defined. Radix guap function should go in a=20=20
radix=20header file.

> +		mtspr(SPRN_AMR, 0);
> +		isync();
> +		get_paca()->user_access_allowed =3D 1;
> +	}
> +#endif
> +}
> +
> +static inline void lock_user_access(void)
> +{
> +#ifdef CONFIG_PPC_RADIX_GUAP
> +	if (mmu_has_feature(MMU_FTR_RADIX_GUAP)) {
> +		mtspr(SPRN_AMR, AMR_LOCKED);
> +		get_paca()->user_access_allowed =3D 0;
> +	}
> +#endif
> +}
> +
>  #define access_ok(type, addr, size)		\
>  	(__chk_user_ptr(addr),			\
>  	 __access_ok((__force unsigned long)(addr), (size), get_fs()))
> @@ -141,6 +162,7 @@ extern long __put_user_bad(void);
>  #define __put_user_size(x, ptr, size, retval)			\
>  do {								\
>  	retval =3D 0;						\
> +	unlock_user_access();					\
>  	switch (size) {						\
>  	  case 1: __put_user_asm(x, ptr, retval, "stb"); break;	\
>  	  case 2: __put_user_asm(x, ptr, retval, "sth"); break;	\
> @@ -148,6 +170,7 @@ do {								\
>  	  case 8: __put_user_asm2(x, ptr, retval); break;	\
>  	  default: __put_user_bad();				\
>  	}							\
> +	lock_user_access();					\
>  } while (0)
>
>  #define __put_user_nocheck(x, ptr, size)			\
> @@ -240,6 +263,7 @@ do {								\
>  	__chk_user_ptr(ptr);					\
>  	if (size > sizeof(x))					\
>  		(x) =3D __get_user_bad();				\
> +	unlock_user_access();					\
>  	switch (size) {						\
>  	case 1: __get_user_asm(x, ptr, retval, "lbz"); break;	\
>  	case 2: __get_user_asm(x, ptr, retval, "lhz"); break;	\
> @@ -247,6 +271,7 @@ do {								\
>  	case 8: __get_user_asm2(x, ptr, retval);  break;	\
>  	default: (x) =3D __get_user_bad();			\
>  	}							\
> +	lock_user_access();					\
>  } while (0)
>
>  /*
> @@ -306,15 +331,20 @@ extern unsigned long __copy_tofrom_user(void=20=20
>=20__user *to,
>  static inline unsigned long
>  raw_copy_in_user(void __user *to, const void __user *from, unsigned long=
 n)
>  {
> -	return __copy_tofrom_user(to, from, n);
> +	unsigned long ret;
> +	unlock_user_access();					\
> +	ret =3D __copy_tofrom_user(to, from, n);			\
> +	lock_user_access();					\
> +	return ret;						\
>  }
>  #endif /* __powerpc64__ */
>
>  static inline unsigned long raw_copy_from_user(void *to,
>  		const void __user *from, unsigned long n)
>  {
> +	unsigned long ret;
>  	if (__builtin_constant_p(n) && (n <=3D 8)) {
> -		unsigned long ret =3D 1;
> +		ret =3D 1;
>
>  		switch (n) {
>  		case 1:
> @@ -339,14 +369,18 @@ static inline unsigned long=20=20
>=20raw_copy_from_user(void *to,
>  	}
>
>  	barrier_nospec();
> -	return __copy_tofrom_user((__force void __user *)to, from, n);
> +	unlock_user_access();
> +	ret =3D __copy_tofrom_user((__force void __user *)to, from, n);
> +	lock_user_access();
> +	return ret;
>  }
>
>  static inline unsigned long raw_copy_to_user(void __user *to,
>  		const void *from, unsigned long n)
>  {
> +	unsigned long ret;
>  	if (__builtin_constant_p(n) && (n <=3D 8)) {
> -		unsigned long ret =3D 1;
> +		ret =3D 1;
>
>  		switch (n) {
>  		case 1:
> @@ -366,17 +400,24 @@ static inline unsigned long=20=20
>=20raw_copy_to_user(void __user *to,
>  			return 0;
>  	}
>
> -	return __copy_tofrom_user(to, (__force const void __user *)from, n);
> +	unlock_user_access();
> +	ret =3D __copy_tofrom_user(to, (__force const void __user *)from, n);
> +	lock_user_access();
> +	return ret;
>  }
>
>  extern unsigned long __clear_user(void __user *addr, unsigned long size)=
;
>
>  static inline unsigned long clear_user(void __user *addr, unsigned=20=20
>=20long size)
>  {
> +	unsigned long ret =3D size;
>  	might_fault();
> -	if (likely(access_ok(VERIFY_WRITE, addr, size)))
> -		return __clear_user(addr, size);
> -	return size;
> +	if (likely(access_ok(VERIFY_WRITE, addr, size))) {
> +		unlock_user_access();
> +		ret =3D __clear_user(addr, size);
> +		lock_user_access();
> +	}
> +	return ret;
>  }
>
>  extern long strncpy_from_user(char *dst, const char __user *src,=20=20
>=20long count);
> diff --git a/arch/powerpc/kernel/asm-offsets.c=20=20
>=20b/arch/powerpc/kernel/asm-offsets.c
> index 10ef2e4db2fd..5050f15ad2f5 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -260,6 +260,7 @@ int main(void)
>  	OFFSET(ACCOUNT_STARTTIME_USER, paca_struct, accounting.starttime_user);
>  	OFFSET(ACCOUNT_USER_TIME, paca_struct, accounting.utime);
>  	OFFSET(ACCOUNT_SYSTEM_TIME, paca_struct, accounting.stime);
> +	OFFSET(PACA_USER_ACCESS_ALLOWED, paca_struct, user_access_allowed);
>  	OFFSET(PACA_TRAP_SAVE, paca_struct, trap_save);
>  	OFFSET(PACA_NAPSTATELOST, paca_struct, nap_state_lost);
>  	OFFSET(PACA_SPRG_VDSO, paca_struct, sprg_vdso);
> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c=20=20
>=20b/arch/powerpc/kernel/dt_cpu_ftrs.c
> index f432054234a4..df4716624840 100644
> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> @@ -337,6 +337,10 @@ static int __init feat_enable_mmu_radix(struct=20=20
>=20dt_cpu_feature *f)
>  	cur_cpu_spec->mmu_features |=3D MMU_FTRS_HASH_BASE;
>  	cur_cpu_spec->cpu_user_features |=3D PPC_FEATURE_HAS_MMU;
>
> +#ifdef CONFIG_PPC_RADIX_GUAP
> +	cur_cpu_spec->mmu_features |=3D MMU_FTR_RADIX_GUAP;
> +#endif
> +
>  	return 1;
>  #endif
>  	return 0;
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_6=
4.S
> index 7b1693adff2a..23f0944185d3 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -297,7 +297,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
>  	b	.	/* prevent speculative execution */
>
>  	/* exit to kernel */
> -1:	ld	r2,GPR2(r1)
> +1:	/* if the AMR was unlocked before, unlock it again */
> +	lbz	r2,PACA_USER_ACCESS_ALLOWED(r13)
> +	cmpwi	cr1,0
> +	bne	2f
> +	UNLOCK_USER_ACCESS(r2)
> +2:	ld	r2,GPR2(r1)
>  	ld	r1,GPR1(r1)
>  	mtlr	r4
>  	mtcr	r5
> @@ -965,6 +970,7 @@ BEGIN_FTR_SECTION
>  	ld	r2,_PPR(r1)
>  	mtspr	SPRN_PPR,r2
>  END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
> +
>  	ACCOUNT_CPU_USER_EXIT(r13, r2, r4)
>  	REST_GPR(13, r1)
>
> @@ -983,7 +989,14 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
>  	RFI_TO_USER
>  	b	.	/* prevent speculative execution */
>
> -1:	mtspr	SPRN_SRR1,r3
> +1:	/* exit to kernel */
> +	/* if the AMR was unlocked before, unlock it again */
> +	lbz	r2,PACA_USER_ACCESS_ALLOWED(r13)
> +	cmpwi	cr1,0
> +	bne	2f
> +	UNLOCK_USER_ACCESS(r2)
> +
> +2:	mtspr	SPRN_SRR1,r3
>
>  	ld	r2,_CCR(r1)
>  	mtcrf	0xFF,r2
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index d51cf5f4e45e..17fd8c6b055b 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -462,6 +462,18 @@ static int __do_page_fault(struct pt_regs=20=20
>=20*regs, unsigned long address,
>  		return bad_key_fault_exception(regs, address,
>  					       get_mm_addr_key(mm, address));
>
> +#ifdef CONFIG_PPC_RADIX_SMAP

SMAP ?

> +	if (mmu_has_feature(MMU_FTR_RADIX_GUAP)) {
> +		if (unlikely(!is_user &&
> +			     (error_code & DSISR_PROTFAULT) &&
> +			     (mfspr(SPRN_AMR) & AMR_LOCKED))) {

Do you mean that in case of fault in user copy, we leave the=20=20
protection=20open for handling the exception ? What is the purpose of=20=20
the=20new paca flag then ?

> +			pr_crit("Kernel attempted to access user data"
> +			        " unsafely, possible exploit attempt\n");
> +			return bad_area_nosemaphore(regs, address);
> +		}
> +	}

Are we sure it is an access to user data ?

> +#endif
> +
>  	/*
>  	 * We want to do this outside mmap_sem, because reading code around nip
>  	 * can result in fault, which will cause a deadlock when called with
> diff --git a/arch/powerpc/mm/pgtable-radix.c=20=20
>=20b/arch/powerpc/mm/pgtable-radix.c
> index c879979faa73..9e5b98887a05 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -29,6 +29,7 @@
>  #include <asm/powernv.h>
>  #include <asm/sections.h>
>  #include <asm/trace.h>
> +#include <asm/uaccess.h>
>
>  #include <trace/events/thp.h>
>
> @@ -608,6 +609,7 @@ void __init radix__early_init_mmu(void)
>  		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
>  		radix_init_partition_table();
>  		radix_init_amor();
> +		lock_user_access();
>  	} else {
>  		radix_init_pseries();
>  	}
> diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> index b271b283c785..0b9bc320138c 100644
> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -7,6 +7,7 @@
>
>  #include <asm/mman.h>
>  #include <asm/setup.h>
> +#include <asm/uaccess.h>
>  #include <linux/pkeys.h>
>  #include <linux/of_device.h>
>
> @@ -266,7 +267,8 @@ int __arch_set_user_pkey_access(struct=20=20
>=20task_struct *tsk, int pkey,
>
>  void thread_pkey_regs_save(struct thread_struct *thread)
>  {
> -	if (static_branch_likely(&pkey_disabled))
> +	if (static_branch_likely(&pkey_disabled) &&
> +	    !mmu_has_feature(MMU_FTR_RADIX_GUAP))
>  		return;
>
>  	/*
> @@ -280,7 +282,8 @@ void thread_pkey_regs_save(struct thread_struct *thre=
ad)
>  void thread_pkey_regs_restore(struct thread_struct *new_thread,
>  			      struct thread_struct *old_thread)
>  {
> -	if (static_branch_likely(&pkey_disabled))
> +	if (static_branch_likely(&pkey_disabled) &&
> +	    !mmu_has_feature(MMU_FTR_RADIX_GUAP))
>  		return;
>
>  	if (old_thread->amr !=3D new_thread->amr)
> diff --git a/arch/powerpc/platforms/Kconfig.cputype=20=20
>=20b/arch/powerpc/platforms/Kconfig.cputype
> index f4e2c5729374..6617d3e415a7 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -351,6 +351,21 @@ config PPC_RADIX_MMU_DEFAULT
>
>  	  If you're unsure, say Y.
>
> +config PPC_RADIX_GUAP
> +	bool "Guarded Userspace Access Prevention on Radix"
> +	depends on PPC_RADIX_MMU
> +	default y
> +	help
> +	  Enable support for Guarded Userspace Access Prevention (GUAP)
> +	  when using the Radix MMU.  GUAP is a security feature
> +	  preventing the kernel from directly accessing userspace data
> +	  without going through the proper checks.
> +
> +	  GUAP has a minor performance impact on context switching and can be
> +	  disabled at boot time using the "nosmap" kernel command line option.
> +
> +	  If you're unsure, say Y.
> +

I think this should be a named in a generic way without the radix thing.
Then one day it will be reused by the 8xx

Christophe

>  config ARCH_ENABLE_HUGEPAGE_MIGRATION
>  	def_bool y
>  	depends on PPC_BOOK3S_64 && HUGETLB_PAGE && MIGRATION
> --
> 2.19.1


