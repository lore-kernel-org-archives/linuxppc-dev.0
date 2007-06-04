Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 04 Jun 2007 15:15:53 +1000
Subject: [PATCH 18/21] powerpc: Remove obsolete freezer bits
In-Reply-To: <1180934134.603289.870346178920.qpush@grosgo>
Message-Id: <20070604051558.36B94DDF8C@ozlabs.org>
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

The powerpc signal code still had some obsolete freezer bits that
have long been removed from x86 (it's now done in generic code).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/signal.c |   12 ------------
 1 file changed, 12 deletions(-)

Index: linux-cell/arch/powerpc/kernel/signal.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/signal.c	2007-06-04 11:44:24.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/signal.c	2007-06-04 11:44:34.000000000 +1000
@@ -9,7 +9,6 @@
  * this archive for more details.
  */
 
-#include <linux/freezer.h>
 #include <linux/ptrace.h>
 #include <linux/signal.h>
 
@@ -100,14 +99,6 @@ int do_signal(sigset_t *oldset, struct p
 	int ret;
 	int is32 = is_32bit_task();
 
-#ifdef CONFIG_PPC32
-	if (try_to_freeze()) {
-		signr = 0;
-		if (!signal_pending(current))
-			goto no_signal;
-	}
-#endif
-
 	if (test_thread_flag(TIF_RESTORE_SIGMASK))
 		oldset = &current->saved_sigmask;
 	else if (!oldset)
@@ -115,9 +106,6 @@ int do_signal(sigset_t *oldset, struct p
 
 	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 
-#ifdef CONFIG_PPC32
-no_signal:
-#endif
 	/* Is there any syscall restart business here ? */
 	check_syscall_restart(regs, &ka, signr > 0);
 
