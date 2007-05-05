Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id BE0EDDDEE4
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 00:37:49 +1000 (EST)
Date: Sat, 5 May 2007 09:39:25 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/4] Add support for 750CL Holly board
Message-ID: <20070505143925.GA21503@lixom.net>
References: <1178302414.3026.202.camel@zod.rchland.ibm.com>
	<1178302469.3026.204.camel@zod.rchland.ibm.com>
	<200705042144.31194.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705042144.31194.arnd@arndb.de>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 04, 2007 at 09:44:30PM +0200, Arnd Bergmann wrote:

> > --- linux-2.6.orig/include/asm-powerpc/tsi108.h
> > +++ linux-2.6/include/asm-powerpc/tsi108.h
> > @@ -68,7 +68,11 @@
> >  #define TSI108_PB_ERRCS_ES		(1 << 1)
> >  #define TSI108_PB_ISR_PBS_RD_ERR	(1 << 8)
> >  
> > +#ifdef CONFIG_HOLLY
> > +#define TSI108_PCI_CFG_BASE_PHYS	(0x7c000000)
> > +#else
> >  #define TSI108_PCI_CFG_BASE_PHYS	(0xfb000000)
> > +#endif
> >  #define TSI108_PCI_CFG_SIZE		(0x01000000)
> >  /* Global variables */
> > 
> 
> Same here.

It would be very easy to take tsi108_setup_pci take the config base as
a function paramter and pass it in from the board setup code, and store
it in a static variable to be used for the tsi108_clear_pci_cfg_error
function.

That'd easily make the code multiplatform friendly without having to
add it to the device tree. Very few other platforms have the config base
address in there, if any. It shouldn't be a requirement that Holly has it.


-Olof
