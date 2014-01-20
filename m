Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 560B72C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jan 2014 19:39:42 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <scottwood@freescale.com>
Subject: [PATCH] powerpc: hugetlb: replace __get_cpu_var with get_cpu_var
Date: Mon, 20 Jan 2014 16:39:34 +0800
Message-ID: <1390207175-2181-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace __get_cpu_var safely with get_cpu_var to avoid
the following call trace:

[ 7253.637591] BUG: using smp_processor_id() in preemptible [00000000 00000000]
code: hugemmap01/9048
[ 7253.637601] caller is free_hugepd_range.constprop.25+0x88/0x1a8
[ 7253.637605] CPU: 1 PID: 9048 Comm: hugemmap01 Not tainted 3.10.20-rt14+ #114
[ 7253.637606] Call Trace:
[ 7253.637617] [cb049d80] [c0007ea4] show_stack+0x4c/0x168 (unreliable)
[ 7253.637624] [cb049dc0] [c031c674] debug_smp_processor_id+0x114/0x134
[ 7253.637628] [cb049de0] [c0016d28] free_hugepd_range.constprop.25+0x88/0x1a8
[ 7253.637632] [cb049e00] [c001711c] hugetlb_free_pgd_range+0x6c/0x168
[ 7253.637639] [cb049e40] [c0117408] free_pgtables+0x12c/0x150
[ 7253.637646] [cb049e70] [c011ce38] unmap_region+0xa0/0x11c
[ 7253.637671] [cb049ef0] [c011f03c] do_munmap+0x224/0x3bc
[ 7253.637676] [cb049f20] [c011f2e0] vm_munmap+0x38/0x5c
[ 7253.637682] [cb049f40] [c000ef88] ret_from_syscall+0x0/0x3c
[ 7253.637686] --- Exception: c01 at 0xff16004

Signed-off-by: Tiejun Chen<tiejun.chen@windriver.com>
---
 arch/powerpc/mm/hugetlbpage.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 90bb6d9..eb92365 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -472,12 +472,13 @@ static void hugepd_free(struct mmu_gather *tlb, void *hugepte)
 {
 	struct hugepd_freelist **batchp;
 
-	batchp = &__get_cpu_var(hugepd_freelist_cur);
+	batchp = &get_cpu_var(hugepd_freelist_cur);
 
 	if (atomic_read(&tlb->mm->mm_users) < 2 ||
 	    cpumask_equal(mm_cpumask(tlb->mm),
 			  cpumask_of(smp_processor_id()))) {
 		kmem_cache_free(hugepte_cache, hugepte);
+        put_cpu_var(hugepd_freelist_cur);
 		return;
 	}
 
@@ -491,6 +492,7 @@ static void hugepd_free(struct mmu_gather *tlb, void *hugepte)
 		call_rcu_sched(&(*batchp)->rcu, hugepd_free_rcu_callback);
 		*batchp = NULL;
 	}
+	put_cpu_var(hugepd_freelist_cur);
 }
 #endif
 
-- 
1.7.9.5
