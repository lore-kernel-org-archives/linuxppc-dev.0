Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 29 Apr 2010 09:39:41 +1000
Subject: [PATCH 2/2] powerpc: only call start-cpu when a CPU is stopped
Message-Id: <20100428233941.3C4E9CBAF6@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, ankita@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we always call start-cpu irrespective of if the CPU is
stopped or not. Unfortunatley on POWER7, firmware seems to not like
start-cpu being called when a cpu already been started.  This was not
the case on POWER6 and earlier.

This patch checks to see if the CPU is stopped or not via an
query-cpu-stopped-state call, and only calls start-cpu on CPUs which
are stopped.

This fixes a bug with kexec on POWER7 on PHYP where only the primary
thread would make it to the second kernel.

Reported-by: Ankita Garg <ankita@linux.vnet.ibm.com>
Cc: <stable@kernel.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/platforms/pseries/smp.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6-ozlabs/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/platforms/pseries/smp.c
+++ linux-2.6-ozlabs/arch/powerpc/platforms/pseries/smp.c
@@ -103,6 +103,12 @@ static inline int __devinit smp_startup_
 		return 1;
 
 	pcpu = get_hard_smp_processor_id(lcpu);
+
+	/* Check to see if the CPU out of FW already for kexec */
+	if (smp_query_cpu_stopped(pcpu) == QCSS_NOT_STOPPED){
+		cpu_set(lcpu, of_spin_map);
+		return 1;
+	}
 
 	/* Fixup atomic count: it exited inside IRQ handler. */
 	task_thread_info(paca[lcpu].__current)->preempt_count	= 0;
