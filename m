Return-Path: <bhelgaas@google.com>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 45677B6FF4
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 04:49:06 +1000 (EST)
Received: by lbgc1 with SMTP id c1so1802009lbg.15
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 11:49:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1340808525-24996-2-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340808525-24996-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1340808525-24996-2-git-send-email-shangw@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 27 Jun 2012 12:48:42 -0600
Message-ID: <CAErSpo64g0ZMJdW+YR-dH=dbcR0rApEf8sPzz7YWqb3v8O2V3Q@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] PCI: minimal alignment for bars of P2P bridges
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-pci@vger.kernel.org, yinghai@kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 27, 2012 at 8:48 AM, Gavin Shan <shangw@linux.vnet.ibm.com> wro=
te:
> On some powerpc platforms, device BARs need to be assigned to separate
> "segments" of the address space in order for the error isolation and HW
> virtualization mechanisms (EEH) to work properly. Those "segments" have
> a minimum size that can be fairly large (16M). In order to be able to
> use the generic resource assignment code rather than re-inventing our
> own, we chose to group devices by bus. That way, a simple change of the
> minimum alignment requirements of resources assigned to PCI to PCI (P2P)
> bridges is enough to ensure that all BARs for devices below those bridges
> will fit into contiguous sets of segments and there will be no overlap.

Is this something that is currently broken on powerpc?  I don't see
any corresponding powerpc change, like a removal of whatever the
previous way of doing this was.

I'm not sure this is generic enough to warrant putting it in the core
code (though I don't know whether we have any pcibios_*() hooks that
would allow us to do it in the arch).

> This patch provides a way for the host bridge to override the default
> alignment values used by the resource allocation code for that purpose.
>
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> Reviewed-by: Ram Pai <linuxram@us.ibm.com>
> Reviewed-by: Richard Yang <weiyang@linux.vnet.ibm.com>
> ---
> =A0drivers/pci/probe.c =A0 =A0 | =A0 =A05 +++++
> =A0drivers/pci/setup-bus.c | =A0 28 +++++++++++++++++++++-------
> =A0include/linux/pci.h =A0 =A0 | =A0 =A08 ++++++++
> =A03 files changed, 34 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 658ac97..a196529 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -431,6 +431,11 @@ static struct pci_host_bridge *pci_alloc_host_bridge=
(struct pci_bus *b)
> =A0 =A0 =A0 =A0if (bridge) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0INIT_LIST_HEAD(&bridge->windows);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bridge->bus =3D b;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set minimal alignment shift of P2P bridg=
es */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bridge->io_align_shift =3D PCI_DEFAULT_IO_A=
LIGN_SHIFT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bridge->mem_align_shift =3D PCI_DEFAULT_MEM=
_ALIGN_SHIFT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bridge->pmem_align_shift =3D PCI_DEFAULT_PM=
EM_ALIGN_SHIFT;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return bridge;
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 8fa2d4b..caebe98 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -706,10 +706,12 @@ static resource_size_t calculate_memsize(resource_s=
ize_t size,
> =A0static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0resource_size_t add_size, struct list_head=
 *realloc_head)
> =A0{
> + =A0 =A0 =A0 struct pci_host_bridge *phb;
> =A0 =A0 =A0 =A0struct pci_dev *dev;
> =A0 =A0 =A0 =A0struct resource *b_res =3D find_free_bus_resource(bus, IOR=
ESOURCE_IO);
> =A0 =A0 =A0 =A0unsigned long size =3D 0, size0 =3D 0, size1 =3D 0;
> =A0 =A0 =A0 =A0resource_size_t children_add_size =3D 0;
> + =A0 =A0 =A0 resource_size_t io_align;
>
> =A0 =A0 =A0 =A0if (!b_res)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> @@ -735,13 +737,17 @@ static void pbus_size_io(struct pci_bus *bus, resou=
rce_size_t min_size,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0children_a=
dd_size +=3D get_res_add_size(realloc_head, r);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 phb =3D find_pci_host_bridge(bus);

I guess this explains why you want find_pci_host_bridge() to take a
pci_bus, not a pci_dev..

> + =A0 =A0 =A0 io_align =3D (1 << phb->io_align_shift);
> +
> =A0 =A0 =A0 =A0size0 =3D calculate_iosize(size, min_size, size1,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size(b_res), 4096)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size(b_res), io_al=
ign);
> =A0 =A0 =A0 =A0if (children_add_size > add_size)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0add_size =3D children_add_size;
> =A0 =A0 =A0 =A0size1 =3D (!realloc_head || (realloc_head && !add_size)) ?=
 size0 :
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0calculate_iosize(size, min_size, add_size =
+ size1,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size(b_res), 4096)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size(b_res), io_al=
ign);
> =A0 =A0 =A0 =A0if (!size0 && !size1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (b_res->start || b_res->end)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_info(&bus->self->dev, =
"disabling bridge window "
> @@ -751,11 +757,11 @@ static void pbus_size_io(struct pci_bus *bus, resou=
rce_size_t min_size,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0/* Alignment of the IO window is always 4K */
> - =A0 =A0 =A0 b_res->start =3D 4096;
> + =A0 =A0 =A0 b_res->start =3D io_align;

This looks like something that will collide with the changes in the
pipe to support I/O windows smaller than 4K.

> =A0 =A0 =A0 =A0b_res->end =3D b_res->start + size0 - 1;
> =A0 =A0 =A0 =A0b_res->flags |=3D IORESOURCE_STARTALIGN;
> =A0 =A0 =A0 =A0if (size1 > size0 && realloc_head) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_to_list(realloc_head, bus->self, b_res,=
 size1-size0, 4096);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_to_list(realloc_head, bus->self, b_res,=
 size1-size0, io_align);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_printk(KERN_DEBUG, &bus->self->dev, "b=
ridge window "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%pR to [=
bus %02x-%02x] add_size %lx\n", b_res,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus->seco=
ndary, bus->subordinate, size1-size0);
> @@ -778,6 +784,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigne=
d long mask,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0resource_size_t add_size,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct list_head *realloc_=
head)
> =A0{
> + =A0 =A0 =A0 struct pci_host_bridge *phb;
> =A0 =A0 =A0 =A0struct pci_dev *dev;
> =A0 =A0 =A0 =A0resource_size_t min_align, align, size, size0, size1;
> =A0 =A0 =A0 =A0resource_size_t aligns[12]; =A0 =A0 /* Alignments from 1Mb=
 to 2Gb */
> @@ -785,10 +792,17 @@ static int pbus_size_mem(struct pci_bus *bus, unsig=
ned long mask,
> =A0 =A0 =A0 =A0struct resource *b_res =3D find_free_bus_resource(bus, typ=
e);
> =A0 =A0 =A0 =A0unsigned int mem64_mask =3D 0;
> =A0 =A0 =A0 =A0resource_size_t children_add_size =3D 0;
> + =A0 =A0 =A0 int mem_align_shift;
>
> =A0 =A0 =A0 =A0if (!b_res)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> + =A0 =A0 =A0 phb =3D find_pci_host_bridge(bus);
> + =A0 =A0 =A0 if (type & IORESOURCE_PREFETCH)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mem_align_shift =3D phb->pmem_align_shift;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mem_align_shift =3D phb->mem_align_shift;
> +
> =A0 =A0 =A0 =A0memset(aligns, 0, sizeof(aligns));
> =A0 =A0 =A0 =A0max_order =3D 0;
> =A0 =A0 =A0 =A0size =3D 0;
> @@ -818,8 +832,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigne=
d long mask,
> =A0#endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* For bridges size !=3D a=
lignment */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0align =3D pci_resource_ali=
gnment(dev, r);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 order =3D __ffs(align) - 20=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (order > 11) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 order =3D __ffs(align) - me=
m_align_shift;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (order > (11 - (mem_alig=
n_shift - 20))) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_warn(&=
dev->dev, "disabling BAR %d: %pR "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "(bad alignment %#llx)\n", i, r,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (unsigned long long) align);
> @@ -846,7 +860,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigne=
d long mask,
> =A0 =A0 =A0 =A0for (order =3D 0; order <=3D max_order; order++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0resource_size_t align1 =3D 1;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 align1 <<=3D (order + 20);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 align1 <<=3D (order + mem_align_shift);

This code must encode somewhere the assumption that mem windows must
be at least 1MB aligned.  Maybe it has something to do with the "20"
constants above.  Independent of your patch, it'd be nice to make this
more explicit.

>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!align)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0min_align =3D align1;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2b559f1..879de4e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -376,9 +376,17 @@ struct pci_host_bridge_window {
> =A0 =A0 =A0 =A0resource_size_t offset; =A0 =A0 =A0 =A0 /* bus address + o=
ffset =3D CPU address */
> =A0};
>
> +/* Default shits for P2P I/O and MMIO bar minimal alignment shifts */

"Default shifts"

> +#define PCI_DEFAULT_IO_ALIGN_SHIFT =A0 =A0 12 =A0 =A0 =A0/* 4KB =A0*/
> +#define PCI_DEFAULT_MEM_ALIGN_SHIFT =A0 =A020 =A0 =A0 =A0/* 1MB =A0*/
> +#define PCI_DEFAULT_PMEM_ALIGN_SHIFT =A0 20 =A0 =A0 =A0/* 1MB */
> +
> =A0struct pci_host_bridge {
> =A0 =A0 =A0 =A0struct device dev;
> =A0 =A0 =A0 =A0struct pci_bus *bus; =A0 =A0 =A0 =A0 =A0 =A0/* root bus */
> + =A0 =A0 =A0 int io_align_shift; =A0 =A0 =A0 =A0 =A0 =A0 /* P2P I/O bar =
minimal alignment shift =A0*/
> + =A0 =A0 =A0 int mem_align_shift; =A0 =A0 =A0 =A0 =A0 =A0/* P2P MMIO bar=
 minimal alignment shift */
> + =A0 =A0 =A0 int pmem_align_shift; =A0 =A0 =A0 =A0 =A0 /* P2P prefetchab=
le MMIO bar minimal alignment shift */
> =A0 =A0 =A0 =A0struct list_head windows; =A0 =A0 =A0 /* pci_host_bridge_w=
indows */
> =A0 =A0 =A0 =A0void (*release_fn)(struct pci_host_bridge *);
> =A0 =A0 =A0 =A0void *release_data;
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
