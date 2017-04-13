Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3TYf6NlGzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 15:17:10 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id o123so9010956pga.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 22:17:10 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [RFC][PATCH] powerpc/mm: convert tlbie to tlbiel when no batch is
 active
Date: Thu, 13 Apr 2017 15:16:55 +1000
Message-Id: <20170413051655.26113-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Do the checks that __flush_tlb_pending() does and check if
a local flush will do when batch->active is false inside of
hpte_need_flush(). I've checked the changes with tlbie tracing,
I see local flushes as applicable now and I've also run
some basic ltp testcases on top of these changes on a powernv
machine.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/mm/tlb_hash64.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index 4517aa4..1268e3a 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -93,12 +93,17 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 
 	/*
 	 * Check if we have an active batch on this CPU. If not, just
-	 * flush now and return. For now, we don global invalidates
-	 * in that case, might be worth testing the mm cpu mask though
-	 * and decide to use local invalidates instead...
+	 * flush now and return.
 	 */
 	if (!batch->active) {
-		flush_hash_page(vpn, rpte, psize, ssize, 0);
+		const struct cpumask *tmp;
+		int local = 0;
+
+		tmp = cpumask_of(smp_processor_id());
+		if (cpumask_equal(mm_cpumask(mm), tmp))
+			local = 1;
+
+		flush_hash_page(vpn, rpte, psize, ssize, local);
 		put_cpu_var(ppc64_tlb_batch);
 		return;
 	}
-- 
2.9.3
