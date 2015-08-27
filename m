Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC5271A0545
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 16:17:36 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 27 Aug 2015 16:17:34 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 03E822BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 16:17:33 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7R6HMQQ10027010
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 16:17:30 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7R6GxHo014006
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 16:17:00 +1000
Date: Thu, 27 Aug 2015 16:16:35 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH kernel] powerpc/iommu: Set default DMA offset in
 dma_dev_setup
Message-ID: <20150827061635.GA9648@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1440655276-6596-1-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440655276-6596-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 27, 2015 at 04:01:16PM +1000, Alexey Kardashevskiy wrote:
>"powerpc/iommu: Cleanup setting of DMA base/offset" expects that
>the default DMA offset is set from pnv_ioda_setup_bus_dma() which
>is correct unless it is SRIOV where the code flow is different - at
>the moment when pnv_ioda_setup_bus_dma() is called, there is no PE for
>the just created VF.
>

The PEs for VFs are ready at the moment. We don't have pci_dev for
VFs actually.

>This adds missing set_dma_offset() to pnv_pci_ioda_dma_dev_setup()
>to cover the case of SRIOV.
>
>Note that we still need set_dma_offset() in pnv_ioda_setup_bus_dma()
>as at the boot time pnv_pci_ioda_dma_dev_setup() is called when no PE
>was created yet, this happens at the PHB fixup stage.
>
>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks,
Gavin

>---
>
>Makes sense to squash it to "powerpc/iommu: Cleanup setting of DMA base/offset".
>
>
>---
> arch/powerpc/platforms/powernv/pci-ioda.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 2c286b57..af875c1 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -1590,6 +1590,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
>
> 	pe = &phb->ioda.pe_array[pdn->pe_number];
> 	WARN_ON(get_dma_ops(&pdev->dev) != &dma_iommu_ops);
>+	set_dma_offset(&pdev->dev, pe->tce_bypass_base);
> 	set_iommu_table_base(&pdev->dev, pe->table_group.tables[0]);
> 	/*
> 	 * Note: iommu_add_device() will fail here as
>-- 
>2.4.0.rc3.8.gfb3e7d5
>
