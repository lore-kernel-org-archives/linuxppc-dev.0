Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNGvT0TQ8zDrb8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 14:16:05 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id j68so358175pfc.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 21:16:04 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 aneesh.kumar@linux.vnet.ibm.com,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH] powerpc/mm: Invalidate partition table cache on host proc tbl
 base update
Date: Thu,  3 Aug 2017 14:15:51 +1000
Message-Id: <20170803041551.7934-1-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The host process table base is stored in the partition table by calling
the function native_register_process_table(). Currently this just sets
the entry in memory and is missing a proceeding cache invalidation
instruction. Any update to the partition table should be followed by a
cache invalidation instruction specifying invalidation of the caching of
any partition table entries (RIC = 2, PRS = 0).

We already have a function to update the partition table with the
required cache invalidation instructions - mmu_partition_table_set_entry().
Update the native_register_process_table() function to call
mmu_partition_table_set_entry(), this ensures all appropriate
invalidation will be performed.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/mm/pgtable-radix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 671a45d..1d5178f 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -33,7 +33,8 @@ static int native_register_process_table(unsigned long base, unsigned long pg_sz
 {
 	unsigned long patb1 = base | table_size | PATB_GR;
 
-	partition_tb->patb1 = cpu_to_be64(patb1);
+	mmu_partition_table_set_entry(0, be64_to_cpu(partition_tb->patb0),
+				      patb1);
 	return 0;
 }
 
-- 
2.9.4
