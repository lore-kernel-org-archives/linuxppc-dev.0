Return-Path: <jrigby@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 351BBDDEE6
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 11:05:50 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m0I05iG9008432
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 17:05:45 -0700 (MST)
Received: from localhost.localdomain (mvp-10-214-72-199.am.freescale.net
	[10.214.72.199])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m0I05dKF028206
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 18:05:44 -0600 (CST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [Add mpc5121 support PATCH v3 8/8] Add MPC512x support to MPC52xx psc
	driver
Date: Thu, 17 Jan 2008 17:05:38 -0700
Message-Id: <1200614738-25654-9-git-send-email-jrigby@freescale.com>
In-Reply-To: <1200614738-25654-8-git-send-email-jrigby@freescale.com>
References: <1200614738-25654-1-git-send-email-jrigby@freescale.com>
	<1200614738-25654-2-git-send-email-jrigby@freescale.com>
	<1200614738-25654-3-git-send-email-jrigby@freescale.com>
	<1200614738-25654-4-git-send-email-jrigby@freescale.com>
	<1200614738-25654-5-git-send-email-jrigby@freescale.com>
	<1200614738-25654-6-git-send-email-jrigby@freescale.com>
	<1200614738-25654-7-git-send-email-jrigby@freescale.com>
	<1200614738-25654-8-git-send-email-jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add 512x support using the psc_ops framework established
with the previous patch.

All 512x PSCs share the same interrupt so add
IRQF_SHARED to irq flags.

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 drivers/serial/Kconfig            |   12 ++--
 drivers/serial/mpc52xx_uart.c     |  177 +++++++++++++++++++++++++++++++++++--
 include/asm-powerpc/mpc52xx_psc.h |   48 ++++++++++
 3 files changed, 222 insertions(+), 15 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index d7e1996..c7a4ba9 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -1114,17 +1114,17 @@ config SERIAL_SGI_L1_CONSOLE
 		say Y.  Otherwise, say N.
 
 config SERIAL_MPC52xx
-	tristate "Freescale MPC52xx family PSC serial support"
-	depends on PPC_MPC52xx
+	tristate "Freescale MPC52xx/MPC512x family PSC serial support"
+	depends on PPC_MPC52xx || PPC_MPC512x
 	select SERIAL_CORE
 	help
-	  This drivers support the MPC52xx PSC serial ports. If you would
-	  like to use them, you must answer Y or M to this option. Not that
+	  This driver supports MPC52xx and MPC512x PSC serial ports. If you would
+	  like to use them, you must answer Y or M to this option. Note that
 	  for use as console, it must be included in kernel and not as a
 	  module.
 
 config SERIAL_MPC52xx_CONSOLE
-	bool "Console on a Freescale MPC52xx family PSC serial port"
+	bool "Console on a Freescale MPC52xx/MPC512x family PSC serial port"
 	depends on SERIAL_MPC52xx=y
 	select SERIAL_CORE_CONSOLE
 	help
@@ -1132,7 +1132,7 @@ config SERIAL_MPC52xx_CONSOLE
 	  of the Freescale MPC52xx family as a console.
 
 config SERIAL_MPC52xx_CONSOLE_BAUD
-	int "Freescale MPC52xx family PSC serial port baud"
+	int "Freescale MPC52xx/MPC512x family PSC serial port baud"
 	depends on SERIAL_MPC52xx_CONSOLE=y
 	default "9600"
 	help
diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 0f6036b..fd1afcc 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -16,6 +16,9 @@
  * Some of the code has been inspired/copied from the 2.4 code written
  * by Dale Farnsworth <dfarnsworth@mvista.com>.
  *
+ * Copyright (C) 2008 Freescale Semiconductor Inc.
+ *                    John Rigby <jrigby@gmail.com>
+ * Added support for MPC5121
  * Copyright (C) 2006 Secret Lab Technologies Ltd.
  *                    Grant Likely <grant.likely@secretlab.ca>
  * Copyright (C) 2004-2006 Sylvain Munaut <tnt@246tNt.com>
@@ -77,6 +80,7 @@
 #endif
 
 #include <asm/mpc52xx.h>
+#include <asm/mpc512x.h>
 #include <asm/mpc52xx_psc.h>
 
 #if defined(CONFIG_SERIAL_MPC52xx_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
@@ -126,12 +130,6 @@ static irqreturn_t mpc52xx_uart_int(int irq, void *dev_id);
 #define uart_console(port)	(0)
 #endif
 
-#if defined(CONFIG_PPC_MERGE)
-static const struct of_device_id mpc52xx_uart_of_match[] = {
-	{ .type = "serial", .compatible = "mpc5200-psc-uart", },
-	{},
-};
-#endif
 
 /* ======================================================================== */
 /* PSC fifo operations for isolating differences between 52xx and 512x      */
@@ -156,6 +154,7 @@ struct psc_ops {
 	unsigned long	(*getuartclk)(void *p);
 };
 
+#ifdef CONFIG_PPC_MPC52xx
 #define FIFO_52xx(port) ((struct mpc52xx_psc_fifo __iomem *)(PSC(port)+1))
 static void mpc52xx_psc_fifo_init(struct uart_port *port)
 {
@@ -288,7 +287,161 @@ static struct psc_ops mpc52xx_psc_ops = {
 	.getuartclk = mpc52xx_getuartclk,
 };
 
-static struct psc_ops *psc_ops = &mpc52xx_psc_ops;
+#endif /* CONFIG_MPC52xx */
+
+#ifdef CONFIG_PPC_MPC512x
+#define FIFO_512x(port) ((struct mpc512x_psc_fifo __iomem *)(PSC(port)+1))
+static void mpc512x_psc_fifo_init(struct uart_port *port)
+{
+	out_be32(&FIFO_512x(port)->txcmd, MPC512x_PSC_FIFO_RESET_SLICE);
+	out_be32(&FIFO_512x(port)->txcmd, MPC512x_PSC_FIFO_ENABLE_SLICE);
+	out_be32(&FIFO_512x(port)->txalarm, 1);
+	out_be32(&FIFO_512x(port)->tximr, 0);
+
+	out_be32(&FIFO_512x(port)->rxcmd, MPC512x_PSC_FIFO_RESET_SLICE);
+	out_be32(&FIFO_512x(port)->rxcmd, MPC512x_PSC_FIFO_ENABLE_SLICE);
+	out_be32(&FIFO_512x(port)->rxalarm, 1);
+	out_be32(&FIFO_512x(port)->rximr, 0);
+
+	out_be32(&FIFO_512x(port)->tximr, MPC512x_PSC_FIFO_ALARM);
+	out_be32(&FIFO_512x(port)->rximr, MPC512x_PSC_FIFO_ALARM);
+}
+
+static int mpc512x_psc_raw_rx_rdy(struct uart_port *port)
+{
+	return !(in_be32(&FIFO_512x(port)->rxsr) & MPC512x_PSC_FIFO_EMPTY);
+}
+
+static int mpc512x_psc_raw_tx_rdy(struct uart_port *port)
+{
+	return !(in_be32(&FIFO_512x(port)->txsr) & MPC512x_PSC_FIFO_FULL);
+}
+
+static int mpc512x_psc_rx_rdy(struct uart_port *port)
+{
+	return in_be32(&FIFO_512x(port)->rxsr)
+	    & in_be32(&FIFO_512x(port)->rximr)
+	    & MPC512x_PSC_FIFO_ALARM;
+}
+
+static int mpc512x_psc_tx_rdy(struct uart_port *port)
+{
+	return in_be32(&FIFO_512x(port)->txsr)
+	    & in_be32(&FIFO_512x(port)->tximr)
+	    & MPC512x_PSC_FIFO_ALARM;
+}
+
+static int mpc512x_psc_tx_empty(struct uart_port *port)
+{
+	return in_be32(&FIFO_512x(port)->txsr)
+	    & MPC512x_PSC_FIFO_EMPTY;
+}
+
+static void mpc512x_psc_stop_rx(struct uart_port *port)
+{
+	unsigned long rx_fifo_imr;
+
+	rx_fifo_imr = in_be32(&FIFO_512x(port)->rximr);
+	rx_fifo_imr &= ~MPC512x_PSC_FIFO_ALARM;
+	out_be32(&FIFO_512x(port)->rximr, rx_fifo_imr);
+}
+
+static void mpc512x_psc_start_tx(struct uart_port *port)
+{
+	unsigned long tx_fifo_imr;
+
+	tx_fifo_imr = in_be32(&FIFO_512x(port)->tximr);
+	tx_fifo_imr |= MPC512x_PSC_FIFO_ALARM;
+	out_be32(&FIFO_512x(port)->tximr, tx_fifo_imr);
+}
+
+static void mpc512x_psc_stop_tx(struct uart_port *port)
+{
+	unsigned long tx_fifo_imr;
+
+	tx_fifo_imr = in_be32(&FIFO_512x(port)->tximr);
+	tx_fifo_imr &= ~MPC512x_PSC_FIFO_ALARM;
+	out_be32(&FIFO_512x(port)->tximr, tx_fifo_imr);
+}
+
+static void mpc512x_psc_rx_clr_irq(struct uart_port *port)
+{
+	out_be32(&FIFO_512x(port)->rxisr, in_be32(&FIFO_512x(port)->rxisr));
+}
+
+static void mpc512x_psc_tx_clr_irq(struct uart_port *port)
+{
+	out_be32(&FIFO_512x(port)->txisr, in_be32(&FIFO_512x(port)->txisr));
+}
+
+static void mpc512x_psc_write_char(struct uart_port *port, unsigned char c)
+{
+	out_8(&FIFO_512x(port)->txdata_8, c);
+}
+
+static unsigned char mpc512x_psc_read_char(struct uart_port *port)
+{
+	return in_8(&FIFO_512x(port)->rxdata_8);
+}
+
+static void mpc512x_psc_cw_disable_ints(struct uart_port *port)
+{
+	port->read_status_mask =
+		in_be32(&FIFO_512x(port)->tximr) << 16 |
+		in_be32(&FIFO_512x(port)->rximr);
+	out_be32(&FIFO_512x(port)->tximr, 0);
+	out_be32(&FIFO_512x(port)->rximr, 0);
+}
+
+static void mpc512x_psc_cw_restore_ints(struct uart_port *port)
+{
+	out_be32(&FIFO_512x(port)->tximr,
+		(port->read_status_mask >> 16) & 0x7f);
+	out_be32(&FIFO_512x(port)->rximr, port->read_status_mask & 0x7f);
+}
+
+static unsigned long mpc512x_getuartclk(void *p)
+{
+	return mpc512x_find_ips_freq(p);
+}
+
+static struct psc_ops mpc512x_psc_ops = {
+	.fifo_init = mpc512x_psc_fifo_init,
+	.raw_rx_rdy = mpc512x_psc_raw_rx_rdy,
+	.raw_tx_rdy = mpc512x_psc_raw_tx_rdy,
+	.rx_rdy = mpc512x_psc_rx_rdy,
+	.tx_rdy = mpc512x_psc_tx_rdy,
+	.tx_empty = mpc512x_psc_tx_empty,
+	.stop_rx = mpc512x_psc_stop_rx,
+	.start_tx = mpc512x_psc_start_tx,
+	.stop_tx = mpc512x_psc_stop_tx,
+	.rx_clr_irq = mpc512x_psc_rx_clr_irq,
+	.tx_clr_irq = mpc512x_psc_tx_clr_irq,
+	.write_char = mpc512x_psc_write_char,
+	.read_char = mpc512x_psc_read_char,
+	.cw_disable_ints = mpc512x_psc_cw_disable_ints,
+	.cw_restore_ints = mpc512x_psc_cw_restore_ints,
+	.getuartclk = mpc512x_getuartclk,
+};
+#endif
+
+static struct psc_ops *psc_ops;
+
+#if defined(CONFIG_PPC_MERGE)
+static const struct of_device_id mpc52xx_uart_of_match[] = {
+#ifdef CONFIG_PPC_MPC52xx
+	{.type = "serial",
+	 .compatible = "mpc5200-psc-uart",
+	 .data = &mpc52xx_psc_ops},
+#endif
+#ifdef CONFIG_PPC_MPC512x
+	{.type = "serial",
+	 .compatible = "fsl,mpc5121-psc-uart",
+	 .data = &mpc512x_psc_ops},
+#endif
+	{},
+};
+#endif
 
 /* ======================================================================== */
 /* UART operations                                                          */
@@ -378,7 +531,8 @@ mpc52xx_uart_startup(struct uart_port *port)
 
 	/* Request IRQ */
 	ret = request_irq(port->irq, mpc52xx_uart_int,
-		IRQF_DISABLED | IRQF_SAMPLE_RANDOM, "mpc52xx_psc_uart", port);
+		IRQF_DISABLED | IRQF_SAMPLE_RANDOM | IRQF_SHARED,
+		"mpc52xx_psc_uart", port);
 	if (ret)
 		return ret;
 
@@ -1205,15 +1359,19 @@ mpc52xx_uart_of_enumerate(void)
 	static int enum_done;
 	struct device_node *np;
 	const unsigned int *devno;
+	const struct  of_device_id *match;
 	int i;
 
 	if (enum_done)
 		return;
 
 	for_each_node_by_type(np, "serial") {
-		if (!of_match_node(mpc52xx_uart_of_match, np))
+		match = of_match_node(mpc52xx_uart_of_match, np);
+		if (!match)
 			continue;
 
+		psc_ops = match->data;
+
 		/* Is a particular device number requested? */
 		devno = of_get_property(np, "port-number", NULL);
 		mpc52xx_uart_of_assign(np, devno ? *devno : -1);
@@ -1274,6 +1432,7 @@ mpc52xx_uart_init(void)
 		return ret;
 	}
 #else
+	psc_ops = &mpc52xx_psc_ops;
 	ret = platform_driver_register(&mpc52xx_uart_platform_driver);
 	if (ret) {
 		printk(KERN_ERR "%s: platform_driver_register failed (%i)\n",
diff --git a/include/asm-powerpc/mpc52xx_psc.h b/include/asm-powerpc/mpc52xx_psc.h
index bea42b9..710c5d3 100644
--- a/include/asm-powerpc/mpc52xx_psc.h
+++ b/include/asm-powerpc/mpc52xx_psc.h
@@ -190,5 +190,53 @@ struct mpc52xx_psc_fifo {
 	u16		tflwfptr;	/* PSC + 0x9e */
 };
 
+#define MPC512x_PSC_FIFO_RESET_SLICE	0x80
+#define MPC512x_PSC_FIFO_ENABLE_SLICE	0x01
+#define MPC512x_PSC_FIFO_ENABLE_DMA	0x04
+
+#define MPC512x_PSC_FIFO_EMPTY		0x1
+#define MPC512x_PSC_FIFO_FULL		0x2
+#define MPC512x_PSC_FIFO_ALARM		0x4
+#define MPC512x_PSC_FIFO_URERR		0x8
+#define MPC512x_PSC_FIFO_ORERR		0x01
+#define MPC512x_PSC_FIFO_MEMERROR	0x02
+
+struct mpc512x_psc_fifo {
+	u32		reserved1[10];
+	u32		txcmd;		/* PSC + 0x80 */
+	u32		txalarm;	/* PSC + 0x84 */
+	u32		txsr;		/* PSC + 0x88 */
+	u32		txisr;		/* PSC + 0x8c */
+	u32		tximr;		/* PSC + 0x90 */
+	u32		txcnt;		/* PSC + 0x94 */
+	u32		txptr;		/* PSC + 0x98 */
+	u32		txsz;		/* PSC + 0x9c */
+	u32		reserved2[7];
+	union {
+		u8	txdata_8;
+		u16	txdata_16;
+		u32	txdata_32;
+	} txdata; 			/* PSC + 0xbc */
+#define txdata_8 txdata.txdata_8
+#define txdata_16 txdata.txdata_16
+#define txdata_32 txdata.txdata_32
+	u32		rxcmd;		/* PSC + 0xc0 */
+	u32		rxalarm;	/* PSC + 0xc4 */
+	u32		rxsr;		/* PSC + 0xc8 */
+	u32		rxisr;		/* PSC + 0xcc */
+	u32		rximr;		/* PSC + 0xd0 */
+	u32		rxcnt;		/* PSC + 0xd4 */
+	u32		rxptr;		/* PSC + 0xd8 */
+	u32		rxsz;		/* PSC + 0xdc */
+	u32		reserved3[7];
+	union {
+		u8	rxdata_8;
+		u16	rxdata_16;
+		u32	rxdata_32;
+	} rxdata; 			/* PSC + 0xfc */
+#define rxdata_8 rxdata.rxdata_8
+#define rxdata_16 rxdata.rxdata_16
+#define rxdata_32 rxdata.rxdata_32
+};
 
 #endif  /* __ASM_MPC52xx_PSC_H__ */
-- 
1.5.3.5.726.g41a7a
