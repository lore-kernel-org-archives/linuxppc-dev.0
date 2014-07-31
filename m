Return-Path: <hartb@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A4D61A073A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Aug 2014 05:24:45 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hartb@linux.vnet.ibm.com>;
 Thu, 31 Jul 2014 13:24:43 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id AA52219D803E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jul 2014 13:24:29 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6VJN23666715792
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jul 2014 21:23:02 +0200
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6VJOesX031509
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jul 2014 13:24:40 -0600
Date: Thu, 31 Jul 2014 14:24:37 -0500
From: Brian W Hart <hartb@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/powernv: update dev->dma_mask in pci_set_dma_mask()
 path
Message-ID: <20140731192437.GA18855@oc3347516403.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc defines various machine-specific routines for handling
pci_set_dma_mask().  The routines for machine "PowerNV" may neglect
to set dev->dma_mask.  This could confuse anyone (e.g. drivers) that
consult dev->dma_mask to find the current mask.  Set the dma_mask in
the PowerNV leaf routine.

Signed-off-by: Brian W. Hart <hartb@linux.vnet.ibm.com>
---
I assume the failure to set dma_mask in this path was just an oversight.
With this change everything still seems to work fine on my powernv setup,
and dev->dma_mask now carries the appropriate value after
pci_set_dma_mask(dev, DMA_BIT_MASK(64).

 arch/powerpc/platforms/powernv/pci-ioda.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index de19ede..3136ae2 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -491,6 +491,7 @@ static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
 		set_dma_ops(&pdev->dev, &dma_iommu_ops);
 		set_iommu_table_base(&pdev->dev, &pe->tce32_table);
 	}
+	*pdev->dev.dma_mask = dma_mask;
 	return 0;
 }
 
-- 
1.7.1
