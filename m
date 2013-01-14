Return-Path: <B29397@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9B5A52C0116
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 15:40:30 +1100 (EST)
Date: Mon, 14 Jan 2013 12:39:11 +0800
From: Peter Chen <peter.chen@freescale.com>
To: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/1] usb: fsl-mxc-udc: fix build error due to
 mach/hardware.h
Message-ID: <20130114043910.GA24585@nchen-desktop>
References: <1357898188-10540-1-git-send-email-peter.chen@freescale.com>
 <20130111125059.GA12715@arwen.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130111125059.GA12715@arwen.pp.htv.fi>
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 kernel@pengutronix.de, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 11, 2013 at 02:50:59PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Fri, Jan 11, 2013 at 05:56:28PM +0800, Peter Chen wrote:
> > It changes the driver to use platform_device_id rather than cpu_is_xxx
> > to determine the SoC type, and updates the platform code accordingly.
> > 
> > Compile ok at imx_v6_v7_defconfig with CONFIG_USB_FSL_USB2 enable.
> > Tested at mx51 bbg board, it works ok after enable phy clock
> > (Need another patch to fix this problem)
> > 
> > -
> > +static struct platform_device_id fsl_udc_devtype[] = {
> 
> should be const
OK.
> 
> > +	{
> > +		.name = "imx-udc-mx25",
> > +		.driver_data = IMX25_UDC,
> > +	}, {
> > +		.name = "imx-udc-mx27",
> > +		.driver_data = IMX27_UDC,
> > +	}, {
> > +		.name = "imx-udc-mx31",
> > +		.driver_data = IMX31_UDC,
> > +	}, {
> > +		.name = "imx-udc-mx35",
> > +		.driver_data = IMX35_UDC,
> > +	}, {
> > +		.name = "imx-udc-mx51",
> > +		.driver_data = IMX51_UDC,
> > +	}
> > +};
> > +MODULE_DEVICE_TABLE(platform, fsl_udc_devtype);
> >  static struct platform_driver udc_driver = {
> > -	.remove  = __exit_p(fsl_udc_remove),
> > +	.remove		= __exit_p(fsl_udc_remove),
> > +	/* Just for FSL i.mx SoC currently */
> > +	.id_table	= fsl_udc_devtype,
> >  	/* these suspend and resume are not usb suspend and resume */
> > -	.suspend = fsl_udc_suspend,
> > -	.resume  = fsl_udc_resume,
> > -	.driver  = {
> > -		.name = (char *)driver_name,
> > -		.owner = THIS_MODULE,
> > -		/* udc suspend/resume called from OTG driver */
> > -		.suspend = fsl_udc_otg_suspend,
> > -		.resume  = fsl_udc_otg_resume,
> > +	.suspend	= fsl_udc_suspend,
> > +	.resume		= fsl_udc_resume,
> > +	.driver		= {
> > +			.name = (char *)driver_name,
> > +			.owner = THIS_MODULE,
> > +			/* udc suspend/resume called from OTG driver */
> > +			.suspend = fsl_udc_otg_suspend,
> > +			.resume  = fsl_udc_otg_resume,
> >  	},
> >  };
> >  
> > diff --git a/drivers/usb/gadget/fsl_usb2_udc.h b/drivers/usb/gadget/fsl_usb2_udc.h
> > index f61a967..bc1f6d0 100644
> > --- a/drivers/usb/gadget/fsl_usb2_udc.h
> > +++ b/drivers/usb/gadget/fsl_usb2_udc.h
> > @@ -505,6 +505,8 @@ struct fsl_udc {
> >  	u32 ep0_dir;		/* Endpoint zero direction: can be
> >  				   USB_DIR_IN or USB_DIR_OUT */
> >  	u8 device_address;	/* Device USB address */
> > +	/* devtype for kinds of SoC, only i.mx uses it now */
> > +	enum fsl_udc_type devtype;
> 
> to me this looks wrong as it will grow forever. Are you sure you don't
> have a way to detect the revision in runtime ?
> 
> BTW, it looks to me that, in order to remove cpu_is_*() from that
> driver, all you have to do is:
> 
> diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mxc_udc.c
> index 1b0f086..f06102d 100644
> --- a/drivers/usb/gadget/fsl_mxc_udc.c
> +++ b/drivers/usb/gadget/fsl_mxc_udc.c
> @@ -18,8 +18,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  
> -#include <mach/hardware.h>
> -
>  static struct clk *mxc_ahb_clk;
>  static struct clk *mxc_per_clk;
>  static struct clk *mxc_ipg_clk;
> @@ -59,14 +57,12 @@ int fsl_udc_clk_init(struct platform_device *pdev)
>  	clk_prepare_enable(mxc_per_clk);
>  
>  	/* make sure USB_CLK is running at 60 MHz +/- 1000 Hz */
> -	if (!cpu_is_mx51()) {
> -		freq = clk_get_rate(mxc_per_clk);
> -		if (pdata->phy_mode != FSL_USB2_PHY_ULPI &&
> -		    (freq < 59999000 || freq > 60001000)) {
> -			dev_err(&pdev->dev, "USB_CLK=%lu, should be 60MHz\n", freq);
> -			ret = -EINVAL;
> -			goto eclkrate;
> -		}
> +	freq = clk_get_rate(mxc_per_clk);
> +	if (pdata->phy_mode != FSL_USB2_PHY_ULPI &&
> +			(freq < 59999000 || freq > 60001000)) {
> +		dev_err(&pdev->dev, "USB_CLK=%lu, should be 60MHz\n", freq);
> +		ret = -EINVAL;
> +		goto eclkrate;
>  	}
For mx51, the otg port, the pdata->phy_mode is FSL_USB2_PHY_UTMI_WIDE,
the freq of "per_clk" is 166250000. So, your patch does not work.
>  
>  	return 0;
> @@ -82,17 +78,15 @@ eclkrate:
>  void fsl_udc_clk_finalize(struct platform_device *pdev)
>  {
>  	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
> -	if (cpu_is_mx35()) {
> -		unsigned int v;
> +	unsigned int v;
>  
> -		/* workaround ENGcm09152 for i.MX35 */
> -		if (pdata->workaround & FLS_USB2_WORKAROUND_ENGCM09152) {
> -			v = readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
> +	/* workaround ENGcm09152 for i.MX35 */
> +	if (pdata->workaround & FLS_USB2_WORKAROUND_ENGCM09152) {
> +		v = readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
>  					USBPHYCTRL_OTGBASE_OFFSET));
> -			writel(v | USBPHYCTRL_EVDO,
> +		writel(v | USBPHYCTRL_EVDO,
>  				MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
>  					USBPHYCTRL_OTGBASE_OFFSET));
> -		}
>  	}
>  
>  	/* ULPI transceivers don't need usbpll */
chipidea's phy interface uses the same register mapping with controller's.
eg, controller register is $BASE, the PHY interface is $BASE + 0x600 or
$BASE + 0x800. So, as a workaround, we can ioremap phy interface 
at fsl_mxc_udc.c, and iounmap after finishing using.

The problem at my code is I have not remapped it before using.
> 
> 
> The only problem is that you're accessing PHY address space directly
> without even ioremap() it first, not to mention that PHY address space
> should only be accessed by a PHY (drivers/usb/phy) driver.
> 
> All of these details are all fixed in chipidea. More and more I consider
> just deleting this driver and forcing you guys to use chipidea.
> 
> That whole MX35_IO_ADDRESS() is really wrong. It shouldn't be used
> outside of arch/mach-imx/, that's why it sits in a mach/ header.
> 
> As I said before, this patch is too big for -rc and is unnecessary
> considering patch I wrote above. Note that there is no problems in
> checking if ULPI PHY clk is 60MHz on all arches and, for the workaround,
> you already have a runtime check.
> 
> Shawn, it can be broken down into smaller pieces because you can *FIX
> THE COMPILE BREAKAGE* with a very small patch as above (only issue now
> is usage of MX32_IO_ADDRESS()).
> 
> -- 
> balbi



-- 

Best Regards,
Peter Chen
