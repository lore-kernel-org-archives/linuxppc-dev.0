Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0D673B6F18
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 11:42:19 +1000 (EST)
Subject: Re: powerpc/4xx: Regression failed on sil24 (and other) drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <ayman@elkhashab.com>
In-Reply-To: <20110627113137.GA10387@crust.elkhashab.com>
References: <20110625235259.GA18837@crust.elkhashab.com>
	<1309169996.32158.390.camel@pasglop>
	<20110627113137.GA10387@crust.elkhashab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Jun 2011 11:42:03 +1000
Message-ID: <1309311723.32158.514.camel@pasglop>
Mime-Version: 1.0
Cc: cam@cs.ualberta.ca, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-06-27 at 06:31 -0500, Ayman El-Khashab wrote:
> On Mon, Jun 27, 2011 at 08:19:56PM +1000, Benjamin Herrenschmidt wrote:
> > On Sat, 2011-06-25 at 18:52 -0500, Ayman El-Khashab wrote:
> > > I noticed during a recent development with the 460SX that a
> > > simple device that once worked stopped.  I did a bisect to
> > > find the offending commit and it turns out to be this one:
> > > 
> > > 0e52247a2ed1f211f0c4f682dc999610a368903f is the first bad
> > > commit
> > > commit 0e52247a2ed1f211f0c4f682dc999610a368903f
> > > Author: Cam Macdonell <cam@cs.ualberta.ca>
> > > Date:   Tue Sep 7 17:25:20 2010 -0700
> > > 
> > >     PCI: fix pci_resource_alignment prototype
> > > 

Ok, let's see what I can dig out of those logs (sorry for the delay)

Let's start with iomem & ioport, stripped of the legacy & common stuff:

/proc/iomem, bad:

e00000000-e7fffffff : /plb/pciex@d00000000
  e00000000-e7fffffff : 0000:40:00.0
e80000000-effffffff : /plb/pciex@d20000000
  e80000000-effffffff : 0001:80:00.0

good:

e00000000-e7fffffff : /plb/pciex@d00000000
e80000000-effffffff : /plb/pciex@d20000000
  e80000000-e800fffff : PCI Bus 0001:81
    e80000000-e80001fff : 0001:81:00.0
      e80000000-e80001fff : sata_sil24
    e80002000-e8000207f : 0001:81:00.0
      e80002000-e8000207f : sata_sil24

So now that's interesting, you have a device at 0000:40:00.0 that
appears on your first PHB in the "bad" case and doesn't show up in the
"good" case.

In addition, on the "other" PHB, the bus itself doesn't show up in the
bad case. (Let's ignore IOs and focus on mem. for now).

Let's see what lead us to that from the logs. First setup before probing
is all identical. The device at 0000:40:00.0 is detected in both cases,
it's the root complex bridge. So the scanning is identical as expected.

Now the fixup/resource allocation, we start seeing some differences:

Bad:

pci 0000:40:00.0: BAR 0: assigned [mem 0xe00000000-0xe7fffffff pref]
pci 0000:40:00.0: BAR 0: set to [mem 0xe00000000-0xe7fffffff pref] (PCI address [0x80000000-0xffffffff]

vs Good:

pci 0000:40:00.0: BAR 0: can't assign mem pref (size 0x80000000)

So the "bad" case succeeds in giving out resources to the root complex,
while the "good" case fails... fun.

And similarily for the other PHB, bad:

pci 0001:80:00.0: BAR 0: assigned [mem 0xe80000000-0xeffffffff pref]
pci 0001:80:00.0: BAR 0: set to [mem 0xe80000000-0xeffffffff pref] (PCI address [0x80000000-0xffffffff]

vs good:

pci 0001:80:00.0: BAR 0: can't assign mem pref (size 0x80000000)

This then goes down to the "bad" case:

pci 0001:80:00.0: BAR 8: can't assign mem (size 0x100000)
pci 0001:80:00.0: BAR 7: assigned [io  0xfffe1000-0xfffe1fff]
pci 0001:81:00.0: BAR 2: can't assign mem (size 0x2000)
pci 0001:81:00.0: BAR 0: can't assign mem (size 0x80)

while the "good" one succeeds assigning BAR 8,2 and 0 :

pci 0001:80:00.0: BAR 8: assigned [mem 0xe80000000-0xe800fffff]
pci 0001:81:00.0: BAR 2: assigned [mem 0xe80000000-0xe80001fff 64bit]
pci 0001:81:00.0: BAR 2: set to [mem 0xe80000000-0xe80001fff 64bit] (PCI address [0x80000000-0x80001fff]
pci 0001:81:00.0: BAR 0: assigned [mem 0xe80002000-0xe8000207f 64bit]
pci 0001:81:00.0: BAR 0: set to [mem 0xe80002000-0xe8000207f 64bit] (PCI address [0x80002000-0x8000207f]

It looks to me like the "BAR 0" of the host bridges are basically taking the
resource aways from the rest of the devices. Now "BAR 0" are not bridge
resources, which would have been OK, but they are MMIO resources of the
bridge itself.

On 44x, the problem is that those bridges (stupidly) expose BARs that represent
main memory (inbound DMA). It would make sense if these weren't host bridges
but in this case that's totally non sensical (and thus IMHO a HW bug).

I thought we had code to "hide" them to avoid that problem, so I wonder what's
going on... If you look at arch/powerpc/sysdev/ppc4xx_pci.c, there's this
quirk:

static void fixup_ppc4xx_pci_bridge(struct pci_dev *dev)
{
	struct pci_controller *hose;
	int i;

	if (dev->devfn != 0 || dev->bus->self != NULL)
		return;

	hose = pci_bus_to_host(dev->bus);
	if (hose == NULL)
		return;

	if (!of_device_is_compatible(hose->dn, "ibm,plb-pciex") &&
	    !of_device_is_compatible(hose->dn, "ibm,plb-pcix") &&
	    !of_device_is_compatible(hose->dn, "ibm,plb-pci"))
		return;

	if (of_device_is_compatible(hose->dn, "ibm,plb440epx-pci") ||
		of_device_is_compatible(hose->dn, "ibm,plb440grx-pci")) {
		hose->indirect_type |= PPC_INDIRECT_TYPE_BROKEN_MRM;
	}

	/* Hide the PCI host BARs from the kernel as their content doesn't
	 * fit well in the resource management
	 */
	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
		dev->resource[i].start = dev->resource[i].end = 0;
		dev->resource[i].flags = 0;
	}

	printk(KERN_INFO "PCI: Hiding 4xx host bridge resources %s\n",
	       pci_name(dev));
}
DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, fixup_ppc4xx_pci_bridge);

This should basically "clear out" the bridge resources for the pcie
bridge itself, which appears to haven't been done in your case.

I suspect you don't have CONFIG_PCI_QUIRKS enabled... I think that's the
cause of your problem.

It looks like this config option controls both compiling the "generic"
quirks in from drivers/pci/quirk.c, and the actually mechanism for
having quirks in the first place (pci_fixup_device() goes away without
that config option).

I think we probably want to unconditionally select that if CONFIG_PCI is
enabled in arch/powerpc...

Can you try changing it and tell us if that helps ?

Cheers,
Ben.
