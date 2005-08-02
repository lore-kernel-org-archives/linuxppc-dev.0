Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 41DE667DA5
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 01:24:21 +1000 (EST)
Message-ID: <42EF9022.5050707@ru.mvista.com>
Date: Tue, 02 Aug 2005 19:24:18 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@freescale.com>
Content-Type: multipart/mixed; boundary="------------050606050202010407030805"
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>
Subject: [PATCH] cpm_uart: Made non-console uart work
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
--------------050606050202010407030805
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Kumar, Pantelis,

This patch makes non-console UART work on both 8xx and 82xx. Various 
issues are resolved:
- removed unnecessary STOP_TX commands in shutdown - no need to 
completely stop CPM TX and reinit BDs each time the port is closing;
- when mem_addr has been allocated via dma_coherent_alloc, virt_to_bus 
on it will not tell the truth in most cases
- SCC UART needs to wait several character times even after all the BDs 
have READY bit cleared
- adds needed board-specific bits for 86xADS

Tested on 8272ADS, 885ADS and 866ADS development boards.
---------------------------------
Signed-off-by:  Vitaly Bordug <vbordug@ru.mvista.com>

-- 
Sincerely, 
Vitaly


--------------050606050202010407030805
Content-Type: text/x-patch;
 name="cpm_uart_fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpm_uart_fixes.patch"

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
@@ -143,10 +144,13 @@ static void cpm_uart_start_tx(struct uar
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
 
@@ -265,13 +269,15 @@ static void cpm_uart_int_rx(struct uart_
 		}		/* End while (i--) */
 
 		/* This BD is ready to be used again. Clear status. get next */
-		bdp->cbd_sc &= ~(BD_SC_BR | BD_SC_FR | BD_SC_PR | BD_SC_OV);
+		bdp->cbd_sc &= ~(BD_SC_BR | BD_SC_FR | BD_SC_PR | BD_SC_OV | BD_SC_ID);
 		bdp->cbd_sc |= BD_SC_EMPTY;
 
-		if (bdp->cbd_sc & BD_SC_WRAP)
-			bdp = pinfo->rx_bd_base;
-		else
-			bdp++;
+		if (bdp->cbd_datlen) {
+			if (bdp->cbd_sc & BD_SC_WRAP)
+				bdp = pinfo->rx_bd_base;
+			else
+				bdp++;
+		}
 	} /* End for (;;) */
 
 	/* Write back buffer pointer */
@@ -336,22 +342,22 @@ static irqreturn_t cpm_uart_int(int irq,
 
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
@@ -360,6 +366,7 @@ static int cpm_uart_startup(struct uart_
 {
 	int retval;
 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
+	int line = pinfo - cpm_uart_ports;
 
 	pr_debug("CPM uart[%d]:startup\n", port->line);
 
@@ -374,18 +381,30 @@ static int cpm_uart_startup(struct uart_
 		pinfo->smcp->smc_smcmr |= SMCMR_REN;
 	} else {
 		pinfo->sccp->scc_sccm |= UART_SCCM_RX;
+		pinfo->sccp->scc_gsmrl |= SCC_GSMRL_ENR;
 	}
 
+	cpm_line_cr_cmd(line,CPM_CR_RESTART_TX);
 	return 0;
 }
 
+inline void cpm_uart_wait_until_send(struct uart_cpm_port *pinfo)
+{
+	unsigned long orig_jiffies = jiffies;
+	while(1)
+	{
+		schedule_timeout(2);
+		if(time_after(jiffies, orig_jiffies + pinfo->wait_closing))
+			break;
+	}
+}
+
 /*
  * Shutdown the uart
  */
 static void cpm_uart_shutdown(struct uart_port *port)
 {
 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
-	int line = pinfo - cpm_uart_ports;
 
 	pr_debug("CPM uart[%d]:shutdown\n", port->line);
 
@@ -394,6 +413,12 @@ static void cpm_uart_shutdown(struct uar
 
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
@@ -405,9 +430,6 @@ static void cpm_uart_shutdown(struct uar
 			sccp->scc_sccm &= ~(UART_SCCM_TX | UART_SCCM_RX);
 		}
 
-		/* Shut them really down and reinit buffer descriptors */
-		cpm_line_cr_cmd(line, CPM_CR_STOP_TX);
-		cpm_uart_initbd(pinfo);
 	}
 }
 
@@ -569,7 +591,10 @@ static int cpm_uart_tx_pump(struct uart_
 		/* Pick next descriptor and fill from buffer */
 		bdp = pinfo->tx_cur;
 
-		p = bus_to_virt(bdp->cbd_bufaddr);
+		if (pinfo->dma_addr)
+			p=(u8*)((ulong)(pinfo->mem_addr) + bdp->cbd_bufaddr - pinfo->dma_addr);
+		else
+			p = bus_to_virt(bdp->cbd_bufaddr);
 		*p++ = xmit->buf[xmit->tail];
 		bdp->cbd_datlen = 1;
 		bdp->cbd_sc |= BD_SC_READY;
@@ -595,7 +620,10 @@ static int cpm_uart_tx_pump(struct uart_
 
 	while (!(bdp->cbd_sc & BD_SC_READY) && (xmit->tail != xmit->head)) {
 		count = 0;
-		p = bus_to_virt(bdp->cbd_bufaddr);
+		if (pinfo->dma_addr)
+			p=(u8*)((ulong)(pinfo->mem_addr) + bdp->cbd_bufaddr - pinfo->dma_addr);
+		else
+			p = bus_to_virt(bdp->cbd_bufaddr);
 		while (count < pinfo->tx_fifosize) {
 			*p++ = xmit->buf[xmit->tail];
 			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
@@ -606,6 +634,7 @@ static int cpm_uart_tx_pump(struct uart_
 		}
 		bdp->cbd_datlen = count;
 		bdp->cbd_sc |= BD_SC_READY;
+		__asm__("eieio");
 		/* Get next BD. */
 		if (bdp->cbd_sc & BD_SC_WRAP)
 			bdp = pinfo->tx_bd_base;
@@ -632,6 +661,7 @@ static void cpm_uart_initbd(struct uart_
 {
 	int i;
 	u8 *mem_addr;
+	u8* dma_addr;
 	volatile cbd_t *bdp;
 
 	pr_debug("CPM uart[%d]:initbd\n", pinfo->port.line);
@@ -641,14 +671,23 @@ static void cpm_uart_initbd(struct uart_
 	 * virtual address for us to work with.
 	 */
 	mem_addr = pinfo->mem_addr;
+	dma_addr = (u8*)(pinfo->dma_addr);
 	bdp = pinfo->rx_cur = pinfo->rx_bd_base;
 	for (i = 0; i < (pinfo->rx_nrfifos - 1); i++, bdp++) {
-		bdp->cbd_bufaddr = virt_to_bus(mem_addr);
+		if (pinfo->dma_addr)
+			bdp->cbd_bufaddr = (ulong)dma_addr;
+		else
+			bdp->cbd_bufaddr = virt_to_bus(mem_addr);
 		bdp->cbd_sc = BD_SC_EMPTY | BD_SC_INTRPT;
+		bdp->cbd_datlen = 0;
 		mem_addr += pinfo->rx_fifosize;
+		dma_addr += pinfo->rx_fifosize;
 	}
-	
-	bdp->cbd_bufaddr = virt_to_bus(mem_addr);
+	if (pinfo->dma_addr)
+		bdp->cbd_bufaddr = (ulong)dma_addr;
+	else
+		bdp->cbd_bufaddr = virt_to_bus(mem_addr);
+	bdp->cbd_datlen = 0;
 	bdp->cbd_sc = BD_SC_WRAP | BD_SC_EMPTY | BD_SC_INTRPT;
 
 	/* Set the physical address of the host memory
@@ -656,14 +695,21 @@ static void cpm_uart_initbd(struct uart_
 	 * virtual address for us to work with.
 	 */
 	mem_addr = pinfo->mem_addr + L1_CACHE_ALIGN(pinfo->rx_nrfifos * pinfo->rx_fifosize);
+	dma_addr = (u8*)(pinfo->dma_addr + L1_CACHE_ALIGN(pinfo->rx_nrfifos * pinfo->rx_fifosize));
 	bdp = pinfo->tx_cur = pinfo->tx_bd_base;
 	for (i = 0; i < (pinfo->tx_nrfifos - 1); i++, bdp++) {
-		bdp->cbd_bufaddr = virt_to_bus(mem_addr);
+		if (pinfo->dma_addr)
+			bdp->cbd_bufaddr = (ulong)dma_addr;
+		else
+			bdp->cbd_bufaddr = virt_to_bus(mem_addr);
 		bdp->cbd_sc = BD_SC_INTRPT;
 		mem_addr += pinfo->tx_fifosize;
+		dma_addr += pinfo->tx_fifosize;
 	}
-	
-	bdp->cbd_bufaddr = virt_to_bus(mem_addr);
+	if (pinfo->dma_addr)
+		bdp->cbd_bufaddr = (ulong)dma_addr;
+	else
+		bdp->cbd_bufaddr = virt_to_bus(mem_addr);
 	bdp->cbd_sc = BD_SC_WRAP | BD_SC_INTRPT;
 }
 
@@ -763,6 +809,8 @@ static void cpm_uart_init_smc(struct uar
 	/* Using idle charater time requires some additional tuning.  */
 	up->smc_mrblr = pinfo->rx_fifosize;
 	up->smc_maxidl = pinfo->rx_fifosize;
+	up->smc_brklen = 0;
+	up->smc_brkec = 0;
 	up->smc_brkcr = 1;
 
 	cpm_line_cr_cmd(line, CPM_CR_INIT_TRX);
@@ -815,6 +863,10 @@ static int cpm_uart_request_port(struct 
 		return ret;
 
 	cpm_uart_initbd(pinfo);
+	if (IS_SMC(pinfo))
+		cpm_uart_init_smc(pinfo);
+	else
+		cpm_uart_init_scc(pinfo);
 
 	return 0;
 }
@@ -902,6 +954,7 @@ struct uart_cpm_port cpm_uart_ports[UART
 		.rx_nrfifos = RX_NUM_FIFO, 
 		.rx_fifosize = RX_BUF_SIZE,
 		.set_lineif = scc1_lineif,
+		.wait_closing = SCC_WAIT_CLOSING,
 	},
 	[UART_SCC2] = {
 		.port = {
@@ -915,6 +968,7 @@ struct uart_cpm_port cpm_uart_ports[UART
 		.rx_nrfifos = RX_NUM_FIFO, 
 		.rx_fifosize = RX_BUF_SIZE,
 		.set_lineif = scc2_lineif,
+		.wait_closing = SCC_WAIT_CLOSING,
 	},
 	[UART_SCC3] = {
 		.port = {
@@ -928,6 +982,7 @@ struct uart_cpm_port cpm_uart_ports[UART
 		.rx_nrfifos = RX_NUM_FIFO, 
 		.rx_fifosize = RX_BUF_SIZE,
 		.set_lineif = scc3_lineif,
+		.wait_closing = SCC_WAIT_CLOSING,
 	},
 	[UART_SCC4] = {
 		.port = {
@@ -941,6 +996,7 @@ struct uart_cpm_port cpm_uart_ports[UART
 		.rx_nrfifos = RX_NUM_FIFO, 
 		.rx_fifosize = RX_BUF_SIZE,
 		.set_lineif = scc4_lineif,
+		.wait_closing = SCC_WAIT_CLOSING,
 	},
 };
 
@@ -1081,6 +1137,7 @@ static int __init cpm_uart_console_setup
 		return ret;
 
 	cpm_uart_initbd(pinfo);
+	cpm_uart_init_scc(pinfo);
 
 	if (IS_SMC(pinfo))
 		cpm_uart_init_smc(pinfo);
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

--------------050606050202010407030805--
