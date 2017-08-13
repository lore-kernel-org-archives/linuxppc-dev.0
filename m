Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xVLrF37bnzDrCv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Aug 2017 11:34:21 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 83so5969313pgb.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 18:34:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 3/9] powerpc/powernv: Remove real mode access limit for
 early allocations
Date: Sun, 13 Aug 2017 11:33:40 +1000
Message-Id: <20170813013346.14002-3-npiggin@gmail.com>
In-Reply-To: <20170812113416.15978-1-npiggin@gmail.com>
References: <20170812113416.15978-1-npiggin@gmail.com>
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
 arch/powerpc/mm/hash_utils_64.c | 24 +++++++++++++++---------
 arch/powerpc/mm/pgtable-radix.c | 33 +++++++++++++++++----------------
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 7a20669c19e7..d3da19cc4867 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1824,16 +1824,22 @@ void hash__setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	 */
 	BUG_ON(first_memblock_base != 0);
 
-	/* On LPAR systems, the first entry is our RMA region,
-	 * non-LPAR 64-bit hash MMU systems don't have a limitation
-	 * on real mode access, but using the first entry works well
-	 * enough. We also clamp it to 1G to avoid some funky things
-	 * such as RTAS bugs etc...
-	 */
-	ppc64_rma_size = min_t(u64, first_memblock_size, 0x40000000);
+	if (!early_cpu_has_feature(CPU_FTR_HVMODE)) {
+		/*
+		 * On virtualized systems, the first entry is our RMA region,
+		 * non-LPAR 64-bit hash MMU systems don't have a limitation
+		 * on real mode access.
+		 *
+		 * We also clamp it to 1G to avoid some funky things
+		 * such as RTAS bugs etc...
+		 */
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
index 671a45d86c18..61ca17d81737 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -598,22 +598,23 @@ void radix__setup_initial_memory_limit(phys_addr_t first_memblock_base,
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
+		 * On virtualized systems, the first entry is our RMA region,
+		 * non-LPAR 64-bit hash MMU systems don't have a limitation
+		 * on real mode access.
+		 *
+		 * We also clamp it to 1G to avoid some funky things
+		 * such as RTAS bugs etc...
+		 */
+		ppc64_rma_size = min_t(u64, first_memblock_size, 0x40000000);
+
+		/* Finally limit subsequent allocations */
+		memblock_set_current_limit(ppc64_rma_size);
+	} else {
+		ppc64_rma_size = ULONG_MAX;
+	}
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-- 
2.13.3
