Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF4C41A0272
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 08:46:39 +1100 (AEDT)
Message-ID: <1427751988.20500.101.camel@kernel.crashing.org>
Subject: Re: [PATCH 02/27] powerpc/powermac: move pmac_pci_probe_mode from
 setup.c to pci.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 31 Mar 2015 08:46:28 +1100
In-Reply-To: <20150330123214.9EE4014009B@ozlabs.org>
References: <20150330123214.9EE4014009B@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-30 at 23:32 +1100, Michael Ellerman wrote:
> On Wed, 2015-25-03 at 05:35:36 UTC, Daniel Axtens wrote:
> 
> Why did we move it? Just for cleanliness?
> 
> > Signed-off-by: Daniel Axtens <dja@axtens.net>
> > ---
> >  arch/powerpc/platforms/powermac/pci.c   | 17 +++++++++++++++++
> >  arch/powerpc/platforms/powermac/pmac.h  |  4 ++++
> >  arch/powerpc/platforms/powermac/setup.c | 18 ------------------
> >  3 files changed, 21 insertions(+), 18 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
> > index f4071a6..a792f45 100644
> > --- a/arch/powerpc/platforms/powermac/pci.c
> > +++ b/arch/powerpc/platforms/powermac/pci.c
> > @@ -1223,3 +1223,20 @@ static void fixup_u4_pcie(struct pci_dev* dev)
> >  	pci_write_config_dword(dev, PCI_PREF_MEMORY_BASE, 0);
> >  }
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_U4_PCIE, fixup_u4_pcie);
> > +
> > +#ifdef CONFIG_PPC64
> > +int pmac_pci_probe_mode(struct pci_bus *bus)
> > +{
> > +	struct device_node *node = pci_bus_to_OF_node(bus);
> > +
> > +	/* We need to use normal PCI probing for the AGP bus,
> > +	 * since the device for the AGP bridge isn't in the tree.
> > +	 * Same for the PCIe host on U4 and the HT host bridge.
> > +	 */
> > +	if (bus->self == NULL && (of_device_is_compatible(node, "u3-agp") ||
> > +				  of_device_is_compatible(node, "u4-pcie") ||
> > +				  of_device_is_compatible(node, "u3-ht")))
> > +		return PCI_PROBE_NORMAL;
> > +	return PCI_PROBE_DEVTREE;
> > +}
> > +#endif /* CONFIG_PPC64 */
> > diff --git a/arch/powerpc/platforms/powermac/pmac.h b/arch/powerpc/platforms/powermac/pmac.h
> > index 8327cce..46d2193 100644
> > --- a/arch/powerpc/platforms/powermac/pmac.h
> > +++ b/arch/powerpc/platforms/powermac/pmac.h
> > @@ -39,4 +39,8 @@ extern void low_cpu_die(void) __attribute__((noreturn));
> >  extern int pmac_nvram_init(void);
> >  extern void pmac_pic_init(void);
> >  
> > +#ifdef CONFIG_PPC64
> > +extern int pmac_pci_probe_mode(struct pci_bus *bus);
> > +#endif
> 
> You don't need to ifdef declarations, and you don't need extern.

I like extern :-) If the rest of the file use it, I prefer if he
continues doing so.

> So just:
> 
> > +int pmac_pci_probe_mode(struct pci_bus *bus);
> 
> Is fine.
> 
> cheers
