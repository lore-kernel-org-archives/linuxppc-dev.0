Return-Path: <anton@ozlabs.org>
Date: Tue, 12 Jan 2010 21:58:05 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Reduce footprint of xics_ipi_struct
Message-ID: <20100112105805.GJ12666@kryten>
References: <20100112105642.GI12666@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100112105642.GI12666@kryten>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Right now we allocate a cacheline sized NR_CPUS array for xics IPI
communication. Since irq_stat is now PowerPC specific and using
DECLARE_PER_CPU_SHARED_ALIGNED (which should mean remote writes to
this should not conflict with other per cpu data), we can put it in there.

On a kernel with NR_CPUS=1024, this saves quite a lot of memory:

   text    data     bss      dec         hex    filename
8767779 2944260 1505724 13217763         c9afe3 vmlinux.irq_cpustat
8767555 2813444 1505724 13086723         c7b003 vmlinux.xics

A saving of around 128kB.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/include/asm/hardirq.h
===================================================================
--- linux-cpumask.orig/arch/powerpc/include/asm/hardirq.h	2010-01-12 12:36:47.174226189 +1100
+++ linux-cpumask/arch/powerpc/include/asm/hardirq.h	2010-01-12 12:36:47.432976459 +1100
@@ -6,6 +6,9 @@
 
 typedef struct {
 	unsigned int __softirq_pending;
+#if defined(CONFIG_XICS) && defined(CONFIG_SMP)
+	unsigned long xics_ipi;
+#endif
 } ____cacheline_aligned irq_cpustat_t;
 
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
Index: linux-cpumask/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/platforms/pseries/xics.c	2010-01-12 12:36:46.905477650 +1100
+++ linux-cpumask/arch/powerpc/platforms/pseries/xics.c	2010-01-12 12:40:54.782975198 +1100
@@ -514,15 +514,12 @@ static void __init xics_init_host(void)
 /*
  * XICS only has a single IPI, so encode the messages per CPU
  */
-struct xics_ipi_struct {
-        unsigned long value;
-	} ____cacheline_aligned;
-
-static struct xics_ipi_struct xics_ipi_message[NR_CPUS] __cacheline_aligned;
 
 static inline void smp_xics_do_message(int cpu, int msg)
 {
-	set_bit(msg, &xics_ipi_message[cpu].value);
+	unsigned long *tgt = &(per_cpu(irq_stat, cpu).xics_ipi);
+
+	set_bit(msg, tgt);
 	mb();
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		lpar_qirr_info(cpu, IPI_PRIORITY);
@@ -548,25 +545,23 @@ void smp_xics_message_pass(int target, i
 
 static irqreturn_t xics_ipi_dispatch(int cpu)
 {
+	unsigned long *tgt = &(per_cpu(irq_stat, cpu).xics_ipi);
+
 	WARN_ON(cpu_is_offline(cpu));
 
 	mb();	/* order mmio clearing qirr */
-	while (xics_ipi_message[cpu].value) {
-		if (test_and_clear_bit(PPC_MSG_CALL_FUNCTION,
-				       &xics_ipi_message[cpu].value)) {
+	while (*tgt) {
+		if (test_and_clear_bit(PPC_MSG_CALL_FUNCTION, tgt)) {
 			smp_message_recv(PPC_MSG_CALL_FUNCTION);
 		}
-		if (test_and_clear_bit(PPC_MSG_RESCHEDULE,
-				       &xics_ipi_message[cpu].value)) {
+		if (test_and_clear_bit(PPC_MSG_RESCHEDULE, tgt)) {
 			smp_message_recv(PPC_MSG_RESCHEDULE);
 		}
-		if (test_and_clear_bit(PPC_MSG_CALL_FUNC_SINGLE,
-				       &xics_ipi_message[cpu].value)) {
+		if (test_and_clear_bit(PPC_MSG_CALL_FUNC_SINGLE, tgt)) {
 			smp_message_recv(PPC_MSG_CALL_FUNC_SINGLE);
 		}
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
-		if (test_and_clear_bit(PPC_MSG_DEBUGGER_BREAK,
-				       &xics_ipi_message[cpu].value)) {
+		if (test_and_clear_bit(PPC_MSG_DEBUGGER_BREAK, tgt)) {
 			smp_message_recv(PPC_MSG_DEBUGGER_BREAK);
 		}
 #endif
