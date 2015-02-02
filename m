Return-Path: <asolokha@kb.kras.ru>
Received: from ispman.iskranet.ru (ispman.iskranet.ru [62.213.33.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E0201A0BA1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Feb 2015 16:28:52 +1100 (AEDT)
From: Arseny Solokha <asolokha@kb.kras.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/mm: warn on flushing tlb page in kernel context
Date: Mon,  2 Feb 2015 12:28:16 +0700
Message-Id: <1422854896-4746-1-git-send-email-asolokha@kb.kras.ru>
In-Reply-To: <1422619707-30864-1-git-send-email-asolokha@kb.kras.ru>
References: <1422619707-30864-1-git-send-email-asolokha@kb.kras.ru>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Scott Wood <scottwood@freescale.com>, Arseny Solokha <asolokha@kb.kras.ru>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Function __flush_tlb_page() must only be called for user contexts, so
put in extra hardening to warn on calling it for kernel context.

Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>
---
 arch/powerpc/mm/tlb_nohash.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index f38ea4d..cbd3d06 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -284,8 +284,15 @@ void __flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 	struct cpumask *cpu_mask;
 	unsigned int pid;
 
+	/*
+	 * This function as well as __local_flush_tlb_page() must only be called
+	 * for user contexts.
+	 */
+	if (unlikely(WARN_ON(!mm)))
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
