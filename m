Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id AABFBB6EFF
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 18:16:29 +1000 (EST)
Received: by gwj15 with SMTP id 15so1320453gwj.15
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 01:16:28 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1279815922-27198-3-git-send-email-agust@denx.de>
References: <1279815922-27198-1-git-send-email-agust@denx.de>
	<1279815922-27198-3-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 28 Jul 2010 02:16:08 -0600
Message-ID: <AANLkTinSeFWM4bQK+o8nwStd6C-OcxMagC7TjwCBNn1v@mail.gmail.com>
Subject: Re: [PATCH 2/3] USB: add of_platform glue driver for FSL USB DR
	controller
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org, David Brownell <dbrownell@users.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 22, 2010 at 10:25 AM, Anatolij Gustschin <agust@denx.de> wrote:
> The driver creates platform devices based on the information
> from USB nodes in the flat device tree. This is the replacement
> for old arch fsl_soc usb code removed by the previous patch.
> It uses usual of-style binding, available EHCI-HCD and UDC
> drivers can be bound to the created devices. The new of-style
> driver additionaly instantiates USB OTG platform device, as the
> appropriate USB OTG driver will be added soon.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>

Hi Anatolij,

Looks pretty good, but some comments below.

g.

> ---
> =A0drivers/usb/gadget/Kconfig =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/usb/host/Kconfig =A0 =A0 =A0 =A0 | =A0 =A05 +
> =A0drivers/usb/host/Makefile =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/usb/host/fsl-mph-dr-of.c | =A0189 ++++++++++++++++++++++++++++=
++++++++++
> =A04 files changed, 196 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/usb/host/fsl-mph-dr-of.c
>
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index cd27f9b..e15e314 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -158,6 +158,7 @@ config USB_GADGET_FSL_USB2
> =A0 =A0 =A0 =A0boolean "Freescale Highspeed USB DR Peripheral Controller"
> =A0 =A0 =A0 =A0depends on FSL_SOC || ARCH_MXC
> =A0 =A0 =A0 =A0select USB_GADGET_DUALSPEED
> + =A0 =A0 =A0 select USB_FSL_MPH_DR_OF
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0 Some of Freescale PowerPC processors have a High Spee=
d
> =A0 =A0 =A0 =A0 =A0 Dual-Role(DR) USB controller, which supports device m=
ode.
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 2d926ce..6687523 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -112,10 +112,15 @@ config XPS_USB_HCD_XILINX
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0support both high speed and full speed dev=
ices, or high speed
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0devices only.
>
> +config USB_FSL_MPH_DR_OF
> + =A0 =A0 =A0 bool
> + =A0 =A0 =A0 depends on PPC_OF

Drop the depends.  This is selected by USB_EHCI_FSL and
USB_GADGET_FSL_USB2, which are already PPC only.

> +
> =A0config USB_EHCI_FSL
> =A0 =A0 =A0 =A0bool "Support for Freescale on-chip EHCI USB controller"
> =A0 =A0 =A0 =A0depends on USB_EHCI_HCD && FSL_SOC
> =A0 =A0 =A0 =A0select USB_EHCI_ROOT_HUB_TT
> + =A0 =A0 =A0 select USB_FSL_MPH_DR_OF
> =A0 =A0 =A0 =A0---help---
> =A0 =A0 =A0 =A0 =A0Variation of ARC USB block used in some Freescale chip=
s.
>
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index b6315aa..aacbe82 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -33,4 +33,5 @@ obj-$(CONFIG_USB_R8A66597_HCD) =A0 =A0 =A0 =A0+=3D r8a6=
6597-hcd.o
> =A0obj-$(CONFIG_USB_ISP1760_HCD) =A0+=3D isp1760.o
> =A0obj-$(CONFIG_USB_HWA_HCD) =A0 =A0 =A0+=3D hwa-hc.o
> =A0obj-$(CONFIG_USB_IMX21_HCD) =A0 =A0+=3D imx21-hcd.o
> +obj-$(CONFIG_USB_FSL_MPH_DR_OF) =A0 =A0 =A0 =A0+=3D fsl-mph-dr-of.o
>
> diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-=
dr-of.c
> new file mode 100644
> index 0000000..020a939
> --- /dev/null
> +++ b/drivers/usb/host/fsl-mph-dr-of.c
> @@ -0,0 +1,189 @@
> +/*
> + * Setup platform devices needed by the Freescale multi-port host
> + * and/or dual-role USB controller modules based on the description
> + * in flat device tree.
> + *
> + * This program is free software; you can redistribute =A0it and/or modi=
fy it
> + * under =A0the terms of =A0the GNU General =A0Public License as publish=
ed by the
> + * Free Software Foundation; =A0either version 2 of the =A0License, or (=
at your
> + * option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/fsl_devices.h>
> +#include <linux/io.h>
> +#include <linux/of_platform.h>
> +
> +struct fsl_usb2_dev_data {
> + =A0 =A0 =A0 char *dr_mode; =A0 =A0 =A0 =A0 =A0/* controller mode */
> + =A0 =A0 =A0 char *drivers[3]; =A0 =A0 =A0 /* drivers to instantiate for=
 this mode */
> + =A0 =A0 =A0 enum fsl_usb2_operating_modes op_mode; =A0/* operating mode=
 */
> +};
> +
> +struct fsl_usb2_dev_data dr_mode_data[] __devinitdata =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "host",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 { "fsl-ehci", NULL, NULL, },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 FSL_USB2_DR_HOST,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "otg",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 { "fsl-ehci", "fsl-usb2-udc", "fsl-usb2-otg=
", },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 FSL_USB2_DR_OTG,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "periferal",

spelling.  "peripheral"

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 { "fsl-usb2-udc", NULL, NULL, },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 FSL_USB2_DR_DEVICE,
> + =A0 =A0 =A0 },
> +};

Program defensively.  Use the following form:
+ =A0 =A0 =A0 {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .dr_mode =3D "host",
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .drivers =3D { "fsl-ehci", NULL, NULL, },
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .op_mode =3D FSL_USB2_DR_HOST,
+ =A0 =A0 =A0 },

> +
> +struct fsl_usb2_dev_data * __devinit get_dr_mode_data(struct device_node=
 *np)
> +{
> + =A0 =A0 =A0 const unsigned char *prop;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 prop =3D of_get_property(np, "dr_mode", NULL);
> + =A0 =A0 =A0 if (prop) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(dr_mode_data);=
 i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(prop, dr_mode_d=
ata[i].dr_mode))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return &dr_=
mode_data[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }

Print a warning if you get through the loop, but don't match anything.
 That means that dr_mode has a bad value.

> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return &dr_mode_data[0]; /* mode not specified, use host */
> +}
> +
> +static enum fsl_usb2_phy_modes __devinit determine_usb_phy(const char *p=
hy_type)
> +{
> + =A0 =A0 =A0 if (!phy_type)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return FSL_USB2_PHY_NONE;
> + =A0 =A0 =A0 if (!strcasecmp(phy_type, "ulpi"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return FSL_USB2_PHY_ULPI;
> + =A0 =A0 =A0 if (!strcasecmp(phy_type, "utmi"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return FSL_USB2_PHY_UTMI;
> + =A0 =A0 =A0 if (!strcasecmp(phy_type, "utmi_wide"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return FSL_USB2_PHY_UTMI_WIDE;
> + =A0 =A0 =A0 if (!strcasecmp(phy_type, "serial"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return FSL_USB2_PHY_SERIAL;
> +
> + =A0 =A0 =A0 return FSL_USB2_PHY_NONE;
> +}
> +
> +struct platform_device * __devinit
> +fsl_usb2_device_register(struct of_device *ofdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct fsl_usb2_platform=
_data *pdata,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *name, int id=
)

In general, it is better to have the function name on the same line as
the return arguements so that grep shows the relevant info.  Move the
arguments to subsequent lines.

> +{
> + =A0 =A0 =A0 struct platform_device *pdev;
> + =A0 =A0 =A0 const struct resource *res =3D ofdev->resource;
> + =A0 =A0 =A0 unsigned int num =3D ofdev->num_resources;
> + =A0 =A0 =A0 int retval;
> +
> + =A0 =A0 =A0 pdev =3D platform_device_alloc(name, id);
> + =A0 =A0 =A0 if (!pdev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pdev->dev.parent =3D &ofdev->dev;

Good!  The sub-devices show up sanely in the device hierarchy by
setting the parent pointer.

> +
> + =A0 =A0 =A0 pdev->dev.coherent_dma_mask =3D ofdev->dev.coherent_dma_mas=
k;
> + =A0 =A0 =A0 pdev->dev.dma_mask =3D &pdev->archdata.dma_mask;
> + =A0 =A0 =A0 *pdev->dev.dma_mask =3D *ofdev->dev.dma_mask;
> +
> + =A0 =A0 =A0 retval =3D platform_device_add_data(pdev, pdata, sizeof(*pd=
ata));
> + =A0 =A0 =A0 if (retval)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> +
> + =A0 =A0 =A0 if (num) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D platform_device_add_resources(pd=
ev, res, num);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 retval =3D platform_device_add(pdev);
> + =A0 =A0 =A0 if (retval)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> +
> + =A0 =A0 =A0 return pdev;
> +
> +error:
> + =A0 =A0 =A0 platform_device_put(pdev);
> + =A0 =A0 =A0 return ERR_PTR(retval);
> +}
> +
> +static int __devinit fsl_usb2_mph_dr_of_probe(struct of_device *ofdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0const struct of_device_id *match)
> +{
> + =A0 =A0 =A0 struct device_node *np =3D ofdev->dev.of_node;
> + =A0 =A0 =A0 struct platform_device *usb_dev;
> + =A0 =A0 =A0 struct fsl_usb2_platform_data data, *pdata;
> + =A0 =A0 =A0 struct fsl_usb2_dev_data *dev_data;
> + =A0 =A0 =A0 const unsigned char *prop;
> + =A0 =A0 =A0 static unsigned int idx;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 if (!of_device_is_available(np))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;

What is this for?

> +
> + =A0 =A0 =A0 pdata =3D match->data;
> + =A0 =A0 =A0 if (!pdata) {

The match table doesn't have any data, so this is a no-op.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(&data, 0, sizeof(data));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D &data;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev_data =3D get_dr_mode_data(np);
> +
> + =A0 =A0 =A0 if (of_device_is_compatible(np, "fsl-usb2-mph")) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prop =3D of_get_property(np, "port0", NULL)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prop)

if (of_get_property())

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->port_enables |=3D FS=
L_USB2_PORT0_ENABLED;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prop =3D of_get_property(np, "port1", NULL)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prop)

Ditto

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->port_enables |=3D FS=
L_USB2_PORT1_ENABLED;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->operating_mode =3D FSL_USB2_MPH_HOST=
;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* setup mode selected in the device tree *=
/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->operating_mode =3D dev_data->op_mode=
;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 prop =3D of_get_property(np, "phy_type", NULL);
> + =A0 =A0 =A0 pdata->phy_mode =3D determine_usb_phy(prop);
> +
> + =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(dev_data->drivers); i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!dev_data->drivers[i])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_dev =3D fsl_usb2_device_register(ofdev,=
 pdata,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 dev_data->drivers[i], idx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(usb_dev)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&ofdev->dev, "Can't=
 register usb device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(usb_dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 idx++;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static const struct of_device_id fsl_usb2_mph_dr_of_match[] =3D {
> + =A0 =A0 =A0 { .compatible =3D "fsl-usb2-mph", },
> + =A0 =A0 =A0 { .compatible =3D "fsl-usb2-dr", },
> + =A0 =A0 =A0 {},
> +};
> +
> +static struct of_platform_driver fsl_usb2_mph_dr_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "fsl-usb2-mph-dr",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D fsl_usb2_mph_dr_of_matc=
h,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .probe =A0=3D fsl_usb2_mph_dr_of_probe,
> +};

No remove hook?

> +
> +static int __init fsl_usb2_mph_dr_init(void)
> +{
> + =A0 =A0 =A0 return of_register_platform_driver(&fsl_usb2_mph_dr_driver)=
;
> +}
> +fs_initcall(fsl_usb2_mph_dr_init);

Why fs_initcall?  Is module_init() not sufficient?

> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
