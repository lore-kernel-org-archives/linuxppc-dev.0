Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcpr430DhzDqZr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 23:56:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] powerpc/oops: Use IS_ENABLED() for oops markers
Date: Wed, 23 Aug 2017 23:56:22 +1000
Message-Id: <1503496584-21970-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1503496584-21970-1-git-send-email-mpe@ellerman.id.au>
References: <1503496584-21970-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just because it looks less gross.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/traps.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 5a54a6f54f70..f77d954f6622 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -208,17 +208,18 @@ static int __die(const char *str, struct pt_regs *regs, long err)
 	else
 		printk("BE ");
 
-#ifdef CONFIG_PREEMPT
-	pr_cont("PREEMPT ");
-#endif
-#ifdef CONFIG_SMP
-	pr_cont("SMP NR_CPUS=%d ", NR_CPUS);
-#endif
+	if (IS_ENABLED(CONFIG_PREEMPT))
+		pr_cont("PREEMPT ");
+
+	if (IS_ENABLED(CONFIG_SMP))
+		pr_cont("SMP NR_CPUS=%d ", NR_CPUS);
+
 	if (debug_pagealloc_enabled())
 		pr_cont("DEBUG_PAGEALLOC ");
-#ifdef CONFIG_NUMA
-	pr_cont("NUMA ");
-#endif
+
+	if (IS_ENABLED(CONFIG_NUMA))
+		pr_cont("NUMA ");
+
 	pr_cont("%s\n", ppc_md.name ? ppc_md.name : "");
 
 	if (notify_die(DIE_OOPS, str, regs, err, 255, SIGSEGV) == NOTIFY_STOP)
-- 
2.7.4
