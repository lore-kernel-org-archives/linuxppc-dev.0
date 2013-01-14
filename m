Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D32EA2C008D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 00:11:19 +1100 (EST)
Date: Mon, 14 Jan 2013 13:10:56 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH v3 2/3] usb: fsl_mxc_udc: replace MX35_IO_ADDRESS to
 ioremap
Message-ID: <20130114131056.GB23505@n2100.arm.linux.org.uk>
References: <1358158361-25550-1-git-send-email-peter.chen@freescale.com>
 <1358158361-25550-3-git-send-email-peter.chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358158361-25550-3-git-send-email-peter.chen@freescale.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
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

On Mon, Jan 14, 2013 at 06:12:40PM +0800, Peter Chen wrote:
> @@ -83,15 +84,16 @@ void fsl_udc_clk_finalize(enum fsl_udc_type devtype,
>  	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
>  	if (devtype == IMX35_UDC) {
>  		unsigned int v;
> +		void __iomem *phy_regs = ioremap((unsigned long)pdata->regs +
> +						MX35_USBPHYCTRL_OFFSET, 512);

Consider that ioremap() can fail.
