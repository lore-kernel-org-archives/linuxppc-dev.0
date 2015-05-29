Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75CD81A0551
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 13:55:57 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 29 May 2015 13:55:55 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D47DE2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 13:55:53 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4T3tjcT50397248
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 13:55:53 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4T3tKe4020825
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 13:55:21 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, hmyneni@gmail.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 2/3] powerpc/mm: Limit the max memory we can support
Date: Fri, 29 May 2015 09:24:51 +0530
Message-Id: <1432871692-707-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1432871692-707-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1432871692-707-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to limit the max memory based on Linux page table format.
For example, with 4K page size we can't support 64TB memory based
on the existing pte format. Add checks to limit memory based
on pte size.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 308c5e15676b..a0108ddde01c 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -698,9 +698,25 @@ void __init early_init_devtree(void *params)
 #endif
 		reserve_crashkernel();
 	early_reserve_mem();
-
-	/* Ensure that total memory size is page-aligned. */
-	limit = ALIGN(memory_limit ?: memblock_phys_mem_size(), PAGE_SIZE);
+	/*
+	 * if not specified limit the memory based on the pfn count that
+	 * we can fit in pte_t. Also ensure that total memory size is
+	 * page-aligned.
+	 */
+	if (!memory_limit) {
+		int bit_count;
+		phys_addr_t pte_mem_limit;
+
+		BUILD_BUG_ON(sizeof(pte_basic_t) > 8);
+		bit_count = (sizeof(pte_basic_t) * 8) - PTE_RPN_SHIFT + PAGE_SHIFT;
+		pte_mem_limit = ~0ULL >> (64 - bit_count);
+		limit = memblock_phys_mem_size();
+		if (limit > pte_mem_limit)
+			limit = pte_mem_limit;
+	} else
+		limit = memory_limit;
+
+	limit = ALIGN(limit, PAGE_SIZE);
 	memblock_enforce_memory_limit(limit);
 
 	memblock_allow_resize();
-- 
2.1.4
