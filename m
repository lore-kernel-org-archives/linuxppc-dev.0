Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDFKl3lBmzDvVl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 16:36:43 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 144so13850214pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Nov 2016 21:36:43 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: sjitindarsingh@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com
Subject: [PATCH] powerpc/mm: Correct process and partition table max size
Date: Wed,  9 Nov 2016 16:36:33 +1100
Message-Id: <1478669793-15074-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Version 3.00 of the ISA states that the PATS (partition table size) field
of the PTCR (partition table control register) and the PRTS (process table
size) field of the partition table entry must both be less than or equal
to 24. However the actual size of the partition and process tables is equal
to 2 to the power of 12 plus the PATS and PRTS fields, respectively. This
means that the max allowable size of each of these tables is 2^36 or 64GB
for both.

Thus when checking the size shift for each we should be checking for values
of greater than 36 instead of the current check for shifts larger than 24
and 23.

Fixes: 2bfd65e45e877fb5704730244da67c748d28a1b8
Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/mm/pgtable-radix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index ed7bddc..80f3479 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -159,7 +159,7 @@ static void __init radix_init_pgtable(void)
 	 * Allocate Partition table and process table for the
 	 * host.
 	 */
-	BUILD_BUG_ON_MSG((PRTB_SIZE_SHIFT > 23), "Process table size too large.");
+	BUILD_BUG_ON_MSG((PRTB_SIZE_SHIFT > 36), "Process table size too large.");
 	process_tb = early_alloc_pgtable(1UL << PRTB_SIZE_SHIFT);
 	/*
 	 * Fill in the process table.
@@ -181,7 +181,7 @@ static void __init radix_init_partition_table(void)
 
 	rts_field = radix__get_tree_size();
 
-	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 24), "Partition table size too large.");
+	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 36), "Partition table size too large.");
 	partition_tb = early_alloc_pgtable(1UL << PATB_SIZE_SHIFT);
 	partition_tb->patb0 = cpu_to_be64(rts_field | __pa(init_mm.pgd) |
 					  RADIX_PGD_INDEX_SIZE | PATB_HR);
-- 
2.5.5
