Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id DDBB2100A6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:43 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <59f1001aabd832db60d51b27076de97c5d36574d.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:29:06 -0500
Subject: [PATCH 10/37] powerpc: remove call sites of MSG_ALL_BUT_SELF
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The only user of MSG_ALL_BUT_SELF in the whole kernel tree is powerpc,
and it only uses it to start the debugger. Both debuggers always call
smp_send_debugger_break with MSG_ALL_BUT_SELF, and only mpic can do
anything more optimal than a loop over all online cpus, but all message
passing implementations have to code for this special delivery target.

Convert smp_send_debugger_break to take void and loop calling the smp_ops
message_pass function for each of the other cpus in the online cpumask.

Use raw_smp_processor_id() because we are either entering the debugger
or trying to start kdump and the additional warning it not useful were
it to trigger.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
 arch/powerpc/include/asm/smp.h |    2 +-
 arch/powerpc/kernel/kgdb.c     |    2 +-
 arch/powerpc/kernel/smp.c      |   19 +++++++++++++------
 arch/powerpc/xmon/xmon.c       |    2 +-
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 5087349..91472c5 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -35,7 +35,7 @@ extern void cpu_die(void);
 
 #ifdef CONFIG_SMP
 
-extern void smp_send_debugger_break(int cpu);
+extern void smp_send_debugger_break(void);
 extern void smp_message_recv(int);
 extern void start_secondary_resume(void);
 
diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 42850ee..bd9d35f 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -109,7 +109,7 @@ static int kgdb_call_nmi_hook(struct pt_regs *regs)
 #ifdef CONFIG_SMP
 void kgdb_roundup_cpus(unsigned long flags)
 {
-	smp_send_debugger_break(MSG_ALL_BUT_SELF);
+	smp_send_debugger_break();
 }
 #endif
 
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 87517ab..b744114 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -218,11 +218,18 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 		smp_ops->message_pass(cpu, PPC_MSG_CALL_FUNCTION);
 }
 
-#ifdef CONFIG_DEBUGGER
-void smp_send_debugger_break(int cpu)
+#if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
+void smp_send_debugger_break(void)
 {
-	if (likely(smp_ops))
-		smp_ops->message_pass(cpu, PPC_MSG_DEBUGGER_BREAK);
+	int cpu;
+	int me = raw_smp_processor_id();
+
+	if (unlikely(!smp_ops))
+		return;
+
+	for_each_online_cpu(cpu)
+		if (cpu != me)
+			smp_ops->message_pass(cpu, PPC_MSG_DEBUGGER_BREAK);
 }
 #endif
 
@@ -230,9 +237,9 @@ void smp_send_debugger_break(int cpu)
 void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
 {
 	crash_ipi_function_ptr = crash_ipi_callback;
-	if (crash_ipi_callback && smp_ops) {
+	if (crash_ipi_callback) {
 		mb();
-		smp_ops->message_pass(MSG_ALL_BUT_SELF, PPC_MSG_DEBUGGER_BREAK);
+		smp_send_debugger_break();
 	}
 }
 #endif
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 91309c5..42541bb 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -437,7 +437,7 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 		xmon_owner = cpu;
 		mb();
 		if (ncpus > 1) {
-			smp_send_debugger_break(MSG_ALL_BUT_SELF);
+			smp_send_debugger_break();
 			/* wait for other cpus to come in */
 			for (timeout = 100000000; timeout != 0; --timeout) {
 				if (cpumask_weight(&cpus_in_xmon) >= ncpus)
-- 
1.7.0.4
