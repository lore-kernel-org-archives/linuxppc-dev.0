Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id B169C679F1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 May 2005 05:20:44 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	j4RJPuIC011642 for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 May 2005 12:25:56 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id j4RJM6ue016585
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 May 2005 14:22:06 -0500 (CDT)
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
In-Reply-To: <f003613a0526b7b6a00a0bd477cd5ac3@freescale.com>
References: <1116607235.29111.20.camel@gleep>
	<f003613a0526b7b6a00a0bd477cd5ac3@freescale.com>
Content-Type: text/plain
Message-Id: <1117221642.26114.102.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Fri, 27 May 2005 14:20:42 -0500
Subject: bd_t Cleaning: System Parts
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2005-05-26 at 18:08, Kumar Gala wrote:
> Jon,
> 
> Can you break the patch up into a few pieces, it will be easier to 
> review that way.  Here are the following pieces that make sense to me:
> 
> 0. New firmware interface (fw_bdt*, Kconfig, ...)
> 1. board code changes (everything in arch/ppc/platforms/*)
> 2. driver changes (things in *_io, ide, net, serial dirs -- try to give 
> a better list below)
> 3. System changes (files in arch/ppc/syslib and include/asm-ppc)

And the final quarter, the System Bits:

 ppc/syslib/cpm2_common.c                |    3 
 ppc/syslib/m8260_pci.h                  |    6 
 ppc/syslib/m8260_setup.c                |   31 -
 ppc/syslib/m8xx_setup.c                 |   27 -
 ppc/syslib/m8xx_wdt.c                   |    8 
 ppc/syslib/m8xx_wdt.h                   |    2 
 ppc/syslib/mpc52xx_setup.c              |   15 
 ppc/syslib/ppc4xx_setup.c               |   18 
 ppc/syslib/ppc83xx_setup.c              |   28 -
 ppc/syslib/ppc83xx_setup.h              |    1 
 ppc/syslib/ppc85xx_setup.c              |   56 +-
 ppc/syslib/ppc85xx_setup.h              |    1 
 asm-ppc/bseip.h                         |   13 
 asm-ppc/ibm4xx.h                        |   17 
 asm-ppc/ibm_ocp.h                       |    3 
 asm-ppc/mpc52xx.h                       |    4 
 asm-ppc/mpc8260.h                       |    7 
 asm-ppc/mpc83xx.h                       |    5 
 asm-ppc/mpc85xx.h                       |    5 
 asm-ppc/mpc8xx.h                        |    7 

Index: arch/ppc/syslib/cpm2_common.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/syslib/cpm2_common.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/syslib/cpm2_common.c  (mode:100644)
@@ -30,6 +30,7 @@
 #include <asm/immap_cpm2.h>
 #include <asm/cpm2.h>
 #include <asm/rheap.h>
+#include <asm/firmware.h>
 
 static void cpm2_dpinit(void);
 cpm_cpm2_t	*cpmp;		/* Pointer to comm processor space */
@@ -67,7 +68,7 @@
  * Baud rate clocks are zero-based in the driver code (as that maps
  * to port numbers).  Documentation uses 1-based numbering.
  */
-#define BRG_INT_CLK	(((bd_t *)__res)->bi_brgfreq)
+#define BRG_INT_CLK	(fw_get_brgfreq())
 #define BRG_UART_CLK	(BRG_INT_CLK/16)
 
 /* This function is used by UARTS, or anything else that uses a 16x
Index: arch/ppc/syslib/m8260_pci.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/syslib/m8260_pci.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/syslib/m8260_pci.h  (mode:100644)
@@ -26,9 +26,9 @@
  */
 
 #ifndef MPC826x_PCI_SLAVE_MEM_LOCAL
-#define MPC826x_PCI_SLAVE_MEM_LOCAL	(((struct bd_info *)__res)->bi_memstart)
-#define MPC826x_PCI_SLAVE_MEM_BUS	(((struct bd_info *)__res)->bi_memstart)
-#define MPC826x_PCI_SLAVE_MEM_SIZE	(((struct bd_info *)__res)->bi_memsize)
+#define MPC826x_PCI_SLAVE_MEM_LOCAL	(fw_get_memory_start())
+#define MPC826x_PCI_SLAVE_MEM_BUS	(fw_get_memory_start())
+#define MPC826x_PCI_SLAVE_MEM_SIZE	(fw_get_memory_size())
 #endif
 
 /* 
Index: arch/ppc/syslib/m8260_setup.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/syslib/m8260_setup.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/syslib/m8260_setup.c  (mode:100644)
@@ -28,11 +28,10 @@
 #include <asm/machdep.h>
 #include <asm/bootinfo.h>
 #include <asm/time.h>
+#include <asm/firmware.h>
 
 #include "cpm2_pic.h"
 
-unsigned char __res[sizeof(bd_t)];
-
 extern void cpm2_reset(void);
 extern void m8260_find_bridges(void);
 extern void idma_pci9_init(void);
@@ -71,10 +70,9 @@
 static void __init
 m8260_calibrate_decr(void)
 {
-	bd_t *binfo = (bd_t *)__res;
 	int freq, divisor;
 
-	freq = binfo->bi_busfreq;
+	freq = fw_get_busfreq();
         divisor = 4;
         tb_ticks_per_jiffy = freq / HZ / divisor;
 	tb_to_us = mulhwu_scale_factor(freq / divisor, 1000000);
@@ -109,7 +107,7 @@
 static void
 m8260_restart(char *cmd)
 {
-	extern void m8260_gorom(bd_t *bi, uint addr);
+	extern void m8260_gorom(void *bi, uint addr);
 	uint	startaddr;
 
 	/* Most boot roms have a warmstart as the second instruction
@@ -122,7 +120,7 @@
 			startaddr = simple_strtoul(&cmd[10], NULL, 0);
 	}
 
-	m8260_gorom((void*)__pa(__res), startaddr);
+	m8260_gorom((void*)__pa(fw_get_init_data()), startaddr);
 }
 
 static void
@@ -141,9 +139,8 @@
 static int
 m8260_show_cpuinfo(struct seq_file *m)
 {
-	bd_t *bp = (bd_t *)__res;
-
-	seq_printf(m, "vendor\t\t: %s\n"
+	seq_printf(m,
+		   "vendor\t\t: %s\n"
 		   "machine\t\t: %s\n"
 		   "\n"
 		   "mem size\t\t: 0x%08x\n"
@@ -152,9 +149,13 @@
 		   "core clock\t: %u MHz\n"
 		   "CPM  clock\t: %u MHz\n"
 		   "bus  clock\t: %u MHz\n",
-		   CPUINFO_VENDOR, CPUINFO_MACHINE, bp->bi_memsize,
-		   bp->bi_baudrate, bp->bi_intfreq / 1000000,
-		   bp->bi_cpmfreq / 1000000, bp->bi_busfreq / 1000000);
+		   CPUINFO_VENDOR,
+		   CPUINFO_MACHINE,
+		   fw_get_memory_size(),
+		   fw_get_baudrate(),
+		   fw_get_intfreq() / 1000000,
+		   fw_get_cpmfreq() / 1000000,
+		   fw_get_busfreq() / 1000000);
 	return 0;
 }
 
@@ -181,9 +182,7 @@
 static unsigned long __init
 m8260_find_end_of_memory(void)
 {
-	bd_t *binfo = (bd_t *)__res;
-
-	return binfo->bi_memsize;
+	return fw_get_memory_size();
 }
 
 /* Map the IMMR, plus anything else we can cover
@@ -228,7 +227,7 @@
 	parse_bootinfo(find_bootinfo());
 
 	if ( r3 )
-		memcpy( (void *)__res,(void *)(r3+KERNELBASE), sizeof(bd_t) );
+		fw_initialize(r3);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* take care of initrd if we have one */
Index: arch/ppc/syslib/m8xx_setup.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/syslib/m8xx_setup.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/syslib/m8xx_setup.c  (mode:100644)
@@ -45,6 +45,7 @@
 #include <asm/bootinfo.h>
 #include <asm/time.h>
 #include <asm/xmon.h>
+#include <asm/firmware.h>
 
 #include "ppc8xx_pic.h"
 
@@ -52,13 +53,11 @@
 static unsigned long m8xx_get_rtc_time(void);
 void m8xx_calibrate_decr(void);
 
-unsigned char __res[sizeof(bd_t)];
-
 extern void m8xx_ide_init(void);
 
 extern unsigned long find_available_memory(void);
 extern void m8xx_cpm_reset(uint cpm_page);
-extern void m8xx_wdt_handler_install(bd_t *bp);
+extern void m8xx_wdt_handler_install(void);
 extern void rpxfb_alloc_pages(void);
 extern void cpm_interrupt_init(void);
 
@@ -144,7 +143,6 @@
  */
 void __init m8xx_calibrate_decr(void)
 {
-	bd_t	*binfo = (bd_t *)__res;
 	int freq, fp, divisor;
 
 	/* Unlock the SCCR. */
@@ -157,7 +155,7 @@
 	/* Processor frequency is MHz.
 	 * The value 'fp' is the number of decrementer ticks per second.
 	 */
-	fp = binfo->bi_intfreq / 16;
+	fp = fw_get_intfreq() / 16;
 	freq = fp*60;	/* try to make freq/1e6 an integer */
         divisor = 60;
         printk("Decrementer Frequency = %d/%d\n", freq, divisor);
@@ -209,7 +207,7 @@
 	/* Install watchdog timer handler early because it might be
 	 * already enabled by the bootloader
 	 */
-	m8xx_wdt_handler_install(binfo);
+	m8xx_wdt_handler_install();
 #endif
 }
 
@@ -266,14 +264,10 @@
 static int
 m8xx_show_percpuinfo(struct seq_file *m, int i)
 {
-	bd_t	*bp;
-
-	bp = (bd_t *)__res;
-
 	seq_printf(m, "clock\t\t: %ldMHz\n"
 		   "bus clock\t: %ldMHz\n",
-		   bp->bi_intfreq / 1000000,
-		   bp->bi_busfreq / 1000000);
+		   fw_get_intfreq() / 1000000,
+		   fw_get_busfreq() / 1000000);
 
 	return 0;
 }
@@ -332,12 +326,7 @@
 static unsigned long __init
 m8xx_find_end_of_memory(void)
 {
-	bd_t	*binfo;
-	extern unsigned char __res[];
-
-	binfo = (bd_t *)__res;
-
-	return binfo->bi_memsize;
+	return fw_get_memory_size();
 }
 
 /*
@@ -387,7 +376,7 @@
 	parse_bootinfo(find_bootinfo());
 
 	if ( r3 )
-		memcpy( (void *)__res,(void *)(r3+KERNELBASE), sizeof(bd_t) );
+		fw_initialize(r3);
 
 #ifdef CONFIG_PCI
 	m8xx_setup_pci_ptrs();
Index: arch/ppc/syslib/m8xx_wdt.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/syslib/m8xx_wdt.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/syslib/m8xx_wdt.c  (mode:100644)
@@ -44,7 +44,7 @@
 	return IRQ_HANDLED;
 }
 
-void __init m8xx_wdt_handler_install(bd_t * binfo)
+void __init m8xx_wdt_handler_install(void)
 {
 	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
 	u32 pitc;
@@ -83,9 +83,9 @@
 		pitrtclk = 8192;
 
 	if ((wdt_timeout) > (UINT_MAX / pitrtclk))
-		pitc = wdt_timeout / binfo->bi_intfreq * pitrtclk / 2;
+		pitc = wdt_timeout / fw_get_intfreq() * pitrtclk / 2;
 	else
-		pitc = pitrtclk * wdt_timeout / binfo->bi_intfreq / 2;
+		pitc = pitrtclk * wdt_timeout / fw_get_intfreq() / 2;
 
 	imap->im_sit.sit_pitc = pitc << 16;
 	imap->im_sit.sit_piscr =
@@ -97,7 +97,7 @@
 	printk(KERN_NOTICE
 	       "m8xx_wdt: keep-alive trigger installed (PITC: 0x%04X)\n", pitc);
 
-	wdt_timeout /= binfo->bi_intfreq;
+	wdt_timeout /= fw_get_intfreq();
 }
 
 int m8xx_wdt_get_timeout(void)
Index: arch/ppc/syslib/m8xx_wdt.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/syslib/m8xx_wdt.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/syslib/m8xx_wdt.h  (mode:100644)
@@ -9,7 +9,7 @@
 #ifndef _PPC_SYSLIB_M8XX_WDT_H
 #define _PPC_SYSLIB_M8XX_WDT_H
 
-extern void m8xx_wdt_handler_install(bd_t * binfo);
+extern void m8xx_wdt_handler_install(void);
 extern int m8xx_wdt_get_timeout(void);
 extern void m8xx_wdt_reset(void);
 
Index: arch/ppc/syslib/mpc52xx_setup.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/syslib/mpc52xx_setup.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/syslib/mpc52xx_setup.c  (mode:100644)
@@ -24,9 +24,8 @@
 #include <asm/mpc52xx.h>
 #include <asm/mpc52xx_psc.h>
 #include <asm/pgtable.h>
-#include <asm/ppcboot.h>
+#include <asm/firmware.h>
 
-extern bd_t __res;
 
 static int core_mult[] = {		/* CPU Frequency multiplier, taken    */
 	0,  0,  0,  10, 20, 20, 25, 45,	/* from the datasheet used to compute */
@@ -127,7 +126,7 @@
 unsigned long __init
 mpc52xx_find_end_of_memory(void)
 {
-	u32 ramsize = __res.bi_memsize;
+	u32 ramsize = fw_get_memory_size();
 
 	/*
 	 * if bootloader passed a memsize, just use it
@@ -161,7 +160,7 @@
 	int tbl_start, tbl_end;
 	unsigned int xlbfreq, cpufreq, ipbfreq, pcifreq, divisor;
 
-	xlbfreq = __res.bi_busfreq;
+	xlbfreq = fw_get_busfreq();
 	/* if bootloader didn't pass bus frequencies, calculate them */
 	if (xlbfreq == 0) {
 		/* Get RTC & Clock manager modules */
@@ -200,10 +199,10 @@
 			pcifreq = xlbfreq / 4;
 			break;
 		}
-		__res.bi_busfreq = xlbfreq;
-		__res.bi_intfreq = cpufreq;
-		__res.bi_ipbfreq = ipbfreq;
-		__res.bi_pcifreq = pcifreq;
+		fw_set_busfreq(xlbfreq);
+		fw_set_intfreq(cpufreq);
+		fw_set_ipbfreq(ipbfreq);
+		fw_set_pcifreq(pcifreq);
 
 		/* Release mapping */
 		iounmap(rtc);
Index: arch/ppc/syslib/ppc4xx_setup.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/syslib/ppc4xx_setup.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/syslib/ppc4xx_setup.c  (mode:100644)
@@ -41,6 +41,7 @@
 #include <asm/ppc4xx_pic.h>
 #include <asm/pci-bridge.h>
 #include <asm/bootinfo.h>
+#include <asm/firmware.h>
 
 #include <syslib/gen550.h>
 
@@ -52,8 +53,6 @@
 extern int wdt_enable;
 extern unsigned long wdt_period;
 
-/* Global Variables */
-bd_t __res;
 
 void __init
 ppc4xx_setup_arch(void)
@@ -81,7 +80,7 @@
 static int
 ppc4xx_show_percpuinfo(struct seq_file *m, int i)
 {
-	seq_printf(m, "clock\t\t: %ldMHz\n", (long)__res.bi_intfreq / 1000000);
+	seq_printf(m, "clock\t\t: %ldMHz\n", fw_get_intfreq() / 1000000);
 
 	return 0;
 }
@@ -93,14 +92,12 @@
 static int
 ppc4xx_show_cpuinfo(struct seq_file *m)
 {
-	bd_t *bip = &__res;
-
 	seq_printf(m, "machine\t\t: %s\n", PPC4xx_MACHINE_NAME);
 	seq_printf(m, "plb bus clock\t: %ldMHz\n",
-		   (long) bip->bi_busfreq / 1000000);
+		   (long) fw_get_busfreq() / 1000000);
 #ifdef CONFIG_PCI
 	seq_printf(m, "pci bus clock\t: %dMHz\n",
-		   bip->bi_pci_busfreq / 1000000);
+		   fw_get_pci_busfreq() / 1000000);
 #endif
 
 	return 0;
@@ -112,7 +109,7 @@
 static unsigned long __init
 ppc4xx_find_end_of_memory(void)
 {
-	return ((unsigned long) __res.bi_memsize);
+	return fw_get_memory_size();
 }
 
 void __init
@@ -169,13 +166,12 @@
 ppc4xx_calibrate_decr(void)
 {
 	unsigned int freq;
-	bd_t *bip = &__res;
 
 #if defined(CONFIG_WALNUT) || defined(CONFIG_ASH) || defined(CONFIG_SYCAMORE)
 	/* Walnut boot rom sets DCR CHCR1 (aka CPC0_CR1) bit CETE to 1 */
 	mtdcr(DCRN_CHCR1, mfdcr(DCRN_CHCR1) & ~CHR1_CETE);
 #endif
-	freq = bip->bi_tbfreq;
+	freq = fw_get_tbfreq();
 	tb_ticks_per_jiffy = freq / HZ;
 	tb_to_us = mulhwu_scale_factor(freq, 1000000);
 
@@ -238,7 +234,7 @@
 	 * residual data area.
 	 */
 	if (r3)
-		__res = *(bd_t *)(r3 + KERNELBASE);
+		fw_initialize(r3);
 
 #if defined(CONFIG_BLK_DEV_INITRD)
 	/*
Index: arch/ppc/syslib/ppc83xx_setup.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/syslib/ppc83xx_setup.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/syslib/ppc83xx_setup.c  (mode:100644)
@@ -29,20 +29,18 @@
 #include <asm/mmu.h>
 #include <asm/ppc_sys.h>
 #include <asm/kgdb.h>
+#include <asm/firmware.h>
 
 #include <syslib/ppc83xx_setup.h>
 
 phys_addr_t immrbar;
 
 /* Return the amount of memory */
+/* FIXME: ppc_md.find_of_memory() could use fw_get_memory_size() directly */
 unsigned long __init
 mpc83xx_find_end_of_memory(void)
 {
-        bd_t *binfo;
-
-        binfo = (bd_t *) __res;
-
-        return binfo->bi_memsize;
+        return fw_get_memory_size();
 }
 
 long __init
@@ -51,8 +49,7 @@
 #define SPCR_OFFS   0x00000110
 #define SPCR_TBEN   0x00400000
 
-	bd_t *binfo = (bd_t *)__res;
-	u32 *spcr = ioremap(binfo->bi_immr_base + SPCR_OFFS, 4);
+	u32 *spcr = ioremap(fw_get_immr_base() + SPCR_OFFS, 4);
 
 	*spcr |= SPCR_TBEN;
 
@@ -65,10 +62,10 @@
 void __init
 mpc83xx_calibrate_decr(void)
 {
-        bd_t *binfo = (bd_t *) __res;
         unsigned int freq, divisor;
 
-	freq = binfo->bi_busfreq;
+	freq = fw_get_busfreq();
+
 	divisor = 4;
 	tb_ticks_per_jiffy = freq / HZ / divisor;
 	tb_to_us = mulhwu_scale_factor(freq / divisor, 1000000);
@@ -82,12 +79,15 @@
 	struct uart_port serial_req;
 #endif
 	struct plat_serial8250_port *pdata;
-	bd_t *binfo = (bd_t *) __res;
+	unsigned int freq, immr_base;
+
 	pdata = (struct plat_serial8250_port *) ppc_sys_get_pdata(MPC83xx_DUART);
+	freq = fw_get_busfreq();
+	immr_base = fw_get_immr_base();
 
 	/* Setup serial port access */
-	pdata[0].uartclk = binfo->bi_busfreq;
-	pdata[0].mapbase += binfo->bi_immr_base;
+	pdata[0].uartclk = freq;
+	pdata[0].mapbase += immr_base;
 	pdata[0].membase = ioremap(pdata[0].mapbase, 0x100);
 
 #if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
@@ -100,8 +100,8 @@
 	gen550_init(0, &serial_req);
 #endif
 
-	pdata[1].uartclk = binfo->bi_busfreq;
-	pdata[1].mapbase += binfo->bi_immr_base;
+	pdata[1].uartclk = freq;
+	pdata[1].mapbase += immr_base;
 	pdata[1].membase = ioremap(pdata[1].mapbase, 0x100);
 
 #if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
Index: arch/ppc/syslib/ppc83xx_setup.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/syslib/ppc83xx_setup.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/syslib/ppc83xx_setup.h  (mode:100644)
@@ -19,7 +19,6 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
-#include <asm/ppcboot.h>
 
 extern unsigned long mpc83xx_find_end_of_memory(void) __init;
 extern long mpc83xx_time_init(void) __init;
Index: arch/ppc/syslib/ppc85xx_setup.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/syslib/ppc85xx_setup.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/syslib/ppc85xx_setup.c  (mode:100644)
@@ -30,29 +30,26 @@
 #include <asm/mmu.h>
 #include <asm/ppc_sys.h>
 #include <asm/kgdb.h>
+#include <asm/firmware.h>
 
 #include <syslib/ppc85xx_setup.h>
 
 /* Return the amount of memory */
+/* FIXME: ppc_md.find_of_memory() could use fw_get_memory_size() directly */
 unsigned long __init
 mpc85xx_find_end_of_memory(void)
 {
-        bd_t *binfo;
-
-        binfo = (bd_t *) __res;
-
-        return binfo->bi_memsize;
+        return fw_get_memory_size();
 }
 
 /* The decrementer counts at the system (internal) clock freq divided by 8 */
 void __init
 mpc85xx_calibrate_decr(void)
 {
-        bd_t *binfo = (bd_t *) __res;
         unsigned int freq, divisor;
 
-        /* get the core frequency */
-        freq = binfo->bi_busfreq;
+        /* get the bus frequency */
+        freq = fw_get_busfreq();
 
         /* The timebase is updated every 8 bus clocks, HID0[SEL_TBCLK] = 0 */
         divisor = 8;
@@ -78,12 +75,15 @@
 	struct uart_port serial_req;
 #endif
 	struct plat_serial8250_port *pdata;
-	bd_t *binfo = (bd_t *) __res;
+	unsigned int freq, immr_base;
+
 	pdata = (struct plat_serial8250_port *) ppc_sys_get_pdata(MPC85xx_DUART);
+	freq = fw_get_busfreq();
+	immr_base = fw_get_immr_base();
 
 	/* Setup serial port access */
-	pdata[0].uartclk = binfo->bi_busfreq;
-	pdata[0].mapbase += binfo->bi_immr_base;
+	pdata[0].uartclk = freq;
+	pdata[0].mapbase += immr_base;
 	pdata[0].membase = ioremap(pdata[0].mapbase, MPC85xx_UART0_SIZE);
 
 #if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
@@ -96,8 +96,8 @@
 	gen550_init(0, &serial_req);
 #endif
 
-	pdata[1].uartclk = binfo->bi_busfreq;
-	pdata[1].mapbase += binfo->bi_immr_base;
+	pdata[1].uartclk = freq;
+	pdata[1].mapbase += immr_base;
 	pdata[1].membase = ioremap(pdata[1].mapbase, MPC85xx_UART0_SIZE);
 
 #if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
@@ -138,13 +138,12 @@
 	volatile struct ccsr_pci *pci;
 	volatile struct ccsr_guts *guts;
 	unsigned short temps;
-	bd_t *binfo = (bd_t *) __res;
+	unsigned int immr_base;
 
-	pci = ioremap(binfo->bi_immr_base + MPC85xx_PCI1_OFFSET,
-		    MPC85xx_PCI1_SIZE);
+	immr_base = fw_get_immr_base();
 
-	guts = ioremap(binfo->bi_immr_base + MPC85xx_GUTS_OFFSET,
-		    MPC85xx_GUTS_SIZE);
+	pci = ioremap(immr_base + MPC85xx_PCI1_OFFSET, MPC85xx_PCI1_SIZE);
+	guts = ioremap(immr_base + MPC85xx_GUTS_OFFSET, MPC85xx_GUTS_SIZE);
 
 	early_read_config_word(hose, 0, 0, PCI_COMMAND, &temps);
 	temps |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY;
@@ -201,10 +200,11 @@
 {
 	volatile struct ccsr_pci *pci;
 	unsigned short temps;
-	bd_t *binfo = (bd_t *) __res;
+	unsigned int immr_base;
 
-	pci = ioremap(binfo->bi_immr_base + MPC85xx_PCI2_OFFSET,
-		    MPC85xx_PCI2_SIZE);
+	immr_base = fw_get_immr_base();
+
+	pci = ioremap(immr_base + MPC85xx_PCI2_OFFSET, MPC85xx_PCI2_SIZE);
 
 	early_read_config_word(hose, hose->bus_offset, 0, PCI_COMMAND, &temps);
 	temps |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY;
@@ -248,11 +248,13 @@
 void __init
 mpc85xx_setup_hose(void)
 {
+	unsigned int immr_base;
 	struct pci_controller *hose_a;
 #ifdef CONFIG_85xx_PCI2
 	struct pci_controller *hose_b;
 #endif
-	bd_t *binfo = (bd_t *) __res;
+
+	immr_base = fw_get_immr_base();
 
 	hose_a = pcibios_alloc_controller();
 
@@ -266,8 +268,9 @@
 	hose_a->bus_offset = 0;
 	hose_a->last_busno = 0xff;
 
-	setup_indirect_pci(hose_a, binfo->bi_immr_base + PCI1_CFG_ADDR_OFFSET,
-			   binfo->bi_immr_base + PCI1_CFG_DATA_OFFSET);
+	setup_indirect_pci(hose_a,
+			   immr_base + PCI1_CFG_ADDR_OFFSET,
+			   immr_base + PCI1_CFG_DATA_OFFSET);
 	hose_a->set_cfg_type = 1;
 
 	mpc85xx_setup_pci1(hose_a);
@@ -314,8 +317,9 @@
 	hose_b->first_busno = hose_a->last_busno + 1;
 	hose_b->last_busno = 0xff;
 
-	setup_indirect_pci(hose_b, binfo->bi_immr_base + PCI2_CFG_ADDR_OFFSET,
-			   binfo->bi_immr_base + PCI2_CFG_DATA_OFFSET);
+	setup_indirect_pci(hose_b,
+			   immr_base + PCI2_CFG_ADDR_OFFSET,
+			   immr_base + PCI2_CFG_DATA_OFFSET);
 	hose_b->set_cfg_type = 1;
 
 	mpc85xx_setup_pci2(hose_b);
Index: arch/ppc/syslib/ppc85xx_setup.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/syslib/ppc85xx_setup.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/syslib/ppc85xx_setup.h  (mode:100644)
@@ -19,7 +19,6 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
-#include <asm/ppcboot.h>
 
 extern unsigned long mpc85xx_find_end_of_memory(void) __init;
 extern void mpc85xx_calibrate_decr(void) __init;
Index: include/asm-ppc/bseip.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/include/asm-ppc/bseip.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/include/asm-ppc/bseip.h  (mode:100644)
@@ -8,19 +8,6 @@
 #define __MACH_BSEIP_DEFS
 
 #ifndef __ASSEMBLY__
-/* A Board Information structure that is given to a program when
- * prom starts it up.
- */
-typedef struct bd_info {
-	unsigned int	bi_memstart;	/* Memory start address */
-	unsigned int	bi_memsize;	/* Memory (end) size in bytes */
-	unsigned int	bi_intfreq;	/* Internal Freq, in Hz */
-	unsigned int	bi_busfreq;	/* Bus Freq, in Hz */
-	unsigned char	bi_enetaddr[6];
-	unsigned int	bi_baudrate;
-} bd_t;
-
-extern bd_t m8xx_board_info;
 
 /* Memory map is configured by the PROM startup.
  * All we need to get started is the IMMR.
Index: include/asm-ppc/ibm4xx.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/include/asm-ppc/ibm4xx.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/include/asm-ppc/ibm4xx.h  (mode:100644)
@@ -65,14 +65,6 @@
 
 #ifndef __ASSEMBLY__
 
-#ifdef CONFIG_40x
-/*
- * The "residual" board information structure the boot loader passes
- * into the kernel.
- */
-extern bd_t __res;
-#endif
-
 void ppc4xx_setup_arch(void);
 void ppc4xx_map_io(void);
 void ppc4xx_init_IRQ(void);
@@ -109,15 +101,6 @@
 #include <platforms/4xx/ocotea.h>
 #endif
 
-#ifndef __ASSEMBLY__
-#ifdef CONFIG_40x
-/*
- * The "residual" board information structure the boot loader passes
- * into the kernel.
- */
-extern bd_t __res;
-#endif
-#endif
 #endif /* CONFIG_40x */
 
 #endif /* __ASM_IBM4XX_H__ */
Index: include/asm-ppc/ibm_ocp.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/include/asm-ppc/ibm_ocp.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/include/asm-ppc/ibm_ocp.h  (mode:100644)
@@ -91,6 +91,7 @@
 }
 
 #ifdef CONFIG_40x
+#include "asm/firmware.h"
 /*
  * Helper function to copy MAC addresses from the bd_t to OCP EMAC
  * additions.
@@ -106,7 +107,7 @@
 	for (i=start; i<=end; i++) {
 		def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, i);
 		memcpy(((struct ocp_func_emac_data *)def->additions)->mac_addr,
-				&__res.bi_enetaddr[i],
+				fw_get_enetaddr(i),
 				6);
 	}
 }
Index: include/asm-ppc/mpc52xx.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/include/asm-ppc/mpc52xx.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/include/asm-ppc/mpc52xx.h  (mode:100644)
@@ -22,7 +22,6 @@
 #define __ASM_MPC52xx_H__
 
 #ifndef __ASSEMBLY__
-#include <asm/ppcboot.h>
 #include <asm/types.h>
 
 struct pt_regs;
@@ -433,9 +432,6 @@
 /* Platform configuration                                                    */
 /* ========================================================================= */
 
-/* The U-Boot platform information struct */
-extern bd_t __res;
-
 /* Platform options */
 #if defined(CONFIG_LITE5200)
 #include <platforms/lite5200.h>
Index: include/asm-ppc/mpc8260.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/include/asm-ppc/mpc8260.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/include/asm-ppc/mpc8260.h  (mode:100644)
@@ -67,13 +67,6 @@
 #define IO_VIRT_ADDR	IO_PHYS_ADDR
 #endif
 
-#ifndef __ASSEMBLY__
-/* The "residual" data board information structure the boot loader
- * hands to us.
- */
-extern unsigned char __res[];
-#endif
-
 #endif /* CONFIG_8260 */
 #endif /* !__ASM_PPC_MPC8260_H__ */
 #endif /* __KERNEL__ */
Index: include/asm-ppc/mpc83xx.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/include/asm-ppc/mpc83xx.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/include/asm-ppc/mpc83xx.h  (mode:100644)
@@ -34,11 +34,6 @@
 #define PCI_DRAM_OFFSET 0
 #endif
 
-/*
- * The "residual" board information structure the boot loader passes
- * into the kernel.
- */
-extern unsigned char __res[];
 
 /* Internal IRQs on MPC83xx OpenPIC */
 /* Not all of these exist on all MPC83xx implementations */
Index: include/asm-ppc/mpc85xx.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/include/asm-ppc/mpc85xx.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/include/asm-ppc/mpc85xx.h  (mode:100644)
@@ -46,11 +46,6 @@
 #define PCI_DRAM_OFFSET 0
 #endif
 
-/*
- * The "residual" board information structure the boot loader passes
- * into the kernel.
- */
-extern unsigned char __res[];
 
 /* Offset from CCSRBAR */
 #define MPC85xx_CPM_OFFSET	(0x80000)
Index: include/asm-ppc/mpc8xx.h
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/include/asm-ppc/mpc8xx.h  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/include/asm-ppc/mpc8xx.h  (mode:100644)
@@ -90,14 +90,9 @@
 #endif
 
 #ifndef __ASSEMBLY__
-/* The "residual" data board information structure the boot loader
- * hands to us.
- */
-extern unsigned char __res[];
-
 struct pt_regs;
-
 #endif /* !__ASSEMBLY__ */
+
 #endif /* CONFIG_8xx */
 #endif /* __CONFIG_8xx_DEFS */
 #endif /* __KERNEL__ */
