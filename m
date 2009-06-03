Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A2FF9DDDF4
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jun 2009 14:21:32 +1000 (EST)
Date: Wed, 3 Jun 2009 14:21:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/pseries: fix warnings when printing resource_size_t
Message-Id: <20090603142130.02be8c2d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

resource_size_t is 64 bits on pseries

Gets rid of these warnings:

arch/powerpc/platforms/pseries/iommu.c: In function 'pci_dma_bus_setup_pSeries':
arch/powerpc/platforms/pseries/iommu.c:391: warning: format '%lx' expects type 'long unsigned int', but argument 2 has type 'resource_size_t'
arch/powerpc/platforms/pseries/iommu.c:417: warning: format '%lx' expects type 'long unsigned int', but argument 2 has type 'resource_size_t'

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/pseries/iommu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 3ee01b4..661c8e0 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -388,7 +388,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 
 		while (pci->phb->dma_window_size * children > 0x80000000ul)
 			pci->phb->dma_window_size >>= 1;
-		pr_debug("No ISA/IDE, window size is 0x%lx\n",
+		pr_debug("No ISA/IDE, window size is 0x%llx\n",
 			 pci->phb->dma_window_size);
 		pci->phb->dma_window_base_cur = 0;
 
@@ -414,7 +414,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	while (pci->phb->dma_window_size * children > 0x70000000ul)
 		pci->phb->dma_window_size >>= 1;
 
-	pr_debug("ISA/IDE, window size is 0x%lx\n", pci->phb->dma_window_size);
+	pr_debug("ISA/IDE, window size is 0x%llx\n", pci->phb->dma_window_size);
 }
 
 
-- 
1.6.3.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
