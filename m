Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <0b2db6ce8ed59fc969ad2d6d003f0b0316559fcc.1210220828.git.michael@ellerman.id.au>
In-Reply-To: <5d2ed2a7e92250bdc6d9959dbeaeb3784a7109b4.1210220828.git.michael@ellerman.id.au>
References: <5d2ed2a7e92250bdc6d9959dbeaeb3784a7109b4.1210220828.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 10/12] Fix sparse warnings in arch/powerpc/kernel
Date: Thu,  8 May 2008 14:27:19 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make a few things static in lparcfg.c
Make init and exit routines static in rtas_flash.c
Make things static in rtas_pci.c
Make some functions static in rtas.c
Make fops static in rtas-proc.c
Remove unneeded extern for do_gtod in smp.c
Make clocksource_init() static in time.c
Make last_tick_len and ticklen_to_xs static in time.c
Move the declaration of the pvr per-cpu into smp.h
Make kexec_smp_down() and kexec_stack static in machine_kexec_64.c
Don't return void in arch_teardown_msi_irqs() in msi.c
Move declaration of GregorianDay()into asm/time.h

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/lparcfg.c          |    6 +++---
 arch/powerpc/kernel/machine_kexec_64.c |    4 ++--
 arch/powerpc/kernel/msi.c              |    2 +-
 arch/powerpc/kernel/rtas-proc.c        |   14 +++++++-------
 arch/powerpc/kernel/rtas.c             |    6 +++---
 arch/powerpc/kernel/rtas_flash.c       |    4 ++--
 arch/powerpc/kernel/rtas_pci.c         |    4 ++--
 arch/powerpc/kernel/smp.c              |    4 ----
 arch/powerpc/kernel/time.c             |   10 +++++-----
 arch/powerpc/platforms/maple/time.c    |    2 --
 include/asm-powerpc/smp.h              |    2 ++
 include/asm-powerpc/time.h             |    1 +
 12 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/kernel/lparcfg.c b/arch/powerpc/kernel/lparcfg.c
index 1e656b4..827a572 100644
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -573,7 +573,7 @@ static int lparcfg_open(struct inode *inode, struct file *file)
 	return single_open(file, lparcfg_data, NULL);
 }
 
-const struct file_operations lparcfg_fops = {
+static const struct file_operations lparcfg_fops = {
 	.owner		= THIS_MODULE,
 	.read		= seq_read,
 	.write		= lparcfg_write,
@@ -581,7 +581,7 @@ const struct file_operations lparcfg_fops = {
 	.release	= single_release,
 };
 
-int __init lparcfg_init(void)
+static int __init lparcfg_init(void)
 {
 	struct proc_dir_entry *ent;
 	mode_t mode = S_IRUSR | S_IRGRP | S_IROTH;
@@ -601,7 +601,7 @@ int __init lparcfg_init(void)
 	return 0;
 }
 
-void __exit lparcfg_cleanup(void)
+static void __exit lparcfg_cleanup(void)
 {
 	if (proc_ppc64_lparcfg)
 		remove_proc_entry("lparcfg", proc_ppc64_lparcfg->parent);
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 704375b..631dfd6 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -158,7 +158,7 @@ void kexec_copy_flush(struct kimage *image)
  * on calling the interrupts, but we would like to call it off irq level
  * so that the interrupt controller is clean.
  */
-void kexec_smp_down(void *arg)
+static void kexec_smp_down(void *arg)
 {
 	if (ppc_md.kexec_cpu_down)
 		ppc_md.kexec_cpu_down(0, 1);
@@ -249,7 +249,7 @@ static void kexec_prepare_cpus(void)
  * We could use a smaller stack if we don't care about anything using
  * current, but that audit has not been performed.
  */
-union thread_union kexec_stack
+static union thread_union kexec_stack
 	__attribute__((__section__(".data.init_task"))) = { };
 
 /* Our assembly helper, in kexec_stub.S */
diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
index c62d101..3bb7d3d 100644
--- a/arch/powerpc/kernel/msi.c
+++ b/arch/powerpc/kernel/msi.c
@@ -34,5 +34,5 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 
 void arch_teardown_msi_irqs(struct pci_dev *dev)
 {
-	return ppc_md.teardown_msi_irqs(dev);
+	ppc_md.teardown_msi_irqs(dev);
 }
diff --git a/arch/powerpc/kernel/rtas-proc.c b/arch/powerpc/kernel/rtas-proc.c
index f9c6abc..1be9fe3 100644
--- a/arch/powerpc/kernel/rtas-proc.c
+++ b/arch/powerpc/kernel/rtas-proc.c
@@ -160,7 +160,7 @@ static int sensors_open(struct inode *inode, struct file *file)
 	return single_open(file, ppc_rtas_sensors_show, NULL);
 }
 
-const struct file_operations ppc_rtas_sensors_operations = {
+static const struct file_operations ppc_rtas_sensors_operations = {
 	.open		= sensors_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -172,7 +172,7 @@ static int poweron_open(struct inode *inode, struct file *file)
 	return single_open(file, ppc_rtas_poweron_show, NULL);
 }
 
-const struct file_operations ppc_rtas_poweron_operations = {
+static const struct file_operations ppc_rtas_poweron_operations = {
 	.open		= poweron_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -185,7 +185,7 @@ static int progress_open(struct inode *inode, struct file *file)
 	return single_open(file, ppc_rtas_progress_show, NULL);
 }
 
-const struct file_operations ppc_rtas_progress_operations = {
+static const struct file_operations ppc_rtas_progress_operations = {
 	.open		= progress_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -198,7 +198,7 @@ static int clock_open(struct inode *inode, struct file *file)
 	return single_open(file, ppc_rtas_clock_show, NULL);
 }
 
-const struct file_operations ppc_rtas_clock_operations = {
+static const struct file_operations ppc_rtas_clock_operations = {
 	.open		= clock_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -211,7 +211,7 @@ static int tone_freq_open(struct inode *inode, struct file *file)
 	return single_open(file, ppc_rtas_tone_freq_show, NULL);
 }
 
-const struct file_operations ppc_rtas_tone_freq_operations = {
+static const struct file_operations ppc_rtas_tone_freq_operations = {
 	.open		= tone_freq_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -224,7 +224,7 @@ static int tone_volume_open(struct inode *inode, struct file *file)
 	return single_open(file, ppc_rtas_tone_volume_show, NULL);
 }
 
-const struct file_operations ppc_rtas_tone_volume_operations = {
+static const struct file_operations ppc_rtas_tone_volume_operations = {
 	.open		= tone_volume_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -237,7 +237,7 @@ static int rmo_buf_open(struct inode *inode, struct file *file)
 	return single_open(file, ppc_rtas_rmo_buf_show, NULL);
 }
 
-const struct file_operations ppc_rtas_rmo_buf_ops = {
+static const struct file_operations ppc_rtas_rmo_buf_ops = {
 	.open		= rmo_buf_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 34843c3..2a60bd3 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -340,8 +340,8 @@ int rtas_get_error_log_max(void)
 EXPORT_SYMBOL(rtas_get_error_log_max);
 
 
-char rtas_err_buf[RTAS_ERROR_LOG_MAX];
-int rtas_last_error_token;
+static char rtas_err_buf[RTAS_ERROR_LOG_MAX];
+static int rtas_last_error_token;
 
 /** Return a copy of the detailed error text associated with the
  *  most recent failed call to rtas.  Because the error text
@@ -484,7 +484,7 @@ unsigned int rtas_busy_delay(int status)
 }
 EXPORT_SYMBOL(rtas_busy_delay);
 
-int rtas_error_rc(int rtas_rc)
+static int rtas_error_rc(int rtas_rc)
 {
 	int rc;
 
diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index 0a5e22b..09ded5c 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -731,7 +731,7 @@ static const struct file_operations validate_flash_operations = {
 	.release	= validate_flash_release,
 };
 
-int __init rtas_flash_init(void)
+static int __init rtas_flash_init(void)
 {
 	int rc;
 
@@ -817,7 +817,7 @@ cleanup:
 	return rc;
 }
 
-void __exit rtas_flash_cleanup(void)
+static void __exit rtas_flash_cleanup(void)
 {
 	rtas_flash_term_hook = NULL;
 
diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 3ab88a9..589a279 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -155,12 +155,12 @@ static int rtas_pci_write_config(struct pci_bus *bus,
 	return PCIBIOS_DEVICE_NOT_FOUND;
 }
 
-struct pci_ops rtas_pci_ops = {
+static struct pci_ops rtas_pci_ops = {
 	.read = rtas_pci_read_config,
 	.write = rtas_pci_write_config,
 };
 
-int is_python(struct device_node *dev)
+static int is_python(struct device_node *dev)
 {
 	const char *model = of_get_property(dev, "model", NULL);
 
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 1457aa0..ba7989f 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -365,12 +365,8 @@ void smp_call_function_interrupt(void)
 	}
 }
 
-extern struct gettimeofday_struct do_gtod;
-
 struct thread_info *current_set[NR_CPUS];
 
-DECLARE_PER_CPU(unsigned int, pvr);
-
 static void __devinit smp_store_cpu_info(int id)
 {
 	per_cpu(pvr, id) = mfspr(SPRN_PVR);
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 73401e8..c73fc33 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -129,7 +129,7 @@ static unsigned long __initdata iSeries_recal_titan;
 static signed long __initdata iSeries_recal_tb;
 
 /* Forward declaration is only needed for iSereis compiles */
-void __init clocksource_init(void);
+static void __init clocksource_init(void);
 #endif
 
 #define XSEC_PER_SEC (1024*1024)
@@ -150,8 +150,8 @@ u64 tb_to_xs;
 unsigned tb_to_us;
 
 #define TICKLEN_SCALE	NTP_SCALE_SHIFT
-u64 last_tick_len;	/* units are ns / 2^TICKLEN_SCALE */
-u64 ticklen_to_xs;	/* 0.64 fraction */
+static u64 last_tick_len;	/* units are ns / 2^TICKLEN_SCALE */
+static u64 ticklen_to_xs;	/* 0.64 fraction */
 
 /* If last_tick_len corresponds to about 1/HZ seconds, then
    last_tick_len << TICKLEN_SHIFT will be about 2^63. */
@@ -164,7 +164,7 @@ static u64 tb_to_ns_scale __read_mostly;
 static unsigned tb_to_ns_shift __read_mostly;
 static unsigned long boot_tb __read_mostly;
 
-struct gettimeofday_struct do_gtod;
+static struct gettimeofday_struct do_gtod;
 
 extern struct timezone sys_tz;
 static long timezone_offset;
@@ -832,7 +832,7 @@ void update_vsyscall_tz(void)
 	++vdso_data->tb_update_count;
 }
 
-void __init clocksource_init(void)
+static void __init clocksource_init(void)
 {
 	struct clocksource *clock;
 
diff --git a/arch/powerpc/platforms/maple/time.c b/arch/powerpc/platforms/maple/time.c
index 9f7579b..53bca13 100644
--- a/arch/powerpc/platforms/maple/time.c
+++ b/arch/powerpc/platforms/maple/time.c
@@ -41,8 +41,6 @@
 #define DBG(x...)
 #endif
 
-extern void GregorianDay(struct rtc_time * tm);
-
 static int maple_rtc_addr;
 
 static int maple_clock_read(int addr)
diff --git a/include/asm-powerpc/smp.h b/include/asm-powerpc/smp.h
index 505f35b..1cd43e3 100644
--- a/include/asm-powerpc/smp.h
+++ b/include/asm-powerpc/smp.h
@@ -37,6 +37,8 @@ extern void cpu_die(void);
 extern void smp_send_debugger_break(int cpu);
 extern void smp_message_recv(int);
 
+DECLARE_PER_CPU(unsigned int, pvr);
+
 #ifdef CONFIG_HOTPLUG_CPU
 extern void fixup_irqs(cpumask_t map);
 int generic_cpu_disable(void);
diff --git a/include/asm-powerpc/time.h b/include/asm-powerpc/time.h
index ce5de6e..febd581 100644
--- a/include/asm-powerpc/time.h
+++ b/include/asm-powerpc/time.h
@@ -33,6 +33,7 @@ extern unsigned      tb_to_us;
 
 struct rtc_time;
 extern void to_tm(int tim, struct rtc_time * tm);
+extern void GregorianDay(struct rtc_time *tm);
 extern time_t last_rtc_update;
 
 extern void generic_calibrate_decr(void);
-- 
1.5.5
