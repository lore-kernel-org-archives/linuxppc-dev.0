Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnW3d1GpBzDqb5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 22:36:13 +1100 (AEDT)
In-Reply-To: <20170221024020.47631-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kernel] powerpc/powernv/npu: Remove dead iommu code
Message-Id: <3vnW3d0Wxlz9s82@ozlabs.org>
Date: Tue, 21 Mar 2017 22:36:12 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-02-21 at 02:40:20 UTC, Alexey Kardashevskiy wrote:
> PNV_IODA_PE_DEV is only used for NPU devices (emulated PCI bridges
> representing NVLink). These are added to IOMMU groups with corresponding
> NVIDIA devices after all non-NPU PEs are setup; a special helper -
> pnv_pci_ioda_setup_iommu_api() - handles this in pnv_pci_ioda_fixup().
> 
> The pnv_pci_ioda2_setup_dma_pe() helper sets up DMA for a PE. It is called
> for VFs (so it does not handle NPU case) and PCI bridges but only
> IODA1 and IODA2 types. An NPU bridge has its own type id (PNV_PHB_NPU)
> so pnv_pci_ioda2_setup_dma_pe() cannot be called on NPU and therefore
> (pe->flags & PNV_IODA_PE_DEV) is always "false".
> 
> This removes not used iommu_add_device(). This should not cause any
> behavioral change.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/20f13b95eef1b3ca75535e313357b0

cheers
