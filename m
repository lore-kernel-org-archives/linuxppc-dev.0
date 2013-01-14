Return-Path: <B29397@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9D3312C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 00:16:40 +1100 (EST)
Date: Mon, 14 Jan 2013 21:16:20 +0800
From: Peter Chen <peter.chen@freescale.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 2/3] usb: fsl_mxc_udc: replace MX35_IO_ADDRESS to
 ioremap
Message-ID: <20130114131619.GC30157@nchen-desktop>
References: <1358158361-25550-1-git-send-email-peter.chen@freescale.com>
 <1358158361-25550-3-git-send-email-peter.chen@freescale.com>
 <20130114131056.GB23505@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130114131056.GB23505@n2100.arm.linux.org.uk>
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 balbi@ti.com, kernel@pengutronix.de, shawn.guo@linaro.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 14, 2013 at 01:10:56PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 14, 2013 at 06:12:40PM +0800, Peter Chen wrote:
> > @@ -83,15 +84,16 @@ void fsl_udc_clk_finalize(enum fsl_udc_type devtype,
> >  	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
> >  	if (devtype == IMX35_UDC) {
> >  		unsigned int v;
> > +		void __iomem *phy_regs = ioremap((unsigned long)pdata->regs +
> > +						MX35_USBPHYCTRL_OFFSET, 512);
> 
> Consider that ioremap() can fail.
> 
Thanks, will check NULL pointer.

-- 

Best Regards,
Peter Chen
