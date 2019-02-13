Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07066C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:57:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F069222B5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WFSHrYpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F069222B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zsLh2PsMzDqTF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 18:57:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+b68490c3fe13e616ccfb+5652+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="WFSHrYpr"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zr7v2H27zDqHL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 18:02:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k5qhExxy1nKxZkK/OaVg+xIEjlwYIczg/ZJjqKJxHlE=; b=WFSHrYprqTd2EO2usmpq7034j0
 gE2dBQcEXqI8xUc3Wl86CI1LvUq5X6srujSgVTwS7g6LHSeQLHM6X2QwSy6jlR32+VA1pATYf0tSa
 wLl1dV26oHdkcOd+bpks73feuzgTXaVh6iWJU7iq417q9uDgM+uAifB53vG0zfZ+E/s/BWSaeGKYJ
 d6/r/CqxV3rAmhjfhgosxYTrCQN7ODVQRfYmxvyWCJiWpraHdkfzUdn0AKAEucfFFdi5YLhb/Kqf7
 Ci+XTkjgo7sIOCyzXEWa7xOgHJKb35V7sZGzf7QGfwyFWfbCuF85oOBs+xZvz8cHXcKBZS6i9yg0h
 IUYPmGrg==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtoZA-0000kc-1M; Wed, 13 Feb 2019 07:02:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Olof Johansson <olof@lixom.net>
Subject: [PATCH 29/32] powerpc/dma: use the generic direct mapping bypass
Date: Wed, 13 Feb 2019 08:01:30 +0100
Message-Id: <20190213070133.11259-30-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213070133.11259-1-hch@lst.de>
References: <20190213070133.11259-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Now that we've switched all the powerpc nommu and swiotlb methods to
use the generic dma_direct_* calls we can remove these ops vectors
entirely and rely on the common direct mapping bypass that avoids
indirect function calls entirely.  This also allows to remove a whole
lot of boilerplate code related to setting up these operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/include/asm/dma-mapping.h        |  9 ---
 arch/powerpc/include/asm/swiotlb.h            |  3 -
 arch/powerpc/kernel/Makefile                  |  2 +-
 arch/powerpc/kernel/dma-swiotlb.c             | 58 -----------------
 arch/powerpc/kernel/dma.c                     | 62 -------------------
 arch/powerpc/kernel/pci-common.c              |  2 +-
 arch/powerpc/kernel/setup-common.c            |  1 -
 arch/powerpc/mm/dma-noncoherent.c             |  6 +-
 arch/powerpc/platforms/44x/warp.c             |  2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c |  4 --
 arch/powerpc/platforms/85xx/ge_imp3a.c        |  2 -
 arch/powerpc/platforms/85xx/mpc8536_ds.c      |  2 -
 arch/powerpc/platforms/85xx/mpc85xx_ds.c      |  4 --
 arch/powerpc/platforms/85xx/mpc85xx_mds.c     |  4 --
 arch/powerpc/platforms/85xx/p1010rdb.c        |  1 -
 arch/powerpc/platforms/85xx/p1022_ds.c        |  2 -
 arch/powerpc/platforms/85xx/p1022_rdk.c       |  2 -
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c    |  1 -
 arch/powerpc/platforms/cell/iommu.c           |  3 -
 arch/powerpc/platforms/pasemi/iommu.c         |  2 +-
 arch/powerpc/platforms/pasemi/setup.c         | 51 ---------------
 arch/powerpc/platforms/powernv/npu-dma.c      |  2 +-
 arch/powerpc/platforms/pseries/vio.c          |  7 +++
 arch/powerpc/sysdev/fsl_pci.c                 |  5 +-
 drivers/misc/cxl/vphb.c                       |  1 -
 25 files changed, 16 insertions(+), 222 deletions(-)
 delete mode 100644 arch/powerpc/kernel/dma.c

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 4de9d4ee23c1..93e57e28be28 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -18,14 +18,6 @@
 #include <asm/io.h>
 #include <asm/swiotlb.h>
 
-/* Some dma direct funcs must be visible for use in other dma_ops */
-extern void *__dma_nommu_alloc_coherent(struct device *dev, size_t size,
-					 dma_addr_t *dma_handle, gfp_t flag,
-					 unsigned long attrs);
-extern void __dma_nommu_free_coherent(struct device *dev, size_t size,
-				       void *vaddr, dma_addr_t dma_handle,
-				       unsigned long attrs);
-
 static inline unsigned long device_to_mask(struct device *dev)
 {
 	if (dev->dma_mask && *dev->dma_mask)
@@ -40,7 +32,6 @@ static inline unsigned long device_to_mask(struct device *dev)
 #ifdef CONFIG_PPC64
 extern const struct dma_map_ops dma_iommu_ops;
 #endif
-extern const struct dma_map_ops dma_nommu_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
diff --git a/arch/powerpc/include/asm/swiotlb.h b/arch/powerpc/include/asm/swiotlb.h
index 26a0f12b835b..b7d082c0ec25 100644
--- a/arch/powerpc/include/asm/swiotlb.h
+++ b/arch/powerpc/include/asm/swiotlb.h
@@ -13,10 +13,7 @@
 
 #include <linux/swiotlb.h>
 
-extern const struct dma_map_ops powerpc_swiotlb_dma_ops;
-
 extern unsigned int ppc_swiotlb_enable;
-int __init swiotlb_setup_bus_notifier(void);
 
 #ifdef CONFIG_SWIOTLB
 void swiotlb_detect_4g(void);
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 9bb12cd642ef..8809e287b80d 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -36,7 +36,7 @@ obj-y				:= cputable.o ptrace.o syscalls.o \
 				   process.o systbl.o idle.o \
 				   signal.o sysfs.o cacheinfo.o time.o \
 				   prom.o traps.o setup-common.o \
-				   udbg.o misc.o io.o dma.o misc_$(BITS).o \
+				   udbg.o misc.o io.o misc_$(BITS).o \
 				   of_platform.o prom_parse.o
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index 3a15a7d945e9..132d61c91629 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -10,70 +10,12 @@
  * option) any later version.
  *
  */
-
-#include <linux/dma-direct.h>
 #include <linux/memblock.h>
-#include <linux/pfn.h>
-#include <linux/of_platform.h>
-#include <linux/platform_device.h>
-#include <linux/pci.h>
-
 #include <asm/machdep.h>
 #include <asm/swiotlb.h>
-#include <asm/dma.h>
 
 unsigned int ppc_swiotlb_enable;
 
-/*
- * At the moment, all platforms that use this code only require
- * swiotlb to be used if we're operating on HIGHMEM.  Since
- * we don't ever call anything other than map_sg, unmap_sg,
- * map_page, and unmap_page on highmem, use normal dma_ops
- * for everything else.
- */
-const struct dma_map_ops powerpc_swiotlb_dma_ops = {
-	.alloc = dma_direct_alloc,
-	.free = dma_direct_free,
-	.map_sg = dma_direct_map_sg,
-	.unmap_sg = dma_direct_unmap_sg,
-	.dma_supported = dma_direct_supported,
-	.map_page = dma_direct_map_page,
-	.unmap_page = dma_direct_unmap_page,
-	.sync_single_for_cpu = dma_direct_sync_single_for_cpu,
-	.sync_single_for_device = dma_direct_sync_single_for_device,
-	.sync_sg_for_cpu = dma_direct_sync_sg_for_cpu,
-	.sync_sg_for_device = dma_direct_sync_sg_for_device,
-	.get_required_mask = dma_direct_get_required_mask,
-};
-
-static int ppc_swiotlb_bus_notify(struct notifier_block *nb,
-				  unsigned long action, void *data)
-{
-	struct device *dev = data;
-
-	/* We are only intereted in device addition */
-	if (action != BUS_NOTIFY_ADD_DEVICE)
-		return 0;
-
-	/* May need to bounce if the device can't address all of DRAM */
-	if ((dma_get_mask(dev) + 1) < memblock_end_of_DRAM())
-		set_dma_ops(dev, &powerpc_swiotlb_dma_ops);
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block ppc_swiotlb_plat_bus_notifier = {
-	.notifier_call = ppc_swiotlb_bus_notify,
-	.priority = 0,
-};
-
-int __init swiotlb_setup_bus_notifier(void)
-{
-	bus_register_notifier(&platform_bus_type,
-			      &ppc_swiotlb_plat_bus_notifier);
-	return 0;
-}
-
 void __init swiotlb_detect_4g(void)
 {
 	if ((memblock_end_of_DRAM() - 1) > 0xffffffff)
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
deleted file mode 100644
index b9f7283e7224..000000000000
--- a/arch/powerpc/kernel/dma.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * Copyright (C) 2006 Benjamin Herrenschmidt, IBM Corporation
- *
- * Provide default implementations of the DMA mapping callbacks for
- * directly mapped busses.
- */
-
-#include <linux/device.h>
-#include <linux/dma-direct.h>
-#include <linux/dma-debug.h>
-#include <linux/gfp.h>
-#include <linux/memblock.h>
-#include <linux/export.h>
-#include <linux/pci.h>
-#include <asm/vio.h>
-#include <asm/bug.h>
-#include <asm/machdep.h>
-#include <asm/swiotlb.h>
-#include <asm/iommu.h>
-
-/*
- * Generic direct DMA implementation
- *
- * This implementation supports a per-device offset that can be applied if
- * the address at which memory is visible to devices is not 0. Platform code
- * can set archdata.dma_data to an unsigned long holding the offset. By
- * default the offset is PCI_DRAM_OFFSET.
- */
-
-const struct dma_map_ops dma_nommu_ops = {
-#ifdef CONFIG_NOT_COHERENT_CACHE
-	.alloc				= __dma_nommu_alloc_coherent,
-	.free				= __dma_nommu_free_coherent,
-#else
-	.alloc				= dma_direct_alloc,
-	.free				= dma_direct_free,
-#endif
-	.map_sg				= dma_direct_map_sg,
-	.dma_supported			= dma_direct_supported,
-	.map_page			= dma_direct_map_page,
-	.get_required_mask		= dma_direct_get_required_mask,
-#ifdef CONFIG_NOT_COHERENT_CACHE
-	.unmap_sg			= dma_direct_unmap_sg,
-	.unmap_page			= dma_direct_unmap_page,
-	.sync_single_for_cpu 		= dma_direct_sync_single_for_cpu,
-	.sync_single_for_device 	= dma_direct_sync_single_for_device,
-	.sync_sg_for_cpu 		= dma_direct_sync_sg_for_cpu,
-	.sync_sg_for_device 		= dma_direct_sync_sg_for_device,
-#endif
-};
-EXPORT_SYMBOL(dma_nommu_ops);
-
-static int __init dma_init(void)
-{
-#ifdef CONFIG_IBMVIO
-	dma_debug_add_bus(&vio_bus_type);
-#endif
-
-       return 0;
-}
-fs_initcall(dma_init);
-
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index a84707680525..23989175349c 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -62,7 +62,7 @@ resource_size_t isa_mem_base;
 EXPORT_SYMBOL(isa_mem_base);
 
 
-static const struct dma_map_ops *pci_dma_ops = &dma_nommu_ops;
+static const struct dma_map_ops *pci_dma_ops;
 
 void set_pci_dma_ops(const struct dma_map_ops *dma_ops)
 {
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index ca00fbb97cf8..fa606aa98f6d 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -791,7 +791,6 @@ void arch_setup_pdev_archdata(struct platform_device *pdev)
 {
 	pdev->archdata.dma_mask = DMA_BIT_MASK(32);
 	pdev->dev.dma_mask = &pdev->archdata.dma_mask;
- 	set_dma_ops(&pdev->dev, &dma_nommu_ops);
 }
 
 static __init void print_system_info(void)
diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index c3d15d718a58..b5d2658c26af 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -152,8 +152,8 @@ static struct ppc_vm_region *ppc_vm_region_find(struct ppc_vm_region *head, unsi
  * Allocate DMA-coherent memory space and return both the kernel remapped
  * virtual and bus address for that space.
  */
-void *__dma_nommu_alloc_coherent(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs)
 {
 	struct page *page;
 	struct ppc_vm_region *c;
@@ -254,7 +254,7 @@ void *__dma_nommu_alloc_coherent(struct device *dev, size_t size,
 /*
  * free a page as defined by the above mapping.
  */
-void __dma_nommu_free_coherent(struct device *dev, size_t size, void *vaddr,
+void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
 	struct ppc_vm_region *c;
diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
index f467247fd1c4..18422dbd061a 100644
--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -47,7 +47,7 @@ static int __init warp_probe(void)
 	if (!of_machine_is_compatible("pika,warp"))
 		return 0;
 
-	/* For __dma_nommu_alloc_coherent */
+	/* For arch_dma_alloc */
 	ISA_DMA_THRESHOLD = ~0L;
 
 	return 1;
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index b0dac307bebf..808da1e9c0a7 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -223,7 +223,3 @@ define_machine(corenet_generic) {
 };
 
 machine_arch_initcall(corenet_generic, corenet_gen_publish_devices);
-
-#ifdef CONFIG_SWIOTLB
-machine_arch_initcall(corenet_generic, swiotlb_setup_bus_notifier);
-#endif
diff --git a/arch/powerpc/platforms/85xx/ge_imp3a.c b/arch/powerpc/platforms/85xx/ge_imp3a.c
index f29c6f0909f3..c64fa2483ea9 100644
--- a/arch/powerpc/platforms/85xx/ge_imp3a.c
+++ b/arch/powerpc/platforms/85xx/ge_imp3a.c
@@ -202,8 +202,6 @@ static int __init ge_imp3a_probe(void)
 
 machine_arch_initcall(ge_imp3a, mpc85xx_common_publish_devices);
 
-machine_arch_initcall(ge_imp3a, swiotlb_setup_bus_notifier);
-
 define_machine(ge_imp3a) {
 	.name			= "GE_IMP3A",
 	.probe			= ge_imp3a_probe,
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index 94a7f92c858f..94194bad4954 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -57,8 +57,6 @@ static void __init mpc8536_ds_setup_arch(void)
 
 machine_arch_initcall(mpc8536_ds, mpc85xx_common_publish_devices);
 
-machine_arch_initcall(mpc8536_ds, swiotlb_setup_bus_notifier);
-
 /*
  * Called very early, device-tree isn't unflattened
  */
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index dc9e035cc637..b7e29ce1f266 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -174,10 +174,6 @@ machine_arch_initcall(mpc8544_ds, mpc85xx_common_publish_devices);
 machine_arch_initcall(mpc8572_ds, mpc85xx_common_publish_devices);
 machine_arch_initcall(p2020_ds, mpc85xx_common_publish_devices);
 
-machine_arch_initcall(mpc8544_ds, swiotlb_setup_bus_notifier);
-machine_arch_initcall(mpc8572_ds, swiotlb_setup_bus_notifier);
-machine_arch_initcall(p2020_ds, swiotlb_setup_bus_notifier);
-
 /*
  * Called very early, device-tree isn't unflattened
  */
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index d7e440e6dba3..80939a425de5 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -367,10 +367,6 @@ machine_arch_initcall(mpc8568_mds, mpc85xx_publish_devices);
 machine_arch_initcall(mpc8569_mds, mpc85xx_publish_devices);
 machine_arch_initcall(p1021_mds, mpc85xx_common_publish_devices);
 
-machine_arch_initcall(mpc8568_mds, swiotlb_setup_bus_notifier);
-machine_arch_initcall(mpc8569_mds, swiotlb_setup_bus_notifier);
-machine_arch_initcall(p1021_mds, swiotlb_setup_bus_notifier);
-
 static void __init mpc85xx_mds_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN |
diff --git a/arch/powerpc/platforms/85xx/p1010rdb.c b/arch/powerpc/platforms/85xx/p1010rdb.c
index 78d13b364cd6..33ca373322e1 100644
--- a/arch/powerpc/platforms/85xx/p1010rdb.c
+++ b/arch/powerpc/platforms/85xx/p1010rdb.c
@@ -55,7 +55,6 @@ static void __init p1010_rdb_setup_arch(void)
 }
 
 machine_arch_initcall(p1010_rdb, mpc85xx_common_publish_devices);
-machine_arch_initcall(p1010_rdb, swiotlb_setup_bus_notifier);
 
 /*
  * Called very early, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 9fb57f78cdbe..1f1af0557470 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -548,8 +548,6 @@ static void __init p1022_ds_setup_arch(void)
 
 machine_arch_initcall(p1022_ds, mpc85xx_common_publish_devices);
 
-machine_arch_initcall(p1022_ds, swiotlb_setup_bus_notifier);
-
 /*
  * Called very early, device-tree isn't unflattened
  */
diff --git a/arch/powerpc/platforms/85xx/p1022_rdk.c b/arch/powerpc/platforms/85xx/p1022_rdk.c
index 276e00ab3dde..fd9e3e7ef234 100644
--- a/arch/powerpc/platforms/85xx/p1022_rdk.c
+++ b/arch/powerpc/platforms/85xx/p1022_rdk.c
@@ -128,8 +128,6 @@ static void __init p1022_rdk_setup_arch(void)
 
 machine_arch_initcall(p1022_rdk, mpc85xx_common_publish_devices);
 
-machine_arch_initcall(p1022_rdk, swiotlb_setup_bus_notifier);
-
 /*
  * Called very early, device-tree isn't unflattened
  */
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 17c6cd3d02e6..775a92353c83 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -121,7 +121,6 @@ static int __init declare_of_platform_devices(void)
 	return 0;
 }
 machine_arch_initcall(mpc86xx_hpcn, declare_of_platform_devices);
-machine_arch_initcall(mpc86xx_hpcn, swiotlb_setup_bus_notifier);
 
 define_machine(mpc86xx_hpcn) {
 	.name			= "MPC86xx HPCN",
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index a3c4057a8f65..06abd432b830 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -600,8 +600,6 @@ static int cell_of_bus_notify(struct notifier_block *nb, unsigned long action,
 
 	if (cell_iommu_enabled)
 		dev->dma_ops = &dma_iommu_ops;
-	else
-		dev->dma_ops = &dma_nommu_ops;
 	cell_dma_dev_setup(dev);
 	return 0;
 }
@@ -727,7 +725,6 @@ static int __init cell_iommu_init_disabled(void)
 	unsigned long base = 0, size;
 
 	/* When no iommu is present, we use direct DMA ops */
-	set_pci_dma_ops(&dma_nommu_ops);
 
 	/* First make sure all IOC translation is turned off */
 	cell_disable_iommus();
diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index f2971522fb4a..bbeb6a1b0393 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -186,7 +186,7 @@ static void pci_dma_dev_setup_pasemi(struct pci_dev *dev)
 	 */
 	if (dev->vendor == 0x1959 && dev->device == 0xa007 &&
 	    !firmware_has_feature(FW_FEATURE_LPAR)) {
-		dev->dev.dma_ops = &dma_nommu_ops;
+		dev->dev.dma_ops = NULL;
 		/*
 		 * Set the coherent DMA mask to prevent the iommu
 		 * being used unnecessarily
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index c0532999f854..46dd463faaa7 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -411,55 +411,6 @@ static int pas_machine_check_handler(struct pt_regs *regs)
 	return !!(srr1 & 0x2);
 }
 
-#ifdef CONFIG_PCMCIA
-static int pcmcia_notify(struct notifier_block *nb, unsigned long action,
-			 void *data)
-{
-	struct device *dev = data;
-	struct device *parent;
-	struct pcmcia_device *pdev = to_pcmcia_dev(dev);
-
-	/* We are only intereted in device addition */
-	if (action != BUS_NOTIFY_ADD_DEVICE)
-		return 0;
-
-	parent = pdev->socket->dev.parent;
-
-	/* We know electra_cf devices will always have of_node set, since
-	 * electra_cf is an of_platform driver.
-	 */
-	if (!parent->of_node)
-		return 0;
-
-	if (!of_device_is_compatible(parent->of_node, "electra-cf"))
-		return 0;
-
-	/* We use the direct ops for localbus */
-	dev->dma_ops = &dma_nommu_ops;
-
-	return 0;
-}
-
-static struct notifier_block pcmcia_notifier = {
-	.notifier_call = pcmcia_notify,
-};
-
-static inline void pasemi_pcmcia_init(void)
-{
-	extern struct bus_type pcmcia_bus_type;
-
-	bus_register_notifier(&pcmcia_bus_type, &pcmcia_notifier);
-}
-
-#else
-
-static inline void pasemi_pcmcia_init(void)
-{
-}
-
-#endif
-
-
 static const struct of_device_id pasemi_bus_ids[] = {
 	/* Unfortunately needed for legacy firmwares */
 	{ .type = "localbus", },
@@ -472,8 +423,6 @@ static const struct of_device_id pasemi_bus_ids[] = {
 
 static int __init pasemi_publish_devices(void)
 {
-	pasemi_pcmcia_init();
-
 	/* Publish OF platform devices for SDC and other non-PCI devices */
 	of_platform_bus_probe(NULL, pasemi_bus_ids, NULL);
 
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 2ca79823e3ba..53b3c86c4c1d 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -216,7 +216,7 @@ static void pnv_npu_dma_set_32(struct pnv_ioda_pe *npe)
 	 * their parent device so drivers shouldn't be doing DMA
 	 * operations directly on these devices.
 	 */
-	set_dma_ops(&npe->pdev->dev, NULL);
+	set_dma_ops(&npe->pdev->dev, &dma_dummy_ops);
 }
 
 /*
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index b7dc8bd41fd0..141795275ccb 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -1699,3 +1699,10 @@ int vio_disable_interrupts(struct vio_dev *dev)
 }
 EXPORT_SYMBOL(vio_disable_interrupts);
 #endif /* CONFIG_PPC_PSERIES */
+
+static int __init vio_init(void)
+{
+	dma_debug_add_bus(&vio_bus_type);
+	return 0;
+}
+fs_initcall(vio_init);
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 0c6510f340cb..23000ca7f688 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -124,10 +124,8 @@ static void pci_dma_dev_setup_swiotlb(struct pci_dev *pdev)
 
 static void setup_swiotlb_ops(struct pci_controller *hose)
 {
-	if (ppc_swiotlb_enable) {
+	if (ppc_swiotlb_enable)
 		hose->controller_ops.dma_dev_setup = pci_dma_dev_setup_swiotlb;
-		set_pci_dma_ops(&powerpc_swiotlb_dma_ops);
-	}
 }
 #else
 static inline void setup_swiotlb_ops(struct pci_controller *hose) {}
@@ -141,7 +139,6 @@ static void fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 	 */
 	if (dev_is_pci(dev) && dma_mask >= pci64_dma_offset * 2 - 1) {
 		dev->bus_dma_mask = 0;
-		set_dma_ops(dev, &dma_nommu_ops);
 		set_dma_offset(dev, pci64_dma_offset);
 	}
 }
diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 49da2f744bbf..b64adc0f0865 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -43,7 +43,6 @@ static bool cxl_pci_enable_device_hook(struct pci_dev *dev)
 		return false;
 	}
 
-	set_dma_ops(&dev->dev, &dma_nommu_ops);
 	set_dma_offset(&dev->dev, PAGE_OFFSET);
 
 	/*
-- 
2.20.1

