Return-Path: <B20052@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4EB2D2C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 17:28:39 +1100 (EST)
From: Leekha Shaveta-B20052 <B20052@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 5/6] powerpc/fsl-booke: Add B4_QDS board support
Date: Mon, 18 Mar 2013 06:28:31 +0000
Message-ID: <E12D2F89F87F4A49B0320A4C2DE7E749144A98@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1363334109-21922-1-git-send-email-shaveta@freescale.com>
 <1363334109-21922-5-git-send-email-shaveta@freescale.com>
 <69F32D25-11C5-414D-A23A-AD25C9CCF9C6@kernel.crashing.org>
In-Reply-To: <69F32D25-11C5-414D-A23A-AD25C9CCF9C6@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
Sent: Friday, March 15, 2013 9:28 PM
To: Leekha Shaveta-B20052
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/6] powerpc/fsl-booke: Add B4_QDS board support


On Mar 15, 2013, at 2:55 AM, Shaveta Leekha wrote:

> - Add support for B4 board's personalities in board file  b4_qds.c, It=20
> is common for B4 personalities B4860 and B4420QDS
> - Add B4QDS support in Kconfig and Makefile

Code also references a B4220, what about it?
[SL] I have added the basic support for it in board file as it's one of the=
 personality of
B4, missed it in description. But device trees for this has not been create=
d and tested.
So what do you suggest here:
Should I add it here in B4 board support or should I remove its references =
altogether?

>=20
> B4860QDS is a high-performance computing evaluation, development and=20
> test platform supporting the B4860 QorIQ Power Architecture processor,=20
> with following major features:
>=20
>    - Four dual-threaded e6500 Power Architecture processors
>      organized in one cluster-each core runs up to 1.8 GHz
>    - Two DDR3/3L controllers for high-speed memory interface each
>      runs at up to 1866.67 MHz
>    - CoreNet fabric that fully supports coherency using MESI protocol
>      between the e6500 cores, SC3900 FVP cores, memories and
>      external interfaces.
>    - Data Path Acceleration Architecture having FMAN, QMan, BMan, SEC 5.3=
 and RMAN
>    - Large internal cache memory with snooping and stashing capabilities
>    - Sixteen 10-GHz SerDes lanes that serve:
>        - Two SRIO interfaces. Each supports up to 4 lanes and
>          a total of up to 8 lanes
>        - Up to 8-lanes Common Public Radio Interface (CPRI) controller
>          for glue-less antenna connection
>        - Two 10-Gbit Ethernet controllers (10GEC)
>        - Six 1G/2.5-Gbit Ethernet controllers for network communications
>        - PCI Express controller
>        - Debug (Aurora)
>    - Various system peripherals
>=20
> B4420 is a reduced personality of B4860 with fewer core/clusters(both=20
> SC3900 and e6500), fewer DDR controllers, fewer serdes lanes, fewer SGMII=
 interfaces and reduced target frequencies.
>=20
> Key differences between B4860 and B4420:
> B4420 has:
>    - Fewer e6500 cores:
>        1 cluster with 2 e6500 cores
>    - Fewer SC3900 cores/clusters:
>        1 cluster with 2 SC3900 cores per cluster
>    - Single DDRC
>    - 2X 4 lane serdes
>    - 3 SGMII interfaces
>    - no sRIO
>    - no 10G
>=20
> Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
> ---
> arch/powerpc/platforms/85xx/Kconfig  |   16 +++++
> arch/powerpc/platforms/85xx/Makefile |    1 +
> arch/powerpc/platforms/85xx/b4_qds.c |  102=20
> ++++++++++++++++++++++++++++++++++
> 3 files changed, 119 insertions(+), 0 deletions(-) create mode 100644=20
> arch/powerpc/platforms/85xx/b4_qds.c
>=20
> diff --git a/arch/powerpc/platforms/85xx/Kconfig=20
> b/arch/powerpc/platforms/85xx/Kconfig
> index 31dc066..7bbd522 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -262,6 +262,22 @@ config SGY_CTS1000
>=20
> endif # PPC32
>=20
> +config B4_QDS
> +	bool "Freescale B4 QDS"
> +	select DEFAULT_UIMAGE
> +	select E500
> +	select PPC_E500MC
> +	select PHYS_64BIT
> +	select SWIOTLB
> +	select MPC8xxx_GPIO

should be:
        select GENERIC_GPIO
        select ARCH_REQUIRE_GPIOLIB

[SL] will change it.
=20
> +	select HAS_RAPIDIO
> +	select PPC_EPAPR_HV_PIC
> +	help
> +	  This option enables support for the B4 QDS board
> +	  The B4 application development system B4 QDS is a complete
> +	  debugging environment intended for engineers developing
> +	  applications for the B4.
> +

Should be in the if PPC64 section with T4240 QDS support
[SL] ok=20

> config P5020_DS
> 	bool "Freescale P5020 DS"
> 	select DEFAULT_UIMAGE
> diff --git a/arch/powerpc/platforms/85xx/Makefile=20
> b/arch/powerpc/platforms/85xx/Makefile
> index 712e233..a12ae2d 100644
> --- a/arch/powerpc/platforms/85xx/Makefile
> +++ b/arch/powerpc/platforms/85xx/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_SMP) +=3D smp.o obj-y +=3D common.o
>=20
> obj-$(CONFIG_BSC9131_RDB) +=3D bsc913x_rdb.o
> +obj-$(CONFIG_B4_QDS)   +=3D b4_qds.o corenet_ds.o
> obj-$(CONFIG_MPC8540_ADS) +=3D mpc85xx_ads.o
> obj-$(CONFIG_MPC8560_ADS) +=3D mpc85xx_ads.o
> obj-$(CONFIG_MPC85xx_CDS) +=3D mpc85xx_cds.o diff --git=20
> a/arch/powerpc/platforms/85xx/b4_qds.c=20
> b/arch/powerpc/platforms/85xx/b4_qds.c
> new file mode 100644
> index 0000000..0c6702f
> --- /dev/null
> +++ b/arch/powerpc/platforms/85xx/b4_qds.c
> @@ -0,0 +1,102 @@
> +/*
> + * B4 QDS Setup
> + * Should apply for QDS platform of B4860 and it's personalities.
> + * viz B4860/B4420/B4220QDS
> + *
> + * Copyright 2012 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or=20
> +modify it
> + * under  the terms of  the GNU General  Public License as published=20
> +by the
> + * Free Software Foundation;  either version 2 of the  License, or=20
> +(at your
> + * option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/kdev_t.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/phy.h>
> +
> +#include <asm/time.h>
> +#include <asm/machdep.h>
> +#include <asm/pci-bridge.h>
> +#include <mm/mmu_decl.h>
> +#include <asm/prom.h>
> +#include <asm/udbg.h>
> +#include <asm/mpic.h>
> +
> +#include <linux/of_platform.h>
> +#include <sysdev/fsl_soc.h>
> +#include <sysdev/fsl_pci.h>
> +#include <asm/ehv_pic.h>
> +
> +#include "corenet_ds.h"
> +
> +/*
> + * Called very early, device-tree isn't unflattened  */ static int=20
> +__init b4_qds_probe(void) {
> +	unsigned long root =3D of_get_flat_dt_root(); #ifdef CONFIG_SMP
> +	extern struct smp_ops_t smp_85xx_ops; #endif
> +
> +	if ((of_flat_dt_is_compatible(root, "fsl,B4860QDS")) ||
> +		(of_flat_dt_is_compatible(root, "fsl,B4420QDS")) ||
> +			(of_flat_dt_is_compatible(root, "fsl,B4220QDS")))
> +		return 1;
> +
> +	/* Check if we're running under the Freescale hypervisor */
> +	if ((of_flat_dt_is_compatible(root, "fsl,B4860QDS-hv")) ||
> +		(of_flat_dt_is_compatible(root, "fsl,B4420QDS-hv")) ||
> +			(of_flat_dt_is_compatible(root, "fsl,B4220QDS-hv"))) {
> +		ppc_md.init_IRQ =3D ehv_pic_init;
> +		ppc_md.get_irq =3D ehv_pic_get_irq;
> +		ppc_md.restart =3D fsl_hv_restart;
> +		ppc_md.power_off =3D fsl_hv_halt;
> +		ppc_md.halt =3D fsl_hv_halt;
> +#ifdef CONFIG_SMP
> +		/*
> +		 * Disable the timebase sync operations because we can't write
> +		 * to the timebase registers under the hypervisor.
> +		  */
> +		smp_85xx_ops.give_timebase =3D NULL;
> +		smp_85xx_ops.take_timebase =3D NULL;
> +#endif
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +define_machine(b4_qds) {
> +	.name			=3D "B4 QDS",
> +	.probe			=3D b4_qds_probe,
> +	.setup_arch		=3D corenet_ds_setup_arch,
> +	.init_IRQ		=3D corenet_ds_pic_init,
> +#ifdef CONFIG_PCI
> +	.pcibios_fixup_bus	=3D fsl_pcibios_fixup_bus,
> +#endif
> +/* coreint doesn't play nice with lazy EE, use legacy mpic for now */=20
> +#ifdef CONFIG_PPC64
> +	.get_irq		=3D mpic_get_irq,
> +#else
> +	.get_irq		=3D mpic_get_coreint_irq,
> +#endif
> +	.restart		=3D fsl_rstcr_restart,
> +	.calibrate_decr		=3D generic_calibrate_decr,
> +	.progress		=3D udbg_progress,
> +#ifdef CONFIG_PPC64
> +	.power_save		=3D book3e_idle,
> +#else
> +	.power_save		=3D e500_idle,
> +#endif
> +};
> +
> +machine_arch_initcall(b4_qds, corenet_ds_publish_devices);
> +
> +#ifdef CONFIG_SWIOTLB
> +machine_arch_initcall(b4_qds, swiotlb_setup_bus_notifier); #endif
> --
> 1.7.6.GIT
>=20
>=20

Regards,
Shaveta

=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
