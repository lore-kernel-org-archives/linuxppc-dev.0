Return-Path: <lvivier@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E81071A0739
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 06:01:16 +1100 (AEDT)
From: Laurent Vivier <lvivier@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dgibson@redhat.com, thuth@redhat.com, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] powerpc: on crash, kexec'ed kernel needs all CPUs are online
Date: Thu, 15 Oct 2015 21:00:58 +0200
Message-Id: <1444935658-27319-1-git-send-email-lvivier@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On kexec, all secondary offline CPUs are onlined before
starting the new kernel, this is not done in the case of kdump.

If kdump is configured and a kernel crash occurs whereas
some secondaries CPUs are offline (SMT=off),
the new kernel is not able to start them and displays some
"Processor X is stuck.".

Starting with POWER8, subcore logic relies on all threads of
core being booted. So, on startup kernel tries to start all
threads, and asks OPAL (or RTAS) to start all CPUs (including
threads). If a CPU has been offlined by the previous kernel,
it has not been returned to OPAL, and thus OPAL cannot restart
it: this CPU has been lost...

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 arch/powerpc/kernel/crash.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 51dbace..3ca9452 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/types.h>
+#include <linux/cpu.h>
 
 #include <asm/processor.h>
 #include <asm/machdep.h>
@@ -299,11 +300,30 @@ int crash_shutdown_unregister(crash_shutdown_t handler)
 }
 EXPORT_SYMBOL(crash_shutdown_unregister);
 
+/*
+ * The next kernel will try to start all secondary CPUs and if
+ * there are not online it will fail to start them.
+ *
+ */
+static void wake_offline_cpus(void)
+{
+	int cpu = 0;
+
+	for_each_present_cpu(cpu) {
+		if (!cpu_online(cpu)) {
+			pr_info("kexec: Waking offline cpu %d.\n", cpu);
+			cpu_up(cpu);
+		}
+	}
+}
+
 void default_machine_crash_shutdown(struct pt_regs *regs)
 {
 	unsigned int i;
 	int (*old_handler)(struct pt_regs *regs);
 
+	wake_offline_cpus();
+
 	/*
 	 * This function is only called after the system
 	 * has panicked or is otherwise in a critical state.
-- 
2.1.0
