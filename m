Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 54BEF2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2012 22:29:24 +1000 (EST)
Subject: Re: [PATCH 2/3] powerpc/e500: add paravirt QEMU platform
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20120627235005.GB9100@tyr.buserror.net>
Date: Fri, 6 Jul 2012 14:29:15 +0200
Message-Id: <36624A62-88AD-404A-A7A8-02D62E8700F0@suse.de>
References: <20120627235005.GB9100@tyr.buserror.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Jia Hongtao <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 28.06.2012, at 01:50, Scott Wood wrote:

> This gives the kernel a paravirtualized machine to target, without
> requiring both sides to pretend to be targeting a specific board
> that likely has little to do with the host in KVM scenarios.  This
> avoids the need to add new boards to QEMU just to be able to
> run KVM on new CPUs.
>=20
> As this is the first platform that can run with either e500v2 or
> e500mc, CONFIG_PPC_E500MC is now a legitimately user configurable
> option, so add a help text.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/platforms/85xx/Kconfig     |   16 +++++++
> arch/powerpc/platforms/85xx/Makefile    |    1 +
> arch/powerpc/platforms/85xx/qemu_e500.c |   66 =
+++++++++++++++++++++++++++++++
> arch/powerpc/platforms/Kconfig.cputype  |    4 ++

I really think we should document what exactly this machine expects.

> 4 files changed, 87 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/platforms/85xx/qemu_e500.c
>=20
> diff --git a/arch/powerpc/platforms/85xx/Kconfig =
b/arch/powerpc/platforms/85xx/Kconfig
> index f000d81..7bbebe5 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -263,6 +263,22 @@ config P5020_DS
> 	help
> 	  This option enables support for the P5020 DS board
>=20
> +config PPC_QEMU_E500
> +	bool "QEMU generic e500 platform"
> +	depends on EXPERIMENTAL
> +	select DEFAULT_UIMAGE
> +	help
> +	  This option enables support for running as a QEMU guest using
> +	  QEMU's generic e500 machine.  This is not required if you're
> +	  using a QEMU machine that targets a specific board, such as
> +	  mpc8544ds.
> +
> +	  Unlike most e500 boards that target a specific CPU, this
> +	  platform works with any e500-family CPU that QEMU supports.
> +	  Thus, you'll need to make sure CONFIG_PPC_E500MC is set or
> +	  unset based on the emulated CPU (or actual host CPU in the =
case
> +	  of KVM).
> +
> endif # FSL_SOC_BOOKE
>=20
> config TQM85xx
> diff --git a/arch/powerpc/platforms/85xx/Makefile =
b/arch/powerpc/platforms/85xx/Makefile
> index 2125d4c..f841ac8 100644
> --- a/arch/powerpc/platforms/85xx/Makefile
> +++ b/arch/powerpc/platforms/85xx/Makefile
> @@ -28,3 +28,4 @@ obj-$(CONFIG_SOCRATES)    +=3D socrates.o =
socrates_fpga_pic.o
> obj-$(CONFIG_KSI8560)	  +=3D ksi8560.o
> obj-$(CONFIG_XES_MPC85xx) +=3D xes_mpc85xx.o
> obj-$(CONFIG_GE_IMP3A)	  +=3D ge_imp3a.o
> +obj-$(CONFIG_PPC_QEMU_E500) +=3D qemu_e500.o
> diff --git a/arch/powerpc/platforms/85xx/qemu_e500.c =
b/arch/powerpc/platforms/85xx/qemu_e500.c
> new file mode 100644
> index 0000000..77c8d5d
> --- /dev/null
> +++ b/arch/powerpc/platforms/85xx/qemu_e500.c
> @@ -0,0 +1,66 @@
> +/*
> + * Paravirt target for a generic QEMU e500 machine
> + *
> + * Copyright 2012 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or =
modify it
> + * under  the terms of  the GNU General  Public License as published =
by the
> + * Free Software Foundation;  either version 2 of the  License, or =
(at your
> + * option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/of_fdt.h>
> +#include <asm/machdep.h>
> +#include <asm/time.h>
> +#include <asm/udbg.h>
> +#include <asm/mpic.h>
> +#include <sysdev/fsl_soc.h>
> +#include <sysdev/fsl_pci.h>
> +#include "smp.h"
> +#include "mpc85xx.h"
> +
> +void __init qemu_e500_pic_init(void)
> +{
> +	struct mpic *mpic;
> +
> +	mpic =3D mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN | =
MPIC_SINGLE_DEST_CPU,
> +			0, 256, " OpenPIC  ");

Does that mean we're configuring the MPIC regardless of what the guest =
tells us? So the MPIC is a hard requirement. We can't use UIC or XPIC =
with this machine, right? This needs to be documented.

> +
> +	BUG_ON(mpic =3D=3D NULL);
> +	mpic_init(mpic);
> +}
> +
> +static void __init qemu_e500_setup_arch(void)
> +{
> +	ppc_md.progress("qemu_e500_setup_arch()", 0);
> +
> +	fsl_pci_init();
> +	mpc85xx_smp_init();
> +}
> +
> +/*
> + * Called very early, device-tree isn't unflattened
> + */
> +static int __init qemu_e500_probe(void)
> +{
> +	unsigned long root =3D of_get_flat_dt_root();
> +
> +	return !!of_flat_dt_is_compatible(root, "fsl,qemu-e500");

So the machine needs to be compatible "fsl,qemu-e500". Needs =
documentation in the machine spec.

I'm sure you'll find more constraints that appear logical, but really =
should be written down so we have something formal that potentially =
someone not-QEMU or not-Scott could write a machine implementation =
against ;).


Alex
