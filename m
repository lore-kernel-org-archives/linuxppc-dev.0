Return-Path: <olh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9171267C25
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jul 2005 07:23:30 +1000 (EST)
Date: Fri, 15 Jul 2005 23:23:25 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Message-ID: <20050715212325.GA5574@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH] make a few functions static in pmac_setup.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Making a few functions static saves a few bytes, but only on ppc32.

     text	   data	    bss	    dec	    hex	filename
  3752421	1605208	 345608	5703237	 570645	../O-ppc64_iSeries_defconfig/vmlinux
  3709411	2042552	 339992	6091955	 5cf4b3	../O-ppc64_maple_defconfig/vmlinux
  5397329	3054824	 679856	9132009	 8b57e9	../O-ppc64_pSeries_defconfig/vmlinux
 -3882695	 417552	 197760	4498007	 44a257	../O-ppc_common_defconfig/vmlinux
 -3414510	 574500	 241440	4230450	 408d32	../O-ppc_pmac_defconfig/vmlinux
 +3882627	 417168	 197760	4497555	 44a093	../O-ppc_common_defconfig/vmlinux
 +3414442	 575428	 241440	4231310	 40908e	../O-ppc_pmac_defconfig/vmlinux

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/ppc/platforms/pmac_setup.c |   16 ++++++++--------
 arch/ppc64/kernel/pmac_setup.c  |   12 ++++++------
 2 files changed, 14 insertions(+), 14 deletions(-)

Index: linux-2.6.13-rc3-olh/arch/ppc/platforms/pmac_setup.c
===================================================================
--- linux-2.6.13-rc3-olh.orig/arch/ppc/platforms/pmac_setup.c
+++ linux-2.6.13-rc3-olh/arch/ppc/platforms/pmac_setup.c
@@ -113,7 +113,7 @@ extern int pmac_newworld;
 extern void zs_kgdb_hook(int tty_num);
 static void ohare_init(void);
 #ifdef CONFIG_BOOTX_TEXT
-void pmac_progress(char *s, unsigned short hex);
+static void pmac_progress(char *s, unsigned short hex);
 #endif
 
 sys_ctrler_t sys_ctrler = SYS_CTRLER_UNKNOWN;
@@ -123,7 +123,7 @@ extern struct smp_ops_t psurge_smp_ops;
 extern struct smp_ops_t core99_smp_ops;
 #endif /* CONFIG_SMP */
 
-int __pmac
+static int __pmac
 pmac_show_cpuinfo(struct seq_file *m)
 {
 	struct device_node *np;
@@ -227,7 +227,7 @@ pmac_show_cpuinfo(struct seq_file *m)
 	return 0;
 }
 
-int __openfirmware
+static int __openfirmware
 pmac_show_percpuinfo(struct seq_file *m, int i)
 {
 #ifdef CONFIG_CPU_FREQ_PMAC
@@ -415,7 +415,7 @@ find_ide_boot(void)
 }
 #endif /* CONFIG_BLK_DEV_IDE && CONFIG_BLK_DEV_IDE_PMAC */
 
-void __init
+static void __init
 find_boot_device(void)
 {
 #if defined(CONFIG_BLK_DEV_IDE) && defined(CONFIG_BLK_DEV_IDE_PMAC)
@@ -512,7 +512,7 @@ note_bootable_part(dev_t dev, int part, 
 	}
 }
 
-void __pmac
+static void __pmac
 pmac_restart(char *cmd)
 {
 #ifdef CONFIG_ADB_CUDA
@@ -537,7 +537,7 @@ pmac_restart(char *cmd)
 	}
 }
 
-void __pmac
+static void __pmac
 pmac_power_off(void)
 {
 #ifdef CONFIG_ADB_CUDA
@@ -562,7 +562,7 @@ pmac_power_off(void)
 	}
 }
 
-void __pmac
+static void __pmac
 pmac_halt(void)
 {
    pmac_power_off();
@@ -715,7 +715,7 @@ pmac_init(unsigned long r3, unsigned lon
 }
 
 #ifdef CONFIG_BOOTX_TEXT
-void __init
+static void __init
 pmac_progress(char *s, unsigned short hex)
 {
 	if (boot_text_mapped) {
Index: linux-2.6.13-rc3-olh/arch/ppc64/kernel/pmac_setup.c
===================================================================
--- linux-2.6.13-rc3-olh.orig/arch/ppc64/kernel/pmac_setup.c
+++ linux-2.6.13-rc3-olh/arch/ppc64/kernel/pmac_setup.c
@@ -97,7 +97,7 @@ EXPORT_SYMBOL(smu_cmdbuf_abs);
 
 extern void udbg_init_scc(struct device_node *np);
 
-void __pmac pmac_show_cpuinfo(struct seq_file *m)
+static void __pmac pmac_show_cpuinfo(struct seq_file *m)
 {
 	struct device_node *np;
 	char *pp;
@@ -144,7 +144,7 @@ void __pmac pmac_show_cpuinfo(struct seq
 }
 
 
-void __init pmac_setup_arch(void)
+static void __init pmac_setup_arch(void)
 {
 	/* init to some ~sane value until calibrate_delay() runs */
 	loops_per_jiffy = 50000000;
@@ -230,7 +230,7 @@ void __pmac note_bootable_part(dev_t dev
 	}
 }
 
-void __pmac pmac_restart(char *cmd)
+static void __pmac pmac_restart(char *cmd)
 {
 	switch(sys_ctrler) {
 #ifdef CONFIG_ADB_PMU
@@ -249,7 +249,7 @@ void __pmac pmac_restart(char *cmd)
 	}
 }
 
-void __pmac pmac_power_off(void)
+static void __pmac pmac_power_off(void)
 {
 	switch(sys_ctrler) {
 #ifdef CONFIG_ADB_PMU
@@ -267,7 +267,7 @@ void __pmac pmac_power_off(void)
 	}
 }
 
-void __pmac pmac_halt(void)
+static void __pmac pmac_halt(void)
 {
 	pmac_power_off();
 }
@@ -327,7 +327,7 @@ static void __init init_boot_display(voi
 /* 
  * Early initialization.
  */
-void __init pmac_init_early(void)
+static void __init pmac_init_early(void)
 {
 	DBG(" -> pmac_init_early\n");
 
