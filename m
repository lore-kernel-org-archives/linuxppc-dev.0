Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CDDE8B6F62
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Aug 2011 20:16:54 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc: Fix build without CONFIG_PCI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20110805173700.19310798b5a30bfb666d7031@canb.auug.org.au>
References: <1312524247.8598.25.camel@pasglop>
	<20110805173700.19310798b5a30bfb666d7031@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 05 Aug 2011 20:16:41 +1000
Message-ID: <1312539401.8598.27.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-08-05 at 17:37 +1000, Stephen Rothwell wrote:
> Hi Ben,
> 
> On Fri, 05 Aug 2011 16:04:07 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > Commit fea80311a939a746533a6d7e7c3183729d6a3faf
> > "iomap: make IOPORT/PCI mapping functions conditional"
> > 
> > Broke powerpc build without CONFIG_PCI as we would still define
> > pci_iomap(), which overlaps with the new empty inline in the headers.
> 
> If we are using a static inline implementation for !CONFIG_PCI, then we
> should probably not EXPORT it in that case either ...

Good point, interesting that my build test didn't catch it ... I'll
add another patch on top before I ask Linus to pull.

Cheers,
Ben.

> > @@ -143,6 +144,7 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
> >  		return;
> >  	iounmap(addr);
> >  }
> > +#endif /* CONFIG_PCI */
> >  
> >  EXPORT_SYMBOL(pci_iomap);
> >  EXPORT_SYMBOL(pci_iounmap);
