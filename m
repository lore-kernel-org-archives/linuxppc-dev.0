Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B1B29DE049
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 05:43:04 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m09Ih1wM003896
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 13:43:01 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m09Ih1dR392482
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 13:43:01 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m09Ih0SE008966
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 13:43:01 -0500
Date: Wed, 9 Jan 2008 12:42:43 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] MTD for Taco
Message-ID: <20080109124243.73205d68@zod.rchland.ibm.com>
In-Reply-To: <47850CEF.9060209@pikatech.com>
References: <477F12D1.2070109@pikatech.com> <200801051041.18173.sr@denx.de>
	<47850CEF.9060209@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 09 Jan 2008 13:05:35 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

> Stefan Roese wrote:
> > On Saturday 05 January 2008, Sean MacLennan wrote:
> >   
> >> This patch adds the maps for the taco. It also gets the ndfc.c NAND
> >> driver in a compilable state. The map is guaranteed to change since the
> >> exact NOR/NAND flash configuration is in flux right now when we found
> >> the 256M NAND flash won't boot properly.
> >>
> >> Currently it configures the NOR in a reasonable fashion and leaves the
> >> NAND as one honkin' parition.
> >>     
> >
> > <snip>
> >
> >   
> >> diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
> >> index 1c0e89f..f5e93cf 100644
> >> --- a/drivers/mtd/nand/ndfc.c
> >> +++ b/drivers/mtd/nand/ndfc.c
> >> @@ -24,11 +24,6 @@
> >>  #include <linux/platform_device.h>
> >>  
> >>  #include <asm/io.h>
> >> -#ifdef CONFIG_40x
> >> -#include <asm/ibm405.h>
> >> -#else
> >> -#include <asm/ibm44x.h>
> >> -#endif
> >>     
> >
> > You do break arch/ppc support with this patch. We have to still support
> > arch/ppc a few month, so please don't break this support for now.
> >  
> Here is an updated patch that does not break the ppc arch support. 
> Unfortunately, it still has the taco specific patch. I can't find 
> anything different between the taco and the sequoia and since this patch 
> fixes the problem, the hardware guys refuse to look into it. I can't 
> blame them as we are overloaded as it is.
> 
> But I will send out the patch anyway in case anybody needs the ndfc 
> driver working under the powerpc arch.

This doesn't really get the addresses, etc from the device tree though,
correct?

josh
