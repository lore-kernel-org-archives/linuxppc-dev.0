Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D1376B6FA0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2012 12:46:23 +1000 (EST)
Message-ID: <1340246774.28143.221.camel@pasglop>
Subject: Re: [PATCH] PPC: PCI: Fix pcibios_io_space_offset() so it works for
 32-bit ptr/64-bit rsrcs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ben Collins <ben.c@servergy.com>, Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 21 Jun 2012 12:46:14 +1000
In-Reply-To: <4DC27253-67FC-4A55-8C78-7782D9D0CF53@servergy.com>
References: <4DC27253-67FC-4A55-8C78-7782D9D0CF53@servergy.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(Bjorn, added you back because I ended up digging a shitload
of issues including some generic ... see below)

On Tue, 2012-06-05 at 23:50 -0400, Ben Collins wrote:
> The commit introducing pcibios_io_space_offset() was ignoring 32-bit to
> 64-bit sign extention, which is the case on ppc32 with 64-bit resource
> addresses. This only seems to have shown up while running under QEMU for
> e500mc target. It may or may be suboptimal that QEMU has an IO base
> address > 32-bits for the e500-pci implementation, but 1) it's still a
> regression and 2) it's more correct to handle things this way.

So I came to the conclusion that this isn't the right fix... what we
have is an "interesting" combinations of issues here and I'll have to
dig with Bjorn to sort them all out.

In the meantime, let me know if the "quick fix" below works for you
as a workaround:

@@ -734,7 +740,7 @@ void __devinit pci_process_bridge_OF_ranges(struct pci_contr
                        hose->io_base_virt = ioremap(cpu_addr, size);
 
                        /* Expect trouble if pci_addr is not 0 */
-                       if (primary)
+                       if (primary || !isa_io_base)
                                isa_io_base =
                                        (unsigned long)hose->io_base_virt;

(Note: The root of the qemu issue seems to be that qemu doesn't accept
an IO BAR with a value of 0 as a valid IO BAR... which is arguably a
qemu bug. However, we shouldn't have assigned that if it wasn't for
a bunch of other nasties)

Now, we have a combination of problems here Bjorn. A bunch of them are
powerpc specific and I'll fix them, but I'm hitting a couple of nasties
in the generic resource allocation code:

 * I'm not too happy with our pcibios_io_space_offset() sign extension,
but that's no biggie, I will fix that

 * It triggers a bunch of other problems where quite a bit of code
in pci-common.c seems to be assuming 32-bit arithmetic when messing
around with the port remapping, so I have fixes for all of that

 * Additionally, we end up with a crazy offset for IO because our
isa_io_base is only set if we mark a host bridge as "primary" and it
looks like the FSL code doesn't mark any. So our isa_io_base is 0
instead of the virt base of the first bridge, and thus our resource
offsets are equal to the virt base of the IO space of the bridge :-)
This isn't wrong per-se, ie, it -should- still work, but it then
trigger interesting problems. The patch above "corrects" that by making
isa_io_base default to the first bridge IO base if there's no primary.

 * PCIBIOS_IO_MIN (and MEM_MIN) are bogus... On most architectures
they represent a bus address, but the generic code uses them as a
resource address. So they don't work and we end up handing out
an IO resource equal to 0 (bus) instead of 0x1000 (bus) because the
offset'ed resource address isn't smaller than the min. Now I do have a
patch to fix that in the generic code, but I suspect that will break
a couple of archs:

arch/mn10300/include/asm/pci.h:#define PCIBIOS_MIN_IO           0xBE000004
arch/alpha/include/asm/pci.h:#define PCIBIOS_MIN_IO             alpha_mv.min_io_address

and maybe some mips stuff, I'm not sure. Do those archs do any
offsetting ? If they do we might want to change those defines
along with my patch:

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index eea85da..ec429f3 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -131,10 +131,20 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
                int resno, resource_size_t size, resource_size_t align)
 {
        struct resource *res = dev->resource + resno;
+       struct resource min_res;
+       struct pci_bus_region min_reg;
        resource_size_t min;
        int ret;
 
-       min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
+       /*
+        * We convert PCIBIOS_MIN_IO/MEM from bus addresses to
+        * resources before passing them to pci_bus_alloc_resource
+        */
+       min_res.flags = res->flags;
+       min_reg.start =  (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
+       min_reg.end = min_reg.start;
+       pcibios_bus_to_resource(dev, &min_res, &min_reg);
+       min = min_res.start;
 
        /* First, try exact prefetching match.. */
        ret = pci_bus_alloc_resource(bus, res, size, align, min,

 * Additionally, there's another problem inside pci_bus_alloc_resource()
itself:

		/* Ok, try it out.. */
		ret = allocate_resource(r, res, size,
					r->start ? : min,
					max, align,
					alignf, alignf_data);

See the r->start ? : min ?

It only applies the "min" if r->start is 0.... now we have a hack in arch/powerpc
to clear out resources we think are unassigned. Unfortunately that hack got broken
when moving the offett'ing to generic code because it now tests the resource start
rather than the bus address (but thinks it tests the bus address).

So with a fix for that hack, I set r->start to 0 for anything that originally had
a "bus address" of 0, and the above passes, I get min, and things work. Pfiew !

Maybe a better thing to do would be to test if r->start < min ? That would work
but maybe it subtly breaks some x86 stuff where we want BIOS assigned addresses
< min to remain in place ?

What do you reckon ?

Cheers,
Ben.
	

> Signed-off-by: Ben Collins <bcollins@ubuntu.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/pci-common.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 8e78e93..be9ced7 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1477,9 +1477,15 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
>  	return pci_enable_resources(dev, mask);
>  }
>  
> +/* Before assuming too much here, take care to realize that we need sign
> + * extension from 32-bit pointers to 64-bit resource addresses to work.
> + */
>  resource_size_t pcibios_io_space_offset(struct pci_controller *hose)
>  {
> -	return (unsigned long) hose->io_base_virt - _IO_BASE;
> +	long vbase = (long)hose->io_base_virt;
> +	long io_base = _IO_BASE;
> +
> +	return (resource_size_t)(vbase - io_base);
>  }
>  
>  static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose, struct list_head *resources)
