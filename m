Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5A51ADDEE0
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 01:16:25 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l45FGMvh006648
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 11:16:22 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l45FGMVQ544770
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 11:16:22 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l45FGLYe006508
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 11:16:21 -0400
Subject: Re: [PATCH 1/4] Add support for 750CL Holly board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070505143925.GA21503@lixom.net>
References: <1178302414.3026.202.camel@zod.rchland.ibm.com>
	<1178302469.3026.204.camel@zod.rchland.ibm.com>
	<200705042144.31194.arnd@arndb.de> <20070505143925.GA21503@lixom.net>
Content-Type: text/plain
Date: Sat, 05 May 2007 10:11:14 -0500
Message-Id: <1178377874.3393.17.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-05-05 at 09:39 -0500, Olof Johansson wrote:
> On Fri, May 04, 2007 at 09:44:30PM +0200, Arnd Bergmann wrote:
> 
> > > --- linux-2.6.orig/include/asm-powerpc/tsi108.h
> > > +++ linux-2.6/include/asm-powerpc/tsi108.h
> > > @@ -68,7 +68,11 @@
> > >  #define TSI108_PB_ERRCS_ES		(1 << 1)
> > >  #define TSI108_PB_ISR_PBS_RD_ERR	(1 << 8)
> > >  
> > > +#ifdef CONFIG_HOLLY
> > > +#define TSI108_PCI_CFG_BASE_PHYS	(0x7c000000)
> > > +#else
> > >  #define TSI108_PCI_CFG_BASE_PHYS	(0xfb000000)
> > > +#endif
> > >  #define TSI108_PCI_CFG_SIZE		(0x01000000)
> > >  /* Global variables */
> > > 
> > 
> > Same here.
> 
> It would be very easy to take tsi108_setup_pci take the config base as
> a function paramter and pass it in from the board setup code, and store
> it in a static variable to be used for the tsi108_clear_pci_cfg_error
> function.
> 
> That'd easily make the code multiplatform friendly without having to
> add it to the device tree. Very few other platforms have the config base
> address in there, if any. It shouldn't be a requirement that Holly has it.

Yeah, after thinking about it, that's what I plan on doing actually.

josh
