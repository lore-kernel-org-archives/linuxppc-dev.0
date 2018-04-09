Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KVJr6dB5zDrnm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 22:40:42 +1000 (AEST)
Message-Id: <61ed0c8c54d32d94ee7fb8c16d9f5c0873201bae.1523276971.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 1/2] powerpc/time: inline arch_vtime_task_switch()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon,  9 Apr 2018 14:40:33 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch_vtime_task_switch() is a small function which is called
only from vtime_common_task_switch(), so it is worth inlining

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: added a local pointer for get_accounting(prev) to avoid GCC to read it twice

 arch/powerpc/include/asm/cputime.h | 16 +++++++++++++++-
 arch/powerpc/kernel/time.c         | 21 ---------------------
 2 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
index 99b541865d8d..bc4903badb3f 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -47,9 +47,23 @@ static inline unsigned long cputime_to_usecs(const cputime_t ct)
  * has to be populated in the new task
  */
 #ifdef CONFIG_PPC64
+#define get_accounting(tsk)	(&get_paca()->accounting)
 static inline void arch_vtime_task_switch(struct task_struct *tsk) { }
 #else
-void arch_vtime_task_switch(struct task_struct *tsk);
+#define get_accounting(tsk)	(&task_thread_info(tsk)->accounting)
+/*
+ * Called from the context switch with interrupts disabled, to charge all
+ * accumulated times to the current process, and to prepare accounting on
+ * the next process.
+ */
+static inline void arch_vtime_task_switch(struct task_struct *prev)
+{
+	struct cpu_accounting_data *acct = get_accounting(current);
+	struct cpu_accounting_data *acct0 = get_accounting(prev);
+
+	acct->starttime = acct0->starttime;
+	acct->startspurr = acct0->startspurr;
+}
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 360e71d455cc..a3ed2eb99d88 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -163,12 +163,6 @@ EXPORT_SYMBOL(__cputime_usec_factor);
 void (*dtl_consumer)(struct dtl_entry *, u64);
 #endif
 
-#ifdef CONFIG_PPC64
-#define get_accounting(tsk)	(&get_paca()->accounting)
-#else
-#define get_accounting(tsk)	(&task_thread_info(tsk)->accounting)
-#endif
-
 static void calc_cputime_factors(void)
 {
 	struct div_result res;
@@ -421,21 +415,6 @@ void vtime_flush(struct task_struct *tsk)
 	acct->softirq_time = 0;
 }
 
-#ifdef CONFIG_PPC32
-/*
- * Called from the context switch with interrupts disabled, to charge all
- * accumulated times to the current process, and to prepare accounting on
- * the next process.
- */
-void arch_vtime_task_switch(struct task_struct *prev)
-{
-	struct cpu_accounting_data *acct = get_accounting(current);
-
-	acct->starttime = get_accounting(prev)->starttime;
-	acct->startspurr = get_accounting(prev)->startspurr;
-}
-#endif /* CONFIG_PPC32 */
-
 #else /* ! CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 #define calc_cputime_factors()
 #endif
-- 
2.13.3
