Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 74F3E67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 11:07:50 +1000 (EST)
Date: Wed, 30 Mar 2005 17:07:47 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Dale Farnsworth <dale@farnsworth.org>
Message-ID: <20050331010747.GA18254@gate.ebshome.net>
References: <20050331000521.GA22041@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050331000521.GA22041@xyzzy>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2.6.10-rc2] ppc32: Add usb support to IBM stb04xxx
	platforms including Redwood5
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Mar 30, 2005 at 05:05:21PM -0700, Dale Farnsworth wrote:

[snip]

> +/* Power up the USB subsection */
> +static int enable_usb(struct platform_device *pdev)
> +{
> +	u32 mask;
> +
> +	mask = 1 << (31 - USB0_IRQ);
> +	mtdcr(DCRN_UIC_PR(UIC0), mfdcr(DCRN_UIC_PR(UIC0)) | mask);
> +	mtdcr(DCRN_UIC_TR(UIC0), mfdcr(DCRN_UIC_TR(UIC0)) & ~mask);
> +	return 0;
> +}
> +
> +/* Power down the USB subsection */
> +static void disable_usb(struct platform_device *pdev)
> +{
> +	u32 mask;
> +
> +	mask = 1 << (31 - USB0_IRQ);
> +	mtdcr(DCRN_UIC_PR(UIC0), mfdcr(DCRN_UIC_PR(UIC0)) & ~mask);
> +	mtdcr(DCRN_UIC_TR(UIC0), mfdcr(DCRN_UIC_TR(UIC0)) | mask);
> +}

Dale, I'm curious, what's going on here :) ?.

How changing polarity and triggering setting could power-down USB 
unit? Some STB funkiness?

--
Eugene
