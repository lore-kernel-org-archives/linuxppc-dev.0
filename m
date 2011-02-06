Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5A031B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  6 Feb 2011 15:44:26 +1100 (EST)
Received: by iye19 with SMTP id 19so3721738iye.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 05 Feb 2011 20:44:23 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <AANLkTinrn0rCRD2=wW59oVBPgDjzX2Qe8rJZm6MURMSZ@mail.gmail.com>
References: <20110205062002.32654.18765.stgit@localhost6.localdomain6>
	<1296949393.2349.842.camel@pasglop>
	<AANLkTinrn0rCRD2=wW59oVBPgDjzX2Qe8rJZm6MURMSZ@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 5 Feb 2011 21:44:02 -0700
Message-ID: <AANLkTi=WQA7siCchFXwSd2s02M6SznHh-GvOByiNh3uX@mail.gmail.com>
Subject: Re: [PATCH] powerpc/pci: Make both ppc32 and ppc64 use sysdata for
	pci_controller
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bah, my android phone sent this with html parts and lkml rejected it.
resending...

On Feb 5, 2011 4:43 PM, "Benjamin Herrenschmidt"
<benh@kernel.crashing.org> wrote:
>
> On Fri, 2011-02-04 at 23:22 -0700, Grant Likely wrote:
> > Currently, ppc32 uses sysdata for the pci_controller pointer, and
> > ppc64 uses it to hold the device_node pointer. =A0This patch moves the
> > of_node pointer into (struct pci_bus*)->dev.of_node and
> > (struct pci_dev*)->dev.of_node so that sysdata can be converted to alwa=
ys
> > use the pci_controller pointer instead. =A0It also fixes up the
> > allocating of pci devices so that the of_node pointer gets assigned
> > consistently and increments the ref count.
> >
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > ---
> >
> > Hi Ben,
> >
> > Please take a look at this. =A0It is based on Sebastian's patch
> > to move some of the OF pci code into driver/of, so it probably doesn't
> > apply cleanly, but it is in my devicetree/next branch if you want to
> > give it a spin. =A0With this patch I'll be able to clean up a lot of th=
e
> > differences between ppc32 and ppc64 pci support.
>
> So the ppc64 "aux" data (EEH stuff etc...) is still referenced from the
> device-node ? That's a bit of a problem as I will need to eventually
> support that stuff even for devices that don't have a node in the
> device-tree.

As far as this patch goes it is, but it doesn't have to stay that way.
 Now that sysdata is used consistently, it would be quite easy to
switch it over to a new structure and redirect the pci_controller
reference.

>
> I was thinking about using the sysdata to point to such an aux structure
> to represent what we call "partitionable endpoints" in ppc64 land, which
> isn't exactly PHBs (but sub divisions of a PHB based on filtering on
> bus/dev/fn, for iommu etc...). Unless we can have another platform
> specific pointer in pci_dev I can use for that purpose ?

I of course cannot answer the additional fields in pci_dev question,
but I have no problem with either approach.

g.

>
> Ben.
>
> > g.
> >
> >
> > =A0arch/microblaze/pci/pci_32.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 =
+
> > =A0arch/powerpc/include/asm/pci-bridge.h =A0 =A0 =A0| =A0 27 +++++-----=
-----------------
> > =A0arch/powerpc/include/asm/pci.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> > =A0arch/powerpc/kernel/of_platform.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> > =A0arch/powerpc/kernel/pci-common.c =A0 =A0 =A0 =A0 =A0 | =A0 11 +++---=
-----
> > =A0arch/powerpc/kernel/pci_32.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 =
+-
> > =A0arch/powerpc/kernel/pci_64.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06 =
+++---
> > =A0arch/powerpc/kernel/pci_dn.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A09 =
++++++---
> > =A0arch/powerpc/kernel/pci_of_scan.c =A0 =A0 =A0 =A0 =A0| =A0 =A04 ++--
> > =A0arch/powerpc/platforms/pseries/pci_dlpar.c | =A0 =A02 +-
> > =A010 files changed, 24 insertions(+), 42 deletions(-)
> >
> > diff --git a/arch/microblaze/pci/pci_32.c b/arch/microblaze/pci/pci_32.=
c
> > index 3c3d808..92728a6 100644
> > --- a/arch/microblaze/pci/pci_32.c
> > +++ b/arch/microblaze/pci/pci_32.c
> > @@ -332,6 +332,7 @@ static void __devinit pcibios_scan_phb(struct pci_c=
ontroller *hose)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hose->global_number);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > =A0 =A0 =A0 }
> > + =A0 =A0 bus.dev->of_node =3D of_node_get(node);
> > =A0 =A0 =A0 bus->secondary =3D hose->first_busno;
> > =A0 =A0 =A0 hose->bus =3D bus;
> >
> > diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/inclu=
de/asm/pci-bridge.h
> > index edeb80f..5e156e0 100644
> > --- a/arch/powerpc/include/asm/pci-bridge.h
> > +++ b/arch/powerpc/include/asm/pci-bridge.h
> > @@ -164,13 +164,13 @@ extern void setup_indirect_pci(struct pci_control=
ler* hose,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0resource_siz=
e_t cfg_addr,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0resource_siz=
e_t cfg_data, u32 flags);
> >
> > -#ifndef CONFIG_PPC64
> > -
> > =A0static inline struct pci_controller *pci_bus_to_host(const struct pc=
i_bus *bus)
> > =A0{
> > =A0 =A0 =A0 return bus->sysdata;
> > =A0}
> >
> > +#ifndef CONFIG_PPC64
> > +
> > =A0static inline struct device_node *pci_bus_to_OF_node(struct pci_bus =
*bus)
> > =A0{
> > =A0 =A0 =A0 struct pci_controller *host;
> > @@ -228,19 +228,10 @@ extern void * update_dn_pci_info(struct device_no=
de *dn, void *data);
> >
> > =A0/* Get a device_node from a pci_dev. =A0This code must be fast excep=
t
> > =A0 * in the case where the sysdata is incorrect and needs to be fixed
> > - * up (this will only happen once).
> > - * In this case the sysdata will have been inherited from a PCI host
> > - * bridge or a PCI-PCI bridge further up the tree, so it will point
> > - * to a valid struct pci_dn, just not the one we want.
> > - */
> > + * up (this will only happen once). */
> > =A0static inline struct device_node *pci_device_to_OF_node(struct pci_d=
ev *dev)
> > =A0{
> > - =A0 =A0 struct device_node *dn =3D dev->sysdata;
> > - =A0 =A0 struct pci_dn *pdn =3D dn->data;
> > -
> > - =A0 =A0 if (pdn && pdn->devfn =3D=3D dev->devfn && pdn->busno =3D=3D =
dev->bus->number)
> > - =A0 =A0 =A0 =A0 =A0 =A0 return dn; =A0 =A0 =A0/* fast path. =A0sysdat=
a is good */
> > - =A0 =A0 return fetch_dev_dn(dev);
> > + =A0 =A0 return dev->dev.of_node ? dev->dev.of_node : fetch_dev_dn(dev=
);
> > =A0}
> >
> > =A0static inline int pci_device_from_OF_node(struct device_node *np,
> > @@ -258,7 +249,7 @@ static inline struct device_node *pci_bus_to_OF_nod=
e(struct pci_bus *bus)
> > =A0 =A0 =A0 if (bus->self)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 return pci_device_to_OF_node(bus->self);
> > =A0 =A0 =A0 else
> > - =A0 =A0 =A0 =A0 =A0 =A0 return bus->sysdata; /* Must be root bus (PHB=
) */
> > + =A0 =A0 =A0 =A0 =A0 =A0 return bus->dev.of_node; /* Must be root bus =
(PHB) */
> > =A0}
> >
> > =A0/** Find the bus corresponding to the indicated device node */
> > @@ -270,14 +261,6 @@ extern void pcibios_remove_pci_devices(struct pci_=
bus *bus);
> > =A0/** Discover new pci devices under this bus, and add them */
> > =A0extern void pcibios_add_pci_devices(struct pci_bus *bus);
> >
> > -static inline struct pci_controller *pci_bus_to_host(const struct pci_=
bus *bus)
> > -{
> > - =A0 =A0 struct device_node *busdn =3D bus->sysdata;
> > -
> > - =A0 =A0 BUG_ON(busdn =3D=3D NULL);
> > - =A0 =A0 return PCI_DN(busdn)->phb;
> > -}
> > -
> >
> > =A0extern void isa_bridge_find_early(struct pci_controller *hose);
> >
> > diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/=
pci.h
> > index a20a9ad..7d77909 100644
> > --- a/arch/powerpc/include/asm/pci.h
> > +++ b/arch/powerpc/include/asm/pci.h
> > @@ -201,7 +201,7 @@ extern void pci_resource_to_user(const struct pci_d=
ev *dev, int bar,
> > =A0extern void pcibios_setup_bus_devices(struct pci_bus *bus);
> > =A0extern void pcibios_setup_bus_self(struct pci_bus *bus);
> > =A0extern void pcibios_setup_phb_io_space(struct pci_controller *hose);
> > -extern void pcibios_scan_phb(struct pci_controller *hose, void *sysdat=
a);
> > +extern void pcibios_scan_phb(struct pci_controller *hose);
> >
> > =A0#endif =A0 =A0 =A0 /* __KERNEL__ */
> > =A0#endif /* __ASM_POWERPC_PCI_H */
> > diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of=
_platform.c
> > index b2c363e..9bd951c 100644
> > --- a/arch/powerpc/kernel/of_platform.c
> > +++ b/arch/powerpc/kernel/of_platform.c
> > @@ -74,7 +74,7 @@ static int __devinit of_pci_phb_probe(struct platform=
_device *dev,
> > =A0#endif /* CONFIG_EEH */
> >
> > =A0 =A0 =A0 /* Scan the bus */
> > - =A0 =A0 pcibios_scan_phb(phb, dev->dev.of_node);
> > + =A0 =A0 pcibios_scan_phb(phb);
> > =A0 =A0 =A0 if (phb->bus =3D=3D NULL)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENXIO;
> >
> > diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci=
-common.c
> > index eb341be..3cd85fa 100644
> > --- a/arch/powerpc/kernel/pci-common.c
> > +++ b/arch/powerpc/kernel/pci-common.c
> > @@ -1688,13 +1688,8 @@ int early_find_capability(struct pci_controller =
*hose, int bus, int devfn,
> > =A0/**
> > =A0 * pci_scan_phb - Given a pci_controller, setup and scan the PCI bus
> > =A0 * @hose: Pointer to the PCI host controller instance structure
> > - * @sysdata: value to use for sysdata pointer. =A0ppc32 and ppc64 diff=
er here
> > - *
> > - * Note: the 'data' pointer is a temporary measure. =A0As 32 and 64 bi=
t
> > - * pci code gets merged, this parameter should become unnecessary beca=
use
> > - * both will use the same value.
> > =A0 */
> > -void __devinit pcibios_scan_phb(struct pci_controller *hose, void *sys=
data)
> > +void __devinit pcibios_scan_phb(struct pci_controller *hose)
> > =A0{
> > =A0 =A0 =A0 struct pci_bus *bus;
> > =A0 =A0 =A0 struct device_node *node =3D hose->dn;
> > @@ -1704,13 +1699,13 @@ void __devinit pcibios_scan_phb(struct pci_cont=
roller *hose, void *sysdata)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0node ? node->full_name : "<NO NAME>");
> >
> > =A0 =A0 =A0 /* Create an empty bus for the toplevel */
> > - =A0 =A0 bus =3D pci_create_bus(hose->parent, hose->first_busno, hose-=
>ops,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sysdata);
> > + =A0 =A0 bus =3D pci_create_bus(hose->parent, hose->first_busno, hose-=
>ops, hose);
> > =A0 =A0 =A0 if (bus =3D=3D NULL) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Failed to create bus for PCI domain=
 %04x\n",
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hose->global_number);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > =A0 =A0 =A0 }
> > + =A0 =A0 bus->dev.of_node =3D of_node_get(node);
> > =A0 =A0 =A0 bus->secondary =3D hose->first_busno;
> > =A0 =A0 =A0 hose->bus =3D bus;
> >
> > diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.=
c
> > index e7db5b4..bedb370 100644
> > --- a/arch/powerpc/kernel/pci_32.c
> > +++ b/arch/powerpc/kernel/pci_32.c
> > @@ -381,7 +381,7 @@ static int __init pcibios_init(void)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pci_assign_all_buses)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hose->first_busno =3D next_=
busno;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 hose->last_busno =3D 0xff;
> > - =A0 =A0 =A0 =A0 =A0 =A0 pcibios_scan_phb(hose, hose);
> > + =A0 =A0 =A0 =A0 =A0 =A0 pcibios_scan_phb(hose);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_add_devices(hose->bus);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pci_assign_all_buses || next_busno <=3D=
 hose->last_busno)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 next_busno =3D hose->last_b=
usno + pcibios_assign_bus_offset;
> > diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.=
c
> > index 8515776..fc6452b 100644
> > --- a/arch/powerpc/kernel/pci_64.c
> > +++ b/arch/powerpc/kernel/pci_64.c
> > @@ -64,7 +64,7 @@ static int __init pcibios_init(void)
> >
> > =A0 =A0 =A0 /* Scan all of the recorded PCI controllers. =A0*/
> > =A0 =A0 =A0 list_for_each_entry_safe(hose, tmp, &hose_list, list_node) =
{
> > - =A0 =A0 =A0 =A0 =A0 =A0 pcibios_scan_phb(hose, hose->dn);
> > + =A0 =A0 =A0 =A0 =A0 =A0 pcibios_scan_phb(hose);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_add_devices(hose->bus);
> > =A0 =A0 =A0 }
> >
> > @@ -242,10 +242,10 @@ long sys_pciconfig_iobase(long which, unsigned lo=
ng in_bus,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus =3D NULL;
> > =A0 =A0 =A0 }
> > - =A0 =A0 if (bus =3D=3D NULL || bus->sysdata =3D=3D NULL)
> > + =A0 =A0 if (bus =3D=3D NULL || bus->dev.of_node =3D=3D NULL)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> >
> > - =A0 =A0 hose_node =3D (struct device_node *)bus->sysdata;
> > + =A0 =A0 hose_node =3D bus->dev.of_node;
> > =A0 =A0 =A0 hose =3D PCI_DN(hose_node)->phb;
> >
> > =A0 =A0 =A0 switch (which) {
> > diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.=
c
> > index d56b35e..2985268 100644
> > --- a/arch/powerpc/kernel/pci_dn.c
> > +++ b/arch/powerpc/kernel/pci_dn.c
> > @@ -161,7 +161,7 @@ static void *is_devfn_node(struct device_node *dn, =
void *data)
> > =A0/*
> > =A0 * This is the "slow" path for looking up a device_node from a
> > =A0 * pci_dev. =A0It will hunt for the device under its parent's
> > - * phb and then update sysdata for a future fastpath.
> > + * phb and then update of_node pointer.
> > =A0 *
> > =A0 * It may also do fixups on the actual device since this happens
> > =A0 * on the first read/write.
> > @@ -170,16 +170,19 @@ static void *is_devfn_node(struct device_node *dn=
, void *data)
> > =A0 * In this case it may probe for real hardware ("just in case")
> > =A0 * and add a device_node to the device tree if necessary.
> > =A0 *
> > + * Is this function necessary anymore now that dev->dev.of_node is
> > + * used to store the node pointer?
> > + *
> > =A0 */
> > =A0struct device_node *fetch_dev_dn(struct pci_dev *dev)
> > =A0{
> > - =A0 =A0 struct device_node *orig_dn =3D dev->sysdata;
> > + =A0 =A0 struct device_node *orig_dn =3D dev->dev.of_node;
> > =A0 =A0 =A0 struct device_node *dn;
> > =A0 =A0 =A0 unsigned long searchval =3D (dev->bus->number << 8) | dev->=
devfn;
> >
> > =A0 =A0 =A0 dn =3D traverse_pci_devices(orig_dn, is_devfn_node, (void *=
)searchval);
> > =A0 =A0 =A0 if (dn)
> > - =A0 =A0 =A0 =A0 =A0 =A0 dev->sysdata =3D dn;
> > + =A0 =A0 =A0 =A0 =A0 =A0 dev->dev.of_node =3D dn;
> > =A0 =A0 =A0 return dn;
> > =A0}
> > =A0EXPORT_SYMBOL(fetch_dev_dn);
> > diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pc=
i_of_scan.c
> > index e751506..1e89a72 100644
> > --- a/arch/powerpc/kernel/pci_of_scan.c
> > +++ b/arch/powerpc/kernel/pci_of_scan.c
> > @@ -135,7 +135,7 @@ struct pci_dev *of_create_pci_dev(struct device_nod=
e *node,
> > =A0 =A0 =A0 pr_debug(" =A0 =A0create device, devfn: %x, type: %s\n", de=
vfn, type);
> >
> > =A0 =A0 =A0 dev->bus =3D bus;
> > - =A0 =A0 dev->sysdata =3D node;
> > + =A0 =A0 dev->dev.of_node =3D of_node_get(node);
> > =A0 =A0 =A0 dev->dev.parent =3D bus->bridge;
> > =A0 =A0 =A0 dev->dev.bus =3D &pci_bus_type;
> > =A0 =A0 =A0 dev->devfn =3D devfn;
> > @@ -238,7 +238,7 @@ void __devinit of_scan_pci_bridge(struct device_nod=
e *node,
> > =A0 =A0 =A0 bus->primary =3D dev->bus->number;
> > =A0 =A0 =A0 bus->subordinate =3D busrange[1];
> > =A0 =A0 =A0 bus->bridge_ctl =3D 0;
> > - =A0 =A0 bus->sysdata =3D node;
> > + =A0 =A0 bus->dev.of_node =3D of_node_get(node);
> >
> > =A0 =A0 =A0 /* parse ranges property */
> > =A0 =A0 =A0 /* PCI #address-cells =3D=3D 3 and #size-cells =3D=3D 2 alw=
ays */
> > diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/=
platforms/pseries/pci_dlpar.c
> > index 5fcc92a..3bf4488 100644
> > --- a/arch/powerpc/platforms/pseries/pci_dlpar.c
> > +++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
> > @@ -149,7 +149,7 @@ struct pci_controller * __devinit init_phb_dynamic(=
struct device_node *dn)
> > =A0 =A0 =A0 if (dn->child)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 eeh_add_device_tree_early(dn);
> >
> > - =A0 =A0 pcibios_scan_phb(phb, dn);
> > + =A0 =A0 pcibios_scan_phb(phb);
> > =A0 =A0 =A0 pcibios_finish_adding_to_bus(phb->bus);
> >
> > =A0 =A0 =A0 return phb;
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at =A0http://www.tux.org/lkml/
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
