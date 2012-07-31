Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 709AB2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 00:15:54 +1000 (EST)
Subject: Re: [PATCH v8 5/7] powerpc/85xx: add sleep and deep sleep support
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1342788159-27529-6-git-send-email-chenhui.zhao@freescale.com>
Date: Tue, 31 Jul 2012 09:15:33 -0500
Message-Id: <F8FE8505-6F6A-4A4B-8302-C1CF16B48B60@kernel.crashing.org>
References: <1342788159-27529-1-git-send-email-chenhui.zhao@freescale.com>
 <1342788159-27529-6-git-send-email-chenhui.zhao@freescale.com>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 20, 2012, at 7:42 AM, Zhao Chenhui wrote:

> In sleep PM mode, the clocks of e500 core and unused IP blocks is
> turned off. IP blocks which are allowed to wake up the processor
> are still running.
>=20
> Some Freescale chips like MPC8536 and P1022 has deep sleep PM mode
> in addtion to the sleep PM mode.
>=20
> While in deep sleep PM mode, additionally, the power supply is
> removed from e500 core and most IP blocks. Only the blocks needed
> to wake up the chip out of deep sleep are ON.
>=20
> This patch supports 32-bit and 36-bit address space.
>=20
> The sleep mode is equal to the Standby state in Linux. The deep sleep
> mode is equal to the Suspend-to-RAM state of Linux Power Management.
>=20
> Command to enter sleep mode.
>  echo standby > /sys/power/state
> Command to enter deep sleep mode.
>  echo mem > /sys/power/state
>=20
> Signed-off-by: Dave Liu <daveliu@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Jin Qing <b24347@freescale.com>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Cc: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> ---
> arch/powerpc/Kconfig                  |    2 +-
> arch/powerpc/include/asm/cacheflush.h |    2 +
> arch/powerpc/kernel/Makefile          |    3 +
> arch/powerpc/kernel/l2cache_85xx.S    |   56 +++
> arch/powerpc/platforms/85xx/Makefile  |    2 +-
> arch/powerpc/platforms/85xx/sleep.S   |  621 =
+++++++++++++++++++++++++++++++++
> arch/powerpc/sysdev/fsl_pmc.c         |   98 +++++-
> arch/powerpc/sysdev/fsl_soc.h         |    5 +
> 8 files changed, 769 insertions(+), 20 deletions(-)
> create mode 100644 arch/powerpc/kernel/l2cache_85xx.S
> create mode 100644 arch/powerpc/platforms/85xx/sleep.S
>=20
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index a7c6914..9d6de82 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -665,7 +665,7 @@ config FSL_PCI
> config FSL_PMC
> 	bool
> 	default y
> -	depends on SUSPEND && (PPC_85xx || PPC_86xx)
> +	depends on SUSPEND && (PPC_85xx || PPC_86xx) && !PPC_E500MC
> 	help
> 	  Freescale MPC85xx/MPC86xx power management controller support
> 	  (suspend/resume). For MPC83xx see platforms/83xx/suspend.c
> diff --git a/arch/powerpc/include/asm/cacheflush.h =
b/arch/powerpc/include/asm/cacheflush.h
> index b843e35..6c5f1c2 100644
> --- a/arch/powerpc/include/asm/cacheflush.h
> +++ b/arch/powerpc/include/asm/cacheflush.h
> @@ -58,6 +58,8 @@ extern void flush_inval_dcache_range(unsigned long =
start, unsigned long stop);
> extern void flush_dcache_phys_range(unsigned long start, unsigned long =
stop);
> #endif
>=20
> +extern void flush_dcache_L1(void);
> +
> #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
> 	do { \
> 		memcpy(dst, src, len); \
> diff --git a/arch/powerpc/kernel/Makefile =
b/arch/powerpc/kernel/Makefile
> index 83afacd..0ddef24 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -64,6 +64,9 @@ obj-$(CONFIG_FA_DUMP)		+=3D fadump.o
> ifeq ($(CONFIG_PPC32),y)
> obj-$(CONFIG_E500)		+=3D idle_e500.o
> endif
> +ifneq ($(CONFIG_PPC_E500MC),y)
> +obj-$(CONFIG_PPC_85xx)		+=3D l2cache_85xx.o
> +endif

why do we need this, beyond reduce code size on an e500mc kernel build?  =
If so why isn't 85xx/sleep.S doing the same thing?

> obj-$(CONFIG_6xx)		+=3D idle_6xx.o l2cr_6xx.o =
cpu_setup_6xx.o
> obj-$(CONFIG_TAU)		+=3D tau_6xx.o
> obj-$(CONFIG_HIBERNATION)	+=3D swsusp.o suspend.o
> diff --git a/arch/powerpc/kernel/l2cache_85xx.S =
b/arch/powerpc/kernel/l2cache_85xx.S
> new file mode 100644
> index 0000000..e920d69
> --- /dev/null
> +++ b/arch/powerpc/kernel/l2cache_85xx.S
> @@ -0,0 +1,56 @@
> +/*
> + * Copyright (C) 2009-2012 Freescale Semiconductor, Inc. All rights =
reserved.
> + *	Scott Wood <scottwood@freescale.com>
> + *	Dave Liu <daveliu@freescale.com>
> + * implement the L2 cache operations of e500 based L2 controller
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <asm/reg.h>
> +#include <asm/cputable.h>
> +#include <asm/ppc_asm.h>
> +#include <asm/asm-offsets.h>
> +
> +#define L2CTL_L2E	0x80000000
> +#define L2CTL_L2I	0x40000000
> +
> +	.section .text
> +
> +	/* r3 =3D virtual address of L2 controller, WIMG =3D 01xx */
> +_GLOBAL(flush_disable_L2)
> +	/* It's a write-through cache, so only invalidation is needed. =
*/
> +	mbar
> +	isync
> +	lwz	r4, 0(r3)
> +	li	r5, 1
> +	rlwimi	r4, r5, 30, L2CTL_L2E | L2CTL_L2I
> +	stw	r4, 0(r3)
> +
> +	/* Wait for the invalidate to finish */
> +1:	lwz	r4, 0(r3)
> +	andis.	r4, r4, L2CTL_L2I@h
> +	bne	1b
> +	mbar
> +
> +	blr
> +
> +	/* r3 =3D virtual address of L2 controller, WIMG =3D 01xx */
> +_GLOBAL(invalidate_enable_L2)
> +	mbar
> +	isync
> +	lwz	r4, 0(r3)
> +	li	r5, 3
> +	rlwimi	r4, r5, 30, L2CTL_L2E | L2CTL_L2I
> +	stw	r4, 0(r3)
> +
> +	/* Wait for the invalidate to finish */
> +1:	lwz	r4, 0(r3)
> +	andis.	r4, r4, L2CTL_L2I@h
> +	bne	1b
> +	mbar
> +
> +	blr
> diff --git a/arch/powerpc/platforms/85xx/Makefile =
b/arch/powerpc/platforms/85xx/Makefile
> index 3dfe811..405ab79 100644
> --- a/arch/powerpc/platforms/85xx/Makefile
> +++ b/arch/powerpc/platforms/85xx/Makefile
> @@ -3,7 +3,7 @@
> #
> obj-$(CONFIG_SMP) +=3D smp.o
>=20
> -obj-y +=3D common.o
> +obj-y +=3D common.o sleep.o
>=20
> obj-$(CONFIG_BSC9131_RDB) +=3D bsc913x_rdb.o
> obj-$(CONFIG_MPC8540_ADS) +=3D mpc85xx_ads.o
>=20

- k
