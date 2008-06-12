Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3EAEFDE4B0
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 23:40:47 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] cpm_uart: Remove !CONFIG_PPC_CPM_NEW_BINDING code
Date: Thu, 12 Jun 2008 08:40:31 -0500
Message-Id: <1213278034-28552-3-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1213278034-28552-2-git-send-email-galak@kernel.crashing.org>
References: <1213278034-28552-1-git-send-email-galak@kernel.crashing.org>
	<1213278034-28552-2-git-send-email-galak@kernel.crashing.org>
Cc: scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that arch/ppc is gone we always define CONFIG_PPC_CPM_NEW_BINDING so
we can remove all the code associated with !CONFIG_PPC_CPM_NEW_BINDING.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/serial/cpm_uart/cpm_uart.h      |    3 -
 drivers/serial/cpm_uart/cpm_uart_core.c |  371 +------------------------------
 drivers/serial/cpm_uart/cpm_uart_cpm1.c |  168 --------------
 drivers/serial/cpm_uart/cpm_uart_cpm1.h |   10 -
 drivers/serial/cpm_uart/cpm_uart_cpm2.c |  277 -----------------------
 drivers/serial/cpm_uart/cpm_uart_cpm2.h |   10 -
 6 files changed, 1 insertions(+), 838 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart.h b/drivers/serial/cpm_uart/cpm_uart.h
index 3d07bec..5c76e0a 100644
--- a/drivers/serial/cpm_uart/cpm_uart.h
+++ b/drivers/serial/cpm_uart/cpm_uart.h
@@ -84,9 +84,6 @@ struct uart_cpm_port {
 	u32			command;
 };
 
-#ifndef CONFIG_PPC_CPM_NEW_BINDING
-extern int cpm_uart_port_map[UART_NR];
-#endif
 extern int cpm_uart_nr;
 extern struct uart_cpm_port cpm_uart_ports[UART_NR];
 
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index b0104ca..43f58dc 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -42,6 +42,7 @@
 #include <linux/bootmem.h>
 #include <linux/dma-mapping.h>
 #include <linux/fs_uart_pd.h>
+#include <linux/of_platform.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -49,10 +50,6 @@
 #include <asm/fs_pd.h>
 #include <asm/udbg.h>
 
-#ifdef CONFIG_PPC_CPM_NEW_BINDING
-#include <linux/of_platform.h>
-#endif
-
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
 #endif
@@ -72,59 +69,6 @@ static void cpm_uart_initbd(struct uart_cpm_port *pinfo);
 
 /**************************************************************/
 
-#ifndef CONFIG_PPC_CPM_NEW_BINDING
-/* Track which ports are configured as uarts */
-int cpm_uart_port_map[UART_NR];
-/* How many ports did we config as uarts */
-int cpm_uart_nr;
-
-/* Place-holder for board-specific stuff */
-struct platform_device* __attribute__ ((weak)) __init
-early_uart_get_pdev(int index)
-{
-	return NULL;
-}
-
-
-static void cpm_uart_count(void)
-{
-	cpm_uart_nr = 0;
-#ifdef CONFIG_SERIAL_CPM_SMC1
-	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC1;
-#endif
-#ifdef CONFIG_SERIAL_CPM_SMC2
-	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC2;
-#endif
-#ifdef CONFIG_SERIAL_CPM_SCC1
-	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC1;
-#endif
-#ifdef CONFIG_SERIAL_CPM_SCC2
-	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC2;
-#endif
-#ifdef CONFIG_SERIAL_CPM_SCC3
-	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC3;
-#endif
-#ifdef CONFIG_SERIAL_CPM_SCC4
-	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC4;
-#endif
-}
-
-/* Get UART number by its id */
-static int cpm_uart_id2nr(int id)
-{
-	int i;
-	if (id < UART_NR) {
-		for (i=0; i<UART_NR; i++) {
-			if (cpm_uart_port_map[i] == id)
-				return i;
-		}
-	}
-
-	/* not found or invalid argument */
-	return -1;
-}
-#endif
-
 /*
  * Check, if transmit buffers are processed
 */
@@ -935,7 +879,6 @@ static struct uart_ops cpm_uart_pops = {
 	.verify_port	= cpm_uart_verify_port,
 };
 
-#ifdef CONFIG_PPC_CPM_NEW_BINDING
 struct uart_cpm_port cpm_uart_ports[UART_NR];
 
 static int cpm_uart_init_port(struct device_node *np,
@@ -1012,153 +955,6 @@ out_mem:
 	return ret;
 }
 
-#else
-
-struct uart_cpm_port cpm_uart_ports[UART_NR] = {
-	[UART_SMC1] = {
-		.port = {
-			.irq		= SMC1_IRQ,
-			.ops		= &cpm_uart_pops,
-			.iotype		= UPIO_MEM,
-			.lock		= __SPIN_LOCK_UNLOCKED(cpm_uart_ports[UART_SMC1].port.lock),
-		},
-		.flags = FLAG_SMC,
-		.tx_nrfifos = TX_NUM_FIFO,
-		.tx_fifosize = TX_BUF_SIZE,
-		.rx_nrfifos = RX_NUM_FIFO,
-		.rx_fifosize = RX_BUF_SIZE,
-		.set_lineif = smc1_lineif,
-	},
-	[UART_SMC2] = {
-		.port = {
-			.irq		= SMC2_IRQ,
-			.ops		= &cpm_uart_pops,
-			.iotype		= UPIO_MEM,
-			.lock		= __SPIN_LOCK_UNLOCKED(cpm_uart_ports[UART_SMC2].port.lock),
-		},
-		.flags = FLAG_SMC,
-		.tx_nrfifos = TX_NUM_FIFO,
-		.tx_fifosize = TX_BUF_SIZE,
-		.rx_nrfifos = RX_NUM_FIFO,
-		.rx_fifosize = RX_BUF_SIZE,
-		.set_lineif = smc2_lineif,
-#ifdef CONFIG_SERIAL_CPM_ALT_SMC2
-		.is_portb = 1,
-#endif
-	},
-	[UART_SCC1] = {
-		.port = {
-			.irq		= SCC1_IRQ,
-			.ops		= &cpm_uart_pops,
-			.iotype		= UPIO_MEM,
-			.lock		= __SPIN_LOCK_UNLOCKED(cpm_uart_ports[UART_SCC1].port.lock),
-		},
-		.tx_nrfifos = TX_NUM_FIFO,
-		.tx_fifosize = TX_BUF_SIZE,
-		.rx_nrfifos = RX_NUM_FIFO,
-		.rx_fifosize = RX_BUF_SIZE,
-		.set_lineif = scc1_lineif,
-		.wait_closing = SCC_WAIT_CLOSING,
-	},
-	[UART_SCC2] = {
-		.port = {
-			.irq		= SCC2_IRQ,
-			.ops		= &cpm_uart_pops,
-			.iotype		= UPIO_MEM,
-			.lock		= __SPIN_LOCK_UNLOCKED(cpm_uart_ports[UART_SCC2].port.lock),
-		},
-		.tx_nrfifos = TX_NUM_FIFO,
-		.tx_fifosize = TX_BUF_SIZE,
-		.rx_nrfifos = RX_NUM_FIFO,
-		.rx_fifosize = RX_BUF_SIZE,
-		.set_lineif = scc2_lineif,
-		.wait_closing = SCC_WAIT_CLOSING,
-	},
-	[UART_SCC3] = {
-		.port = {
-			.irq		= SCC3_IRQ,
-			.ops		= &cpm_uart_pops,
-			.iotype		= UPIO_MEM,
-			.lock		= __SPIN_LOCK_UNLOCKED(cpm_uart_ports[UART_SCC3].port.lock),
-		},
-		.tx_nrfifos = TX_NUM_FIFO,
-		.tx_fifosize = TX_BUF_SIZE,
-		.rx_nrfifos = RX_NUM_FIFO,
-		.rx_fifosize = RX_BUF_SIZE,
-		.set_lineif = scc3_lineif,
-		.wait_closing = SCC_WAIT_CLOSING,
-	},
-	[UART_SCC4] = {
-		.port = {
-			.irq		= SCC4_IRQ,
-			.ops		= &cpm_uart_pops,
-			.iotype		= UPIO_MEM,
-			.lock		= __SPIN_LOCK_UNLOCKED(cpm_uart_ports[UART_SCC4].port.lock),
-		},
-		.tx_nrfifos = TX_NUM_FIFO,
-		.tx_fifosize = TX_BUF_SIZE,
-		.rx_nrfifos = RX_NUM_FIFO,
-		.rx_fifosize = RX_BUF_SIZE,
-		.set_lineif = scc4_lineif,
-		.wait_closing = SCC_WAIT_CLOSING,
-	},
-};
-
-int cpm_uart_drv_get_platform_data(struct platform_device *pdev, int is_con)
-{
-	struct resource *r;
-	struct fs_uart_platform_info *pdata = pdev->dev.platform_data;
-	int idx;	/* It is UART_SMCx or UART_SCCx index */
-	struct uart_cpm_port *pinfo;
-	int line;
-	u32 mem, pram;
-
-        idx = pdata->fs_no = fs_uart_get_id(pdata);
-
-	line = cpm_uart_id2nr(idx);
-	if(line < 0) {
-		printk(KERN_ERR"%s(): port %d is not registered", __func__, idx);
-		return -EINVAL;
-	}
-
-	pinfo = (struct uart_cpm_port *) &cpm_uart_ports[idx];
-
-	pinfo->brg = pdata->brg;
-
-	if (!is_con) {
-		pinfo->port.line = line;
-		pinfo->port.flags = UPF_BOOT_AUTOCONF;
-	}
-
-	if (!(r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs")))
-		return -EINVAL;
-	mem = (u32)ioremap(r->start, r->end - r->start + 1);
-
-	if (!(r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pram")))
-		return -EINVAL;
-	pram = (u32)ioremap(r->start, r->end - r->start + 1);
-
-	if(idx > fsid_smc2_uart) {
-		pinfo->sccp = (scc_t *)mem;
-		pinfo->sccup = (scc_uart_t *)pram;
-	} else {
-		pinfo->smcp = (smc_t *)mem;
-		pinfo->smcup = (smc_uart_t *)pram;
-	}
-	pinfo->tx_nrfifos = pdata->tx_num_fifo;
-	pinfo->tx_fifosize = pdata->tx_buf_size;
-
-	pinfo->rx_nrfifos = pdata->rx_num_fifo;
-	pinfo->rx_fifosize = pdata->rx_buf_size;
-
-	pinfo->port.uartclk = pdata->uart_clk;
-	pinfo->port.mapbase = (unsigned long)mem;
-	pinfo->port.irq = platform_get_irq(pdev, 0);
-
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_SERIAL_CPM_CONSOLE
 /*
  *	Print a string to the serial port trying not to disturb
@@ -1169,12 +965,7 @@ int cpm_uart_drv_get_platform_data(struct platform_device *pdev, int is_con)
 static void cpm_uart_console_write(struct console *co, const char *s,
 				   u_int count)
 {
-#ifdef CONFIG_PPC_CPM_NEW_BINDING
 	struct uart_cpm_port *pinfo = &cpm_uart_ports[co->index];
-#else
-	struct uart_cpm_port *pinfo =
-	    &cpm_uart_ports[cpm_uart_port_map[co->index]];
-#endif
 	unsigned int i;
 	cbd_t __iomem *bdp, *bdbase;
 	unsigned char *cp;
@@ -1252,7 +1043,6 @@ static int __init cpm_uart_console_setup(struct console *co, char *options)
 	struct uart_cpm_port *pinfo;
 	struct uart_port *port;
 
-#ifdef CONFIG_PPC_CPM_NEW_BINDING
 	struct device_node *np = NULL;
 	int i = 0;
 
@@ -1284,35 +1074,6 @@ static int __init cpm_uart_console_setup(struct console *co, char *options)
 	if (ret)
 		return ret;
 
-#else
-
-	struct fs_uart_platform_info *pdata;
-	struct platform_device* pdev = early_uart_get_pdev(co->index);
-
-	if (!pdev) {
-		pr_info("cpm_uart: console: compat mode\n");
-		/* compatibility - will be cleaned up */
-		cpm_uart_init_portdesc();
-	}
-
-	port =
-	    (struct uart_port *)&cpm_uart_ports[cpm_uart_port_map[co->index]];
-	pinfo = (struct uart_cpm_port *)port;
-	if (!pdev) {
-		if (pinfo->set_lineif)
-			pinfo->set_lineif(pinfo);
-	} else {
-		pdata = pdev->dev.platform_data;
-		if (pdata)
-			if (pdata->init_ioports)
-				pdata->init_ioports(pdata);
-
-		cpm_uart_drv_get_platform_data(pdev, 1);
-	}
-
-	pinfo->flags |= FLAG_CONSOLE;
-#endif
-
 	if (options) {
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	} else {
@@ -1386,7 +1147,6 @@ static struct uart_driver cpm_reg = {
 	.nr		= UART_NR,
 };
 
-#ifdef CONFIG_PPC_CPM_NEW_BINDING
 static int probe_index;
 
 static int __devinit cpm_uart_probe(struct of_device *ofdev,
@@ -1457,135 +1217,6 @@ static void __exit cpm_uart_exit(void)
 	of_unregister_platform_driver(&cpm_uart_driver);
 	uart_unregister_driver(&cpm_reg);
 }
-#else
-static int cpm_uart_drv_probe(struct device *dev)
-{
-	struct platform_device  *pdev = to_platform_device(dev);
-	struct fs_uart_platform_info *pdata;
-	int ret = -ENODEV;
-
-	if(!pdev) {
-		printk(KERN_ERR"CPM UART: platform data missing!\n");
-		return ret;
-	}
-
-	pdata = pdev->dev.platform_data;
-
-	if ((ret = cpm_uart_drv_get_platform_data(pdev, 0)))
-		return ret;
-
-	pr_debug("cpm_uart_drv_probe: Adding CPM UART %d\n", cpm_uart_id2nr(pdata->fs_no));
-
-	if (pdata->init_ioports)
-                pdata->init_ioports(pdata);
-
-	ret = uart_add_one_port(&cpm_reg, &cpm_uart_ports[pdata->fs_no].port);
-
-        return ret;
-}
-
-static int cpm_uart_drv_remove(struct device *dev)
-{
-	struct platform_device  *pdev = to_platform_device(dev);
-	struct fs_uart_platform_info *pdata = pdev->dev.platform_data;
-
-	pr_debug("cpm_uart_drv_remove: Removing CPM UART %d\n",
-			cpm_uart_id2nr(pdata->fs_no));
-
-        uart_remove_one_port(&cpm_reg, &cpm_uart_ports[pdata->fs_no].port);
-        return 0;
-}
-
-static struct device_driver cpm_smc_uart_driver = {
-        .name   = "fsl-cpm-smc:uart",
-        .bus    = &platform_bus_type,
-        .probe  = cpm_uart_drv_probe,
-        .remove = cpm_uart_drv_remove,
-};
-
-static struct device_driver cpm_scc_uart_driver = {
-        .name   = "fsl-cpm-scc:uart",
-        .bus    = &platform_bus_type,
-        .probe  = cpm_uart_drv_probe,
-        .remove = cpm_uart_drv_remove,
-};
-
-/*
-   This is supposed to match uart devices on platform bus,
-   */
-static int match_is_uart (struct device* dev, void* data)
-{
-	struct platform_device* pdev = container_of(dev, struct platform_device, dev);
-	int ret = 0;
-	/* this was setfunc as uart */
-	if(strstr(pdev->name,":uart")) {
-		ret = 1;
-	}
-	return ret;
-}
-
-
-static int cpm_uart_init(void) {
-
-	int ret;
-	int i;
-	struct device *dev;
-	printk(KERN_INFO "Serial: CPM driver $Revision: 0.02 $\n");
-
-	/* lookup the bus for uart devices */
-	dev = bus_find_device(&platform_bus_type, NULL, 0, match_is_uart);
-
-	/* There are devices on the bus - all should be OK  */
-	if (dev) {
-		cpm_uart_count();
-		cpm_reg.nr = cpm_uart_nr;
-
-		if (!(ret = uart_register_driver(&cpm_reg))) {
-			if ((ret = driver_register(&cpm_smc_uart_driver))) {
-				uart_unregister_driver(&cpm_reg);
-				return ret;
-			}
-			if ((ret = driver_register(&cpm_scc_uart_driver))) {
-				driver_unregister(&cpm_scc_uart_driver);
-				uart_unregister_driver(&cpm_reg);
-			}
-		}
-	} else {
-	/* No capable platform devices found - falling back to legacy mode */
-		pr_info("cpm_uart: WARNING: no UART devices found on platform bus!\n");
-		pr_info(
-		"cpm_uart: the driver will guess configuration, but this mode is no longer supported.\n");
-
-		/* Don't run this again, if the console driver did it already */
-		if (cpm_uart_nr == 0)
-			cpm_uart_init_portdesc();
-
-		cpm_reg.nr = cpm_uart_nr;
-		ret = uart_register_driver(&cpm_reg);
-
-		if (ret)
-			return ret;
-
-		for (i = 0; i < cpm_uart_nr; i++) {
-			int con = cpm_uart_port_map[i];
-			cpm_uart_ports[con].port.line = i;
-			cpm_uart_ports[con].port.flags = UPF_BOOT_AUTOCONF;
-			if (cpm_uart_ports[con].set_lineif)
-				cpm_uart_ports[con].set_lineif(&cpm_uart_ports[con]);
-			uart_add_one_port(&cpm_reg, &cpm_uart_ports[con].port);
-		}
-
-	}
-	return ret;
-}
-
-static void __exit cpm_uart_exit(void)
-{
-	driver_unregister(&cpm_scc_uart_driver);
-	driver_unregister(&cpm_smc_uart_driver);
-	uart_unregister_driver(&cpm_reg);
-}
-#endif
 
 module_init(cpm_uart_init);
 module_exit(cpm_uart_exit);
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
index bec0c97..0f0aff0 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
@@ -51,7 +51,6 @@
 
 /**************************************************************/
 
-#ifdef CONFIG_PPC_CPM_NEW_BINDING
 void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd)
 {
 	cpm_command(port->command, cmd);
@@ -68,75 +67,6 @@ void cpm_uart_unmap_pram(struct uart_cpm_port *port, void __iomem *pram)
 	iounmap(pram);
 }
 
-#else
-void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd)
-{
-	ushort val;
-	int line = port - cpm_uart_ports;
-	volatile cpm8xx_t *cp = cpmp;
-
-	switch (line) {
-	case UART_SMC1:
-		val = mk_cr_cmd(CPM_CR_CH_SMC1, cmd) | CPM_CR_FLG;
-		break;
-	case UART_SMC2:
-		val = mk_cr_cmd(CPM_CR_CH_SMC2, cmd) | CPM_CR_FLG;
-		break;
-	case UART_SCC1:
-		val = mk_cr_cmd(CPM_CR_CH_SCC1, cmd) | CPM_CR_FLG;
-		break;
-	case UART_SCC2:
-		val = mk_cr_cmd(CPM_CR_CH_SCC2, cmd) | CPM_CR_FLG;
-		break;
-	case UART_SCC3:
-		val = mk_cr_cmd(CPM_CR_CH_SCC3, cmd) | CPM_CR_FLG;
-		break;
-	case UART_SCC4:
-		val = mk_cr_cmd(CPM_CR_CH_SCC4, cmd) | CPM_CR_FLG;
-		break;
-	default:
-		return;
-
-	}
-	cp->cp_cpcr = val;
-	while (cp->cp_cpcr & CPM_CR_FLG) ;
-}
-
-void smc1_lineif(struct uart_cpm_port *pinfo)
-{
-	pinfo->brg = 1;
-}
-
-void smc2_lineif(struct uart_cpm_port *pinfo)
-{
-	pinfo->brg = 2;
-}
-
-void scc1_lineif(struct uart_cpm_port *pinfo)
-{
-	/* XXX SCC1: insert port configuration here */
-	pinfo->brg = 1;
-}
-
-void scc2_lineif(struct uart_cpm_port *pinfo)
-{
-	/* XXX SCC2: insert port configuration here */
-	pinfo->brg = 2;
-}
-
-void scc3_lineif(struct uart_cpm_port *pinfo)
-{
-	/* XXX SCC3: insert port configuration here */
-	pinfo->brg = 3;
-}
-
-void scc4_lineif(struct uart_cpm_port *pinfo)
-{
-	/* XXX SCC4: insert port configuration here */
-	pinfo->brg = 4;
-}
-#endif
-
 /*
  * Allocate DP-Ram and memory buffers. We need to allocate a transmit and
  * receive buffer descriptors from dual port ram, and a character
@@ -205,101 +135,3 @@ void cpm_uart_freebuf(struct uart_cpm_port *pinfo)
 
 	cpm_dpfree(pinfo->dp_addr);
 }
-
-#ifndef CONFIG_PPC_CPM_NEW_BINDING
-/* Setup any dynamic params in the uart desc */
-int cpm_uart_init_portdesc(void)
-{
-	pr_debug("CPM uart[-]:init portdesc\n");
-
-	cpm_uart_nr = 0;
-#ifdef CONFIG_SERIAL_CPM_SMC1
-	cpm_uart_ports[UART_SMC1].smcp = &cpmp->cp_smc[0];
-/*
- *  Is SMC1 being relocated?
- */
-# ifdef CONFIG_I2C_SPI_SMC1_UCODE_PATCH
-	cpm_uart_ports[UART_SMC1].smcup =
-	    (smc_uart_t *) & cpmp->cp_dparam[0x3C0];
-# else
-	cpm_uart_ports[UART_SMC1].smcup =
-	    (smc_uart_t *) & cpmp->cp_dparam[PROFF_SMC1];
-# endif
-	cpm_uart_ports[UART_SMC1].port.mapbase =
-	    (unsigned long)&cpmp->cp_smc[0];
-	cpm_uart_ports[UART_SMC1].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
-	cpm_uart_ports[UART_SMC1].smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
-	cpm_uart_ports[UART_SMC1].port.uartclk = uart_clock();
-	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC1;
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SMC2
-	cpm_uart_ports[UART_SMC2].smcp = &cpmp->cp_smc[1];
-	cpm_uart_ports[UART_SMC2].smcup =
-	    (smc_uart_t *) & cpmp->cp_dparam[PROFF_SMC2];
-	cpm_uart_ports[UART_SMC2].port.mapbase =
-	    (unsigned long)&cpmp->cp_smc[1];
-	cpm_uart_ports[UART_SMC2].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
-	cpm_uart_ports[UART_SMC2].smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
-	cpm_uart_ports[UART_SMC2].port.uartclk = uart_clock();
-	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC2;
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SCC1
-	cpm_uart_ports[UART_SCC1].sccp = &cpmp->cp_scc[0];
-	cpm_uart_ports[UART_SCC1].sccup =
-	    (scc_uart_t *) & cpmp->cp_dparam[PROFF_SCC1];
-	cpm_uart_ports[UART_SCC1].port.mapbase =
-	    (unsigned long)&cpmp->cp_scc[0];
-	cpm_uart_ports[UART_SCC1].sccp->scc_sccm &=
-	    ~(UART_SCCM_TX | UART_SCCM_RX);
-	cpm_uart_ports[UART_SCC1].sccp->scc_gsmrl &=
-	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC1].port.uartclk = uart_clock();
-	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC1;
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SCC2
-	cpm_uart_ports[UART_SCC2].sccp = &cpmp->cp_scc[1];
-	cpm_uart_ports[UART_SCC2].sccup =
-	    (scc_uart_t *) & cpmp->cp_dparam[PROFF_SCC2];
-	cpm_uart_ports[UART_SCC2].port.mapbase =
-	    (unsigned long)&cpmp->cp_scc[1];
-	cpm_uart_ports[UART_SCC2].sccp->scc_sccm &=
-	    ~(UART_SCCM_TX | UART_SCCM_RX);
-	cpm_uart_ports[UART_SCC2].sccp->scc_gsmrl &=
-	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC2].port.uartclk = uart_clock();
-	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC2;
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SCC3
-	cpm_uart_ports[UART_SCC3].sccp = &cpmp->cp_scc[2];
-	cpm_uart_ports[UART_SCC3].sccup =
-	    (scc_uart_t *) & cpmp->cp_dparam[PROFF_SCC3];
-	cpm_uart_ports[UART_SCC3].port.mapbase =
-	    (unsigned long)&cpmp->cp_scc[2];
-	cpm_uart_ports[UART_SCC3].sccp->scc_sccm &=
-	    ~(UART_SCCM_TX | UART_SCCM_RX);
-	cpm_uart_ports[UART_SCC3].sccp->scc_gsmrl &=
-	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC3].port.uartclk = uart_clock();
-	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC3;
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SCC4
-	cpm_uart_ports[UART_SCC4].sccp = &cpmp->cp_scc[3];
-	cpm_uart_ports[UART_SCC4].sccup =
-	    (scc_uart_t *) & cpmp->cp_dparam[PROFF_SCC4];
-	cpm_uart_ports[UART_SCC4].port.mapbase =
-	    (unsigned long)&cpmp->cp_scc[3];
-	cpm_uart_ports[UART_SCC4].sccp->scc_sccm &=
-	    ~(UART_SCCM_TX | UART_SCCM_RX);
-	cpm_uart_ports[UART_SCC4].sccp->scc_gsmrl &=
-	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC4].port.uartclk = uart_clock();
-	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC4;
-#endif
-	return 0;
-}
-#endif
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.h b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
index b805698..10eecd6 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.h
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
@@ -12,16 +12,6 @@
 
 #include <asm/cpm1.h>
 
-/* defines for IRQs */
-#ifndef CONFIG_PPC_CPM_NEW_BINDING
-#define SMC1_IRQ	(CPM_IRQ_OFFSET + CPMVEC_SMC1)
-#define SMC2_IRQ	(CPM_IRQ_OFFSET + CPMVEC_SMC2)
-#define SCC1_IRQ	(CPM_IRQ_OFFSET + CPMVEC_SCC1)
-#define SCC2_IRQ	(CPM_IRQ_OFFSET + CPMVEC_SCC2)
-#define SCC3_IRQ	(CPM_IRQ_OFFSET + CPMVEC_SCC3)
-#define SCC4_IRQ	(CPM_IRQ_OFFSET + CPMVEC_SCC4)
-#endif
-
 static inline void cpm_set_brg(int brg, int baud)
 {
 	cpm_setbrg(brg, baud);
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index e53524c..b8db4d3 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -41,9 +41,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/fs_pd.h>
-#ifdef CONFIG_PPC_CPM_NEW_BINDING
 #include <asm/prom.h>
-#endif
 
 #include <linux/serial_core.h>
 #include <linux/kernel.h>
@@ -52,7 +50,6 @@
 
 /**************************************************************/
 
-#ifdef CONFIG_PPC_CPM_NEW_BINDING
 void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd)
 {
 	cpm_command(port->command, cmd);
@@ -106,172 +103,6 @@ void cpm_uart_unmap_pram(struct uart_cpm_port *port, void __iomem *pram)
 		iounmap(pram);
 }
 
-#else
-void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd)
-{
-	ulong val;
-	int line = port - cpm_uart_ports;
-	volatile cpm_cpm2_t *cp = cpm2_map(im_cpm);
-
-
-	switch (line) {
-	case UART_SMC1:
-		val = mk_cr_cmd(CPM_CR_SMC1_PAGE, CPM_CR_SMC1_SBLOCK, 0,
-				cmd) | CPM_CR_FLG;
-		break;
-	case UART_SMC2:
-		val = mk_cr_cmd(CPM_CR_SMC2_PAGE, CPM_CR_SMC2_SBLOCK, 0,
-				cmd) | CPM_CR_FLG;
-		break;
-	case UART_SCC1:
-		val = mk_cr_cmd(CPM_CR_SCC1_PAGE, CPM_CR_SCC1_SBLOCK, 0,
-				cmd) | CPM_CR_FLG;
-		break;
-	case UART_SCC2:
-		val = mk_cr_cmd(CPM_CR_SCC2_PAGE, CPM_CR_SCC2_SBLOCK, 0,
-				cmd) | CPM_CR_FLG;
-		break;
-	case UART_SCC3:
-		val = mk_cr_cmd(CPM_CR_SCC3_PAGE, CPM_CR_SCC3_SBLOCK, 0,
-				cmd) | CPM_CR_FLG;
-		break;
-	case UART_SCC4:
-		val = mk_cr_cmd(CPM_CR_SCC4_PAGE, CPM_CR_SCC4_SBLOCK, 0,
-				cmd) | CPM_CR_FLG;
-		break;
-	default:
-		return;
-
-	}
-	cp->cp_cpcr = val;
-	while (cp->cp_cpcr & CPM_CR_FLG) ;
-
-	cpm2_unmap(cp);
-}
-
-void smc1_lineif(struct uart_cpm_port *pinfo)
-{
-	volatile iop_cpm2_t *io = cpm2_map(im_ioport);
-	volatile cpmux_t *cpmux = cpm2_map(im_cpmux);
-
-	/* SMC1 is only on port D */
-	io->iop_ppard |= 0x00c00000;
-	io->iop_pdird |= 0x00400000;
-	io->iop_pdird &= ~0x00800000;
-	io->iop_psord &= ~0x00c00000;
-
-	/* Wire BRG1 to SMC1 */
-	cpmux->cmx_smr &= 0x0f;
-	pinfo->brg = 1;
-
-	cpm2_unmap(cpmux);
-	cpm2_unmap(io);
-}
-
-void smc2_lineif(struct uart_cpm_port *pinfo)
-{
-	volatile iop_cpm2_t *io = cpm2_map(im_ioport);
-	volatile cpmux_t *cpmux = cpm2_map(im_cpmux);
-
-	/* SMC2 is only on port A */
-	io->iop_ppara |= 0x00c00000;
-	io->iop_pdira |= 0x00400000;
-	io->iop_pdira &= ~0x00800000;
-	io->iop_psora &= ~0x00c00000;
-
-	/* Wire BRG2 to SMC2 */
-	cpmux->cmx_smr &= 0xf0;
-	pinfo->brg = 2;
-
-	cpm2_unmap(cpmux);
-	cpm2_unmap(io);
-}
-
-void scc1_lineif(struct uart_cpm_port *pinfo)
-{
-	volatile iop_cpm2_t *io = cpm2_map(im_ioport);
-	volatile cpmux_t *cpmux = cpm2_map(im_cpmux);
-
-	/* Use Port D for SCC1 instead of other functions.  */
-	io->iop_ppard |= 0x00000003;
-	io->iop_psord &= ~0x00000001;	/* Rx */
-	io->iop_psord |= 0x00000002;	/* Tx */
-	io->iop_pdird &= ~0x00000001;	/* Rx */
-	io->iop_pdird |= 0x00000002;	/* Tx */
-
-	/* Wire BRG1 to SCC1 */
-	cpmux->cmx_scr &= 0x00ffffff;
-	cpmux->cmx_scr |= 0x00000000;
-	pinfo->brg = 1;
-
-	cpm2_unmap(cpmux);
-	cpm2_unmap(io);
-}
-
-void scc2_lineif(struct uart_cpm_port *pinfo)
-{
-	/*
-	 * STx GP3 uses the SCC2 secondary option pin assignment
-	 * which this driver doesn't account for in the static
-	 * pin assignments. This kind of board specific info
-	 * really has to get out of the driver so boards can
-	 * be supported in a sane fashion.
-	 */
-	volatile cpmux_t *cpmux = cpm2_map(im_cpmux);
-#ifndef CONFIG_STX_GP3
-	volatile iop_cpm2_t *io = cpm2_map(im_ioport);
-
-	io->iop_pparb |= 0x008b0000;
-	io->iop_pdirb |= 0x00880000;
-	io->iop_psorb |= 0x00880000;
-	io->iop_pdirb &= ~0x00030000;
-	io->iop_psorb &= ~0x00030000;
-#endif
-	cpmux->cmx_scr &= 0xff00ffff;
-	cpmux->cmx_scr |= 0x00090000;
-	pinfo->brg = 2;
-
-	cpm2_unmap(cpmux);
-	cpm2_unmap(io);
-}
-
-void scc3_lineif(struct uart_cpm_port *pinfo)
-{
-	volatile iop_cpm2_t *io = cpm2_map(im_ioport);
-	volatile cpmux_t *cpmux = cpm2_map(im_cpmux);
-
-	io->iop_pparb |= 0x008b0000;
-	io->iop_pdirb |= 0x00880000;
-	io->iop_psorb |= 0x00880000;
-	io->iop_pdirb &= ~0x00030000;
-	io->iop_psorb &= ~0x00030000;
-	cpmux->cmx_scr &= 0xffff00ff;
-	cpmux->cmx_scr |= 0x00001200;
-	pinfo->brg = 3;
-
-	cpm2_unmap(cpmux);
-	cpm2_unmap(io);
-}
-
-void scc4_lineif(struct uart_cpm_port *pinfo)
-{
-	volatile iop_cpm2_t *io = cpm2_map(im_ioport);
-	volatile cpmux_t *cpmux = cpm2_map(im_cpmux);
-
-	io->iop_ppard |= 0x00000600;
-	io->iop_psord &= ~0x00000600;	/* Tx/Rx */
-	io->iop_pdird &= ~0x00000200;	/* Rx */
-	io->iop_pdird |= 0x00000400;	/* Tx */
-
-	cpmux->cmx_scr &= 0xffffff00;
-	cpmux->cmx_scr |= 0x0000001b;
-	pinfo->brg = 4;
-
-	cpm2_unmap(cpmux);
-	cpm2_unmap(io);
-}
-#endif
-
 /*
  * Allocate DP-Ram and memory buffers. We need to allocate a transmit and
  * receive buffer descriptors from dual port ram, and a character
@@ -340,111 +171,3 @@ void cpm_uart_freebuf(struct uart_cpm_port *pinfo)
 
 	cpm_dpfree(pinfo->dp_addr);
 }
-
-#ifndef CONFIG_PPC_CPM_NEW_BINDING
-/* Setup any dynamic params in the uart desc */
-int cpm_uart_init_portdesc(void)
-{
-#if defined(CONFIG_SERIAL_CPM_SMC1) || defined(CONFIG_SERIAL_CPM_SMC2)
-	u16 *addr;
-#endif
-	pr_debug("CPM uart[-]:init portdesc\n");
-
-	cpm_uart_nr = 0;
-#ifdef CONFIG_SERIAL_CPM_SMC1
-	cpm_uart_ports[UART_SMC1].smcp = (smc_t *) cpm2_map(im_smc[0]);
-	cpm_uart_ports[UART_SMC1].port.mapbase =
-	    (unsigned long)cpm_uart_ports[UART_SMC1].smcp;
-
-	cpm_uart_ports[UART_SMC1].smcup =
-	    (smc_uart_t *) cpm2_map_size(im_dprambase[PROFF_SMC1], PROFF_SMC_SIZE);
-	addr = (u16 *)cpm2_map_size(im_dprambase[PROFF_SMC1_BASE], 2);
-	*addr = PROFF_SMC1;
-	cpm2_unmap(addr);
-
-	cpm_uart_ports[UART_SMC1].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
-	cpm_uart_ports[UART_SMC1].smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
-	cpm_uart_ports[UART_SMC1].port.uartclk = uart_clock();
-	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC1;
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SMC2
-	cpm_uart_ports[UART_SMC2].smcp = (smc_t *) cpm2_map(im_smc[1]);
-	cpm_uart_ports[UART_SMC2].port.mapbase =
-	    (unsigned long)cpm_uart_ports[UART_SMC2].smcp;
-
-	cpm_uart_ports[UART_SMC2].smcup =
-	    (smc_uart_t *) cpm2_map_size(im_dprambase[PROFF_SMC2], PROFF_SMC_SIZE);
-	addr = (u16 *)cpm2_map_size(im_dprambase[PROFF_SMC2_BASE], 2);
-	*addr = PROFF_SMC2;
-	cpm2_unmap(addr);
-
-	cpm_uart_ports[UART_SMC2].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
-	cpm_uart_ports[UART_SMC2].smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
-	cpm_uart_ports[UART_SMC2].port.uartclk = uart_clock();
-	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC2;
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SCC1
-	cpm_uart_ports[UART_SCC1].sccp = (scc_t *) cpm2_map(im_scc[0]);
-	cpm_uart_ports[UART_SCC1].port.mapbase =
-	    (unsigned long)cpm_uart_ports[UART_SCC1].sccp;
-	cpm_uart_ports[UART_SCC1].sccup =
-	    (scc_uart_t *) cpm2_map_size(im_dprambase[PROFF_SCC1], PROFF_SCC_SIZE);
-
-	cpm_uart_ports[UART_SCC1].sccp->scc_sccm &=
-	    ~(UART_SCCM_TX | UART_SCCM_RX);
-	cpm_uart_ports[UART_SCC1].sccp->scc_gsmrl &=
-	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC1].port.uartclk = uart_clock();
-	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC1;
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SCC2
-	cpm_uart_ports[UART_SCC2].sccp = (scc_t *) cpm2_map(im_scc[1]);
-	cpm_uart_ports[UART_SCC2].port.mapbase =
-	    (unsigned long)cpm_uart_ports[UART_SCC2].sccp;
-	cpm_uart_ports[UART_SCC2].sccup =
-	    (scc_uart_t *) cpm2_map_size(im_dprambase[PROFF_SCC2], PROFF_SCC_SIZE);
-
-	cpm_uart_ports[UART_SCC2].sccp->scc_sccm &=
-	    ~(UART_SCCM_TX | UART_SCCM_RX);
-	cpm_uart_ports[UART_SCC2].sccp->scc_gsmrl &=
-	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC2].port.uartclk = uart_clock();
-	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC2;
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SCC3
-	cpm_uart_ports[UART_SCC3].sccp = (scc_t *) cpm2_map(im_scc[2]);
-	cpm_uart_ports[UART_SCC3].port.mapbase =
-	    (unsigned long)cpm_uart_ports[UART_SCC3].sccp;
-	cpm_uart_ports[UART_SCC3].sccup =
-	    (scc_uart_t *) cpm2_map_size(im_dprambase[PROFF_SCC3], PROFF_SCC_SIZE);
-
-	cpm_uart_ports[UART_SCC3].sccp->scc_sccm &=
-	    ~(UART_SCCM_TX | UART_SCCM_RX);
-	cpm_uart_ports[UART_SCC3].sccp->scc_gsmrl &=
-	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC3].port.uartclk = uart_clock();
-	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC3;
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SCC4
-	cpm_uart_ports[UART_SCC4].sccp = (scc_t *) cpm2_map(im_scc[3]);
-	cpm_uart_ports[UART_SCC4].port.mapbase =
-	    (unsigned long)cpm_uart_ports[UART_SCC4].sccp;
-	cpm_uart_ports[UART_SCC4].sccup =
-	    (scc_uart_t *) cpm2_map_size(im_dprambase[PROFF_SCC4], PROFF_SCC_SIZE);
-
-	cpm_uart_ports[UART_SCC4].sccp->scc_sccm &=
-	    ~(UART_SCCM_TX | UART_SCCM_RX);
-	cpm_uart_ports[UART_SCC4].sccp->scc_gsmrl &=
-	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC4].port.uartclk = uart_clock();
-	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC4;
-#endif
-
-	return 0;
-}
-#endif
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.h b/drivers/serial/cpm_uart/cpm_uart_cpm2.h
index a48b56e..7194c63 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.h
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.h
@@ -12,16 +12,6 @@
 
 #include <asm/cpm2.h>
 
-/* defines for IRQs */
-#ifndef CONFIG_PPC_CPM_NEW_BINDING
-#define SMC1_IRQ	SIU_INT_SMC1
-#define SMC2_IRQ	SIU_INT_SMC2
-#define SCC1_IRQ	SIU_INT_SCC1
-#define SCC2_IRQ	SIU_INT_SCC2
-#define SCC3_IRQ	SIU_INT_SCC3
-#define SCC4_IRQ	SIU_INT_SCC4
-#endif
-
 static inline void cpm_set_brg(int brg, int baud)
 {
 	cpm_setbrg(brg, baud);
-- 
1.5.5.1
