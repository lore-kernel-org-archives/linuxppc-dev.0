Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B2FFFB7121
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Nov 2010 22:51:32 +1100 (EST)
Subject: Re: [PATCH] Add Freescale CodeWarrior debug support for kernel
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1288255803-10948-1-git-send-email-tie-fei.zang@freescale.com>
Date: Thu, 11 Nov 2010 05:51:23 -0600
Message-Id: <C621BC63-26DC-4495-B7EE-600D6C565AB9@kernel.crashing.org>
References: <1288255803-10948-1-git-send-email-tie-fei.zang@freescale.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, adrian.bogdan@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 28, 2010, at 3:50 AM, Roy Zang wrote:

> CodeWarrior is popular embedded tools to support debugging Powerpc.
> This patch adds Freescale CodeWarrior debug support for Linux kernel =
on
> 85xx/QorIQ platform.
>=20
> Signed-off-by: Bogdan Adrin <drian.bogdan@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> arch/powerpc/Kconfig.debug                    |    8 ++++++++
> arch/powerpc/Makefile                         |    5 +++++
> arch/powerpc/include/asm/reg_booke.h          |    4 ++++
> arch/powerpc/kernel/fsl_booke_entry_mapping.S |    3 +++
> arch/powerpc/kernel/head_fsl_booke.S          |   11 +++++++++--
> arch/powerpc/kernel/idle.c                    |    5 ++++-
> 6 files changed, 33 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 2d38a50..eedd2ac 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -153,6 +153,14 @@ config BDI_SWITCH
> 	  Unless you are intending to debug the kernel with one of these
> 	  machines, say N here.
>=20
> +config DEBUG_CODEWARRIOR
> +	bool "Include CodeWarrior kernel debugging"
> +	depends on DEBUG_KERNEL && PPC32
> +	help
> +	  Say Y here to include CodeWarrior kernel debugging option
> +	  Unless you are intending to debug the kernel with one of these
> +	  machines, say N here.
> +
> config BOOTX_TEXT
> 	bool "Support for early boot text console (BootX or OpenFirmware =
only)"
> 	depends on PPC_OF && PPC_BOOK3S
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index b7212b6..d3050e6 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -121,6 +121,11 @@ KBUILD_CFLAGS	+=3D $(call =
cc-option,-fno-dwarf2-cfi-asm)
> # often slow when they are implemented at all
> KBUILD_CFLAGS		+=3D -mno-string
>=20
> +ifeq ($(CONFIG_DEBUG_CODEWARRIOR),y)
> +CFLAGS +=3D -g2 -gdwarf-2
> +AFLAGS_KERNEL +=3D -Wa,-gdwarf2
> +endif
> +
> ifeq ($(CONFIG_6xx),y)
> KBUILD_CFLAGS		+=3D -mcpu=3Dpowerpc
> endif
> diff --git a/arch/powerpc/include/asm/reg_booke.h =
b/arch/powerpc/include/asm/reg_booke.h
> index 667a498..ac65fcd 100644
> --- a/arch/powerpc/include/asm/reg_booke.h
> +++ b/arch/powerpc/include/asm/reg_booke.h
> @@ -35,7 +35,11 @@
> #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_CE)
> #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
> #else
> +#if defined(CONFIG_DEBUG_CODEWARRIOR)
> +#define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_CE|MSR_DE)
> +#else
> #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_CE)
> +#endif
> #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
> #endif
>=20
> diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S =
b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> index a92c79b..9102aa7 100644
> --- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> +++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
> @@ -116,6 +116,9 @@ skpinv:	addi	r6,r6,1				=
/* Increment */
>=20
> 	xori	r6,r4,1
> 	slwi	r6,r6,5		/* setup new context with other address =
space */
> +#if defined(CONFIG_DEBUG_CODEWARRIOR)
> +	ori	r6, r6, 0x200	/* enable DE bit for MSR */

Can we use MSR_DE@l instead of 0x200

> +#endif
> 	bl	1f		/* Find our address */
> 1:	mflr	r9
> 	rlwimi	r7,r9,0,20,31
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S =
b/arch/powerpc/kernel/head_fsl_booke.S
> index 529b817..9962d09 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -21,7 +21,7 @@
>  *		debbie_chu@mvista.com
>  *    Copyright 2002-2004 MontaVista Software, Inc.
>  *	PowerPC 44x support, Matt Porter <mporter@kernel.crashing.org>
> - *    Copyright 2004 Freescale Semiconductor, Inc
> + *    Copyright 2004,2010 Freescale Semiconductor, Inc
>  *	PowerPC e500 modifications, Kumar Gala =
<galak@kernel.crashing.org>
>  *
>  * This program is free software; you can redistribute  it and/or =
modify it
> @@ -135,7 +135,7 @@ _ENTRY(__early_start)
> 	mtspr	SPRN_HID0, r2
> #endif
>=20
> -#if !defined(CONFIG_BDI_SWITCH)
> +#if !defined(CONFIG_BDI_SWITCH) && !defined(CONFIG_DEBUG_CODEWARRIOR)
> 	/*
> 	 * The Abatron BDI JTAG debugger does not tolerate others
> 	 * mucking with the debug registers.
> @@ -197,6 +197,13 @@ _ENTRY(__early_start)
> /*
>  * Decide what sort of machine this is and initialize the MMU.
>  */
> +#if defined(CONFIG_DEBUG_CODEWARRIOR)
> +	lis	r10, 0x1008 /* clear the V bit from the L2MMU_CAM8 =
register */

why do we need this code?  It seems pretty fragile if its assuming =
something about TLB entry #8

> +	mtspr	SPRN_MAS0, r10
> +	lis	r10, 0x0
> +	mtspr	SPRN_MAS1, r10
> +	tlbwe
> +#endif
> 	mr	r3,r31
> 	mr	r4,r30
> 	mr	r5,r29
> diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
> index 39a2baa..83fb019 100644
> --- a/arch/powerpc/kernel/idle.c
> +++ b/arch/powerpc/kernel/idle.c
> @@ -73,8 +73,11 @@ void cpu_idle(void)
> 				stop_critical_timings();
>=20
> 				/* check again after disabling irqs */
> -				if (!need_resched() && =
!cpu_should_die())
> +				if (!need_resched() && =
!cpu_should_die()) {
> +#if !defined(CONFIG_DEBUG_CODEWARRIOR)
> 					ppc_md.power_save();
> +#endif
> +				}
>=20
> 				start_critical_timings();
>=20
> --=20
> 1.5.6.5
>=20
