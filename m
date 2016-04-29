Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyM6bx5zDqBZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 47/70] powerpc/mm/radix: Limit paca allocation in radix
Date: Fri, 29 Apr 2016 23:26:10 +1000
Message-Id: <1461936393-10131-47-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

On return from RTAS we access the paca variables and we have 64 bit
disabled. This requires us to limit paca in 32 bit range.

Fix this by setting ppc64_rma_size to first_memblock_size/1G range.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/pgtable-radix.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 0472f8aa40e1..04ec9760380d 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -351,7 +351,25 @@ void radix__early_init_mmu_secondary(void)
 void radix__setup_initial_memory_limit(phys_addr_t first_memblock_base,
 				phys_addr_t first_memblock_size)
 {
-	/* Finally limit subsequent allocations */
+	/* We don't currently support the first MEMBLOCK not mapping 0
+	 * physical on those processors
+	 */
+	BUG_ON(first_memblock_base != 0);
+	/*
+	 * We limit the allocation that depend on ppc64_rma_size
+	 * to first_memblock_size. We also clamp it to 1GB to
+	 * avoid some funky things such as RTAS bugs.
+	 *
+	 * On radix config we really don't have a limitation
+	 * on real mode access. But keeping it as above works
+	 * well enough.
+	 */
+	ppc64_rma_size = min_t(u64, first_memblock_size, 0x40000000);
+	/*
+	 * Finally limit subsequent allocations. We really don't want
+	 * to limit the memblock allocations to rma_size. FIXME!! should
+	 * we even limit at all ?
+	 */
 	memblock_set_current_limit(first_memblock_base + first_memblock_size);
 }
 
-- 
2.5.0
