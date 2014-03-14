Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C26622C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Mar 2014 11:01:14 +1100 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 01/10] powerpc/book3e: initialize crit/mc/dbg kernel stack
 pointers
Date: Thu, 13 Mar 2014 19:00:40 -0500
Message-ID: <1394755249-8856-2-git-send-email-scottwood@freescale.com>
In-Reply-To: <1394755249-8856-1-git-send-email-scottwood@freescale.com>
References: <1394755249-8856-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Tiejun Chen <tiejun.chen@windriver.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tiejun Chen <tiejun.chen@windriver.com>

We already allocated critical/machine/debug check exceptions, but
we also should initialize those associated kernel stack pointers
for use by special exceptions in the PACA.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/setup_64.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index f5f11a7..da9c42f 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -552,14 +552,20 @@ static void __init irqstack_early_init(void)
 static void __init exc_lvl_early_init(void)
 {
 	unsigned int i;
+	unsigned long sp;
 
 	for_each_possible_cpu(i) {
-		critirq_ctx[i] = (struct thread_info *)
-			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
-		dbgirq_ctx[i] = (struct thread_info *)
-			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
-		mcheckirq_ctx[i] = (struct thread_info *)
-			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
+		sp = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
+		critirq_ctx[i] = (struct thread_info *)__va(sp);
+		paca[i].crit_kstack = __va(sp + THREAD_SIZE);
+
+		sp = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
+		dbgirq_ctx[i] = (struct thread_info *)__va(sp);
+		paca[i].dbg_kstack = __va(sp + THREAD_SIZE);
+
+		sp = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
+		mcheckirq_ctx[i] = (struct thread_info *)__va(sp);
+		paca[i].mc_kstack = __va(sp + THREAD_SIZE);
 	}
 
 	if (cpu_has_feature(CPU_FTR_DEBUG_LVL_EXC))
-- 
1.8.3.2
