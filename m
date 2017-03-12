Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vh6zJ2glDzDqY1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 04:13:48 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 67so16502861pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Mar 2017 10:13:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/64s: change the doorbell IPI calling convention
Date: Mon, 13 Mar 2017 03:13:26 +1000
Message-Id: <20170312171327.21088-2-npiggin@gmail.com>
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

Change the doorbell calls to know about their msgsnd addressing, rather
than have them set a per-cpu target data tag at boot that gets sent to
the cause_ipi functions. The data is only used for doorbell IPI functions,
so it's backward to arrange it like this.

Have the platform code understand doorbell IPIs, rather than the interrupt
controller code understand them.
---
 arch/powerpc/include/asm/dbell.h       | 11 ++++++--
 arch/powerpc/include/asm/smp.h         |  3 +--
 arch/powerpc/include/asm/xics.h        |  2 +-
 arch/powerpc/kernel/dbell.c            | 46 +++++++++++++++++++++++-----------
 arch/powerpc/kernel/smp.c              | 14 +++--------
 arch/powerpc/platforms/85xx/smp.c      |  9 +------
 arch/powerpc/platforms/powermac/smp.c  |  2 +-
 arch/powerpc/platforms/powernv/smp.c   | 16 ++++++------
 arch/powerpc/platforms/pseries/smp.c   | 24 ++++--------------
 arch/powerpc/sysdev/xics/icp-hv.c      |  2 +-
 arch/powerpc/sysdev/xics/icp-native.c  | 12 +--------
 arch/powerpc/sysdev/xics/icp-opal.c    |  2 +-
 arch/powerpc/sysdev/xics/xics-common.c |  3 ---
 13 files changed, 64 insertions(+), 82 deletions(-)

diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index b9d3b52e2a2c..78b8ba575ec2 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -55,9 +55,16 @@ static inline void _ppc_msgsnd(u32 msg)
 
 #endif /* CONFIG_PPC_BOOK3S */
 
-extern void doorbell_cause_ipi(int cpu, unsigned long data);
+extern void global_doorbell_cause_ipi(int cpu);
+extern void core_doorbell_cause_ipi(int cpu);
+extern int __try_core_doorbell_cause_ipi(int cpu);
+static inline int try_core_doorbell_cause_ipi(int cpu)
+{
+	if (!cpu_has_feature(CPU_FTR_DBELL))
+		return 0;
+	return __try_core_doorbell_cause_ipi(cpu);
+}
 extern void doorbell_exception(struct pt_regs *regs);
-extern void doorbell_setup_this_cpu(void);
 
 static inline void ppc_msgsnd(enum ppc_dbell type, u32 flags, u32 tag)
 {
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 32db16d2e7ad..0ada12e61fd7 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -40,7 +40,7 @@ extern int cpu_to_chip_id(int cpu);
 struct smp_ops_t {
 	void  (*message_pass)(int cpu, int msg);
 #ifdef CONFIG_PPC_SMP_MUXED_IPI
-	void  (*cause_ipi)(int cpu, unsigned long data);
+	void  (*cause_ipi)(int cpu);
 #endif
 	void  (*probe)(void);
 	int   (*kick_cpu)(int nr);
@@ -125,7 +125,6 @@ extern int smp_request_message_ipi(int virq, int message);
 extern const char *smp_ipi_name[];
 
 /* for irq controllers with only a single ipi */
-extern void smp_muxed_ipi_set_data(int cpu, unsigned long data);
 extern void smp_muxed_ipi_message_pass(int cpu, int msg);
 extern void smp_muxed_ipi_set_message(int cpu, int msg);
 extern irqreturn_t smp_ipi_demux(void);
diff --git a/arch/powerpc/include/asm/xics.h b/arch/powerpc/include/asm/xics.h
index e0b9e576905a..7ce2c3ac2964 100644
--- a/arch/powerpc/include/asm/xics.h
+++ b/arch/powerpc/include/asm/xics.h
@@ -57,7 +57,7 @@ struct icp_ops {
 	void (*teardown_cpu)(void);
 	void (*flush_ipi)(void);
 #ifdef CONFIG_SMP
-	void (*cause_ipi)(int cpu, unsigned long data);
+	void (*cause_ipi)(int cpu);
 	irq_handler_t ipi_action;
 #endif
 };
diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
index b2011a261045..4df23ba7c3d3 100644
--- a/arch/powerpc/kernel/dbell.c
+++ b/arch/powerpc/kernel/dbell.c
@@ -20,28 +20,44 @@
 #include <asm/kvm_ppc.h>
 
 #ifdef CONFIG_SMP
-void doorbell_setup_this_cpu(void)
+void global_doorbell_cause_ipi(int cpu)
 {
-	unsigned long tag;
+	u32 tag = get_hard_smp_processor_id(cpu);
 
-#ifdef CONFIG_PPC_BOOK3S
-	if (cpu_has_feature(CPU_FTR_HVMODE) && cpu_has_feature(CPU_FTR_ARCH_300))
-		tag = mfspr(SPRN_PIR) & 0xfffff;
-	else
-		tag = mfspr(SPRN_TIR) & 0x7f;
-
-#else
-	tag = mfspr(SPRN_PIR) & 0x3fff;
-#endif
-
-	smp_muxed_ipi_set_data(smp_processor_id(), tag);
+	kvmppc_set_host_ipi(cpu, 1);
+	/* Order previous accesses vs. msgsnd, which is treated as a store */
+	ppc_msgsnd_sync();
+	ppc_msgsnd(PPC_DBELL_MSGTYPE, 0, tag);
 }
 
-void doorbell_cause_ipi(int cpu, unsigned long data)
+void core_doorbell_cause_ipi(int cpu)
 {
+	u32 tag;
+
+	if (cpu_has_feature(CPU_FTR_ARCH_300) && cpu_has_feature(CPU_FTR_HVMODE))
+		global_doorbell_cause_ipi(cpu);
+
+	tag = cpu_thread_in_core(cpu);
+
+	kvmppc_set_host_ipi(cpu, 1);
 	/* Order previous accesses vs. msgsnd, which is treated as a store */
 	mb();
-	ppc_msgsnd(PPC_DBELL_MSGTYPE, 0, data);
+	ppc_msgsnd(PPC_DBELL_MSGTYPE, 0, tag);
+}
+
+int __try_core_doorbell_cause_ipi(int cpu)
+{
+	int this_cpu = get_cpu();
+	int ret = 0;
+
+	if (cpumask_test_cpu(cpu, cpu_sibling_mask(this_cpu))) {
+		core_doorbell_cause_ipi(cpu);
+		ret = 1;
+	}
+
+	put_cpu();
+
+	return ret;
 }
 
 void doorbell_exception(struct pt_regs *regs)
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 46f89e66a273..bb882fa1f762 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -39,6 +39,7 @@
 #include <asm/irq.h>
 #include <asm/hw_irq.h>
 #include <asm/kvm_ppc.h>
+#include <asm/dbell.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/prom.h>
@@ -211,17 +212,9 @@ int smp_request_message_ipi(int virq, int msg)
 #ifdef CONFIG_PPC_SMP_MUXED_IPI
 struct cpu_messages {
 	long messages;			/* current messages */
-	unsigned long data;		/* data for cause ipi */
 };
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct cpu_messages, ipi_message);
 
-void smp_muxed_ipi_set_data(int cpu, unsigned long data)
-{
-	struct cpu_messages *info = &per_cpu(ipi_message, cpu);
-
-	info->data = data;
-}
-
 void smp_muxed_ipi_set_message(int cpu, int msg)
 {
 	struct cpu_messages *info = &per_cpu(ipi_message, cpu);
@@ -236,14 +229,13 @@ void smp_muxed_ipi_set_message(int cpu, int msg)
 
 void smp_muxed_ipi_message_pass(int cpu, int msg)
 {
-	struct cpu_messages *info = &per_cpu(ipi_message, cpu);
-
 	smp_muxed_ipi_set_message(cpu, msg);
+
 	/*
 	 * cause_ipi functions are required to include a full barrier
 	 * before doing whatever causes the IPI.
 	 */
-	smp_ops->cause_ipi(cpu, info->data);
+	smp_ops->cause_ipi(cpu);
 }
 
 #ifdef __BIG_ENDIAN__
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 078097a0b09d..5cfc24708021 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -461,16 +461,9 @@ static void mpc85xx_smp_machine_kexec(struct kimage *image)
 }
 #endif /* CONFIG_KEXEC_CORE */
 
-static void smp_85xx_basic_setup(int cpu_nr)
-{
-	if (cpu_has_feature(CPU_FTR_DBELL))
-		doorbell_setup_this_cpu();
-}
-
 static void smp_85xx_setup_cpu(int cpu_nr)
 {
 	mpic_setup_this_cpu();
-	smp_85xx_basic_setup(cpu_nr);
 }
 
 void __init mpc85xx_smp_init(void)
@@ -492,7 +485,7 @@ void __init mpc85xx_smp_init(void)
 		 * smp_muxed_ipi_message_pass
 		 */
 		smp_85xx_ops.message_pass = NULL;
-		smp_85xx_ops.cause_ipi = doorbell_cause_ipi;
+		smp_85xx_ops.cause_ipi = global_doorbell_cause_ipi;
 		smp_85xx_ops.probe = NULL;
 	}
 
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 746ca7321b03..a3207cea360e 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -172,7 +172,7 @@ static irqreturn_t psurge_ipi_intr(int irq, void *d)
 	return IRQ_HANDLED;
 }
 
-static void smp_psurge_cause_ipi(int cpu, unsigned long data)
+static void smp_psurge_cause_ipi(int cpu)
 {
 	psurge_set_ipi(cpu);
 }
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 8b67e1eefb5c..e796c97914c8 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -49,11 +49,6 @@ static void pnv_smp_setup_cpu(int cpu)
 {
 	if (cpu != boot_cpuid)
 		xics_setup_cpu();
-
-#ifdef CONFIG_PPC_DOORBELL
-	if (cpu_has_feature(CPU_FTR_DBELL))
-		doorbell_setup_this_cpu();
-#endif
 }
 
 static int pnv_smp_kick_cpu(int nr)
@@ -252,9 +247,16 @@ static int pnv_cpu_bootable(unsigned int nr)
 	return smp_generic_cpu_bootable(nr);
 }
 
+static void pnv_cause_ipi(int cpu)
+{
+	if (try_core_doorbell_cause_ipi(cpu))
+		return;
+	icp_ops->cause_ipi(cpu);
+}
+
 static struct smp_ops_t pnv_smp_ops = {
-	.message_pass	= smp_muxed_ipi_message_pass,
-	.cause_ipi	= NULL,	/* Filled at runtime by xics_smp_probe() */
+	.message_pass	= NULL, /* Use smp_muxed_ipi_message_pass */
+	.cause_ipi	= pnv_cause_ipi,
 	.probe		= xics_smp_probe,
 	.kick_cpu	= pnv_smp_kick_cpu,
 	.setup_cpu	= pnv_smp_setup_cpu,
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index f6f83aeccaaa..a26b3158555e 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -55,11 +55,6 @@
  */
 static cpumask_var_t of_spin_mask;
 
-/*
- * If we multiplex IPI mechanisms, store the appropriate XICS IPI mechanism here
- */
-static void  (*xics_cause_ipi)(int cpu, unsigned long data);
-
 /* Query where a cpu is now.  Return codes #defined in plpar_wrappers.h */
 int smp_query_cpu_stopped(unsigned int pcpu)
 {
@@ -143,8 +138,6 @@ static void smp_setup_cpu(int cpu)
 {
 	if (cpu != boot_cpuid)
 		xics_setup_cpu();
-	if (cpu_has_feature(CPU_FTR_DBELL))
-		doorbell_setup_this_cpu();
 
 	if (firmware_has_feature(FW_FEATURE_SPLPAR))
 		vpa_init(cpu);
@@ -187,28 +180,21 @@ static int smp_pSeries_kick_cpu(int nr)
 	return 0;
 }
 
-/* Only used on systems that support multiple IPI mechanisms */
-static void pSeries_cause_ipi_mux(int cpu, unsigned long data)
+static void smp_pseries_cause_ipi(int cpu)
 {
-	if (cpumask_test_cpu(cpu, cpu_sibling_mask(smp_processor_id())))
-		doorbell_cause_ipi(cpu, data);
-	else
-		xics_cause_ipi(cpu, data);
+	if (try_core_doorbell_cause_ipi(cpu))
+		return;
+	icp_ops->cause_ipi(cpu);
 }
 
 static __init void pSeries_smp_probe(void)
 {
 	xics_smp_probe();
-
-	if (cpu_has_feature(CPU_FTR_DBELL)) {
-		xics_cause_ipi = smp_ops->cause_ipi;
-		smp_ops->cause_ipi = pSeries_cause_ipi_mux;
-	}
 }
 
 static struct smp_ops_t pseries_smp_ops = {
 	.message_pass	= NULL,	/* Use smp_muxed_ipi_message_pass */
-	.cause_ipi	= NULL,	/* Filled at runtime by pSeries_smp_probe() */
+	.cause_ipi	= smp_pseries_cause_ipi,
 	.probe		= pSeries_smp_probe,
 	.kick_cpu	= smp_pSeries_kick_cpu,
 	.setup_cpu	= smp_setup_cpu,
diff --git a/arch/powerpc/sysdev/xics/icp-hv.c b/arch/powerpc/sysdev/xics/icp-hv.c
index e7fa26c4ff73..bbc839a98c41 100644
--- a/arch/powerpc/sysdev/xics/icp-hv.c
+++ b/arch/powerpc/sysdev/xics/icp-hv.c
@@ -138,7 +138,7 @@ static void icp_hv_set_cpu_priority(unsigned char cppr)
 
 #ifdef CONFIG_SMP
 
-static void icp_hv_cause_ipi(int cpu, unsigned long data)
+static void icp_hv_cause_ipi(int cpu)
 {
 	icp_hv_set_qirr(cpu, IPI_PRIORITY);
 }
diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index 8a6a043e239b..f9e2f8b2e3eb 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -143,19 +143,9 @@ static unsigned int icp_native_get_irq(void)
 
 #ifdef CONFIG_SMP
 
-static void icp_native_cause_ipi(int cpu, unsigned long data)
+static void icp_native_cause_ipi(int cpu)
 {
 	kvmppc_set_host_ipi(cpu, 1);
-#ifdef CONFIG_PPC_DOORBELL
-	if (cpu_has_feature(CPU_FTR_DBELL)) {
-		if (cpumask_test_cpu(cpu, cpu_sibling_mask(get_cpu()))) {
-			doorbell_cause_ipi(cpu, data);
-			put_cpu();
-			return;
-		}
-		put_cpu();
-	}
-#endif
 	icp_native_set_qirr(cpu, IPI_PRIORITY);
 }
 
diff --git a/arch/powerpc/sysdev/xics/icp-opal.c b/arch/powerpc/sysdev/xics/icp-opal.c
index b53f80f0b4d8..c71d2ea42627 100644
--- a/arch/powerpc/sysdev/xics/icp-opal.c
+++ b/arch/powerpc/sysdev/xics/icp-opal.c
@@ -126,7 +126,7 @@ static void icp_opal_eoi(struct irq_data *d)
 
 #ifdef CONFIG_SMP
 
-static void icp_opal_cause_ipi(int cpu, unsigned long data)
+static void icp_opal_cause_ipi(int cpu)
 {
 	int hw_cpu = get_hard_smp_processor_id(cpu);
 
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 23efe4e42172..2eb53c12ee6e 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -143,9 +143,6 @@ static void xics_request_ipi(void)
 
 void __init xics_smp_probe(void)
 {
-	/* Setup cause_ipi callback  based on which ICP is used */
-	smp_ops->cause_ipi = icp_ops->cause_ipi;
-
 	/* Register all the IPIs */
 	xics_request_ipi();
 }
-- 
2.11.0
