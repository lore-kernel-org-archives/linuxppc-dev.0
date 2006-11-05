Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DDCFE67C32
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Nov 2006 17:47:32 +1100 (EST)
Subject: Re: [patch 01/16] remove inclusion of asm/processor.h for powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
In-Reply-To: <20061103085249.GC22478@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
	<20061102125624.134898000@localhost.localdomain>
	<1162506020.10630.31.camel@localhost.localdomain>
	<20061103085249.GC22478@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 17:47:28 +1100
Message-Id: <1162709248.28571.215.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-11-03 at 09:52 +0100, Sascha Hauer wrote:
> I Sent a -p0 patch by accident, forget the last one.
> 
> There is some PPC_CHRP specific code in drivers/ide/pci/via82cxxx.c,
> so #ifdef on CONFIG_PPC_CHRP instead of CONFIG_PPC_MULTIPLATFORM.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Index: drivers/ide/pci/via82cxxx.c
> ===================================================================
> --- a/drivers/ide/pci/via82cxxx.c.orig
> +++ b/drivers/ide/pci/via82cxxx.c
> @@ -35,7 +35,7 @@
>  #include <linux/ide.h>
>  #include <asm/io.h>
>  
> -#ifdef CONFIG_PPC_MULTIPLATFORM
> +#ifdef CONFIG_PPC_CHRP
>  #include <asm/processor.h>
>  #endif
>  
> @@ -442,7 +442,7 @@ static void __devinit init_hwif_via82cxx
>  	hwif->speedproc = &via_set_drive;
>  
> 
> -#if defined(CONFIG_PPC_CHRP) && defined(CONFIG_PPC32)
> +#ifdef CONFIG_PPC_CHRP
>  	if(machine_is(chrp) && _chrp_type == _CHRP_Pegasos) {
>  		hwif->irq = hwif->channel ? 15 : 14;
>  	}
> 
> 
> 
