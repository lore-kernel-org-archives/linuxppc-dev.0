Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 21CC367E9F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Aug 2005 01:49:42 +1000 (EST)
Message-ID: <42F23913.7020905@ru.mvista.com>
Date: Thu, 04 Aug 2005 19:49:39 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@freescale.com>
Content-Type: multipart/mixed; boundary="------------060403090401030907070903"
Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] cpm_uart: Make non-console uart work (rev 1)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060403090401030907070903
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Kumar, Pantelis,

This patch makes non-console UART work on both 8xx and 82xx. dpram 
allocation fix by Pantelis included, almost all mentioned issues fixed.

Tested on 8272ADS development board, but as far as there are no major 
modifications comparing to previous revision (excluding Pantelis change 
which has been tested independently), 8xx should work as well.
---------------------------------
Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
Signed-off-by: Pantelis Antoniou <panto@intracom.gr>

-- 
Sincerely,
Vitaly



--------------060403090401030907070903
Content-Type: text/x-patch;
 name="cpm_uart_fixes.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpm_uart_fixes.2.patch"

diff --git a/drivers/serial/cpm_uart/cpm_uart.h b/drivers/serial/cpm_uart/cpm_uart.h
--- a/drivers/serial/cpm_uart/cpm_uart.h
+++ b/drivers/serial/cpm_uart/cpm_uart.h
@@ -40,6 +40,8 @@
 #define TX_NUM_FIFO	4
 #define TX_BUF_SIZE	32
 
+#define SCC_WAIT_CLOSING 100
+
 struct uart_cpm_port {
 	struct uart_port	port;
 	u16			rx_nrfifos;	
@@ -67,6 +69,8 @@ struct uart_cpm_port {
 	int			 bits;
 	/* Keep track of 'odd' SMC2 wirings */
 	int			is_portb;
+	/* wait on close if needed */
+	int 			wait_closing;
 };
 
 extern int cpm_uart_port_map[UART_NR];
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -12,6 +12,7 @@
  * 
  *  Copyright (C) 2004 Freescale Semiconductor, Inc.
  *            (C) 2004 Intracom, S.A.
+ * 	      (C) 2005 MontaVista Software, Inc. by Vitaly Bordug <vbordug@ru.mvista.com>	
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -70,6 +71,20 @@ static void cpm_uart_initbd(struct uart_
 
 /**************************************************************/
 
+static inline unsigned long cpu2cpm_addr(void *addr)
+{
+	if ((unsigned long)addr >= CPM_ADDR)
+		return (unsigned long)addr;
+	return virt_to_bus(addr);
+}
+
+static inline void *cpm2cpu_addr(unsigned long addr)
+{
+	if (addr >= CPM_ADDR)
+		return (void *)addr;
+	return bus_to_virt(addr);
+}
+
 /*
  * Check, if transmit buffers are processed		
 */
@@ -143,10 +158,13 @@ static void cpm_uart_start_tx(struct uar
 	}
 
 	if (cpm_uart_tx_pump(port) != 0) {
-		if (IS_SMC(pinfo))
+		if (IS_SMC(pinfo)) {
 			smcp->smc_smcm |= SMCM_TX;
-		else
+			smcp->smc_smcmr |= SMCMR_TEN;
+		} else {
 			sccp->scc_sccm |= UART_SCCM_TX;
+			pinfo->sccp->scc_gsmrl |= SCC_GSMRL_ENT;
+		}
 	}
 }
 
@@ -243,7 +261,7 @@ static void cpm_uart_int_rx(struct uart_
 		}
 
 		/* get pointer */
-		cp = (unsigned char *)bus_to_virt(bdp->cbd_bufaddr);
+		cp = (unsigned char *)cpm2cpu_addr(bdp->cbd_bufaddr);
 
 		/* loop through the buffer */
 		while (i-- > 0) {
@@ -265,13 +283,14 @@ static void cpm_uart_int_rx(struct uart_
 		}		/* End while (i--) */
 
 		/* This BD is ready to be used again. Clear status. get next */
-		bdp->cbd_sc &= ~(BD_SC_BR | BD_SC_FR | BD_SC_PR | BD_SC_OV);
+		bdp->cbd_sc &= ~(BD_SC_BR | BD_SC_FR | BD_SC_PR | BD_SC_OV | BD_SC_ID);
 		bdp->cbd_sc |= BD_SC_EMPTY;
 
 		if (bdp->cbd_sc & BD_SC_WRAP)
 			bdp = pinfo->rx_bd_base;
 		else
 			bdp++;
+		
 	} /* End for (;;) */
 
 	/* Write back buffer pointer */
@@ -336,22 +355,22 @@ static irqreturn_t cpm_uart_int(int irq,
 
 	if (IS_SMC(pinfo)) {
 		events = smcp->smc_smce;
+		smcp->smc_smce = events;
 		if (events & SMCM_BRKE)
 			uart_handle_break(port);
 		if (events & SMCM_RX)
 			cpm_uart_int_rx(port, regs);
 		if (events & SMCM_TX)
 			cpm_uart_int_tx(port, regs);
-		smcp->smc_smce = events;
 	} else {
 		events = sccp->scc_scce;
+		sccp->scc_scce = events;
 		if (events & UART_SCCM_BRKE)
 			uart_handle_break(port);
 		if (events & UART_SCCM_RX)
 			cpm_uart_int_rx(port, regs);
 		if (events & UART_SCCM_TX)
 			cpm_uart_int_tx(port, regs);
-		sccp->scc_scce = events;
 	}
 	return (events) ? IRQ_HANDLED : IRQ_NONE;
 }
@@ -360,6 +379,7 @@ static int cpm_uart_startup(struct uart_
 {
 	int retval;
 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
+	int line = pinfo - cpm_uart_ports;
 
 	pr_debug("CPM uart[%d]:startup\n", port->line);
 
@@ -376,9 +396,19 @@ static int cpm_uart_startup(struct uart_
 		pinfo->sccp->scc_sccm |= UART_SCCM_RX;
 	}
 
+	if (!(pinfo->flags & FLAG_CONSOLE))
+		cpm_line_cr_cmd(line,CPM_CR_INIT_TRX);
 	return 0;
 }
 
+inline void cpm_uart_wait_until_send(struct uart_cpm_port *pinfo)
+{
+	unsigned long target_jiffies = jiffies + pinfo->wait_closing;
+
+	while (!time_after(jiffies, target_jiffies))
+   		schedule();
+}
+
 /*
  * Shutdown the uart
  */
@@ -394,6 +424,12 @@ static void cpm_uart_shutdown(struct uar
 
 	/* If the port is not the console, disable Rx and Tx. */
 	if (!(pinfo->flags & FLAG_CONSOLE)) {
+		/* Wait for all the BDs marked sent */
+		while(!cpm_uart_tx_empty(port))
+			schedule_timeout(2);
+		if(pinfo->wait_closing)
+			cpm_uart_wait_until_send(pinfo);
+
 		/* Stop uarts */
 		if (IS_SMC(pinfo)) {
 			volatile smc_t *smcp = pinfo->smcp;
@@ -569,7 +605,7 @@ static int cpm_uart_tx_pump(struct uart_
 		/* Pick next descriptor and fill from buffer */
 		bdp = pinfo->tx_cur;
 
-		p = bus_to_virt(bdp->cbd_bufaddr);
+		p = cpm2cpu_addr(bdp->cbd_bufaddr);
 		*p++ = xmit->buf[xmit->tail];
 		bdp->cbd_datlen = 1;
 		bdp->cbd_sc |= BD_SC_READY;
@@ -595,7 +631,7 @@ static int cpm_uart_tx_pump(struct uart_
 
 	while (!(bdp->cbd_sc & BD_SC_READY) && (xmit->tail != xmit->head)) {
 		count = 0;
-		p = bus_to_virt(bdp->cbd_bufaddr);
+		p = cpm2cpu_addr(bdp->cbd_bufaddr);
 		while (count < pinfo->tx_fifosize) {
 			*p++ = xmit->buf[xmit->tail];
 			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
@@ -606,6 +642,7 @@ static int cpm_uart_tx_pump(struct uart_
 		}
 		bdp->cbd_datlen = count;
 		bdp->cbd_sc |= BD_SC_READY;
+		__asm__("eieio");
 		/* Get next BD. */
 		if (bdp->cbd_sc & BD_SC_WRAP)
 			bdp = pinfo->tx_bd_base;
@@ -643,12 +680,12 @@ static void cpm_uart_initbd(struct uart_
 	mem_addr = pinfo->mem_addr;
 	bdp = pinfo->rx_cur = pinfo->rx_bd_base;
 	for (i = 0; i < (pinfo->rx_nrfifos - 1); i++, bdp++) {
-		bdp->cbd_bufaddr = virt_to_bus(mem_addr);
+		bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr);
 		bdp->cbd_sc = BD_SC_EMPTY | BD_SC_INTRPT;
 		mem_addr += pinfo->rx_fifosize;
 	}
 	
-	bdp->cbd_bufaddr = virt_to_bus(mem_addr);
+	bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr);
 	bdp->cbd_sc = BD_SC_WRAP | BD_SC_EMPTY | BD_SC_INTRPT;
 
 	/* Set the physical address of the host memory
@@ -658,12 +695,12 @@ static void cpm_uart_initbd(struct uart_
 	mem_addr = pinfo->mem_addr + L1_CACHE_ALIGN(pinfo->rx_nrfifos * pinfo->rx_fifosize);
 	bdp = pinfo->tx_cur = pinfo->tx_bd_base;
 	for (i = 0; i < (pinfo->tx_nrfifos - 1); i++, bdp++) {
-		bdp->cbd_bufaddr = virt_to_bus(mem_addr);
+		bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr);
 		bdp->cbd_sc = BD_SC_INTRPT;
 		mem_addr += pinfo->tx_fifosize;
 	}
 	
-	bdp->cbd_bufaddr = virt_to_bus(mem_addr);
+	bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr);
 	bdp->cbd_sc = BD_SC_WRAP | BD_SC_INTRPT;
 }
 
@@ -763,6 +800,8 @@ static void cpm_uart_init_smc(struct uar
 	/* Using idle charater time requires some additional tuning.  */
 	up->smc_mrblr = pinfo->rx_fifosize;
 	up->smc_maxidl = pinfo->rx_fifosize;
+	up->smc_brklen = 0;
+	up->smc_brkec = 0;
 	up->smc_brkcr = 1;
 
 	cpm_line_cr_cmd(line, CPM_CR_INIT_TRX);
@@ -815,6 +854,10 @@ static int cpm_uart_request_port(struct 
 		return ret;
 
 	cpm_uart_initbd(pinfo);
+	if (IS_SMC(pinfo))
+		cpm_uart_init_smc(pinfo);
+	else
+		cpm_uart_init_scc(pinfo);
 
 	return 0;
 }
@@ -902,6 +945,7 @@ struct uart_cpm_port cpm_uart_ports[UART
 		.rx_nrfifos = RX_NUM_FIFO, 
 		.rx_fifosize = RX_BUF_SIZE,
 		.set_lineif = scc1_lineif,
+		.wait_closing = SCC_WAIT_CLOSING,
 	},
 	[UART_SCC2] = {
 		.port = {
@@ -915,6 +959,7 @@ struct uart_cpm_port cpm_uart_ports[UART
 		.rx_nrfifos = RX_NUM_FIFO, 
 		.rx_fifosize = RX_BUF_SIZE,
 		.set_lineif = scc2_lineif,
+		.wait_closing = SCC_WAIT_CLOSING,
 	},
 	[UART_SCC3] = {
 		.port = {
@@ -928,6 +973,7 @@ struct uart_cpm_port cpm_uart_ports[UART
 		.rx_nrfifos = RX_NUM_FIFO, 
 		.rx_fifosize = RX_BUF_SIZE,
 		.set_lineif = scc3_lineif,
+		.wait_closing = SCC_WAIT_CLOSING,
 	},
 	[UART_SCC4] = {
 		.port = {
@@ -941,6 +987,7 @@ struct uart_cpm_port cpm_uart_ports[UART
 		.rx_nrfifos = RX_NUM_FIFO, 
 		.rx_fifosize = RX_BUF_SIZE,
 		.set_lineif = scc4_lineif,
+		.wait_closing = SCC_WAIT_CLOSING,
 	},
 };
 
@@ -986,7 +1033,7 @@ static void cpm_uart_console_write(struc
 		if ((uint) (bdp->cbd_bufaddr) > (uint) CPM_ADDR)
 			cp = (unsigned char *) (bdp->cbd_bufaddr);
 		else
-			cp = bus_to_virt(bdp->cbd_bufaddr);
+			cp = cpm2cpu_addr(bdp->cbd_bufaddr);
 		
 		*cp = *s;
 
@@ -1006,7 +1053,7 @@ static void cpm_uart_console_write(struc
 			if ((uint) (bdp->cbd_bufaddr) > (uint) CPM_ADDR)
 				cp = (unsigned char *) (bdp->cbd_bufaddr);
 			else
-				cp = bus_to_virt(bdp->cbd_bufaddr);
+				cp = cpm2cpu_addr(bdp->cbd_bufaddr);
 
 			*cp = 13;
 			bdp->cbd_datlen = 1;
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
@@ -82,6 +82,16 @@ void cpm_line_cr_cmd(int line, int cmd)
 void smc1_lineif(struct uart_cpm_port *pinfo)
 {
 	volatile cpm8xx_t *cp = cpmp;
+
+#if defined (CONFIG_MPC885ADS)
+	/* Enable SMC1 transceivers */
+	{
+		cp->cp_pepar |= 0x000000c0;
+		cp->cp_pedir &= ~0x000000c0;
+		cp->cp_peso &= ~0x00000040;
+		cp->cp_peso |= 0x00000080;
+	}
+#elif defined (CONFIG_MPC86XADS)
 	unsigned int iobits = 0x000000c0;
 
 	if (!pinfo->is_portb) {
@@ -93,41 +103,31 @@ void smc1_lineif(struct uart_cpm_port *p
 		((immap_t *)IMAP_ADDR)->im_ioport.iop_padir &= ~iobits;
 		((immap_t *)IMAP_ADDR)->im_ioport.iop_paodr &= ~iobits;
 	}
-
-#ifdef CONFIG_MPC885ADS
-	/* Enable SMC1 transceivers */
-	{
-		volatile uint __iomem *bcsr1 = ioremap(BCSR1, 4);
-		uint tmp;
-
-		tmp = in_be32(bcsr1);
-		tmp &= ~BCSR1_RS232EN_1;
-		out_be32(bcsr1, tmp);
-		iounmap(bcsr1);
-	}
 #endif
-
 	pinfo->brg = 1;
 }
 
 void smc2_lineif(struct uart_cpm_port *pinfo)
 {
-#ifdef CONFIG_MPC885ADS
 	volatile cpm8xx_t *cp = cpmp;
-	volatile uint __iomem *bcsr1;
-	uint tmp;
-
+#if defined (CONFIG_MPC885ADS)
 	cp->cp_pepar |= 0x00000c00;
 	cp->cp_pedir &= ~0x00000c00;
 	cp->cp_peso &= ~0x00000400;
 	cp->cp_peso |= 0x00000800;
+#elif defined (CONFIG_MPC86XADS)
+	unsigned int iobits = 0x00000c00;
+
+	if (!pinfo->is_portb) {
+		cp->cp_pbpar |= iobits;
+		cp->cp_pbdir &= ~iobits;
+		cp->cp_pbodr &= ~iobits;
+	} else {
+		((immap_t *)IMAP_ADDR)->im_ioport.iop_papar |= iobits;
+		((immap_t *)IMAP_ADDR)->im_ioport.iop_padir &= ~iobits;
+		((immap_t *)IMAP_ADDR)->im_ioport.iop_paodr &= ~iobits;
+	}
 
-	/* Enable SMC2 transceivers */
-	bcsr1 = ioremap(BCSR1, 4);
-	tmp = in_be32(bcsr1);
-	tmp &= ~BCSR1_RS232EN_2;
-	out_be32(bcsr1, tmp);
-	iounmap(bcsr1);
 #endif
 
 	pinfo->brg = 2;

--------------060403090401030907070903--
