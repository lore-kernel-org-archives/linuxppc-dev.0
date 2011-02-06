Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6281DB70E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  6 Feb 2011 13:09:38 +1100 (EST)
Received: by iye19 with SMTP id 19so3657267iye.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 05 Feb 2011 18:09:35 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1296949393.2349.842.camel@pasglop>
References: <20110205062002.32654.18765.stgit@localhost6.localdomain6>
	<1296949393.2349.842.camel@pasglop>
Date: Sat, 5 Feb 2011 19:09:35 -0700
Message-ID: <AANLkTinrn0rCRD2=wW59oVBPgDjzX2Qe8rJZm6MURMSZ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/pci: Make both ppc32 and ppc64 use sysdata for
	pci_controller
From: Grant Likely <grant.likely@secretlab.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/alternative; boundary=000325575e52510b1d049b939b41
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000325575e52510b1d049b939b41
Content-Type: text/plain; charset=ISO-8859-1

On Feb 5, 2011 4:43 PM, "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
wrote:
>
> On Fri, 2011-02-04 at 23:22 -0700, Grant Likely wrote:
> > Currently, ppc32 uses sysdata for the pci_controller pointer, and
> > ppc64 uses it to hold the device_node pointer.  This patch moves the
> > of_node pointer into (struct pci_bus*)->dev.of_node and
> > (struct pci_dev*)->dev.of_node so that sysdata can be converted to
always
> > use the pci_controller pointer instead.  It also fixes up the
> > allocating of pci devices so that the of_node pointer gets assigned
> > consistently and increments the ref count.
> >
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > ---
> >
> > Hi Ben,
> >
> > Please take a look at this.  It is based on Sebastian's patch
> > to move some of the OF pci code into driver/of, so it probably doesn't
> > apply cleanly, but it is in my devicetree/next branch if you want to
> > give it a spin.  With this patch I'll be able to clean up a lot of the
> > differences between ppc32 and ppc64 pci support.
>
> So the ppc64 "aux" data (EEH stuff etc...) is still referenced from the
> device-node ? That's a bit of a problem as I will need to eventually
> support that stuff even for devices that don't have a node in the
> device-tree.

As far as this patch goes it is, but it doesn't have to stay that way.  Now
that sysdata is used consistently, it would be quite easy to switch it over
to a new structure and redirect the pci_controller reference.

>
> I was thinking about using the sysdata to point to such an aux structure
> to represent what we call "partitionable endpoints" in ppc64 land, which
> isn't exactly PHBs (but sub divisions of a PHB based on filtering on
> bus/dev/fn, for iommu etc...). Unless we can have another platform
> specific pointer in pci_dev I can use for that purpose ?

I of course cannot answer the additional fields in pci_dev question, but I
have no problem with either approach.

g.

>
> Ben.
>
> > g.
> >
> >
> >  arch/microblaze/pci/pci_32.c               |    1 +
> >  arch/powerpc/include/asm/pci-bridge.h      |   27
+++++----------------------
> >  arch/powerpc/include/asm/pci.h             |    2 +-
> >  arch/powerpc/kernel/of_platform.c          |    2 +-
> >  arch/powerpc/kernel/pci-common.c           |   11 +++--------
> >  arch/powerpc/kernel/pci_32.c               |    2 +-
> >  arch/powerpc/kernel/pci_64.c               |    6 +++---
> >  arch/powerpc/kernel/pci_dn.c               |    9 ++++++---
> >  arch/powerpc/kernel/pci_of_scan.c          |    4 ++--
> >  arch/powerpc/platforms/pseries/pci_dlpar.c |    2 +-
> >  10 files changed, 24 insertions(+), 42 deletions(-)
> >
> > diff --git a/arch/microblaze/pci/pci_32.c b/arch/microblaze/pci/pci_32.c
> > index 3c3d808..92728a6 100644
> > --- a/arch/microblaze/pci/pci_32.c
> > +++ b/arch/microblaze/pci/pci_32.c
> > @@ -332,6 +332,7 @@ static void __devinit pcibios_scan_phb(struct
pci_controller *hose)
> >                      hose->global_number);
> >               return;
> >       }
> > +     bus.dev->of_node = of_node_get(node);
> >       bus->secondary = hose->first_busno;
> >       hose->bus = bus;
> >
> > diff --git a/arch/powerpc/include/asm/pci-bridge.h
b/arch/powerpc/include/asm/pci-bridge.h
> > index edeb80f..5e156e0 100644
> > --- a/arch/powerpc/include/asm/pci-bridge.h
> > +++ b/arch/powerpc/include/asm/pci-bridge.h
> > @@ -164,13 +164,13 @@ extern void setup_indirect_pci(struct
pci_controller* hose,
> >                              resource_size_t cfg_addr,
> >                              resource_size_t cfg_data, u32 flags);
> >
> > -#ifndef CONFIG_PPC64
> > -
> >  static inline struct pci_controller *pci_bus_to_host(const struct
pci_bus *bus)
> >  {
> >       return bus->sysdata;
> >  }
> >
> > +#ifndef CONFIG_PPC64
> > +
> >  static inline struct device_node *pci_bus_to_OF_node(struct pci_bus
*bus)
> >  {
> >       struct pci_controller *host;
> > @@ -228,19 +228,10 @@ extern void * update_dn_pci_info(struct
device_node *dn, void *data);
> >
> >  /* Get a device_node from a pci_dev.  This code must be fast except
> >   * in the case where the sysdata is incorrect and needs to be fixed
> > - * up (this will only happen once).
> > - * In this case the sysdata will have been inherited from a PCI host
> > - * bridge or a PCI-PCI bridge further up the tree, so it will point
> > - * to a valid struct pci_dn, just not the one we want.
> > - */
> > + * up (this will only happen once). */
> >  static inline struct device_node *pci_device_to_OF_node(struct pci_dev
*dev)
> >  {
> > -     struct device_node *dn = dev->sysdata;
> > -     struct pci_dn *pdn = dn->data;
> > -
> > -     if (pdn && pdn->devfn == dev->devfn && pdn->busno ==
dev->bus->number)
> > -             return dn;      /* fast path.  sysdata is good */
> > -     return fetch_dev_dn(dev);
> > +     return dev->dev.of_node ? dev->dev.of_node : fetch_dev_dn(dev);
> >  }
> >
> >  static inline int pci_device_from_OF_node(struct device_node *np,
> > @@ -258,7 +249,7 @@ static inline struct device_node
*pci_bus_to_OF_node(struct pci_bus *bus)
> >       if (bus->self)
> >               return pci_device_to_OF_node(bus->self);
> >       else
> > -             return bus->sysdata; /* Must be root bus (PHB) */
> > +             return bus->dev.of_node; /* Must be root bus (PHB) */
> >  }
> >
> >  /** Find the bus corresponding to the indicated device node */
> > @@ -270,14 +261,6 @@ extern void pcibios_remove_pci_devices(struct
pci_bus *bus);
> >  /** Discover new pci devices under this bus, and add them */
> >  extern void pcibios_add_pci_devices(struct pci_bus *bus);
> >
> > -static inline struct pci_controller *pci_bus_to_host(const struct
pci_bus *bus)
> > -{
> > -     struct device_node *busdn = bus->sysdata;
> > -
> > -     BUG_ON(busdn == NULL);
> > -     return PCI_DN(busdn)->phb;
> > -}
> > -
> >
> >  extern void isa_bridge_find_early(struct pci_controller *hose);
> >
> > diff --git a/arch/powerpc/include/asm/pci.h
b/arch/powerpc/include/asm/pci.h
> > index a20a9ad..7d77909 100644
> > --- a/arch/powerpc/include/asm/pci.h
> > +++ b/arch/powerpc/include/asm/pci.h
> > @@ -201,7 +201,7 @@ extern void pci_resource_to_user(const struct
pci_dev *dev, int bar,
> >  extern void pcibios_setup_bus_devices(struct pci_bus *bus);
> >  extern void pcibios_setup_bus_self(struct pci_bus *bus);
> >  extern void pcibios_setup_phb_io_space(struct pci_controller *hose);
> > -extern void pcibios_scan_phb(struct pci_controller *hose, void
*sysdata);
> > +extern void pcibios_scan_phb(struct pci_controller *hose);
> >
> >  #endif       /* __KERNEL__ */
> >  #endif /* __ASM_POWERPC_PCI_H */
> > diff --git a/arch/powerpc/kernel/of_platform.c
b/arch/powerpc/kernel/of_platform.c
> > index b2c363e..9bd951c 100644
> > --- a/arch/powerpc/kernel/of_platform.c
> > +++ b/arch/powerpc/kernel/of_platform.c
> > @@ -74,7 +74,7 @@ static int __devinit of_pci_phb_probe(struct
platform_device *dev,
> >  #endif /* CONFIG_EEH */
> >
> >       /* Scan the bus */
> > -     pcibios_scan_phb(phb, dev->dev.of_node);
> > +     pcibios_scan_phb(phb);
> >       if (phb->bus == NULL)
> >               return -ENXIO;
> >
> > diff --git a/arch/powerpc/kernel/pci-common.c
b/arch/powerpc/kernel/pci-common.c
> > index eb341be..3cd85fa 100644
> > --- a/arch/powerpc/kernel/pci-common.c
> > +++ b/arch/powerpc/kernel/pci-common.c
> > @@ -1688,13 +1688,8 @@ int early_find_capability(struct pci_controller
*hose, int bus, int devfn,
> >  /**
> >   * pci_scan_phb - Given a pci_controller, setup and scan the PCI bus
> >   * @hose: Pointer to the PCI host controller instance structure
> > - * @sysdata: value to use for sysdata pointer.  ppc32 and ppc64 differ
here
> > - *
> > - * Note: the 'data' pointer is a temporary measure.  As 32 and 64 bit
> > - * pci code gets merged, this parameter should become unnecessary
because
> > - * both will use the same value.
> >   */
> > -void __devinit pcibios_scan_phb(struct pci_controller *hose, void
*sysdata)
> > +void __devinit pcibios_scan_phb(struct pci_controller *hose)
> >  {
> >       struct pci_bus *bus;
> >       struct device_node *node = hose->dn;
> > @@ -1704,13 +1699,13 @@ void __devinit pcibios_scan_phb(struct
pci_controller *hose, void *sysdata)
> >                node ? node->full_name : "<NO NAME>");
> >
> >       /* Create an empty bus for the toplevel */
> > -     bus = pci_create_bus(hose->parent, hose->first_busno, hose->ops,
> > -                          sysdata);
> > +     bus = pci_create_bus(hose->parent, hose->first_busno, hose->ops,
hose);
> >       if (bus == NULL) {
> >               pr_err("Failed to create bus for PCI domain %04x\n",
> >                       hose->global_number);
> >               return;
> >       }
> > +     bus->dev.of_node = of_node_get(node);
> >       bus->secondary = hose->first_busno;
> >       hose->bus = bus;
> >
> > diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
> > index e7db5b4..bedb370 100644
> > --- a/arch/powerpc/kernel/pci_32.c
> > +++ b/arch/powerpc/kernel/pci_32.c
> > @@ -381,7 +381,7 @@ static int __init pcibios_init(void)
> >               if (pci_assign_all_buses)
> >                       hose->first_busno = next_busno;
> >               hose->last_busno = 0xff;
> > -             pcibios_scan_phb(hose, hose);
> > +             pcibios_scan_phb(hose);
> >               pci_bus_add_devices(hose->bus);
> >               if (pci_assign_all_buses || next_busno <=
hose->last_busno)
> >                       next_busno = hose->last_busno +
pcibios_assign_bus_offset;
> > diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> > index 8515776..fc6452b 100644
> > --- a/arch/powerpc/kernel/pci_64.c
> > +++ b/arch/powerpc/kernel/pci_64.c
> > @@ -64,7 +64,7 @@ static int __init pcibios_init(void)
> >
> >       /* Scan all of the recorded PCI controllers.  */
> >       list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
> > -             pcibios_scan_phb(hose, hose->dn);
> > +             pcibios_scan_phb(hose);
> >               pci_bus_add_devices(hose->bus);
> >       }
> >
> > @@ -242,10 +242,10 @@ long sys_pciconfig_iobase(long which, unsigned
long in_bus,
> >                       break;
> >               bus = NULL;
> >       }
> > -     if (bus == NULL || bus->sysdata == NULL)
> > +     if (bus == NULL || bus->dev.of_node == NULL)
> >               return -ENODEV;
> >
> > -     hose_node = (struct device_node *)bus->sysdata;
> > +     hose_node = bus->dev.of_node;
> >       hose = PCI_DN(hose_node)->phb;
> >
> >       switch (which) {
> > diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
> > index d56b35e..2985268 100644
> > --- a/arch/powerpc/kernel/pci_dn.c
> > +++ b/arch/powerpc/kernel/pci_dn.c
> > @@ -161,7 +161,7 @@ static void *is_devfn_node(struct device_node *dn,
void *data)
> >  /*
> >   * This is the "slow" path for looking up a device_node from a
> >   * pci_dev.  It will hunt for the device under its parent's
> > - * phb and then update sysdata for a future fastpath.
> > + * phb and then update of_node pointer.
> >   *
> >   * It may also do fixups on the actual device since this happens
> >   * on the first read/write.
> > @@ -170,16 +170,19 @@ static void *is_devfn_node(struct device_node *dn,
void *data)
> >   * In this case it may probe for real hardware ("just in case")
> >   * and add a device_node to the device tree if necessary.
> >   *
> > + * Is this function necessary anymore now that dev->dev.of_node is
> > + * used to store the node pointer?
> > + *
> >   */
> >  struct device_node *fetch_dev_dn(struct pci_dev *dev)
> >  {
> > -     struct device_node *orig_dn = dev->sysdata;
> > +     struct device_node *orig_dn = dev->dev.of_node;
> >       struct device_node *dn;
> >       unsigned long searchval = (dev->bus->number << 8) | dev->devfn;
> >
> >       dn = traverse_pci_devices(orig_dn, is_devfn_node, (void
*)searchval);
> >       if (dn)
> > -             dev->sysdata = dn;
> > +             dev->dev.of_node = dn;
> >       return dn;
> >  }
> >  EXPORT_SYMBOL(fetch_dev_dn);
> > diff --git a/arch/powerpc/kernel/pci_of_scan.c
b/arch/powerpc/kernel/pci_of_scan.c
> > index e751506..1e89a72 100644
> > --- a/arch/powerpc/kernel/pci_of_scan.c
> > +++ b/arch/powerpc/kernel/pci_of_scan.c
> > @@ -135,7 +135,7 @@ struct pci_dev *of_create_pci_dev(struct device_node
*node,
> >       pr_debug("    create device, devfn: %x, type: %s\n", devfn, type);
> >
> >       dev->bus = bus;
> > -     dev->sysdata = node;
> > +     dev->dev.of_node = of_node_get(node);
> >       dev->dev.parent = bus->bridge;
> >       dev->dev.bus = &pci_bus_type;
> >       dev->devfn = devfn;
> > @@ -238,7 +238,7 @@ void __devinit of_scan_pci_bridge(struct device_node
*node,
> >       bus->primary = dev->bus->number;
> >       bus->subordinate = busrange[1];
> >       bus->bridge_ctl = 0;
> > -     bus->sysdata = node;
> > +     bus->dev.of_node = of_node_get(node);
> >
> >       /* parse ranges property */
> >       /* PCI #address-cells == 3 and #size-cells == 2 always */
> > diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c
b/arch/powerpc/platforms/pseries/pci_dlpar.c
> > index 5fcc92a..3bf4488 100644
> > --- a/arch/powerpc/platforms/pseries/pci_dlpar.c
> > +++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
> > @@ -149,7 +149,7 @@ struct pci_controller * __devinit
init_phb_dynamic(struct device_node *dn)
> >       if (dn->child)
> >               eeh_add_device_tree_early(dn);
> >
> > -     pcibios_scan_phb(phb, dn);
> > +     pcibios_scan_phb(phb);
> >       pcibios_finish_adding_to_bus(phb->bus);
> >
> >       return phb;
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
>

--000325575e52510b1d049b939b41
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p><br>
On Feb 5, 2011 4:43 PM, &quot;Benjamin Herrenschmidt&quot; &lt;<a href=3D"m=
ailto:benh@kernel.crashing.org">benh@kernel.crashing.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On Fri, 2011-02-04 at 23:22 -0700, Grant Likely wrote:<br>
&gt; &gt; Currently, ppc32 uses sysdata for the pci_controller pointer, and=
<br>
&gt; &gt; ppc64 uses it to hold the device_node pointer. =A0This patch move=
s the<br>
&gt; &gt; of_node pointer into (struct pci_bus*)-&gt;dev.of_node and<br>
&gt; &gt; (struct pci_dev*)-&gt;dev.of_node so that sysdata can be converte=
d to always<br>
&gt; &gt; use the pci_controller pointer instead. =A0It also fixes up the<b=
r>
&gt; &gt; allocating of pci devices so that the of_node pointer gets assign=
ed<br>
&gt; &gt; consistently and increments the ref count.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Grant Likely &lt;<a href=3D"mailto:grant.likely@se=
cretlab.ca">grant.likely@secretlab.ca</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;<br>
&gt; &gt; Hi Ben,<br>
&gt; &gt;<br>
&gt; &gt; Please take a look at this. =A0It is based on Sebastian&#39;s pat=
ch<br>
&gt; &gt; to move some of the OF pci code into driver/of, so it probably do=
esn&#39;t<br>
&gt; &gt; apply cleanly, but it is in my devicetree/next branch if you want=
 to<br>
&gt; &gt; give it a spin. =A0With this patch I&#39;ll be able to clean up a=
 lot of the<br>
&gt; &gt; differences between ppc32 and ppc64 pci support.<br>
&gt;<br>
&gt; So the ppc64 &quot;aux&quot; data (EEH stuff etc...) is still referenc=
ed from the<br>
&gt; device-node ? That&#39;s a bit of a problem as I will need to eventual=
ly<br>
&gt; support that stuff even for devices that don&#39;t have a node in the<=
br>
&gt; device-tree.</p>
<p>As far as this patch goes it is, but it doesn&#39;t have to stay that wa=
y.=A0 Now that sysdata is used consistently, it would be quite easy to swit=
ch it over to a new structure and redirect the pci_controller reference.</p=
>

<p>&gt;<br>
&gt; I was thinking about using the sysdata to point to such an aux structu=
re<br>
&gt; to represent what we call &quot;partitionable endpoints&quot; in ppc64=
 land, which<br>
&gt; isn&#39;t exactly PHBs (but sub divisions of a PHB based on filtering =
on<br>
&gt; bus/dev/fn, for iommu etc...). Unless we can have another platform<br>
&gt; specific pointer in pci_dev I can use for that purpose ?</p>
<p>I of course cannot answer the additional fields in pci_dev question, but=
 I have no problem with either approach.</p>
<p>g.</p>
<p>&gt;<br>
&gt; Ben.<br>
&gt;<br>
&gt; &gt; g.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; =A0arch/microblaze/pci/pci_32.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A01 +<br>
&gt; &gt; =A0arch/powerpc/include/asm/pci-bridge.h =A0 =A0 =A0| =A0 27 ++++=
+----------------------<br>
&gt; &gt; =A0arch/powerpc/include/asm/pci.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A02 +-<br>
&gt; &gt; =A0arch/powerpc/kernel/of_platform.c =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +-<br>
&gt; &gt; =A0arch/powerpc/kernel/pci-common.c =A0 =A0 =A0 =A0 =A0 | =A0 11 =
+++--------<br>
&gt; &gt; =A0arch/powerpc/kernel/pci_32.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +-<br>
&gt; &gt; =A0arch/powerpc/kernel/pci_64.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A06 +++---<br>
&gt; &gt; =A0arch/powerpc/kernel/pci_dn.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A09 ++++++---<br>
&gt; &gt; =A0arch/powerpc/kernel/pci_of_scan.c =A0 =A0 =A0 =A0 =A0| =A0 =A0=
4 ++--<br>
&gt; &gt; =A0arch/powerpc/platforms/pseries/pci_dlpar.c | =A0 =A02 +-<br>
&gt; &gt; =A010 files changed, 24 insertions(+), 42 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/arch/microblaze/pci/pci_32.c b/arch/microblaze/pci/p=
ci_32.c<br>
&gt; &gt; index 3c3d808..92728a6 100644<br>
&gt; &gt; --- a/arch/microblaze/pci/pci_32.c<br>
&gt; &gt; +++ b/arch/microblaze/pci/pci_32.c<br>
&gt; &gt; @@ -332,6 +332,7 @@ static void __devinit pcibios_scan_phb(struct=
 pci_controller *hose)<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hose-&gt;global_number=
);<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
&gt; &gt; =A0 =A0 =A0 }<br>
&gt; &gt; + =A0 =A0 bus.dev-&gt;of_node =3D of_node_get(node);<br>
&gt; &gt; =A0 =A0 =A0 bus-&gt;secondary =3D hose-&gt;first_busno;<br>
&gt; &gt; =A0 =A0 =A0 hose-&gt;bus =3D bus;<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc=
/include/asm/pci-bridge.h<br>
&gt; &gt; index edeb80f..5e156e0 100644<br>
&gt; &gt; --- a/arch/powerpc/include/asm/pci-bridge.h<br>
&gt; &gt; +++ b/arch/powerpc/include/asm/pci-bridge.h<br>
&gt; &gt; @@ -164,13 +164,13 @@ extern void setup_indirect_pci(struct pci_c=
ontroller* hose,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0resour=
ce_size_t cfg_addr,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0resour=
ce_size_t cfg_data, u32 flags);<br>
&gt; &gt;<br>
&gt; &gt; -#ifndef CONFIG_PPC64<br>
&gt; &gt; -<br>
&gt; &gt; =A0static inline struct pci_controller *pci_bus_to_host(const str=
uct pci_bus *bus)<br>
&gt; &gt; =A0{<br>
&gt; &gt; =A0 =A0 =A0 return bus-&gt;sysdata;<br>
&gt; &gt; =A0}<br>
&gt; &gt;<br>
&gt; &gt; +#ifndef CONFIG_PPC64<br>
&gt; &gt; +<br>
&gt; &gt; =A0static inline struct device_node *pci_bus_to_OF_node(struct pc=
i_bus *bus)<br>
&gt; &gt; =A0{<br>
&gt; &gt; =A0 =A0 =A0 struct pci_controller *host;<br>
&gt; &gt; @@ -228,19 +228,10 @@ extern void * update_dn_pci_info(struct dev=
ice_node *dn, void *data);<br>
&gt; &gt;<br>
&gt; &gt; =A0/* Get a device_node from a pci_dev. =A0This code must be fast=
 except<br>
&gt; &gt; =A0 * in the case where the sysdata is incorrect and needs to be =
fixed<br>
&gt; &gt; - * up (this will only happen once).<br>
&gt; &gt; - * In this case the sysdata will have been inherited from a PCI =
host<br>
&gt; &gt; - * bridge or a PCI-PCI bridge further up the tree, so it will po=
int<br>
&gt; &gt; - * to a valid struct pci_dn, just not the one we want.<br>
&gt; &gt; - */<br>
&gt; &gt; + * up (this will only happen once). */<br>
&gt; &gt; =A0static inline struct device_node *pci_device_to_OF_node(struct=
 pci_dev *dev)<br>
&gt; &gt; =A0{<br>
&gt; &gt; - =A0 =A0 struct device_node *dn =3D dev-&gt;sysdata;<br>
&gt; &gt; - =A0 =A0 struct pci_dn *pdn =3D dn-&gt;data;<br>
&gt; &gt; -<br>
&gt; &gt; - =A0 =A0 if (pdn &amp;&amp; pdn-&gt;devfn =3D=3D dev-&gt;devfn &=
amp;&amp; pdn-&gt;busno =3D=3D dev-&gt;bus-&gt;number)<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 return dn; =A0 =A0 =A0/* fast path. =A0=
sysdata is good */<br>
&gt; &gt; - =A0 =A0 return fetch_dev_dn(dev);<br>
&gt; &gt; + =A0 =A0 return dev-&gt;dev.of_node ? dev-&gt;dev.of_node : fetc=
h_dev_dn(dev);<br>
&gt; &gt; =A0}<br>
&gt; &gt;<br>
&gt; &gt; =A0static inline int pci_device_from_OF_node(struct device_node *=
np,<br>
&gt; &gt; @@ -258,7 +249,7 @@ static inline struct device_node *pci_bus_to_=
OF_node(struct pci_bus *bus)<br>
&gt; &gt; =A0 =A0 =A0 if (bus-&gt;self)<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return pci_device_to_OF_node(bus-&gt;=
self);<br>
&gt; &gt; =A0 =A0 =A0 else<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 return bus-&gt;sysdata; /* Must be root=
 bus (PHB) */<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 return bus-&gt;dev.of_node; /* Must be =
root bus (PHB) */<br>
&gt; &gt; =A0}<br>
&gt; &gt;<br>
&gt; &gt; =A0/** Find the bus corresponding to the indicated device node */=
<br>
&gt; &gt; @@ -270,14 +261,6 @@ extern void pcibios_remove_pci_devices(struc=
t pci_bus *bus);<br>
&gt; &gt; =A0/** Discover new pci devices under this bus, and add them */<b=
r>
&gt; &gt; =A0extern void pcibios_add_pci_devices(struct pci_bus *bus);<br>
&gt; &gt;<br>
&gt; &gt; -static inline struct pci_controller *pci_bus_to_host(const struc=
t pci_bus *bus)<br>
&gt; &gt; -{<br>
&gt; &gt; - =A0 =A0 struct device_node *busdn =3D bus-&gt;sysdata;<br>
&gt; &gt; -<br>
&gt; &gt; - =A0 =A0 BUG_ON(busdn =3D=3D NULL);<br>
&gt; &gt; - =A0 =A0 return PCI_DN(busdn)-&gt;phb;<br>
&gt; &gt; -}<br>
&gt; &gt; -<br>
&gt; &gt;<br>
&gt; &gt; =A0extern void isa_bridge_find_early(struct pci_controller *hose)=
;<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/includ=
e/asm/pci.h<br>
&gt; &gt; index a20a9ad..7d77909 100644<br>
&gt; &gt; --- a/arch/powerpc/include/asm/pci.h<br>
&gt; &gt; +++ b/arch/powerpc/include/asm/pci.h<br>
&gt; &gt; @@ -201,7 +201,7 @@ extern void pci_resource_to_user(const struct=
 pci_dev *dev, int bar,<br>
&gt; &gt; =A0extern void pcibios_setup_bus_devices(struct pci_bus *bus);<br=
>
&gt; &gt; =A0extern void pcibios_setup_bus_self(struct pci_bus *bus);<br>
&gt; &gt; =A0extern void pcibios_setup_phb_io_space(struct pci_controller *=
hose);<br>
&gt; &gt; -extern void pcibios_scan_phb(struct pci_controller *hose, void *=
sysdata);<br>
&gt; &gt; +extern void pcibios_scan_phb(struct pci_controller *hose);<br>
&gt; &gt;<br>
&gt; &gt; =A0#endif =A0 =A0 =A0 /* __KERNEL__ */<br>
&gt; &gt; =A0#endif /* __ASM_POWERPC_PCI_H */<br>
&gt; &gt; diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/ker=
nel/of_platform.c<br>
&gt; &gt; index b2c363e..9bd951c 100644<br>
&gt; &gt; --- a/arch/powerpc/kernel/of_platform.c<br>
&gt; &gt; +++ b/arch/powerpc/kernel/of_platform.c<br>
&gt; &gt; @@ -74,7 +74,7 @@ static int __devinit of_pci_phb_probe(struct pl=
atform_device *dev,<br>
&gt; &gt; =A0#endif /* CONFIG_EEH */<br>
&gt; &gt;<br>
&gt; &gt; =A0 =A0 =A0 /* Scan the bus */<br>
&gt; &gt; - =A0 =A0 pcibios_scan_phb(phb, dev-&gt;dev.of_node);<br>
&gt; &gt; + =A0 =A0 pcibios_scan_phb(phb);<br>
&gt; &gt; =A0 =A0 =A0 if (phb-&gt;bus =3D=3D NULL)<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENXIO;<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kern=
el/pci-common.c<br>
&gt; &gt; index eb341be..3cd85fa 100644<br>
&gt; &gt; --- a/arch/powerpc/kernel/pci-common.c<br>
&gt; &gt; +++ b/arch/powerpc/kernel/pci-common.c<br>
&gt; &gt; @@ -1688,13 +1688,8 @@ int early_find_capability(struct pci_contr=
oller *hose, int bus, int devfn,<br>
&gt; &gt; =A0/**<br>
&gt; &gt; =A0 * pci_scan_phb - Given a pci_controller, setup and scan the P=
CI bus<br>
&gt; &gt; =A0 * @hose: Pointer to the PCI host controller instance structur=
e<br>
&gt; &gt; - * @sysdata: value to use for sysdata pointer. =A0ppc32 and ppc6=
4 differ here<br>
&gt; &gt; - *<br>
&gt; &gt; - * Note: the &#39;data&#39; pointer is a temporary measure. =A0A=
s 32 and 64 bit<br>
&gt; &gt; - * pci code gets merged, this parameter should become unnecessar=
y because<br>
&gt; &gt; - * both will use the same value.<br>
&gt; &gt; =A0 */<br>
&gt; &gt; -void __devinit pcibios_scan_phb(struct pci_controller *hose, voi=
d *sysdata)<br>
&gt; &gt; +void __devinit pcibios_scan_phb(struct pci_controller *hose)<br>
&gt; &gt; =A0{<br>
&gt; &gt; =A0 =A0 =A0 struct pci_bus *bus;<br>
&gt; &gt; =A0 =A0 =A0 struct device_node *node =3D hose-&gt;dn;<br>
&gt; &gt; @@ -1704,13 +1699,13 @@ void __devinit pcibios_scan_phb(struct pc=
i_controller *hose, void *sysdata)<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0node ? node-&gt;full_name : &quot;=
&lt;NO NAME&gt;&quot;);<br>
&gt; &gt;<br>
&gt; &gt; =A0 =A0 =A0 /* Create an empty bus for the toplevel */<br>
&gt; &gt; - =A0 =A0 bus =3D pci_create_bus(hose-&gt;parent, hose-&gt;first_=
busno, hose-&gt;ops,<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sysdata);<br=
>
&gt; &gt; + =A0 =A0 bus =3D pci_create_bus(hose-&gt;parent, hose-&gt;first_=
busno, hose-&gt;ops, hose);<br>
&gt; &gt; =A0 =A0 =A0 if (bus =3D=3D NULL) {<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(&quot;Failed to create bus for=
 PCI domain %04x\n&quot;,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hose-&gt;global_numbe=
r);<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
&gt; &gt; =A0 =A0 =A0 }<br>
&gt; &gt; + =A0 =A0 bus-&gt;dev.of_node =3D of_node_get(node);<br>
&gt; &gt; =A0 =A0 =A0 bus-&gt;secondary =3D hose-&gt;first_busno;<br>
&gt; &gt; =A0 =A0 =A0 hose-&gt;bus =3D bus;<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/p=
ci_32.c<br>
&gt; &gt; index e7db5b4..bedb370 100644<br>
&gt; &gt; --- a/arch/powerpc/kernel/pci_32.c<br>
&gt; &gt; +++ b/arch/powerpc/kernel/pci_32.c<br>
&gt; &gt; @@ -381,7 +381,7 @@ static int __init pcibios_init(void)<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pci_assign_all_buses)<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hose-&gt;first_busno =
=3D next_busno;<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 hose-&gt;last_busno =3D 0xff;<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 pcibios_scan_phb(hose, hose);<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 pcibios_scan_phb(hose);<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_add_devices(hose-&gt;bus);<br=
>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pci_assign_all_buses || next_busn=
o &lt;=3D hose-&gt;last_busno)<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 next_busno =3D hose-&=
gt;last_busno + pcibios_assign_bus_offset;<br>
&gt; &gt; diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/p=
ci_64.c<br>
&gt; &gt; index 8515776..fc6452b 100644<br>
&gt; &gt; --- a/arch/powerpc/kernel/pci_64.c<br>
&gt; &gt; +++ b/arch/powerpc/kernel/pci_64.c<br>
&gt; &gt; @@ -64,7 +64,7 @@ static int __init pcibios_init(void)<br>
&gt; &gt;<br>
&gt; &gt; =A0 =A0 =A0 /* Scan all of the recorded PCI controllers. =A0*/<br=
>
&gt; &gt; =A0 =A0 =A0 list_for_each_entry_safe(hose, tmp, &amp;hose_list, l=
ist_node) {<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 pcibios_scan_phb(hose, hose-&gt;dn);<br=
>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 pcibios_scan_phb(hose);<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_add_devices(hose-&gt;bus);<br=
>
&gt; &gt; =A0 =A0 =A0 }<br>
&gt; &gt;<br>
&gt; &gt; @@ -242,10 +242,10 @@ long sys_pciconfig_iobase(long which, unsig=
ned long in_bus,<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus =3D NULL;<br>
&gt; &gt; =A0 =A0 =A0 }<br>
&gt; &gt; - =A0 =A0 if (bus =3D=3D NULL || bus-&gt;sysdata =3D=3D NULL)<br>
&gt; &gt; + =A0 =A0 if (bus =3D=3D NULL || bus-&gt;dev.of_node =3D=3D NULL)=
<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<br>
&gt; &gt;<br>
&gt; &gt; - =A0 =A0 hose_node =3D (struct device_node *)bus-&gt;sysdata;<br=
>
&gt; &gt; + =A0 =A0 hose_node =3D bus-&gt;dev.of_node;<br>
&gt; &gt; =A0 =A0 =A0 hose =3D PCI_DN(hose_node)-&gt;phb;<br>
&gt; &gt;<br>
&gt; &gt; =A0 =A0 =A0 switch (which) {<br>
&gt; &gt; diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/p=
ci_dn.c<br>
&gt; &gt; index d56b35e..2985268 100644<br>
&gt; &gt; --- a/arch/powerpc/kernel/pci_dn.c<br>
&gt; &gt; +++ b/arch/powerpc/kernel/pci_dn.c<br>
&gt; &gt; @@ -161,7 +161,7 @@ static void *is_devfn_node(struct device_node=
 *dn, void *data)<br>
&gt; &gt; =A0/*<br>
&gt; &gt; =A0 * This is the &quot;slow&quot; path for looking up a device_n=
ode from a<br>
&gt; &gt; =A0 * pci_dev. =A0It will hunt for the device under its parent&#3=
9;s<br>
&gt; &gt; - * phb and then update sysdata for a future fastpath.<br>
&gt; &gt; + * phb and then update of_node pointer.<br>
&gt; &gt; =A0 *<br>
&gt; &gt; =A0 * It may also do fixups on the actual device since this happe=
ns<br>
&gt; &gt; =A0 * on the first read/write.<br>
&gt; &gt; @@ -170,16 +170,19 @@ static void *is_devfn_node(struct device_no=
de *dn, void *data)<br>
&gt; &gt; =A0 * In this case it may probe for real hardware (&quot;just in =
case&quot;)<br>
&gt; &gt; =A0 * and add a device_node to the device tree if necessary.<br>
&gt; &gt; =A0 *<br>
&gt; &gt; + * Is this function necessary anymore now that dev-&gt;dev.of_no=
de is<br>
&gt; &gt; + * used to store the node pointer?<br>
&gt; &gt; + *<br>
&gt; &gt; =A0 */<br>
&gt; &gt; =A0struct device_node *fetch_dev_dn(struct pci_dev *dev)<br>
&gt; &gt; =A0{<br>
&gt; &gt; - =A0 =A0 struct device_node *orig_dn =3D dev-&gt;sysdata;<br>
&gt; &gt; + =A0 =A0 struct device_node *orig_dn =3D dev-&gt;dev.of_node;<br=
>
&gt; &gt; =A0 =A0 =A0 struct device_node *dn;<br>
&gt; &gt; =A0 =A0 =A0 unsigned long searchval =3D (dev-&gt;bus-&gt;number &=
lt;&lt; 8) | dev-&gt;devfn;<br>
&gt; &gt;<br>
&gt; &gt; =A0 =A0 =A0 dn =3D traverse_pci_devices(orig_dn, is_devfn_node, (=
void *)searchval);<br>
&gt; &gt; =A0 =A0 =A0 if (dn)<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 dev-&gt;sysdata =3D dn;<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev-&gt;dev.of_node =3D dn;<br>
&gt; &gt; =A0 =A0 =A0 return dn;<br>
&gt; &gt; =A0}<br>
&gt; &gt; =A0EXPORT_SYMBOL(fetch_dev_dn);<br>
&gt; &gt; diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/ker=
nel/pci_of_scan.c<br>
&gt; &gt; index e751506..1e89a72 100644<br>
&gt; &gt; --- a/arch/powerpc/kernel/pci_of_scan.c<br>
&gt; &gt; +++ b/arch/powerpc/kernel/pci_of_scan.c<br>
&gt; &gt; @@ -135,7 +135,7 @@ struct pci_dev *of_create_pci_dev(struct devi=
ce_node *node,<br>
&gt; &gt; =A0 =A0 =A0 pr_debug(&quot; =A0 =A0create device, devfn: %x, type=
: %s\n&quot;, devfn, type);<br>
&gt; &gt;<br>
&gt; &gt; =A0 =A0 =A0 dev-&gt;bus =3D bus;<br>
&gt; &gt; - =A0 =A0 dev-&gt;sysdata =3D node;<br>
&gt; &gt; + =A0 =A0 dev-&gt;dev.of_node =3D of_node_get(node);<br>
&gt; &gt; =A0 =A0 =A0 dev-&gt;dev.parent =3D bus-&gt;bridge;<br>
&gt; &gt; =A0 =A0 =A0 dev-&gt;dev.bus =3D &amp;pci_bus_type;<br>
&gt; &gt; =A0 =A0 =A0 dev-&gt;devfn =3D devfn;<br>
&gt; &gt; @@ -238,7 +238,7 @@ void __devinit of_scan_pci_bridge(struct devi=
ce_node *node,<br>
&gt; &gt; =A0 =A0 =A0 bus-&gt;primary =3D dev-&gt;bus-&gt;number;<br>
&gt; &gt; =A0 =A0 =A0 bus-&gt;subordinate =3D busrange[1];<br>
&gt; &gt; =A0 =A0 =A0 bus-&gt;bridge_ctl =3D 0;<br>
&gt; &gt; - =A0 =A0 bus-&gt;sysdata =3D node;<br>
&gt; &gt; + =A0 =A0 bus-&gt;dev.of_node =3D of_node_get(node);<br>
&gt; &gt;<br>
&gt; &gt; =A0 =A0 =A0 /* parse ranges property */<br>
&gt; &gt; =A0 =A0 =A0 /* PCI #address-cells =3D=3D 3 and #size-cells =3D=3D=
 2 always */<br>
&gt; &gt; diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/po=
werpc/platforms/pseries/pci_dlpar.c<br>
&gt; &gt; index 5fcc92a..3bf4488 100644<br>
&gt; &gt; --- a/arch/powerpc/platforms/pseries/pci_dlpar.c<br>
&gt; &gt; +++ b/arch/powerpc/platforms/pseries/pci_dlpar.c<br>
&gt; &gt; @@ -149,7 +149,7 @@ struct pci_controller * __devinit init_phb_dy=
namic(struct device_node *dn)<br>
&gt; &gt; =A0 =A0 =A0 if (dn-&gt;child)<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 eeh_add_device_tree_early(dn);<br>
&gt; &gt;<br>
&gt; &gt; - =A0 =A0 pcibios_scan_phb(phb, dn);<br>
&gt; &gt; + =A0 =A0 pcibios_scan_phb(phb);<br>
&gt; &gt; =A0 =A0 =A0 pcibios_finish_adding_to_bus(phb-&gt;bus);<br>
&gt; &gt;<br>
&gt; &gt; =A0 =A0 =A0 return phb;<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; To unsubscribe from this list: send the line &quot;unsubscribe li=
nux-kernel&quot; in<br>
&gt; &gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.=
org">majordomo@vger.kernel.org</a><br>
&gt; &gt; More majordomo info at =A0<a href=3D"http://vger.kernel.org/major=
domo-info.html">http://vger.kernel.org/majordomo-info.html</a><br>
&gt; &gt; Please read the FAQ at =A0<a href=3D"http://www.tux.org/lkml/">ht=
tp://www.tux.org/lkml/</a><br>
&gt;<br>
&gt;<br>
</p>

--000325575e52510b1d049b939b41--
