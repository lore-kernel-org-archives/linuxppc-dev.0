Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17186.49097.313507.772500@cargo.ozlabs.ibm.com>
Date: Sat, 10 Sep 2005 21:13:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32: support hotplug cpu on powermacs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This allows cpus to be off-lined on 32-bit SMP powermacs.  When a cpu
is off-lined, it is put into sleep mode with interrupts disabled.  It
can be on-lined again by asserting its soft-reset pin, which is
connected to a GPIO pin.

With this I can off-line the second cpu in my dual G4 powermac, which
means that I can then suspend the machine (the suspend/resume code
refuses to suspend if more than one cpu is online, and making it cope
with multiple cpus is surprisingly messy).

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff -urN linux-2.6/arch/ppc/Kconfig test/arch/ppc/Kconfig
--- linux-2.6/arch/ppc/Kconfig	2005-09-10 09:25:11.000000000 +1000
+++ test/arch/ppc/Kconfig	2005-09-10 19:48:24.000000000 +1000
@@ -265,6 +265,15 @@
 
 	  If in doubt, say Y here.
 
+config HOTPLUG_CPU
+	bool "Support for enabling/disabling CPUs"
+	depends on SMP && HOTPLUG && EXPERIMENTAL && PPC_PMAC
+	---help---
+	  Say Y here to be able to disable and re-enable individual
+	  CPUs at runtime on SMP machines.
+
+	  Say N if you are unsure.
+
 source arch/ppc/platforms/4xx/Kconfig
 source arch/ppc/platforms/85xx/Kconfig
 
diff -urN linux-2.6/arch/ppc/kernel/head.S test/arch/ppc/kernel/head.S
--- linux-2.6/arch/ppc/kernel/head.S	2005-09-10 09:25:11.000000000 +1000
+++ test/arch/ppc/kernel/head.S	2005-09-10 19:48:24.000000000 +1000
@@ -1023,23 +1023,21 @@
         andc    r4,r4,r3
         mtspr   SPRN_HID0,r4
         sync
-        bl      gemini_prom_init
         b       __secondary_start
 #endif /* CONFIG_GEMINI */
-	.globl	__secondary_start_psurge
-__secondary_start_psurge:
-	li	r24,1			/* cpu # */
-	b	__secondary_start_psurge99
-	.globl	__secondary_start_psurge2
-__secondary_start_psurge2:
-	li	r24,2			/* cpu # */
-	b	__secondary_start_psurge99
-	.globl	__secondary_start_psurge3
-__secondary_start_psurge3:
-	li	r24,3			/* cpu # */
-	b	__secondary_start_psurge99
-__secondary_start_psurge99:
-	/* we come in here with IR=0 and DR=1, and DBAT 0
+
+	.globl	__secondary_start_pmac_0
+__secondary_start_pmac_0:
+	/* NB the entries for cpus 0, 1, 2 must each occupy 8 bytes. */
+	li	r24,0
+	b	1f
+	li	r24,1
+	b	1f
+	li	r24,2
+	b	1f
+	li	r24,3
+1:
+	/* on powersurge, we come in here with IR=0 and DR=1, and DBAT 0
 	   set to map the 0xf0000000 - 0xffffffff region */
 	mfmsr	r0
 	rlwinm	r0,r0,0,28,26		/* clear DR (0x10) */
diff -urN linux-2.6/arch/ppc/kernel/idle.c test/arch/ppc/kernel/idle.c
--- linux-2.6/arch/ppc/kernel/idle.c	2005-04-26 15:37:55.000000000 +1000
+++ test/arch/ppc/kernel/idle.c	2005-09-10 19:48:24.000000000 +1000
@@ -22,6 +22,7 @@
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
+#include <linux/cpu.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -35,6 +36,7 @@
 void default_idle(void)
 {
 	void (*powersave)(void);
+	int cpu = smp_processor_id();
 
 	powersave = ppc_md.power_save;
 
@@ -44,7 +46,7 @@
 #ifdef CONFIG_SMP
 		else {
 			set_thread_flag(TIF_POLLING_NRFLAG);
-			while (!need_resched())
+			while (!need_resched() && !cpu_is_offline(cpu))
 				barrier();
 			clear_thread_flag(TIF_POLLING_NRFLAG);
 		}
@@ -52,6 +54,8 @@
 	}
 	if (need_resched())
 		schedule();
+	if (cpu_is_offline(cpu) && system_state == SYSTEM_RUNNING)
+		cpu_die();
 }
 
 /*
diff -urN linux-2.6/arch/ppc/kernel/smp.c test/arch/ppc/kernel/smp.c
--- linux-2.6/arch/ppc/kernel/smp.c	2005-04-26 15:37:55.000000000 +1000
+++ test/arch/ppc/kernel/smp.c	2005-09-10 19:48:24.000000000 +1000
@@ -45,6 +45,7 @@
 cpumask_t cpu_possible_map;
 int smp_hw_index[NR_CPUS];
 struct thread_info *secondary_ti;
+static struct task_struct *idle_tasks[NR_CPUS];
 
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL(cpu_possible_map);
@@ -286,7 +287,8 @@
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	int num_cpus, i;
+	int num_cpus, i, cpu;
+	struct task_struct *p;
 
 	/* Fixup boot cpu */
         smp_store_cpu_info(smp_processor_id());
@@ -308,6 +310,17 @@
 
 	if (smp_ops->space_timers)
 		smp_ops->space_timers(num_cpus);
+
+	for_each_cpu(cpu) {
+		if (cpu == smp_processor_id())
+			continue;
+		/* create a process for the processor */
+		p = fork_idle(cpu);
+		if (IS_ERR(p))
+			panic("failed fork for CPU %u: %li", cpu, PTR_ERR(p));
+		p->thread_info->cpu = cpu;
+		idle_tasks[cpu] = p;
+	}
 }
 
 void __devinit smp_prepare_boot_cpu(void)
@@ -334,12 +347,17 @@
 	set_dec(tb_ticks_per_jiffy);
 	cpu_callin_map[cpu] = 1;
 
-	printk("CPU %i done callin...\n", cpu);
+	printk("CPU %d done callin...\n", cpu);
 	smp_ops->setup_cpu(cpu);
-	printk("CPU %i done setup...\n", cpu);
-	local_irq_enable();
+	printk("CPU %d done setup...\n", cpu);
 	smp_ops->take_timebase();
-	printk("CPU %i done timebase take...\n", cpu);
+	printk("CPU %d done timebase take...\n", cpu);
+
+	spin_lock(&call_lock);
+	cpu_set(cpu, cpu_online_map);
+	spin_unlock(&call_lock);
+
+	local_irq_enable();
 
 	cpu_idle();
 	return 0;
@@ -347,17 +365,11 @@
 
 int __cpu_up(unsigned int cpu)
 {
-	struct task_struct *p;
 	char buf[32];
 	int c;
 
-	/* create a process for the processor */
-	/* only regs.msr is actually used, and 0 is OK for it */
-	p = fork_idle(cpu);
-	if (IS_ERR(p))
-		panic("failed fork for CPU %u: %li", cpu, PTR_ERR(p));
-	secondary_ti = p->thread_info;
-	p->thread_info->cpu = cpu;
+	secondary_ti = idle_tasks[cpu]->thread_info;
+	mb();
 
 	/*
 	 * There was a cache flush loop here to flush the cache
@@ -389,7 +401,11 @@
 	printk("Processor %d found.\n", cpu);
 
 	smp_ops->give_timebase();
-	cpu_set(cpu, cpu_online_map);
+
+	/* Wait until cpu puts itself in the online map */
+	while (!cpu_online(cpu))
+		cpu_relax();
+
 	return 0;
 }
 
diff -urN linux-2.6/arch/ppc/platforms/pmac_sleep.S test/arch/ppc/platforms/pmac_sleep.S
--- linux-2.6/arch/ppc/platforms/pmac_sleep.S	2005-09-10 09:25:11.000000000 +1000
+++ test/arch/ppc/platforms/pmac_sleep.S	2005-09-10 19:48:24.000000000 +1000
@@ -161,6 +161,8 @@
 	addi r3,r3,sleep_storage@l
 	stw r5,0(r3)
 
+	.globl	low_cpu_die
+low_cpu_die:
 	/* Flush & disable all caches */
 	bl	flush_disable_caches
 
diff -urN linux-2.6/arch/ppc/platforms/pmac_smp.c test/arch/ppc/platforms/pmac_smp.c
--- linux-2.6/arch/ppc/platforms/pmac_smp.c	2005-04-26 15:37:55.000000000 +1000
+++ test/arch/ppc/platforms/pmac_smp.c	2005-09-10 19:48:24.000000000 +1000
@@ -33,6 +33,7 @@
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/hardirq.h>
+#include <linux/cpu.h>
 
 #include <asm/ptrace.h>
 #include <asm/atomic.h>
@@ -55,9 +56,7 @@
  * Powersurge (old powermac SMP) support.
  */
 
-extern void __secondary_start_psurge(void);
-extern void __secondary_start_psurge2(void);	/* Temporary horrible hack */
-extern void __secondary_start_psurge3(void);	/* Temporary horrible hack */
+extern void __secondary_start_pmac_0(void);
 
 /* Addresses for powersurge registers */
 #define HAMMERHEAD_BASE		0xf8000000
@@ -119,7 +118,7 @@
 static unsigned int pri_tb_hi, pri_tb_lo;
 static unsigned int pri_tb_stamp;
 
-static void __init core99_init_caches(int cpu)
+static void __devinit core99_init_caches(int cpu)
 {
 	if (!cpu_has_feature(CPU_FTR_L2CR))
 		return;
@@ -346,7 +345,7 @@
 
 static void __init smp_psurge_kick_cpu(int nr)
 {
-	void (*start)(void) = __secondary_start_psurge;
+	unsigned long start = __pa(__secondary_start_pmac_0) + nr * 8;
 	unsigned long a;
 
 	/* may need to flush here if secondary bats aren't setup */
@@ -356,17 +355,7 @@
 
 	if (ppc_md.progress) ppc_md.progress("smp_psurge_kick_cpu", 0x353);
 
-	/* setup entry point of secondary processor */
-	switch (nr) {
-	case 2:
-		start = __secondary_start_psurge2;
-		break;
-	case 3:
-		start = __secondary_start_psurge3;
-		break;
-	}
-
-	out_be32(psurge_start, __pa(start));
+	out_be32(psurge_start, start);
 	mb();
 
 	psurge_set_ipi(nr);
@@ -500,14 +489,14 @@
 	return ncpus;
 }
 
-static void __init smp_core99_kick_cpu(int nr)
+static void __devinit smp_core99_kick_cpu(int nr)
 {
 	unsigned long save_vector, new_vector;
 	unsigned long flags;
 
 	volatile unsigned long *vector
 		 = ((volatile unsigned long *)(KERNELBASE+0x100));
-	if (nr < 1 || nr > 3)
+	if (nr < 0 || nr > 3)
 		return;
 	if (ppc_md.progress) ppc_md.progress("smp_core99_kick_cpu", 0x346);
 
@@ -518,19 +507,9 @@
 	save_vector = *vector;
 
 	/* Setup fake reset vector that does	
-	 *   b __secondary_start_psurge - KERNELBASE
+	 *   b __secondary_start_pmac_0 + nr*8 - KERNELBASE
 	 */
-	switch(nr) {
-		case 1:
-			new_vector = (unsigned long)__secondary_start_psurge;
-			break;
-		case 2:
-			new_vector = (unsigned long)__secondary_start_psurge2;
-			break;
-		case 3:
-			new_vector = (unsigned long)__secondary_start_psurge3;
-			break;
-	}
+	new_vector = (unsigned long) __secondary_start_pmac_0 + nr * 8;
 	*vector = 0x48000002 + new_vector - KERNELBASE;
 
 	/* flush data cache and inval instruction cache */
@@ -554,7 +533,7 @@
 	if (ppc_md.progress) ppc_md.progress("smp_core99_kick_cpu done", 0x347);
 }
 
-static void __init smp_core99_setup_cpu(int cpu_nr)
+static void __devinit smp_core99_setup_cpu(int cpu_nr)
 {
 	/* Setup L2/L3 */
 	if (cpu_nr != 0)
@@ -668,3 +647,47 @@
 	.give_timebase	= smp_core99_give_timebase,
 	.take_timebase	= smp_core99_take_timebase,
 };
+
+#ifdef CONFIG_HOTPLUG_CPU
+
+int __cpu_disable(void)
+{
+	cpu_clear(smp_processor_id(), cpu_online_map);
+
+	/* XXX reset cpu affinity here */
+	openpic_set_priority(0xf);
+	asm volatile("mtdec %0" : : "r" (0x7fffffff));
+	mb();
+	udelay(20);
+	asm volatile("mtdec %0" : : "r" (0x7fffffff));
+	return 0;
+}
+
+extern void low_cpu_die(void) __attribute__((noreturn)); /* in pmac_sleep.S */
+static int cpu_dead[NR_CPUS];
+
+void cpu_die(void)
+{
+	local_irq_disable();
+	cpu_dead[smp_processor_id()] = 1;
+	mb();
+	low_cpu_die();
+}
+
+void __cpu_die(unsigned int cpu)
+{
+	int timeout;
+
+	timeout = 1000;
+	while (!cpu_dead[cpu]) {
+		if (--timeout == 0) {
+			printk("CPU %u refused to die!\n", cpu);
+			break;
+		}
+		msleep(1);
+	}
+	cpu_callin_map[cpu] = 0;
+	cpu_dead[cpu] = 0;
+}
+
+#endif
diff -urN linux-2.6/include/asm-ppc/smp.h test/include/asm-ppc/smp.h
--- linux-2.6/include/asm-ppc/smp.h	2005-06-24 13:39:01.000000000 +1000
+++ test/include/asm-ppc/smp.h	2005-09-10 20:06:39.000000000 +1000
@@ -41,6 +41,10 @@
 struct pt_regs;
 extern void smp_message_recv(int, struct pt_regs *);
 
+extern int __cpu_disable(void);
+extern void __cpu_die(unsigned int cpu);
+extern void cpu_die(void) __attribute__((noreturn));
+
 #define NO_PROC_ID		0xFF            /* No processor magic marker */
 #define PROC_CHANGE_PENALTY	20
 
@@ -64,6 +68,8 @@
 
 #else /* !(CONFIG_SMP) */
 
+static inline void cpu_die(void) { }
+
 #endif /* !(CONFIG_SMP) */
 
 #endif /* !(_PPC_SMP_H) */
