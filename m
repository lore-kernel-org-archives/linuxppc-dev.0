Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409tCW4hn0zF2D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 14:09:43 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id t16so454527pfh.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 20:09:43 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mm: Fix printing of process table address
Date: Wed, 28 Mar 2018 14:09:32 +1100
Message-Id: <20180328030932.32169-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

New changes to %p cause the information printed at boot
about radix-mmu partition and process table opaque, if
we really want to protect those values, we should make
dmesg more secure using CONFIG_SECURITY_DMESG_RESTRICT

Before the patches:

radix-mmu: Partition table         (ptrval)
radix-mmu: Process table         (ptrval) and radix root for kernel:         (ptrval)

After the patches

radix-mmu: Partition table c0000000ffff0000
radix-mmu: Process table c0000000fe000000 and radix root for kernel: c0000000015a0000

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/mm/pgtable-radix.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 2e10a964e290..3f676e89c3a6 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -329,7 +329,8 @@ static void __init radix_init_pgtable(void)
 	 * physical address here.
 	 */
 	register_process_table(__pa(process_tb), 0, PRTB_SIZE_SHIFT - 12);
-	pr_info("Process table %p and radix root for kernel: %p\n", process_tb, init_mm.pgd);
+	pr_info("Process table %px and radix root for kernel: %px\n",
+			process_tb, init_mm.pgd);
 	asm volatile("ptesync" : : : "memory");
 	asm volatile(PPC_TLBIE_5(%0,%1,2,1,1) : :
 		     "r" (TLBIEL_INVAL_SET_LPID), "r" (0));
@@ -363,7 +364,7 @@ static void __init radix_init_partition_table(void)
 	mmu_partition_table_set_entry(0, dw0, 0);
 
 	pr_info("Initializing Radix MMU\n");
-	pr_info("Partition table %p\n", partition_tb);
+	pr_info("Partition table %px\n", partition_tb);
 }
 
 void __init radix_init_native(void)
-- 
2.13.6
