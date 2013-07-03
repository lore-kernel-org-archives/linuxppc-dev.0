Return-Path: <B16395@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7B2892C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 21:52:48 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>
Subject: RE: [v2][PATCH 1/7] powerpc/book3e: support CONFIG_RELOCATABLE
Date: Wed, 3 Jul 2013 11:52:37 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0A3520C2@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1371714797-7898-1-git-send-email-tiejun.chen@windriver.com>
 <1371714797-7898-2-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1371714797-7898-2-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+varun.sethi=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Tiejun
> Chen
> Sent: Thursday, June 20, 2013 1:23 PM
> To: benh@kernel.crashing.org
> Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
> Subject: [v2][PATCH 1/7] powerpc/book3e: support CONFIG_RELOCATABLE
>=20
> book3e is different with book3s since 3s includes the exception vectors
> code in head_64.S as it relies on absolute addressing which is only
> possible within this compilation unit. So we have to get that label
> address with got.
>=20
> And when boot a relocated kernel, we should reset ipvr properly again
> after .relocate.
>=20
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  arch/powerpc/include/asm/exception-64e.h |    8 ++++++++
>  arch/powerpc/kernel/exceptions-64e.S     |   15 ++++++++++++++-
>  arch/powerpc/kernel/head_64.S            |   22 ++++++++++++++++++++++
>  arch/powerpc/lib/feature-fixups.c        |    7 +++++++
>  4 files changed, 51 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/include/asm/exception-64e.h
> b/arch/powerpc/include/asm/exception-64e.h
> index 51fa43e..89e940d 100644
> --- a/arch/powerpc/include/asm/exception-64e.h
> +++ b/arch/powerpc/include/asm/exception-64e.h
> @@ -214,10 +214,18 @@ exc_##label##_book3e:
>  #define TLB_MISS_STATS_SAVE_INFO_BOLTED  #endif
>=20
> +#ifndef CONFIG_RELOCATABLE
>  #define SET_IVOR(vector_number, vector_offset)	\
>  	li	r3,vector_offset@l; 		\
>  	ori	r3,r3,interrupt_base_book3e@l;	\
>  	mtspr	SPRN_IVOR##vector_number,r3;
> +#else
> +#define SET_IVOR(vector_number, vector_offset)	\
> +	LOAD_REG_ADDR(r3,interrupt_base_book3e);\
> +	rlwinm	r3,r3,0,15,0;			\
> +	ori	r3,r3,vector_offset@l;		\
> +	mtspr	SPRN_IVOR##vector_number,r3;
> +#endif
>=20
[Sethi Varun-B16395] Please add a documentation note here.

>  #endif /* _ASM_POWERPC_EXCEPTION_64E_H */
>=20
> diff --git a/arch/powerpc/kernel/exceptions-64e.S
> b/arch/powerpc/kernel/exceptions-64e.S
> index 645170a..4b23119 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -1097,7 +1097,15 @@ skpinv:	addi	r6,r6,1
> 	/* Increment */
>   * r4 =3D MAS0 w/TLBSEL & ESEL for the temp mapping
>   */
>  	/* Now we branch the new virtual address mapped by this entry */
> +#ifdef CONFIG_RELOCATABLE
> +	/* We have to find out address from lr. */
> +	bl	1f		/* Find our address */
> +1:	mflr	r6
> +	addi	r6,r6,(2f - 1b)
> +	tovirt(r6,r6)
> +#else
>  	LOAD_REG_IMMEDIATE(r6,2f)
> +#endif
>  	lis	r7,MSR_KERNEL@h
>  	ori	r7,r7,MSR_KERNEL@l
>  	mtspr	SPRN_SRR0,r6
> @@ -1348,9 +1356,14 @@ _GLOBAL(book3e_secondary_thread_init)
>  	mflr	r28
>  	b	3b
>=20
> -_STATIC(init_core_book3e)
> +_GLOBAL(init_core_book3e)
>  	/* Establish the interrupt vector base */
> +#ifdef CONFIG_RELOCATABLE
> +	tovirt(r2,r2)
> +	LOAD_REG_ADDR(r3, interrupt_base_book3e) #else
>  	LOAD_REG_IMMEDIATE(r3, interrupt_base_book3e)
> +#endif
>  	mtspr	SPRN_IVPR,r3
>  	sync
>  	blr
[Sethi Varun-B16395] Please add a documentation note here as well.=20

> diff --git a/arch/powerpc/kernel/head_64.S
> b/arch/powerpc/kernel/head_64.S index b61363d..0942f3a 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -414,12 +414,22 @@ _STATIC(__after_prom_start)
>  	/* process relocations for the final address of the kernel */
>  	lis	r25,PAGE_OFFSET@highest	/* compute virtual base of kernel */
>  	sldi	r25,r25,32
> +#if defined(CONFIG_PPC_BOOK3E)
> +	tovirt(r26,r26)			/* on booke, we already run at
> PAGE_OFFSET */
> +#endif
>  	lwz	r7,__run_at_load-_stext(r26)
> +#if defined(CONFIG_PPC_BOOK3E)
> +	tophys(r26,r26)			/* Restore for the remains. */
> +#endif
>  	cmplwi	cr0,r7,1	/* flagged to stay where we are ? */
>  	bne	1f
>  	add	r25,r25,r26
>  1:	mr	r3,r25
>  	bl	.relocate
> +#if defined(CONFIG_PPC_BOOK3E)
> +	/* We should set ivpr again after .relocate. */
> +	bl	.init_core_book3e
> +#endif
>  #endif
>=20
[Sethi Varun-B16395] A more detailed note over here would be useful.

>  /*
> @@ -447,12 +457,24 @@ _STATIC(__after_prom_start)
>   * variable __run_at_load, if it is set the kernel is treated as
> relocatable
>   * kernel, otherwise it will be moved to PHYSICAL_START
>   */
> +#if defined(CONFIG_PPC_BOOK3E)
> +	tovirt(r26,r26)			/* on booke, we already run at
> PAGE_OFFSET */
> +#endif
>  	lwz	r7,__run_at_load-_stext(r26)
> +#if defined(CONFIG_PPC_BOOK3E)
> +	tophys(r26,r26)			/* Restore for the remains. */
> +#endif
>  	cmplwi	cr0,r7,1
>  	bne	3f
>=20
> +#ifdef CONFIG_PPC_BOOK3E
> +	LOAD_REG_ADDR(r5, interrupt_end_book3e)
> +	LOAD_REG_ADDR(r11, _stext)
> +	sub	r5,r5,r11
> +#else
>  	/* just copy interrupts */
>  	LOAD_REG_IMMEDIATE(r5, __end_interrupts - _stext)
> +#endif
>  	b	5f
>  3:
>  #endif
> diff --git a/arch/powerpc/lib/feature-fixups.c
> b/arch/powerpc/lib/feature-fixups.c
> index 7a8a748..13f20ed 100644
> --- a/arch/powerpc/lib/feature-fixups.c
> +++ b/arch/powerpc/lib/feature-fixups.c
> @@ -135,13 +135,20 @@ void do_final_fixups(void)  #if
> defined(CONFIG_PPC64) && defined(CONFIG_RELOCATABLE)
>  	int *src, *dest;
>  	unsigned long length;
> +#ifdef CONFIG_PPC_BOOK3E
> +	extern char interrupt_end_book3e[];
> +#endif
[Sethi Varun-B16395] You can simply move this to sections.h and remove the =
ifdefs.

>=20
>  	if (PHYSICAL_START =3D=3D 0)
>  		return;
>=20
>  	src =3D (int *)(KERNELBASE + PHYSICAL_START);
>  	dest =3D (int *)KERNELBASE;
> +#ifdef CONFIG_PPC_BOOK3E
> +	length =3D (interrupt_end_book3e - _stext) / sizeof(int); #else
>  	length =3D (__end_interrupts - _stext) / sizeof(int);
> +#endif
>=20
>  	while (length--) {
>  		patch_instruction(dest, *src);

-Varun
