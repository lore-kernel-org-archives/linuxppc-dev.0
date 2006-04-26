Return-Path: <dwilder@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5153267B86
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 05:03:01 +1000 (EST)
Received: from e31.co.us.ibm.com (e31.boulder.ibm.com [9.17.249.41])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3QHMLCX024022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 13:22:22 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3QHLlCE016709
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 13:21:47 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3QHPHtY168604
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 11:25:17 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3QHLlWH003213
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 11:21:47 -0600
Received: from [9.67.65.168] ([9.67.65.168])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	k3QHLkUi032505
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 11:21:46 -0600
Message-ID: <444FB608.5020702@us.ibm.com>
Date: Wed, 26 Apr 2006 11:03:52 -0700
From: David Wilder <dwilder@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc64_softreset_patch
Content-Type: multipart/mixed; boundary="------------050300000202090307010102"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050300000202090307010102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please pick up this patch.
This is a re-do of the ppc64-soft-reset-fix.patch. I have included 
changes suggested by Olaf and Andrew and combined it with the 
ppc64-kexec-tools-rm-platform-fix.patch to remove the dependency. 

-- 
David Wilder
IBM Linux Technology Center
Beaverton, Oregon, USA 
dwilder@us.ibm.com
(503)578-3789


--------------050300000202090307010102
Content-Type: text/x-patch;
 name="ppc64-softreset-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc64-softreset-fixes.patch"

- When a system hangs, user will activate the soft-reset to initiate the kdump boot. But, soft-reset behavior is indeterminate on sending FWNMI to all CPUS. i.e, all CPUs will not get FW NMI at the same time. When the first CPU entered (calling primary CPU here onwards) kdump using crash_kexec(), sends an IPI to other CPUs. Some CPUs will respond to this IPI and execute crash_ipi_callback()  before receive NMI. When they receive FW NMI, will execute die() and waiting forever since no more kdump IPI coming from the primary CPU. This issue will be fixed by invoking crash_kexec_secondary() directly from die().

Since the secondary CPUs will enter the IPI_callback function two times, CPU states have to be saved only once and the primary CPU has to start kdump boot after all CPUs are stopped. Hence, cpus_in_crash bitmap is used to determine whether pt_regs is saved. If the bit is not set, regs will be saved. Introduced cpus_in_sr bitmap and enter_on_soft_reset counter which are used to let the primary CPU know that all secondary CPUs entered via soft-reset and ready to do down.

- For the crash scenario, when a CPU hangs with interrupts disabled and the other CPUs panic or user invoked kdump boot using sysrq-c. In this case, the hung CPU can not be stopped and causes the kdump boot not successful. This case can be treated as complete system hang and asks the user to activate soft-reset if all secondary CPUs are not stopped.

Signed-off-by: David Wilder <dwilder@us.ibm.com>
Signed-off-by: Haren Myneni <haren@us.ibm.com>

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 778f22f..20ef5d2 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -23,9 +23,11 @@
 #include <linux/elfcore.h>
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/irq.h>
 
 #include <asm/processor.h>
 #include <asm/machdep.h>
+#include <asm/kexec.h>
 #include <asm/kdump.h>
 #include <asm/lmb.h>
 #include <asm/firmware.h>
@@ -40,6 +42,7 @@
 
 /* This keeps a track of which one is crashing cpu. */
 int crashing_cpu = -1;
+static cpumask_t cpus_in_crash = CPU_MASK_NONE;
 
 static u32 *append_elf_note(u32 *buf, char *name, unsigned type, void *data,
 							       size_t data_len)
@@ -97,34 +100,66 @@ static void crash_save_this_cpu(struct p
 }
 
 #ifdef CONFIG_SMP
-static atomic_t waiting_for_crash_ipi;
+static atomic_t enter_on_soft_reset = ATOMIC_INIT(0);
 
 void crash_ipi_callback(struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
 
-	if (cpu == crashing_cpu)
-		return;
-
 	if (!cpu_online(cpu))
 		return;
 
-	if (ppc_md.kexec_cpu_down)
-		ppc_md.kexec_cpu_down(1, 1);
-
 	local_irq_disable();
+	if (!cpu_isset(cpu, cpus_in_crash))
+		crash_save_this_cpu(regs, cpu);
+	cpu_set(cpu, cpus_in_crash);
 
-	crash_save_this_cpu(regs, cpu);
-	atomic_dec(&waiting_for_crash_ipi);
+	/*
+	 * Entered via soft-reset - could be the kdump  
+	 * process is invoked using soft-reset or user activated
+	 * it if some CPU did not respond to an IPI.
+	 * For soft-reset, the secondary CPU can enter this func
+	 * twice. 1 - using IPI, and 2. soft-reset.
+	 * Tell the kexec CPU that entered via soft-reset and ready 
+	 * to go down.
+	 */
+	if (cpu_isset(cpu, cpus_in_sr)) {
+		cpu_clear(cpu, cpus_in_sr);
+		atomic_inc(&enter_on_soft_reset);
+	} 
+		
+	/*
+	 * Starting the kdump boot.
+	 * This barrier is needed to make sure that all CPUs are stopped.
+	 * If not, soft-reset will be invoked to bring other CPUs. 
+	 */
+	while (!cpu_isset(crashing_cpu, cpus_in_crash)) 
+		cpu_relax();
+	
+	if (ppc_md.kexec_cpu_down)
+		ppc_md.kexec_cpu_down(1, 1);
 	kexec_smp_wait();
 	/* NOTREACHED */
 }
 
-static void crash_kexec_prepare_cpus(void)
+/*
+ * Wait until all CPUs are entered via soft-reset.
+ */
+static void crash_soft_reset_check(int cpu)
+{
+	unsigned int ncpus = num_online_cpus() - 1;/* Excluding the panic cpu */
+
+	cpu_clear(cpu, cpus_in_sr);
+	while (atomic_read(&enter_on_soft_reset) != ncpus)
+		cpu_relax();
+}
+	
+	
+static void crash_kexec_prepare_cpus(int cpu)
 {
 	unsigned int msecs;
 
-	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
+	unsigned int ncpus = num_online_cpus() - 1;/* Excluding the panic cpu */
 
 	crash_send_ipi(crash_ipi_callback);
 	smp_wmb();
@@ -132,14 +167,13 @@ static void crash_kexec_prepare_cpus(voi
 	/*
 	 * FIXME: Until we will have the way to stop other CPUSs reliabally,
 	 * the crash CPU will send an IPI and wait for other CPUs to
-	 * respond. If not, proceed the kexec boot even though we failed to
-	 * capture other CPU states.
+	 * respond.
 	 * Delay of at least 10 seconds.
 	 */
-	printk(KERN_ALERT "Sending IPI to other cpus...\n");
+	printk(KERN_EMERG "Sending IPI to other cpus...\n");
 	msecs = 10000;
-	while ((atomic_read(&waiting_for_crash_ipi) > 0) && (--msecs > 0)) {
-		barrier();
+		while ((cpus_weight(cpus_in_crash) < ncpus) && (--msecs > 0)) {
+		cpu_relax();
 		mdelay(1);
 	}
 
@@ -148,18 +182,71 @@ static void crash_kexec_prepare_cpus(voi
 	/*
 	 * FIXME: In case if we do not get all CPUs, one possibility: ask the
 	 * user to do soft reset such that we get all.
-	 * IPI handler is already set by the panic cpu initially. Therefore,
-	 * all cpus could invoke this handler from die() and the panic CPU
-	 * will call machine_kexec() directly from this handler to do
-	 * kexec boot.
-	 */
-	if (atomic_read(&waiting_for_crash_ipi))
-		printk(KERN_ALERT "done waiting: %d cpus not responding\n",
-			atomic_read(&waiting_for_crash_ipi));
+	 * Soft-reset will be used until better mechanism is implemented.
+	 */
+	if (cpus_weight(cpus_in_crash) < ncpus) {
+		printk(KERN_EMERG "done waiting: %d cpu(s) not responding\n",
+			ncpus - cpus_weight(cpus_in_crash));
+		printk(KERN_EMERG "Activate soft-reset to stop other cpu(s)\n");
+		cpus_in_sr = CPU_MASK_NONE;
+		atomic_set(&enter_on_soft_reset, 0);
+		while (cpus_weight(cpus_in_crash) < ncpus)
+			cpu_relax();
+	}
+	/*
+	 * Make sure all CPUs are entered via soft-reset if the kdump is
+	 * invoked using soft-reset.
+	 */
+	if (cpu_isset(cpu, cpus_in_sr)) 
+		crash_soft_reset_check(cpu);
 	/* Leave the IPI callback set */
 }
+
+/*
+ * This function will be called by secondary cpus or by kexec cpu 
+ * if soft-reset is activated to stop some CPUs.
+ */
+void crash_kexec_secondary(struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+	unsigned long flags;
+	int msecs = 5;
+
+	local_irq_save(flags);
+	/* Wait 5ms if the kexec CPU is not entered yet. */
+	while (crashing_cpu < 0) {
+		if (--msecs < 0) {
+			/*
+			 * Either kdump image is not loaded or
+			 * kdump process is not started - Probably xmon
+			 * exited using 'x'(exit and recover) or 
+			 * kexec_should_crash() failed for all running tasks.
+			 */
+			cpu_clear(cpu, cpus_in_sr);
+			local_irq_restore(flags);
+			return;
+		}
+		mdelay(1);
+		cpu_relax();
+	}
+	if (cpu == crashing_cpu) {
+		/*
+		 * Panic CPU will enter this func only via soft-reset.
+		 * Wait until all secondary CPUs entered and
+		 * then start kexec boot.
+		 */
+		crash_soft_reset_check(cpu);
+		cpu_set(crashing_cpu, cpus_in_crash);
+		if (ppc_md.kexec_cpu_down)
+			ppc_md.kexec_cpu_down(1, 0);
+		machine_kexec(kexec_crash_image);
+		/* NOTREACHED */
+	}
+	crash_ipi_callback(regs);
+}
+
 #else
-static void crash_kexec_prepare_cpus(void)
+static void crash_kexec_prepare_cpus(int cpu)
 {
 	/*
 	 * move the secondarys to us so that we can copy
@@ -170,6 +257,10 @@ static void crash_kexec_prepare_cpus(voi
 	smp_release_cpus();
 }
 
+void crash_kexec_secondary(struct pt_regs *regs)
+{
+	cpus_in_sr = CPU_MASK_NONE;
+}
 #endif
 
 void default_machine_crash_shutdown(struct pt_regs *regs)
@@ -185,15 +276,14 @@ void default_machine_crash_shutdown(stru
 	 * The kernel is broken so disable interrupts.
 	 */
 	local_irq_disable();
-
-	if (ppc_md.kexec_cpu_down)
-		ppc_md.kexec_cpu_down(1, 0);
-
 	/*
 	 * Make a note of crashing cpu. Will be used in machine_kexec
 	 * such that another IPI will not be sent.
 	 */
 	crashing_cpu = smp_processor_id();
-	crash_kexec_prepare_cpus();
 	crash_save_this_cpu(regs, crashing_cpu);
+	crash_kexec_prepare_cpus(crashing_cpu);
+	cpu_set(crashing_cpu, cpus_in_crash);
+	if (ppc_md.kexec_cpu_down)
+		ppc_md.kexec_cpu_down(1, 0);
 }
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 064a525..ad6500e 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -51,9 +51,13 @@
 #include <asm/firmware.h>
 #include <asm/processor.h>
 #endif
+#include <asm/kexec.h>
 
 #ifdef CONFIG_PPC64	/* XXX */
 #define _IO_BASE	pci_io_base
+#ifdef CONFIG_KEXEC
+cpumask_t cpus_in_sr = CPU_MASK_NONE;
+#endif
 #endif
 
 #ifdef CONFIG_DEBUGGER
@@ -96,7 +100,7 @@ static DEFINE_SPINLOCK(die_lock);
 
 int die(const char *str, struct pt_regs *regs, long err)
 {
-	static int die_counter, crash_dump_start = 0;
+	static int die_counter;
 
 	if (debugger(regs))
 		return 1;
@@ -128,22 +132,12 @@ int die(const char *str, struct pt_regs 
 	print_modules();
 	show_regs(regs);
 	bust_spinlocks(0);
-
-	if (!crash_dump_start && kexec_should_crash(current)) {
-		crash_dump_start = 1;
-		spin_unlock_irq(&die_lock);
-		crash_kexec(regs);
-		/* NOTREACHED */
-	}
 	spin_unlock_irq(&die_lock);
-	if (crash_dump_start)
-		/*
-		 * Only for soft-reset: Other CPUs will be responded to an IPI
-		 * sent by first kexec CPU.
-		 */
-		for(;;)
-			;
 
+	if (kexec_should_crash(current))
+		crash_kexec(regs);
+	crash_kexec_secondary(regs);
+		
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
 
@@ -205,6 +199,10 @@ void system_reset_exception(struct pt_re
 		if (ppc_md.system_reset_exception(regs))
 			return;
 	}
+	
+#ifdef CONFIG_KEXEC
+	cpu_set(smp_processor_id(), cpus_in_sr);
+#endif
 
 	die("System Reset", regs, SIGABRT);
 
diff --git a/include/asm-powerpc/kexec.h b/include/asm-powerpc/kexec.h
index 6a2af2f..7eb2bb2 100644
--- a/include/asm-powerpc/kexec.h
+++ b/include/asm-powerpc/kexec.h
@@ -31,9 +31,8 @@
 #define KEXEC_ARCH KEXEC_ARCH_PPC
 #endif
 
-#ifdef CONFIG_KEXEC
-
 #ifndef __ASSEMBLY__
+#ifdef CONFIG_KEXEC
 #ifdef __powerpc64__
 /*
  * This function is responsible for capturing register states if coming
@@ -114,6 +113,7 @@ extern void kexec_smp_wait(void);	/* get
 extern void __init kexec_setup(void);
 extern int crashing_cpu;
 extern void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *));
+extern cpumask_t cpus_in_sr;
 #endif /* __powerpc64 __ */
 
 struct kimage;
@@ -123,8 +123,10 @@ extern int default_machine_kexec_prepare
 extern void default_machine_crash_shutdown(struct pt_regs *regs);
 
 extern void machine_kexec_simple(struct kimage *image);
-
-#endif /* ! __ASSEMBLY__ */
+extern void crash_kexec_secondary(struct pt_regs *regs);
+#else
+static inline void crash_kexec_secondary(struct pt_regs *regs) { }
 #endif /* CONFIG_KEXEC */
+#endif /* ! __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_KEXEC_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index cfb3410..6427949 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -106,6 +106,7 @@ extern struct page *kimage_alloc_control
 extern void crash_kexec(struct pt_regs *);
 int kexec_should_crash(struct task_struct *);
 extern struct kimage *kexec_image;
+extern struct kimage *kexec_crash_image;
 
 #define KEXEC_ON_CRASH  0x00000001
 #define KEXEC_ARCH_MASK 0xffff0000
diff --git a/kernel/kexec.c b/kernel/kexec.c
index bf39d28..950559d 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -903,7 +903,7 @@ static int kimage_load_segment(struct ki
  * that to happen you need to do that yourself.
  */
 struct kimage *kexec_image = NULL;
-static struct kimage *kexec_crash_image = NULL;
+struct kimage *kexec_crash_image = NULL;
 /*
  * A home grown binary mutex.
  * Nothing can wait so this mutex is safe to use
@@ -1042,7 +1042,6 @@ asmlinkage long compat_sys_kexec_load(un
 
 void crash_kexec(struct pt_regs *regs)
 {
-	struct kimage *image;
 	int locked;
 
 
@@ -1056,12 +1055,11 @@ void crash_kexec(struct pt_regs *regs)
 	 */
 	locked = xchg(&kexec_lock, 1);
 	if (!locked) {
-		image = xchg(&kexec_crash_image, NULL);
-		if (image) {
+		if (kexec_crash_image) {
 			struct pt_regs fixed_regs;
 			crash_setup_regs(&fixed_regs, regs);
 			machine_crash_shutdown(&fixed_regs);
-			machine_kexec(image);
+			machine_kexec(kexec_crash_image);
 		}
 		xchg(&kexec_lock, 0);
 	}

--------------050300000202090307010102--
