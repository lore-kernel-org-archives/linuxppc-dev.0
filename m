Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E5B04B712C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 16:15:21 +1000 (EST)
Received: from mail-yx0-f199.google.com (mail-yx0-f199.google.com
	[209.85.210.199]) by ozlabs.org (Postfix) with ESMTP id 3FA73DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 16:15:19 +1000 (EST)
Received: by yxe37 with SMTP id 37so85256yxe.17
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 23:15:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1244751543-21977-1-git-send-email-wd@denx.de>
References: <fa686aa40906080737h64bad3cfv32155e5b819d650b@mail.gmail.com>
	<1244751543-21977-1-git-send-email-wd@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 17 Jun 2009 00:14:56 -0600
Message-ID: <fa686aa40906162314p3e308bc4j2420a5f5570d5ae@mail.gmail.com>
Subject: Re: [PATCH] mpc5xxx_get_bus_frequency(): use common code on MPC512x
	and MPC52xx
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 11, 2009 at 2:19 PM, Wolfgang Denk<wd@denx.de> wrote:
> So far, MPC512x used mpc512x_find_ips_freq() to get the bus frequency,
> while MPC52xx used mpc52xx_find_ipb_freq(). =A0Despite the different
> clock names (IPS vs. IPB) the code was identical.
>
> Use common code for both processor families.
>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Kumar Gala <galak@kernel.crashing.org>

You probably already know this, but this patch doesn't apply against
mainline, so I won't merge for 2.6.31.

g.

> ---
>
> This patch is not only intended to avoid code duplication, but it
> will be needed in a following patch that fixes a MII speed
> miscalculation in drivers/net/fs_enet/mii-fec.c - this patch allows
> for a clean solution that works both on MPC512x and MPC52x systems.
>
> =A0arch/powerpc/include/asm/mpc512x.h =A0 =A0 =A0 =A0 =A0 | =A0 22 ------=
-----------
> =A0arch/powerpc/include/asm/mpc52xx.h =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0arch/powerpc/include/asm/mpc5xxx.h =A0 =A0 =A0 =A0 =A0 | =A0 22 ++++++=
+++++++++++
> =A0arch/powerpc/platforms/512x/clock.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0arch/powerpc/platforms/512x/mpc512x.h =A0 =A0 =A0 =A0| =A0 =A01 -
> =A0arch/powerpc/platforms/512x/mpc512x_shared.c | =A0 23 ----------------=
--
> =A0arch/powerpc/platforms/52xx/mpc52xx_common.c | =A0 32 +---------------=
---------
> =A0arch/powerpc/sysdev/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
3 ++
> =A0arch/powerpc/sysdev/mpc5xxx_clocks.c =A0 =A0 =A0 =A0 | =A0 33 ++++++++=
++++++++++++++++++
> =A0drivers/ata/pata_mpc52xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A02 +-
> =A0drivers/i2c/busses/i2c-mpc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
2 +-
> =A0drivers/net/fec_mpc52xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A02 +-
> =A0drivers/net/fec_mpc52xx_phy.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +-
> =A0drivers/serial/mpc52xx_uart.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
5 +--
> =A0drivers/watchdog/mpc5200_wdt.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 =
+-
> =A015 files changed, 68 insertions(+), 87 deletions(-)
> =A0delete mode 100644 arch/powerpc/include/asm/mpc512x.h
> =A0create mode 100644 arch/powerpc/include/asm/mpc5xxx.h
> =A0create mode 100644 arch/powerpc/sysdev/mpc5xxx_clocks.c
>
> diff --git a/arch/powerpc/include/asm/mpc512x.h b/arch/powerpc/include/as=
m/mpc512x.h
> deleted file mode 100644
> index c48a165..0000000
> --- a/arch/powerpc/include/asm/mpc512x.h
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -/*
> - * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
> - *
> - * Author: John Rigby, <jrigby@freescale.com>, Friday Apr 13 2007
> - *
> - * Description:
> - * MPC5121 Prototypes and definitions
> - *
> - * This is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - */
> -
> -#ifndef __ASM_POWERPC_MPC512x_H__
> -#define __ASM_POWERPC_MPC512x_H__
> -
> -extern unsigned long mpc512x_find_ips_freq(struct device_node *node);
> -
> -#endif /* __ASM_POWERPC_MPC512x_H__ */
> -
> diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/as=
m/mpc52xx.h
> index 52e049c..1b4f697 100644
> --- a/arch/powerpc/include/asm/mpc52xx.h
> +++ b/arch/powerpc/include/asm/mpc52xx.h
> @@ -16,6 +16,7 @@
> =A0#ifndef __ASSEMBLY__
> =A0#include <asm/types.h>
> =A0#include <asm/prom.h>
> +#include <asm/mpc5xxx.h>
> =A0#endif /* __ASSEMBLY__ */
>
> =A0#include <linux/suspend.h>
> @@ -268,7 +269,6 @@ struct mpc52xx_intr {
> =A0#ifndef __ASSEMBLY__
>
> =A0/* mpc52xx_common.c */
> -extern unsigned int mpc52xx_find_ipb_freq(struct device_node *node);
> =A0extern void mpc5200_setup_xlb_arbiter(void);
> =A0extern void mpc52xx_declare_of_platform_devices(void);
> =A0extern void mpc52xx_map_common_devices(void);
> diff --git a/arch/powerpc/include/asm/mpc5xxx.h b/arch/powerpc/include/as=
m/mpc5xxx.h
> new file mode 100644
> index 0000000..5ce9c5f
> --- /dev/null
> +++ b/arch/powerpc/include/asm/mpc5xxx.h
> @@ -0,0 +1,22 @@
> +/*
> + * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
> + *
> + * Author: John Rigby, <jrigby@freescale.com>, Friday Apr 13 2007
> + *
> + * Description:
> + * MPC5xxx Prototypes and definitions
> + *
> + * This is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + */
> +
> +#ifndef __ASM_POWERPC_MPC5xxx_H__
> +#define __ASM_POWERPC_MPC5xxx_H__
> +
> +extern unsigned long mpc5xxx_get_bus_frequency(struct device_node *node)=
;
> +
> +#endif /* __ASM_POWERPC_MPC5xxx_H__ */
> +
> diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platforms=
/512x/clock.c
> index 1bcff94..f4c4c6f 100644
> --- a/arch/powerpc/platforms/512x/clock.c
> +++ b/arch/powerpc/platforms/512x/clock.c
> @@ -24,7 +24,7 @@
> =A0#include <linux/io.h>
>
> =A0#include <linux/of_platform.h>
> -#include <asm/mpc512x.h>
> +#include <asm/mpc5xxx.h>
> =A0#include <asm/clk_interface.h>
>
> =A0#undef CLK_DEBUG
> diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platfor=
ms/512x/mpc512x.h
> index 9c03693..22a5352 100644
> --- a/arch/powerpc/platforms/512x/mpc512x.h
> +++ b/arch/powerpc/platforms/512x/mpc512x.h
> @@ -11,7 +11,6 @@
>
> =A0#ifndef __MPC512X_H__
> =A0#define __MPC512X_H__
> -extern unsigned long mpc512x_find_ips_freq(struct device_node *node);
> =A0extern void __init mpc512x_init_IRQ(void);
> =A0void __init mpc512x_declare_of_platform_devices(void);
> =A0#endif =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* __MPC512X_H_=
_ */
> diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/=
platforms/512x/mpc512x_shared.c
> index d8cd579..434d683 100644
> --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> @@ -24,29 +24,6 @@
>
> =A0#include "mpc512x.h"
>
> -unsigned long
> -mpc512x_find_ips_freq(struct device_node *node)
> -{
> - =A0 =A0 =A0 struct device_node *np;
> - =A0 =A0 =A0 const unsigned int *p_ips_freq =3D NULL;
> -
> - =A0 =A0 =A0 of_node_get(node);
> - =A0 =A0 =A0 while (node) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 p_ips_freq =3D of_get_property(node, "bus-f=
requency", NULL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p_ips_freq)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 np =3D of_get_parent(node);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(node);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 node =3D np;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 if (node)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(node);
> -
> - =A0 =A0 =A0 return p_ips_freq ? *p_ips_freq : 0;
> -}
> -EXPORT_SYMBOL(mpc512x_find_ips_freq);
> -
> =A0void __init mpc512x_init_IRQ(void)
> =A0{
> =A0 =A0 =A0 =A0struct device_node *np;
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/=
platforms/52xx/mpc52xx_common.c
> index 8e3dd5a..a46bad0 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
> @@ -47,36 +47,6 @@ static DEFINE_SPINLOCK(mpc52xx_lock);
> =A0static struct mpc52xx_gpt __iomem *mpc52xx_wdt;
> =A0static struct mpc52xx_cdm __iomem *mpc52xx_cdm;
>
> -/**
> - * =A0 =A0 mpc52xx_find_ipb_freq - Find the IPB bus frequency for a devi=
ce
> - * =A0 =A0 @node: =A0device node
> - *
> - * =A0 =A0 Returns IPB bus frequency, or 0 if the bus frequency cannot b=
e found.
> - */
> -unsigned int
> -mpc52xx_find_ipb_freq(struct device_node *node)
> -{
> - =A0 =A0 =A0 struct device_node *np;
> - =A0 =A0 =A0 const unsigned int *p_ipb_freq =3D NULL;
> -
> - =A0 =A0 =A0 of_node_get(node);
> - =A0 =A0 =A0 while (node) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 p_ipb_freq =3D of_get_property(node, "bus-f=
requency", NULL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p_ipb_freq)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 np =3D of_get_parent(node);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(node);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 node =3D np;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 if (node)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(node);
> -
> - =A0 =A0 =A0 return p_ipb_freq ? *p_ipb_freq : 0;
> -}
> -EXPORT_SYMBOL(mpc52xx_find_ipb_freq);
> -
> -
> =A0/*
> =A0* Configure the XLB arbiter settings to match what Linux expects.
> =A0*/
> @@ -221,7 +191,7 @@ unsigned int mpc52xx_get_xtal_freq(struct device_node=
 *node)
> =A0 =A0 =A0 =A0if (!mpc52xx_cdm)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> - =A0 =A0 =A0 freq =3D mpc52xx_find_ipb_freq(node);
> + =A0 =A0 =A0 freq =3D mpc5xxx_get_bus_frequency(node);
> =A0 =A0 =A0 =A0if (!freq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
> index b33b28a..2a1df88 100644
> --- a/arch/powerpc/sysdev/Makefile
> +++ b/arch/powerpc/sysdev/Makefile
> @@ -47,6 +47,9 @@ obj-$(CONFIG_PPC_DCR) =A0 =A0 =A0 =A0 +=3D dcr.o
> =A0obj-$(CONFIG_8xx) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D mpc8xx_pic.o cpm1.o
> =A0obj-$(CONFIG_UCODE_PATCH) =A0 =A0 =A0+=3D micropatch.o
>
> +obj-$(CONFIG_PPC_MPC512x) =A0 =A0 =A0+=3D mpc5xxx_clocks.o
> +obj-$(CONFIG_PPC_MPC52xx) =A0 =A0 =A0+=3D mpc5xxx_clocks.o
> +
> =A0ifeq ($(CONFIG_SUSPEND),y)
> =A0obj-$(CONFIG_6xx) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D 6xx-suspend.o
> =A0endif
> diff --git a/arch/powerpc/sysdev/mpc5xxx_clocks.c b/arch/powerpc/sysdev/m=
pc5xxx_clocks.c
> new file mode 100644
> index 0000000..34e12f9
> --- /dev/null
> +++ b/arch/powerpc/sysdev/mpc5xxx_clocks.c
> @@ -0,0 +1,33 @@
> +/**
> + * =A0 =A0 mpc5xxx_get_bus_frequency - Find the bus frequency for a devi=
ce
> + * =A0 =A0 @node: =A0device node
> + *
> + * =A0 =A0 Returns bus frequency (IPS on MPC512x, IPB on MPC52xx),
> + * =A0 =A0 or 0 if the bus frequency cannot be found.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/of_platform.h>
> +
> +unsigned int
> +mpc5xxx_get_bus_frequency(struct device_node *node)
> +{
> + =A0 =A0 =A0 struct device_node *np;
> + =A0 =A0 =A0 const unsigned int *p_bus_freq =3D NULL;
> +
> + =A0 =A0 =A0 of_node_get(node);
> + =A0 =A0 =A0 while (node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p_bus_freq =3D of_get_property(node, "bus-f=
requency", NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p_bus_freq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 np =3D of_get_parent(node);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(node);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 node =3D np;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(node);
> +
> + =A0 =A0 =A0 return p_bus_freq ? *p_bus_freq : 0;
> +}
> +EXPORT_SYMBOL(mpc5xxx_get_bus_frequency);
> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
> index 68d27bc..2bc2dbe 100644
> --- a/drivers/ata/pata_mpc52xx.c
> +++ b/drivers/ata/pata_mpc52xx.c
> @@ -694,7 +694,7 @@ mpc52xx_ata_probe(struct of_device *op, const struct =
of_device_id *match)
> =A0 =A0 =A0 =A0struct bcom_task *dmatsk =3D NULL;
>
> =A0 =A0 =A0 =A0/* Get ipb frequency */
> - =A0 =A0 =A0 ipb_freq =3D mpc52xx_find_ipb_freq(op->node);
> + =A0 =A0 =A0 ipb_freq =3D mpc5xxx_get_bus_frequency(op->node);
> =A0 =A0 =A0 =A0if (!ipb_freq) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&op->dev, "could not determine IPB=
 bus frequency\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index dd778d7..d325e86 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -197,7 +197,7 @@ int mpc_i2c_get_fdr_52xx(struct device_node *node, u3=
2 clock, int prescaler)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> =A0 =A0 =A0 =A0/* Determine divider value */
> - =A0 =A0 =A0 divider =3D mpc52xx_find_ipb_freq(node) / clock;
> + =A0 =A0 =A0 divider =3D mpc5xxx_get_bus_frequency(node) / clock;
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * We want to choose an FDR/DFSR that generates an I2C bus=
 speed that
> diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
> index 8bbe7f6..5ddf033 100644
> --- a/drivers/net/fec_mpc52xx.c
> +++ b/drivers/net/fec_mpc52xx.c
> @@ -1006,7 +1006,7 @@ mpc52xx_fec_probe(struct of_device *op, const struc=
t of_device_id *match)
> =A0 =A0 =A0 =A0priv->phy_addr =3D FEC5200_PHYADDR_NONE;
> =A0 =A0 =A0 =A0priv->speed =3D 100;
> =A0 =A0 =A0 =A0priv->duplex =3D DUPLEX_HALF;
> - =A0 =A0 =A0 priv->phy_speed =3D ((mpc52xx_find_ipb_freq(op->node) >> 20=
) / 5) << 1;
> + =A0 =A0 =A0 priv->phy_speed =3D ((mpc5xxx_get_bus_frequency(op->node) >=
> 20) / 5) << 1;
>
> =A0 =A0 =A0 =A0/* the 7-wire property means don't use MII mode */
> =A0 =A0 =A0 =A0if (of_find_property(op->node, "fsl,7-wire-mode", NULL))
> diff --git a/drivers/net/fec_mpc52xx_phy.c b/drivers/net/fec_mpc52xx_phy.=
c
> index dd9bfa4..176e9b8 100644
> --- a/drivers/net/fec_mpc52xx_phy.c
> +++ b/drivers/net/fec_mpc52xx_phy.c
> @@ -120,7 +120,7 @@ static int mpc52xx_fec_mdio_probe(struct of_device *o=
f,
>
> =A0 =A0 =A0 =A0/* set MII speed */
> =A0 =A0 =A0 =A0out_be32(&priv->regs->mii_speed,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((mpc52xx_find_ipb_freq(of->node) >> 20) / =
5) << 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((mpc5xxx_get_bus_frequency(of->node) >> 20=
) / 5) << 1);
>
> =A0 =A0 =A0 =A0err =3D mdiobus_register(bus);
> =A0 =A0 =A0 =A0if (err)
> diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.=
c
> index b3feb61..abbd146 100644
> --- a/drivers/serial/mpc52xx_uart.c
> +++ b/drivers/serial/mpc52xx_uart.c
> @@ -76,7 +76,6 @@
> =A0#include <linux/of_platform.h>
>
> =A0#include <asm/mpc52xx.h>
> -#include <asm/mpc512x.h>
> =A0#include <asm/mpc52xx_psc.h>
>
> =A0#if defined(CONFIG_SERIAL_MPC52xx_CONSOLE) && defined(CONFIG_MAGIC_SYS=
RQ)
> @@ -254,7 +253,7 @@ static unsigned long mpc52xx_getuartclk(void *p)
> =A0 =A0 =A0 =A0 * but the generic serial code assumes 16
> =A0 =A0 =A0 =A0 * so return ipb freq / 2
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 return mpc52xx_find_ipb_freq(p) / 2;
> + =A0 =A0 =A0 return mpc5xxx_get_bus_frequency(p) / 2;
> =A0}
>
> =A0static struct psc_ops mpc52xx_psc_ops =3D {
> @@ -391,7 +390,7 @@ static void mpc512x_psc_cw_restore_ints(struct uart_p=
ort *port)
>
> =A0static unsigned long mpc512x_getuartclk(void *p)
> =A0{
> - =A0 =A0 =A0 return mpc512x_find_ips_freq(p);
> + =A0 =A0 =A0 return mpc5xxx_get_bus_frequency(p);
> =A0}
>
> =A0static struct psc_ops mpc512x_psc_ops =3D {
> diff --git a/drivers/watchdog/mpc5200_wdt.c b/drivers/watchdog/mpc5200_wd=
t.c
> index 465fe36..fa9c47c 100644
> --- a/drivers/watchdog/mpc5200_wdt.c
> +++ b/drivers/watchdog/mpc5200_wdt.c
> @@ -188,7 +188,7 @@ static int mpc5200_wdt_probe(struct of_device *op,
> =A0 =A0 =A0 =A0if (!wdt)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>
> - =A0 =A0 =A0 wdt->ipb_freq =3D mpc52xx_find_ipb_freq(op->node);
> + =A0 =A0 =A0 wdt->ipb_freq =3D mpc5xxx_get_bus_frequency(op->node);
>
> =A0 =A0 =A0 =A0err =3D of_address_to_resource(op->node, 0, &wdt->mem);
> =A0 =A0 =A0 =A0if (err)
> --
> 1.6.0.6
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
