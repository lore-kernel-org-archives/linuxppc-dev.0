Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmLJ4dsVzDqFL
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:16:24 +1000 (AEST)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 02:16:22 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id CE7DB6E803C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 02:03:09 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396GKPX34275404
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 06:16:20 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396GJ13012166
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 02:16:20 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 44/68] powerpc/mm/radix: Limit paca allocation in radix
Date: Sat,  9 Apr 2016 11:43:40 +0530
Message-Id: <1460182444-2468-45-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On return from rtas we access the paca variables and we have 64 bit
disabled. This requires us to limit paca in 32 bit range.

Fix this by setting ppc64_rma_size to first_memblock_size/1G range.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable-radix.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index a5d0ae5630b3..52ed820a386a 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -339,7 +339,25 @@ void rearly_init_mmu_secondary(void)
 void rsetup_initial_memory_limit(phys_addr_t first_memblock_base,
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
