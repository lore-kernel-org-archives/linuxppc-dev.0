Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdRZM3msDzDqpJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 21:30:35 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 16/38] powerpc/pasemi: Remove IOBMAP allocation from platform
 probe()
Date: Mon, 27 Jun 2016 21:29:14 +1000
Message-Id: <1467026976-7974-17-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These days, memblocks is available later, so we can just allocate it
as part of iob_init.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/pasemi/iommu.c  | 15 +++++----------
 arch/powerpc/platforms/pasemi/pasemi.h |  1 -
 arch/powerpc/platforms/pasemi/setup.c  |  2 --
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index c929644..43dd3fb 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -202,6 +202,11 @@ int __init iob_init(struct device_node *dn)
 
 	pr_debug(" -> %s\n", __func__);
 
+	/* For 2G space, 8x64 pages (2^21 bytes) is max total l2 size */
+	iob_l2_base = (u32 *)__va(memblock_alloc_base(1UL<<21, 1UL<<21, 0x80000000));
+
+	printk(KERN_INFO "IOBMAP L2 allocated at: %p\n", iob_l2_base);
+
 	/* Allocate a spare page to map all invalid IOTLB pages. */
 	tmp = memblock_alloc(IOBMAP_PAGE_SIZE, IOBMAP_PAGE_SIZE);
 	if (!tmp)
@@ -260,13 +265,3 @@ void __init iommu_init_early_pasemi(void)
 	set_pci_dma_ops(&dma_iommu_ops);
 }
 
-void __init alloc_iobmap_l2(void)
-{
-#ifndef CONFIG_PPC_PASEMI_IOMMU
-	return;
-#endif
-	/* For 2G space, 8x64 pages (2^21 bytes) is max total l2 size */
-	iob_l2_base = (u32 *)__va(memblock_alloc_base(1UL<<21, 1UL<<21, 0x80000000));
-
-	printk(KERN_INFO "IOBMAP L2 allocated at: %p\n", iob_l2_base);
-}
diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platforms/pasemi/pasemi.h
index 11f230a..74cbcb3 100644
--- a/arch/powerpc/platforms/pasemi/pasemi.h
+++ b/arch/powerpc/platforms/pasemi/pasemi.h
@@ -8,7 +8,6 @@ extern void pas_pci_dma_dev_setup(struct pci_dev *dev);
 
 extern void __iomem *pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset);
 
-extern void __init alloc_iobmap_l2(void);
 extern void __init pasemi_map_registers(void);
 
 /* Power savings modes, implemented in asm */
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 7605bc6..9a881be 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -426,8 +426,6 @@ static int __init pas_probe(void)
 	    !of_flat_dt_is_compatible(root, "pasemi,pwrficient"))
 		return 0;
 
-	alloc_iobmap_l2();
-
 	return 1;
 }
 
-- 
2.7.4
