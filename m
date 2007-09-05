Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B21CFDDEA3
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 05:28:04 +1000 (EST)
Date: Wed, 5 Sep 2007 14:27:53 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 2/9] 8xx: Infrastructure code cleanup.
Message-ID: <20070905192753.GA32398@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905192727.GA32365@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

1. Keep a global mpc8xx_immr mapping, rather than constantly
creating temporary mappings.
2. Look for new fsl,cpm1 and fsl,cpm1-pic names.
3. Always reset the CPM when not using the udbg console;
this is required in case the firmware initialized a device
that is incompatible with one that the kernel is about to
use.
4. Remove some superfluous casts and header includes.
5. Change a usage of IMAP_ADDR to get_immrbase().
6. Use phys_addr_t, not uint, for dpram_pbase.
7. Various sparse-related fixes, such as __iomem annotations.
8. Remove mpc8xx_show_cpuinfo, which doesn't provide anything
useful beyond the generic cpuinfo handler.
9. Move prototypes for 8xx support functions from board files
to sysdev/commproc.h.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/8xx/m8xx_setup.c      |   90 ++++++--------------------
 arch/powerpc/platforms/8xx/mpc86xads.h       |    3 -
 arch/powerpc/platforms/8xx/mpc86xads_setup.c |   10 +---
 arch/powerpc/platforms/8xx/mpc885ads.h       |    3 -
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |   11 +---
 arch/powerpc/sysdev/commproc.c               |   71 +++++++++++---------
 arch/powerpc/sysdev/commproc.h               |   12 ++++
 arch/powerpc/sysdev/mpc8xx_pic.c             |   16 ++--
 include/asm-powerpc/commproc.h               |    4 +-
 include/asm-powerpc/fs_pd.h                  |   19 +----
 10 files changed, 89 insertions(+), 150 deletions(-)
 create mode 100644 arch/powerpc/sysdev/commproc.h

diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index b2b98dd..d35eda8 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -10,57 +10,33 @@
  * bootup setup stuff..
  */
 
-#include <linux/errno.h>
-#include <linux/sched.h>
 #include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/stddef.h>
-#include <linux/unistd.h>
-#include <linux/ptrace.h>
 #include <linux/slab.h>
-#include <linux/user.h>
-#include <linux/a.out.h>
-#include <linux/tty.h>
-#include <linux/major.h>
 #include <linux/interrupt.h>
-#include <linux/reboot.h>
 #include <linux/init.h>
-#include <linux/initrd.h>
-#include <linux/ioport.h>
-#include <linux/bootmem.h>
-#include <linux/seq_file.h>
-#include <linux/root_dev.h>
 #include <linux/time.h>
 #include <linux/rtc.h>
-#include <linux/fsl_devices.h>
 
-#include <asm/mmu.h>
-#include <asm/reg.h>
 #include <asm/io.h>
-#include <asm/pgtable.h>
 #include <asm/mpc8xx.h>
 #include <asm/8xx_immap.h>
-#include <asm/machdep.h>
-#include <asm/time.h>
 #include <asm/prom.h>
 #include <asm/fs_pd.h>
 #include <mm/mmu_decl.h>
 
-#include "sysdev/mpc8xx_pic.h"
+#include <sysdev/mpc8xx_pic.h>
+#include <sysdev/commproc.h>
 
 #ifdef CONFIG_PCMCIA_M8XX
 struct mpc8xx_pcmcia_ops m8xx_pcmcia_ops;
 #endif
 
 void m8xx_calibrate_decr(void);
-#ifdef CONFIG_8xx_WDT
-extern void m8xx_wdt_handler_install(bd_t *bp);
-#endif
 extern int cpm_pic_init(void);
 extern int cpm_get_irq(void);
 
 /* A place holder for time base interrupts, if they are ever enabled. */
-irqreturn_t timebase_interrupt(int irq, void * dev)
+static irqreturn_t timebase_interrupt(int irq, void *dev)
 {
 	printk ("timebase_interrupt()\n");
 
@@ -77,7 +53,7 @@ static struct irqaction tbint_irqaction = {
 void __init __attribute__ ((weak))
 init_internal_rtc(void)
 {
-	sit8xx_t *sys_tmr = (sit8xx_t *) immr_map(im_sit);
+	sit8xx_t __iomem *sys_tmr = immr_map(im_sit);
 
 	/* Disable the RTC one second and alarm interrupts. */
 	clrbits16(&sys_tmr->sit_rtcsc, (RTCSC_SIE | RTCSC_ALE));
@@ -116,13 +92,13 @@ static int __init get_freq(char *name, unsigned long *val)
 void __init mpc8xx_calibrate_decr(void)
 {
 	struct device_node *cpu;
-	cark8xx_t *clk_r1;
-	car8xx_t *clk_r2;
-	sitk8xx_t *sys_tmr1;
-	sit8xx_t *sys_tmr2;
+	cark8xx_t __iomem *clk_r1;
+	car8xx_t __iomem *clk_r2;
+	sitk8xx_t __iomem *sys_tmr1;
+	sit8xx_t __iomem *sys_tmr2;
 	int irq, virq;
 
-	clk_r1 = (cark8xx_t *) immr_map(im_clkrstk);
+	clk_r1 = immr_map(im_clkrstk);
 
 	/* Unlock the SCCR. */
 	out_be32(&clk_r1->cark_sccrk, ~KAPWR_KEY);
@@ -130,7 +106,7 @@ void __init mpc8xx_calibrate_decr(void)
 	immr_unmap(clk_r1);
 
 	/* Force all 8xx processors to use divide by 16 processor clock. */
-	clk_r2 = (car8xx_t *) immr_map(im_clkrst);
+	clk_r2 = immr_map(im_clkrst);
 	setbits32(&clk_r2->car_sccr, 0x02000000);
 	immr_unmap(clk_r2);
 
@@ -164,7 +140,7 @@ void __init mpc8xx_calibrate_decr(void)
 	 * we guarantee the registers are locked, then we unlock them
 	 * for our use.
 	 */
-	sys_tmr1 = (sitk8xx_t *) immr_map(im_sitk);
+	sys_tmr1 = immr_map(im_sitk);
 	out_be32(&sys_tmr1->sitk_tbscrk, ~KAPWR_KEY);
 	out_be32(&sys_tmr1->sitk_rtcsck, ~KAPWR_KEY);
 	out_be32(&sys_tmr1->sitk_tbk, ~KAPWR_KEY);
@@ -184,20 +160,13 @@ void __init mpc8xx_calibrate_decr(void)
 	virq= irq_of_parse_and_map(cpu, 0);
 	irq = irq_map[virq].hwirq;
 
-	sys_tmr2 = (sit8xx_t *) immr_map(im_sit);
+	sys_tmr2 = immr_map(im_sit);
 	out_be16(&sys_tmr2->sit_tbscr, ((1 << (7 - (irq/2))) << 8) |
 					(TBSCR_TBF | TBSCR_TBE));
 	immr_unmap(sys_tmr2);
 
 	if (setup_irq(virq, &tbint_irqaction))
 		panic("Could not allocate timer IRQ!");
-
-#ifdef CONFIG_8xx_WDT
-	/* Install watchdog timer handler early because it might be
-	 * already enabled by the bootloader
-	 */
-	m8xx_wdt_handler_install(binfo);
-#endif
 }
 
 /* The RTC on the MPC8xx is an internal register.
@@ -207,12 +176,12 @@ void __init mpc8xx_calibrate_decr(void)
 
 int mpc8xx_set_rtc_time(struct rtc_time *tm)
 {
-	sitk8xx_t *sys_tmr1;
-	sit8xx_t *sys_tmr2;
+	sitk8xx_t __iomem *sys_tmr1;
+	sit8xx_t __iomem *sys_tmr2;
 	int time;
 
-	sys_tmr1 = (sitk8xx_t *) immr_map(im_sitk);
-	sys_tmr2 = (sit8xx_t *) immr_map(im_sit);
+	sys_tmr1 = immr_map(im_sitk);
+	sys_tmr2 = immr_map(im_sit);
 	time = mktime(tm->tm_year+1900, tm->tm_mon+1, tm->tm_mday,
 	              tm->tm_hour, tm->tm_min, tm->tm_sec);
 
@@ -228,7 +197,7 @@ int mpc8xx_set_rtc_time(struct rtc_time *tm)
 void mpc8xx_get_rtc_time(struct rtc_time *tm)
 {
 	unsigned long data;
-	sit8xx_t *sys_tmr = (sit8xx_t *) immr_map(im_sit);
+	sit8xx_t __iomem *sys_tmr = immr_map(im_sit);
 
 	/* Get time from the RTC. */
 	data = in_be32(&sys_tmr->sit_rtc);
@@ -241,8 +210,7 @@ void mpc8xx_get_rtc_time(struct rtc_time *tm)
 
 void mpc8xx_restart(char *cmd)
 {
-	__volatile__ unsigned char dummy;
-	car8xx_t * clk_r = (car8xx_t *) immr_map(im_clkrst);
+	car8xx_t __iomem *clk_r = immr_map(im_clkrst);
 
 
 	local_irq_disable();
@@ -252,26 +220,8 @@ void mpc8xx_restart(char *cmd)
 	*/
 	mtmsr(mfmsr() & ~0x1000);
 
-	dummy = in_8(&clk_r->res[0]);
-	printk("Restart failed\n");
-	while(1);
-}
-
-void mpc8xx_show_cpuinfo(struct seq_file *m)
-{
-	struct device_node *root;
-	uint memsize = total_memory;
-	const char *model = "";
-
-	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
-
-	root = of_find_node_by_path("/");
-	if (root)
-		model = of_get_property(root, "model", NULL);
-	seq_printf(m, "Machine\t\t: %s\n", model);
-	of_node_put(root);
-
-	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
+	in_8(&clk_r->res[0]);
+	panic("Restart failed\n");
 }
 
 static void cpm_cascade(unsigned int irq, struct irq_desc *desc)
diff --git a/arch/powerpc/platforms/8xx/mpc86xads.h b/arch/powerpc/platforms/8xx/mpc86xads.h
index dd10cd2..cffa194 100644
--- a/arch/powerpc/platforms/8xx/mpc86xads.h
+++ b/arch/powerpc/platforms/8xx/mpc86xads.h
@@ -29,9 +29,6 @@
 #define CFG_PHYDEV_ADDR		((uint)0xff0a0000)
 #define BCSR5			((uint)(CFG_PHYDEV_ADDR + 0x300))
 
-#define IMAP_ADDR		(get_immrbase())
-#define IMAP_SIZE		((uint)(64 * 1024))
-
 #define MPC8xx_CPM_OFFSET	(0x9c0)
 #define CPM_MAP_ADDR		(get_immrbase() + MPC8xx_CPM_OFFSET)
 #define CPM_IRQ_OFFSET		16     // for compability with cpm_uart driver
diff --git a/arch/powerpc/platforms/8xx/mpc86xads_setup.c b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
index 8f64f48..4901283 100644
--- a/arch/powerpc/platforms/8xx/mpc86xads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
@@ -37,14 +37,7 @@
 #include <asm/fs_pd.h>
 #include <asm/prom.h>
 
-extern void cpm_reset(void);
-extern void mpc8xx_show_cpuinfo(struct seq_file*);
-extern void mpc8xx_restart(char *cmd);
-extern void mpc8xx_calibrate_decr(void);
-extern int mpc8xx_set_rtc_time(struct rtc_time *tm);
-extern void mpc8xx_get_rtc_time(struct rtc_time *tm);
-extern void m8xx_pic_init(void);
-extern unsigned int mpc8xx_get_irq(void);
+#include <sysdev/commproc.h>
 
 static void init_smc1_uart_ioports(struct fs_uart_platform_info* fpi);
 static void init_smc2_uart_ioports(struct fs_uart_platform_info* fpi);
@@ -277,7 +270,6 @@ define_machine(mpc86x_ads) {
 	.probe			= mpc86xads_probe,
 	.setup_arch		= mpc86xads_setup_arch,
 	.init_IRQ		= m8xx_pic_init,
-	.show_cpuinfo		= mpc8xx_show_cpuinfo,
 	.get_irq		= mpc8xx_get_irq,
 	.restart		= mpc8xx_restart,
 	.calibrate_decr		= mpc8xx_calibrate_decr,
diff --git a/arch/powerpc/platforms/8xx/mpc885ads.h b/arch/powerpc/platforms/8xx/mpc885ads.h
index 14db124..a21e528 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads.h
+++ b/arch/powerpc/platforms/8xx/mpc885ads.h
@@ -29,9 +29,6 @@
 #define CFG_PHYDEV_ADDR		((uint)0xff0a0000)
 #define BCSR5			((uint)(CFG_PHYDEV_ADDR + 0x300))
 
-#define IMAP_ADDR		(get_immrbase())
-#define IMAP_SIZE		((uint)(64 * 1024))
-
 #define MPC8xx_CPM_OFFSET	(0x9c0)
 #define CPM_MAP_ADDR		(get_immrbase() + MPC8xx_CPM_OFFSET)
 #define CPM_IRQ_OFFSET		16     // for compability with cpm_uart driver
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index d3da385..bb54268 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -38,15 +38,6 @@
 #include <asm/fs_pd.h>
 #include <asm/prom.h>
 
-extern void cpm_reset(void);
-extern void mpc8xx_show_cpuinfo(struct seq_file *);
-extern void mpc8xx_restart(char *cmd);
-extern void mpc8xx_calibrate_decr(void);
-extern int mpc8xx_set_rtc_time(struct rtc_time *tm);
-extern void mpc8xx_get_rtc_time(struct rtc_time *tm);
-extern void m8xx_pic_init(void);
-extern unsigned int mpc8xx_get_irq(void);
-
 static void init_smc1_uart_ioports(struct fs_uart_platform_info *fpi);
 static void init_smc2_uart_ioports(struct fs_uart_platform_info *fpi);
 static void init_scc3_ioports(struct fs_platform_info *ptr);
@@ -428,7 +419,7 @@ define_machine(mpc885_ads)
 {
 .name = "MPC885 ADS",.probe = mpc885ads_probe,.setup_arch =
 	    mpc885ads_setup_arch,.init_IRQ =
-	    m8xx_pic_init,.show_cpuinfo = mpc8xx_show_cpuinfo,.get_irq =
+	    m8xx_pic_init,.get_irq =
 	    mpc8xx_get_irq,.restart = mpc8xx_restart,.calibrate_decr =
 	    mpc8xx_calibrate_decr,.set_rtc_time =
 	    mpc8xx_set_rtc_time,.get_rtc_time = mpc8xx_get_rtc_time,};
diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index e8e79f8..af26659 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -47,8 +47,9 @@
 static void m8xx_cpm_dpinit(void);
 static uint host_buffer; /* One page of host buffer */
 static uint host_end;    /* end + 1 */
-cpm8xx_t *cpmp;          /* Pointer to comm processor space */
-cpic8xx_t *cpic_reg;
+cpm8xx_t __iomem *cpmp;  /* Pointer to comm processor space */
+immap_t __iomem *mpc8xx_immr;
+static cpic8xx_t __iomem *cpic_reg;
 
 static struct device_node *cpm_pic_node;
 static struct irq_host *cpm_pic_host;
@@ -140,16 +141,19 @@ unsigned int cpm_pic_init(void)
 
 	pr_debug("cpm_pic_init\n");
 
-	np = of_find_compatible_node(NULL, "cpm-pic", "CPM");
+	np = of_find_compatible_node(NULL, NULL, "fsl,cpm1-pic");
+	if (np == NULL)
+		np = of_find_compatible_node(NULL, "cpm-pic", "CPM");
 	if (np == NULL) {
 		printk(KERN_ERR "CPM PIC init: can not find cpm-pic node\n");
 		return sirq;
 	}
+
 	ret = of_address_to_resource(np, 0, &res);
 	if (ret)
 		goto end;
 
-	cpic_reg = (void *)ioremap(res.start, res.end - res.start + 1);
+	cpic_reg = ioremap(res.start, res.end - res.start + 1);
 	if (cpic_reg == NULL)
 		goto end;
 
@@ -173,14 +177,16 @@ unsigned int cpm_pic_init(void)
 		sirq = NO_IRQ;
 		goto end;
 	}
-	of_node_put(np);
 
 	/* Install our own error handler. */
-	np = of_find_node_by_type(NULL, "cpm");
+	np = of_find_compatible_node(NULL, NULL, "fsl,cpm1");
+	if (np == NULL)
+		np = of_find_node_by_type(NULL, "cpm");
 	if (np == NULL) {
 		printk(KERN_ERR "CPM PIC init: can not find cpm node\n");
 		goto end;
 	}
+
 	eirq = irq_of_parse_and_map(np, 0);
 	if (eirq == NO_IRQ)
 		goto end;
@@ -197,21 +203,28 @@ end:
 
 void cpm_reset(void)
 {
-	cpm8xx_t *commproc;
-	sysconf8xx_t *siu_conf;
+	sysconf8xx_t __iomem *siu_conf;
 
-	commproc = (cpm8xx_t *)ioremap(CPM_MAP_ADDR, CPM_MAP_SIZE);
+	mpc8xx_immr = ioremap(get_immrbase(), 0x4000);
+	if (!mpc8xx_immr) {
+		printk(KERN_CRIT "Could not map IMMR\n");
+		return;
+	}
 
-#ifdef CONFIG_UCODE_PATCH
+	cpmp = &mpc8xx_immr->im_cpm;
+
+#ifndef CONFIG_PPC_EARLY_DEBUG_CPM
 	/* Perform a reset.
 	*/
-	out_be16(&commproc->cp_cpcr, CPM_CR_RST | CPM_CR_FLG);
+	out_be16(&cpmp->cp_cpcr, CPM_CR_RST | CPM_CR_FLG);
 
 	/* Wait for it.
 	*/
-	while (in_be16(&commproc->cp_cpcr) & CPM_CR_FLG);
+	while (in_be16(&cpmp->cp_cpcr) & CPM_CR_FLG);
+#endif
 
-	cpm_load_patch(commproc);
+#ifdef CONFIG_UCODE_PATCH
+	cpm_load_patch(cpmp);
 #endif
 
 	/* Set SDMA Bus Request priority 5.
@@ -220,16 +233,12 @@ void cpm_reset(void)
 	 * manual recommends it.
 	 * Bit 25, FAM can also be set to use FEC aggressive mode (860T).
 	 */
-	siu_conf = (sysconf8xx_t*)immr_map(im_siu_conf);
+	siu_conf = immr_map(im_siu_conf);
 	out_be32(&siu_conf->sc_sdcr, 1);
 	immr_unmap(siu_conf);
 
 	/* Reclaim the DP memory for our use. */
 	m8xx_cpm_dpinit();
-
-	/* Tell everyone where the comm processor resides.
-	*/
-	cpmp = commproc;
 }
 
 /* We used to do this earlier, but have to postpone as long as possible
@@ -279,20 +288,20 @@ m8xx_cpm_hostalloc(uint size)
 void
 cpm_setbrg(uint brg, uint rate)
 {
-	volatile uint	*bp;
+	u32 __iomem *bp;
 
 	/* This is good enough to get SMCs running.....
 	*/
-	bp = (uint *)&cpmp->cp_brgc1;
+	bp = &cpmp->cp_brgc1;
 	bp += brg;
 	/* The BRG has a 12-bit counter.  For really slow baud rates (or
 	 * really fast processors), we may have to further divide by 16.
 	 */
 	if (((BRG_UART_CLK / rate) - 1) < 4096)
-		*bp = (((BRG_UART_CLK / rate) - 1) << 1) | CPM_BRG_EN;
+		out_be32(bp, (((BRG_UART_CLK / rate) - 1) << 1) | CPM_BRG_EN);
 	else
-		*bp = (((BRG_UART_CLK_DIV16 / rate) - 1) << 1) |
-						CPM_BRG_EN | CPM_BRG_DIV16;
+		out_be32(bp, (((BRG_UART_CLK_DIV16 / rate) - 1) << 1) |
+		             CPM_BRG_EN | CPM_BRG_DIV16);
 }
 
 /*
@@ -307,15 +316,15 @@ static rh_block_t cpm_boot_dpmem_rh_block[16];
 static rh_info_t cpm_dpmem_info;
 
 #define CPM_DPMEM_ALIGNMENT	8
-static u8 *dpram_vbase;
-static uint dpram_pbase;
+static u8 __iomem *dpram_vbase;
+static phys_addr_t dpram_pbase;
 
-void m8xx_cpm_dpinit(void)
+static void m8xx_cpm_dpinit(void)
 {
 	spin_lock_init(&cpm_dpmem_lock);
 
-	dpram_vbase = immr_map_size(im_cpm.cp_dpmem, CPM_DATAONLY_BASE + CPM_DATAONLY_SIZE);
-	dpram_pbase = (uint)&((immap_t *)IMAP_ADDR)->im_cpm.cp_dpmem;
+	dpram_vbase = cpmp->cp_dpmem;
+	dpram_pbase = get_immrbase() + offsetof(immap_t, im_cpm.cp_dpmem);
 
 	/* Initialize the info header */
 	rh_init(&cpm_dpmem_info, CPM_DPMEM_ALIGNMENT,
@@ -387,12 +396,12 @@ EXPORT_SYMBOL(cpm_dpdump);
 
 void *cpm_dpram_addr(unsigned long offset)
 {
-	return (void *)(dpram_vbase + offset);
+	return (void __force *)(dpram_vbase + offset);
 }
 EXPORT_SYMBOL(cpm_dpram_addr);
 
-uint cpm_dpram_phys(u8* addr)
+uint cpm_dpram_phys(u8 *addr)
 {
-	return (dpram_pbase + (uint)(addr - dpram_vbase));
+	return (dpram_pbase + (uint)(addr - (u8 __force *)dpram_vbase));
 }
 EXPORT_SYMBOL(cpm_dpram_addr);
diff --git a/arch/powerpc/sysdev/commproc.h b/arch/powerpc/sysdev/commproc.h
new file mode 100644
index 0000000..9155ba4
--- /dev/null
+++ b/arch/powerpc/sysdev/commproc.h
@@ -0,0 +1,12 @@
+#ifndef _POWERPC_SYSDEV_COMMPROC_H
+#define _POWERPC_SYSDEV_COMMPROC_H
+
+extern void cpm_reset(void);
+extern void mpc8xx_restart(char *cmd);
+extern void mpc8xx_calibrate_decr(void);
+extern int mpc8xx_set_rtc_time(struct rtc_time *tm);
+extern void mpc8xx_get_rtc_time(struct rtc_time *tm);
+extern void m8xx_pic_init(void);
+extern unsigned int mpc8xx_get_irq(void);
+
+#endif
diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8xx_pic.c
index 2fc2bcd..e50d3ae 100644
--- a/arch/powerpc/sysdev/mpc8xx_pic.c
+++ b/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -23,7 +23,7 @@ static struct device_node *mpc8xx_pic_node;
 static struct irq_host *mpc8xx_pic_host;
 #define NR_MASK_WORDS   ((NR_IRQS + 31) / 32)
 static unsigned long ppc_cached_irq_mask[NR_MASK_WORDS];
-static sysconf8xx_t	*siu_reg;
+static sysconf8xx_t __iomem *siu_reg;
 
 int cpm_get_irq(struct pt_regs *regs);
 
@@ -166,24 +166,24 @@ static struct irq_host_ops mpc8xx_pic_host_ops = {
 int mpc8xx_pic_init(void)
 {
 	struct resource res;
-	struct device_node *np = NULL;
+	struct device_node *np;
 	int ret;
 
-	np = of_find_node_by_type(np, "mpc8xx-pic");
-
+	np = of_find_compatible_node(NULL, NULL, "fsl,pq1-pic");
+	if (np == NULL)
+		np = of_find_node_by_type(NULL, "mpc8xx-pic");
 	if (np == NULL) {
-		printk(KERN_ERR "Could not find open-pic node\n");
+		printk(KERN_ERR "Could not find fsl,pq1-pic node\n");
 		return -ENOMEM;
 	}
 
-	mpc8xx_pic_node = of_node_get(np);
+	mpc8xx_pic_node = np;
 
 	ret = of_address_to_resource(np, 0, &res);
-	of_node_put(np);
 	if (ret)
 		return ret;
 
-	siu_reg = (void *)ioremap(res.start, res.end - res.start + 1);
+	siu_reg = ioremap(res.start, res.end - res.start + 1);
 	if (siu_reg == NULL)
 		return -EINVAL;
 
diff --git a/include/asm-powerpc/commproc.h b/include/asm-powerpc/commproc.h
index 3972487..86fcf26 100644
--- a/include/asm-powerpc/commproc.h
+++ b/include/asm-powerpc/commproc.h
@@ -66,7 +66,7 @@
 /* Export the base address of the communication processor registers
  * and dual port ram.
  */
-extern	cpm8xx_t	*cpmp;		/* Pointer to comm processor */
+extern cpm8xx_t __iomem *cpmp; /* Pointer to comm processor */
 extern unsigned long cpm_dpalloc(uint size, uint align);
 extern int cpm_dpfree(unsigned long offset);
 extern unsigned long cpm_dpalloc_fixed(unsigned long offset, uint size, uint align);
@@ -689,4 +689,6 @@ typedef struct risc_timer_pram {
 extern void cpm_install_handler(int vec, void (*handler)(void *), void *dev_id);
 extern void cpm_free_handler(int vec);
 
+#define IMAP_ADDR		(get_immrbase())
+
 #endif /* __CPM_8XX__ */
diff --git a/include/asm-powerpc/fs_pd.h b/include/asm-powerpc/fs_pd.h
index c624915..733e8cb 100644
--- a/include/asm-powerpc/fs_pd.h
+++ b/include/asm-powerpc/fs_pd.h
@@ -45,22 +45,11 @@
 #include <asm/8xx_immap.h>
 #include <asm/mpc8xx.h>
 
-#define immr_map(member)						\
-({									\
-	u32 offset = offsetof(immap_t, member);				\
-	void *addr = ioremap (IMAP_ADDR + offset,			\
-			      sizeof( ((immap_t*)0)->member));		\
-	addr;								\
-})
-
-#define immr_map_size(member, size)					\
-({									\
-	u32 offset = offsetof(immap_t, member);				\
-	void *addr = ioremap (IMAP_ADDR + offset, size);		\
-	addr;								\
-})
+extern immap_t __iomem *mpc8xx_immr;
 
-#define immr_unmap(addr)		iounmap(addr)
+#define immr_map(member) (&mpc8xx_immr->member)
+#define immr_map_size(member, size) (&mpc8xx_immr->member)
+#define immr_unmap(addr) iounmap(addr)
 #endif
 
 static inline int uart_baudrate(void)
-- 
1.5.3
