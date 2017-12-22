Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z35Zh6PM6zDrdP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 22:17:32 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id q67so5163345pga.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 03:17:32 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 1/9] powerpc/powernv: Remove real mode access limit for early
 allocations
Date: Fri, 22 Dec 2017 21:17:08 +1000
Message-Id: <20171222111716.13101-2-npiggin@gmail.com>
In-Reply-To: <20171222111716.13101-1-npiggin@gmail.com>
References: <20171222111716.13101-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This removes the RMA limit on powernv platform, which constrains
early allocations such as PACAs and stacks. There are still other
restrictions that must be followed, such as bolted SLB limits, but
real mode addressing has no constraints.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/hash_utils_64.c | 20 +++++++++++++-------
 arch/powerpc/mm/pgtable-radix.c | 37 +++++++++++++++++++++----------------
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 655a5a9a183d..8922e069b073 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1825,16 +1825,22 @@ void hash__setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	 */
 	BUG_ON(first_memblock_base != 0);
 
-	/* On LPAR systems, the first entry is our RMA region,
-	 * non-LPAR 64-bit hash MMU systems don't have a limitation
-	 * on real mode access, but using the first entry works well
-	 * enough. We also clamp it to 1G to avoid some funky things
+	/*
+	 * On virtualized systems the first entry is our RMA region aka VRMA,
+	 * non-virtualized 64-bit hash MMU systems don't have a limitation
+	 * on real mode access.
+	 *
+	 * We also clamp it to 1G to avoid some funky things
 	 * such as RTAS bugs etc...
 	 */
-	ppc64_rma_size = min_t(u64, first_memblock_size, 0x40000000);
+	if (!early_cpu_has_feature(CPU_FTR_HVMODE)) {
+		ppc64_rma_size = min_t(u64, first_memblock_size, 0x40000000);
 
-	/* Finally limit subsequent allocations */
-	memblock_set_current_limit(ppc64_rma_size);
+		/* Finally limit subsequent allocations */
+		memblock_set_current_limit(ppc64_rma_size);
+	} else {
+		ppc64_rma_size = ULONG_MAX;
+	}
 }
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index cfbbee941a76..d73816960825 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -622,22 +622,27 @@ void radix__setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	 * physical on those processors
 	 */
 	BUG_ON(first_memblock_base != 0);
-	/*
-	 * We limit the allocation that depend on ppc64_rma_size
-	 * to first_memblock_size. We also clamp it to 1GB to
-	 * avoid some funky things such as RTAS bugs.
-	 *
-	 * On radix config we really don't have a limitation
-	 * on real mode access. But keeping it as above works
-	 * well enough.
-	 */
-	ppc64_rma_size = min_t(u64, first_memblock_size, 0x40000000);
-	/*
-	 * Finally limit subsequent allocations. We really don't want
-	 * to limit the memblock allocations to rma_size. FIXME!! should
-	 * we even limit at all ?
-	 */
-	memblock_set_current_limit(first_memblock_base + first_memblock_size);
+
+	if (!early_cpu_has_feature(CPU_FTR_HVMODE)) {
+		/*
+		 * We limit the allocation that depend on ppc64_rma_size
+		 * to first_memblock_size. We also clamp it to 1GB to
+		 * avoid some funky things such as RTAS bugs.
+		 *
+		 * On radix config we really don't have a limitation
+		 * on real mode access. But keeping it as above works
+		 * well enough.
+		 */
+		ppc64_rma_size = min_t(u64, first_memblock_size, 0x40000000);
+		/*
+		 * Finally limit subsequent allocations. We really don't want
+		 * to limit the memblock allocations to rma_size. FIXME!! should
+		 * we even limit at all ?
+		 */
+		memblock_set_current_limit(first_memblock_base + first_memblock_size);
+	} else {
+		ppc64_rma_size = ULONG_MAX;
+	}
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-- 
2.15.0
