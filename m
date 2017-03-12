Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vh6zP0v3ZzDqYK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 04:13:53 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id j5so16490829pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Mar 2017 10:13:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/64s: use global doorbell on POWER9 in HV mode
Date: Mon, 13 Mar 2017 03:13:27 +1000
Message-Id: <20170312171327.21088-3-npiggin@gmail.com>
In-Reply-To: <20170312171327.21088-1-npiggin@gmail.com>
References: <20170312171327.21088-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Callers of global_doorbell and core_doorbell must now be aware of their
capabilities and which addressing mode their msgsnd instruction uses,
and use the correct one.
---
 arch/powerpc/include/asm/dbell.h     | 41 ++++++++++++++++++++++++++----------
 arch/powerpc/include/asm/smp.h       |  1 +
 arch/powerpc/kernel/dbell.c          | 11 +++++-----
 arch/powerpc/kernel/smp.c            | 13 +++++++++---
 arch/powerpc/platforms/powernv/smp.c | 18 ++++++++++++++--
 arch/powerpc/platforms/pseries/smp.c |  8 ++++++-
 6 files changed, 69 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index 78b8ba575ec2..0ce54014632b 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -38,10 +38,24 @@ enum ppc_dbell {
 
 static inline void _ppc_msgsnd(u32 msg)
 {
-	if (cpu_has_feature(CPU_FTR_HVMODE))
-		__asm__ __volatile__ (PPC_MSGSND(%0) : : "r" (msg));
-	else
-		__asm__ __volatile__ (PPC_MSGSNDP(%0) : : "r" (msg));
+	__asm__ __volatile__ (ASM_FTR_IFSET(PPC_MSGSND(%1), PPC_MSGSNDP(%1), %0)
+				: : "i" (CPU_FTR_HVMODE), "r" (msg));
+}
+
+/* sync before sending message */
+static inline void ppc_msgsnd_sync(void)
+{
+	/* Could use lwsync for msgsndp? (does not order non-cacheable) */
+	__asm__ __volatile__ ("sync" : : : "memory");
+}
+
+/* sync after taking message interrupt */
+static inline void ppc_msgsync(void)
+{
+	/* sync is not required when taking messages from the same core */
+	__asm__ __volatile__ (ASM_FTR_IFSET(PPC_MSGSYNC, "", %0)
+				: : "i" (CPU_FTR_ARCH_300|CPU_FTR_HVMODE)
+				: "memory");
 }
 
 #else /* CONFIG_PPC_BOOK3S */
@@ -55,15 +69,20 @@ static inline void _ppc_msgsnd(u32 msg)
 
 #endif /* CONFIG_PPC_BOOK3S */
 
+/*
+ * Doorbells must only be used if CPU_FTR_DBELL is available.
+ *
+ * Global doorbell IPIs must only be used on CPUs that address the msgsnd
+ * (or msgsndp if in HVMODE) with PIR (hard_smp_processor_id)
+ */
 extern void global_doorbell_cause_ipi(int cpu);
+
+/*
+ * Core doorbell IPIs must only be used on CPUs that address the msgsnd
+ * (or msgsndp if in HVMODE) with TIR (cpu_thread_in_core)
+ */
 extern void core_doorbell_cause_ipi(int cpu);
-extern int __try_core_doorbell_cause_ipi(int cpu);
-static inline int try_core_doorbell_cause_ipi(int cpu)
-{
-	if (!cpu_has_feature(CPU_FTR_DBELL))
-		return 0;
-	return __try_core_doorbell_cause_ipi(cpu);
-}
+extern int try_core_doorbell_cause_ipi(int cpu);
 extern void doorbell_exception(struct pt_regs *regs);
 
 static inline void ppc_msgsnd(enum ppc_dbell type, u32 flags, u32 tag)
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 0ada12e61fd7..0ee8a6cb1d87 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -128,6 +128,7 @@ extern const char *smp_ipi_name[];
 extern void smp_muxed_ipi_message_pass(int cpu, int msg);
 extern void smp_muxed_ipi_set_message(int cpu, int msg);
 extern irqreturn_t smp_ipi_demux(void);
+extern irqreturn_t smp_ipi_demux_relaxed(void);
 
 void smp_init_pSeries(void);
 void smp_init_cell(void);
diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
index 4df23ba7c3d3..95409bca76b0 100644
--- a/arch/powerpc/kernel/dbell.c
+++ b/arch/powerpc/kernel/dbell.c
@@ -34,18 +34,15 @@ void core_doorbell_cause_ipi(int cpu)
 {
 	u32 tag;
 
-	if (cpu_has_feature(CPU_FTR_ARCH_300) && cpu_has_feature(CPU_FTR_HVMODE))
-		global_doorbell_cause_ipi(cpu);
-
 	tag = cpu_thread_in_core(cpu);
 
 	kvmppc_set_host_ipi(cpu, 1);
 	/* Order previous accesses vs. msgsnd, which is treated as a store */
-	mb();
+	ppc_msgsnd_sync();
 	ppc_msgsnd(PPC_DBELL_MSGTYPE, 0, tag);
 }
 
-int __try_core_doorbell_cause_ipi(int cpu)
+int try_core_doorbell_cause_ipi(int cpu)
 {
 	int this_cpu = get_cpu();
 	int ret = 0;
@@ -66,12 +63,14 @@ void doorbell_exception(struct pt_regs *regs)
 
 	irq_enter();
 
+	ppc_msgsync();
+
 	may_hard_irq_enable();
 
 	kvmppc_set_host_ipi(smp_processor_id(), 0);
 	__this_cpu_inc(irq_stat.doorbell_irqs);
 
-	smp_ipi_demux();
+	smp_ipi_demux_relaxed(); /* already performed the barrier */
 
 	irq_exit();
 	set_irq_regs(old_regs);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index bb882fa1f762..fd2441591b81 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -246,11 +246,18 @@ void smp_muxed_ipi_message_pass(int cpu, int msg)
 
 irqreturn_t smp_ipi_demux(void)
 {
-	struct cpu_messages *info = this_cpu_ptr(&ipi_message);
-	unsigned long all;
-
 	mb();	/* order any irq clear */
 
+	return smp_ipi_demux_relaxed();
+}
+
+/* sync-free variant. Callers should ensure synchronization */
+irqreturn_t smp_ipi_demux_relaxed(void)
+{
+	struct cpu_messages *info;
+	unsigned long all;
+
+	info = this_cpu_ptr(&ipi_message);
 	do {
 		all = xchg(&info->messages, 0);
 #if defined(CONFIG_KVM_XICS) && defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index e796c97914c8..660212d3c2d9 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -254,10 +254,24 @@ static void pnv_cause_ipi(int cpu)
 	icp_ops->cause_ipi(cpu);
 }
 
+static __init void pnv_smp_probe(void)
+{
+	xics_smp_probe();
+
+	if (cpu_has_feature(CPU_FTR_DBELL)) {
+		if (cpu_has_feature(CPU_FTR_ARCH_300))
+			smp_ops->cause_ipi = global_doorbell_cause_ipi;
+		else
+			smp_ops->cause_ipi = pnv_cause_ipi;
+	} else {
+		smp_ops->cause_ipi = icp_ops->cause_ipi;
+	}
+}
+
 static struct smp_ops_t pnv_smp_ops = {
 	.message_pass	= NULL, /* Use smp_muxed_ipi_message_pass */
-	.cause_ipi	= pnv_cause_ipi,
-	.probe		= xics_smp_probe,
+	.cause_ipi	= NULL,	/* Filled at runtime by pnv_smp_probe() */
+	.probe		= pnv_smp_probe,
 	.kick_cpu	= pnv_smp_kick_cpu,
 	.setup_cpu	= pnv_smp_setup_cpu,
 	.cpu_bootable	= pnv_cpu_bootable,
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index a26b3158555e..87b5700b217b 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -190,11 +190,17 @@ static void smp_pseries_cause_ipi(int cpu)
 static __init void pSeries_smp_probe(void)
 {
 	xics_smp_probe();
+
+	if (cpu_has_feature(CPU_FTR_DBELL))
+		smp_ops->cause_ipi = pseries_cause_ipi;
+	else
+		smp_ops->cause_ipi = icp_ops->cause_ipi;
+
 }
 
 static struct smp_ops_t pseries_smp_ops = {
 	.message_pass	= NULL,	/* Use smp_muxed_ipi_message_pass */
-	.cause_ipi	= smp_pseries_cause_ipi,
+	.cause_ipi	= NULL, /* Filled at runtime by pSeries_smp_probe */
 	.probe		= pSeries_smp_probe,
 	.kick_cpu	= smp_pSeries_kick_cpu,
 	.setup_cpu	= smp_setup_cpu,
-- 
2.11.0
