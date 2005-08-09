Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0143167FE3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 05:03:21 +1000 (EST)
Date: Tue, 9 Aug 2005 12:03:19 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Dale Farnsworth <dale@farnsworth.org>
Message-ID: <20050809190319.GC30956@gate.ebshome.net>
References: <20050809185327.GA19340@xyzzy.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050809185327.GA19340@xyzzy.farnsworth.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATH] ppc32: Add usb support to IBM stb04xxx platforms
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2005 at 11:53:27AM -0700, Dale Farnsworth wrote:
[snip]

> Index: linux-2.5-usb-405/arch/ppc/platforms/4xx/redwood5.c
> ===================================================================
> --- linux-2.5-usb-405.orig/arch/ppc/platforms/4xx/redwood5.c
> +++ linux-2.5-usb-405/arch/ppc/platforms/4xx/redwood5.c
> @@ -52,8 +52,18 @@
>  void __init
>  redwood5_setup_arch(void)
>  {
> +	u32 mask;
> +
>  	ppc4xx_setup_arch();
>  
> +	/*
> +	 * Set up USB interrupt as positive polarity and level-sensitive.
> +	 * Firmware should do this, but apparently does not.
> +	 */
> +	mask = 1 << (31 - USB0_IRQ);
> +	mtdcr(DCRN_UIC_PR(UIC0), mfdcr(DCRN_UIC_PR(UIC0)) | mask);
> +	mtdcr(DCRN_UIC_TR(UIC0), mfdcr(DCRN_UIC_TR(UIC0)) & ~mask);
> +

Please, DO NOT DO THIS. 

There is a way to configure UIC settings without messing with UIC 
registers directly. Refer to asm-ppc/ppc4xx_pic.h and other 4xx board 
ports for more information.

-- 
Eugene
