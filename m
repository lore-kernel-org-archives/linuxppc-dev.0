Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id 9688E2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Oct 2004 11:07:06 +1000 (EST)
Date: Wed, 6 Oct 2004 18:07:00 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20041006180700.A31966@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Move some common PPC44x code to ibm44x_common.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is first part (trivial one) of the ebony.c/ocotea.c cleanup, 
which moves common stuff to ibm44x_common.c.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== arch/ppc/platforms/4xx/ebony.c 1.4 vs edited =====
--- 1.4/arch/ppc/platforms/4xx/ebony.c	2004-08-16 09:04:08 -07:00
+++ edited/arch/ppc/platforms/4xx/ebony.c	2004-10-04 18:18:09 -07:00
@@ -4,9 +4,11 @@
  * Ebony board specific routines
  *
  * Matt Porter <mporter@mvista.com>
- *
  * Copyright 2002 MontaVista Software Inc.
  *
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ * Copyright (c) 2003, 2004 Zultys Technologies
+ *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
@@ -118,7 +120,7 @@
 	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* 63: EMAC 1 WOL */
 };
 
-extern void abort(void);
+static struct ibm44x_clocks clocks __initdata;
 
 static void __init
 ebony_calibrate_decr(void)
@@ -142,19 +144,8 @@
 			freq = EBONY_440GP_RC_SYSCLK;
 			break;
 	}
-
-	tb_ticks_per_jiffy = freq / HZ;
-	tb_to_us = mulhwu_scale_factor(freq, 1000000);
-
-	/* Set the time base to zero */
-	mtspr(SPRN_TBWL, 0);
-	mtspr(SPRN_TBWU, 0);
-
-	/* Clear any pending timer interrupts */
-	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
-
-	/* Enable decrementer interrupt */
-	mtspr(SPRN_TCR, TCR_DIE);
+	
+	ibm44x_calibrate_decr(freq);
 }
 
 static int
@@ -283,7 +274,7 @@
 	memset(&port, 0, sizeof(port));
 	port.membase = ioremap64(PPC440GP_UART0_ADDR, 8);
 	port.irq = 0;
-	port.uartclk = BASE_BAUD * 16;
+	port.uartclk = clocks.uart0;
 	port.regshift = 0;
 	port.iotype = SERIAL_IO_MEM;
 	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
@@ -306,7 +297,6 @@
 ebony_setup_arch(void)
 {
 	unsigned char * vpd_base;
-	struct ibm44x_clocks clocks;
 	struct ocp_def *def;
 	struct ocp_func_emac_data *emacdata;
 
@@ -370,152 +360,17 @@
 	printk("IBM Ebony port (MontaVista Software, Inc. (source@mvista.com))\n");
 }
 
-static void
-ebony_restart(char *cmd)
-{
-	local_irq_disable();
-	abort();
-}
-
-static void
-ebony_power_off(void)
-{
-	local_irq_disable();
-	for(;;);
-}
-
-static void
-ebony_halt(void)
-{
-	local_irq_disable();
-	for(;;);
-}
-
-/*
- * Read the 440GP memory controller to get size of system memory.
- */
-static unsigned long __init
-ebony_find_end_of_memory(void)
-{
-	u32 i, bank_config;
-	u32 mem_size = 0;
-
-	for (i=0; i<4; i++)
-	{
-		switch (i)
-		{
-			case 0:
-				mtdcr(DCRN_SDRAM0_CFGADDR, SDRAM0_B0CR);
-				break;
-			case 1:
-				mtdcr(DCRN_SDRAM0_CFGADDR, SDRAM0_B1CR);
-				break;
-			case 2:
-				mtdcr(DCRN_SDRAM0_CFGADDR, SDRAM0_B2CR);
-				break;
-			case 3:
-				mtdcr(DCRN_SDRAM0_CFGADDR, SDRAM0_B3CR);
-				break;
-		}
-
-		bank_config = mfdcr(DCRN_SDRAM0_CFGDATA);
-
-		if (!(bank_config & SDRAM_CONFIG_BANK_ENABLE))
-			continue;
-		switch (SDRAM_CONFIG_BANK_SIZE(bank_config))
-		{
-			case SDRAM_CONFIG_SIZE_8M:
-				mem_size += PPC44x_MEM_SIZE_8M;
-				break;
-			case SDRAM_CONFIG_SIZE_16M:
-				mem_size += PPC44x_MEM_SIZE_16M;
-				break;
-			case SDRAM_CONFIG_SIZE_32M:
-				mem_size += PPC44x_MEM_SIZE_32M;
-				break;
-			case SDRAM_CONFIG_SIZE_64M:
-				mem_size += PPC44x_MEM_SIZE_64M;
-				break;
-			case SDRAM_CONFIG_SIZE_128M:
-				mem_size += PPC44x_MEM_SIZE_128M;
-				break;
-			case SDRAM_CONFIG_SIZE_256M:
-				mem_size += PPC44x_MEM_SIZE_256M;
-				break;
-			case SDRAM_CONFIG_SIZE_512M:
-				mem_size += PPC44x_MEM_SIZE_512M;
-				break;
-		}
-	}
-	return mem_size;
-}
-
-static void __init
-ebony_init_irq(void)
-{
-	int i;
-
-	ppc4xx_pic_init();
-
-	for (i = 0; i < NR_IRQS; i++)
-		irq_desc[i].handler = ppc4xx_pic;
-}
-
-#ifdef CONFIG_SERIAL_TEXT_DEBUG
-#include <linux/serialP.h>
-#include <linux/serial_reg.h>
-#include <asm/serial.h>
-
-static struct serial_state rs_table[RS_TABLE_SIZE] = {
-	SERIAL_PORT_DFNS	/* Defined in <asm/serial.h> */
-};
-
-static void
-ebony_progress(char *s, unsigned short hex)
-{
-	volatile char c;
-	volatile unsigned long com_port;
-	u16 shift;
-
-	com_port = (unsigned long)rs_table[0].iomem_base;
-	shift = rs_table[0].iomem_reg_shift;
-
-	while ((c = *s++) != 0) {
-		while ((*((volatile unsigned char *)com_port +
-				(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-			;
-		*(volatile unsigned char *)com_port = c;
-
-	}
-
-	/* Send LF/CR to pretty up output */
-	while ((*((volatile unsigned char *)com_port +
-		(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-		;
-	*(volatile unsigned char *)com_port = '\r';
-	while ((*((volatile unsigned char *)com_port +
-		(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-		;
-	*(volatile unsigned char *)com_port = '\n';
-}
-#endif /* CONFIG_SERIAL_TEXT_DEBUG */
-
 void __init platform_init(unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, unsigned long r7)
 {
 	parse_bootinfo((struct bi_record *) (r3 + KERNELBASE));
+	
+	ibm44x_platform_init();
 
 	ppc_md.setup_arch = ebony_setup_arch;
 	ppc_md.show_cpuinfo = ebony_show_cpuinfo;
-	ppc_md.init_IRQ = ebony_init_irq;
 	ppc_md.get_irq = NULL;		/* Set in ppc4xx_pic_init() */
 
-	ppc_md.find_end_of_memory = ebony_find_end_of_memory;
-
-	ppc_md.restart = ebony_restart;
-	ppc_md.power_off = ebony_power_off;
-	ppc_md.halt = ebony_halt;
-
 	ppc_md.calibrate_decr = ebony_calibrate_decr;
 	ppc_md.time_init = todc_time_init;
 	ppc_md.set_rtc_time = todc_set_rtc_time;
@@ -524,9 +379,6 @@
 	ppc_md.nvram_read_val = todc_direct_read_val;
 	ppc_md.nvram_write_val = todc_direct_write_val;
 
-#ifdef CONFIG_SERIAL_TEXT_DEBUG
-	ppc_md.progress = ebony_progress;
-#endif /* CONFIG_SERIAL_TEXT_DEBUG */
 #ifdef CONFIG_KGDB
 	ppc_md.early_serial_map = ebony_early_serial_map;
 #endif
===== arch/ppc/platforms/4xx/ocotea.c 1.5 vs edited =====
--- 1.5/arch/ppc/platforms/4xx/ocotea.c	2004-10-04 17:51:42 -07:00
+++ edited/arch/ppc/platforms/4xx/ocotea.c	2004-10-04 18:36:10 -07:00
@@ -58,39 +58,21 @@
  */
 #include "../../../../drivers/net/ibm_emac/ibm_emac_phy.h"
 
-extern void abort(void);
 bd_t __res;
 
-static struct ibm44x_clocks clocks;
-
-static int __init
-ocotea_get_dec_freq(void)
-{
-	if (mfspr(SPRN_CCR1) & CCR1_TCS)
-		return OCOTEA_TMR_CLK;
-	else
-		return clocks.cpu;
-}
+static struct ibm44x_clocks clocks __initdata;
 
 static void __init
 ocotea_calibrate_decr(void)
 {
 	unsigned int freq;
-
-	freq = ocotea_get_dec_freq();
-
-	tb_ticks_per_jiffy = freq / HZ;
-	tb_to_us = mulhwu_scale_factor(freq, 1000000);
-
-	/* Set the time base to zero */
-	mtspr(SPRN_TBWL, 0);
-	mtspr(SPRN_TBWU, 0);
-
-	/* Clear any pending timer interrupts */
-	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
-
-	/* Enable decrementer interrupt */
-	mtspr(SPRN_TCR, TCR_DIE);
+	
+	if (mfspr(SPRN_CCR1) & CCR1_TCS)
+		freq = OCOTEA_TMR_CLK;
+	else
+		freq = clocks.cpu;
+		
+	ibm44x_calibrate_decr(freq);
 }
 
 static int
@@ -101,6 +83,7 @@
 
 	return 0;
 }
+
 static inline int
 ocotea_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
 {
@@ -344,135 +327,6 @@
 	printk("IBM Ocotea port (MontaVista Software, Inc. <source@mvista.com>)\n");
 }
 
-static void
-ocotea_restart(char *cmd)
-{
-	local_irq_disable();
-	abort();
-}
-
-static void
-ocotea_power_off(void)
-{
-	local_irq_disable();
-	for(;;);
-}
-
-static void
-ocotea_halt(void)
-{
-	local_irq_disable();
-	for(;;);
-}
-
-/*
- * Read the 440GX memory controller to get size of system memory.
- */
-static unsigned long __init
-ocotea_find_end_of_memory(void)
-{
-	u32 i, bank_config;
-	u32 mem_size = 0;
-
-	for (i=0; i<4; i++)
-	{
-		switch (i)
-		{
-			case 0:
-				mtdcr(DCRN_SDRAM0_CFGADDR, SDRAM0_B0CR);
-				break;
-			case 1:
-				mtdcr(DCRN_SDRAM0_CFGADDR, SDRAM0_B1CR);
-				break;
-			case 2:
-				mtdcr(DCRN_SDRAM0_CFGADDR, SDRAM0_B2CR);
-				break;
-			case 3:
-				mtdcr(DCRN_SDRAM0_CFGADDR, SDRAM0_B3CR);
-				break;
-		}
-
-		bank_config = mfdcr(DCRN_SDRAM0_CFGDATA);
-
-		if (!(bank_config & SDRAM_CONFIG_BANK_ENABLE))
-			continue;
-		switch (SDRAM_CONFIG_BANK_SIZE(bank_config))
-		{
-			case SDRAM_CONFIG_SIZE_8M:
-				mem_size += PPC44x_MEM_SIZE_8M;
-				break;
-			case SDRAM_CONFIG_SIZE_16M:
-				mem_size += PPC44x_MEM_SIZE_16M;
-				break;
-			case SDRAM_CONFIG_SIZE_32M:
-				mem_size += PPC44x_MEM_SIZE_32M;
-				break;
-			case SDRAM_CONFIG_SIZE_64M:
-				mem_size += PPC44x_MEM_SIZE_64M;
-				break;
-			case SDRAM_CONFIG_SIZE_128M:
-				mem_size += PPC44x_MEM_SIZE_128M;
-				break;
-			case SDRAM_CONFIG_SIZE_256M:
-				mem_size += PPC44x_MEM_SIZE_256M;
-				break;
-			case SDRAM_CONFIG_SIZE_512M:
-				mem_size += PPC44x_MEM_SIZE_512M;
-				break;
-		}
-	}
-	return mem_size;
-}
-
-static void __init
-ocotea_init_irq(void)
-{
-	int i;
-
-	ppc4xx_pic_init();
-
-	for (i = 0; i < NR_IRQS; i++)
-		irq_desc[i].handler = ppc4xx_pic;
-}
-
-#ifdef CONFIG_SERIAL_TEXT_DEBUG
-#include <linux/serialP.h>
-#include <linux/serial_reg.h>
-#include <asm/serial.h>
-struct serial_state rs_table[RS_TABLE_SIZE] = {
-	SERIAL_PORT_DFNS	/* Defined in <asm/serial.h> */
-};
-
-static void
-ocotea_progress(char *s, unsigned short hex)
-{
-	volatile char c;
-	volatile unsigned long com_port;
-	u16 shift;
-
-	com_port = (unsigned long)rs_table[0].iomem_base;
-	shift = rs_table[0].iomem_reg_shift;
-
-	while ((c = *s++) != 0) {
-		while ((*((volatile unsigned char *)com_port +
-				(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-			;
-		*(volatile unsigned char *)com_port = c;
-
-	}
-
-	/* Send LF/CR to pretty up output */
-	while ((*((volatile unsigned char *)com_port +
-		(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-		;
-	*(volatile unsigned char *)com_port = '\r';
-	while ((*((volatile unsigned char *)com_port +
-		(UART_LSR << shift)) & UART_LSR_THRE) == 0)
-		;
-	*(volatile unsigned char *)com_port = '\n';
-}
-#endif /* CONFIG_SERIAL_TEXT_DEBUG */
-
 void __init platform_init(unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, unsigned long r7)
 {
@@ -487,18 +341,13 @@
 
 	/* Disable L2-Cache due to hardware issues */
 	ibm440gx_l2c_disable();
+	
+	ibm44x_platform_init();
 
 	ppc_md.setup_arch = ocotea_setup_arch;
 	ppc_md.show_cpuinfo = ocotea_show_cpuinfo;
-	ppc_md.init_IRQ = ocotea_init_irq;
 	ppc_md.get_irq = NULL;		/* Set in ppc4xx_pic_init() */
 
-	ppc_md.find_end_of_memory = ocotea_find_end_of_memory;
-
-	ppc_md.restart = ocotea_restart;
-	ppc_md.power_off = ocotea_power_off;
-	ppc_md.halt = ocotea_halt;
-
 	ppc_md.calibrate_decr = ocotea_calibrate_decr;
 	ppc_md.time_init = todc_time_init;
 	ppc_md.set_rtc_time = todc_set_rtc_time;
@@ -507,9 +356,6 @@
 	ppc_md.nvram_read_val = todc_direct_read_val;
 	ppc_md.nvram_write_val = todc_direct_write_val;
 
-#ifdef CONFIG_SERIAL_TEXT_DEBUG
-	ppc_md.progress = ocotea_progress;
-#endif /* CONFIG_SERIAL_TEXT_DEBUG */
 #ifdef CONFIG_KGDB
 	ppc_md.early_serial_map = ocotea_early_serial_map;
 #endif
===== arch/ppc/syslib/ibm44x_common.c 1.1 vs edited =====
--- 1.1/arch/ppc/syslib/ibm44x_common.c	2003-09-03 02:15:10 -07:00
+++ edited/arch/ppc/syslib/ibm44x_common.c	2004-10-04 18:00:08 -07:00
@@ -6,6 +6,9 @@
  * Matt Porter <mporter@mvista.com>
  * Copyright 2002-2003 MontaVista Software Inc.
  *
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ * Copyright (c) 2003, 2004 Zultys Technologies
+ *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
@@ -14,8 +17,14 @@
  */
 #include <linux/config.h>
 #include <linux/types.h>
+#include <linux/serial.h>
+
+#include <asm/param.h>
 #include <asm/ibm44x.h>
 #include <asm/mmu.h>
+#include <asm/machdep.h>
+#include <asm/time.h>
+#include <asm/ppc4xx_pic.h>
 
 phys_addr_t fixup_bigphys_addr(phys_addr_t addr, phys_addr_t size)
 {
@@ -35,3 +44,159 @@
 
 	return (page_4gb | addr);
 };
+
+void __init ibm44x_calibrate_decr(unsigned int freq)
+{
+	tb_ticks_per_jiffy = freq / HZ;
+	tb_to_us = mulhwu_scale_factor(freq, 1000000);
+
+	/* Set the time base to zero */
+	mtspr(SPRN_TBWL, 0);
+	mtspr(SPRN_TBWU, 0);
+
+	/* Clear any pending timer interrupts */
+	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
+
+	/* Enable decrementer interrupt */
+	mtspr(SPRN_TCR, TCR_DIE);
+}
+
+extern void abort(void);
+
+static void ibm44x_restart(char *cmd)
+{
+	local_irq_disable();
+	abort();
+}
+
+static void ibm44x_power_off(void)
+{
+	local_irq_disable();
+	for(;;);
+}
+
+static void ibm44x_halt(void)
+{
+	local_irq_disable();
+	for(;;);
+}
+
+/*
+ * Read the 44x memory controller to get size of system memory.
+ */
+static unsigned long __init ibm44x_find_end_of_memory(void)
+{
+	u32 i, bank_config;
+	u32 mem_size = 0;
+
+	for (i=0; i<4; i++)
+	{
+		switch (i)
+		{
+			case 0:
+				mtdcr(DCRN_SDRAM0_CFGADDR, SDRAM0_B0CR);
+				break;
+			case 1:
+				mtdcr(DCRN_SDRAM0_CFGADDR, SDRAM0_B1CR);
+				break;
+			case 2:
+				mtdcr(DCRN_SDRAM0_CFGADDR, SDRAM0_B2CR);
+				break;
+			case 3:
+				mtdcr(DCRN_SDRAM0_CFGADDR, SDRAM0_B3CR);
+				break;
+		}
+
+		bank_config = mfdcr(DCRN_SDRAM0_CFGDATA);
+
+		if (!(bank_config & SDRAM_CONFIG_BANK_ENABLE))
+			continue;
+		switch (SDRAM_CONFIG_BANK_SIZE(bank_config))
+		{
+			case SDRAM_CONFIG_SIZE_8M:
+				mem_size += PPC44x_MEM_SIZE_8M;
+				break;
+			case SDRAM_CONFIG_SIZE_16M:
+				mem_size += PPC44x_MEM_SIZE_16M;
+				break;
+			case SDRAM_CONFIG_SIZE_32M:
+				mem_size += PPC44x_MEM_SIZE_32M;
+				break;
+			case SDRAM_CONFIG_SIZE_64M:
+				mem_size += PPC44x_MEM_SIZE_64M;
+				break;
+			case SDRAM_CONFIG_SIZE_128M:
+				mem_size += PPC44x_MEM_SIZE_128M;
+				break;
+			case SDRAM_CONFIG_SIZE_256M:
+				mem_size += PPC44x_MEM_SIZE_256M;
+				break;
+			case SDRAM_CONFIG_SIZE_512M:
+				mem_size += PPC44x_MEM_SIZE_512M;
+				break;
+		}
+	}
+	return mem_size;
+}
+
+static void __init ibm44x_init_irq(void)
+{
+	int i;
+
+	ppc4xx_pic_init();
+
+	for (i = 0; i < NR_IRQS; i++)
+		irq_desc[i].handler = ppc4xx_pic;
+}
+
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+#include <linux/serialP.h>
+#include <linux/serial_reg.h>
+#include <asm/serial.h>
+
+static struct serial_state rs_table[RS_TABLE_SIZE] = {
+	SERIAL_PORT_DFNS	/* Defined in <asm/serial.h> */
+};
+
+static void ibm44x_progress(char *s, unsigned short hex)
+{
+	volatile char c;
+	volatile unsigned long com_port;
+	u16 shift;
+
+	com_port = (unsigned long)rs_table[0].iomem_base;
+	shift = rs_table[0].iomem_reg_shift;
+
+	while ((c = *s++) != 0) {
+		while ((*((volatile unsigned char *)com_port +
+				(UART_LSR << shift)) & UART_LSR_THRE) == 0)
+			;
+		*(volatile unsigned char *)com_port = c;
+
+	}
+
+	/* Send LF/CR to pretty up output */
+	while ((*((volatile unsigned char *)com_port +
+		(UART_LSR << shift)) & UART_LSR_THRE) == 0)
+		;
+	*(volatile unsigned char *)com_port = '\r';
+	while ((*((volatile unsigned char *)com_port +
+		(UART_LSR << shift)) & UART_LSR_THRE) == 0)
+		;
+	*(volatile unsigned char *)com_port = '\n';
+}
+#endif /* CONFIG_SERIAL_TEXT_DEBUG */
+
+void __init ibm44x_platform_init(void)
+{
+	ppc_md.init_IRQ = ibm44x_init_irq;
+	ppc_md.find_end_of_memory = ibm44x_find_end_of_memory;
+	ppc_md.restart = ibm44x_restart;
+	ppc_md.power_off = ibm44x_power_off;
+	ppc_md.halt = ibm44x_halt;
+
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+	ppc_md.progress = ibm44x_progress;
+#endif /* CONFIG_SERIAL_TEXT_DEBUG */
+}
+
===== arch/ppc/syslib/ibm44x_common.h 1.1 vs edited =====
--- 1.1/arch/ppc/syslib/ibm44x_common.h	2004-05-14 19:00:24 -07:00
+++ edited/arch/ppc/syslib/ibm44x_common.h	2004-10-04 17:57:29 -07:00
@@ -4,7 +4,7 @@
  * PPC44x system library
  *
  * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
- * Copyright (c) 2003 Zultys Technologies
+ * Copyright (c) 2003, 2004 Zultys Technologies
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -30,6 +30,12 @@
 	unsigned int uart0;
 	unsigned int uart1;
 };
+
+/* common 44x platform init */
+void ibm44x_platform_init(void) __init;
+
+/* initialize decrementer and tick-related variables */
+void ibm44x_calibrate_decr(unsigned int freq) __init;
 
 #endif /* __ASSEMBLY__ */
 #endif /* __PPC_SYSLIB_IBM44x_COMMON_H */
