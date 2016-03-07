Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA0281A0B86
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 01:50:41 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 7 Mar 2016 06:40:09 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 787CD3E40048
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 06:40:05 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u27De54F36896936
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 06:40:05 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u27De4N6029856
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 06:40:05 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 08/14] powerpc/mm: Use helper for finding pte bits mapping I/O
 area
Date: Mon,  7 Mar 2016 19:09:28 +0530
Message-Id: <1457357974-20839-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1457357974-20839-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1457357974-20839-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use helper instead of opencoding with constants. Later patch will
drop the WIMG bits and use PowerISA 3.0 defines

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/btext.c      | 2 +-
 arch/powerpc/kernel/isa-bridge.c | 4 ++--
 arch/powerpc/kernel/pci_64.c     | 2 +-
 arch/powerpc/mm/pgtable_64.c     | 4 ++--
 arch/powerpc/platforms/ps3/spu.c | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
index 41c011cb6070..8275858a434d 100644
--- a/arch/powerpc/kernel/btext.c
+++ b/arch/powerpc/kernel/btext.c
@@ -162,7 +162,7 @@ void btext_map(void)
 	offset = ((unsigned long) dispDeviceBase) - base;
 	size = dispDeviceRowBytes * dispDeviceRect[3] + offset
 		+ dispDeviceRect[0];
-	vbase = __ioremap(base, size, _PAGE_NO_CACHE);
+	vbase = __ioremap(base, size, pgprot_val(pgprot_noncached_wc(__pgprot(0))));
 	if (vbase == 0)
 		return;
 	logicalDisplayBase = vbase + offset;
diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-bridge.c
index 0f1997097960..ae1316106e2b 100644
--- a/arch/powerpc/kernel/isa-bridge.c
+++ b/arch/powerpc/kernel/isa-bridge.c
@@ -109,14 +109,14 @@ static void pci_process_ISA_OF_ranges(struct device_node *isa_node,
 		size = 0x10000;
 
 	__ioremap_at(phb_io_base_phys, (void *)ISA_IO_BASE,
-		     size, _PAGE_NO_CACHE|_PAGE_GUARDED);
+		     size, pgprot_val(pgprot_noncached(__pgprot(0))));
 	return;
 
 inval_range:
 	printk(KERN_ERR "no ISA IO ranges or unexpected isa range, "
 	       "mapping 64k\n");
 	__ioremap_at(phb_io_base_phys, (void *)ISA_IO_BASE,
-		     0x10000, _PAGE_NO_CACHE|_PAGE_GUARDED);
+		     0x10000, pgprot_val(pgprot_noncached(__pgprot(0))));
 }
 
 
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 60bb187cb46a..41503d7d53a1 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -159,7 +159,7 @@ static int pcibios_map_phb_io_space(struct pci_controller *hose)
 
 	/* Establish the mapping */
 	if (__ioremap_at(phys_page, area->addr, size_page,
-			 _PAGE_NO_CACHE | _PAGE_GUARDED) == NULL)
+			 pgprot_val(pgprot_noncached(__pgprot(0)))) == NULL)
 		return -ENOMEM;
 
 	/* Fixup hose IO resource */
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 1254cf107871..6f1b7064f822 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -253,7 +253,7 @@ void __iomem * __ioremap(phys_addr_t addr, unsigned long size,
 
 void __iomem * ioremap(phys_addr_t addr, unsigned long size)
 {
-	unsigned long flags = _PAGE_NO_CACHE | _PAGE_GUARDED;
+	unsigned long flags = pgprot_val(pgprot_noncached(__pgprot(0)));
 	void *caller = __builtin_return_address(0);
 
 	if (ppc_md.ioremap)
@@ -263,7 +263,7 @@ void __iomem * ioremap(phys_addr_t addr, unsigned long size)
 
 void __iomem * ioremap_wc(phys_addr_t addr, unsigned long size)
 {
-	unsigned long flags = _PAGE_NO_CACHE;
+	unsigned long flags = pgprot_val(pgprot_noncached_wc(__pgprot(0)));
 	void *caller = __builtin_return_address(0);
 
 	if (ppc_md.ioremap)
diff --git a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
index 5e8a40f9739f..492b2575e0d2 100644
--- a/arch/powerpc/platforms/ps3/spu.c
+++ b/arch/powerpc/platforms/ps3/spu.c
@@ -216,7 +216,7 @@ static int __init setup_areas(struct spu *spu)
 	}
 
 	spu->local_store = (__force void *)ioremap_prot(spu->local_store_phys,
-		LS_SIZE, _PAGE_NO_CACHE);
+		LS_SIZE, pgprot_val(pgprot_noncached_wc(__pgprot(0))));
 
 	if (!spu->local_store) {
 		pr_debug("%s:%d: ioremap local_store failed\n",
-- 
2.5.0
