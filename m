Return-Path: <vbordug@ru.mvista.com>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C684679FC
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 30 Apr 2006 03:14:29 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH] ppc32 CPM_UART: fixes and improvements
Date: Sat, 29 Apr 2006 21:14:17 +0400
Message-Id: <20060429171417.6922.88480.stgit@vitb.ru.mvista.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


A number of small issues are fixed, and added the header file, missed from the
original series. With this, driver should be pretty stable as tested among
both platform-device-driven and "old way" boards. Also added missing GPL
statement , and updated year field on existing ones to reflect 
code update.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/ppc/platforms/mpc866ads_setup.c    |    2 +
 drivers/serial/cpm_uart/cpm_uart.h      |   19 +++++++---
 drivers/serial/cpm_uart/cpm_uart_core.c |   31 +++++++++++++---
 drivers/serial/cpm_uart/cpm_uart_cpm1.c |    2 +
 drivers/serial/cpm_uart/cpm_uart_cpm2.c |    2 +
 include/linux/fs_uart_pd.h              |   60 +++++++++++++++++++++++++++++++
 6 files changed, 104 insertions(+), 12 deletions(-)

diff --git a/arch/ppc/platforms/mpc866ads_setup.c b/arch/ppc/platforms/mpc866ads_setup.c
index 6ce3b84..d919dab 100644
--- a/arch/ppc/platforms/mpc866ads_setup.c
+++ b/arch/ppc/platforms/mpc866ads_setup.c
@@ -378,7 +378,7 @@ int __init mpc866ads_init(void)
 	ppc_sys_device_setfunc(MPC8xx_CPM_SMC1, PPC_SYS_FUNC_UART);
 #endif
 
-#ifdef CONFIG_SERIAL_CPM_SMCer
+#ifdef CONFIG_SERIAL_CPM_SMC
 	ppc_sys_device_enable(MPC8xx_CPM_SMC2);
 	ppc_sys_device_setfunc(MPC8xx_CPM_SMC2, PPC_SYS_FUNC_UART);
 #endif
diff --git a/drivers/serial/cpm_uart/cpm_uart.h b/drivers/serial/cpm_uart/cpm_uart.h
index aa5eb7d..3b35cb7 100644
--- a/drivers/serial/cpm_uart/cpm_uart.h
+++ b/drivers/serial/cpm_uart/cpm_uart.h
@@ -5,6 +5,13 @@
  *
  *  Copyright (C) 2004 Freescale Semiconductor, Inc.
  *
+ *  2006 (c) MontaVista Software, Inc.
+ * 	Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
  */
 #ifndef CPM_UART_H
 #define CPM_UART_H
@@ -101,12 +108,13 @@ static inline unsigned long cpu2cpm_addr
 	int offset;
 	u32 val = (u32)addr;
 	/* sane check */
-	if ((val >= (u32)pinfo->mem_addr) &&
+	if (likely((val >= (u32)pinfo->mem_addr)) &&
 			(val<((u32)pinfo->mem_addr + pinfo->mem_size))) {
 		offset = val - (u32)pinfo->mem_addr;
 		return pinfo->dma_addr+offset;
 	}
-	printk("%s(): address %x to translate out of range!\n", __FUNCTION__, val);
+	/* something nasty happened */
+	BUG();
 	return 0;
 }
 
@@ -115,12 +123,13 @@ static inline void *cpm2cpu_addr(unsigne
 	int offset;
 	u32 val = addr;
 	/* sane check */
-	if ((val >= pinfo->dma_addr) &&
-			(val<(pinfo->dma_addr + pinfo->mem_size))) {
+	if (likely((val >= pinfo->dma_addr) &&
+			(val<(pinfo->dma_addr + pinfo->mem_size)))) {
 		offset = val - (u32)pinfo->dma_addr;
 		return (void*)(pinfo->mem_addr+offset);
 	}
-	printk("%s(): address %x to translate out of range!\n", __FUNCTION__, val);
+	/* something nasty happened */
+	BUG();
 	return 0;
 }
 
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index ced193b..2bdbcb3 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -12,7 +12,8 @@
  *
  *  Copyright (C) 2004 Freescale Semiconductor, Inc.
  *            (C) 2004 Intracom, S.A.
- *            (C) 2005 MontaVista Software, Inc. by Vitaly Bordug <vbordug@ru.mvista.com>
+ *            (C) 2005-2006 MontaVista Software, Inc.
+ * 		Vitaly Bordug <vbordug@ru.mvista.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -81,7 +82,7 @@ early_uart_get_pdev(int index)
 }
 
 
-void cpm_uart_count(void)
+static void cpm_uart_count(void)
 {
 	cpm_uart_nr = 0;
 #ifdef CONFIG_SERIAL_CPM_SMC1
@@ -104,6 +105,21 @@ void cpm_uart_count(void)
 #endif
 }
 
+/* Get UART number by its id */
+static int cpm_uart_id2nr(int id)
+{
+	int i;
+	if (id < UART_NR) {
+		for (i=0; i<UART_NR; i++) {
+			if (cpm_uart_port_map[i] == id)
+				return i;
+		}
+	}
+
+	/* not found or invalid argument */
+	return -1;
+}
+
 /*
  * Check, if transmit buffers are processed
 */
@@ -1008,7 +1024,11 @@ int cpm_uart_drv_get_platform_data(struc
 	int line;
 	u32 mem, pram;
 
-	for (line=0; line<UART_NR && cpm_uart_port_map[line]!=pdata->fs_no; line++);
+	line = cpm_uart_id2nr(idx);
+	if(line < 0) {
+		printk(KERN_ERR"%s(): port %d is not registered", __FUNCTION__, idx);
+		return -1;
+	}
 
 	pinfo = (struct uart_cpm_port *) &cpm_uart_ports[idx];
 
@@ -1241,8 +1261,7 @@ static int cpm_uart_drv_probe(struct dev
 	}
 
 	pdata = pdev->dev.platform_data;
-	pr_debug("cpm_uart_drv_probe: Adding CPM UART %d\n",
-			cpm_uart_port_map[pdata->fs_no]);
+	pr_debug("cpm_uart_drv_probe: Adding CPM UART %d\n", cpm_uart_id2nr(pdata->fs_no));
 
 	if ((ret = cpm_uart_drv_get_platform_data(pdev, 0)))
 		return ret;
@@ -1261,7 +1280,7 @@ static int cpm_uart_drv_remove(struct de
 	struct fs_uart_platform_info *pdata = pdev->dev.platform_data;
 
 	pr_debug("cpm_uart_drv_remove: Removing CPM UART %d\n",
-			cpm_uart_port_map[pdata->fs_no]);
+			cpm_uart_id2nr(pdata->fs_no));
 
         uart_remove_one_port(&cpm_reg, &cpm_uart_ports[pdata->fs_no].port);
         return 0;
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
index a5a3062..17406a0 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
@@ -8,6 +8,8 @@
  *
  *  Copyright (C) 2004 Freescale Semiconductor, Inc.
  *            (C) 2004 Intracom, S.A.
+ *            (C) 2006 MontaVista Software, Inc.
+ * 		Vitaly Bordug <vbordug@ru.mvista.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index 7c6b07a..4b2de08 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -8,6 +8,8 @@
  * 
  *  Copyright (C) 2004 Freescale Semiconductor, Inc.
  *            (C) 2004 Intracom, S.A.
+ *            (C) 2006 MontaVista Software, Inc.
+ * 		Vitaly Bordug <vbordug@ru.mvista.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff --git a/include/linux/fs_uart_pd.h b/include/linux/fs_uart_pd.h
new file mode 100644
index 0000000..a6454f6
--- /dev/null
+++ b/include/linux/fs_uart_pd.h
@@ -0,0 +1,60 @@
+/*
+ * Platform information definitions for the CMP Uart driver.
+ *
+ * 2006 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef FS_UART_PD_H
+#define FS_UART_PD_H
+
+#include <linux/version.h>
+#include <asm/types.h>
+
+enum fs_uart_id {
+	fsid_smc1_uart,
+	fsid_smc2_uart,
+	fsid_scc1_uart,
+	fsid_scc2_uart,
+	fsid_scc3_uart,
+	fsid_scc4_uart,
+	fs_uart_nr,
+};
+
+static inline int fs_uart_id_scc2fsid(int id)
+{
+    return fsid_scc1_uart + id - 1;
+}
+
+static inline int fs_uart_id_fsid2scc(int id)
+{
+    return id - fsid_scc1_uart + 1;
+}
+
+static inline int fs_uart_id_smc2fsid(int id)
+{
+    return fsid_smc1_uart + id - 1;
+}
+
+static inline int fs_uart_id_fsid2smc(int id)
+{
+    return id - fsid_smc1_uart + 1;
+}
+
+struct fs_uart_platform_info {
+        void(*init_ioports)(void);
+	/* device specific information */
+	int fs_no;		/* controller index */
+	u32 uart_clk;
+	u8 tx_num_fifo;
+	u8 tx_buf_size;
+	u8 rx_num_fifo;
+	u8 rx_buf_size;
+	u8 brg;
+};
+
+#endif
