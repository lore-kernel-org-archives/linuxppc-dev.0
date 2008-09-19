Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BC730DDFCC
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 03:39:47 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8JHdion032362
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 13:39:44 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8JHdiaZ235746
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 13:39:44 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8JHdiff018345
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 13:39:44 -0400
Date: Fri, 19 Sep 2008 13:39:36 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Victor Gallardo" <vgallardo@amcc.com>
Subject: Re: [PATCH v2] Add AMCC Arches eval board support to platforms/44x
Message-ID: <20080919133936.27d2a09f@zod.rchland.ibm.com>
In-Reply-To: <0CA0A16855646F4FA96D25A158E299D6050D1768@SDCEXCHANGE01.ad.amcc.com>
References: <20080918200143.0367482f@zod.rchland.ibm.com>
	<0CA0A16855646F4FA96D25A158E299D6050D1768@SDCEXCHANGE01.ad.amcc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Feng Kan <fkan@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 19 Sep 2008 10:31:34 -0700
"Victor Gallardo" <vgallardo@amcc.com> wrote:

>  
> Hi Josh,
> 
> See below...
> 
> >> ...
> >> @@ -83,9 +83,23 @@ config CANYONLANDS
> >>  	select 460EX
> >>  	select PCI
> >>  	select PPC4xx_PCI_EXPRESS
> >> +	select IBM_NEW_EMAC_EMAC4
> >> +	select IBM_NEW_EMAC_RGMII
> >> +	select IBM_NEW_EMAC_ZMII
> >> +	select IBM_NEW_EMAC_TAH
> >>  	help
> >>  	  This option enables support for the AMCC PPC460EX evaluation board.
> >> 
> >> +config ARCHES
> >> +	bool "Arches"
> >> +	depends on 44x
> >> +	default n
> >> +	select 460EX
> >> +	select IBM_NEW_EMAC_EMAC4
> >> +	select IBM_NEW_EMAC_TAH
> >> +	help
> >> +	  This option enables support for the AMCC PPC460GT evaluation board.
> >
> >This seems fine.
> >
> > ...
> >
> >> +obj-$(CONFIG_ARCHES)	+= canyonlands.o
> >>  obj-$(CONFIG_CANYONLANDS) += canyonlands.o
> >>  obj-$(CONFIG_XILINX_VIRTEX_5_FXT) += virtex.o
> >
> >Instead of modifying the Makefile, you should only have to add the "amcc,arches"
> > string to the >"board" array in ppc44x_simple.c.
> >
> > We switched to doing this as opposed to having a somewhat bogus 
> > "board compatible" statement with >other boards.  That is what was discussed at
> > OLS, and this is the result.
> 
> The reason for two different board types is to remove RGMII and ZMII from the build. Arches does not use it.

Right, and that part is fine.

> 
> Where is ppc4xx_simple.c? I just pulled your git tree and did not find this file.

You need to look in the 'next' branch.

http://git.kernel.org/?p=linux/kernel/git/jwboyer/powerpc-4xx.git;a=tree;f=arch/powerpc/platforms/44x;h=c5cae8d37f170193ed45b7b76e3cb2cbb8be927a;hb=next

josh
