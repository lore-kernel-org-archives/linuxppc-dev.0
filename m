Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCgqM4vy2zDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 23:27:27 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
	anton@samba.org
Subject: [PATCH v2 1/2] powerpc/mm/radix: Optimise Page Walk Cache flush
Date: Wed, 26 Apr 2017 23:27:19 +1000
Message-Id: <1493213240-5260-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we implement flushing of the page walk cache (PWC) by calling
_tlbiel_pid() with a RIC (Radix Invalidation Control) value of 1 which says to
only flush the PWC.

But _tlbiel_pid() loops over each set (congruence class) of the TLB, which is
not necessary when we're just flushing the PWC.

In fact the set argument is ignored for a PWC flush, so essentially we're just
flushing the PWC 127 extra times for no benefit.

Fix it by adding tlbiel_pwc() which just does a single flush of the PWC.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
[mpe: Split out of combined patch, drop _ in name, rewrite change log]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/tlb-radix.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index b68b5219cf45..ae2e799822bd 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -53,6 +53,17 @@ static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
 	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
 }
 
+static inline void tlbiel_pwc(unsigned long pid)
+{
+	asm volatile("ptesync": : :"memory");
+
+	/* For PWC flush, we don't look at set number */
+	__tlbiel_pid(pid, 0, RIC_FLUSH_PWC);
+
+	asm volatile("ptesync": : :"memory");
+	asm volatile(PPC_INVALIDATE_ERAT "; isync" : : :"memory");
+}
+
 static inline void _tlbie_pid(unsigned long pid, unsigned long ric)
 {
 	unsigned long rb,rs,prs,r;
@@ -140,7 +151,7 @@ void radix__local_flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr)
 
 	pid = mm->context.id;
 	if (pid != MMU_NO_CONTEXT)
-		_tlbiel_pid(pid, RIC_FLUSH_PWC);
+		tlbiel_pwc(pid);
 
 	preempt_enable();
 }
@@ -222,7 +233,7 @@ void radix__flush_tlb_pwc(struct mmu_gather *tlb, unsigned long addr)
 		if (lock_tlbie)
 			raw_spin_unlock(&native_tlbie_lock);
 	} else
-		_tlbiel_pid(pid, RIC_FLUSH_PWC);
+		tlbiel_pwc(pid);
 no_context:
 	preempt_enable();
 }
-- 
2.7.4
