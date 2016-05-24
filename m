Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDnjn4mXwzDqNq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 06:55:25 +1000 (AEST)
Date: Tue, 24 May 2016 15:55:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, alex.williamson@redhat.com,
 bhelgaas@google.com, aik@ozlabs.ru, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, joro@8bytes.org,
 warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, eric.auger@linaro.org,
 will.deacon@arm.com, gwshan@linux.vnet.ibm.com,
 David.Laight@ACULAB.COM, alistair@popple.id.au, ruscur@russell.cc
Subject: Re: [PATCH 1/5] PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
Message-ID: <20160524205519.GA16463@localhost>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1461761010-5452-2-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461761010-5452-2-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 27, 2016 at 08:43:26PM +0800, Yongji Xie wrote:
> We introduce a new pci_bus_flags, PCI_BUS_FLAGS_MSI_REMAP
> which indicates all devices on the bus are protected by the
> hardware which supports IRQ remapping(intel naming).

This changelog is ambiguous.  It's possible that there is hardware
that *supports* IRQ remapping, but does not actually *do* IRQ
remapping.  For example, an IRQ remapping capability may be present
but not enabled.

I think your intent is to set this flag only when MSI remapping is
actually *enabled* for all devices on the bus.

I'd also like to know exactly what protection is implied by
PCI_BUS_FLAGS_MSI_REMAP and IOMMU_CAP_INTR_REMAP.  I guess it means a
device can only generate MSIs to a certain set of CPUs?  I assume the
remapping hardware only checks the target address, not the data being
written?

> This flag will be used to know whether it's safe to expose
> MSI-X tables of PCI BARs to userspace. Because the capability
> of IRQ remapping can guarantee the PCI device cannot trigger
> MSIs that correspond to interrupt IDs of other devices.
> 
> There is a existing flag for this in the IOMMU space:
> 
> enum iommu_cap {
> 	IOMMU_CAP_CACHE_COHERENCY,
> --->	IOMMU_CAP_INTR_REMAP,
> 	IOMMU_CAP_NOEXEC,
> };
> 
> and Eric also posted a patchset [1] to abstract this
> capability on MSI controller side for ARM. But it would
> make sense to have a more common flag like
> PCI_BUS_FLAGS_MSI_REMAP in this patch so that we can use
> a universal flag to test this capability on PCI side for
> different archs.
> 
> [1] http://www.spinics.net/lists/kvm/msg130256.html
> 
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>  include/linux/pci.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 27df4a6..d619228 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -193,6 +193,7 @@ typedef unsigned short __bitwise pci_bus_flags_t;
>  enum pci_bus_flags {
>  	PCI_BUS_FLAGS_NO_MSI   = (__force pci_bus_flags_t) 1,
>  	PCI_BUS_FLAGS_NO_MMRBC = (__force pci_bus_flags_t) 2,
> +	PCI_BUS_FLAGS_MSI_REMAP = (__force pci_bus_flags_t) 4,
>  };
>  
>  /* These values come from the PCI Express Spec */
> -- 
> 1.7.9.5
> 
