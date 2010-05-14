Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Neuling <mikey@neuling.org>
Date: Fri, 14 May 2010 13:57:00 +1000
Subject: [PATCH 2/2] powerpc, kdump: Fix race in kdump shutdown
In-Reply-To: <1273559307.55666.645438163872.qpush@pale>
Message-Id: <20100514035700.90C39CED6C@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org,
	Anton Blanchard <anton@samba.org>, jlarrew@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we are crashing, the crashing/primary CPU IPIs the secondaries to
turn off IRQs, go into real mode and wait in kexec_wait.  While this
is happening, the primary tears down all the MMU maps.  Unfortunately
the primary doesn't check to make sure the secondaries have entered
real mode before doing this.

On PHYP machines, the secondaries can take a long time shutting down
the IRQ controller as RTAS calls are need.  These RTAS calls need to
be serialised which resilts in the secondaries contending in
lock_rtas() and hence taking a long time to shut down.

We've hit this on large POWER7 machines, where some secondaries are
still waiting in lock_rtas(), when the primary tears down the HPTEs.

This patch makes sure all secondaries are in real mode before the
primary tears down the MMU.  It uses the new kexec_state entry in the
paca.  It times out if the secondaries don't reach real mode after
10sec.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/kernel/crash.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/crash.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/crash.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/crash.c
@@ -162,6 +162,33 @@ static void crash_kexec_prepare_cpus(int
 	/* Leave the IPI callback set */
 }
 
+/* wait for all the CPUs to hit real mode but timeout if they don't come in */
+static void crash_kexec_wait_realmode(int cpu)
+{
+	unsigned int msecs;
+	int i;
+
+	/* check the others cpus are now down (via paca kexec_irqs_off == 1) */
+	msecs = 10000;
+	for (i=0; i < NR_CPUS && msecs > 0; i++) {
+		if (i == cpu)
+			continue;
+
+		while (paca[i].kexec_state < KEXEC_STATE_REAL_MODE) {
+			barrier();
+			if (!cpu_possible(i)) {
+				break;
+			}
+			if (!cpu_online(i)) {
+				break;
+			}
+			msecs--;
+			mdelay(1);
+		}
+	}
+	mb();
+}
+
 /*
  * This function will be called by secondary cpus or by kexec cpu
  * if soft-reset is activated to stop some CPUs.
@@ -419,6 +446,7 @@ void default_machine_crash_shutdown(stru
 	crash_kexec_prepare_cpus(crashing_cpu);
 	cpu_set(crashing_cpu, cpus_in_crash);
 	crash_kexec_stop_spus();
+	crash_kexec_wait_realmode(crashing_cpu);
 	if (ppc_md.kexec_cpu_down)
 		ppc_md.kexec_cpu_down(1, 0);
 }
