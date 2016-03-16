Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQH801d9kzDr4l
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 03:32:16 +1100 (AEDT)
Date: Wed, 16 Mar 2016 10:32:07 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
 aik@ozlabs.ru, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
Subject: Re: [RFC PATCH v4 7/7] powerpc/powernv/pci-ioda: Add
 IOMMU_CAP_INTR_REMAP for IODA host bridge
Message-ID: <20160316103207.6fffb9b5@t450s.home>
In-Reply-To: <1457336918-3893-8-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1457336918-3893-8-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon,  7 Mar 2016 15:48:38 +0800
Yongji Xie <xyjxie@linux.vnet.ibm.com> wrote:

> This patch adds IOMMU_CAP_INTR_REMAP for IODA host bridge so that
> we can mmap MSI-X table in vfio driver.
> 
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index f90dc04..f01b9ab 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1955,6 +1955,20 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops = {
>  	.free = pnv_ioda2_table_free,
>  };
>  
> +static bool pnv_ioda_iommu_capable(enum iommu_cap cap)
> +{
> +	switch (cap) {
> +	case IOMMU_CAP_INTR_REMAP:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static struct iommu_ops pnv_ioda_iommu_ops = {
> +	.capable = pnv_ioda_iommu_capable,
> +};
> +
>  static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>  				      struct pnv_ioda_pe *pe, unsigned int base,
>  				      unsigned int segs)
> @@ -3078,6 +3092,9 @@ static void pnv_pci_ioda_fixup(void)
>  
>  	/* Link NPU IODA tables to their PCI devices. */
>  	pnv_npu_ioda_fixup();
> +
> +	/* Add IOMMU_CAP_INTR_REMAP */
> +	bus_set_iommu(&pci_bus_type, &pnv_ioda_iommu_ops);
>  }
>  
>  /*


Doesn't this set you up for a world of hurt?  bus_set_iommu() calls
iommu_bus_init() which sets up notifiers, which maybe you don't care
about, but it also means that iommu_domain_alloc(&pci_bus_type) will
segfault because you're not providing a domain_alloc callback here.
