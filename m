Return-Path: <matt@ozlabs.org>
Received: from [10.61.2.237] (ibmaus65.lnk.telstra.net [165.228.126.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPSA id 28C9AB6EEE
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 17:54:25 +1000 (EST)
Message-ID: <4C4E90B6.30503@ozlabs.org>
Date: Tue, 27 Jul 2010 17:54:30 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/kexec: Fix orphaned offline CPUs across kexec
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When CPU hotplug is used, some CPUs may be offline at the time a kexec is
performed.  The subsequent kernel may expect these CPUs to be already running,
and will declare them stuck.  On pseries, there's also a soft-offline (cede)
state that CPUs may be in; this can also cause problems as the kexeced kernel
may ask RTAS if they're online -- and RTAS would say they are.  Again, stuck.

This patch kicks each present offline CPU awake before the kexec, so that
none are lost to these assumptions in the subsequent kernel.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 arch/powerpc/kernel/machine_kexec_64.c |   42 +++++++++++++++++++++++++++----
 1 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 4fbb3be..c2fd914 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -15,6 +15,8 @@
 #include <linux/thread_info.h>
 #include <linux/init_task.h>
 #include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/cpu.h>
 
 #include <asm/page.h>
 #include <asm/current.h>
@@ -181,7 +183,7 @@ static void kexec_prepare_cpus_wait(int wait_state)
 	int my_cpu, i, notified=-1;
 
 	my_cpu = get_cpu();
-	/* Make sure each CPU has atleast made it to the state we need */
+	/* Make sure each CPU has at least made it to the state we need. */
 	for_each_online_cpu(i) {
 		if (i == my_cpu)
 			continue;
@@ -189,9 +191,9 @@ static void kexec_prepare_cpus_wait(int wait_state)
 		while (paca[i].kexec_state < wait_state) {
 			barrier();
 			if (i != notified) {
-				printk( "kexec: waiting for cpu %d (physical"
-						" %d) to enter %i state\n",
-					i, paca[i].hw_cpu_id, wait_state);
+				printk(KERN_INFO "kexec: waiting for cpu %d "
+				       "(physical %d) to enter %i state\n",
+				       i, paca[i].hw_cpu_id, wait_state);
 				notified = i;
 			}
 		}
@@ -199,9 +201,32 @@ static void kexec_prepare_cpus_wait(int wait_state)
 	mb();
 }
 
-static void kexec_prepare_cpus(void)
+/*
+ * We need to make sure each present CPU is online.  The next kernel will scan
+ * the device tree and assume primary threads are online and query secondary
+ * threads via RTAS to online them if required.  If we don't online primary
+ * threads, they will be stuck.  However, we also online secondary threads as we
+ * may be using 'cede offline'.  In this case RTAS doesn't see the secondary
+ * threads as offline -- and again, these CPUs will be stuck.
+ *
+ * So, we online all CPUs that should be running, including secondary threads.
+ */
+static void wake_offline_cpus(void)
 {
+	int cpu = 0;
 
+	for_each_present_cpu(cpu) {
+		if (!cpu_online(cpu)) {
+			printk(KERN_INFO "kexec: Waking offline cpu %d.\n",
+			       cpu);
+			cpu_up(cpu);
+		}
+	}
+}
+
+static void kexec_prepare_cpus(void)
+{
+	wake_offline_cpus();
 	smp_call_function(kexec_smp_down, NULL, /* wait */0);
 	local_irq_disable();
 	mb(); /* make sure IRQs are disabled before we say they are */
@@ -215,7 +240,10 @@ static void kexec_prepare_cpus(void)
 	if (ppc_md.kexec_cpu_down)
 		ppc_md.kexec_cpu_down(0, 0);
 
-	/* Before removing MMU mapings make sure all CPUs have entered real mode */
+	/*
+	 * Before removing MMU mappings make sure all CPUs have entered real
+	 * mode:
+	 */
 	kexec_prepare_cpus_wait(KEXEC_STATE_REAL_MODE);
 
 	put_cpu();
@@ -284,6 +312,8 @@ void default_machine_kexec(struct kimage *image)
 	if (crashing_cpu == -1)
 		kexec_prepare_cpus();
 
+	pr_debug("kexec: Starting switchover sequence.\n");
+
 	/* switch to a staticly allocated stack.  Based on irq stack code.
 	 * XXX: the task struct will likely be invalid once we do the copy!
 	 */
-- 
1.6.3.3
