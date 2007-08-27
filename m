Return-Path: <SRS0=QhAZ=NY=denx.de=sr@srs.kundenserver.de>
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/3] [POWERPC] Add PCI support for AMCC 440EPx (sequoia)
Date: Mon, 27 Aug 2007 08:21:35 +0200
References: <20070825091440.4087.1428.stgit@localhost.localdomain>
	<20070825093001.4087.18160.stgit@localhost.localdomain>
	<20070827015719.GD12804@localhost.localdomain>
In-Reply-To: <20070827015719.GD12804@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708270821.35209.sr@denx.de>
Cc: David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 27 August 2007, David Gibson wrote:
> On Sat, Aug 25, 2007 at 01:30:01PM +0400, Vitaly Bordug wrote:
> > In fact, loosely move of arch/ppc bits, though regions are
> > set up using values from ranges property. This also adds
> > setup_indirect_pci_noremap() function to handle indirect
> > PCI without one more ioremap.
> >
> > Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> > Signed-off-by: Stefan Roese <sr@denx.de>
> >
> > ---
> >
> >  arch/powerpc/platforms/44x/44x.h           |   28 ++++
> >  arch/powerpc/platforms/44x/Makefile        |    4 +
> >  arch/powerpc/platforms/44x/ppc440epx-pci.c |  192
> > ++++++++++++++++++++++++++++ arch/powerpc/platforms/44x/sequoia.c       |
> >   14 ++
> >  arch/powerpc/sysdev/indirect_pci.c         |   14 ++
> >  include/asm-powerpc/pci-bridge.h           |    2
> >  6 files changed, 254 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/44x/44x.h
> > b/arch/powerpc/platforms/44x/44x.h index 42eabf8..d3845f9 100644
> > --- a/arch/powerpc/platforms/44x/44x.h
> > +++ b/arch/powerpc/platforms/44x/44x.h
> > @@ -1,8 +1,36 @@
> >  #ifndef __POWERPC_PLATFORMS_44X_44X_H
> >  #define __POWERPC_PLATFORMS_44X_44X_H
> > +#include <asm/pci-bridge.h>
> > +
> > +/* PCI support */
> > +#define PPC4xx_PCI_CFGA_OFFSET		0
> > +#define PPC4xx_PCI_CFGD_OFFSET		0x4
> > +
> > +#define PPC4xx_PCIL0_PMM0LA		0x000
> > +#define PPC4xx_PCIL0_PMM0MA		0x004
> > +#define PPC4xx_PCIL0_PMM0PCILA		0x008
> > +#define PPC4xx_PCIL0_PMM0PCIHA		0x00C
> > +#define PPC4xx_PCIL0_PMM1LA		0x010
> > +#define PPC4xx_PCIL0_PMM1MA		0x014
> > +#define PPC4xx_PCIL0_PMM1PCILA		0x018
> > +#define PPC4xx_PCIL0_PMM1PCIHA		0x01C
> > +#define PPC4xx_PCIL0_PMM2LA		0x020
> > +#define PPC4xx_PCIL0_PMM2MA		0x024
> > +#define PPC4xx_PCIL0_PMM2PCILA		0x028
> > +#define PPC4xx_PCIL0_PMM2PCIHA		0x02C
> > +#define PPC4xx_PCIL0_PTM1MS		0x030
> > +#define PPC4xx_PCIL0_PTM1LA		0x034
> > +#define PPC4xx_PCIL0_PTM2MS		0x038
> > +#define PPC4xx_PCIL0_PTM2LA		0x03C
> >
> >  extern u8 as1_readb(volatile u8 __iomem  *addr);
> >  extern void as1_writeb(u8 data, volatile u8 __iomem *addr);
> >  extern void ppc44x_reset_system(char *cmd);
> >
> > +#ifdef CONFIG_PCI
> > +int ppc440epx_exclude_device(struct pci_controller *hose,
> > +		u_char bus, u_char devfn);
> > +int ppc440epx_add_bridge(struct device_node *dev);
> > +#endif
> > +
> >  #endif /* __POWERPC_PLATFORMS_44X_44X_H */
> > diff --git a/arch/powerpc/platforms/44x/Makefile
> > b/arch/powerpc/platforms/44x/Makefile index 10ce674..d2a5278 100644
> > --- a/arch/powerpc/platforms/44x/Makefile
> > +++ b/arch/powerpc/platforms/44x/Makefile
> > @@ -2,3 +2,7 @@ obj-$(CONFIG_44x)	:= misc_44x.o
> >  obj-$(CONFIG_EBONY)	+= ebony.o
> >  obj-$(CONFIG_BAMBOO) += bamboo.o
> >  obj-$(CONFIG_SEQUOIA)	+= sequoia.o
> > +
> > +ifeq ($(CONFIG_PCI),y)
> > +obj-$(CONFIG_440EPX)   += ppc440epx-pci.o
> > +endif
> > diff --git a/arch/powerpc/platforms/44x/ppc440epx-pci.c
> > b/arch/powerpc/platforms/44x/ppc440epx-pci.c new file mode 100644
> > index 0000000..bd4a352
> > --- /dev/null
> > +++ b/arch/powerpc/platforms/44x/ppc440epx-pci.c
> > @@ -0,0 +1,192 @@
> > +/*
> > + * PPC44x PCI host support
> > + *
> > + * Vitaly Bordug <vitb@kernel.crashing.org>
> > + * Stefan Roese <sr@denx.de>
> > + *
> > + * Based on arch/ppc sequoia pci bits, that are
> > + * Copyright 2006-2007 DENX Software Engineering, Stefan Roese
> > <sr@denx.de> + *
> > + * Based on bamboo.c from Wade Farnsworth <wfarnsworth@mvista.com>
> > + *      Copyright 2004 MontaVista Software Inc.
> > + *      Copyright 2006 AMCC
> > + * This program is free software; you can redistribute  it and/or modify
> > it + * under  the terms of  the GNU General  Public License as published
> > by the + * Free Software Foundation;  either version 2 of the  License,
> > or (at your + * option) any later version.
> > + */
>
> Unless there really is something peculiar about the EPx bridge
> compared to say the GP, EP and other 4xx bridges, this should have a
> more general name.

We originally started naming this file sequoia-pci.c and changed it to be 
440EPx specific (just by renaming). But you are right of course. We should 
make it even more generic for 4xx PCI support. Perhaps we will overlook some 
problems with other 4xx platforms, but those should be solved when other 
platforms (Josh: 440ep and 405gp? ;)) will be added.

So what should it be called? arch/powerpc/syslib/ppc4xx_pci.c ?

Best regards,
Stefan
