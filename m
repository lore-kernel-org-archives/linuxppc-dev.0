Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B79FB67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Apr 2005 07:08:10 +1000 (EST)
Date: Thu, 31 Mar 2005 13:08:07 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Dale Farnsworth <dale@farnsworth.org>
Message-ID: <20050331210806.GA5694@gate.ebshome.net>
References: <20050331204729.GA29785@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050331204729.GA29785@xyzzy>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2.6.10-rc2] ppc32: Add usb support to IBM stb04xxx
	platforms
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Mar 31, 2005 at 01:47:30PM -0700, Dale Farnsworth wrote:

[snip]

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
>  #ifdef CONFIG_DEBUG_BRINGUP
>  	printk("\n");
>  	printk("machine\t: %s\n", PPC4xx_MACHINE_NAME);

Dale, please, don't mess with UIC registers directly, there is a 
cleaner way to set this up. 

Take a look at how this is done in other 4xx ports
(ppc4xx_core_uic_cfg & ppc4xx_uic_ext_irq_cfg).

--
Eugene
