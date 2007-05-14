Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4D734DDE0E
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 06:59:51 +1000 (EST)
Subject: Re: [RFC/PATCH] powerpc: Rewrite IO allocation & mapping on powerpc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200705141637.19572.arnd@arndb.de>
References: <20070514075415.7999BDDEC8@ozlabs.org>
	<200705141637.19572.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 15 May 2007 06:59:41 +1000
Message-Id: <1179176381.32247.98.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-14 at 16:37 +0200, Arnd Bergmann wrote:
> On Monday 14 May 2007, Benjamin Herrenschmidt wrote:
> > + * Define the address ranges for MMIO and IO space :
> > + *
> > + *  ISA_IO_BASE = VMALLOC_END, 64K reserved area
> > + *  PHB_IO_BASE = ISA_IO_BASE + 64K to ISA_IO_BASE + 2G, PHB IO spaces
> > + * IOREMAP_BASE = ISA_IO_BASE + 2G to VMALLOC_START + PGTABLE_RANGE
> > + */
> > +#define  ISA_IO_BASE	(VMALLOC_END)
> > +#define  ISA_IO_END	(VMALLOC_END + 0x10000ul)
> > +#define  PHB_IO_BASE	(ISA_IO_END)
> > +#define  PHB_IO_END	(VMALLOC_END + 0x80000000ul)
> > +#define IOREMAP_BASE	(PHB_IO_END)
> > +#define IOREMAP_END	(VMALLOC_START + PGTABLE_RANGE)
> 
> Very nice layout, it suddenly all makes sense ;-)
> 
> PHB_IO_END should probably be 
> 
> #define  PHB_IO_END	(VMALLOC_END + PIO_RESERVED)
> 
> At least, that is how I understand the definition of PIO_RESERVED.

I was wondering what that constant was about ... 0x40000000 doesn't seem
good though.

> Do you think it's ok to not treat the range between 64k and 1M special?
> There might be ISA drivers that expect devices in there. Maybe we should
> start PHB_IO_BASE after a 1M guard area where nothing is mapped.

I though legacy IO couldn't be above 64 K ? ISA bridges definitely don't
forward more than 64K...

> Where should Olof's PCMCIA space go? The ISA or the PHB range?

I'm not sure about Olof's issues with pcmcia. Usually, the PCMCIA bridge
is expected to remap IOs but I suppose he can have it anywhere as part
of the standard PHB ranges, unless he explicitely needs the low IOs.

I want to add a call that archs can do to explicitely bind the low 64K
when there is no ISA so he can always bind them to something special.

> Can we make this depend on CONFIG_ISA? Most platforms don't actually want
> to build in ISA support.

I'm not too sure about that. CONFIG_ISA means you have legacy devices or
ISA slots ? or both ?

> > @@ -11,7 +11,7 @@
> >   *      2 of the License, or (at your option) any later version.
> >   */
> >  
> > -#undef DEBUG
> > +#define DEBUG
> >  
> >  #include <linux/kernel.h>
> >  #include <linux/pci.h>
> 
> needs to get reverted of course

Sure, that's still very much a WIP patch

> >  /* pci_io_base -- the base address from which io bars are offsets.
> >   * This is the lowest I/O base address (so bar values are always positive),
> >   * and it *must* be the start of ISA space if an ISA bus exists because
> > - * ISA drivers use hard coded offsets.  If no ISA bus exists a dummy
> > - * page is mapped and isa_io_limit prevents access to it.
> > + * ISA drivers use hard coded offsets.
> >   */
> > -unsigned long isa_io_base;	/* NULL if no ISA bus */
> > -EXPORT_SYMBOL(isa_io_base);
> > -unsigned long pci_io_base;
> > +unsigned long pci_io_base = ISA_IO_BASE;
> >  EXPORT_SYMBOL(pci_io_base);
> >  
> >  void iSeries_pcibios_init(void);
> 
> Why do we even need to make pci_io_base a variable? There are not many
> places where it's used, and they are are read-only. Replacing it with the
> constant of ISA_IO_BASE should reduce the code size in every driver
> that uses port access functions.

I've been thinking about it yes.

Ben.
