Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWnP85MMnzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 14:33:48 +1100 (AEDT)
Date: Mon, 27 Feb 2017 14:32:41 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/64: Invalidate process table caching after setting
 process table
Message-ID: <20170227033241.GA3591@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The POWER9 MMU reads and caches entries from the process table.
When we kexec from one kernel to another, the second kernel sets
its process table pointer but doesn't currently do anything to
make the CPU invalidate any cached entries from the old process table.
This adds a tlbie (TLB invalidate entry) instruction with parameters
to invalidate caching of the process table after the new process
table is installed.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/mm/pgtable-radix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 7ac17e9..c6a9f37 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -173,6 +173,10 @@ static void __init radix_init_pgtable(void)
 	 */
 	register_process_table(__pa(process_tb), 0, PRTB_SIZE_SHIFT - 12);
 	pr_info("Process table %p and radix root for kernel: %p\n", process_tb, init_mm.pgd);
+	asm volatile("ptesync" : : : "memory");
+	asm volatile(PPC_TLBIE_5(%0,%1,2,1,1) : :
+		     "r" (TLBIEL_INVAL_SET_LPID), "r" (0));
+	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
 }
 
 static void __init radix_init_partition_table(void)
-- 
2.10.2
