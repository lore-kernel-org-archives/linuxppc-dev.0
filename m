Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZTqX5DJTzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 12:01:28 +1100 (AEDT)
Message-ID: <1459299687.18194.8.camel@neuling.org>
Subject: Re: [PATCH 65/65] powerpc/mm/radix: Cputable update for radix
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 Mar 2016 12:01:27 +1100
In-Reply-To: <1459067053-10835-65-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1459067053-10835-65-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-03-27 at 13:54 +0530, Aneesh Kumar K.V wrote:
> This patch move the existing p9 hash to a different PVR and add
> radix feature with p9 PVR. That implies we will not be able to
> runtime select P9 hash. With P9 Radix we need to do
>=20
> * set UPRT =3D 0 in cpu setup
> * set different TLB set count
>=20
> We ideally want to use ibm,pa-features to enable disable radix. But
> we have already done setup cpu by the time we reach pa-features check.

What would we need change to disable radix after?  Can't we just update the=
=20
cur_cpu_spec if we hit this and change some LPCR bits?

> So for now use this hack.
>=20
> Not-Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Good, indeed this is a pretty gross hack :-)

Why not change the existing cputable entry to do radix and lets=20
forget about hash.

Mikey

> ---
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h |  1 +
>  arch/powerpc/include/asm/reg.h                |  4 +++
>  arch/powerpc/kernel/cpu_setup_power.S         | 35 +++++++++++++++++++++=
++++++
>  arch/powerpc/kernel/cputable.c                | 29 +++++++++++++++++++--=
-
>  arch/powerpc/kernel/mce_power.c               |  4 +++
>  5 files changed, 70 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc=
/include/asm/book3s/64/mmu-hash.h
> index 7da61b85406b..290157e8d5b2 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> @@ -119,6 +119,7 @@
>  #define POWER7_TLB_SETS		128	/* # sets in POWER7 TLB */
>  #define POWER8_TLB_SETS		512	/* # sets in POWER8 TLB */
>  #define POWER9_TLB_SETS_HASH	256	/* # sets in POWER9 TLB Hash mode */
> +#define POWER9_TLB_SETS_RADIX	128	/* # sets in POWER9 TLB Radix mode */
> =20
>  #ifndef __ASSEMBLY__
> =20
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/re=
g.h
> index 257251ada3a3..d39b5fedabfd 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -347,6 +347,10 @@
>  #define   LPCR_LPES_SH	2
>  #define   LPCR_RMI     0x00000002      /* real mode is cache inhibit */
>  #define   LPCR_HDICE   0x00000001      /* Hyp Decr enable (HV,PR,EE) */
> +/*
> + * Used in asm code, hence we don't want to use PPC_BITCOUNT
> + */
> +#define	  LPCR_UPRT	(ASM_CONST(0x1) << (64 - 42))
>  #ifndef SPRN_LPID
>  #define SPRN_LPID	0x13F	/* Logical Partition Identifier */
>  #endif
> diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/=
cpu_setup_power.S
> index 584e119fa8b0..e9b76c651bd1 100644
> --- a/arch/powerpc/kernel/cpu_setup_power.S
> +++ b/arch/powerpc/kernel/cpu_setup_power.S
> @@ -117,6 +117,41 @@ _GLOBAL(__restore_cpu_power9)
>  	mtlr	r11
>  	blr
> =20
> +_GLOBAL(__setup_cpu_power9_uprt)
> +	mflr	r11
> +	bl	__init_FSCR
> +	bl	__init_hvmode_206
> +	mtlr	r11
> +	beqlr
> +	li	r0,0
> +	mtspr	SPRN_LPID,r0
> +	mfspr	r3,SPRN_LPCR
> +	ori	r3, r3, LPCR_PECEDH
> +	oris	r3,r3,(LPCR_UPRT >> 16)
> +	bl	__init_LPCR
> +	bl	__init_HFSCR
> +	bl	__init_tlb_power7
> +	mtlr	r11
> +	blr
> +
> +_GLOBAL(__restore_cpu_power9_uprt)
> +	mflr	r11
> +	bl	__init_FSCR
> +	mfmsr	r3
> +	rldicl.	r0,r3,4,63
> +	mtlr	r11
> +	beqlr
> +	li	r0,0
> +	mtspr	SPRN_LPID,r0
> +	mfspr   r3,SPRN_LPCR
> +	ori	r3, r3, LPCR_PECEDH
> +	oris	r3,r3,(LPCR_UPRT >> 16)
> +	bl	__init_LPCR
> +	bl	__init_HFSCR
> +	bl	__init_tlb_power7
> +	mtlr	r11
> +	blr
> +
>  __init_hvmode_206:
>  	/* Disable CPU_FTR_HVMODE and exit if MSR:HV is not set */
>  	mfmsr	r3
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputabl=
e.c
> index be4d73053bed..878bcc46ea04 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -72,10 +72,13 @@ extern void __setup_cpu_power8(unsigned long offset, =
struct cpu_spec* spec);
>  extern void __restore_cpu_power8(void);
>  extern void __setup_cpu_power9(unsigned long offset, struct cpu_spec* sp=
ec);
>  extern void __restore_cpu_power9(void);
> +extern void __setup_cpu_power9_uprt(unsigned long offset, struct cpu_spe=
c* spec);
> +extern void __restore_cpu_power9_uprt(void);
>  extern void __restore_cpu_a2(void);
>  extern void __flush_tlb_power7(unsigned int action);
>  extern void __flush_tlb_power8(unsigned int action);
>  extern void __flush_tlb_power9(unsigned int action);
> +extern void __flush_tlb_power9_radix(unsigned int action);
>  extern long __machine_check_early_realmode_p7(struct pt_regs *regs);
>  extern long __machine_check_early_realmode_p8(struct pt_regs *regs);
>  #endif /* CONFIG_PPC64 */
> @@ -508,9 +511,9 @@ static struct cpu_spec __initdata cpu_specs[] =3D {
>  		.platform		=3D "power8",
>  	},
>  	{	/* Power9 */
> -		.pvr_mask		=3D 0xffff0000,
> -		.pvr_value		=3D 0x004e0000,
> -		.cpu_name		=3D "POWER9 (raw)",
> +		.pvr_mask		=3D 0xffffff00,
> +		.pvr_value		=3D 0x004e0200,
> +		.cpu_name		=3D "POWER9/hash (raw)",
>  		.cpu_features		=3D CPU_FTRS_POWER9,
>  		.cpu_user_features	=3D COMMON_USER_POWER9,
>  		.cpu_user_features2	=3D COMMON_USER2_POWER9,
> @@ -526,6 +529,26 @@ static struct cpu_spec __initdata cpu_specs[] =3D {
>  		.flush_tlb		=3D __flush_tlb_power9,
>  		.platform		=3D "power9",
>  	},
> +	{	/*  Power9 */
> +		.pvr_mask		=3D 0xffff0000,
> +		.pvr_value		=3D 0x004e0000,
> +		.cpu_name		=3D "POWER9/radix (raw)",
> +		.cpu_features		=3D CPU_FTRS_POWER9,
> +		.cpu_user_features	=3D COMMON_USER_POWER9,
> +		.cpu_user_features2	=3D COMMON_USER2_POWER9,
> +		.mmu_features		=3D MMU_FTRS_POWER9 | MMU_FTR_RADIX,
> +		.icache_bsize		=3D 128,
> +		.dcache_bsize		=3D 128,
> +		.num_pmcs		=3D 6,
> +		.pmc_type		=3D PPC_PMC_IBM,
> +		.oprofile_cpu_type	=3D "ppc64/power8",
> +		.oprofile_type		=3D PPC_OPROFILE_INVALID,
> +		.cpu_setup		=3D __setup_cpu_power9_uprt,
> +		.cpu_restore		=3D __restore_cpu_power9_uprt,
> +		.flush_tlb		=3D __flush_tlb_power9_radix,
> +		.machine_check_early	=3D __machine_check_early_realmode_p8,
> +		.platform		=3D "power9",
> +	},
>  	{	/* Cell Broadband Engine */
>  		.pvr_mask		=3D 0xffff0000,
>  		.pvr_value		=3D 0x00700000,
> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_po=
wer.c
> index 92a66a2a9b85..f902ede263ab 100644
> --- a/arch/powerpc/kernel/mce_power.c
> +++ b/arch/powerpc/kernel/mce_power.c
> @@ -75,6 +75,10 @@ void __flush_tlb_power9(unsigned int action)
>  	flush_tlb_206(POWER9_TLB_SETS_HASH, action);
>  }
> =20
> +void __flush_tlb_power9_radix(unsigned int action)
> +{
> +	flush_tlb_206(POWER9_TLB_SETS_RADIX, action);
> +}
> =20
>  /* flush SLBs and reload */
>  #ifdef CONFIG_PPC_MMU_STD_64
