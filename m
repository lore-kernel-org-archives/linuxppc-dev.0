Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 22083B7BAF
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Nov 2009 16:43:47 +1100 (EST)
Subject: Re: [PATCH] PCI: Fix regression in powerpc MSI-X
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andre Detsch <adetsch@br.ibm.com>
In-Reply-To: <200911041303.19695.adetsch@br.ibm.com>
References: <200911041303.19695.adetsch@br.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Nov 2009 16:43:31 +1100
Message-ID: <1257399811.13611.94.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-11-04 at 13:03 -0200, Andre Detsch wrote:
> Patch f598282f5145036312d90875d0ed5c14b49fd8a7 exposed a problem in
> powerpc MSI-X functionality, making network interfaces such as ixgbe
> and cxgb3 stop to work when MSI-X is enabled. RX interrupts were not
> being generated.
> 
> The problem was caused because MSI irq was not being effectively
> unmasked after device initialization.

Patch is wrapped...

Ben.

> Signed-off-by: Andre Detsch <adetsch@br.ibm.com>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> 
> Index: linux-2.6/arch/powerpc/platforms/pseries/msi.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/pseries/msi.c	2009-11-04 
> 06:35:39.000000000 -0700
> +++ linux-2.6/arch/powerpc/platforms/pseries/msi.c	2009-11-04 
> 07:23:27.000000000 -0700
> @@ -432,8 +432,6 @@ static int rtas_setup_msi_irqs(struct pc
>  		/* Read config space back so we can restore after reset */
>  		read_msi_msg(virq, &msg);
>  		entry->msg = msg;
> -
> -		unmask_msi_irq(virq);
>  	}
>  
>  	return 0;
> Index: linux-2.6/arch/powerpc/platforms/pseries/xics.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/pseries/xics.c	2009-11-04 
> 06:35:39.000000000 -0700
> +++ linux-2.6/arch/powerpc/platforms/pseries/xics.c	2009-11-04 
> 07:23:27.000000000 -0700
> @@ -18,6 +18,7 @@
>  #include <linux/init.h>
>  #include <linux/radix-tree.h>
>  #include <linux/cpu.h>
> +#include <linux/msi.h>
>  #include <linux/of.h>
>  
>  #include <asm/firmware.h>
> @@ -219,6 +220,14 @@ static void xics_unmask_irq(unsigned int
>  
>  static unsigned int xics_startup(unsigned int virq)
>  {
> +	/*
> +	 * The generic MSI code returns with the interrupt disabled on the
> +	 * card, using the MSI mask bits. Firmware doesn't appear to unmask
> +	 * at that level, so we do it here by hand.
> +	 */
> +	if (irq_to_desc(virq)->msi_desc)
> +		unmask_msi_irq(virq);
> +
>  	/* unmask it */
>  	xics_unmask_irq(virq);
>  	return 0;
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
