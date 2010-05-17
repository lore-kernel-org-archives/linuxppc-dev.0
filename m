Return-Path: <anton@ozlabs.org>
Date: Mon, 17 May 2010 16:02:39 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, nfont@austin.ibm.com
Subject: [PATCH 2/2] powerpc: Use smt_snooze_delay=-1 to always busy loop
Message-ID: <20100517060238.GA25198@kryten>
References: <20100517060128.GC13509@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100517060128.GC13509@kryten>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Right now if we want to busy loop and not give up any time to the hypervisor
we put a very large value into smt_snooze_delay. This is sometimes useful
when running a single partition and you want to avoid any latencies due
to the hypervisor or CPU power state transitions. While this works, it's a bit
ugly - how big a number is enough now we have NO_HZ and can be idle for a very
long time.

The patch below makes smt_snooze_delay signed, and a negative value means loop
forever:

echo -1 > /sys/devices/system/cpu/cpu0/smt_snooze_delay

This change shouldn't affect the existing userspace tools (eg ppc64_cpu), but
I'm cc-ing Nathan just to be sure.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/kernel/sysfs.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/sysfs.c	2010-05-17 15:18:24.164704601 +1000
+++ powerpc.git/arch/powerpc/kernel/sysfs.c	2010-05-17 15:18:26.207205125 +1000
@@ -35,7 +35,7 @@ static DEFINE_PER_CPU(struct cpu, cpu_de
 #ifdef CONFIG_PPC64
 
 /* Time in microseconds we delay before sleeping in the idle loop */
-DEFINE_PER_CPU(unsigned long, smt_snooze_delay) = { 100 };
+DEFINE_PER_CPU(long, smt_snooze_delay) = { 100 };
 
 static ssize_t store_smt_snooze_delay(struct sys_device *dev,
 				      struct sysdev_attribute *attr,
@@ -44,9 +44,9 @@ static ssize_t store_smt_snooze_delay(st
 {
 	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
 	ssize_t ret;
-	unsigned long snooze;
+	long snooze;
 
-	ret = sscanf(buf, "%lu", &snooze);
+	ret = sscanf(buf, "%ld", &snooze);
 	if (ret != 1)
 		return -EINVAL;
 
@@ -61,7 +61,7 @@ static ssize_t show_smt_snooze_delay(str
 {
 	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
 
-	return sprintf(buf, "%lu\n", per_cpu(smt_snooze_delay, cpu->sysdev.id));
+	return sprintf(buf, "%ld\n", per_cpu(smt_snooze_delay, cpu->sysdev.id));
 }
 
 static SYSDEV_ATTR(smt_snooze_delay, 0644, show_smt_snooze_delay,
@@ -70,15 +70,14 @@ static SYSDEV_ATTR(smt_snooze_delay, 064
 static int __init setup_smt_snooze_delay(char *str)
 {
 	unsigned int cpu;
-	int snooze;
+	long snooze;
 
 	if (!cpu_has_feature(CPU_FTR_SMT))
 		return 1;
 
-	if (get_option(&str, &snooze)) {
-		for_each_possible_cpu(cpu)
-			per_cpu(smt_snooze_delay, cpu) = snooze;
-	}
+	snooze = simple_strtol(str, NULL, 10);
+	for_each_possible_cpu(cpu)
+		per_cpu(smt_snooze_delay, cpu) = snooze;
 
 	return 1;
 }
Index: powerpc.git/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/pseries/setup.c	2010-05-17 15:05:29.827204407 +1000
+++ powerpc.git/arch/powerpc/platforms/pseries/setup.c	2010-05-17 15:18:26.207205125 +1000
@@ -496,13 +496,14 @@ static int __init pSeries_probe(void)
 }
 
 
-DECLARE_PER_CPU(unsigned long, smt_snooze_delay);
+DECLARE_PER_CPU(long, smt_snooze_delay);
 
 static void pseries_dedicated_idle_sleep(void)
 { 
 	unsigned int cpu = smp_processor_id();
 	unsigned long start_snooze;
 	unsigned long in_purr, out_purr;
+	long snooze = __get_cpu_var(smt_snooze_delay);
 
 	/*
 	 * Indicate to the HV that we are idle. Now would be
@@ -517,13 +518,12 @@ static void pseries_dedicated_idle_sleep
 	 * has been checked recently.  If we should poll for a little
 	 * while, do so.
 	 */
-	if (__get_cpu_var(smt_snooze_delay)) {
-		start_snooze = get_tb() +
-			__get_cpu_var(smt_snooze_delay) * tb_ticks_per_usec;
+	if (snooze) {
+		start_snooze = get_tb() + snooze * tb_ticks_per_usec;
 		local_irq_enable();
 		set_thread_flag(TIF_POLLING_NRFLAG);
 
-		while (get_tb() < start_snooze) {
+		while ((snooze < 0) || (get_tb() < start_snooze)) {
 			if (need_resched() || cpu_is_offline(cpu))
 				goto out;
 			ppc64_runlatch_off();
