Return-Path: <paulus@ozlabs.org>
Date: Thu, 26 May 2011 19:34:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Avoid extra indirect function call in sending IPIs
Message-ID: <20110526093412.GA3400@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On many platforms (including pSeries), smp_ops->message_pass is always
smp_muxed_ipi_message_pass.  This changes arch/powerpc/kernel/smp.c so
that if smp_ops->message_pass is NULL, it calls smp_muxed_ipi_message_pass
directly.

This means that a platform doesn't need to set both .message_pass and
.cause_ipi, only one of them.  It is a slight performance improvement
in that it gets rid of an indirect function call at the expense of a
predictable conditional branch.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/smp.c             |   16 ++++++++++++----
 arch/powerpc/platforms/85xx/smp.c     |    2 +-
 arch/powerpc/platforms/iseries/smp.c  |    2 +-
 arch/powerpc/platforms/powermac/smp.c |    2 +-
 arch/powerpc/platforms/pseries/smp.c  |    2 +-
 arch/powerpc/platforms/wsp/smp.c      |    2 +-
 6 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 4a6f2ec..b50c577 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -238,15 +238,23 @@ irqreturn_t smp_ipi_demux(void)
 }
 #endif /* CONFIG_PPC_SMP_MUXED_IPI */
 
+static inline void do_message_pass(int cpu, int msg)
+{
+	if (smp_ops->message_pass)
+		smp_ops->message_pass(cpu, msg);
+	else
+		smp_muxed_ipi_message_pass(cpu, msg);
+}
+
 void smp_send_reschedule(int cpu)
 {
 	if (likely(smp_ops))
-		smp_ops->message_pass(cpu, PPC_MSG_RESCHEDULE);
+		do_message_pass(cpu, PPC_MSG_RESCHEDULE);
 }
 
 void arch_send_call_function_single_ipi(int cpu)
 {
-	smp_ops->message_pass(cpu, PPC_MSG_CALL_FUNC_SINGLE);
+	do_message_pass(cpu, PPC_MSG_CALL_FUNC_SINGLE);
 }
 
 void arch_send_call_function_ipi_mask(const struct cpumask *mask)
@@ -254,7 +262,7 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 	unsigned int cpu;
 
 	for_each_cpu(cpu, mask)
-		smp_ops->message_pass(cpu, PPC_MSG_CALL_FUNCTION);
+		do_message_pass(cpu, PPC_MSG_CALL_FUNCTION);
 }
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
@@ -268,7 +276,7 @@ void smp_send_debugger_break(void)
 
 	for_each_online_cpu(cpu)
 		if (cpu != me)
-			smp_ops->message_pass(cpu, PPC_MSG_DEBUGGER_BREAK);
+			do_message_pass(cpu, PPC_MSG_DEBUGGER_BREAK);
 }
 #endif
 
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index d6a93a1..8eef8d2 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -236,7 +236,7 @@ void __init mpc85xx_smp_init(void)
 	}
 
 	if (cpu_has_feature(CPU_FTR_DBELL)) {
-		smp_85xx_ops.message_pass = smp_muxed_ipi_message_pass;
+		/* .message_pass defaults to smp_muxed_ipi_message_pass */
 		smp_85xx_ops.cause_ipi = doorbell_cause_ipi;
 	}
 
diff --git a/arch/powerpc/platforms/iseries/smp.c b/arch/powerpc/platforms/iseries/smp.c
index e3265ad..2df48c2 100644
--- a/arch/powerpc/platforms/iseries/smp.c
+++ b/arch/powerpc/platforms/iseries/smp.c
@@ -75,7 +75,7 @@ static void __devinit smp_iSeries_setup_cpu(int nr)
 }
 
 static struct smp_ops_t iSeries_smp_ops = {
-	.message_pass = smp_muxed_ipi_message_pass,
+	.message_pass = NULL,	/* Use smp_muxed_ipi_message_pass */
 	.cause_ipi    = smp_iSeries_cause_ipi,
 	.probe        = smp_iSeries_probe,
 	.kick_cpu     = smp_iSeries_kick_cpu,
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index db092d7..d15fca3 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -447,7 +447,7 @@ void __init smp_psurge_give_timebase(void)
 
 /* PowerSurge-style Macs */
 struct smp_ops_t psurge_smp_ops = {
-	.message_pass	= smp_muxed_ipi_message_pass,
+	.message_pass	= NULL,	/* Use smp_muxed_ipi_message_pass */
 	.cause_ipi	= smp_psurge_cause_ipi,
 	.probe		= smp_psurge_probe,
 	.kick_cpu	= smp_psurge_kick_cpu,
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index fbffd7e..84dafd3 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -207,7 +207,7 @@ static struct smp_ops_t pSeries_mpic_smp_ops = {
 };
 
 static struct smp_ops_t pSeries_xics_smp_ops = {
-	.message_pass	= smp_muxed_ipi_message_pass,
+	.message_pass	= NULL,	/* Use smp_muxed_ipi_message_pass */
 	.cause_ipi	= NULL,	/* Filled at runtime by xics_smp_probe() */
 	.probe		= xics_smp_probe,
 	.kick_cpu	= smp_pSeries_kick_cpu,
diff --git a/arch/powerpc/platforms/wsp/smp.c b/arch/powerpc/platforms/wsp/smp.c
index 9d20fa9..71bd105 100644
--- a/arch/powerpc/platforms/wsp/smp.c
+++ b/arch/powerpc/platforms/wsp/smp.c
@@ -75,7 +75,7 @@ static int __init smp_a2_probe(void)
 }
 
 static struct smp_ops_t a2_smp_ops = {
-	.message_pass	= smp_muxed_ipi_message_pass,
+	.message_pass	= NULL,	/* Use smp_muxed_ipi_message_pass */
 	.cause_ipi	= doorbell_cause_ipi,
 	.probe		= smp_a2_probe,
 	.kick_cpu	= smp_a2_kick_cpu,
-- 
1.7.5.1
