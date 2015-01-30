Return-Path: <asolokha@kb.kras.ru>
Received: from ispman.iskranet.ru (ispman.iskranet.ru [62.213.33.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BDB2D1A0DF2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 23:20:02 +1100 (AEDT)
From: Arseny Solokha <asolokha@kb.kras.ru>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH] powerpc/mm: bail out early when flushing TLB page
Date: Fri, 30 Jan 2015 19:08:27 +0700
Message-Id: <1422619707-30864-1-git-send-email-asolokha@kb.kras.ru>
Cc: linux-kernel@vger.kernel.org, Arseny Solokha <asolokha@kb.kras.ru>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MMU_NO_CONTEXT is conditionally defined as 0 or (unsigned int)-1. However,
in __flush_tlb_page() a corresponding variable is only tested for open
coded 0, which can cause NULL pointer dereference if `mm' argument was
legitimately passed as such.

Bail out early in case the first argument is NULL, thus eliminate confusion
between different values of MMU_NO_CONTEXT and avoid disabling and then
re-enabling preemption unnecessarily.

Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>
---
 arch/powerpc/mm/tlb_nohash.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index f38ea4d..ab0616b 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -284,8 +284,11 @@ void __flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 	struct cpumask *cpu_mask;
 	unsigned int pid;
 
+	if (unlikely(!mm))
+		return;
+
 	preempt_disable();
-	pid = mm ? mm->context.id : 0;
+	pid = mm->context.id;
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		goto bail;
 	cpu_mask = mm_cpumask(mm);
-- 
2.2.2
