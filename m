Return-Path: <B29397@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 92E912C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2013 20:28:50 +1100 (EST)
Date: Thu, 17 Jan 2013 17:28:30 +0800
From: Peter Chen <peter.chen@freescale.com>
To: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v5 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
Message-ID: <20130117092829.GA8251@nchen-desktop>
References: <1358216975-1404-1-git-send-email-peter.chen@freescale.com>
 <1358216975-1404-2-git-send-email-peter.chen@freescale.com>
 <20130115140344.GB6574@S2101-09.ap.freescale.net>
 <20130116014824.GD16514@nchen-desktop>
 <20130117091422.GF10814@arwen.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130117091422.GF10814@arwen.pp.htv.fi>
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 17, 2013 at 11:14:22AM +0200, Felipe Balbi wrote:
> On Wed, Jan 16, 2013 at 09:48:25AM +0800, Peter Chen wrote:
> > On Tue, Jan 15, 2013 at 10:03:46PM +0800, Shawn Guo wrote:
> > > On Tue, Jan 15, 2013 at 10:29:33AM +0800, Peter Chen wrote:
> > > > As mach/hardware.h is deleted, we need to use platform_device_id to
> > > > differentiate SoCs. Besides, one cpu_is_mx35 is useless as it has
> > > > already used pdata to differentiate runtime
> > > > 
> > > > Meanwhile we update the platform code accordingly.
> > > > 
> > > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > > > ---
> > > >  arch/arm/mach-imx/devices/devices-common.h        |    1 +
> > > >  arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c |   15 ++++---
> > > >  drivers/usb/gadget/fsl_mxc_udc.c                  |   24 +++++-------
> > > >  drivers/usb/gadget/fsl_udc_core.c                 |   42 +++++++++++++--------
> > > >  4 files changed, 45 insertions(+), 37 deletions(-)
> > > 
> > > Since we are splitting the original patch anyway, it's a bit strange
> > > to me that you are mixing arch/arm/mach-imx and drivers/usb/gadget
> > > in this patch.  I'm fine with it, since I assume all the patches to
> > > go via USB tree anyway.
> > > 
> > > > 
> > > > diff --git a/arch/arm/mach-imx/devices/devices-common.h b/arch/arm/mach-imx/devices/devices-common.h
> > > > index 6277baf..9bd5777 100644
> > > > --- a/arch/arm/mach-imx/devices/devices-common.h
> > > > +++ b/arch/arm/mach-imx/devices/devices-common.h
> > > > @@ -63,6 +63,7 @@ struct platform_device *__init imx_add_flexcan(
> > > >  
> > > >  #include <linux/fsl_devices.h>
> > > >  struct imx_fsl_usb2_udc_data {
> > > > +	const char *devid;
> > > >  	resource_size_t iobase;
> > > >  	resource_size_t irq;
> > > >  };
> > > > diff --git a/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c b/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
> > > > index 37e4439..fb527c7 100644
> > > > --- a/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
> > > > +++ b/arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c
> > > > @@ -11,35 +11,36 @@
> > > >  #include "../hardware.h"
> > > >  #include "devices-common.h"
> > > >  
> > > > -#define imx_fsl_usb2_udc_data_entry_single(soc)				\
> > > > +#define imx_fsl_usb2_udc_data_entry_single(soc, _devid)			\
> > > >  	{								\
> > > > +		.devid = _devid,					\
> > > >  		.iobase = soc ## _USB_OTG_BASE_ADDR,			\
> > > >  		.irq = soc ## _INT_USB_OTG,				\
> > > >  	}
> > > >  
> > > >  #ifdef CONFIG_SOC_IMX25
> > > >  const struct imx_fsl_usb2_udc_data imx25_fsl_usb2_udc_data __initconst =
> > > > -	imx_fsl_usb2_udc_data_entry_single(MX25);
> > > > +	imx_fsl_usb2_udc_data_entry_single(MX25, "imx-udc-mx25");
> > > >  #endif /* ifdef CONFIG_SOC_IMX25 */
> > > >  
> > > >  #ifdef CONFIG_SOC_IMX27
> > > >  const struct imx_fsl_usb2_udc_data imx27_fsl_usb2_udc_data __initconst =
> > > > -	imx_fsl_usb2_udc_data_entry_single(MX27);
> > > > +	imx_fsl_usb2_udc_data_entry_single(MX27, "imx-udc-mx27");
> > > >  #endif /* ifdef CONFIG_SOC_IMX27 */
> > > >  
> > > >  #ifdef CONFIG_SOC_IMX31
> > > >  const struct imx_fsl_usb2_udc_data imx31_fsl_usb2_udc_data __initconst =
> > > > -	imx_fsl_usb2_udc_data_entry_single(MX31);
> > > > +	imx_fsl_usb2_udc_data_entry_single(MX31, "imx-udc-mx31");
> > > >  #endif /* ifdef CONFIG_SOC_IMX31 */
> > > >  
> > > >  #ifdef CONFIG_SOC_IMX35
> > > >  const struct imx_fsl_usb2_udc_data imx35_fsl_usb2_udc_data __initconst =
> > > > -	imx_fsl_usb2_udc_data_entry_single(MX35);
> > > > +	imx_fsl_usb2_udc_data_entry_single(MX35, "imx-udc-mx35");
> > > >  #endif /* ifdef CONFIG_SOC_IMX35 */
> > > >  
> > > >  #ifdef CONFIG_SOC_IMX51
> > > >  const struct imx_fsl_usb2_udc_data imx51_fsl_usb2_udc_data __initconst =
> > > > -	imx_fsl_usb2_udc_data_entry_single(MX51);
> > > > +	imx_fsl_usb2_udc_data_entry_single(MX51, "imx-udc-mx51");
> > > >  #endif
> > > >  
> > > >  struct platform_device *__init imx_add_fsl_usb2_udc(
> > > > @@ -57,7 +58,7 @@ struct platform_device *__init imx_add_fsl_usb2_udc(
> > > >  			.flags = IORESOURCE_IRQ,
> > > >  		},
> > > >  	};
> > > > -	return imx_add_platform_device_dmamask("fsl-usb2-udc", -1,
> > > > +	return imx_add_platform_device_dmamask(data->devid, -1,
> > > >  			res, ARRAY_SIZE(res),
> > > >  			pdata, sizeof(*pdata), DMA_BIT_MASK(32));
> > > >  }
> > > 
> > > <snip>
> > > 
> > > > +static const struct platform_device_id fsl_udc_devtype[] = {
> > > > +	{
> > > > +		.name = "imx-udc-mx25",
> > > > +	}, {
> > > > +		.name = "imx-udc-mx27",
> > > > +	}, {
> > > > +		.name = "imx-udc-mx31",
> > > > +	}, {
> > > > +		.name = "imx-udc-mx35",
> > > > +	}, {
> > > > +		.name = "imx-udc-mx51",
> > > > +	}
> > > > +};
> > > 
> > > From what I understand balbi's comment, he dislikes this full list of
> > > device id.  Instead, he prefers to something like below.
> > > 
> > > static const struct platform_device_id fsl_udc_devtype[] = {
> > > 	{
> > > 		.name = "imx-udc-mx27",
> > > 	}, {
> > > 		.name = "imx-udc-mx51",
> > > 	}
> > > };
> > > 
> > > It basically tells that we are handling two type of devices here, one
> > > is imx-udc-mx27 type and the other is imx-udc-mx51 type, with mx25/31/35
> > > completely compatible with mx27 type.  We choose mx27 instead of mx25
> > > to define the type because mx27 Si came out earlier than mx25.  That
> > > said, we generally choose the earlies SoC name to define a particular
> > > version of IP block, since hardware version is mostly unavailable or
> > > unreliable.
> > > 
> > > But that also means in platform code which create the platform_device,
> > > you will need to use name "imx-udc-mx27" for even mx25/31/35.
> > > 
> > > 	imx_fsl_usb2_udc_data_entry_single(MX25, "imx-udc-mx27");
> > > 	imx_fsl_usb2_udc_data_entry_single(MX31, "imx-udc-mx27");
> > > 	imx_fsl_usb2_udc_data_entry_single(MX35, "imx-udc-mx27");
> > > 
> > > Considering this is a piece of code we will not use for any new
> > > hardware, I'm fine with either way.
> > > 
> > > So, balbi, it's all your call to accept the series as it is or ask for
> > > another iteration.
> 
> right :-)
> 
> > Thanks Shawn. Let's see Felipe's comment, nevertheless, I will send v6 patch
> > due to a compile error at mx25
> 
> Shawn is right.

In fact, this driver is just the temp solution, we will use chipidea
in future, so just take all i.mx usb as two kinds of ip are ok.

Do you want me to change like Shawn said, or current version is ok?

> 
> -- 
> balbi



-- 

Best Regards,
Peter Chen
