Return-Path: <anton@samba.org>
Date: Fri, 7 Jan 2011 15:00:36 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 8/8] powerpc/kdump: Disable ftrace during kexec
Message-ID: <20110107150036.5b21b394@kryten>
In-Reply-To: <20110107145255.72cf30ba@kryten>
References: <20110107145255.72cf30ba@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We should disable ftrace during kexec, some of the tracers are very invasive
and we do not want them going off while doing the low level work of swapping
one kernel out for another. This mirrors what we do on x86.

Even though we cannot return from a kexec on powerpc (since we do not implement
CONFIG_KEXEC_JUMP), add the restore code in case we do one day.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/kernel/machine_kexec.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/machine_kexec.c	2011-01-07 12:51:56.222461754 +1100
+++ powerpc.git/arch/powerpc/kernel/machine_kexec.c	2011-01-07 12:52:02.012644243 +1100
@@ -15,6 +15,7 @@
 #include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/irq.h>
+#include <linux/ftrace.h>
 
 #include <asm/machdep.h>
 #include <asm/prom.h>
@@ -82,8 +83,14 @@ void arch_crash_save_vmcoreinfo(void)
  */
 void machine_kexec(struct kimage *image)
 {
+	int save_ftrace_enabled;
+
+	save_ftrace_enabled = __ftrace_enabled_save();
+
 	default_machine_kexec(image);
 
+	__ftrace_enabled_restore(save_ftrace_enabled);
+
 	/* Fall back to normal restart if we're still alive. */
 	machine_restart(NULL);
 	for(;;);
