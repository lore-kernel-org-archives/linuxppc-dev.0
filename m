Return-Path: <bhelgaas@google.com>
Received: from mail-gg0-f202.google.com (mail-gg0-f202.google.com
 [209.85.161.202])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E3E2A2C0301
 for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2012 06:12:54 +1000 (EST)
Received: by ggeh3 with SMTP id h3so388617gge.3
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2012 13:12:51 -0700 (PDT)
Date: Fri, 13 Jul 2012 14:12:50 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/7] pci: minimal alignment for bars of P2P bridges
Message-ID: <20120713201250.GB18587@google.com>
References: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
 <878dcc914319fd110ceda936c2ce5b6bb7a449ab.1340949637.git.shangw@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <878dcc914319fd110ceda936c2ce5b6bb7a449ab.1340949637.git.shangw@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, yinghai@kernel.org, linuxram@us.ibm.com,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 29, 2012 at 02:47:48PM +0800, Gavin Shan wrote:
> On some powerpc platforms, device BARs need to be assigned to separate
> "segments" of the address space in order for the error isolation and HW
> virtualization mechanisms (EEH) to work properly. Those "segments" have
> a minimum size that can be fairly large (16M). In order to be able to
> use the generic resource assignment code rather than re-inventing our
> own, we chose to group devices by bus. That way, a simple change of the
> minimum alignment requirements of resources assigned to PCI to PCI (P2P)
> bridges is enough to ensure that all BARs for devices below those bridges
> will fit into contiguous sets of segments and there will be no overlap.

If I understand correctly, you might have something like this:

  PCI host bridge to bus 0000:00
  pci_bus 0000:00: root bus resource [mem 0xc0000000-0xcfffffff]
  0000:00:01.0: PCI bridge to [bus 10-1f]
  0000:00:01.0:   bridge window [mem 0xc1000000-0xc1ffffff]
  0000:00:02.0: PCI bridge to [bus 20-2f]
  0000:00:02.0:   bridge window [mem 0xc2000000-0xc2ffffff]

where everything under bridge 00:01.0 is in one EEH segment, and
everything under 00:02.0 is in another.  In this case, each EEH
segment is 16MB.

I think your proposal is basically that when we add up resources required
below the P2P bridges, we round up to the default 1MB (the minimum P2P
bridge memory aperture size per spec) *or* to a larger value, e.g., 16MB,
if the architecture requires it.

That makes sense to me, but I have some implementation questions.

Your patches make the required alignment a property of the host bridge.
But don't you want to do this rounding up only at certain levels of the
hierarchy?  For example, what if you had another P2P bridge:

  0000:10:01.0: PCI bridge to [bus 18-1f]

I assume the devices on bus 0000:18 would still be in the first EEH
segment, and you wouldn't necessarily want to round up the 10:01.0
apertures to 16MB.

Maybe there should be an interface like this:

  resource_size_t __weak pcibios_window_alignment(struct pci_bus *bus,
						  unsigned long type)
  {
    if (type & IORESOURCE_MEM)
      return 1024*1024;		/* mem windows must be 1MB aligned */
    if (bus->self->io_window_1k)
      return 1024;
    return 4*1024;		/* I/O windows default to 4K alignment */
  }

that the arch could override?  Then you could return the 16MB alignment
for the top-level P2P bridge leading to an EEH segment, and use the
default alignment for P2P bridges *inside* the segment.

> This patch provides a way for the host bridge to override the default
> alignment values used by the resource allocation code for that purpose.
> 
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> Reviewed-by: Ram Pai <linuxram@us.ibm.com>
> Reviewed-by: Richard Yang <weiyang@linux.vnet.ibm.com>
> ---
>  drivers/pci/probe.c |    5 +++++
>  include/linux/pci.h |    8 ++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 658ac97..a196529 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -431,6 +431,11 @@ static struct pci_host_bridge *pci_alloc_host_bridge(struct pci_bus *b)
>  	if (bridge) {
>  		INIT_LIST_HEAD(&bridge->windows);
>  		bridge->bus = b;
> +
> +		/* Set minimal alignment shift of P2P bridges */
> +		bridge->io_align_shift = PCI_DEFAULT_IO_ALIGN_SHIFT;
> +		bridge->mem_align_shift = PCI_DEFAULT_MEM_ALIGN_SHIFT;
> +		bridge->pmem_align_shift = PCI_DEFAULT_PMEM_ALIGN_SHIFT;
>  	}
>  
>  	return bridge;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e66f4b2..2b2b38d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -376,9 +376,17 @@ struct pci_host_bridge_window {
>  	resource_size_t offset;		/* bus address + offset = CPU address */
>  };
>  
> +/* Default shits for P2P I/O and MMIO bar minimal alignment shifts */
> +#define PCI_DEFAULT_IO_ALIGN_SHIFT	12	/* 4KB  */
> +#define PCI_DEFAULT_MEM_ALIGN_SHIFT	20	/* 1MB  */
> +#define PCI_DEFAULT_PMEM_ALIGN_SHIFT	20	/* 1MB */
> +
>  struct pci_host_bridge {
>  	struct device dev;
>  	struct pci_bus *bus;		/* root bus */
> +	int io_align_shift;		/* P2P I/O bar minimal alignment shift  */
> +	int mem_align_shift;		/* P2P MMIO bar minimal alignment shift */
> +	int pmem_align_shift;		/* P2P prefetchable MMIO bar minimal alignment shift */
>  	struct list_head windows;	/* pci_host_bridge_windows */
>  	void (*release_fn)(struct pci_host_bridge *);
>  	void *release_data;
> -- 
> 1.7.9.5
> 
