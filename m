Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 427202C033F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 20:31:36 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <scottwood@freescale.com>
Subject: [v6][PATCH 1/5] powerpc/book3e: initialize crit/mc/dbg kernel stack
 pointers
Date: Wed, 23 Oct 2013 17:31:21 +0800
Message-ID: <1382520685-11609-2-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1382520685-11609-1-git-send-email-tiejun.chen@windriver.com>
References: <1382520685-11609-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We already allocated critical/machine/debug check exceptions, but
we also should initialize those associated kernel stack pointers
for use by special exceptions in the PACA.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kernel/setup_64.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 278ca93..5c96d92 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -526,14 +526,20 @@ static void __init exc_lvl_early_init(void)
 	extern unsigned int exc_debug_debug_book3e;
 
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
1.7.9.5
