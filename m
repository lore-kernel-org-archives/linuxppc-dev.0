Return-Path: <dwilder@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2DCC567A6C
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 07:48:26 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5NLmJAU019032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 17:48:19 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5NLmVdl133300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 15:48:31 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5NLmIPC013928
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 15:48:18 -0600
Message-ID: <449C6B4E.4060205@us.ibm.com>
Date: Fri, 23 Jun 2006 15:29:34 -0700
From: David Wilder <dwilder@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, paulus@samba.org, Andrew Morton <akpm@osdl.org>,
	fastboot@lists.osdl.org, Haren Myneni <hbabu@us.ibm.com>
Subject: powerpc: Adding the use of the firmware soft-reset-nmi to kdump.
Content-Type: multipart/mixed; boundary="------------030803050103040700090708"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030803050103040700090708
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

This is a reposting of the patch posted on June 14.
http://ozlabs.org/pipermail/linuxppc-dev/2006-June/023705.html
I had no comments on my previous posting. It should be ready to pickup 
by Andrew or Paul.
The attached patch applies clean to the torvalds/linux-2.6.git
Thanks

- Patch Description
With this patch, kdump uses the firmware soft-rest NMI for two purposes:
1) Initiate the kdump (take a crash dump) by issuing a soft-reset.
2) Break a CPU out of a deadlock condition that is detected during kdump 
processing.

When a soft-reset is initiated each CPU will enter 
system_reset_exception() and set its corresponding bit in the global 
bit-array cpus_in_sr then call die(). When die() finds the CPU’s bit set 
in cpu_in_sr crash_kexec() is called to initiate a crash dump. The first 
CPU to enter crash_kexec() is called the “crashing CPU”. All other CPUs 
are “secondary CPUs”. The secondary CPU’s pass through to 
crash_kexec_secondary() and sleep. The crashing CPU waits for all CPUs 
to enter via soft-reset then boots the kdump kernel (see 
crash_soft_reset_check())

When the system crashes due to a panic or exception, crash_kexec() is 
called by panic() or die(). The crashing CPU sends an IPI to all other 
CPUs to notify them of the pending shutdown. If a CPU is in a deadlock 
or hung state with interrupts disabled, the IPI will not be delivered. 
The result being, that the kdump kernel is not booted. This problem is 
solved with the use of a firmware generated soft-reset. After the 
crashing_cpu has issued the IPI, it waits for 10 sec for all CPUs to 
enter crash_ipi_callback(). A CPU signifies its entry to 
crash_ipi_callback() by setting its corresponding bit in the 
cpus_in_crash bit array. After 10 sec, if one or more CPUs have not set 
their bit in cpus_in_crash we assume that the CPU(s) is deadlocked. The 
operator is then prompted to generate a soft-reset to break the 
deadlock. Each CPU enters the soft reset handler as described above.

Two conditions must be handled at this point:
1) The system crashed because the operator generated a soft-reset. See 
#1 above.
2) The system had crashed before the soft-reset was generated ( in the 
case of a Panic or oops…).

The first CPU to enter crash_kexec() uses the state of the kexec_lock to 
determine this state. If kexec_lock is already held then condition 2 is 
true and crash_kexec_secondary() is called, else; this CPU is flagged as 
the crashing CPU, the kexec_lock is acquired and crash_kexec() proceeds 
as described above.

Each additional CPUs responding to the soft-reset will pass through 
crash_kexec() to kexec_secondary(). All secondary CPUs call 
crash_ipi_callback() readying them self's for the shutdown. When ready 
they clear their bit in cpus_in_sr. The crashing CPU waits in 
kexec_secondary() until all other CPUs have cleared their bits in 
cpus_in_sr. The kexec kernel boot is then started.

Signed-off-by: Haren Myneni <haren at us.ibm.com <https://ozlabs.org/mailman/listinfo/linuxppc-dev>>
Signed-off-by: David Wilder <dwilder at us.ibm.com <https://ozlabs.org/mailman/listinfo/linuxppc-dev>>
-- 




-- 
David Wilder
IBM Linux Technology Center
Beaverton, Oregon, USA 
dwilder@us.ibm.com
(503)578-3789


--------------030803050103040700090708
Content-Type: text/x-patch;
 name="ppc64-softreset-in-k-dump-2.6.17-git.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc64-softreset-in-k-dump-2.6.17-git.patch"

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index dbcb859..857629f 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -24,9 +24,11 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/types.h>
+#include <linux/irq.h>
 
 #include <asm/processor.h>
 #include <asm/machdep.h>
+#include <asm/kexec.h>
 #include <asm/kdump.h>
 #include <asm/lmb.h>
 #include <asm/firmware.h>
@@ -41,6 +43,7 @@
 
 /* This keeps a track of which one is crashing cpu. */
 int crashing_cpu = -1;
+static cpumask_t cpus_in_crash = CPU_MASK_NONE;
 
 static u32 *append_elf_note(u32 *buf, char *name, unsigned type, void *data,
 							       size_t data_len)
@@ -98,34 +101,66 @@ static void crash_save_this_cpu(struct p
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
@@ -133,14 +168,13 @@ static void crash_kexec_prepare_cpus(voi
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
+	while ((cpus_weight(cpus_in_crash) < ncpus) && (--msecs > 0)) {
+		cpu_relax();
 		mdelay(1);
 	}
 
@@ -149,18 +183,71 @@ static void crash_kexec_prepare_cpus(voi
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
@@ -171,6 +258,10 @@ static void crash_kexec_prepare_cpus(voi
 	smp_release_cpus();
 }
 
+void crash_kexec_secondary(struct pt_regs *regs)
+{
+	cpus_in_sr = CPU_MASK_NONE;
+}
 #endif
 
 void default_machine_crash_shutdown(struct pt_regs *regs)
@@ -199,14 +290,14 @@ void default_machine_crash_shutdown(stru
 			desc->handler->disable(irq);
 	}
 
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
index 91a6e04..b94a790 100644
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
@@ -128,22 +132,13 @@ int die(const char *str, struct pt_regs 
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
 
+	if (kexec_should_crash(current) ||
+		kexec_sr_activated(smp_processor_id()))
+		crash_kexec(regs);
+	crash_kexec_secondary(regs);
+		
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
 
@@ -205,6 +200,10 @@ void system_reset_exception(struct pt_re
 		if (ppc_md.system_reset_exception(regs))
 			return;
 	}
+	
+#ifdef CONFIG_KEXEC
+	cpu_set(smp_processor_id(), cpus_in_sr);
+#endif
 
 	die("System Reset", regs, SIGABRT);
 
diff --git a/include/asm-powerpc/kexec.h b/include/asm-powerpc/kexec.h
index efe8872..610c75e 100644
--- a/include/asm-powerpc/kexec.h
+++ b/include/asm-powerpc/kexec.h
@@ -115,6 +115,11 @@ extern void kexec_smp_wait(void);	/* get
 extern void __init kexec_setup(void);
 extern int crashing_cpu;
 extern void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *));
+extern cpumask_t cpus_in_sr;
+static inline int kexec_sr_activated(int cpu)
+{
+	return cpu_isset(cpu,cpus_in_sr);
+}
 #endif /* __powerpc64 __ */
 
 struct kimage;
@@ -124,10 +129,13 @@ extern int default_machine_kexec_prepare
 extern void default_machine_crash_shutdown(struct pt_regs *regs);
 
 extern void machine_kexec_simple(struct kimage *image);
+extern void crash_kexec_secondary(struct pt_regs *regs);
 extern int overlaps_crashkernel(unsigned long start, unsigned long size);
 extern void reserve_crashkernel(void);
 
 #else /* !CONFIG_KEXEC */
+static inline int kexec_sr_activated(int cpu) { return 0; }
+static inline void crash_kexec_secondary(struct pt_regs *regs) { }
 
 static inline int overlaps_crashkernel(unsigned long start, unsigned long size)
 {
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 58f0f38..50087ec 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
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

--------------030803050103040700090708--
