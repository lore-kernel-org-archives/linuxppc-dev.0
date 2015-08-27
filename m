Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE1631A0748
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 07:58:32 +1000 (AEST)
In-Reply-To: <1440655276-6596-1-git-send-email-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Wei Yang <weiyang@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [kernel] powerpc/iommu: Set default DMA offset in dma_dev_setup
Message-Id: <20150827215832.9A6A01401AB@ozlabs.org>
Date: Fri, 28 Aug 2015 07:58:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-27-08 at 06:01:16 UTC, Alexey Kardashevskiy wrote:
> "powerpc/iommu: Cleanup setting of DMA base/offset" expects that
> the default DMA offset is set from pnv_ioda_setup_bus_dma() which
> is correct unless it is SRIOV where the code flow is different - at
> the moment when pnv_ioda_setup_bus_dma() is called, there is no PE for
> the just created VF.
> 
> This adds missing set_dma_offset() to pnv_pci_ioda_dma_dev_setup()
> to cover the case of SRIOV.
> 
> Note that we still need set_dma_offset() in pnv_ioda_setup_bus_dma()
> as at the boot time pnv_pci_ioda_dma_dev_setup() is called when no PE
> was created yet, this happens at the PHB fixup stage.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0e1ffef02cf94e46f95957af

cheers
