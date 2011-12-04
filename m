Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 38F361007D5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2011 07:52:10 +1100 (EST)
Message-ID: <1323031921.11728.25.camel@pasglop>
Subject: Re: [PATCH-RFC 08/10] powerpc: switch to GENERIC_PCI_IOMAP
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Date: Mon, 05 Dec 2011 07:52:01 +1100
In-Reply-To: <20111204104835.GJ15464@redhat.com>
References: <cover.1322163031.git.mst@redhat.com>
 <54aba7d0694e98b9103ca278486485598086b2be.1322163031.git.mst@redhat.com>
 <20111204104835.GJ15464@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2011-12-04 at 12:48 +0200, Michael S. Tsirkin wrote:
> On Thu, Nov 24, 2011 at 10:19:54PM +0200, Michael S. Tsirkin wrote:
> > powerpc copied pci_iomap from generic code, probably to avoid
> > pulling the rest of iomap.c in.  Since that's in
> > a separate file now, we can reuse the common implementation.
> > 
> > The only difference is handling of nocache flag,
> > that turns out to be done correctly by the
> > generic code since arch/powerpc/include/asm/io.h
> > defines ioremap_nocache same as ioremap.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> 
> Sorry to nag, any ACKs/NACKs on the powerpc changes?
> I intend to send this to Linus if there are no
> objections. Thanks!

Ah sorry, forgot about that. Do you have a git tree I can pull to do
quick test ?

No objection in principle.

Cheers,
Ben.

> > ---
> >  arch/powerpc/Kconfig        |    1 +
> >  arch/powerpc/kernel/iomap.c |   19 -------------------
> >  2 files changed, 1 insertions(+), 19 deletions(-)
> > 
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 951e18f..6ffe3df 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -710,6 +710,7 @@ config PCI
> >  	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx
> >  	default PCI_QSPAN if !4xx && !CPM2 && 8xx
> >  	select ARCH_SUPPORTS_MSI
> > +	select GENERIC_PCI_IOMAP
> >  	help
> >  	  Find out whether your system includes a PCI bus. PCI is the name of
> >  	  a bus system, i.e. the way the CPU talks to the other stuff inside
> > diff --git a/arch/powerpc/kernel/iomap.c b/arch/powerpc/kernel/iomap.c
> > index 2627918..97a3715 100644
> > --- a/arch/powerpc/kernel/iomap.c
> > +++ b/arch/powerpc/kernel/iomap.c
> > @@ -119,24 +119,6 @@ EXPORT_SYMBOL(ioport_map);
> >  EXPORT_SYMBOL(ioport_unmap);
> >  
> >  #ifdef CONFIG_PCI
> > -void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max)
> > -{
> > -	resource_size_t start = pci_resource_start(dev, bar);
> > -	resource_size_t len = pci_resource_len(dev, bar);
> > -	unsigned long flags = pci_resource_flags(dev, bar);
> > -
> > -	if (!len)
> > -		return NULL;
> > -	if (max && len > max)
> > -		len = max;
> > -	if (flags & IORESOURCE_IO)
> > -		return ioport_map(start, len);
> > -	if (flags & IORESOURCE_MEM)
> > -		return ioremap(start, len);
> > -	/* What? */
> > -	return NULL;
> > -}
> > -
> >  void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
> >  {
> >  	if (isa_vaddr_is_ioport(addr))
> > @@ -146,6 +128,5 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
> >  	iounmap(addr);
> >  }
> >  
> > -EXPORT_SYMBOL(pci_iomap);
> >  EXPORT_SYMBOL(pci_iounmap);
> >  #endif /* CONFIG_PCI */
> > -- 
> > 1.7.5.53.gc233e
