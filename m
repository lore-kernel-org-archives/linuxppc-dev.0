Return-Path: <galak@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 8B22B67A7B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Mar 2005 15:31:44 +1100 (EST)
Date: Wed, 2 Mar 2005 22:31:39 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: akpm@osdl.org
Message-ID: <Pine.LNX.4.61.0503022227000.28697@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: Add support to use the DS1553 RTC/NVRAM on MPC8555
 CDS system
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew,
                
This patch makes the MPC8555 CDS system utilize the DS1553 RTC/NVRAM.
                
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-03-02 22:11:56 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-03-02 22:11:56 -06:00
@@ -39,6 +39,7 @@
 #include <asm/page.h>
 #include <asm/atomic.h>
 #include <asm/time.h>
+#include <asm/todc.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/prom.h>
@@ -304,6 +305,8 @@
 }
 #endif /* CONFIG_PCI */
 
+TODC_ALLOC();
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -329,6 +332,13 @@
 	cds_pci_slot = ((cadmus[CM_CSR] >> 6) & 0x3) + 1;
 	printk("CDS Version = %x in PCI slot %d\n", cadmus[CM_VER], cds_pci_slot);
 
+	/* Setup TODC access */
+	TODC_INIT(TODC_TYPE_DS1743,
+			0,
+			0,
+			ioremap(CDS_RTC_ADDR, CDS_RTC_SIZE),
+			8);
+
 	/* Set loops_per_jiffy to a half-way reasonable value,
 	   for use until calibrate_delay gets called. */
 	loops_per_jiffy = freq / HZ;
@@ -453,10 +463,14 @@
 
 	ppc_md.find_end_of_memory = mpc85xx_find_end_of_memory;
 
-	ppc_md.time_init = NULL;
-	ppc_md.set_rtc_time = NULL;
-	ppc_md.get_rtc_time = NULL;
 	ppc_md.calibrate_decr = mpc85xx_calibrate_decr;
+
+	ppc_md.time_init = todc_time_init;
+	ppc_md.set_rtc_time = todc_set_rtc_time;
+	ppc_md.get_rtc_time = todc_get_rtc_time;
+
+	ppc_md.nvram_read_val = todc_direct_read_val;
+	ppc_md.nvram_write_val = todc_direct_write_val;
 
 #if defined(CONFIG_SERIAL_8250) && defined(CONFIG_SERIAL_TEXT_DEBUG)
 	ppc_md.progress = gen550_progress;
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_cds_common.h b/arch/ppc/platforms/85xx/mpc85xx_cds_common.h
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.h	2005-03-02 22:11:56 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.h	2005-03-02 22:11:56 -06:00
@@ -33,6 +33,10 @@
 #define CM_CSR	(1)
 #define CM_RST	(2)
 
+/* CDS NVRAM/RTC */
+#define CDS_RTC_ADDR	(0xf8000000)
+#define CDS_RTC_SIZE	(8 * 1024)
+
 /* PCI config */
 #define PCI1_CFG_ADDR_OFFSET	(0x8000)
 #define PCI1_CFG_DATA_OFFSET	(0x8004)
diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	2005-03-02 22:11:56 -06:00
+++ b/arch/ppc/syslib/Makefile	2005-03-02 22:11:56 -06:00
@@ -99,4 +99,5 @@
 ifeq ($(CONFIG_85xx),y)
 obj-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o
 endif
+obj-$(CONFIG_MPC8555_CDS)	+= todc_time.o
 obj-$(CONFIG_PPC_MPC52xx)	+= mpc52xx_setup.o mpc52xx_pic.o
