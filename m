Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBf95YxxzDqxV
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:05:21 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkBf75Mbrz9s9Z
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:05:18 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 17/41] powerpc/mm/hash: Don't use machine_is() early during
 boot
Date: Tue,  5 Jul 2016 15:03:53 +1000
Message-Id: <1467695057-12431-18-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
References: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the device-tree instead as we'll be moving probe_machine()
out of early_setup

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/hash_utils_64.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 839e1ad..a261e44 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -34,6 +34,7 @@
 #include <linux/signal.h>
 #include <linux/memblock.h>
 #include <linux/context_tracking.h>
+#include <linux/libfdt.h>
 
 #include <asm/processor.h>
 #include <asm/pgtable.h>
@@ -731,7 +732,7 @@ static void __init htab_initialize(void)
 	unsigned long table;
 	unsigned long pteg_count;
 	unsigned long prot;
-	unsigned long base = 0, size = 0, limit;
+	unsigned long base = 0, size = 0;
 	struct memblock_region *reg;
 
 	DBG(" -> htab_initialize()\n");
@@ -757,7 +758,8 @@ static void __init htab_initialize(void)
 
 	htab_hash_mask = pteg_count - 1;
 
-	if (firmware_has_feature(FW_FEATURE_LPAR)) {
+	if (firmware_has_feature(FW_FEATURE_LPAR) ||
+	    firmware_has_feature(FW_FEATURE_PS3_LV1)) {
 		/* Using a hypervisor which owns the htab */
 		htab_address = NULL;
 		_SDR1 = 0; 
@@ -772,16 +774,21 @@ static void __init htab_initialize(void)
 			ppc_md.hpte_clear_all();
 #endif
 	} else {
-		/* Find storage for the HPT.  Must be contiguous in
-		 * the absolute address space. On cell we want it to be
-		 * in the first 2 Gig so we can use it for IOMMU hacks.
+		unsigned long limit = MEMBLOCK_ALLOC_ANYWHERE;
+
+#ifdef CONFIG_PPC_CELL
+		/* Cell may require the hash table down low when using the
+		 * Axon IOMMU in order to fit the dynamic region over it, see
+		 * comments in cell/iommu.c
 		 */
-		if (machine_is(cell))
+		if (fdt_subnode_offset(initial_boot_params, 0, "axon") > 0) {
 			limit = 0x80000000;
-		else
-			limit = MEMBLOCK_ALLOC_ANYWHERE;
+			pr_info("Hash table forced below 2G for Axon IOMMU\n");
+		}
+#endif /* CONFIG_PPC_CELL */
 
-		table = memblock_alloc_base(htab_size_bytes, htab_size_bytes, limit);
+		table = memblock_alloc_base(htab_size_bytes, htab_size_bytes,
+					    limit);
 
 		DBG("Hash table allocated at %lx, size: %lx\n", table,
 		    htab_size_bytes);
-- 
2.7.4
