Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC4NH22D0zDrLs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:50:38 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 10/24] powerpc/mm: Move debugger check to notify_page_fault()
Date: Wed, 19 Jul 2017 14:49:32 +1000
Message-Id: <20170719044946.22030-10-benh@kernel.crashing.org>
In-Reply-To: <20170719044946.22030-1-benh@kernel.crashing.org>
References: <20170719044946.22030-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

unclutters the main path

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/fault.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 4470500b4871..2f825ae68f20 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -47,27 +47,25 @@
 
 #include "icswx.h"
 
-#ifdef CONFIG_KPROBES
-static inline int notify_page_fault(struct pt_regs *regs)
+static inline bool notify_page_fault(struct pt_regs *regs)
 {
-	int ret = 0;
+	bool ret = false;
 
+#ifdef CONFIG_KPROBES
 	/* kprobe_running() needs smp_processor_id() */
 	if (!user_mode(regs)) {
 		preempt_disable();
 		if (kprobe_running() && kprobe_fault_handler(regs, 11))
-			ret = 1;
+			ret = true;
 		preempt_enable();
 	}
+#endif /* CONFIG_KPROBES */
+
+	if (unlikely(debugger_fault_handler(regs)))
+		ret = true;
 
 	return ret;
 }
-#else
-static inline int notify_page_fault(struct pt_regs *regs)
-{
-	return 0;
-}
-#endif
 
 /*
  * Check whether the instruction at regs->nip is a store using
@@ -242,9 +240,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (notify_page_fault(regs))
 		goto bail;
 
-	if (unlikely(debugger_fault_handler(regs)))
-		goto bail;
-
 	if (unlikely(page_fault_is_bad(error_code))) {
 		if (is_user)
 			_exception(SIGBUS, regs, BUS_OBJERR, address);
-- 
2.13.3
