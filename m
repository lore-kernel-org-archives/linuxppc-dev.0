Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f204.google.com (mail-iw0-f204.google.com
	[209.85.223.204]) by ozlabs.org (Postfix) with ESMTP id 01EAAB7CDB
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2010 04:43:55 +1100 (EST)
Received: by iwn42 with SMTP id 42so207362iwn.9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jan 2010 09:43:54 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1263932653-3634-9-git-send-email-agust@denx.de>
References: <1263932653-3634-1-git-send-email-agust@denx.de>
	<1263932653-3634-9-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 21 Jan 2010 10:43:34 -0700
Message-ID: <fa686aa41001210943i3739f693uecf0c05ef0a81c1@mail.gmail.com>
Subject: Re: [PATCH 08/11] powerpc/mpc5121: add USB host support
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: wd@denx.de, dzu@denx.de,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Bruce Schmid <duck@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 19, 2010 at 1:24 PM, Anatolij Gustschin <agust@denx.de> wrote:
> Platform specific code for MPC5121 USB Host support.
> MPC5121 Rev 2.0 silicon EHCI registers are big endian.
> Add appropriate support by specifying "big-endian-regs"
> property in device tree node for USB controller. Also
> allow specifying DRVVBUS and PWR_FAULT signal polarity
> of MPC5121 internal PHY using "invert-drvvbus" and
> "invert-pwr-fault" properties.
>
> Signed-off-by: Bruce Schmid <duck@freescale.com>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: linux-usb@vger.kernel.org
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
> Note that EHCI FSL driver extention in this patch
> applies on top of the following two patches (in the
> linux-next tree):
>
> commit 23c3314b88f91db51bd198ed92e34cffb67788dd
> Author: Anton Vorontsov <avorontsov@ru.mvista.com>
> Date: =A0 Mon Dec 14 18:41:12 2009 +0300
>
> =A0 =A0USB: ehci-fsl: Add power management support
>
> commit bf4bf2d9f646eb0cc531d213a13ffcedf9d6785f
> Author: Anton Vorontsov <avorontsov@ru.mvista.com>
> Date: =A0 Mon Dec 14 18:41:05 2009 +0300
>
> =A0 =A0USB: ehci-fsl: Fix sparse warnings
>
> =A0Documentation/powerpc/dts-bindings/fsl/usb.txt | =A0 =A08 ++
> =A0arch/powerpc/platforms/512x/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A06 =
+
> =A0arch/powerpc/platforms/512x/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0arch/powerpc/platforms/512x/mpc5121_ads.c =A0 =A0 =A0| =A0 =A01 +
> =A0arch/powerpc/platforms/512x/mpc5121_usb.c =A0 =A0 =A0| =A0117 ++++++++=
++++++++++++++++
> =A0arch/powerpc/platforms/512x/mpc512x.h =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0arch/powerpc/sysdev/fsl_soc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 10 ++
> =A0arch/powerpc/sysdev/fsl_soc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A09 ++
> =A0drivers/usb/host/ehci-fsl.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0116 +++++++++++++++++-------
> =A0drivers/usb/host/ehci-fsl.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 19 ++++-
> =A0drivers/usb/host/ehci-mem.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A02 +-
> =A0include/linux/fsl_devices.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 10 ++
> =A012 files changed, 265 insertions(+), 36 deletions(-)
> =A0create mode 100644 arch/powerpc/platforms/512x/mpc5121_usb.c
>
> diff --git a/Documentation/powerpc/dts-bindings/fsl/usb.txt b/Documentati=
on/powerpc/dts-bindings/fsl/usb.txt
> index b001524..9050154 100644
> --- a/Documentation/powerpc/dts-bindings/fsl/usb.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/usb.txt
> @@ -33,6 +33,14 @@ Recommended properties :
> =A0- interrupt-parent : the phandle for the interrupt controller that
> =A0 =A0services interrupts for this device.
>
> +Optional properties :

> + - big-endian-regs : boolean; if defined, indicates the USB host
> + =A0 controller registers format is big endian.

Rather than testing for this explicitly, add fsl,mpc5121-usb2-dr to
the match table and use the .data pointer for setting device specific
quirks.

> + - invert-drvvbus : boolean; for MPC5121 only. Indicates the port
> + =A0 power polarity of internal PHY signal DRVVBUS is inverted.
> + - invert-pwr-fault : boolean; for MPC5121 only. Indicates the
> + =A0 PWR_FAULT signal polarity is inverted.

These are also characteristics of the chip, not the board, right?  If
so then these also can be determined implicitly by the compatible
value.

Finally, these are all freescale specific properties.  If you still
need them, then prefix the property names with 'fsl,'

> +
> =A0Example multi port host USB controller device node :
> =A0 =A0 =A0 =A0usb@22000 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl-usb2-mph";
> diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms=
/512x/Kconfig
> index 4dac9b0..3fec738 100644
> --- a/arch/powerpc/platforms/512x/Kconfig
> +++ b/arch/powerpc/platforms/512x/Kconfig
> @@ -9,6 +9,9 @@ config PPC_MPC512x
> =A0config PPC_MPC5121
> =A0 =A0 =A0 =A0bool
> =A0 =A0 =A0 =A0select PPC_MPC512x
> + =A0 =A0 =A0 select USB_ARCH_HAS_EHCI
> + =A0 =A0 =A0 select USB_EHCI_BIG_ENDIAN_DESC
> + =A0 =A0 =A0 select USB_EHCI_BIG_ENDIAN_MMIO
>
> =A0config MPC5121_ADS
> =A0 =A0 =A0 =A0bool "Freescale MPC5121E ADS"
> @@ -30,3 +33,6 @@ config MPC5121_GENERIC
>
> =A0 =A0 =A0 =A0 =A0Compatible boards include: =A0Protonic LVT base boards=
 (ZANMCU
> =A0 =A0 =A0 =A0 =A0and VICVT2).
> +
> +config USB_FSL_BIG_ENDIAN_MMIO
> + =A0 =A0 =A0 bool

What's this for?

> diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platform=
s/512x/Makefile
> index 90be2f5..49adabc 100644
> --- a/arch/powerpc/platforms/512x/Makefile
> +++ b/arch/powerpc/platforms/512x/Makefile
> @@ -1,6 +1,6 @@
> =A0#
> =A0# Makefile for the Freescale PowerPC 512x linux kernel.
> =A0#
> -obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D clock.o mp=
c512x_shared.o
> +obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D clock.o mp=
c512x_shared.o mpc5121_usb.o
> =A0obj-$(CONFIG_MPC5121_ADS) =A0 =A0 =A0+=3D mpc5121_ads.o mpc5121_ads_cp=
ld.o
> =A0obj-$(CONFIG_MPC5121_GENERIC) =A0+=3D mpc5121_generic.o
> diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/pla=
tforms/512x/mpc5121_ads.c
> index 2f40404..a497c14 100644
> --- a/arch/powerpc/platforms/512x/mpc5121_ads.c
> +++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
> @@ -42,6 +42,7 @@ static void __init mpc5121_ads_setup_arch(void)
> =A0 =A0 =A0 =A0for_each_compatible_node(np, "pci", "fsl,mpc5121-pci")
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpc83xx_add_bridge(np);
> =A0#endif
> + =A0 =A0 =A0 mpc5121_usb_init();
> =A0}
>
> =A0static void __init mpc5121_ads_init_IRQ(void)
> diff --git a/arch/powerpc/platforms/512x/mpc5121_usb.c b/arch/powerpc/pla=
tforms/512x/mpc5121_usb.c
> new file mode 100644
> index 0000000..7b45651
> --- /dev/null
> +++ b/arch/powerpc/platforms/512x/mpc5121_usb.c
> @@ -0,0 +1,117 @@
> +/*
> + * Copyright (C) 2007,2008 Freescale Semiconductor, Inc. All rights rese=
rved.
> + *
> + * Author: Bruce Schmid <duck@freescale.com>, Tue Oct 2 2007
> + *
> + * Description:
> + * MPC5121 USB platform-specific routines
> + *
> + * This is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/fsl_devices.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/stddef.h>
> +#include <linux/of_platform.h>
> +#include <sysdev/fsl_soc.h>
> +
> +#define USBGENCTRL =A0 =A0 =A0 =A0 =A0 =A0 0x200 =A0 =A0 =A0 =A0 =A0 /* =
NOTE: big endian */
> +#define GC_WU_INT_CLR =A0 =A0 =A0 =A0 =A0(1 << 5) =A0 =A0 =A0 =A0/* Wake=
up int clear */
> +#define GC_ULPI_SEL =A0 =A0 =A0 =A0 =A0 =A0(1 << 4) =A0 =A0 =A0 =A0/* UL=
PI i/f select (usb0 only)*/
> +#define GC_PPP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 3) =A0 =A0 =A0 =A0/=
* Inv. Port Power Polarity */
> +#define GC_PFP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 2) =A0 =A0 =A0 =A0/=
* Inv. Power Fault Polarity */
> +#define GC_WU_ULPI_EN =A0 =A0 =A0 =A0 =A0(1 << 1) =A0 =A0 =A0 =A0/* Wake=
up on ULPI event */
> +#define GC_WU_IE =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 1) =A0 =A0 =A0 =A0/* =
Wakeup interrupt enable */
> +
> +#define ISIPHYCTRL =A0 =A0 =A0 =A0 =A0 =A0 0x204 =A0 =A0 =A0 =A0 =A0 /* =
NOTE: big endian */
> +#define PHYCTRL_PHYE =A0 =A0 =A0 =A0 =A0 (1 << 4) =A0 =A0 =A0 =A0/* On-c=
hip UTMI PHY enable */
> +#define PHYCTRL_BSENH =A0 =A0 =A0 =A0 =A0(1 << 3) =A0 =A0 =A0 =A0/* Bit =
Stuff Enable High */
> +#define PHYCTRL_BSEN =A0 =A0 =A0 =A0 =A0 (1 << 2) =A0 =A0 =A0 =A0/* Bit =
Stuff Enable */
> +#define PHYCTRL_LSFE =A0 =A0 =A0 =A0 =A0 (1 << 1) =A0 =A0 =A0 =A0/* Line=
 State Filter Enable */
> +#define PHYCTRL_PXE =A0 =A0 =A0 =A0 =A0 =A0(1 << 0) =A0 =A0 =A0 =A0/* PH=
Y oscillator enable */
> +
> +static struct clk *dr_clk1;
> +static struct clk *dr_clk2;
> +static int dr_used;
> +
> +static int mpc5121_usb_dr_init(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct fsl_usb2_platform_data *pdata =3D pdev->dev.platform=
_data;
> +
> + =A0 =A0 =A0 /* enable the clock if we haven't already */
> + =A0 =A0 =A0 if (!dr_used) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dr_clk1 =3D clk_get(&pdev->dev, "usb1_clk")=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(dr_clk1)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "usb1: =
clk_get failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(dr_clk1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dr_clk2 =3D clk_get(&pdev->dev, "usb2_clk")=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(dr_clk2)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "usb2: =
clk_get failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(dr_clk2);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 dr_used++;
> +
> + =A0 =A0 =A0 pdata->big_endian_desc =3D 1;
> + =A0 =A0 =A0 pdata->es =3D 1;
> +
> + =A0 =A0 =A0 if (pdata->phy_mode =3D=3D FSL_USB2_PHY_UTMI_WIDE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_node *np;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 reg =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 np =3D of_find_compatible_node(NULL, NULL, =
"fsl,mpc5121-usb2-dr");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("No USB node found\n=
");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_get_property(np, "invert-drvvbus", N=
ULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D GC_PPP;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_get_property(np, "invert-pwr-fault",=
 NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D GC_PFP;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(np);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(pdata->regs + ISIPHYCTRL, PHYCTRL_=
PHYE | PHYCTRL_PXE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(pdata->regs + USBGENCTRL, reg);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void mpc5121_usb_dr_uninit(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct fsl_usb2_platform_data *pdata =3D pdev->dev.platform=
_data;
> +
> + =A0 =A0 =A0 pdata->regs =3D NULL;
> +
> + =A0 =A0 =A0 dr_used--;
> + =A0 =A0 =A0 if (!dr_used) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(dr_clk1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(dr_clk2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(dr_clk1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(dr_clk2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dr_clk1 =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dr_clk2 =3D NULL;
> + =A0 =A0 =A0 }
> +}
> +
> +void mpc5121_usb_init(void)
> +{
> + =A0 =A0 =A0 fsl_platform_usb_ops.init =3D mpc5121_usb_dr_init;
> + =A0 =A0 =A0 fsl_platform_usb_ops.uninit =3D mpc5121_usb_dr_uninit;
> +}

Hmmm... I'm not fond of using the fsl_soc.c stuff instead of
drivers/usb/host/ehci-ppc-of.c, but I understand why you're doing it.
Given the constraints, I guess this is okay, but this USB common code
needs some refactoring (I'm not asking you to do it).

> diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platfor=
ms/512x/mpc512x.h
> index c38875c..e92a282 100644
> --- a/arch/powerpc/platforms/512x/mpc512x.h
> +++ b/arch/powerpc/platforms/512x/mpc512x.h
> @@ -13,5 +13,6 @@
> =A0#define __MPC512X_H__
> =A0extern void __init mpc512x_init_IRQ(void);
> =A0extern void mpc512x_restart(char *cmd);
> +extern void mpc5121_usb_init(void);
> =A0void __init mpc512x_declare_of_platform_devices(void);
> =A0#endif =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* __MPC512X_H_=
_ */
> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.=
c
> index b91f7ac..19a455d 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -209,6 +209,9 @@ static int __init of_add_fixed_phys(void)
> =A0arch_initcall(of_add_fixed_phys);
> =A0#endif /* CONFIG_FIXED_PHY */
>
> +struct fsl_platform_usb_ops fsl_platform_usb_ops;
> +EXPORT_SYMBOL(fsl_platform_usb_ops);
> +
> =A0static enum fsl_usb2_phy_modes determine_usb_phy(const char *phy_type)
> =A0{
> =A0 =A0 =A0 =A0if (!phy_type)
> @@ -267,6 +270,9 @@ static int __init fsl_usb_of_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (prop)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_data.port_enables |=3D=
 FSL_USB2_PORT1_ENABLED;
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_get_property(np, "big-endian-regs", =
NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_data.big_endian_mmio =
=3D 1;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prop =3D of_get_property(np, "phy_type", N=
ULL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_data.phy_mode =3D determine_usb_phy(pr=
op);
>
> @@ -332,9 +338,13 @@ static int __init fsl_usb_of_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_get_property(np, "big-endian-regs", =
NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_data.big_endian_mmio =
=3D 1;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prop =3D of_get_property(np, "phy_type", N=
ULL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_data.phy_mode =3D determine_usb_phy(pr=
op);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_data.platform_init =3D fsl_platform_usb=
_ops.init;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_data.platform_uninit =3D fsl_platform_u=
sb_ops.uninit;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (usb_dev_dr_host) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_dev_dr_host->dev.coher=
ent_dma_mask =3D 0xffffffffUL;
> diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.=
h
> index 42381bb..19754be 100644
> --- a/arch/powerpc/sysdev/fsl_soc.h
> +++ b/arch/powerpc/sysdev/fsl_soc.h
> @@ -35,5 +35,14 @@ struct platform_diu_data_ops {
> =A0extern struct platform_diu_data_ops diu_ops;
> =A0#endif
>
> +struct platform_device;
> +
> +struct fsl_platform_usb_ops {
> + =A0 =A0 =A0 int (*init)(struct platform_device *);
> + =A0 =A0 =A0 void (*uninit)(struct platform_device *);
> +};
> +
> +extern struct fsl_platform_usb_ops fsl_platform_usb_ops;
> +
> =A0#endif
> =A0#endif
> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> index 0e26aa1..c4ec00c 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -57,7 +57,7 @@ static int usb_hcd_fsl_probe(const struct hc_driver *dr=
iver,
> =A0 =A0 =A0 =A0pr_debug("initializing FSL-SOC USB Controller\n");
>
> =A0 =A0 =A0 =A0/* Need platform data for setup */
> - =A0 =A0 =A0 pdata =3D (struct fsl_usb2_platform_data *)pdev->dev.platfo=
rm_data;
> + =A0 =A0 =A0 pdata =3D pdev->dev.platform_data;
> =A0 =A0 =A0 =A0if (!pdata) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"No platform data for %s.\=
n", dev_name(&pdev->dev));
> @@ -77,14 +77,13 @@ static int usb_hcd_fsl_probe(const struct hc_driver *=
driver,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> - =A0 =A0 =A0 if (!res) {
> + =A0 =A0 =A0 irq =3D platform_get_irq(pdev, 0);
> + =A0 =A0 =A0 if (irq < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Found HC with no IRQ. Che=
ck %s setup!\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_name(&pdev->dev));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 irq =3D res->start;

Put this hunk in a separate patch.

>
> =A0 =A0 =A0 =A0hcd =3D usb_create_hcd(driver, &pdev->dev, dev_name(&pdev-=
>dev));
> =A0 =A0 =A0 =A0if (!hcd) {
> @@ -116,13 +115,39 @@ static int usb_hcd_fsl_probe(const struct hc_driver=
 *driver,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err3;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* Enable USB controller */
> - =A0 =A0 =A0 temp =3D in_be32(hcd->regs + 0x500);
> - =A0 =A0 =A0 out_be32(hcd->regs + 0x500, temp | 0x4);
> + =A0 =A0 =A0 pdata->regs =3D hcd->regs;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* do platform specific init: check the clock, grab/confi=
g pins, etc.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (pdata->platform_init && pdata->platform_init(pdev)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err3;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Check if it is MPC5121 SoC, otherwise set pdata->have_=
sysif_regs
> + =A0 =A0 =A0 =A0* flag for 83xx or 8536 system interface registers.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (pdata->big_endian_mmio)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D in_be32(hcd->regs + FSL_SOC_USB_ID=
);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D in_le32(hcd->regs + FSL_SOC_USB_ID=
);
> +
> + =A0 =A0 =A0 if ((temp & ID_MSK) !=3D (~((temp & NID_MSK) >> 8) & ID_MSK=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->have_sysif_regs =3D 1;
> +
> + =A0 =A0 =A0 /* Enable USB controller, 83xx or 8536 */
> + =A0 =A0 =A0 if (pdata->have_sysif_regs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 setbits32(hcd->regs + FSL_SOC_USB_CTRL, 0x4=
);
>
> =A0 =A0 =A0 =A0/* Set to Host mode */
> - =A0 =A0 =A0 temp =3D in_le32(hcd->regs + 0x1a8);
> - =A0 =A0 =A0 out_le32(hcd->regs + 0x1a8, temp | 0x3);
> + =A0 =A0 =A0 if (pdata->big_endian_mmio) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 setbits32(hcd->regs + FSL_SOC_USB_USBMODE, =
USBMODE_CM_HOST);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clrsetbits_le32(hcd->regs + FSL_SOC_USB_USB=
MODE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USBMODE_CM_=
MASK, USBMODE_CM_HOST);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0retval =3D usb_add_hcd(hcd, irq, IRQF_DISABLED | IRQF_SHAR=
ED);
> =A0 =A0 =A0 =A0if (retval !=3D 0)
> @@ -137,6 +162,8 @@ static int usb_hcd_fsl_probe(const struct hc_driver *=
driver,
> =A0 =A0 =A0 =A0usb_put_hcd(hcd);
> =A0 =A0 =A0 err1:
> =A0 =A0 =A0 =A0dev_err(&pdev->dev, "init %s fail, %d\n", dev_name(&pdev->=
dev), retval);
> + =A0 =A0 =A0 if (pdata->platform_uninit)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->platform_uninit(pdev);
> =A0 =A0 =A0 =A0return retval;
> =A0}
>
> @@ -154,17 +181,30 @@ static int usb_hcd_fsl_probe(const struct hc_driver=
 *driver,
> =A0static void usb_hcd_fsl_remove(struct usb_hcd *hcd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct platfo=
rm_device *pdev)
> =A0{
> + =A0 =A0 =A0 struct fsl_usb2_platform_data *pdata =3D pdev->dev.platform=
_data;
> +
> =A0 =A0 =A0 =A0usb_remove_hcd(hcd);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* do platform specific un-initialization:
> + =A0 =A0 =A0 =A0* release iomux pins, disable clock, etc.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (pdata->platform_uninit)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->platform_uninit(pdev);
> =A0 =A0 =A0 =A0iounmap(hcd->regs);
> =A0 =A0 =A0 =A0release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
> =A0 =A0 =A0 =A0usb_put_hcd(hcd);
> =A0}
>
> -static void mpc83xx_setup_phy(struct ehci_hcd *ehci,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum fsl_usb2_p=
hy_modes phy_mode,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int po=
rt_offset)
> +static void ehci_fsl_setup_phy(struct ehci_hcd *ehci,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum fsl_usb=
2_phy_modes phy_mode,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int=
 port_offset)
> =A0{
> - =A0 =A0 =A0 u32 portsc =3D 0;
> + =A0 =A0 =A0 u32 portsc;
> +
> + =A0 =A0 =A0 portsc =3D ehci_readl(ehci, &ehci->regs->port_status[port_o=
ffset]);
> + =A0 =A0 =A0 portsc &=3D ~(PORT_PTS_MSK | PORT_PTS_PTW);
> +
> =A0 =A0 =A0 =A0switch (phy_mode) {
> =A0 =A0 =A0 =A0case FSL_USB2_PHY_ULPI:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0portsc |=3D PORT_PTS_ULPI;
> @@ -184,20 +224,21 @@ static void mpc83xx_setup_phy(struct ehci_hcd *ehci=
,
> =A0 =A0 =A0 =A0ehci_writel(ehci, portsc, &ehci->regs->port_status[port_of=
fset]);
> =A0}
>
> -static void mpc83xx_usb_setup(struct usb_hcd *hcd)
> +static void ehci_fsl_usb_setup(struct ehci_hcd *ehci)
> =A0{
> - =A0 =A0 =A0 struct ehci_hcd *ehci =3D hcd_to_ehci(hcd);
> + =A0 =A0 =A0 struct usb_hcd *hcd =3D ehci_to_hcd(ehci);
> =A0 =A0 =A0 =A0struct fsl_usb2_platform_data *pdata;
> =A0 =A0 =A0 =A0void __iomem *non_ehci =3D hcd->regs;
> - =A0 =A0 =A0 u32 temp;
> + =A0 =A0 =A0 u32 tmp;
> +
> + =A0 =A0 =A0 pdata =3D hcd->self.controller->platform_data;
>
> - =A0 =A0 =A0 pdata =3D
> - =A0 =A0 =A0 =A0 =A0 (struct fsl_usb2_platform_data *)hcd->self.controll=
er->
> - =A0 =A0 =A0 =A0 =A0 platform_data;
> =A0 =A0 =A0 =A0/* Enable PHY interface in the control reg. */
> - =A0 =A0 =A0 temp =3D in_be32(non_ehci + FSL_SOC_USB_CTRL);
> - =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_CTRL, temp | 0x00000004);
> - =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0000001b);
> + =A0 =A0 =A0 if (pdata->have_sysif_regs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D in_be32(non_ehci + FSL_SOC_USB_CTRL=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_CTRL, tmp |=
 0x00000004);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0=
000001b);
> + =A0 =A0 =A0 }
>
> =A0#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
> =A0 =A0 =A0 =A0/*
> @@ -214,7 +255,7 @@ static void mpc83xx_usb_setup(struct usb_hcd *hcd)
>
> =A0 =A0 =A0 =A0if ((pdata->operating_mode =3D=3D FSL_USB2_DR_HOST) ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(pdata->operating_mode =3D=
=3D FSL_USB2_DR_OTG))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_setup_phy(ehci, pdata->phy_mode, 0)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ehci_fsl_setup_phy(ehci, pdata->phy_mode, 0=
);
>
> =A0 =A0 =A0 =A0if (pdata->operating_mode =3D=3D FSL_USB2_MPH_HOST) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int chip, rev, svr;
> @@ -228,27 +269,31 @@ static void mpc83xx_usb_setup(struct usb_hcd *hcd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ehci->has_fsl_port_bug =3D=
 1;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pdata->port_enables & FSL_USB2_PORT0_E=
NABLED)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_setup_phy(ehci, pda=
ta->phy_mode, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ehci_fsl_setup_phy(ehci, pd=
ata->phy_mode, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pdata->port_enables & FSL_USB2_PORT1_E=
NABLED)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_setup_phy(ehci, pda=
ta->phy_mode, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ehci_fsl_setup_phy(ehci, pd=
ata->phy_mode, 1);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* put controller in host mode. */
> - =A0 =A0 =A0 ehci_writel(ehci, 0x00000003, non_ehci + FSL_SOC_USB_USBMOD=
E);
> + =A0 =A0 =A0 tmp =3D USBMODE_CM_HOST | (pdata->es ? USBMODE_ES : 0);
> + =A0 =A0 =A0 ehci_writel(ehci, tmp, non_ehci + FSL_SOC_USB_USBMODE);
> +
> + =A0 =A0 =A0 if (pdata->have_sysif_regs) {
> =A0#ifdef CONFIG_PPC_85xx
> - =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_PRICTRL, 0x00000008);
> - =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_AGECNTTHRSH, 0x00000080);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_PRICTRL, 0x=
00000008);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_AGECNTTHRSH=
, 0x00000080);
> =A0#else
> - =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_PRICTRL, 0x0000000c);
> - =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_AGECNTTHRSH, 0x00000040);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_PRICTRL, 0x=
0000000c);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_AGECNTTHRSH=
, 0x00000040);
> =A0#endif
> - =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_SICTRL, 0x00000001);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(non_ehci + FSL_SOC_USB_SICTRL, 0x0=
0000001);
> + =A0 =A0 =A0 }
> =A0}

Unrelated whitespace changes.  Put in separate patch.

>
> =A0/* called after powerup, by probe or system-pm "wakeup" */
> =A0static int ehci_fsl_reinit(struct ehci_hcd *ehci)
> =A0{
> - =A0 =A0 =A0 mpc83xx_usb_setup(ehci_to_hcd(ehci));
> + =A0 =A0 =A0 ehci_fsl_usb_setup(ehci);
> =A0 =A0 =A0 =A0ehci_port_power(ehci, 0);
>
> =A0 =A0 =A0 =A0return 0;
> @@ -259,6 +304,11 @@ static int ehci_fsl_setup(struct usb_hcd *hcd)
> =A0{
> =A0 =A0 =A0 =A0struct ehci_hcd *ehci =3D hcd_to_ehci(hcd);
> =A0 =A0 =A0 =A0int retval;
> + =A0 =A0 =A0 struct fsl_usb2_platform_data *pdata;
> +
> + =A0 =A0 =A0 pdata =3D hcd->self.controller->platform_data;
> + =A0 =A0 =A0 ehci->big_endian_desc =3D pdata->big_endian_desc;
> + =A0 =A0 =A0 ehci->big_endian_mmio =3D pdata->big_endian_mmio;
>
> =A0 =A0 =A0 =A0/* EHCI registers start at offset 0x100 */
> =A0 =A0 =A0 =A0ehci->caps =3D hcd->regs + 0x100;
> @@ -369,7 +419,7 @@ static const struct hc_driver ehci_fsl_hc_driver =3D =
{
> =A0 =A0 =A0 =A0 * generic hardware linkage
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0.irq =3D ehci_irq,
> - =A0 =A0 =A0 .flags =3D HCD_USB2,
> + =A0 =A0 =A0 .flags =3D HCD_USB2 | HCD_MEMORY,
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * basic lifecycle operations
> diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
> index b5e59db..3525bb4 100644
> --- a/drivers/usb/host/ehci-fsl.h
> +++ b/drivers/usb/host/ehci-fsl.h
> @@ -1,4 +1,4 @@
> -/* Copyright (c) 2005 freescale semiconductor
> +/* Copyright (C) 2005-2009 Freescale Semiconductor, Inc. All rights rese=
rved.
> =A0* Copyright (c) 2005 MontaVista Software
> =A0*
> =A0* This program is free software; you can redistribute =A0it and/or mod=
ify it
> @@ -19,6 +19,11 @@
> =A0#define _EHCI_FSL_H
>
> =A0/* offsets for the non-ehci registers in the FSL SOC USB controller */
> +#define FSL_SOC_USB_ID =A0 =A0 =A0 =A0 0x0
> +#define ID_MSK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3f
> +#define NID_MSK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x3f00
> +#define FSL_SOC_USB_SBUSCFG =A0 =A00x90
> +#define FSL_SOC_USB_BURSTSIZE =A00x160
> =A0#define FSL_SOC_USB_ULPIVP =A0 =A0 0x170
> =A0#define FSL_SOC_USB_PORTSC1 =A0 =A00x184
> =A0#define PORT_PTS_MSK =A0 =A0 =A0 =A0 =A0 (3<<30)
> @@ -26,8 +31,20 @@
> =A0#define PORT_PTS_ULPI =A0 =A0 =A0 =A0 =A0(2<<30)
> =A0#define =A0 =A0 =A0 =A0PORT_PTS_SERIAL =A0 =A0 =A0 =A0 (3<<30)
> =A0#define PORT_PTS_PTW =A0 =A0 =A0 =A0 =A0 (1<<28)
> +#define PORT_PTS_PHCD =A0 =A0 =A0 =A0 =A0(1<<23)
> =A0#define FSL_SOC_USB_PORTSC2 =A0 =A00x188
> =A0#define FSL_SOC_USB_USBMODE =A0 =A00x1a8
> +#define USBMODE_CM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(3 << 0) =A0 =A0 =
=A0 =A0/* controller mode mask */
> +#define USBMODE_CM_HOST =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(3 << 0) =A0 =A0 =
=A0 =A0/* controller mode: host */
> +#define USBMODE_ES =A0 =A0 =A0 =A0 =A0 =A0 (1 << 2) =A0 =A0 =A0 =A0/* (B=
ig) Endian Select */
> +
> +#define FSL_SOC_USB_USBGENCTRL =A0 =A0 =A0 =A0 0x200
> +#define USBGENCTRL_PPP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 3)
> +#define USBGENCTRL_PFP =A0 =A0 =A0 =A0 (1 << 2)
> +#define FSL_SOC_USB_ISIPHYCTRL 0x204
> +#define ISIPHYCTRL_PXE =A0 =A0 =A0 =A0 (1)
> +#define ISIPHYCTRL_PHYE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 4)
> +
> =A0#define FSL_SOC_USB_SNOOP1 =A0 =A0 0x400 =A0 /* NOTE: big-endian */
> =A0#define FSL_SOC_USB_SNOOP2 =A0 =A0 0x404 =A0 /* NOTE: big-endian */
> =A0#define FSL_SOC_USB_AGECNTTHRSH =A0 =A0 =A0 =A00x408 =A0 /* NOTE: big-=
endian */
> diff --git a/drivers/usb/host/ehci-mem.c b/drivers/usb/host/ehci-mem.c
> index aeda96e..1e7e004 100644
> --- a/drivers/usb/host/ehci-mem.c
> +++ b/drivers/usb/host/ehci-mem.c
> @@ -40,7 +40,7 @@ static inline void ehci_qtd_init(struct ehci_hcd *ehci,=
 struct ehci_qtd *qtd,
> =A0{
> =A0 =A0 =A0 =A0memset (qtd, 0, sizeof *qtd);
> =A0 =A0 =A0 =A0qtd->qtd_dma =3D dma;
> - =A0 =A0 =A0 qtd->hw_token =3D cpu_to_le32 (QTD_STS_HALT);
> + =A0 =A0 =A0 qtd->hw_token =3D cpu_to_hc32(ehci, QTD_STS_HALT);
> =A0 =A0 =A0 =A0qtd->hw_next =3D EHCI_LIST_END(ehci);
> =A0 =A0 =A0 =A0qtd->hw_alt_next =3D EHCI_LIST_END(ehci);
> =A0 =A0 =A0 =A0INIT_LIST_HEAD (&qtd->qtd_list);
> diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
> index 28e33fe..dfe603f 100644
> --- a/include/linux/fsl_devices.h
> +++ b/include/linux/fsl_devices.h
> @@ -58,11 +58,21 @@ enum fsl_usb2_phy_modes {
> =A0 =A0 =A0 =A0FSL_USB2_PHY_SERIAL,
> =A0};
>
> +struct platform_device;
> =A0struct fsl_usb2_platform_data {
> =A0 =A0 =A0 =A0/* board specific information */
> =A0 =A0 =A0 =A0enum fsl_usb2_operating_modes =A0 operating_mode;
> =A0 =A0 =A0 =A0enum fsl_usb2_phy_modes =A0 =A0 =A0 =A0 phy_mode;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port_e=
nables;
> +
> + =A0 =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0*name; =A0 =A0 =A0 =A0 =A0/* pretty print */
> + =A0 =A0 =A0 int (*platform_init) (struct platform_device *);
> + =A0 =A0 =A0 void (*platform_uninit) (struct platform_device *);
> + =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*regs; =
=A0/* ioremap'd register base */
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0big=
_endian_mmio:1;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0big=
_endian_desc:1;
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0es:=
1; =A0 =A0 =A0 =A0 =A0 /* need USBMODE:ES */
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hav=
e_sysif_regs:1;
> =A0};

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
