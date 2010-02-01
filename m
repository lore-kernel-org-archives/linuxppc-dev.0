Return-Path: <anton@ozlabs.org>
Date: Mon, 1 Feb 2010 17:32:51 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 2/7] powerpc: Reduce footprint of xics_ipi_struct
Message-ID: <20100201063251.GU2996@kryten>
References: <20100201063023.GT2996@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100201063023.GT2996@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Right now we allocate a cacheline sized NR_CPUS array for xics IPI
communication. Use DECLARE_PER_CPU_SHARED_ALIGNED to put it in percpu
data in its own cacheline since it is written to by other cpus.

On a kernel with NR_CPUS=1024, this saves quite a lot of memory:

   text    data     bss      dec         hex    filename
8767779 2944260 1505724 13217763         c9afe3 vmlinux.irq_cpustat
8767555 2813444 1505724 13086723         c7b003 vmlinux.xics

A saving of around 128kB.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/platforms/pseries/xics.c	2010-02-01 17:28:56.980961887 +1100
+++ linux-cpumask/arch/powerpc/platforms/pseries/xics.c	2010-02-01 17:29:00.980963118 +1100
@@ -514,15 +514,13 @@ static void __init xics_init_host(void)
 /*
  * XICS only has a single IPI, so encode the messages per CPU
  */
-struct xics_ipi_struct {
-        unsigned long value;
-	} ____cacheline_aligned;
-
-static struct xics_ipi_struct xics_ipi_message[NR_CPUS] __cacheline_aligned;
+static DEFINE_PER_CPU_SHARED_ALIGNED(unsigned long, xics_ipi_message);
 
 static inline void smp_xics_do_message(int cpu, int msg)
 {
-	set_bit(msg, &xics_ipi_message[cpu].value);
+	unsigned long *tgt = &per_cpu(xics_ipi_message, cpu);
+
+	set_bit(msg, tgt);
 	mb();
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		lpar_qirr_info(cpu, IPI_PRIORITY);
@@ -548,25 +546,23 @@ void smp_xics_message_pass(int target, i
 
 static irqreturn_t xics_ipi_dispatch(int cpu)
 {
+	unsigned long *tgt = &per_cpu(xics_ipi_message, cpu);
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
