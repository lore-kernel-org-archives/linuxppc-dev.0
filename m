Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x83J12WPCzDqln
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 16:51:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] powerpc/mm/hash: Refactor hash__mark_rodata_ro()
Date: Fri, 14 Jul 2017 16:51:22 +1000
Message-Id: <1500015083-23511-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1500015083-23511-1-git-send-email-mpe@ellerman.id.au>
References: <1500015083-23511-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the core logic into a helper, so we can use it for changing other
permissions.

We also change the logic to align start down, and end up. This means
calling the function with a range will expand that range to be at
least 1 mmu_linear_psize page in size. We need that so we can use it
on __init_begin ...  __init_end which is not a full page in size.

This should always work for _stext/__init_begin, because we align
__init_begin to _stext + 16M in the linker script.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/pgtable-hash64.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index 188b4107584d..73019c52141f 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -425,33 +425,39 @@ int hash__has_transparent_hugepage(void)
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-void hash__mark_rodata_ro(void)
+static bool hash__change_memory_range(unsigned long start, unsigned long end,
+				      unsigned long newpp)
 {
-	unsigned long start = (unsigned long)_stext;
-	unsigned long end = (unsigned long)__init_begin;
 	unsigned long idx;
 	unsigned int step, shift;
-	unsigned long newpp = PP_RXXX;
 
 	shift = mmu_psize_defs[mmu_linear_psize].shift;
 	step = 1 << shift;
 
-	start = ((start + step - 1) >> shift) << shift;
-	end = (end >> shift) << shift;
+	start = ALIGN_DOWN(start, step);
+	end = ALIGN(end, step); // aligns up
 
-	pr_devel("marking ro start %lx, end %lx, step %x\n",
-			start, end, step);
+	if (start >= end)
+		return false;
 
-	if (start == end) {
-		pr_warn("could not set rodata ro, relocate the start"
-			" of the kernel to a 0x%x boundary\n", step);
-		return;
-	}
+	pr_debug("Changing page protection on range 0x%lx-0x%lx, to 0x%lx, step 0x%x\n",
+		 start, end, newpp, step);
 
 	for (idx = start; idx < end; idx += step)
 		/* Not sure if we can do much with the return value */
 		mmu_hash_ops.hpte_updateboltedpp(newpp, idx, mmu_linear_psize,
 							mmu_kernel_ssize);
 
+	return true;
+}
+
+void hash__mark_rodata_ro(void)
+{
+	unsigned long start, end;
+
+	start = (unsigned long)_stext;
+	end = (unsigned long)__init_begin;
+
+	WARN_ON(!hash__change_memory_range(start, end, PP_RXXX));
 }
 #endif
-- 
2.7.4
