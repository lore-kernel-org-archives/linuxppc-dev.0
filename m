Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 02F9ADE53D
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 06:24:30 +1000 (EST)
Date: Tue, 28 Aug 2007 15:16:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 2/4] cpm_uart: Be an of_platform device when
	CONFIG_PPC_CPM_NEW_BINDING is set.
Message-ID: <20070828201651.GB24234@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The existing OF glue code was crufty and broken.  Rather than fix it,
it has been removed, and the serial driver now talks to the device tree
directly.

The non-CONFIG_PPC_CPM_NEW_BINDING code can go away once CPM platforms
are dropped from arch/ppc (which will hopefully be soon), and existing
arch/powerpc boards that I wasn't able to test on for this patchset get
converted (which should be even sooner).

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 drivers/serial/cpm_uart/cpm_uart.h      |    6 +-
 drivers/serial/cpm_uart/cpm_uart_core.c |  241 ++++++++++++++++++++++++++++---
 drivers/serial/cpm_uart/cpm_uart_cpm1.c |   16 ++-
 drivers/serial/cpm_uart/cpm_uart_cpm1.h |    2 +
 drivers/serial/cpm_uart/cpm_uart_cpm2.c |   18 +++-
 drivers/serial/cpm_uart/cpm_uart_cpm2.h |    2 +
 6 files changed, 260 insertions(+), 25 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart.h b/drivers/serial/cpm_uart/cpm_uart.h
index a8f894c..4e1987a 100644
--- a/drivers/serial/cpm_uart/cpm_uart.h
+++ b/drivers/serial/cpm_uart/cpm_uart.h
@@ -80,14 +80,18 @@ struct uart_cpm_port {
 	int			is_portb;
 	/* wait on close if needed */
 	int 			wait_closing;
+	/* value to combine with opcode to form cpm command */
+	u32			command;
 };
 
+#ifndef CONFIG_PPC_CPM_NEW_BINDING
 extern int cpm_uart_port_map[UART_NR];
+#endif
 extern int cpm_uart_nr;
 extern struct uart_cpm_port cpm_uart_ports[UART_NR];
 
 /* these are located in their respective files */
-void cpm_line_cr_cmd(int line, int cmd);
+void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd);
 int cpm_uart_init_portdesc(void);
 int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con);
 void cpm_uart_freebuf(struct uart_cpm_port *pinfo);
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index cefde58..78171d0 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -10,7 +10,7 @@
  *  Maintainer: Kumar Gala (galak@kernel.crashing.org) (CPM2)
  *              Pantelis Antoniou (panto@intracom.gr) (CPM1)
  *
- *  Copyright (C) 2004 Freescale Semiconductor, Inc.
+ *  Copyright (C) 2004, 2007 Freescale Semiconductor, Inc.
  *            (C) 2004 Intracom, S.A.
  *            (C) 2005-2006 MontaVista Software, Inc.
  * 		Vitaly Bordug <vbordug@ru.mvista.com>
@@ -47,6 +47,11 @@
 #include <asm/irq.h>
 #include <asm/delay.h>
 #include <asm/fs_pd.h>
+#include <asm/udbg.h>
+
+#ifdef CONFIG_PPC_CPM_NEW_BINDING
+#include <asm/of_platform.h>
+#endif
 
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
@@ -57,12 +62,6 @@
 
 #include "cpm_uart.h"
 
-/***********************************************************************/
-
-/* Track which ports are configured as uarts */
-int cpm_uart_port_map[UART_NR];
-/* How many ports did we config as uarts */
-int cpm_uart_nr = 0;
 
 /**************************************************************/
 
@@ -73,6 +72,11 @@ static void cpm_uart_initbd(struct uart_cpm_port *pinfo);
 
 /**************************************************************/
 
+#ifndef CONFIG_PPC_CPM_NEW_BINDING
+/* Track which ports are configured as uarts */
+int cpm_uart_port_map[UART_NR];
+/* How many ports did we config as uarts */
+int cpm_uart_nr;
 
 /* Place-holder for board-specific stuff */
 struct platform_device* __attribute__ ((weak)) __init
@@ -119,6 +123,7 @@ static int cpm_uart_id2nr(int id)
 	/* not found or invalid argument */
 	return -1;
 }
+#endif
 
 /*
  * Check, if transmit buffers are processed
@@ -232,15 +237,14 @@ static void cpm_uart_enable_ms(struct uart_port *port)
 static void cpm_uart_break_ctl(struct uart_port *port, int break_state)
 {
 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
-	int line = pinfo - cpm_uart_ports;
 
 	pr_debug("CPM uart[%d]:break ctrl, break_state: %d\n", port->line,
 		break_state);
 
 	if (break_state)
-		cpm_line_cr_cmd(line, CPM_CR_STOP_TX);
+		cpm_line_cr_cmd(pinfo, CPM_CR_STOP_TX);
 	else
-		cpm_line_cr_cmd(line, CPM_CR_RESTART_TX);
+		cpm_line_cr_cmd(pinfo, CPM_CR_RESTART_TX);
 }
 
 /*
@@ -407,7 +411,6 @@ static int cpm_uart_startup(struct uart_port *port)
 {
 	int retval;
 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
-	int line = pinfo - cpm_uart_ports;
 
 	pr_debug("CPM uart[%d]:startup\n", port->line);
 
@@ -426,7 +429,7 @@ static int cpm_uart_startup(struct uart_port *port)
 	}
 
 	if (!(pinfo->flags & FLAG_CONSOLE))
-		cpm_line_cr_cmd(line,CPM_CR_INIT_TRX);
+		cpm_line_cr_cmd(pinfo, CPM_CR_INIT_TRX);
 	return 0;
 }
 
@@ -442,7 +445,6 @@ inline void cpm_uart_wait_until_send(struct uart_cpm_port *pinfo)
 static void cpm_uart_shutdown(struct uart_port *port)
 {
 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
-	int line = pinfo - cpm_uart_ports;
 
 	pr_debug("CPM uart[%d]:shutdown\n", port->line);
 
@@ -473,9 +475,9 @@ static void cpm_uart_shutdown(struct uart_port *port)
 
 		/* Shut them really down and reinit buffer descriptors */
 		if (IS_SMC(pinfo))
-			cpm_line_cr_cmd(line, CPM_CR_STOP_TX);
+			cpm_line_cr_cmd(pinfo, CPM_CR_STOP_TX);
 		else
-			cpm_line_cr_cmd(line, CPM_CR_GRA_STOP_TX);
+			cpm_line_cr_cmd(pinfo, CPM_CR_GRA_STOP_TX);
 
 		cpm_uart_initbd(pinfo);
 	}
@@ -595,7 +597,6 @@ static void cpm_uart_set_termios(struct uart_port *port,
 
 	cpm_set_brg(pinfo->brg - 1, baud);
 	spin_unlock_irqrestore(&port->lock, flags);
-
 }
 
 static const char *cpm_uart_type(struct uart_port *port)
@@ -742,7 +743,6 @@ static void cpm_uart_initbd(struct uart_cpm_port *pinfo)
 
 static void cpm_uart_init_scc(struct uart_cpm_port *pinfo)
 {
-	int line = pinfo - cpm_uart_ports;
 	volatile scc_t *scp;
 	volatile scc_uart_t *sup;
 
@@ -783,7 +783,7 @@ static void cpm_uart_init_scc(struct uart_cpm_port *pinfo)
 
 	/* Send the CPM an initialize command.
 	 */
-	cpm_line_cr_cmd(line, CPM_CR_INIT_TRX);
+	cpm_line_cr_cmd(pinfo, CPM_CR_INIT_TRX);
 
 	/* Set UART mode, 8 bit, no parity, one stop.
 	 * Enable receive and transmit.
@@ -803,7 +803,6 @@ static void cpm_uart_init_scc(struct uart_cpm_port *pinfo)
 
 static void cpm_uart_init_smc(struct uart_cpm_port *pinfo)
 {
-	int line = pinfo - cpm_uart_ports;
 	volatile smc_t *sp;
 	volatile smc_uart_t *up;
 
@@ -840,7 +839,7 @@ static void cpm_uart_init_smc(struct uart_cpm_port *pinfo)
 	up->smc_brkec = 0;
 	up->smc_brkcr = 1;
 
-	cpm_line_cr_cmd(line, CPM_CR_INIT_TRX);
+	cpm_line_cr_cmd(pinfo, CPM_CR_INIT_TRX);
 
 	/* Set UART mode, 8 bit, no parity, one stop.
 	 * Enable receive and transmit.
@@ -929,6 +928,85 @@ static struct uart_ops cpm_uart_pops = {
 	.verify_port	= cpm_uart_verify_port,
 };
 
+#ifdef CONFIG_PPC_CPM_NEW_BINDING
+struct uart_cpm_port cpm_uart_ports[UART_NR];
+
+int cpm_uart_init_port(struct device_node *np, struct uart_cpm_port *pinfo)
+{
+	const u32 *data;
+	void __iomem *mem, __iomem *pram;
+	int len;
+	int ret;
+
+	data = of_get_property(np, "fsl,cpm-brg", &len);
+	if (!data || len != 4) {
+		printk(KERN_ERR "CPM UART %s has no/invalid "
+		                "fsl,cpm-brg property.\n", np->name);
+		return -EINVAL;
+	}
+	pinfo->brg = *data;
+
+	data = of_get_property(np, "fsl,cpm-command", &len);
+	if (!data || len != 4) {
+		printk(KERN_ERR "CPM UART %s has no/invalid "
+		                "fsl,cpm-command property.\n", np->name);
+		return -EINVAL;
+	}
+	pinfo->command = *data;
+
+	mem = of_iomap(np, 0);
+	if (!mem)
+		return -ENOMEM;
+
+	pram = of_iomap(np, 1);
+	if (!pram) {
+		ret = -ENOMEM;
+		goto out_mem;
+	}
+
+	if (of_device_is_compatible(np, "fsl,cpm1-scc-uart") ||
+	    of_device_is_compatible(np, "fsl,cpm2-scc-uart")) {
+		pinfo->sccp = mem;
+		pinfo->sccup = pram;
+	} else if (of_device_is_compatible(np, "fsl,cpm1-smc-uart") ||
+	           of_device_is_compatible(np, "fsl,cpm2-smc-uart")) {
+		pinfo->flags |= FLAG_SMC;
+		pinfo->smcp = mem;
+		pinfo->smcup = pram;
+	} else {
+		ret = -ENODEV;
+		goto out_pram;
+	}
+
+	pinfo->tx_nrfifos = TX_NUM_FIFO;
+	pinfo->tx_fifosize = TX_BUF_SIZE;
+	pinfo->rx_nrfifos = RX_NUM_FIFO;
+	pinfo->rx_fifosize = RX_BUF_SIZE;
+
+	pinfo->port.uartclk = ppc_proc_freq;
+	pinfo->port.mapbase = (unsigned long)mem;
+	pinfo->port.type = PORT_CPM;
+	pinfo->port.ops = &cpm_uart_pops,
+	pinfo->port.iotype = UPIO_MEM;
+	spin_lock_init(&pinfo->port.lock);
+
+	pinfo->port.irq = of_irq_to_resource(np, 0, NULL);
+	if (pinfo->port.irq == NO_IRQ) {
+		ret = -EINVAL;
+		goto out_pram;
+	}
+
+	return cpm_uart_request_port(&pinfo->port);
+
+out_pram:
+	iounmap(pram);
+out_mem:
+	iounmap(mem);
+	return ret;
+}
+
+#else
+
 struct uart_cpm_port cpm_uart_ports[UART_NR] = {
 	[UART_SMC1] = {
 		.port = {
@@ -1072,6 +1150,7 @@ int cpm_uart_drv_get_platform_data(struct platform_device *pdev, int is_con)
 
 	return 0;
 }
+#endif
 
 #ifdef CONFIG_SERIAL_CPM_CONSOLE
 /*
@@ -1083,8 +1162,12 @@ int cpm_uart_drv_get_platform_data(struct platform_device *pdev, int is_con)
 static void cpm_uart_console_write(struct console *co, const char *s,
 				   u_int count)
 {
+#ifdef CONFIG_PPC_CPM_NEW_BINDING
+	struct uart_cpm_port *pinfo = &cpm_uart_ports[co->index];
+#else
 	struct uart_cpm_port *pinfo =
 	    &cpm_uart_ports[cpm_uart_port_map[co->index]];
+#endif
 	unsigned int i;
 	volatile cbd_t *bdp, *bdbase;
 	volatile unsigned char *cp;
@@ -1155,13 +1238,47 @@ static void cpm_uart_console_write(struct console *co, const char *s,
 
 static int __init cpm_uart_console_setup(struct console *co, char *options)
 {
-	struct uart_port *port;
-	struct uart_cpm_port *pinfo;
 	int baud = 38400;
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
 	int ret;
+	struct uart_cpm_port *pinfo;
+	struct uart_port *port;
+
+#ifdef CONFIG_PPC_CPM_NEW_BINDING
+	struct device_node *np = NULL;
+	int i = 0;
+
+	if (co->index >= UART_NR) {
+		printk(KERN_ERR "cpm_uart: console index %d too high\n",
+		       co->index);
+		return -ENODEV;
+	}
+
+	do {
+		np = of_find_node_by_type(np, "serial");
+		if (!np)
+			return -ENODEV;
+
+		if (!of_device_is_compatible(np, "fsl,cpm1-smc-uart") &&
+		    !of_device_is_compatible(np, "fsl,cpm1-scc-uart") &&
+		    !of_device_is_compatible(np, "fsl,cpm2-smc-uart") &&
+		    !of_device_is_compatible(np, "fsl,cpm2-scc-uart"))
+			i--;
+	} while (i++ != co->index);
+
+	pinfo = &cpm_uart_ports[co->index];
+
+	pinfo->flags |= FLAG_CONSOLE;
+	port = &pinfo->port;
+
+	ret = cpm_uart_init_port(np, pinfo);
+	of_node_put(np);
+	if (ret)
+		return ret;
+
+#else
 
 	struct fs_uart_platform_info *pdata;
 	struct platform_device* pdev = early_uart_get_pdev(co->index);
@@ -1188,6 +1305,7 @@ static int __init cpm_uart_console_setup(struct console *co, char *options)
 	}
 
 	pinfo->flags |= FLAG_CONSOLE;
+#endif
 
 	if (options) {
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
@@ -1196,6 +1314,10 @@ static int __init cpm_uart_console_setup(struct console *co, char *options)
 			baud = 9600;
 	}
 
+#ifdef CONFIG_PPC_EARLY_DEBUG_CPM
+	udbg_putc = NULL;
+#endif
+
 	if (IS_SMC(pinfo)) {
 		pinfo->smcp->smc_smcm &= ~(SMCM_RX | SMCM_TX);
 		pinfo->smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
@@ -1252,7 +1374,81 @@ static struct uart_driver cpm_reg = {
 	.major		= SERIAL_CPM_MAJOR,
 	.minor		= SERIAL_CPM_MINOR,
 	.cons		= CPM_UART_CONSOLE,
+	.nr		= UART_NR,
+};
+
+#ifdef CONFIG_PPC_CPM_NEW_BINDING
+static int probe_index;
+
+static int __devinit cpm_uart_probe(struct of_device *ofdev,
+                                    const struct of_device_id *match)
+{
+	int index = probe_index++;
+	struct uart_cpm_port *pinfo = &cpm_uart_ports[index];
+	int ret;
+
+	pinfo->port.line = index;
+
+	if (index >= UART_NR)
+		return -ENODEV;
+
+	dev_set_drvdata(&ofdev->dev, pinfo);
+
+	ret = cpm_uart_init_port(ofdev->node, pinfo);
+	if (ret)
+		return ret;
+
+	return uart_add_one_port(&cpm_reg, &pinfo->port);
+}
+
+static int __devexit cpm_uart_remove(struct of_device *ofdev)
+{
+	struct uart_cpm_port *pinfo = dev_get_drvdata(&ofdev->dev);
+	return uart_remove_one_port(&cpm_reg, &pinfo->port);
+}
+
+static struct of_device_id cpm_uart_match[] = {
+	{
+		.compatible = "fsl,cpm1-smc-uart",
+	},
+	{
+		.compatible = "fsl,cpm1-scc-uart",
+	},
+	{
+		.compatible = "fsl,cpm2-smc-uart",
+	},
+	{
+		.compatible = "fsl,cpm2-scc-uart",
+	},
+	{}
 };
+
+static struct of_platform_driver cpm_uart_driver = {
+	.name = "cpm_uart",
+	.match_table = cpm_uart_match,
+	.probe = cpm_uart_probe,
+	.remove = cpm_uart_remove,
+ };
+
+static int __init cpm_uart_init(void)
+{
+	int ret = uart_register_driver(&cpm_reg);
+	if (ret)
+		return ret;
+
+	ret = of_register_platform_driver(&cpm_uart_driver);
+	if (ret)
+		uart_unregister_driver(&cpm_reg);
+
+	return ret;
+}
+
+static void __exit cpm_uart_exit(void)
+{
+	of_unregister_platform_driver(&cpm_uart_driver);
+	uart_unregister_driver(&cpm_reg);
+}
+#else
 static int cpm_uart_drv_probe(struct device *dev)
 {
 	struct platform_device  *pdev = to_platform_device(dev);
@@ -1380,6 +1576,7 @@ static void __exit cpm_uart_exit(void)
 	driver_unregister(&cpm_smc_uart_driver);
 	uart_unregister_driver(&cpm_reg);
 }
+#endif
 
 module_init(cpm_uart_init);
 module_exit(cpm_uart_exit);
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
index 8c6324e..4647f55 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
@@ -49,9 +49,20 @@
 
 /**************************************************************/
 
-void cpm_line_cr_cmd(int line, int cmd)
+#ifdef CONFIG_PPC_CPM_NEW_BINDING
+void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd)
+{
+	u16 __iomem *cpcr = &cpmp->cp_cpcr;
+
+	out_be16(cpcr, port->command | (cmd << 8) | CPM_CR_FLG);
+	while (in_be16(cpcr) & CPM_CR_FLG)
+		;
+}
+#else
+void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd)
 {
 	ushort val;
+	int line = port - cpm_uart_ports;
 	volatile cpm8xx_t *cp = cpmp;
 
 	switch (line) {
@@ -114,6 +125,7 @@ void scc4_lineif(struct uart_cpm_port *pinfo)
 	/* XXX SCC4: insert port configuration here */
 	pinfo->brg = 4;
 }
+#endif
 
 /*
  * Allocate DP-Ram and memory buffers. We need to allocate a transmit and
@@ -184,6 +196,7 @@ void cpm_uart_freebuf(struct uart_cpm_port *pinfo)
 	cpm_dpfree(pinfo->dp_addr);
 }
 
+#ifndef CONFIG_PPC_CPM_NEW_BINDING
 /* Setup any dynamic params in the uart desc */
 int cpm_uart_init_portdesc(void)
 {
@@ -279,3 +292,4 @@ int cpm_uart_init_portdesc(void)
 #endif
 	return 0;
 }
+#endif
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.h b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
index a99e45e..cdc9b22 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.h
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
@@ -13,12 +13,14 @@
 #include <asm/commproc.h>
 
 /* defines for IRQs */
+#ifndef CONFIG_PPC_CPM_NEW_BINDING
 #define SMC1_IRQ	(CPM_IRQ_OFFSET + CPMVEC_SMC1)
 #define SMC2_IRQ	(CPM_IRQ_OFFSET + CPMVEC_SMC2)
 #define SCC1_IRQ	(CPM_IRQ_OFFSET + CPMVEC_SCC1)
 #define SCC2_IRQ	(CPM_IRQ_OFFSET + CPMVEC_SCC2)
 #define SCC3_IRQ	(CPM_IRQ_OFFSET + CPMVEC_SCC3)
 #define SCC4_IRQ	(CPM_IRQ_OFFSET + CPMVEC_SCC4)
+#endif
 
 static inline void cpm_set_brg(int brg, int baud)
 {
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index 7b61d80..7ebce26 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -49,9 +49,22 @@
 
 /**************************************************************/
 
-void cpm_line_cr_cmd(int line, int cmd)
+#ifdef CONFIG_PPC_CPM_NEW_BINDING
+void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd)
+{
+	cpm_cpm2_t __iomem *cp = cpm2_map(im_cpm);
+
+	out_be32(&cp->cp_cpcr, port->command | cmd | CPM_CR_FLG);
+	while (in_be32(&cp->cp_cpcr) & CPM_CR_FLG)
+		;
+
+	cpm2_unmap(cp);
+}
+#else
+void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd)
 {
 	ulong val;
+	int line = port - cpm_uart_ports;
 	volatile cpm_cpm2_t *cp = cpm2_map(im_cpm);
 
 
@@ -211,6 +224,7 @@ void scc4_lineif(struct uart_cpm_port *pinfo)
 	cpm2_unmap(cpmux);
 	cpm2_unmap(io);
 }
+#endif
 
 /*
  * Allocate DP-Ram and memory buffers. We need to allocate a transmit and 
@@ -281,6 +295,7 @@ void cpm_uart_freebuf(struct uart_cpm_port *pinfo)
 	cpm_dpfree(pinfo->dp_addr);
 }
 
+#ifndef CONFIG_PPC_CPM_NEW_BINDING
 /* Setup any dynamic params in the uart desc */
 int cpm_uart_init_portdesc(void)
 {
@@ -386,3 +401,4 @@ int cpm_uart_init_portdesc(void)
 
 	return 0;
 }
+#endif
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.h b/drivers/serial/cpm_uart/cpm_uart_cpm2.h
index 1b3219f..e7717ec 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.h
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.h
@@ -13,12 +13,14 @@
 #include <asm/cpm2.h>
 
 /* defines for IRQs */
+#ifndef CONFIG_PPC_CPM_NEW_BINDING
 #define SMC1_IRQ	SIU_INT_SMC1
 #define SMC2_IRQ	SIU_INT_SMC2
 #define SCC1_IRQ	SIU_INT_SCC1
 #define SCC2_IRQ	SIU_INT_SCC2
 #define SCC3_IRQ	SIU_INT_SCC3
 #define SCC4_IRQ	SIU_INT_SCC4
+#endif
 
 static inline void cpm_set_brg(int brg, int baud)
 {
-- 
1.5.0.3
