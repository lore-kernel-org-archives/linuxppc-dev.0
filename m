Return-Path: <alwillia@redhat.com>
Received: from mx4-phx2.redhat.com (mx4-phx2.redhat.com [209.132.183.25])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 86BB61A0E27
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jan 2016 06:05:54 +1100 (AEDT)
Date: Fri, 29 Jan 2016 14:05:44 -0500 (EST)
From: Alex Williamson <alex.williamson@redhat.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
 aik@ozlabs.ru, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
Message-ID: <163133676.20416948.1454094344181.JavaMail.zimbra@redhat.com>
In-Reply-To: <56AB4182.5060501@linux.vnet.ibm.com>
References: <1452841574-2781-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1452841574-2781-4-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1454021182.23148.6.camel@redhat.com> <56AB4182.5060501@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 3/5] PCI: Add host bridge attribute to indicate
 filtering of MSIs is supported
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



----- Original Message -----
> On 2016/1/29 6:46, Alex Williamson wrote:
> > On Fri, 2016-01-15 at 15:06 +0800, Yongji Xie wrote:
> >> MSI-X tables are not allowed to be mmapped in vfio-pci
> >> driver in case that user get to touch this directly.
> >> This will cause some performance issues when when PCI
> >> adapters have critical registers in the same page as
> >> the MSI-X table.
> >>   
> >> However, some kind of PCI host bridge such as IODA bridge
> >> on Power support filtering of MSIs, which can ensure that a
> >> given pci device can only shoot the MSIs assigned for it.
> >> So we think it's safe to expose the MSI-X table to userspace
> >> if filtering of MSIs is supported because the exposed MSI-X
> >> table can't be used to do harm to other memory space.
> >>   
> >> To support this case, this patch adds a pci_host_bridge
> >> attribute to indicate if this PCI host bridge supports
> >> filtering of MSIs.
> >>   
> >> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> >> ---
> >>   drivers/pci/host-bridge.c |    6 ++++++
> >>   include/linux/pci.h       |    3 +++
> >>   2 files changed, 9 insertions(+)
> >>   
> >> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> >> index 5f4a2e0..c029267 100644
> >> --- a/drivers/pci/host-bridge.c
> >> +++ b/drivers/pci/host-bridge.c
> >> @@ -96,3 +96,9 @@ void pcibios_bus_to_resource(struct pci_bus *bus, struct
> >> resource *res,
> >>   	res->end = region->end + offset;
> >>   }
> >>   EXPORT_SYMBOL(pcibios_bus_to_resource);
> >> +
> >> +bool pci_host_bridge_msi_filtered_enabled(struct pci_dev *pdev)
> >> +{
> >> +	return pci_find_host_bridge(pdev->bus)->msi_filtered;
> >> +}
> >> +EXPORT_SYMBOL_GPL(pci_host_bridge_msi_filtered_enabled);
> >> diff --git a/include/linux/pci.h b/include/linux/pci.h
> >> index b640d65..b952b78 100644
> >> --- a/include/linux/pci.h
> >> +++ b/include/linux/pci.h
> >> @@ -412,6 +412,7 @@ struct pci_host_bridge {
> >>   	void (*release_fn)(struct pci_host_bridge *);
> >>   	void *release_data;
> >>   	unsigned int ignore_reset_delay:1;	/* for entire hierarchy */
> >> +	unsigned int msi_filtered:1;	/* support filtering of MSIs */
> >>   	/* Resource alignment requirements */
> >>   	resource_size_t (*align_resource)(struct pci_dev *dev,
> >>   			const struct resource *res,
> >> @@ -430,6 +431,8 @@ void pci_set_host_bridge_release(struct
> >> pci_host_bridge *bridge,
> >>   
> >>   int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
> >>   
> >> +bool pci_host_bridge_msi_filtered_enabled(struct pci_dev *pdev);
> >> +
> >>   /*
> >>    * The first PCI_BRIDGE_RESOURCE_NUM PCI bus resources (those that
> >>    correspond
> >>    * to P2P or CardBus bridge windows) go in a table.  Additional ones
> >>    (for
> > Don't we already have a flag for this in the IOMMU space?
> >
> > enum iommu_cap {
> >          IOMMU_CAP_CACHE_COHERENCY,      /* IOMMU can enforce cache
> >          coherent DMA
> >                                             transactions */
> > --->    IOMMU_CAP_INTR_REMAP,           /* IOMMU supports interrupt
> > isolation */
> >          IOMMU_CAP_NOEXEC,               /* IOMMU_NOEXEC flag */
> > };
> >
> 
> I saw this flag had been enabled in x86 and ARM arch.
> 
> I'm not sure whether we can mmap MSI-X table in those archs. I just
> verify it on PPC64 arch.

Unfortunately that's not a very good excuse for creating an alternate implementation.  When x86 implements interrupt remapping, we get fine grained isolation of MSI vectors and we've always taken this flag to mean that the system is isolated from devices that may perform DoS attacks with MSI writes.  I'm not entirely sure whether ARM really provides that degree of isolation, but they would be incorrect is exposing the capability if they do not.  Thanks,

Alex
