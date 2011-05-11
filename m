Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id A8A3D100870
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:43 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <21fcf71a581c724f968518c87b13ebb6163464d2.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:29:10 -0500
Subject: [PATCH 11/37] powerpc: remove checks for MSG_ALL and MSG_ALL_BUT_SELF
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that smp_ops->smp_message_pass is always called with an (online) cpu
number for the target remove the checks for MSG_ALL and MSG_ALL_BUT_SELF.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
rediffed for ppc-next xics split
---
 arch/powerpc/include/asm/dbell.h       |    2 +-
 arch/powerpc/include/asm/machdep.h     |    2 +-
 arch/powerpc/include/asm/xics.h        |    2 +-
 arch/powerpc/kernel/dbell.c            |   29 +++++------------------------
 arch/powerpc/platforms/cell/beat_smp.c |   18 +-----------------
 arch/powerpc/platforms/cell/smp.c      |   18 +-----------------
 arch/powerpc/platforms/iseries/smp.c   |   18 +-----------------
 arch/powerpc/platforms/powermac/smp.c  |   17 +++--------------
 arch/powerpc/platforms/ps3/smp.c       |   22 +++-------------------
 arch/powerpc/sysdev/mpic.c             |   20 ++------------------
 arch/powerpc/sysdev/xics/icp-hv.c      |   18 +-----------------
 arch/powerpc/sysdev/xics/icp-native.c  |   18 +-----------------
 12 files changed, 21 insertions(+), 163 deletions(-)

diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index 0893ab9..3269eb4 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -27,7 +27,7 @@ enum ppc_dbell {
 	PPC_G_DBELL_MC = 4,	/* guest mcheck doorbell */
 };
 
-extern void doorbell_message_pass(int target, int msg);
+extern void doorbell_message_pass(int cpu, int msg);
 extern void doorbell_exception(struct pt_regs *regs);
 extern void doorbell_check_self(void);
 extern void doorbell_setup_this_cpu(void);
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index c6345ac..b0802a5 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -31,7 +31,7 @@ struct kimage;
 
 #ifdef CONFIG_SMP
 struct smp_ops_t {
-	void  (*message_pass)(int target, int msg);
+	void  (*message_pass)(int cpu, int msg);
 	int   (*probe)(void);
 	int   (*kick_cpu)(int nr);
 	void  (*setup_cpu)(int nr);
diff --git a/arch/powerpc/include/asm/xics.h b/arch/powerpc/include/asm/xics.h
index 6c06306..1750c8d 100644
--- a/arch/powerpc/include/asm/xics.h
+++ b/arch/powerpc/include/asm/xics.h
@@ -40,7 +40,7 @@ struct icp_ops {
 	void (*teardown_cpu)(void);
 	void (*flush_ipi)(void);
 #ifdef CONFIG_SMP
-	void (*message_pass)(int target, int msg);
+	void (*message_pass)(int cpu, int msg);
 	irq_handler_t ipi_action;
 #endif
 };
diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
index 3307a52..e49b24c 100644
--- a/arch/powerpc/kernel/dbell.c
+++ b/arch/powerpc/kernel/dbell.c
@@ -34,32 +34,13 @@ void doorbell_setup_this_cpu(void)
 	info->tag = mfspr(SPRN_PIR) & 0x3fff;
 }
 
-void doorbell_message_pass(int target, int msg)
+void doorbell_message_pass(int cpu, int msg)
 {
 	struct doorbell_cpu_info *info;
-	int i;
-
-	if (target < NR_CPUS) {
-		info = &per_cpu(doorbell_cpu_info, target);
-		set_bit(msg, &info->messages);
-		ppc_msgsnd(PPC_DBELL, 0, info->tag);
-	}
-	else if (target == MSG_ALL_BUT_SELF) {
-		for_each_online_cpu(i) {
-			if (i == smp_processor_id())
-				continue;
-			info = &per_cpu(doorbell_cpu_info, i);
-			set_bit(msg, &info->messages);
-			ppc_msgsnd(PPC_DBELL, 0, info->tag);
-		}
-	}
-	else { /* target == MSG_ALL */
-		for_each_online_cpu(i) {
-			info = &per_cpu(doorbell_cpu_info, i);
-			set_bit(msg, &info->messages);
-		}
-		ppc_msgsnd(PPC_DBELL, PPC_DBELL_MSG_BRDCAST, 0);
-	}
+
+	info = &per_cpu(doorbell_cpu_info, cpu);
+	set_bit(msg, &info->messages);
+	ppc_msgsnd(PPC_DBELL, 0, info->tag);
 }
 
 void doorbell_exception(struct pt_regs *regs)
diff --git a/arch/powerpc/platforms/cell/beat_smp.c b/arch/powerpc/platforms/cell/beat_smp.c
index 3e86acb..23bbe6e 100644
--- a/arch/powerpc/platforms/cell/beat_smp.c
+++ b/arch/powerpc/platforms/cell/beat_smp.c
@@ -67,22 +67,6 @@ static inline int __devinit smp_startup_cpu(unsigned int lcpu)
 	return 0;
 }
 
-static void smp_beatic_message_pass(int target, int msg)
-{
-	unsigned int i;
-
-	if (target < NR_CPUS) {
-		beatic_cause_IPI(target, msg);
-	} else {
-		for_each_online_cpu(i) {
-			if (target == MSG_ALL_BUT_SELF
-			    && i == smp_processor_id())
-				continue;
-			beatic_cause_IPI(i, msg);
-		}
-	}
-}
-
 static int __init smp_beatic_probe(void)
 {
 	return cpumask_weight(cpu_possible_mask);
@@ -105,7 +89,7 @@ static int smp_celleb_cpu_bootable(unsigned int nr)
 	return 1;
 }
 static struct smp_ops_t bpa_beatic_smp_ops = {
-	.message_pass	= smp_beatic_message_pass,
+	.message_pass	= beatic_cause_IPI,
 	.probe		= smp_beatic_probe,
 	.kick_cpu	= smp_celleb_kick_cpu,
 	.setup_cpu	= smp_beatic_setup_cpu,
diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
index a2161b9..d176e61 100644
--- a/arch/powerpc/platforms/cell/smp.c
+++ b/arch/powerpc/platforms/cell/smp.c
@@ -103,22 +103,6 @@ static inline int __devinit smp_startup_cpu(unsigned int lcpu)
 	return 1;
 }
 
-static void smp_iic_message_pass(int target, int msg)
-{
-	unsigned int i;
-
-	if (target < NR_CPUS) {
-		iic_cause_IPI(target, msg);
-	} else {
-		for_each_online_cpu(i) {
-			if (target == MSG_ALL_BUT_SELF
-			    && i == smp_processor_id())
-				continue;
-			iic_cause_IPI(i, msg);
-		}
-	}
-}
-
 static int __init smp_iic_probe(void)
 {
 	iic_request_IPIs();
@@ -168,7 +152,7 @@ static int smp_cell_cpu_bootable(unsigned int nr)
 	return 1;
 }
 static struct smp_ops_t bpa_iic_smp_ops = {
-	.message_pass	= smp_iic_message_pass,
+	.message_pass	= iic_cause_IPI,
 	.probe		= smp_iic_probe,
 	.kick_cpu	= smp_cell_kick_cpu,
 	.setup_cpu	= smp_cell_setup_cpu,
diff --git a/arch/powerpc/platforms/iseries/smp.c b/arch/powerpc/platforms/iseries/smp.c
index 02a677a..dcdbc5d 100644
--- a/arch/powerpc/platforms/iseries/smp.c
+++ b/arch/powerpc/platforms/iseries/smp.c
@@ -59,28 +59,12 @@ void iSeries_smp_message_recv(void)
 			smp_message_recv(msg);
 }
 
-static inline void smp_iSeries_do_message(int cpu, int msg)
+static void smp_iSeries_message_pass(int cpu, int msg)
 {
 	set_bit(msg, &iSeries_smp_message[cpu]);
 	HvCall_sendIPI(&(paca[cpu]));
 }
 
-static void smp_iSeries_message_pass(int target, int msg)
-{
-	int i;
-
-	if (target < NR_CPUS)
-		smp_iSeries_do_message(target, msg);
-	else {
-		for_each_online_cpu(i) {
-			if ((target == MSG_ALL_BUT_SELF) &&
-					(i == smp_processor_id()))
-				continue;
-			smp_iSeries_do_message(i, msg);
-		}
-	}
-}
-
 static int smp_iSeries_probe(void)
 {
 	return cpumask_weight(cpu_possible_mask);
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 621d4b7..c49e719 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -186,21 +186,10 @@ irqreturn_t psurge_primary_intr(int irq, void *d)
 	return IRQ_HANDLED;
 }
 
-static void smp_psurge_message_pass(int target, int msg)
+static void smp_psurge_message_pass(int cpu, int msg)
 {
-	int i;
-
-	if (num_online_cpus() < 2)
-		return;
-
-	for_each_online_cpu(i) {
-		if (target == MSG_ALL
-		    || (target == MSG_ALL_BUT_SELF && i != smp_processor_id())
-		    || target == i) {
-			set_bit(msg, &psurge_smp_message[i]);
-			psurge_set_ipi(i);
-		}
-	}
+	set_bit(msg, &psurge_smp_message[cpu]);
+	psurge_set_ipi(cpu);
 }
 
 /*
diff --git a/arch/powerpc/platforms/ps3/smp.c b/arch/powerpc/platforms/ps3/smp.c
index 51ffde4..4c44794 100644
--- a/arch/powerpc/platforms/ps3/smp.c
+++ b/arch/powerpc/platforms/ps3/smp.c
@@ -39,7 +39,7 @@
 #define MSG_COUNT 4
 static DEFINE_PER_CPU(unsigned int [MSG_COUNT], ps3_ipi_virqs);
 
-static void do_message_pass(int target, int msg)
+static void ps3_smp_message_pass(int cpu, int msg)
 {
 	int result;
 	unsigned int virq;
@@ -49,28 +49,12 @@ static void do_message_pass(int target, int msg)
 		return;
 	}
 
-	virq = per_cpu(ps3_ipi_virqs, target)[msg];
+	virq = per_cpu(ps3_ipi_virqs, cpu)[msg];
 	result = ps3_send_event_locally(virq);
 
 	if (result)
 		DBG("%s:%d: ps3_send_event_locally(%d, %d) failed"
-			" (%d)\n", __func__, __LINE__, target, msg, result);
-}
-
-static void ps3_smp_message_pass(int target, int msg)
-{
-	int cpu;
-
-	if (target < NR_CPUS)
-		do_message_pass(target, msg);
-	else if (target == MSG_ALL_BUT_SELF) {
-		for_each_online_cpu(cpu)
-			if (cpu != smp_processor_id())
-				do_message_pass(cpu, msg);
-	} else {
-		for_each_online_cpu(cpu)
-			do_message_pass(cpu, msg);
-	}
+			" (%d)\n", __func__, __LINE__, cpu, msg, result);
 }
 
 static int ps3_smp_probe(void)
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 116695b..68ea50c 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1628,31 +1628,15 @@ static void mpic_send_ipi(unsigned int ipi_no, const struct cpumask *cpu_mask)
 		       mpic_physmask(cpumask_bits(cpu_mask)[0]));
 }
 
-void smp_mpic_message_pass(int target, int msg)
+void smp_mpic_message_pass(int cpu, int msg)
 {
-	cpumask_var_t tmp;
-
 	/* make sure we're sending something that translates to an IPI */
 	if ((unsigned int)msg > 3) {
 		printk("SMP %d: smp_message_pass: unknown msg %d\n",
 		       smp_processor_id(), msg);
 		return;
 	}
-	switch (target) {
-	case MSG_ALL:
-		mpic_send_ipi(msg, cpu_online_mask);
-		break;
-	case MSG_ALL_BUT_SELF:
-		alloc_cpumask_var(&tmp, GFP_NOWAIT);
-		cpumask_andnot(tmp, cpu_online_mask,
-			       cpumask_of(smp_processor_id()));
-		mpic_send_ipi(msg, tmp);
-		free_cpumask_var(tmp);
-		break;
-	default:
-		mpic_send_ipi(msg, cpumask_of(target));
-		break;
-	}
+	mpic_send_ipi(msg, cpumask_of(cpu));
 }
 
 int __init smp_mpic_probe(void)
diff --git a/arch/powerpc/sysdev/xics/icp-hv.c b/arch/powerpc/sysdev/xics/icp-hv.c
index 76e8724..234764c 100644
--- a/arch/powerpc/sysdev/xics/icp-hv.c
+++ b/arch/powerpc/sysdev/xics/icp-hv.c
@@ -118,7 +118,7 @@ static void icp_hv_set_cpu_priority(unsigned char cppr)
 
 #ifdef CONFIG_SMP
 
-static inline void icp_hv_do_message(int cpu, int msg)
+static void icp_hv_message_pass(int cpu, int msg)
 {
 	unsigned long *tgt = &per_cpu(xics_ipi_message, cpu);
 
@@ -127,22 +127,6 @@ static inline void icp_hv_do_message(int cpu, int msg)
 	icp_hv_set_qirr(cpu, IPI_PRIORITY);
 }
 
-static void icp_hv_message_pass(int target, int msg)
-{
-	unsigned int i;
-
-	if (target < NR_CPUS) {
-		icp_hv_do_message(target, msg);
-	} else {
-		for_each_online_cpu(i) {
-			if (target == MSG_ALL_BUT_SELF
-			    && i == smp_processor_id())
-				continue;
-			icp_hv_do_message(i, msg);
-		}
-	}
-}
-
 static irqreturn_t icp_hv_ipi_action(int irq, void *dev_id)
 {
 	int cpu = smp_processor_id();
diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index 3508321..246500e 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -134,7 +134,7 @@ static unsigned int icp_native_get_irq(void)
 
 #ifdef CONFIG_SMP
 
-static inline void icp_native_do_message(int cpu, int msg)
+static void icp_native_message_pass(int cpu, int msg)
 {
 	unsigned long *tgt = &per_cpu(xics_ipi_message, cpu);
 
@@ -143,22 +143,6 @@ static inline void icp_native_do_message(int cpu, int msg)
 	icp_native_set_qirr(cpu, IPI_PRIORITY);
 }
 
-static void icp_native_message_pass(int target, int msg)
-{
-	unsigned int i;
-
-	if (target < NR_CPUS) {
-		icp_native_do_message(target, msg);
-	} else {
-		for_each_online_cpu(i) {
-			if (target == MSG_ALL_BUT_SELF
-			    && i == smp_processor_id())
-				continue;
-			icp_native_do_message(i, msg);
-		}
-	}
-}
-
 static irqreturn_t icp_native_ipi_action(int irq, void *dev_id)
 {
 	int cpu = smp_processor_id();
-- 
1.7.0.4
