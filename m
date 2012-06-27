Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9493AB6FF4
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 07:57:52 +1000 (EST)
Message-ID: <1340834259.3732.79.camel@pasglop>
Subject: Re: [PATCH V4 2/2] PCI: minimal alignment for bars of P2P bridges
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 28 Jun 2012 07:57:39 +1000
In-Reply-To: <CAErSpo64g0ZMJdW+YR-dH=dbcR0rApEf8sPzz7YWqb3v8O2V3Q@mail.gmail.com>
References: <1340808525-24996-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1340808525-24996-2-git-send-email-shangw@linux.vnet.ibm.com>
 <CAErSpo64g0ZMJdW+YR-dH=dbcR0rApEf8sPzz7YWqb3v8O2V3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org, yinghai@kernel.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-06-27 at 12:48 -0600, Bjorn Helgaas wrote:
> On Wed, Jun 27, 2012 at 8:48 AM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> > On some powerpc platforms, device BARs need to be assigned to separate
> > "segments" of the address space in order for the error isolation and HW
> > virtualization mechanisms (EEH) to work properly. Those "segments" have
> > a minimum size that can be fairly large (16M). In order to be able to
> > use the generic resource assignment code rather than re-inventing our
> > own, we chose to group devices by bus. That way, a simple change of the
> > minimum alignment requirements of resources assigned to PCI to PCI (P2P)
> > bridges is enough to ensure that all BARs for devices below those bridges
> > will fit into contiguous sets of segments and there will be no overlap.
> 
> Is this something that is currently broken on powerpc?  I don't see
> any corresponding powerpc change, like a removal of whatever the
> previous way of doing this was.

Subsequent patch. The goal is to get rid of the bulk of the custom
resource allocation code in arch/powerpc/platforms/powernv/pci-ioda.c
where we basically re-implement it all (well I did) but without handling
all the special & corner cases that the generic code does.

The root of the problem is the need to segment the MMIO and IO spaces
based on a somewhat fixed (HW driven) segment size and have devices
isolated in their own groups of segments.

This is related to our "EEH" advanced error handling scheme which among
other things can properly connect errors triggered by MMIO (target
aborts, UE responses, etc...) to the actual device or driver.

> I'm not sure this is generic enough to warrant putting it in the core
> code (though I don't know whether we have any pcibios_*() hooks that
> would allow us to do it in the arch).

We don't have such hooks. This is the less invasive approach as far as I
can tell.

Cheers,
Ben.

> > This patch provides a way for the host bridge to override the default
> > alignment values used by the resource allocation code for that purpose.
> >
> > Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> > Reviewed-by: Ram Pai <linuxram@us.ibm.com>
> > Reviewed-by: Richard Yang <weiyang@linux.vnet.ibm.com>
> > ---
> >  drivers/pci/probe.c     |    5 +++++
> >  drivers/pci/setup-bus.c |   28 +++++++++++++++++++++-------
> >  include/linux/pci.h     |    8 ++++++++
> >  3 files changed, 34 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 658ac97..a196529 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -431,6 +431,11 @@ static struct pci_host_bridge *pci_alloc_host_bridge(struct pci_bus *b)
> >        if (bridge) {
> >                INIT_LIST_HEAD(&bridge->windows);
> >                bridge->bus = b;
> > +
> > +               /* Set minimal alignment shift of P2P bridges */
> > +               bridge->io_align_shift = PCI_DEFAULT_IO_ALIGN_SHIFT;
> > +               bridge->mem_align_shift = PCI_DEFAULT_MEM_ALIGN_SHIFT;
> > +               bridge->pmem_align_shift = PCI_DEFAULT_PMEM_ALIGN_SHIFT;
> >        }
> >
> >        return bridge;
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 8fa2d4b..caebe98 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -706,10 +706,12 @@ static resource_size_t calculate_memsize(resource_size_t size,
> >  static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
> >                resource_size_t add_size, struct list_head *realloc_head)
> >  {
> > +       struct pci_host_bridge *phb;
> >        struct pci_dev *dev;
> >        struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO);
> >        unsigned long size = 0, size0 = 0, size1 = 0;
> >        resource_size_t children_add_size = 0;
> > +       resource_size_t io_align;
> >
> >        if (!b_res)
> >                return;
> > @@ -735,13 +737,17 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
> >                                children_add_size += get_res_add_size(realloc_head, r);
> >                }
> >        }
> > +
> > +       phb = find_pci_host_bridge(bus);
> 
> I guess this explains why you want find_pci_host_bridge() to take a
> pci_bus, not a pci_dev..
> 
> > +       io_align = (1 << phb->io_align_shift);
> > +
> >        size0 = calculate_iosize(size, min_size, size1,
> > -                       resource_size(b_res), 4096);
> > +                       resource_size(b_res), io_align);
> >        if (children_add_size > add_size)
> >                add_size = children_add_size;
> >        size1 = (!realloc_head || (realloc_head && !add_size)) ? size0 :
> >                calculate_iosize(size, min_size, add_size + size1,
> > -                       resource_size(b_res), 4096);
> > +                       resource_size(b_res), io_align);
> >        if (!size0 && !size1) {
> >                if (b_res->start || b_res->end)
> >                        dev_info(&bus->self->dev, "disabling bridge window "
> > @@ -751,11 +757,11 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
> >                return;
> >        }
> >        /* Alignment of the IO window is always 4K */
> > -       b_res->start = 4096;
> > +       b_res->start = io_align;
> 
> This looks like something that will collide with the changes in the
> pipe to support I/O windows smaller than 4K.
> 
> >        b_res->end = b_res->start + size0 - 1;
> >        b_res->flags |= IORESOURCE_STARTALIGN;
> >        if (size1 > size0 && realloc_head) {
> > -               add_to_list(realloc_head, bus->self, b_res, size1-size0, 4096);
> > +               add_to_list(realloc_head, bus->self, b_res, size1-size0, io_align);
> >                dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window "
> >                                 "%pR to [bus %02x-%02x] add_size %lx\n", b_res,
> >                                 bus->secondary, bus->subordinate, size1-size0);
> > @@ -778,6 +784,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
> >                        resource_size_t add_size,
> >                        struct list_head *realloc_head)
> >  {
> > +       struct pci_host_bridge *phb;
> >        struct pci_dev *dev;
> >        resource_size_t min_align, align, size, size0, size1;
> >        resource_size_t aligns[12];     /* Alignments from 1Mb to 2Gb */
> > @@ -785,10 +792,17 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
> >        struct resource *b_res = find_free_bus_resource(bus, type);
> >        unsigned int mem64_mask = 0;
> >        resource_size_t children_add_size = 0;
> > +       int mem_align_shift;
> >
> >        if (!b_res)
> >                return 0;
> >
> > +       phb = find_pci_host_bridge(bus);
> > +       if (type & IORESOURCE_PREFETCH)
> > +               mem_align_shift = phb->pmem_align_shift;
> > +       else
> > +               mem_align_shift = phb->mem_align_shift;
> > +
> >        memset(aligns, 0, sizeof(aligns));
> >        max_order = 0;
> >        size = 0;
> > @@ -818,8 +832,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
> >  #endif
> >                        /* For bridges size != alignment */
> >                        align = pci_resource_alignment(dev, r);
> > -                       order = __ffs(align) - 20;
> > -                       if (order > 11) {
> > +                       order = __ffs(align) - mem_align_shift;
> > +                       if (order > (11 - (mem_align_shift - 20))) {
> >                                dev_warn(&dev->dev, "disabling BAR %d: %pR "
> >                                         "(bad alignment %#llx)\n", i, r,
> >                                         (unsigned long long) align);
> > @@ -846,7 +860,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
> >        for (order = 0; order <= max_order; order++) {
> >                resource_size_t align1 = 1;
> >
> > -               align1 <<= (order + 20);
> > +               align1 <<= (order + mem_align_shift);
> 
> This code must encode somewhere the assumption that mem windows must
> be at least 1MB aligned.  Maybe it has something to do with the "20"
> constants above.  Independent of your patch, it'd be nice to make this
> more explicit.
> 
> >
> >                if (!align)
> >                        min_align = align1;
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 2b559f1..879de4e 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -376,9 +376,17 @@ struct pci_host_bridge_window {
> >        resource_size_t offset;         /* bus address + offset = CPU address */
> >  };
> >
> > +/* Default shits for P2P I/O and MMIO bar minimal alignment shifts */
> 
> "Default shifts"
> 
> > +#define PCI_DEFAULT_IO_ALIGN_SHIFT     12      /* 4KB  */
> > +#define PCI_DEFAULT_MEM_ALIGN_SHIFT    20      /* 1MB  */
> > +#define PCI_DEFAULT_PMEM_ALIGN_SHIFT   20      /* 1MB */
> > +
> >  struct pci_host_bridge {
> >        struct device dev;
> >        struct pci_bus *bus;            /* root bus */
> > +       int io_align_shift;             /* P2P I/O bar minimal alignment shift  */
> > +       int mem_align_shift;            /* P2P MMIO bar minimal alignment shift */
> > +       int pmem_align_shift;           /* P2P prefetchable MMIO bar minimal alignment shift */
> >        struct list_head windows;       /* pci_host_bridge_windows */
> >        void (*release_fn)(struct pci_host_bridge *);
> >        void *release_data;
> > --
> > 1.7.9.5
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
