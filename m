Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BF2C61A0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 13:40:11 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 4/4] arch/powerpc: Split hash page table sizing heuristic into
 a helper
Date: Thu, 28 Jan 2016 13:41:06 +1100
Message-Id: <1453948866-22808-5-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1453948866-22808-1-git-send-email-david@gibson.dropbear.id.au>
References: <1453948866-22808-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

htab_get_table_size() either retrieve the size of the hash page table (HPT)
from the device tree - if the HPT size is determined by firmware - or
uses a heuristic to determine a good size based on RAM size if the kernel
is responsible for allocating the HPT.

To support a PAPR extension allowing resizing of the HPT, we're going to
want the memory size -> HPT size logic elsewhere, so split it out into a
helper function.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/mmu-hash64.h |  3 +++
 arch/powerpc/mm/hash_utils_64.c       | 30 +++++++++++++++++-------------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 7352d3f..cf070fd 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -607,6 +607,9 @@ static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
 	context = (MAX_USER_CONTEXT) + ((ea >> 60) - 0xc) + 1;
 	return get_vsid(context, ea, ssize);
 }
+
+unsigned htab_shift_for_mem_size(unsigned long mem_size);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_MMU_HASH64_H_ */
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index e88a86e..d63f7dc 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -606,10 +606,24 @@ static int __init htab_dt_scan_pftsize(unsigned long node,
 	return 0;
 }
 
-static unsigned long __init htab_get_table_size(void)
+unsigned htab_shift_for_mem_size(unsigned long mem_size)
 {
-	unsigned long mem_size, rnd_mem_size, pteg_count, psize;
+	unsigned memshift = __ilog2(mem_size);
+	unsigned pshift = mmu_psize_defs[mmu_virtual_psize].shift;
+	unsigned pteg_shift;
+
+	/* round mem_size up to next power of 2 */
+	if ((1UL << memshift) < mem_size)
+		memshift += 1;
+
+	/* aim for 2 pages / pteg */
+	pteg_shift = memshift - (pshift + 1);
+
+	return max(pteg_shift + 7, 18U);
+}
 
+static unsigned long __init htab_get_table_size(void)
+{
 	/* If hash size isn't already provided by the platform, we try to
 	 * retrieve it from the device-tree. If it's not there neither, we
 	 * calculate it now based on the total RAM size
@@ -619,17 +633,7 @@ static unsigned long __init htab_get_table_size(void)
 	if (ppc64_pft_size)
 		return 1UL << ppc64_pft_size;
 
-	/* round mem_size up to next power of 2 */
-	mem_size = memblock_phys_mem_size();
-	rnd_mem_size = 1UL << __ilog2(mem_size);
-	if (rnd_mem_size < mem_size)
-		rnd_mem_size <<= 1;
-
-	/* # pages / 2 */
-	psize = mmu_psize_defs[mmu_virtual_psize].shift;
-	pteg_count = max(rnd_mem_size >> (psize + 1), 1UL << 11);
-
-	return pteg_count << 7;
+	return htab_shift_for_mem_size(memblock_phys_mem_size());
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-- 
2.5.0
