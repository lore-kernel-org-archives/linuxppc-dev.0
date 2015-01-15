Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0117.outbound.protection.outlook.com [157.56.111.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFF151A0DC2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 17:07:46 +1100 (AEDT)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>, <yorksun@freescale.com>, <leoli@freescale.com>
Subject: [PATCH] fsl/smp: add low power boot support to replace spin boot
Date: Thu, 15 Jan 2015 14:05:30 +0800
Message-ID: <1421301930-10035-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

U-boot put non-boot cpus into an low power state(PW10/PW20 or DOZE) when cpu
powered up. To exit low power state kernel will send DOORBELL or MPIC-IPI
signal to all those CPUs.

e500/e500v2 use mpic to send IPI signal.
e500mc and later use doorbell to send IPI signal.

This feature tested on:
POWER UP TEST:
P1022DS(e500v2),96k times.
P4080(e500mc),  110k times.
T1024(e5500),   83k times.
T4240(e6500),   150k times.

CPU HOTPLUG TEST:
P1022DS(e500v2),1.4 million times.
P4080(e500mc),  1.8 million times.
T1024(e5500),   1.3 million times.
T4240(e6500),   1.1 million times.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index 754f93d..8af6a25 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -474,6 +474,15 @@ extern int mpic_cpu_get_priority(void);
 /* Set the current cpu priority for this cpu */
 extern void mpic_cpu_set_priority(int prio);
 
+/* Set cpu priority */
+void mpic_set_cpu_priority(int nr, int prio);
+
+/* Set cpu EOI */
+void mpic_cpu_eoi_write(int cpu);
+
+/* CPU ACK interrupt */
+void mpic_cpu_ack(int cpu);
+
 /* Request IPIs on primary mpic */
 extern void mpic_request_ipis(void);
 
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index d7c1e69..6c54632 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -193,6 +193,30 @@ static int smp_85xx_kick_cpu(int nr)
 	const u64 *cpu_rel_addr;
 	__iomem struct epapr_spin_table *spin_table;
 	struct device_node *np;
+
+	/*
+	 * DOORBELL:
+	 * When kernel kick one of cpus, all cpus will be wakenup. To make
+	 * sure that only the target cpu is effected, other cpus (by checking
+	 * spin_table->addr_l) should go back to low power state.
+	 *
+	 * U-boot has renumber the cpu PIR Why we need to set all of PIR to
+	 * the same value?
+	 * A: Before kernel kicking cpu, the doorbell message was not configured
+	 * for target cpu(cpu_messages->data). If we try to send a
+	 * non-configured message to target cpu, it cannot correctly receive
+	 * doorbell interrput. So SET ALL OF CPU'S PIR to the same value to
+	 * let all cpus catch the interrupt.
+	 *
+	 * Why set PIR to zero?
+	 * A: U-boot cannot know how many cpus will be kicked up(Kernel allow us
+	 * to configure NR_CPUS) and IPI is a per_cpu variable, u-boot cannot
+	 * set a appropriate PIR for every cpu, but the boot cpu(CPU0) always be
+	 * there. U-boot set PIR to zero as a default PIR ID for each CPU, so
+	 * initialize the kick_cpus to 0.
+	 */
+	u32 kick_cpus = 0;
+
 	int hw_cpu = get_hard_smp_processor_id(nr);
 	int ioremappable;
 	int ret = 0;
@@ -251,8 +275,7 @@ static int smp_85xx_kick_cpu(int nr)
 		spin_table = phys_to_virt(*cpu_rel_addr);
 
 	local_irq_save(flags);
-#ifdef CONFIG_PPC32
-#ifdef CONFIG_HOTPLUG_CPU
+#if defined(CONFIG_PPC32) && defined(CONFIG_HOTPLUG_CPU)
 	/* Corresponding to generic_set_cpu_dead() */
 	generic_set_cpu_up(nr);
 
@@ -292,11 +315,58 @@ static int smp_85xx_kick_cpu(int nr)
 		__secondary_hold_acknowledge = -1;
 	}
 #endif
+
 	flush_spin_table(spin_table);
-	out_be32(&spin_table->pir, hw_cpu);
+	/*
+	 * U-boot will wait kernel send eoi to MPIC, after EOI has send
+	 * kernel will set PIR for uboot, let uboot know EOI has send.
+	 */
+	out_be32(&spin_table->pir, 0);
+
+#ifdef CONFIG_PPC32
 	out_be32(&spin_table->addr_l, __pa(__early_start));
+#else
+	out_be64((u64 *)(&spin_table->addr_h),
+		 __pa(ppc_function_entry(generic_secondary_smp_init)));
+#endif
 	flush_spin_table(spin_table);
 
+	/*
+	 * e500, e500v2 need to use MPIC to send IPI signal, so we need to
+	 * open IPI firstly.
+	 */
+	if (!cpu_has_feature(CPU_FTR_DBELL)) {
+		mpic_set_cpu_priority(nr, 0);
+		kick_cpus = nr;
+	}
+
+	/* Let cpu exit low power state, and from u-boot jump to kernel */
+	arch_send_call_function_single_ipi(kick_cpus);
+
+	/*
+	 * Let we ACK interrput and Send EOI signal to finish INT server
+	 * U-boot has read EPR to ACK interrput when MPIC work in external
+	 * proxy mode. Without the external proxy facility, we need to read
+	 * MPIC ACK register.
+	 *
+	 * There just ACK interrput, we don't need to get the interrupt vector
+	 * and to handle it. Because there just IPI or DOORBELL interrupt to
+	 * make u-boot exit low power state and jump to kernel.
+	 */
+	mpic_cpu_ack(nr);
+	/* Send EOI to clear ISR bit to remove interrupt from service */
+	mpic_cpu_eoi_write(nr);
+
+	/* After wakeup CPU disable IPI, IPI will be opened in setup_cpu */
+	if (!cpu_has_feature(CPU_FTR_DBELL))
+		mpic_set_cpu_priority(nr, 0xf);
+
+	/* After EOI finish, let we release cpu */
+	flush_spin_table(spin_table);
+	out_be32(&spin_table->pir, hw_cpu);
+	flush_spin_table(spin_table);
+
+#ifdef CONFIG_PPC32
 	/* Wait a bit for the CPU to ack. */
 	if (!spin_event_timeout(__secondary_hold_acknowledge == hw_cpu,
 					10000, 100)) {
@@ -308,12 +378,6 @@ static int smp_85xx_kick_cpu(int nr)
 out:
 #else
 	smp_generic_kick_cpu(nr);
-
-	flush_spin_table(spin_table);
-	out_be32(&spin_table->pir, hw_cpu);
-	out_be64((u64 *)(&spin_table->addr_h),
-		__pa(ppc_function_entry(generic_secondary_smp_init)));
-	flush_spin_table(spin_table);
 #endif
 
 	local_irq_restore(flags);
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index c4648ad..b2ba47e 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -658,6 +658,21 @@ static inline void mpic_eoi(struct mpic *mpic)
 	(void)mpic_cpu_read(MPIC_INFO(CPU_WHOAMI));
 }
 
+void mpic_cpu_eoi_write(int cpu)
+{
+	struct mpic *mpic = mpic_primary;
+
+	_mpic_write(mpic->reg_type, &mpic->cpuregs[cpu], MPIC_INFO(CPU_EOI), 0);
+	_mpic_read(mpic->reg_type, &mpic->cpuregs[cpu], MPIC_INFO(CPU_WHOAMI));
+}
+
+void mpic_cpu_ack(int cpu)
+{
+	struct mpic *mpic = mpic_primary;
+
+	_mpic_read(mpic->reg_type, &mpic->cpuregs[cpu], MPIC_INFO(CPU_INTACK));
+}
+
 /*
  * Linux descriptor level callbacks
  */
@@ -1778,6 +1793,16 @@ void mpic_cpu_set_priority(int prio)
 	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), prio);
 }
 
+void mpic_set_cpu_priority(int nr, int prio)
+{
+	struct mpic *mpic = mpic_primary;
+	int hw_cpu = get_hard_smp_processor_id(nr);
+
+	prio &= MPIC_CPU_TASKPRI_MASK;
+	_mpic_write(mpic->reg_type, &mpic->cpuregs[hw_cpu],
+		    MPIC_INFO(CPU_CURRENT_TASK_PRI), prio);
+}
+
 void mpic_teardown_this_cpu(int secondary)
 {
 	struct mpic *mpic = mpic_primary;
-- 
2.1.0.27.g96db324
