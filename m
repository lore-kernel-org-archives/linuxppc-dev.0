Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 04 Jun 2007 15:15:56 +1000
Subject: [PATCH 21/21] powerpc: Less ifdef's in signal.c/signal.h
In-Reply-To: <1180934134.603289.870346178920.qpush@grosgo>
Message-Id: <20070604051603.508F6DDE30@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch moves things around a little bit in the new common signal.c
and signal.h files to remove the last #ifdef in the middle of the
common do_signal()

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/signal.c |   15 ---------------
 arch/powerpc/kernel/signal.h |   24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 15 deletions(-)

Index: linux-cell/arch/powerpc/kernel/signal.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/signal.c	2007-06-04 13:09:27.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/signal.c	2007-06-04 13:17:50.000000000 +1000
@@ -15,19 +15,6 @@
 
 #include "signal.h"
 
-
-#ifdef CONFIG_PPC64
-static inline int is_32bit_task(void)
-{
-	return test_thread_flag(TIF_32BIT);
-}
-#else
-static inline int is_32bit_task(void)
-{
-	return 1;
-}
-#endif
-
 /*
  * Allocate space for the signal frame
  */
@@ -160,10 +147,8 @@ int do_signal(sigset_t *oldset, struct p
 		else
 			ret = handle_signal32(signr, &ka, &info, oldset,
 					regs);
-#ifdef CONFIG_PPC64
 	} else {
 		ret = handle_rt_signal64(signr, &ka, &info, oldset, regs);
-#endif
 	}
 
 	if (ret) {
Index: linux-cell/arch/powerpc/kernel/signal.h
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/signal.h	2007-06-04 13:10:10.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/signal.h	2007-06-04 13:11:03.000000000 +1000
@@ -24,8 +24,32 @@ extern int handle_rt_signal32(unsigned l
 			      siginfo_t *info, sigset_t *oldset,
 			      struct pt_regs *regs);
 
+
+#ifdef CONFIG_PPC64
+
+static inline int is_32bit_task(void)
+{
+	return test_thread_flag(TIF_32BIT);
+}
+
 extern int handle_rt_signal64(int signr, struct k_sigaction *ka,
 			      siginfo_t *info, sigset_t *set,
 			      struct pt_regs *regs);
 
+#else /* CONFIG_PPC64 */
+
+static inline int is_32bit_task(void)
+{
+	return 1;
+}
+
+static inline int handle_rt_signal64(int signr, struct k_sigaction *ka,
+				     siginfo_t *info, sigset_t *set,
+				     struct pt_regs *regs)
+{
+	return -EFAULT;
+}
+
+#endif /* !defined(CONFIG_PPC64) */
+
 #endif  /* _POWERPC_ARCH_SIGNAL_H */
