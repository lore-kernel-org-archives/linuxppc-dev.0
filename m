Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 969B067C88
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 09:20:25 +1100 (EST)
Subject: Re: [patch 01/16] remove inclusion of asm/processor.h for powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: s.hauer@pengutronix.de
In-Reply-To: <20061102125624.134898000@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
	<20061102125624.134898000@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 09:20:20 +1100
Message-Id: <1162506020.10630.31.camel@localhost.localdomain>
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

On Thu, 2006-11-02 at 13:55 +0100, s.hauer@pengutronix.de wrote:
> plain text document attachment
> (drivers-ide-pci-via82xxx-remove-ppc-ifdef.diff)
> Remove inclusion of asm/processor.h for powerpc. It was used for
> some ppc specific hook in this file, but the hook is gone

It's not:

init_hwif_via82cxxx() contains:

#if defined(CONFIG_PPC_CHRP) && defined(CONFIG_PPC32)
        if(machine_is(chrp) && _chrp_type == _CHRP_Pegasos) {
                hwif->irq = hwif->channel ? 15 : 14;
        }
#endif

Now you can replace CONFIG_PPC_MULTIPLATFORM with CONFIG_PPC_CHRP

> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Index: linux-2.6/drivers/ide/pci/via82cxxx.c
> ===================================================================
> --- linux-2.6.orig/drivers/ide/pci/via82cxxx.c
> +++ linux-2.6/drivers/ide/pci/via82cxxx.c
> @@ -35,10 +35,6 @@
>  #include <linux/ide.h>
>  #include <asm/io.h>
>  
> -#ifdef CONFIG_PPC_MULTIPLATFORM
> -#include <asm/processor.h>
> -#endif
> -
>  #include "ide-timing.h"
>  
>  #define DISPLAY_VIA_TIMINGS
> 
> --
>  Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
>   Pengutronix - Linux Solutions for Science and Industry
>     Handelsregister: Amtsgericht Hildesheim, HRA 2686
>       Hannoversche Str. 2, 31134 Hildesheim, Germany
>     Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
