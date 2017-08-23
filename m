Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcpr20rBJzDqZr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 23:56:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] powerpc/oops: Fix the oops markers to use pr_cont()
Date: Wed, 23 Aug 2017 23:56:20 +1000
Message-Id: <1503496584-21970-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we oops we print a few markers for significant config options
such as PREEMPT, SMP etc. Currently these appear on separate lines
because we're not using pr_cont() properly. Fix it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/traps.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 675d5d2bfcde..82d0ce236f9d 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -203,17 +203,17 @@ static int __die(const char *str, struct pt_regs *regs, long err)
 {
 	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
 #ifdef CONFIG_PREEMPT
-	printk("PREEMPT ");
+	pr_cont("PREEMPT ");
 #endif
 #ifdef CONFIG_SMP
-	printk("SMP NR_CPUS=%d ", NR_CPUS);
+	pr_cont("SMP NR_CPUS=%d ", NR_CPUS);
 #endif
 	if (debug_pagealloc_enabled())
-		printk("DEBUG_PAGEALLOC ");
+		pr_cont("DEBUG_PAGEALLOC ");
 #ifdef CONFIG_NUMA
-	printk("NUMA ");
+	pr_cont("NUMA ");
 #endif
-	printk("%s\n", ppc_md.name ? ppc_md.name : "");
+	pr_cont("%s\n", ppc_md.name ? ppc_md.name : "");
 
 	if (notify_die(DIE_OOPS, str, regs, err, 255, SIGSEGV) == NOTIFY_STOP)
 		return 1;
-- 
2.7.4
