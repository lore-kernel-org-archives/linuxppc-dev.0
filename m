Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBlnB5DcwzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 21:22:06 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 06/20] powerpc/64: Make type of partition table flush
 depend on partition type
Date: Mon, 30 Jan 2017 21:21:39 +1100
Message-Id: <1485771713-24801-7-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
References: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When changing a partition table entry on POWER9, we do a particular
form of the tlbie instruction which flushes all TLBs and caches of
the partition table for a given logical partition ID (LPID).
This instruction has a field in the instruction word, labelled R
(radix), which should be 1 if the partition was previously a radix
partition and 0 if it was a HPT partition.  This implements that
logic.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/mm/pgtable_64.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 8bca7f5..d6b5e5c 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -454,13 +454,23 @@ void __init mmu_partition_table_init(void)
 void mmu_partition_table_set_entry(unsigned int lpid, unsigned long dw0,
 				   unsigned long dw1)
 {
+	unsigned long old = be64_to_cpu(partition_tb[lpid].patb0);
+
 	partition_tb[lpid].patb0 = cpu_to_be64(dw0);
 	partition_tb[lpid].patb1 = cpu_to_be64(dw1);
 
-	/* Global flush of TLBs and partition table caches for this lpid */
+	/*
+	 * Global flush of TLBs and partition table caches for this lpid.
+	 * The type of flush (hash or radix) depends on what the previous
+	 * use of this partition ID was, not the new use.
+	 */
 	asm volatile("ptesync" : : : "memory");
-	asm volatile(PPC_TLBIE_5(%0,%1,2,0,0) : :
-		     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
+	if (old & PATB_HR)
+		asm volatile(PPC_TLBIE_5(%0,%1,2,0,1) : :
+			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
+	else
+		asm volatile(PPC_TLBIE_5(%0,%1,2,0,0) : :
+			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
 	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
 }
 EXPORT_SYMBOL_GPL(mmu_partition_table_set_entry);
-- 
2.7.4
