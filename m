Return-Path: <vbordug@ru.mvista.com>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 95E52679F9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Apr 2006 02:26:49 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 2/4] CPM_UART: Convert to use platform devices
Date: Tue, 25 Apr 2006 20:26:41 +0400
Message-Id: <20060425162641.23551.21925.stgit@vitb.ru.mvista.com>
In-Reply-To: <20060425162633.23551.85273.stgit@vitb.ru.mvista.com>
References: <20060425162633.23551.85273.stgit@vitb.ru.mvista.com>
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


This is intended to make the driver code more generic and flexible,
to get rid of board-specific layouts within driver, and generic rehaul,
yet keeping compatibility with the existing stuff utilizing it, being
compatible with legacy behavior (but with complaints that legacy mode
used).

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 drivers/serial/cpm_uart/cpm_uart.h      |   16 +-
 drivers/serial/cpm_uart/cpm_uart_core.c |  259 +++++++++++++++++++++++++------
 drivers/serial/cpm_uart/cpm_uart_cpm1.c |   47 ------
 drivers/serial/cpm_uart/cpm_uart_cpm2.c |    9 -
 4 files changed, 220 insertions(+), 111 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart.h b/drivers/serial/cpm_uart/cpm_uart.h
index 73c8a08..17f2c7a 100644
--- a/drivers/serial/cpm_uart/cpm_uart.h
+++ b/drivers/serial/cpm_uart/cpm_uart.h
@@ -10,6 +10,8 @@
 #define CPM_UART_H
 
 #include <linux/config.h>
+#include <linux/platform_device.h>
+#include <linux/fs_uart_pd.h>
 
 #if defined(CONFIG_CPM2)
 #include "cpm_uart_cpm2.h"
@@ -26,14 +28,14 @@
 #define FLAG_SMC	0x00000002
 #define FLAG_CONSOLE	0x00000001
 
-#define UART_SMC1	0
-#define UART_SMC2	1
-#define UART_SCC1	2
-#define UART_SCC2	3
-#define UART_SCC3	4
-#define UART_SCC4	5
+#define UART_SMC1	fsid_smc1_uart
+#define UART_SMC2	fsid_smc2_uart
+#define UART_SCC1	fsid_scc1_uart
+#define UART_SCC2	fsid_scc2_uart
+#define UART_SCC3	fsid_scc3_uart
+#define UART_SCC4	fsid_scc4_uart
 
-#define UART_NR	6
+#define UART_NR		fs_uart_nr
 
 #define RX_NUM_FIFO	4
 #define RX_BUF_SIZE	32
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index b7bf4c6..8f33815 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -41,6 +41,7 @@
 #include <linux/device.h>
 #include <linux/bootmem.h>
 #include <linux/dma-mapping.h>
+#include <linux/fs_uart_pd.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -60,7 +61,7 @@
 /* Track which ports are configured as uarts */
 int cpm_uart_port_map[UART_NR];
 /* How many ports did we config as uarts */
-int cpm_uart_nr;
+int cpm_uart_nr = 0;
 
 /**************************************************************/
 
@@ -85,6 +86,37 @@ static inline void *cpm2cpu_addr(unsigne
 	return bus_to_virt(addr);
 }
 
+/* Place-holder for board-specific stuff */
+struct platform_device* __attribute__ ((weak)) __init
+early_uart_get_pdev(int index)
+{
+	return NULL;
+}
+
+
+void cpm_uart_count(void)
+{
+	cpm_uart_nr = 0;
+#ifdef CONFIG_SERIAL_CPM_SMC1
+	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC1;
+#endif
+#ifdef CONFIG_SERIAL_CPM_SMC2
+	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC2;
+#endif
+#ifdef CONFIG_SERIAL_CPM_SCC1
+	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC1;
+#endif
+#ifdef CONFIG_SERIAL_CPM_SCC2
+	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC2;
+#endif
+#ifdef CONFIG_SERIAL_CPM_SCC3
+	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC3;
+#endif
+#ifdef CONFIG_SERIAL_CPM_SCC4
+	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC4;
+#endif
+}
+
 /*
  * Check, if transmit buffers are processed
 */
@@ -829,14 +861,6 @@ static int cpm_uart_request_port(struct 
 	if (pinfo->flags & FLAG_CONSOLE)
 		return 0;
 
-	/*
-	 * Setup any port IO, connect any baud rate generators,
-	 * etc.  This is expected to be handled by board
-	 * dependant code
-	 */
-	if (pinfo->set_lineif)
-		pinfo->set_lineif(pinfo);
-
 	if (IS_SMC(pinfo)) {
 		pinfo->smcp->smc_smcm &= ~(SMCM_RX | SMCM_TX);
 		pinfo->smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
@@ -988,6 +1012,54 @@ struct uart_cpm_port cpm_uart_ports[UART
 	},
 };
 
+int cpm_uart_drv_get_platform_data(struct platform_device *pdev, int is_con)
+{
+	struct resource *r;
+	struct fs_uart_platform_info *pdata = pdev->dev.platform_data;
+	int idx = pdata->fs_no;	/* It is UART_SMCx or UART_SCCx index */
+	struct uart_cpm_port *pinfo;
+	int line;
+	u32 mem, pram;
+
+	for (line=0; line<UART_NR && cpm_uart_port_map[line]!=pdata->fs_no; line++);
+
+	pinfo = (struct uart_cpm_port *) &cpm_uart_ports[idx];
+
+	pinfo->brg = pdata->brg;
+
+	if (!is_con) {
+		pinfo->port.line = line;
+		pinfo->port.flags = UPF_BOOT_AUTOCONF;
+	}
+
+	if (!(r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs")))
+		return -EINVAL;
+	mem = r->start;
+
+	if (!(r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pram")))
+		return -EINVAL;
+	pram = r->start;
+
+	if(idx > fsid_smc2_uart) {
+		pinfo->sccp = (scc_t *)mem;
+		pinfo->sccup = (scc_uart_t *)pram; 
+	} else {
+		pinfo->smcp = (smc_t *)mem;
+		pinfo->smcup = (smc_uart_t *)pram; 
+	}
+	pinfo->tx_nrfifos = pdata->tx_num_fifo;
+	pinfo->tx_fifosize = pdata->tx_buf_size;
+
+	pinfo->rx_nrfifos = pdata->rx_num_fifo;
+	pinfo->rx_fifosize = pdata->rx_buf_size;
+
+	pinfo->port.uartclk = pdata->uart_clk;
+	pinfo->port.mapbase = (unsigned long)mem;
+	pinfo->port.irq = platform_get_irq(pdev, 0);
+	
+	return 0;
+}
+
 #ifdef CONFIG_SERIAL_CPM_CONSOLE
 /*
  *	Print a string to the serial port trying not to disturb
@@ -1067,9 +1139,7 @@ static void cpm_uart_console_write(struc
 	pinfo->tx_cur = (volatile cbd_t *) bdp;
 }
 
-/*
- * Setup console. Be careful is called early !
- */
+
 static int __init cpm_uart_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
@@ -1080,9 +1150,27 @@ static int __init cpm_uart_console_setup
 	int flow = 'n';
 	int ret;
 
+	struct fs_uart_platform_info *pdata;
+	struct platform_device* pdev = early_uart_get_pdev(co->index);
+	
 	port =
 	    (struct uart_port *)&cpm_uart_ports[cpm_uart_port_map[co->index]];
 	pinfo = (struct uart_cpm_port *)port;
+	if (!pdev) {
+		pr_info("cpm_uart: console: compat mode\n");
+		/* compatibility - will be cleaned up */
+		cpm_uart_init_portdesc();
+
+		if (pinfo->set_lineif)
+			pinfo->set_lineif(pinfo);
+	} else {
+		pdata = pdev->dev.platform_data;
+		if (pdata)
+			if (pdata->init_ioports)
+    	                	pdata->init_ioports();
+
+		cpm_uart_drv_get_platform_data(pdev, 1);
+	}
 
 	pinfo->flags |= FLAG_CONSOLE;
 
@@ -1097,14 +1185,6 @@ static int __init cpm_uart_console_setup
 			baud = 9600;
 	}
 
-	/*
-	 * Setup any port IO, connect any baud rate generators,
-	 * etc.  This is expected to be handled by board
-	 * dependant code
-	 */
-	if (pinfo->set_lineif)
-		pinfo->set_lineif(pinfo);
-
 	if (IS_SMC(pinfo)) {
 		pinfo->smcp->smc_smcm &= ~(SMCM_RX | SMCM_TX);
 		pinfo->smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
@@ -1143,11 +1223,8 @@ static struct console cpm_scc_uart_conso
 
 int __init cpm_uart_console_init(void)
 {
-	int ret = cpm_uart_init_portdesc();
-
-	if (!ret)
-		register_console(&cpm_scc_uart_console);
-	return ret;
+	register_console(&cpm_scc_uart_console);
+	return 0;
 }
 
 console_initcall(cpm_uart_console_init);
@@ -1165,44 +1242,130 @@ static struct uart_driver cpm_reg = {
 	.minor		= SERIAL_CPM_MINOR,
 	.cons		= CPM_UART_CONSOLE,
 };
-
-static int __init cpm_uart_init(void)
+static int cpm_uart_drv_probe(struct device *dev)
 {
-	int ret, i;
+	struct platform_device  *pdev = to_platform_device(dev);
+	struct fs_uart_platform_info *pdata;
+	int ret = -ENODEV;
 
-	printk(KERN_INFO "Serial: CPM driver $Revision: 0.01 $\n");
-
-#ifndef CONFIG_SERIAL_CPM_CONSOLE
-	ret = cpm_uart_init_portdesc();
-	if (ret)
+	if(!pdev) {
+		printk(KERN_ERR"CPM UART: platform data missing!\n");
 		return ret;
-#endif
+	}
 
-	cpm_reg.nr = cpm_uart_nr;
-	ret = uart_register_driver(&cpm_reg);
+	pdata = pdev->dev.platform_data;
+	pr_debug("cpm_uart_drv_probe: Adding CPM UART %d\n",
+			cpm_uart_port_map[pdata->fs_no]);
 
-	if (ret)
+	if ((ret = cpm_uart_drv_get_platform_data(pdev, 0)))
 		return ret;
 
-	for (i = 0; i < cpm_uart_nr; i++) {
-		int con = cpm_uart_port_map[i];
-		cpm_uart_ports[con].port.line = i;
-		cpm_uart_ports[con].port.flags = UPF_BOOT_AUTOCONF;
-		uart_add_one_port(&cpm_reg, &cpm_uart_ports[con].port);
-	}
+	if (pdata->init_ioports)
+                pdata->init_ioports();
+ 
+	ret = uart_add_one_port(&cpm_reg, &cpm_uart_ports[pdata->fs_no].port);
 
-	return ret;
+        return ret;
 }
 
-static void __exit cpm_uart_exit(void)
+static int cpm_uart_drv_remove(struct device *dev)
 {
+	struct platform_device  *pdev = to_platform_device(dev);
+	struct fs_uart_platform_info *pdata = pdev->dev.platform_data;
+
+	pr_debug("cpm_uart_drv_remove: Removing CPM UART %d\n", 
+			cpm_uart_port_map[pdata->fs_no]);
+
+        uart_remove_one_port(&cpm_reg, &cpm_uart_ports[pdata->fs_no].port);
+        return 0;
+}
+
+static struct device_driver cpm_smc_uart_driver = {
+        .name   = "fsl-cpm-smc:uart",
+        .bus    = &platform_bus_type,
+        .probe  = cpm_uart_drv_probe,
+        .remove = cpm_uart_drv_remove,
+};
+
+static struct device_driver cpm_scc_uart_driver = {
+        .name   = "fsl-cpm-scc:uart",
+        .bus    = &platform_bus_type,
+        .probe  = cpm_uart_drv_probe,
+        .remove = cpm_uart_drv_remove,
+};
+
+/* 
+   This is supposed to match uart devices on platform bus,
+   */
+static int match_is_uart (struct device* dev, void* data)
+{
+	struct platform_device* pdev = container_of(dev, struct platform_device, dev);
+	int ret = 0;
+	/* this was setfunc as uart */
+	if(strstr(pdev->name,":uart")) {
+		ret = 1;
+	}
+	return ret;
+}
+
+
+static int cpm_uart_init(void) {
+
+	int ret;
 	int i;
+	struct device *dev; 
+	printk(KERN_INFO "Serial: CPM driver $Revision: 0.02 $\n");
+
+	/* lookup the bus for uart devices */
+	dev = bus_find_device(&platform_bus_type, NULL, 0, match_is_uart);
+
+	/* There are devices on the bus - all should be OK  */
+	if (dev) {
+		cpm_uart_count();
+		cpm_reg.nr = cpm_uart_nr;
+
+		if (!(ret = uart_register_driver(&cpm_reg))) {
+			if ((ret = driver_register(&cpm_smc_uart_driver))) {
+				uart_unregister_driver(&cpm_reg);
+				return ret;
+			}
+			if ((ret = driver_register(&cpm_scc_uart_driver))) {
+				driver_unregister(&cpm_scc_uart_driver);
+				uart_unregister_driver(&cpm_reg);
+			}
+		}
+	} else {
+	/* No capable platform devices found - falling back to legacy mode */
+		pr_info("cpm_uart: WARNING: no UART devices found on platform bus!\n");
+		pr_info(
+		"cpm_uart: the driver will guess configuration, but this mode is no longer supported.\n");
+#ifndef CONFIG_SERIAL_CPM_CONSOLE
+		ret = cpm_uart_init_portdesc();
+		if (ret)
+			return ret;
+#endif
+
+		cpm_reg.nr = cpm_uart_nr;
+		ret = uart_register_driver(&cpm_reg);
+
+		if (ret)
+			return ret;
+
+		for (i = 0; i < cpm_uart_nr; i++) {
+			int con = cpm_uart_port_map[i];
+			cpm_uart_ports[con].port.line = i;
+			cpm_uart_ports[con].port.flags = UPF_BOOT_AUTOCONF;
+			uart_add_one_port(&cpm_reg, &cpm_uart_ports[con].port);
+		}
 
-	for (i = 0; i < cpm_uart_nr; i++) {
-		int con = cpm_uart_port_map[i];
-		uart_remove_one_port(&cpm_reg, &cpm_uart_ports[con].port);
 	}
+	return ret;
+}
 
+static void __exit cpm_uart_exit(void)
+{
+	driver_unregister(&cpm_scc_uart_driver);
+	driver_unregister(&cpm_smc_uart_driver);
 	uart_unregister_driver(&cpm_reg);
 }
 
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
index d789ee5..31223aa 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
@@ -81,58 +81,11 @@ void cpm_line_cr_cmd(int line, int cmd)
 
 void smc1_lineif(struct uart_cpm_port *pinfo)
 {
-	volatile cpm8xx_t *cp = cpmp;
-
-	(void)cp;	/* fix warning */
-#if defined (CONFIG_MPC885ADS)
-	/* Enable SMC1 transceivers */
-	{
-		cp->cp_pepar |= 0x000000c0;
-		cp->cp_pedir &= ~0x000000c0;
-		cp->cp_peso &= ~0x00000040;
-		cp->cp_peso |= 0x00000080;
-	}
-#elif defined (CONFIG_MPC86XADS)
-	unsigned int iobits = 0x000000c0;
-
-	if (!pinfo->is_portb) {
-		cp->cp_pbpar |= iobits;
-		cp->cp_pbdir &= ~iobits;
-		cp->cp_pbodr &= ~iobits;
-	} else {
-		((immap_t *)IMAP_ADDR)->im_ioport.iop_papar |= iobits;
-		((immap_t *)IMAP_ADDR)->im_ioport.iop_padir &= ~iobits;
-		((immap_t *)IMAP_ADDR)->im_ioport.iop_paodr &= ~iobits;
-	}
-#endif
 	pinfo->brg = 1;
 }
 
 void smc2_lineif(struct uart_cpm_port *pinfo)
 {
-	volatile cpm8xx_t *cp = cpmp;
-
-	(void)cp;	/* fix warning */
-#if defined (CONFIG_MPC885ADS)
-	cp->cp_pepar |= 0x00000c00;
-	cp->cp_pedir &= ~0x00000c00;
-	cp->cp_peso &= ~0x00000400;
-	cp->cp_peso |= 0x00000800;
-#elif defined (CONFIG_MPC86XADS)
-	unsigned int iobits = 0x00000c00;
-
-	if (!pinfo->is_portb) {
-		cp->cp_pbpar |= iobits;
-		cp->cp_pbdir &= ~iobits;
-		cp->cp_pbodr &= ~iobits;
-	} else {
-		((immap_t *)IMAP_ADDR)->im_ioport.iop_papar |= iobits;
-		((immap_t *)IMAP_ADDR)->im_ioport.iop_padir &= ~iobits;
-		((immap_t *)IMAP_ADDR)->im_ioport.iop_paodr &= ~iobits;
-	}
-
-#endif
-
 	pinfo->brg = 2;
 }
 
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index fd9e53e..c9c3b1d 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -142,14 +142,6 @@ void scc2_lineif(struct uart_cpm_port *p
 	 * be supported in a sane fashion.
 	 */
 #ifndef CONFIG_STX_GP3
-#ifdef CONFIG_MPC8560_ADS
-	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
-	io->iop_ppard |= 0x00000018;
-	io->iop_psord &= ~0x00000008;	/* Rx */
-	io->iop_psord &= ~0x00000010;	/* Tx */
-	io->iop_pdird &= ~0x00000008;	/* Rx */
-	io->iop_pdird |= 0x00000010;	/* Tx */
-#else
 	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
 	io->iop_pparb |= 0x008b0000;
 	io->iop_pdirb |= 0x00880000;
@@ -157,7 +149,6 @@ void scc2_lineif(struct uart_cpm_port *p
 	io->iop_pdirb &= ~0x00030000;
 	io->iop_psorb &= ~0x00030000;
 #endif
-#endif
 	cpm2_immr->im_cpmux.cmx_scr &= 0xff00ffff;
 	cpm2_immr->im_cpmux.cmx_scr |= 0x00090000;
 	pinfo->brg = 2;
