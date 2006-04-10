Return-Path: <dwilder@us.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C0F32679E1
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2006 09:56:46 +1000 (EST)
Received: from e32.co.us.ibm.com (e32.boulder.ibm.com [9.17.249.42])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3ALmINe017222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 17:48:18 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3ALmFeT004741
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 17:48:15 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3ALimne236802
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 15:44:48 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3ALmEsQ009269
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 15:48:15 -0600
Message-ID: <443ADCCE.1070504@us.ibm.com>
Date: Mon, 10 Apr 2006 15:31:42 -0700
From: David Wilder <dwilder@us.ibm.com>
MIME-Version: 1.0
To: fastboot@lists.osdl.org, linuxppc-dev@ozlabs.org, akpm@osdl.org,
	mchintage@in.ibm.com, paulus@samba.org, hbabu@us.ibm.com
Subject: [PATCH] 2 of 3   kdump-ppc64-soft-reset-fixes
Content-Type: multipart/mixed; boundary="------------060902070004080301010304"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060902070004080301010304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

- When a system hangs, user will activate the soft-reset to initiate the 
kdump boot. But, soft-reset behavior is indeterminate on sending FWNMI 
to all CPUS. i.e, all CPUs will not get FW NMI at the same time. When 
the first CPU entered (calling primary CPU here onwards) kdump using 
crash_kexec(), sends an IPI to other CPUs. Some CPUs will respond to 
this IPI and execute crash_ipi_callback()  before receive NMI. When they 
receive FW NMI, will execute die() and waiting forever since no more 
kdump IPI coming from the primary CPU. This issue will be fixed by 
invoking crash_kexec_secondary() directly from die().

Since the secondary CPUs will enter the IPI_callback function two times, 
CPU states have to be saved only once and the primary CPU has to start 
kdump boot after all CPUs are stopped. Hence, cpus_in_crash bitmap is 
used to determine whether pt_regs is saved. If the bit is not set, regs 
will be saved. Introduced cpus_in_sr bitmap and enter_on_soft_reset 
counter which are used to let the primary CPU know that all secondary 
CPUs entered via soft-reset and ready to do down.

- For the crash scenario, when a CPU hangs with interrupts disabled and 
the other CPUs panic or user invoked kdump boot using sysrq-c. In this 
case, the hung CPU can not be stopped and causes the kdump boot not 
successful. This case can be treated as complete system hang and asks 
the user to activate soft-reset if all secondary CPUs are not stopped.

Please pick-up this patch. (Note this patch is dependent on 
kdump-image-rm-static.patch, see my earlier posting)

-- 
David Wilder
IBM Linux Technology Center
Beaverton, Oregon, USA 
dwilder@us.ibm.com
(503)578-3789


--------------060902070004080301010304
Content-Type: text/x-patch;
 name="kdump-ppc64-soft-reset-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kdump-ppc64-soft-reset-fixes.patch"


- When a system hangs, user will activate the soft-reset to initiate the kdump boot. But, soft-reset behavior is indeterminate on sending FWNMI to all CPUS. i.e, all CPUs will not get FW NMI at the same time. When the first CPU entered (calling primary CPU here onwards) kdump using crash_kexec(), sends an IPI to other CPUs. Some CPUs will respond to this IPI and execute crash_ipi_callback()  before receive NMI. When they receive FW NMI, will execute die() and waiting forever since no more kdump IPI coming from the primary CPU. This issue will be fixed by invoking crash_kexec_secondary() directly from die().

Since the secondary CPUs will enter the IPI_callback function two times, CPU states have to be saved only once and the primary CPU has to start kdump boot after all CPUs are stopped. Hence, cpus_in_crash bitmap is used to determine whether pt_regs is saved. If the bit is not set, regs will be saved. Introduced cpus_in_sr bitmap and enter_on_soft_reset counter which are used to let the primary CPU know that all secondary CPUs entered via soft-reset and ready to do down.

- For the crash scenario, when a CPU hangs with interrupts disabled and the other CPUs panic or user invoked kdump boot using sysrq-c. In this case, the hung CPU can not be stopped and causes the kdump boot not successful. This case can be treated as complete system hang and asks the user to activate soft-reset if all secondary CPUs are not stopped.

Signed-off-by: David Wilder <dwilder@us.ibm.com>
Signed-off-by: Haren Myneni <haren@us.ibm.com>

diff -Naurp 2617-rc1.orig/arch/powerpc/kernel/crash.c 2617-rc1/arch/powerpc/kernel/crash.c
--- 2617-rc1.orig/arch/powerpc/kernel/crash.c	2006-04-05 13:20:38.000000000 -0700
+++ 2617-rc1/arch/powerpc/kernel/crash.c	2006-04-05 13:24:19.000000000 -0700
@@ -23,6 +23,7 @@
 #include <linux/elfcore.h>
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/irq.h>
 
 #include <asm/processor.h>
 #include <asm/machdep.h>
@@ -40,6 +41,9 @@
 
 /* This keeps a track of which one is crashing cpu. */
 int crashing_cpu = -1;
+static cpumask_t cpus_in_crash = CPU_MASK_NONE;
+extern struct kimage *kexec_crash_image;
+extern cpumask_t cpus_in_sr;
 
 static u32 *append_elf_note(u32 *buf, char *name, unsigned type, void *data,
 							       size_t data_len)
@@ -97,34 +101,66 @@ static void crash_save_this_cpu(struct p
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
+		barrier();
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
+		barrier();
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
@@ -132,13 +168,12 @@ static void crash_kexec_prepare_cpus(voi
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
+	while ((cpus_weight(cpus_in_crash) < ncpus) && (--msecs > 0)) {
 		barrier();
 		mdelay(1);
 	}
@@ -148,18 +183,71 @@ static void crash_kexec_prepare_cpus(voi
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
+			barrier();
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
+		barrier();
+	}
+        if (cpu == crashing_cpu) {
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
@@ -170,6 +258,10 @@ static void crash_kexec_prepare_cpus(voi
 	smp_release_cpus();
 }
 
+void crash_kexec_secondary(struct pt_regs *regs)
+{
+	cpus_in_sr = CPU_MASK_NONE;
+}
 #endif
 
 void default_machine_crash_shutdown(struct pt_regs *regs)
@@ -185,15 +277,14 @@ void default_machine_crash_shutdown(stru
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
diff -Naurp 2617-rc1.orig/arch/powerpc/kernel/traps.c 2617-rc1/arch/powerpc/kernel/traps.c
--- 2617-rc1.orig/arch/powerpc/kernel/traps.c	2006-04-05 13:20:33.000000000 -0700
+++ 2617-rc1/arch/powerpc/kernel/traps.c	2006-04-05 13:22:00.000000000 -0700
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
 
diff -Naurp 2617-rc1.orig/include/asm-powerpc/kexec.h 2617-rc1/include/asm-powerpc/kexec.h
--- 2617-rc1.orig/include/asm-powerpc/kexec.h	2006-04-05 13:20:53.000000000 -0700
+++ 2617-rc1/include/asm-powerpc/kexec.h	2006-04-05 13:18:27.000000000 -0700
@@ -123,8 +123,10 @@ extern int default_machine_kexec_prepare
 extern void default_machine_crash_shutdown(struct pt_regs *regs);
 
 extern void machine_kexec_simple(struct kimage *image);
-
+extern void crash_kexec_secondary(struct pt_regs *regs);
 #endif /* ! __ASSEMBLY__ */
+#else
+static inline void crash_kexec_secondary(struct pt_regs *regs) { }
 #endif /* CONFIG_KEXEC */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_KEXEC_H */

--------------060902070004080301010304--
