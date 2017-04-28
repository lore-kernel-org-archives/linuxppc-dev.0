Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDrdS0LPNzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 21:07:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v2] powerpc/xmon: Wait for secondaries before IPI'ing on
 system reset
Date: Fri, 28 Apr 2017 21:07:49 +1000
Message-Id: <1493377669-7658-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

An externally triggered system reset (e.g., via QEMU nmi command, or pseries
reset button) can cause system reset interrupts on all CPUs. In case this causes
xmon to be entered, it is undesirable for the primary (first) CPU into xmon to
trigger an NMI IPI to others, because this may cause a nested system reset
interrupt.

So spin for a time waiting for secondaries to join xmon before performing the
NMI IPI, similarly to what the crash dump code does.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[mpe: Only do it when we come in from system reset, not via sysrq etc.]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

v2: Only wait before sending the IPI if we came from a system reset. Otherwise
    any entry into xmon, from eg. sysrq, will pause before entering which is
    undesirable.

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 682506821bba..5c184b059a3d 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -430,6 +430,21 @@ static inline int unrecoverable_excp(struct pt_regs *regs)
 #endif
 }
 
+static bool wait_for_other_cpus(int ncpus)
+{
+	unsigned long timeout;
+
+	/* We wait for 2s, which is a metric "little while" */
+	for (timeout = 20000; timeout != 0; --timeout) {
+		if (cpumask_weight(&cpus_in_xmon) >= ncpus)
+			return true;
+		udelay(100);
+		barrier();
+	}
+
+	return false;
+}
+
 static int xmon_core(struct pt_regs *regs, int fromipi)
 {
 	int cmd = 0;
@@ -440,7 +455,6 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 #ifdef CONFIG_SMP
 	int cpu;
 	int secondary;
-	unsigned long timeout;
 #endif
 
 	local_irq_save(flags);
@@ -527,13 +541,17 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 		xmon_owner = cpu;
 		mb();
 		if (ncpus > 1) {
-			smp_send_debugger_break();
-			/* wait for other cpus to come in */
-			for (timeout = 100000000; timeout != 0; --timeout) {
-				if (cpumask_weight(&cpus_in_xmon) >= ncpus)
-					break;
-				barrier();
-			}
+			/*
+			 * A system reset (trap == 0x100) can be triggered on
+			 * all CPUs, so when we come in via 0x100 try waiting
+			 * for the other CPUs to come in before we send the
+			 * debugger break (IPI). This is similar to
+			 * crash_kexec_secondary().
+			 */
+			if (TRAP(regs) != 0x100 || !wait_for_other_cpus(ncpus))
+				smp_send_debugger_break();
+
+			wait_for_other_cpus(ncpus);
 		}
 		remove_bpts();
 		disable_surveillance();
-- 
2.7.4
