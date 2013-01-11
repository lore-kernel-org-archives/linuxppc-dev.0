Return-Path: <balbi@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9B3B52C0290
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 23:51:24 +1100 (EST)
Date: Fri, 11 Jan 2013 14:50:59 +0200
From: Felipe Balbi <balbi@ti.com>
To: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH 1/1] usb: fsl-mxc-udc: fix build error due to
 mach/hardware.h
Message-ID: <20130111125059.GA12715@arwen.pp.htv.fi>
References: <1357898188-10540-1-git-send-email-peter.chen@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
In-Reply-To: <1357898188-10540-1-git-send-email-peter.chen@freescale.com>
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 balbi@ti.com, kernel@pengutronix.de, shawn.guo@linaro.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 11, 2013 at 05:56:28PM +0800, Peter Chen wrote:
> It changes the driver to use platform_device_id rather than cpu_is_xxx
> to determine the SoC type, and updates the platform code accordingly.
>=20
> Compile ok at imx_v6_v7_defconfig with CONFIG_USB_FSL_USB2 enable.
> Tested at mx51 bbg board, it works ok after enable phy clock
> (Need another patch to fix this problem)
>=20
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  arch/arm/mach-imx/clk-imx25.c                     |    6 +-
>  arch/arm/mach-imx/clk-imx27.c                     |    6 +-
>  arch/arm/mach-imx/clk-imx31.c                     |    6 +-
>  arch/arm/mach-imx/clk-imx35.c                     |    6 +-
>  arch/arm/mach-imx/clk-imx51-imx53.c               |    6 +-
>  arch/arm/mach-imx/devices/devices-common.h        |    1 +
>  arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c |   15 +++---
>  drivers/usb/gadget/fsl_mxc_udc.c                  |   17 +++----
>  drivers/usb/gadget/fsl_udc_core.c                 |   52 +++++++++++++--=
-----
>  drivers/usb/gadget/fsl_usb2_udc.h                 |   13 ++++--
>  include/linux/fsl_devices.h                       |    8 +++
>  11 files changed, 82 insertions(+), 54 deletions(-)
>=20
> diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
> index b197aa7..67e353d 100644
> --- a/arch/arm/mach-imx/clk-imx25.c
> +++ b/arch/arm/mach-imx/clk-imx25.c
> @@ -254,9 +254,9 @@ int __init mx25_clocks_init(void)
>  	clk_register_clkdev(clk[ipg], "ipg", "mxc-ehci.2");
>  	clk_register_clkdev(clk[usbotg_ahb], "ahb", "mxc-ehci.2");
>  	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.2");
> -	clk_register_clkdev(clk[ipg], "ipg", "fsl-usb2-udc");
> -	clk_register_clkdev(clk[usbotg_ahb], "ahb", "fsl-usb2-udc");
> -	clk_register_clkdev(clk[usb_div], "per", "fsl-usb2-udc");
> +	clk_register_clkdev(clk[ipg], "ipg", "imx-udc-mx25");
> +	clk_register_clkdev(clk[usbotg_ahb], "ahb", "imx-udc-mx25");
> +	clk_register_clkdev(clk[usb_div], "per", "imx-udc-mx25");
>  	clk_register_clkdev(clk[nfc_ipg_per], NULL, "imx25-nand.0");
>  	/* i.mx25 has the i.mx35 type cspi */
>  	clk_register_clkdev(clk[cspi1_ipg], NULL, "imx35-cspi.0");
> diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
> index 4c1d1e4..1ffe3b5 100644
> --- a/arch/arm/mach-imx/clk-imx27.c
> +++ b/arch/arm/mach-imx/clk-imx27.c
> @@ -236,9 +236,9 @@ int __init mx27_clocks_init(unsigned long fref)
>  	clk_register_clkdev(clk[lcdc_ahb_gate], "ahb", "imx21-fb.0");
>  	clk_register_clkdev(clk[csi_ahb_gate], "ahb", "imx27-camera.0");
>  	clk_register_clkdev(clk[per4_gate], "per", "imx27-camera.0");
> -	clk_register_clkdev(clk[usb_div], "per", "fsl-usb2-udc");
> -	clk_register_clkdev(clk[usb_ipg_gate], "ipg", "fsl-usb2-udc");
> -	clk_register_clkdev(clk[usb_ahb_gate], "ahb", "fsl-usb2-udc");
> +	clk_register_clkdev(clk[usb_div], "per", "imx-udc-mx27");
> +	clk_register_clkdev(clk[usb_ipg_gate], "ipg", "imx-udc-mx27");
> +	clk_register_clkdev(clk[usb_ahb_gate], "ahb", "imx-udc-mx27");
>  	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.0");
>  	clk_register_clkdev(clk[usb_ipg_gate], "ipg", "mxc-ehci.0");
>  	clk_register_clkdev(clk[usb_ahb_gate], "ahb", "mxc-ehci.0");
> diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
> index 8be64e0..ef66eaf 100644
> --- a/arch/arm/mach-imx/clk-imx31.c
> +++ b/arch/arm/mach-imx/clk-imx31.c
> @@ -139,9 +139,9 @@ int __init mx31_clocks_init(unsigned long fref)
>  	clk_register_clkdev(clk[usb_div_post], "per", "mxc-ehci.2");
>  	clk_register_clkdev(clk[usb_gate], "ahb", "mxc-ehci.2");
>  	clk_register_clkdev(clk[ipg], "ipg", "mxc-ehci.2");
> -	clk_register_clkdev(clk[usb_div_post], "per", "fsl-usb2-udc");
> -	clk_register_clkdev(clk[usb_gate], "ahb", "fsl-usb2-udc");
> -	clk_register_clkdev(clk[ipg], "ipg", "fsl-usb2-udc");
> +	clk_register_clkdev(clk[usb_div_post], "per", "imx-udc-mx31");
> +	clk_register_clkdev(clk[usb_gate], "ahb", "imx-udc-mx31");
> +	clk_register_clkdev(clk[ipg], "ipg", "imx-udc-mx31");
>  	clk_register_clkdev(clk[csi_gate], NULL, "mx3-camera.0");
>  	/* i.mx31 has the i.mx21 type uart */
>  	clk_register_clkdev(clk[uart1_gate], "per", "imx21-uart.0");
> diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
> index 66f3d65..69fe9c8 100644
> --- a/arch/arm/mach-imx/clk-imx35.c
> +++ b/arch/arm/mach-imx/clk-imx35.c
> @@ -251,9 +251,9 @@ int __init mx35_clocks_init()
>  	clk_register_clkdev(clk[usb_div], "per", "mxc-ehci.2");
>  	clk_register_clkdev(clk[ipg], "ipg", "mxc-ehci.2");
>  	clk_register_clkdev(clk[usbotg_gate], "ahb", "mxc-ehci.2");
> -	clk_register_clkdev(clk[usb_div], "per", "fsl-usb2-udc");
> -	clk_register_clkdev(clk[ipg], "ipg", "fsl-usb2-udc");
> -	clk_register_clkdev(clk[usbotg_gate], "ahb", "fsl-usb2-udc");
> +	clk_register_clkdev(clk[usb_div], "per", "imx-udc-mx35");
> +	clk_register_clkdev(clk[ipg], "ipg", "imx-udc-mx35");
> +	clk_register_clkdev(clk[usbotg_gate], "ahb", "imx-udc-mx35");
>  	clk_register_clkdev(clk[wdog_gate], NULL, "imx2-wdt.0");
>  	clk_register_clkdev(clk[nfc_div], NULL, "imx25-nand.0");
>  	clk_register_clkdev(clk[csi_gate], NULL, "mx3-camera.0");
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-=
imx51-imx53.c
> index 579023f..fb7cb84 100644
> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> @@ -269,9 +269,9 @@ static void __init mx5_clocks_common_init(unsigned lo=
ng rate_ckil,
>  	clk_register_clkdev(clk[usboh3_per_gate], "per", "mxc-ehci.2");
>  	clk_register_clkdev(clk[usboh3_gate], "ipg", "mxc-ehci.2");
>  	clk_register_clkdev(clk[usboh3_gate], "ahb", "mxc-ehci.2");
> -	clk_register_clkdev(clk[usboh3_per_gate], "per", "fsl-usb2-udc");
> -	clk_register_clkdev(clk[usboh3_gate], "ipg", "fsl-usb2-udc");
> -	clk_register_clkdev(clk[usboh3_gate], "ahb", "fsl-usb2-udc");
> +	clk_register_clkdev(clk[usboh3_per_gate], "per", "imx-udc-mx51");
> +	clk_register_clkdev(clk[usboh3_gate], "ipg", "imx-udc-mx51");
> +	clk_register_clkdev(clk[usboh3_gate], "ahb", "imx-udc-mx51");
>  	clk_register_clkdev(clk[nfc_gate], NULL, "imx51-nand");
>  	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.0");
>  	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "imx-ssi.1");
> diff --git a/arch/arm/mach-imx/devices/devices-common.h b/arch/arm/mach-i=
mx/devices/devices-common.h
> index 6277baf..9bd5777 100644
> --- a/arch/arm/mach-imx/devices/devices-common.h
> +++ b/arch/arm/mach-imx/devices/devices-common.h
> @@ -63,6 +63,7 @@ struct platform_device *__init imx_add_flexcan(
> =20
>  #include <linux/fsl_devices.h>
>  struct imx_fsl_usb2_udc_data {
> +	const char *devid;
>  	resource_size_t iobase;
>  	resource_size_t irq;
>  };
> diff --git a/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c b/arch/arm=
/mach-imx/devices/platform-fsl-usb2-udc.c
> index 37e4439..fb527c7 100644
> --- a/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
> +++ b/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
> @@ -11,35 +11,36 @@
>  #include "../hardware.h"
>  #include "devices-common.h"
> =20
> -#define imx_fsl_usb2_udc_data_entry_single(soc)				\
> +#define imx_fsl_usb2_udc_data_entry_single(soc, _devid)			\
>  	{								\
> +		.devid =3D _devid,					\
>  		.iobase =3D soc ## _USB_OTG_BASE_ADDR,			\
>  		.irq =3D soc ## _INT_USB_OTG,				\
>  	}
> =20
>  #ifdef CONFIG_SOC_IMX25
>  const struct imx_fsl_usb2_udc_data imx25_fsl_usb2_udc_data __initconst =
=3D
> -	imx_fsl_usb2_udc_data_entry_single(MX25);
> +	imx_fsl_usb2_udc_data_entry_single(MX25, "imx-udc-mx25");
>  #endif /* ifdef CONFIG_SOC_IMX25 */
> =20
>  #ifdef CONFIG_SOC_IMX27
>  const struct imx_fsl_usb2_udc_data imx27_fsl_usb2_udc_data __initconst =
=3D
> -	imx_fsl_usb2_udc_data_entry_single(MX27);
> +	imx_fsl_usb2_udc_data_entry_single(MX27, "imx-udc-mx27");
>  #endif /* ifdef CONFIG_SOC_IMX27 */
> =20
>  #ifdef CONFIG_SOC_IMX31
>  const struct imx_fsl_usb2_udc_data imx31_fsl_usb2_udc_data __initconst =
=3D
> -	imx_fsl_usb2_udc_data_entry_single(MX31);
> +	imx_fsl_usb2_udc_data_entry_single(MX31, "imx-udc-mx31");
>  #endif /* ifdef CONFIG_SOC_IMX31 */
> =20
>  #ifdef CONFIG_SOC_IMX35
>  const struct imx_fsl_usb2_udc_data imx35_fsl_usb2_udc_data __initconst =
=3D
> -	imx_fsl_usb2_udc_data_entry_single(MX35);
> +	imx_fsl_usb2_udc_data_entry_single(MX35, "imx-udc-mx35");
>  #endif /* ifdef CONFIG_SOC_IMX35 */
> =20
>  #ifdef CONFIG_SOC_IMX51
>  const struct imx_fsl_usb2_udc_data imx51_fsl_usb2_udc_data __initconst =
=3D
> -	imx_fsl_usb2_udc_data_entry_single(MX51);
> +	imx_fsl_usb2_udc_data_entry_single(MX51, "imx-udc-mx51");
>  #endif
> =20
>  struct platform_device *__init imx_add_fsl_usb2_udc(
> @@ -57,7 +58,7 @@ struct platform_device *__init imx_add_fsl_usb2_udc(
>  			.flags =3D IORESOURCE_IRQ,
>  		},
>  	};
> -	return imx_add_platform_device_dmamask("fsl-usb2-udc", -1,
> +	return imx_add_platform_device_dmamask(data->devid, -1,
>  			res, ARRAY_SIZE(res),
>  			pdata, sizeof(*pdata), DMA_BIT_MASK(32));
>  }
> diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mx=
c_udc.c
> index 1b0f086..f313085 100644
> --- a/drivers/usb/gadget/fsl_mxc_udc.c
> +++ b/drivers/usb/gadget/fsl_mxc_udc.c
> @@ -18,8 +18,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
> =20
> -#include <mach/hardware.h>
> -
>  static struct clk *mxc_ahb_clk;
>  static struct clk *mxc_per_clk;
>  static struct clk *mxc_ipg_clk;
> @@ -28,7 +26,7 @@ static struct clk *mxc_ipg_clk;
>  #define USBPHYCTRL_OTGBASE_OFFSET	0x608
>  #define USBPHYCTRL_EVDO			(1 << 23)
> =20
> -int fsl_udc_clk_init(struct platform_device *pdev)
> +int fsl_udc_clk_init(enum fsl_udc_type devtype, struct platform_device *=
pdev)
>  {
>  	struct fsl_usb2_platform_data *pdata;
>  	unsigned long freq;
> @@ -59,7 +57,7 @@ int fsl_udc_clk_init(struct platform_device *pdev)
>  	clk_prepare_enable(mxc_per_clk);
> =20
>  	/* make sure USB_CLK is running at 60 MHz +/- 1000 Hz */
> -	if (!cpu_is_mx51()) {
> +	if (!(devtype =3D=3D IMX51_UDC)) {
>  		freq =3D clk_get_rate(mxc_per_clk);
>  		if (pdata->phy_mode !=3D FSL_USB2_PHY_ULPI &&
>  		    (freq < 59999000 || freq > 60001000)) {
> @@ -79,19 +77,18 @@ eclkrate:
>  	return ret;
>  }
> =20
> -void fsl_udc_clk_finalize(struct platform_device *pdev)
> +void fsl_udc_clk_finalize(enum fsl_udc_type devtype,
> +	struct platform_device *pdev)
>  {
>  	struct fsl_usb2_platform_data *pdata =3D pdev->dev.platform_data;
> -	if (cpu_is_mx35()) {
> +	if (devtype =3D=3D IMX35_UDC) {
>  		unsigned int v;
> =20
>  		/* workaround ENGcm09152 for i.MX35 */
>  		if (pdata->workaround & FLS_USB2_WORKAROUND_ENGCM09152) {
> -			v =3D readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
> -					USBPHYCTRL_OTGBASE_OFFSET));
> +			v =3D readl(pdata->regs + USBPHYCTRL_OTGBASE_OFFSET);
>  			writel(v | USBPHYCTRL_EVDO,
> -				MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
> -					USBPHYCTRL_OTGBASE_OFFSET));
> +				pdata->regs + USBPHYCTRL_OTGBASE_OFFSET);
>  		}
>  	}
> =20
> diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_u=
dc_core.c
> index c19f7f1..9f9005b 100644
> --- a/drivers/usb/gadget/fsl_udc_core.c
> +++ b/drivers/usb/gadget/fsl_udc_core.c
> @@ -41,6 +41,7 @@
>  #include <linux/fsl_devices.h>
>  #include <linux/dmapool.h>
>  #include <linux/delay.h>
> +#include <linux/of_device.h>
> =20
>  #include <asm/byteorder.h>
>  #include <asm/io.h>
> @@ -2438,17 +2439,13 @@ static int __init fsl_udc_probe(struct platform_d=
evice *pdev)
>  	unsigned int i;
>  	u32 dccparams;
> =20
> -	if (strcmp(pdev->name, driver_name)) {
> -		VDBG("Wrong device");
> -		return -ENODEV;
> -	}
> -
>  	udc_controller =3D kzalloc(sizeof(struct fsl_udc), GFP_KERNEL);
>  	if (udc_controller =3D=3D NULL) {
>  		ERR("malloc udc failed\n");
>  		return -ENOMEM;
>  	}
> =20
> +	udc_controller->devtype =3D pdev->id_entry->driver_data;
>  	pdata =3D pdev->dev.platform_data;
>  	udc_controller->pdata =3D pdata;
>  	spin_lock_init(&udc_controller->lock);
> @@ -2505,7 +2502,7 @@ static int __init fsl_udc_probe(struct platform_dev=
ice *pdev)
>  #endif
> =20
>  	/* Initialize USB clocks */
> -	ret =3D fsl_udc_clk_init(pdev);
> +	ret =3D fsl_udc_clk_init(udc_controller->devtype, pdev);
>  	if (ret < 0)
>  		goto err_iounmap_noclk;
> =20
> @@ -2547,7 +2544,7 @@ static int __init fsl_udc_probe(struct platform_dev=
ice *pdev)
>  		dr_controller_setup(udc_controller);
>  	}
> =20
> -	fsl_udc_clk_finalize(pdev);
> +	fsl_udc_clk_finalize(udc_controller->devtype, pdev);
> =20
>  	/* Setup gadget structure */
>  	udc_controller->gadget.ops =3D &fsl_gadget_ops;
> @@ -2756,22 +2753,41 @@ static int fsl_udc_otg_resume(struct device *dev)
> =20
>  	return fsl_udc_resume(NULL);
>  }
> -
>  /*----------------------------------------------------------------------=
---
>  	Register entry point for the peripheral controller driver
>  ------------------------------------------------------------------------=
--*/
> -
> +static struct platform_device_id fsl_udc_devtype[] =3D {

should be const

> +	{
> +		.name =3D "imx-udc-mx25",
> +		.driver_data =3D IMX25_UDC,
> +	}, {
> +		.name =3D "imx-udc-mx27",
> +		.driver_data =3D IMX27_UDC,
> +	}, {
> +		.name =3D "imx-udc-mx31",
> +		.driver_data =3D IMX31_UDC,
> +	}, {
> +		.name =3D "imx-udc-mx35",
> +		.driver_data =3D IMX35_UDC,
> +	}, {
> +		.name =3D "imx-udc-mx51",
> +		.driver_data =3D IMX51_UDC,
> +	}
> +};
> +MODULE_DEVICE_TABLE(platform, fsl_udc_devtype);
>  static struct platform_driver udc_driver =3D {
> -	.remove  =3D __exit_p(fsl_udc_remove),
> +	.remove		=3D __exit_p(fsl_udc_remove),
> +	/* Just for FSL i.mx SoC currently */
> +	.id_table	=3D fsl_udc_devtype,
>  	/* these suspend and resume are not usb suspend and resume */
> -	.suspend =3D fsl_udc_suspend,
> -	.resume  =3D fsl_udc_resume,
> -	.driver  =3D {
> -		.name =3D (char *)driver_name,
> -		.owner =3D THIS_MODULE,
> -		/* udc suspend/resume called from OTG driver */
> -		.suspend =3D fsl_udc_otg_suspend,
> -		.resume  =3D fsl_udc_otg_resume,
> +	.suspend	=3D fsl_udc_suspend,
> +	.resume		=3D fsl_udc_resume,
> +	.driver		=3D {
> +			.name =3D (char *)driver_name,
> +			.owner =3D THIS_MODULE,
> +			/* udc suspend/resume called from OTG driver */
> +			.suspend =3D fsl_udc_otg_suspend,
> +			.resume  =3D fsl_udc_otg_resume,
>  	},
>  };
> =20
> diff --git a/drivers/usb/gadget/fsl_usb2_udc.h b/drivers/usb/gadget/fsl_u=
sb2_udc.h
> index f61a967..bc1f6d0 100644
> --- a/drivers/usb/gadget/fsl_usb2_udc.h
> +++ b/drivers/usb/gadget/fsl_usb2_udc.h
> @@ -505,6 +505,8 @@ struct fsl_udc {
>  	u32 ep0_dir;		/* Endpoint zero direction: can be
>  				   USB_DIR_IN or USB_DIR_OUT */
>  	u8 device_address;	/* Device USB address */
> +	/* devtype for kinds of SoC, only i.mx uses it now */
> +	enum fsl_udc_type devtype;

to me this looks wrong as it will grow forever. Are you sure you don't
have a way to detect the revision in runtime ?

BTW, it looks to me that, in order to remove cpu_is_*() from that
driver, all you have to do is:

diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mxc_=
udc.c
index 1b0f086..f06102d 100644
--- a/drivers/usb/gadget/fsl_mxc_udc.c
+++ b/drivers/usb/gadget/fsl_mxc_udc.c
@@ -18,8 +18,6 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
=20
-#include <mach/hardware.h>
-
 static struct clk *mxc_ahb_clk;
 static struct clk *mxc_per_clk;
 static struct clk *mxc_ipg_clk;
@@ -59,14 +57,12 @@ int fsl_udc_clk_init(struct platform_device *pdev)
 	clk_prepare_enable(mxc_per_clk);
=20
 	/* make sure USB_CLK is running at 60 MHz +/- 1000 Hz */
-	if (!cpu_is_mx51()) {
-		freq =3D clk_get_rate(mxc_per_clk);
-		if (pdata->phy_mode !=3D FSL_USB2_PHY_ULPI &&
-		    (freq < 59999000 || freq > 60001000)) {
-			dev_err(&pdev->dev, "USB_CLK=3D%lu, should be 60MHz\n", freq);
-			ret =3D -EINVAL;
-			goto eclkrate;
-		}
+	freq =3D clk_get_rate(mxc_per_clk);
+	if (pdata->phy_mode !=3D FSL_USB2_PHY_ULPI &&
+			(freq < 59999000 || freq > 60001000)) {
+		dev_err(&pdev->dev, "USB_CLK=3D%lu, should be 60MHz\n", freq);
+		ret =3D -EINVAL;
+		goto eclkrate;
 	}
=20
 	return 0;
@@ -82,17 +78,15 @@ eclkrate:
 void fsl_udc_clk_finalize(struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata =3D pdev->dev.platform_data;
-	if (cpu_is_mx35()) {
-		unsigned int v;
+	unsigned int v;
=20
-		/* workaround ENGcm09152 for i.MX35 */
-		if (pdata->workaround & FLS_USB2_WORKAROUND_ENGCM09152) {
-			v =3D readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
+	/* workaround ENGcm09152 for i.MX35 */
+	if (pdata->workaround & FLS_USB2_WORKAROUND_ENGCM09152) {
+		v =3D readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
 					USBPHYCTRL_OTGBASE_OFFSET));
-			writel(v | USBPHYCTRL_EVDO,
+		writel(v | USBPHYCTRL_EVDO,
 				MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
 					USBPHYCTRL_OTGBASE_OFFSET));
-		}
 	}
=20
 	/* ULPI transceivers don't need usbpll */


The only problem is that you're accessing PHY address space directly
without even ioremap() it first, not to mention that PHY address space
should only be accessed by a PHY (drivers/usb/phy) driver.

All of these details are all fixed in chipidea. More and more I consider
just deleting this driver and forcing you guys to use chipidea.

That whole MX35_IO_ADDRESS() is really wrong. It shouldn't be used
outside of arch/mach-imx/, that's why it sits in a mach/ header.

As I said before, this patch is too big for -rc and is unnecessary
considering patch I wrote above. Note that there is no problems in
checking if ULPI PHY clk is 60MHz on all arches and, for the workaround,
you already have a runtime check.

Shawn, it can be broken down into smaller pieces because you can *FIX
THE COMPILE BREAKAGE* with a very small patch as above (only issue now
is usage of MX32_IO_ADDRESS()).

--=20
balbi

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ8AqzAAoJEIaOsuA1yqRE+iUP/iV0/fvSq04nXR8MIPREJGT8
htVBPWgs8cwDqgiiSgy2ov7eLFAbu9YiRe/+eXrkGeI5QgOg9glYVi+Y/BxRIl5F
htDzqfRE0oWA0zfoAZQfGcItoMavlZEXKLp9WiY9/ngRQ5Z+NQ7b//MqKTjOGGPW
ociLOKTgqHr5qqROx8B/PSK4rkcZYTsSd90/G3YPhv779An2SPp/LB0SneWnlWjd
MBKcK/n0bJD9rLMr9dA7cNu2sPEZ0nuILi2710dHGbce1dq9ykX0bM/z9Fq9N2mw
YqZ5cFXLG76bWIUkDj3DALG5dCiMmz4B156VLl2I4Kn/hfI/uecNAzmh53vurqR1
ECNzyNvOi646t8tb2yQx1eNNd/lqvI3ET2CcD4/s3jFgKYdLZ8JUdVGqy7yp0QNk
R7HV3t//QlqiQHMayRqez61XUxbptoZdwusonNfgaCdrFRbnpWVzU6o9ec2hI56r
m+muBnFYkn7Ka18o23yosd8IjjW8fqwup+4gF6JLmk6KHkMDTxAiES3ggvkkYEsn
6Ce7ceWRxsfxIrSCilr7m66PwjXrCGUInMJoAXUUd4q+IQaaYyi07C+W3a51Sti4
HajJsv7avLvqKrHEtp+1iydHyw3QZ3PBOicv6LfockFFsX14T+5iXs5bLjUTEmkC
oZzZEzPYKDth6orxK4x/
=7mGD
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
