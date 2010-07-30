Return-Path: <matt@ozlabs.org>
Message-ID: <4C525955.3060206@ozlabs.org>
Date: Fri, 30 Jul 2010 14:47:17 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org
Subject: [PATCH 1/2] powerpc/kexec: Add to and tidy debug/comments in
	machine_kexec64.c
References: <4C5258C8.1030305@ozlabs.org>
In-Reply-To: <4C5258C8.1030305@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Neuling <mikey@neuling.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tidies some typos, KERN_INFO-ise an info msg, and add a debug msg showing
when the final sequence starts.

Also adds a comment to kexec_prepare_cpus_wait() to make note of a possible
problem; the need for kexec to deal with CPUs that failed to originally start
up.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 arch/powerpc/kernel/machine_kexec_64.c |   29 ++++++++++++++++++++++++-----
 1 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 4fbb3be..aa3d5cd 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -15,6 +15,7 @@
 #include <linux/thread_info.h>
 #include <linux/init_task.h>
 #include <linux/errno.h>
+#include <linux/kernel.h>
 
 #include <asm/page.h>
 #include <asm/current.h>
@@ -181,7 +182,20 @@ static void kexec_prepare_cpus_wait(int wait_state)
 	int my_cpu, i, notified=-1;
 
 	my_cpu = get_cpu();
-	/* Make sure each CPU has atleast made it to the state we need */
+	/* Make sure each CPU has at least made it to the state we need.
+	 *
+	 * FIXME: There is a (slim) chance of a problem if not all of the CPUs
+	 * are correctly onlined.  If somehow we start a CPU on boot with RTAS
+	 * start-cpu, but somehow that CPU doesn't write callin_cpu_map[] in
+	 * time, the boot CPU will timeout.  If it does eventually execute
+	 * stuff, the secondary will start up (paca[].cpu_start was written) and
+	 * get into a peculiar state.  If the platform supports
+	 * smp_ops->take_timebase(), the secondary CPU will probably be spinning
+	 * in there.  If not (i.e. pseries), the secondary will continue on and
+	 * try to online itself/idle/etc. If it survives that, we need to find
+	 * these possible-but-not-online-but-should-be CPUs and chaperone them
+	 * into kexec_smp_wait().
+	 */
 	for_each_online_cpu(i) {
 		if (i == my_cpu)
 			continue;
@@ -189,9 +203,9 @@ static void kexec_prepare_cpus_wait(int wait_state)
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
@@ -215,7 +229,10 @@ static void kexec_prepare_cpus(void)
 	if (ppc_md.kexec_cpu_down)
 		ppc_md.kexec_cpu_down(0, 0);
 
-	/* Before removing MMU mapings make sure all CPUs have entered real mode */
+	/*
+	 * Before removing MMU mappings make sure all CPUs have entered real
+	 * mode:
+	 */
 	kexec_prepare_cpus_wait(KEXEC_STATE_REAL_MODE);
 
 	put_cpu();
@@ -284,6 +301,8 @@ void default_machine_kexec(struct kimage *image)
 	if (crashing_cpu == -1)
 		kexec_prepare_cpus();
 
+	pr_debug("kexec: Starting switchover sequence.\n");
+
 	/* switch to a staticly allocated stack.  Based on irq stack code.
 	 * XXX: the task struct will likely be invalid once we do the copy!
 	 */
-- 
1.6.3.3
