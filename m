Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Tue, 01 Jul 2008 17:00:39 +1000
Subject: [PATCH] powerpc: fix compile warning in init_thread
In-Reply-To: <18537.30774.608486.268257@cargo.ozlabs.ibm.com>
Message-Id: <1214895639.691008.114376646781.qpush@coopers>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/kernel/init_task.c:33: warning: missing braces around initializer
arch/powerpc/kernel/init_task.c:33: warning: (near initialization for 'init_task.thread.fpr[0]')

Noticed by SFR.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 include/asm-powerpc/processor.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-ozlabs/include/asm-powerpc/processor.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/processor.h
+++ linux-2.6-ozlabs/include/asm-powerpc/processor.h
@@ -222,7 +222,7 @@ struct thread_struct {
 	.ksp_limit = INIT_SP_LIMIT, \
 	.regs = (struct pt_regs *)INIT_SP - 1, /* XXX bogus, I think */ \
 	.fs = KERNEL_DS, \
-	.fpr = {0}, \
+	.fpr = {{0}}, \
 	.fpscr = { .val = 0, }, \
 	.fpexc_mode = 0, \
 }
