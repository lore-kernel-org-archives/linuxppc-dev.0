Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7C618DE5B8
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 06:24:34 +1000 (EST)
Date: Tue, 28 Aug 2007 15:16:53 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 3/4] cpm_uart: sparse fixes
Message-ID: <20070828201653.GC24234@ld0162-tx32.am.freescale.net>
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

Mostly a bunch of direct access to in/out conversions, plus a few
cast removals, __iomem annotations, and miscellaneous cleanup.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 drivers/serial/cpm_uart/cpm_uart.h      |   42 +++--
 drivers/serial/cpm_uart/cpm_uart_core.c |  299 ++++++++++++++++---------------
 drivers/serial/cpm_uart/cpm_uart_cpm1.c |    2 +-
 drivers/serial/cpm_uart/cpm_uart_cpm1.h |   14 +-
 drivers/serial/cpm_uart/cpm_uart_cpm2.c |    4 +-
 drivers/serial/cpm_uart/cpm_uart_cpm2.h |   14 +-
 6 files changed, 192 insertions(+), 183 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart.h b/drivers/serial/cpm_uart/cpm_uart.h
index 4e1987a..32b9737 100644
--- a/drivers/serial/cpm_uart/cpm_uart.h
+++ b/drivers/serial/cpm_uart/cpm_uart.h
@@ -56,21 +56,21 @@ struct uart_cpm_port {
 	u16			rx_fifosize;
 	u16			tx_nrfifos;
 	u16			tx_fifosize;
-	smc_t			*smcp;
-	smc_uart_t		*smcup;
-	scc_t			*sccp;
-	scc_uart_t		*sccup;
-	volatile cbd_t		*rx_bd_base;
-	volatile cbd_t		*rx_cur;
-	volatile cbd_t		*tx_bd_base;
-	volatile cbd_t		*tx_cur;
+	smc_t __iomem		*smcp;
+	smc_uart_t __iomem	*smcup;
+	scc_t __iomem		*sccp;
+	scc_uart_t __iomem	*sccup;
+	cbd_t __iomem		*rx_bd_base;
+	cbd_t __iomem		*rx_cur;
+	cbd_t __iomem		*tx_bd_base;
+	cbd_t __iomem		*tx_cur;
 	unsigned char		*tx_buf;
 	unsigned char		*rx_buf;
 	u32			flags;
 	void			(*set_lineif)(struct uart_cpm_port *);
 	u8			brg;
 	uint			 dp_addr;
-	void			*mem_addr;
+	void 			*mem_addr;
 	dma_addr_t		 dma_addr;
 	u32			mem_size;
 	/* helpers */
@@ -106,34 +106,36 @@ void scc4_lineif(struct uart_cpm_port *pinfo);
 /*
    virtual to phys transtalion
 */
-static inline unsigned long cpu2cpm_addr(void* addr, struct uart_cpm_port *pinfo)
+static inline unsigned long cpu2cpm_addr(void *addr,
+                                         struct uart_cpm_port *pinfo)
 {
 	int offset;
 	u32 val = (u32)addr;
+	u32 mem = (u32)pinfo->mem_addr;
 	/* sane check */
-	if (likely((val >= (u32)pinfo->mem_addr)) &&
-			(val<((u32)pinfo->mem_addr + pinfo->mem_size))) {
-		offset = val - (u32)pinfo->mem_addr;
-		return pinfo->dma_addr+offset;
+	if (likely(val >= mem && val < mem + pinfo->mem_size)) {
+		offset = val - mem;
+		return pinfo->dma_addr + offset;
 	}
 	/* something nasty happened */
 	BUG();
 	return 0;
 }
 
-static inline void *cpm2cpu_addr(unsigned long addr, struct uart_cpm_port *pinfo)
+static inline void *cpm2cpu_addr(unsigned long addr,
+                                 struct uart_cpm_port *pinfo)
 {
 	int offset;
 	u32 val = addr;
+	u32 dma = (u32)pinfo->dma_addr;
 	/* sane check */
-	if (likely((val >= pinfo->dma_addr) &&
-			(val<(pinfo->dma_addr + pinfo->mem_size)))) {
-		offset = val - (u32)pinfo->dma_addr;
-		return (void*)(pinfo->mem_addr+offset);
+	if (likely(val >= dma && val < dma + pinfo->mem_size)) {
+		offset = val - dma;
+		return pinfo->mem_addr + offset;
 	}
 	/* something nasty happened */
 	BUG();
-	return 0;
+	return NULL;
 }
 
 
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index 78171d0..c43706e 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -131,14 +131,14 @@ static int cpm_uart_id2nr(int id)
 static unsigned int cpm_uart_tx_empty(struct uart_port *port)
 {
 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
-	volatile cbd_t *bdp = pinfo->tx_bd_base;
+	cbd_t __iomem *bdp = pinfo->tx_bd_base;
 	int ret = 0;
 
 	while (1) {
-		if (bdp->cbd_sc & BD_SC_READY)
+		if (in_be16(&bdp->cbd_sc) & BD_SC_READY)
 			break;
 
-		if (bdp->cbd_sc & BD_SC_WRAP) {
+		if (in_be16(&bdp->cbd_sc) & BD_SC_WRAP) {
 			ret = TIOCSER_TEMT;
 			break;
 		}
@@ -167,15 +167,15 @@ static unsigned int cpm_uart_get_mctrl(struct uart_port *port)
 static void cpm_uart_stop_tx(struct uart_port *port)
 {
 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
-	volatile smc_t *smcp = pinfo->smcp;
-	volatile scc_t *sccp = pinfo->sccp;
+	smc_t __iomem *smcp = pinfo->smcp;
+	scc_t __iomem *sccp = pinfo->sccp;
 
 	pr_debug("CPM uart[%d]:stop tx\n", port->line);
 
 	if (IS_SMC(pinfo))
-		smcp->smc_smcm &= ~SMCM_TX;
+		clrbits8(&smcp->smc_smcm, SMCM_TX);
 	else
-		sccp->scc_sccm &= ~UART_SCCM_TX;
+		clrbits16(&sccp->scc_sccm, UART_SCCM_TX);
 }
 
 /*
@@ -184,24 +184,24 @@ static void cpm_uart_stop_tx(struct uart_port *port)
 static void cpm_uart_start_tx(struct uart_port *port)
 {
 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
-	volatile smc_t *smcp = pinfo->smcp;
-	volatile scc_t *sccp = pinfo->sccp;
+	smc_t __iomem *smcp = pinfo->smcp;
+	scc_t __iomem *sccp = pinfo->sccp;
 
 	pr_debug("CPM uart[%d]:start tx\n", port->line);
 
 	if (IS_SMC(pinfo)) {
-		if (smcp->smc_smcm & SMCM_TX)
+		if (in_8(&smcp->smc_smcm) & SMCM_TX)
 			return;
 	} else {
-		if (sccp->scc_sccm & UART_SCCM_TX)
+		if (in_be16(&sccp->scc_sccm) & UART_SCCM_TX)
 			return;
 	}
 
 	if (cpm_uart_tx_pump(port) != 0) {
 		if (IS_SMC(pinfo)) {
-			smcp->smc_smcm |= SMCM_TX;
+			setbits8(&smcp->smc_smcm, SMCM_TX);
 		} else {
-			sccp->scc_sccm |= UART_SCCM_TX;
+			setbits16(&sccp->scc_sccm, UART_SCCM_TX);
 		}
 	}
 }
@@ -212,15 +212,15 @@ static void cpm_uart_start_tx(struct uart_port *port)
 static void cpm_uart_stop_rx(struct uart_port *port)
 {
 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
-	volatile smc_t *smcp = pinfo->smcp;
-	volatile scc_t *sccp = pinfo->sccp;
+	smc_t __iomem *smcp = pinfo->smcp;
+	scc_t __iomem *sccp = pinfo->sccp;
 
 	pr_debug("CPM uart[%d]:stop rx\n", port->line);
 
 	if (IS_SMC(pinfo))
-		smcp->smc_smcm &= ~SMCM_RX;
+		clrbits8(&smcp->smc_smcm, SMCM_RX);
 	else
-		sccp->scc_sccm &= ~UART_SCCM_RX;
+		clrbits16(&sccp->scc_sccm, UART_SCCM_RX);
 }
 
 /*
@@ -263,10 +263,11 @@ static void cpm_uart_int_tx(struct uart_port *port)
 static void cpm_uart_int_rx(struct uart_port *port)
 {
 	int i;
-	unsigned char ch, *cp;
+	unsigned char ch;
+	u8 *cp;
 	struct tty_struct *tty = port->info->tty;
 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
-	volatile cbd_t *bdp;
+	cbd_t __iomem *bdp;
 	u16 status;
 	unsigned int flg;
 
@@ -278,13 +279,13 @@ static void cpm_uart_int_rx(struct uart_port *port)
 	bdp = pinfo->rx_cur;
 	for (;;) {
 		/* get status */
-		status = bdp->cbd_sc;
+		status = in_be16(&bdp->cbd_sc);
 		/* If this one is empty, return happy */
 		if (status & BD_SC_EMPTY)
 			break;
 
 		/* get number of characters, and check spce in flip-buffer */
-		i = bdp->cbd_datlen;
+		i = in_be16(&bdp->cbd_datlen);
 
 		/* If we have not enough room in tty flip buffer, then we try
 		 * later, which will be the next rx-interrupt or a timeout
@@ -295,7 +296,7 @@ static void cpm_uart_int_rx(struct uart_port *port)
 		}
 
 		/* get pointer */
-		cp = cpm2cpu_addr(bdp->cbd_bufaddr, pinfo);
+		cp = cpm2cpu_addr(in_be32(&bdp->cbd_bufaddr), pinfo);
 
 		/* loop through the buffer */
 		while (i-- > 0) {
@@ -315,10 +316,11 @@ static void cpm_uart_int_rx(struct uart_port *port)
 		}		/* End while (i--) */
 
 		/* This BD is ready to be used again. Clear status. get next */
-		bdp->cbd_sc &= ~(BD_SC_BR | BD_SC_FR | BD_SC_PR | BD_SC_OV | BD_SC_ID);
-		bdp->cbd_sc |= BD_SC_EMPTY;
+		clrbits16(&bdp->cbd_sc, BD_SC_BR | BD_SC_FR | BD_SC_PR |
+		                        BD_SC_OV | BD_SC_ID);
+		setbits16(&bdp->cbd_sc, BD_SC_EMPTY);
 
-		if (bdp->cbd_sc & BD_SC_WRAP)
+		if (in_be16(&bdp->cbd_sc) & BD_SC_WRAP)
 			bdp = pinfo->rx_bd_base;
 		else
 			bdp++;
@@ -326,7 +328,7 @@ static void cpm_uart_int_rx(struct uart_port *port)
 	} /* End for (;;) */
 
 	/* Write back buffer pointer */
-	pinfo->rx_cur = (volatile cbd_t *) bdp;
+	pinfo->rx_cur = bdp;
 
 	/* activate BH processing */
 	tty_flip_buffer_push(tty);
@@ -380,14 +382,14 @@ static irqreturn_t cpm_uart_int(int irq, void *data)
 	u8 events;
 	struct uart_port *port = (struct uart_port *)data;
 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
-	volatile smc_t *smcp = pinfo->smcp;
-	volatile scc_t *sccp = pinfo->sccp;
+	smc_t __iomem *smcp = pinfo->smcp;
+	scc_t __iomem *sccp = pinfo->sccp;
 
 	pr_debug("CPM uart[%d]:IRQ\n", port->line);
 
 	if (IS_SMC(pinfo)) {
-		events = smcp->smc_smce;
-		smcp->smc_smce = events;
+		events = in_8(&smcp->smc_smce);
+		out_8(&smcp->smc_smce, events);
 		if (events & SMCM_BRKE)
 			uart_handle_break(port);
 		if (events & SMCM_RX)
@@ -395,8 +397,8 @@ static irqreturn_t cpm_uart_int(int irq, void *data)
 		if (events & SMCM_TX)
 			cpm_uart_int_tx(port);
 	} else {
-		events = sccp->scc_scce;
-		sccp->scc_scce = events;
+		events = in_be16(&sccp->scc_scce);
+		out_be16(&sccp->scc_scce, events);
 		if (events & UART_SCCM_BRKE)
 			uart_handle_break(port);
 		if (events & UART_SCCM_RX)
@@ -421,11 +423,11 @@ static int cpm_uart_startup(struct uart_port *port)
 
 	/* Startup rx-int */
 	if (IS_SMC(pinfo)) {
-		pinfo->smcp->smc_smcm |= SMCM_RX;
-		pinfo->smcp->smc_smcmr |= (SMCMR_REN | SMCMR_TEN);
+		setbits8(&pinfo->smcp->smc_smcm, SMCM_RX);
+		setbits16(&pinfo->smcp->smc_smcmr, (SMCMR_REN | SMCMR_TEN));
 	} else {
-		pinfo->sccp->scc_sccm |= UART_SCCM_RX;
-		pinfo->sccp->scc_gsmrl |= (SCC_GSMRL_ENR | SCC_GSMRL_ENT);
+		setbits16(&pinfo->sccp->scc_sccm, UART_SCCM_RX);
+		setbits32(&pinfo->sccp->scc_gsmrl, (SCC_GSMRL_ENR | SCC_GSMRL_ENT));
 	}
 
 	if (!(pinfo->flags & FLAG_CONSOLE))
@@ -464,13 +466,13 @@ static void cpm_uart_shutdown(struct uart_port *port)
 
 		/* Stop uarts */
 		if (IS_SMC(pinfo)) {
-			volatile smc_t *smcp = pinfo->smcp;
-			smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
-			smcp->smc_smcm &= ~(SMCM_RX | SMCM_TX);
+			smc_t __iomem *smcp = pinfo->smcp;
+			clrbits16(&smcp->smc_smcmr, SMCMR_REN | SMCMR_TEN);
+			clrbits8(&smcp->smc_smcm, SMCM_RX | SMCM_TX);
 		} else {
-			volatile scc_t *sccp = pinfo->sccp;
-			sccp->scc_gsmrl &= ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-			sccp->scc_sccm &= ~(UART_SCCM_TX | UART_SCCM_RX);
+			scc_t __iomem *sccp = pinfo->sccp;
+			clrbits32(&sccp->scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
+			clrbits16(&sccp->scc_sccm, UART_SCCM_TX | UART_SCCM_RX);
 		}
 
 		/* Shut them really down and reinit buffer descriptors */
@@ -492,8 +494,8 @@ static void cpm_uart_set_termios(struct uart_port *port,
 	u16 cval, scval, prev_mode;
 	int bits, sbits;
 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
-	volatile smc_t *smcp = pinfo->smcp;
-	volatile scc_t *sccp = pinfo->sccp;
+	smc_t __iomem *smcp = pinfo->smcp;
+	scc_t __iomem *sccp = pinfo->sccp;
 
 	pr_debug("CPM uart[%d]:set_termios\n", port->line);
 
@@ -588,11 +590,11 @@ static void cpm_uart_set_termios(struct uart_port *port,
 		 * enables, because we want to put them back if they were
 		 * present.
 		 */
-		prev_mode = smcp->smc_smcmr;
-		smcp->smc_smcmr = smcr_mk_clen(bits) | cval | SMCMR_SM_UART;
-		smcp->smc_smcmr |= (prev_mode & (SMCMR_REN | SMCMR_TEN));
+		prev_mode = in_be16(&smcp->smc_smcmr);
+		out_be16(&smcp->smc_smcmr, smcr_mk_clen(bits) | cval | SMCMR_SM_UART);
+		setbits16(&smcp->smc_smcmr, (prev_mode & (SMCMR_REN | SMCMR_TEN)));
 	} else {
-		sccp->scc_psmr = (sbits << 12) | scval;
+		out_be16(&sccp->scc_psmr, (sbits << 12) | scval);
 	}
 
 	cpm_set_brg(pinfo->brg - 1, baud);
@@ -630,8 +632,8 @@ static int cpm_uart_verify_port(struct uart_port *port,
  */
 static int cpm_uart_tx_pump(struct uart_port *port)
 {
-	volatile cbd_t *bdp;
-	unsigned char *p;
+	cbd_t __iomem *bdp;
+	u8 *p;
 	int count;
 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
 	struct circ_buf *xmit = &port->info->xmit;
@@ -641,13 +643,14 @@ static int cpm_uart_tx_pump(struct uart_port *port)
 		/* Pick next descriptor and fill from buffer */
 		bdp = pinfo->tx_cur;
 
-		p = cpm2cpu_addr(bdp->cbd_bufaddr, pinfo);
+		p = cpm2cpu_addr(in_be32(&bdp->cbd_bufaddr), pinfo);
 
 		*p++ = port->x_char;
-		bdp->cbd_datlen = 1;
-		bdp->cbd_sc |= BD_SC_READY;
+
+		out_be16(&bdp->cbd_datlen, 1);
+		setbits16(&bdp->cbd_sc, BD_SC_READY);
 		/* Get next BD. */
-		if (bdp->cbd_sc & BD_SC_WRAP)
+		if (in_be16(&bdp->cbd_sc) & BD_SC_WRAP)
 			bdp = pinfo->tx_bd_base;
 		else
 			bdp++;
@@ -666,9 +669,10 @@ static int cpm_uart_tx_pump(struct uart_port *port)
 	/* Pick next descriptor and fill from buffer */
 	bdp = pinfo->tx_cur;
 
-	while (!(bdp->cbd_sc & BD_SC_READY) && (xmit->tail != xmit->head)) {
+	while (!(in_be16(&bdp->cbd_sc) & BD_SC_READY) &&
+	       xmit->tail != xmit->head) {
 		count = 0;
-		p = cpm2cpu_addr(bdp->cbd_bufaddr, pinfo);
+		p = cpm2cpu_addr(in_be32(&bdp->cbd_bufaddr), pinfo);
 		while (count < pinfo->tx_fifosize) {
 			*p++ = xmit->buf[xmit->tail];
 			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
@@ -677,11 +681,10 @@ static int cpm_uart_tx_pump(struct uart_port *port)
 			if (xmit->head == xmit->tail)
 				break;
 		}
-		bdp->cbd_datlen = count;
-		bdp->cbd_sc |= BD_SC_READY;
-		eieio();
+		out_be16(&bdp->cbd_datlen, count);
+		setbits16(&bdp->cbd_sc, BD_SC_READY);
 		/* Get next BD. */
-		if (bdp->cbd_sc & BD_SC_WRAP)
+		if (in_be16(&bdp->cbd_sc) & BD_SC_WRAP)
 			bdp = pinfo->tx_bd_base;
 		else
 			bdp++;
@@ -706,7 +709,7 @@ static void cpm_uart_initbd(struct uart_cpm_port *pinfo)
 {
 	int i;
 	u8 *mem_addr;
-	volatile cbd_t *bdp;
+	cbd_t __iomem *bdp;
 
 	pr_debug("CPM uart[%d]:initbd\n", pinfo->port.line);
 
@@ -717,13 +720,13 @@ static void cpm_uart_initbd(struct uart_cpm_port *pinfo)
 	mem_addr = pinfo->mem_addr;
 	bdp = pinfo->rx_cur = pinfo->rx_bd_base;
 	for (i = 0; i < (pinfo->rx_nrfifos - 1); i++, bdp++) {
-		bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr, pinfo);
-		bdp->cbd_sc = BD_SC_EMPTY | BD_SC_INTRPT;
+		out_be32(&bdp->cbd_bufaddr, cpu2cpm_addr(mem_addr, pinfo));
+		out_be16(&bdp->cbd_sc, BD_SC_EMPTY | BD_SC_INTRPT);
 		mem_addr += pinfo->rx_fifosize;
 	}
 
-	bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr, pinfo);
-	bdp->cbd_sc = BD_SC_WRAP | BD_SC_EMPTY | BD_SC_INTRPT;
+	out_be32(&bdp->cbd_bufaddr, cpu2cpm_addr(mem_addr, pinfo));
+	out_be16(&bdp->cbd_sc, BD_SC_WRAP | BD_SC_EMPTY | BD_SC_INTRPT);
 
 	/* Set the physical address of the host memory
 	 * buffers in the buffer descriptors, and the
@@ -732,19 +735,19 @@ static void cpm_uart_initbd(struct uart_cpm_port *pinfo)
 	mem_addr = pinfo->mem_addr + L1_CACHE_ALIGN(pinfo->rx_nrfifos * pinfo->rx_fifosize);
 	bdp = pinfo->tx_cur = pinfo->tx_bd_base;
 	for (i = 0; i < (pinfo->tx_nrfifos - 1); i++, bdp++) {
-		bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr, pinfo);
-		bdp->cbd_sc = BD_SC_INTRPT;
+		out_be32(&bdp->cbd_bufaddr, cpu2cpm_addr(mem_addr, pinfo));
+		out_be16(&bdp->cbd_sc, BD_SC_INTRPT);
 		mem_addr += pinfo->tx_fifosize;
 	}
 
-	bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr, pinfo);
-	bdp->cbd_sc = BD_SC_WRAP | BD_SC_INTRPT;
+	out_be32(&bdp->cbd_bufaddr, cpu2cpm_addr(mem_addr, pinfo));
+	out_be16(&bdp->cbd_sc, BD_SC_WRAP | BD_SC_INTRPT);
 }
 
 static void cpm_uart_init_scc(struct uart_cpm_port *pinfo)
 {
-	volatile scc_t *scp;
-	volatile scc_uart_t *sup;
+	scc_t __iomem *scp;
+	scc_uart_t __iomem *sup;
 
 	pr_debug("CPM uart[%d]:init_scc\n", pinfo->port.line);
 
@@ -752,8 +755,10 @@ static void cpm_uart_init_scc(struct uart_cpm_port *pinfo)
 	sup = pinfo->sccup;
 
 	/* Store address */
-	pinfo->sccup->scc_genscc.scc_rbase = (unsigned char *)pinfo->rx_bd_base - DPRAM_BASE;
-	pinfo->sccup->scc_genscc.scc_tbase = (unsigned char *)pinfo->tx_bd_base - DPRAM_BASE;
+	out_be16(&pinfo->sccup->scc_genscc.scc_rbase,
+	         (u8 __iomem *)pinfo->rx_bd_base - DPRAM_BASE);
+	out_be16(&pinfo->sccup->scc_genscc.scc_tbase,
+	         (u8 __iomem *)pinfo->tx_bd_base - DPRAM_BASE);
 
 	/* Set up the uart parameters in the
 	 * parameter ram.
@@ -761,25 +766,25 @@ static void cpm_uart_init_scc(struct uart_cpm_port *pinfo)
 
 	cpm_set_scc_fcr(sup);
 
-	sup->scc_genscc.scc_mrblr = pinfo->rx_fifosize;
-	sup->scc_maxidl = pinfo->rx_fifosize;
-	sup->scc_brkcr = 1;
-	sup->scc_parec = 0;
-	sup->scc_frmec = 0;
-	sup->scc_nosec = 0;
-	sup->scc_brkec = 0;
-	sup->scc_uaddr1 = 0;
-	sup->scc_uaddr2 = 0;
-	sup->scc_toseq = 0;
-	sup->scc_char1 = 0x8000;
-	sup->scc_char2 = 0x8000;
-	sup->scc_char3 = 0x8000;
-	sup->scc_char4 = 0x8000;
-	sup->scc_char5 = 0x8000;
-	sup->scc_char6 = 0x8000;
-	sup->scc_char7 = 0x8000;
-	sup->scc_char8 = 0x8000;
-	sup->scc_rccm = 0xc0ff;
+	out_be16(&sup->scc_genscc.scc_mrblr, pinfo->rx_fifosize);
+	out_be16(&sup->scc_maxidl, pinfo->rx_fifosize);
+	out_be16(&sup->scc_brkcr, 1);
+	out_be16(&sup->scc_parec, 0);
+	out_be16(&sup->scc_frmec, 0);
+	out_be16(&sup->scc_nosec, 0);
+	out_be16(&sup->scc_brkec, 0);
+	out_be16(&sup->scc_uaddr1, 0);
+	out_be16(&sup->scc_uaddr2, 0);
+	out_be16(&sup->scc_toseq, 0);
+	out_be16(&sup->scc_char1, 0x8000);
+	out_be16(&sup->scc_char2, 0x8000);
+	out_be16(&sup->scc_char3, 0x8000);
+	out_be16(&sup->scc_char4, 0x8000);
+	out_be16(&sup->scc_char5, 0x8000);
+	out_be16(&sup->scc_char6, 0x8000);
+	out_be16(&sup->scc_char7, 0x8000);
+	out_be16(&sup->scc_char8, 0x8000);
+	out_be16(&sup->scc_rccm, 0xc0ff);
 
 	/* Send the CPM an initialize command.
 	 */
@@ -788,23 +793,23 @@ static void cpm_uart_init_scc(struct uart_cpm_port *pinfo)
 	/* Set UART mode, 8 bit, no parity, one stop.
 	 * Enable receive and transmit.
 	 */
-	scp->scc_gsmrh = 0;
-	scp->scc_gsmrl =
-	    (SCC_GSMRL_MODE_UART | SCC_GSMRL_TDCR_16 | SCC_GSMRL_RDCR_16);
+	out_be32(&scp->scc_gsmrh, 0);
+	out_be32(&scp->scc_gsmrl,
+	         SCC_GSMRL_MODE_UART | SCC_GSMRL_TDCR_16 | SCC_GSMRL_RDCR_16);
 
 	/* Enable rx interrupts  and clear all pending events.  */
-	scp->scc_sccm = 0;
-	scp->scc_scce = 0xffff;
-	scp->scc_dsr = 0x7e7e;
-	scp->scc_psmr = 0x3000;
+	out_be16(&scp->scc_sccm, 0);
+	out_be16(&scp->scc_scce, 0xffff);
+	out_be16(&scp->scc_dsr, 0x7e7e);
+	out_be16(&scp->scc_psmr, 0x3000);
 
-	scp->scc_gsmrl |= (SCC_GSMRL_ENR | SCC_GSMRL_ENT);
+	setbits32(&scp->scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
 }
 
 static void cpm_uart_init_smc(struct uart_cpm_port *pinfo)
 {
-	volatile smc_t *sp;
-	volatile smc_uart_t *up;
+	smc_t __iomem *sp;
+	smc_uart_t __iomem *up;
 
 	pr_debug("CPM uart[%d]:init_smc\n", pinfo->port.line);
 
@@ -812,19 +817,21 @@ static void cpm_uart_init_smc(struct uart_cpm_port *pinfo)
 	up = pinfo->smcup;
 
 	/* Store address */
-	pinfo->smcup->smc_rbase = (u_char *)pinfo->rx_bd_base - DPRAM_BASE;
-	pinfo->smcup->smc_tbase = (u_char *)pinfo->tx_bd_base - DPRAM_BASE;
+	out_be16(&pinfo->smcup->smc_rbase,
+	         (u8 __iomem *)pinfo->rx_bd_base - DPRAM_BASE);
+	out_be16(&pinfo->smcup->smc_tbase,
+	         (u8 __iomem *)pinfo->tx_bd_base - DPRAM_BASE);
 
 /*
  *  In case SMC1 is being relocated...
  */
 #if defined (CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
-	up->smc_rbptr = pinfo->smcup->smc_rbase;
-	up->smc_tbptr = pinfo->smcup->smc_tbase;
-	up->smc_rstate = 0;
-	up->smc_tstate = 0;
-	up->smc_brkcr = 1;              /* number of break chars */
-	up->smc_brkec = 0;
+	out_be16(&up->smc_rbptr, in_be16(&pinfo->smcup->smc_rbase));
+	out_be16(&up->smc_tbptr, in_be16(&pinfo->smcup->smc_tbase));
+	out_be32(&up->smc_rstate, 0);
+	out_be32(&up->smc_tstate, 0);
+	out_be16(&up->smc_brkcr, 1);              /* number of break chars */
+	out_be16(&up->smc_brkec, 0);
 #endif
 
 	/* Set up the uart parameters in the
@@ -833,24 +840,24 @@ static void cpm_uart_init_smc(struct uart_cpm_port *pinfo)
 	cpm_set_smc_fcr(up);
 
 	/* Using idle charater time requires some additional tuning.  */
-	up->smc_mrblr = pinfo->rx_fifosize;
-	up->smc_maxidl = pinfo->rx_fifosize;
-	up->smc_brklen = 0;
-	up->smc_brkec = 0;
-	up->smc_brkcr = 1;
+	out_be16(&up->smc_mrblr, pinfo->rx_fifosize);
+	out_be16(&up->smc_maxidl, pinfo->rx_fifosize);
+	out_be16(&up->smc_brklen, 0);
+	out_be16(&up->smc_brkec, 0);
+	out_be16(&up->smc_brkcr, 1);
 
 	cpm_line_cr_cmd(pinfo, CPM_CR_INIT_TRX);
 
 	/* Set UART mode, 8 bit, no parity, one stop.
 	 * Enable receive and transmit.
 	 */
-	sp->smc_smcmr = smcr_mk_clen(9) | SMCMR_SM_UART;
+	out_be16(&sp->smc_smcmr, smcr_mk_clen(9) | SMCMR_SM_UART);
 
 	/* Enable only rx interrupts clear all pending events. */
-	sp->smc_smcm = 0;
-	sp->smc_smce = 0xff;
+	out_8(&sp->smc_smcm, 0);
+	out_8(&sp->smc_smce, 0xff);
 
-	sp->smc_smcmr |= (SMCMR_REN | SMCMR_TEN);
+	setbits16(&sp->smc_smcmr, SMCMR_REN | SMCMR_TEN);
 }
 
 /*
@@ -868,11 +875,11 @@ static int cpm_uart_request_port(struct uart_port *port)
 		return 0;
 
 	if (IS_SMC(pinfo)) {
-		pinfo->smcp->smc_smcm &= ~(SMCM_RX | SMCM_TX);
-		pinfo->smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
+		clrbits8(&pinfo->smcp->smc_smcm, SMCM_RX | SMCM_TX);
+		clrbits16(&pinfo->smcp->smc_smcmr, SMCMR_REN | SMCMR_TEN);
 	} else {
-		pinfo->sccp->scc_sccm &= ~(UART_SCCM_TX | UART_SCCM_RX);
-		pinfo->sccp->scc_gsmrl &= ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
+		clrbits16(&pinfo->sccp->scc_sccm, UART_SCCM_TX | UART_SCCM_RX);
+		clrbits32(&pinfo->sccp->scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
 	}
 
 	ret = cpm_uart_allocbuf(pinfo, 0);
@@ -931,10 +938,11 @@ static struct uart_ops cpm_uart_pops = {
 #ifdef CONFIG_PPC_CPM_NEW_BINDING
 struct uart_cpm_port cpm_uart_ports[UART_NR];
 
-int cpm_uart_init_port(struct device_node *np, struct uart_cpm_port *pinfo)
+static int cpm_uart_init_port(struct device_node *np,
+                              struct uart_cpm_port *pinfo)
 {
 	const u32 *data;
-	void __iomem *mem, __iomem *pram;
+	void __iomem *mem, *pram;
 	int len;
 	int ret;
 
@@ -1169,8 +1177,8 @@ static void cpm_uart_console_write(struct console *co, const char *s,
 	    &cpm_uart_ports[cpm_uart_port_map[co->index]];
 #endif
 	unsigned int i;
-	volatile cbd_t *bdp, *bdbase;
-	volatile unsigned char *cp;
+	cbd_t __iomem *bdp, *bdbase;
+	unsigned char *cp;
 
 	/* Get the address of the host memory buffer.
 	 */
@@ -1188,37 +1196,36 @@ static void cpm_uart_console_write(struct console *co, const char *s,
 		 * Ready indicates output is ready, and xmt is doing
 		 * that, not that it is ready for us to send.
 		 */
-		while ((bdp->cbd_sc & BD_SC_READY) != 0)
+		while ((in_be16(&bdp->cbd_sc) & BD_SC_READY) != 0)
 			;
 
 		/* Send the character out.
 		 * If the buffer address is in the CPM DPRAM, don't
 		 * convert it.
 		 */
-		cp = cpm2cpu_addr(bdp->cbd_bufaddr, pinfo);
-
+		cp = cpm2cpu_addr(in_be32(&bdp->cbd_bufaddr), pinfo);
 		*cp = *s;
 
-		bdp->cbd_datlen = 1;
-		bdp->cbd_sc |= BD_SC_READY;
+		out_be16(&bdp->cbd_datlen, 1);
+		setbits16(&bdp->cbd_sc, BD_SC_READY);
 
-		if (bdp->cbd_sc & BD_SC_WRAP)
+		if (in_be16(&bdp->cbd_sc) & BD_SC_WRAP)
 			bdp = bdbase;
 		else
 			bdp++;
 
 		/* if a LF, also do CR... */
 		if (*s == 10) {
-			while ((bdp->cbd_sc & BD_SC_READY) != 0)
+			while ((in_be16(&bdp->cbd_sc) & BD_SC_READY) != 0)
 				;
 
-			cp = cpm2cpu_addr(bdp->cbd_bufaddr, pinfo);
-
+			cp = cpm2cpu_addr(in_be32(&bdp->cbd_bufaddr), pinfo);
 			*cp = 13;
-			bdp->cbd_datlen = 1;
-			bdp->cbd_sc |= BD_SC_READY;
 
-			if (bdp->cbd_sc & BD_SC_WRAP)
+			out_be16(&bdp->cbd_datlen, 1);
+			setbits16(&bdp->cbd_sc, BD_SC_READY);
+
+			if (in_be16(&bdp->cbd_sc) & BD_SC_WRAP)
 				bdp = bdbase;
 			else
 				bdp++;
@@ -1229,10 +1236,10 @@ static void cpm_uart_console_write(struct console *co, const char *s,
 	 * Finally, Wait for transmitter & holding register to empty
 	 *  and restore the IER
 	 */
-	while ((bdp->cbd_sc & BD_SC_READY) != 0)
+	while ((in_be16(&bdp->cbd_sc) & BD_SC_READY) != 0)
 		;
 
-	pinfo->tx_cur = (volatile cbd_t *) bdp;
+	pinfo->tx_cur = bdp;
 }
 
 
@@ -1319,11 +1326,11 @@ static int __init cpm_uart_console_setup(struct console *co, char *options)
 #endif
 
 	if (IS_SMC(pinfo)) {
-		pinfo->smcp->smc_smcm &= ~(SMCM_RX | SMCM_TX);
-		pinfo->smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
+		clrbits8(&pinfo->smcp->smc_smcm, SMCM_RX | SMCM_TX);
+		clrbits16(&pinfo->smcp->smc_smcmr, SMCMR_REN | SMCMR_TEN);
 	} else {
-		pinfo->sccp->scc_sccm &= ~(UART_SCCM_TX | UART_SCCM_RX);
-		pinfo->sccp->scc_gsmrl &= ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
+		clrbits16(&pinfo->sccp->scc_sccm, UART_SCCM_TX | UART_SCCM_RX);
+		clrbits32(&pinfo->sccp->scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
 	}
 
 	ret = cpm_uart_allocbuf(pinfo, 1);
@@ -1354,7 +1361,7 @@ static struct console cpm_scc_uart_console = {
 	.data		= &cpm_reg,
 };
 
-int __init cpm_uart_console_init(void)
+static int __init cpm_uart_console_init(void)
 {
 	register_console(&cpm_scc_uart_console);
 	return 0;
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
index 4647f55..52fb044 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
@@ -179,7 +179,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
 	pinfo->tx_buf = pinfo->rx_buf + L1_CACHE_ALIGN(pinfo->rx_nrfifos
 						       * pinfo->rx_fifosize);
 
-	pinfo->rx_bd_base = (volatile cbd_t *)dp_mem;
+	pinfo->rx_bd_base = (cbd_t __iomem __force *)dp_mem;
 	pinfo->tx_bd_base = pinfo->rx_bd_base + pinfo->rx_nrfifos;
 
 	return 0;
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.h b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
index cdc9b22..470b093 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.h
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
@@ -27,18 +27,18 @@ static inline void cpm_set_brg(int brg, int baud)
 	cpm_setbrg(brg, baud);
 }
 
-static inline void cpm_set_scc_fcr(volatile scc_uart_t * sup)
+static inline void cpm_set_scc_fcr(scc_uart_t __iomem * sup)
 {
-	sup->scc_genscc.scc_rfcr = SMC_EB;
-	sup->scc_genscc.scc_tfcr = SMC_EB;
+	out_8(&sup->scc_genscc.scc_rfcr, SMC_EB);
+	out_8(&sup->scc_genscc.scc_tfcr, SMC_EB);
 }
 
-static inline void cpm_set_smc_fcr(volatile smc_uart_t * up)
+static inline void cpm_set_smc_fcr(smc_uart_t __iomem * up)
 {
-	up->smc_rfcr = SMC_EB;
-	up->smc_tfcr = SMC_EB;
+	out_8(&up->smc_rfcr, SMC_EB);
+	out_8(&up->smc_tfcr, SMC_EB);
 }
 
-#define DPRAM_BASE	((unsigned char *)&cpmp->cp_dpmem[0])
+#define DPRAM_BASE	((u8 __iomem __force *)&cpmp->cp_dpmem[0])
 
 #endif
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index 7ebce26..5bd4508 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -278,7 +278,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
 	pinfo->tx_buf = pinfo->rx_buf + L1_CACHE_ALIGN(pinfo->rx_nrfifos
 						       * pinfo->rx_fifosize);
 
-	pinfo->rx_bd_base = (volatile cbd_t *)dp_mem;
+	pinfo->rx_bd_base = (cbd_t __iomem __force *)dp_mem;
 	pinfo->tx_bd_base = pinfo->rx_bd_base + pinfo->rx_nrfifos;
 
 	return 0;
@@ -289,7 +289,7 @@ void cpm_uart_freebuf(struct uart_cpm_port *pinfo)
 	dma_free_coherent(NULL, L1_CACHE_ALIGN(pinfo->rx_nrfifos *
 					       pinfo->rx_fifosize) +
 			  L1_CACHE_ALIGN(pinfo->tx_nrfifos *
-					 pinfo->tx_fifosize), pinfo->mem_addr,
+					 pinfo->tx_fifosize), (void __force *)pinfo->mem_addr,
 			  pinfo->dma_addr);
 
 	cpm_dpfree(pinfo->dp_addr);
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.h b/drivers/serial/cpm_uart/cpm_uart_cpm2.h
index e7717ec..40006a7 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.h
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.h
@@ -27,18 +27,18 @@ static inline void cpm_set_brg(int brg, int baud)
 	cpm_setbrg(brg, baud);
 }
 
-static inline void cpm_set_scc_fcr(volatile scc_uart_t * sup)
+static inline void cpm_set_scc_fcr(scc_uart_t __iomem *sup)
 {
-	sup->scc_genscc.scc_rfcr = CPMFCR_GBL | CPMFCR_EB;
-	sup->scc_genscc.scc_tfcr = CPMFCR_GBL | CPMFCR_EB;
+	out_8(&sup->scc_genscc.scc_rfcr, CPMFCR_GBL | CPMFCR_EB);
+	out_8(&sup->scc_genscc.scc_tfcr, CPMFCR_GBL | CPMFCR_EB);
 }
 
-static inline void cpm_set_smc_fcr(volatile smc_uart_t * up)
+static inline void cpm_set_smc_fcr(smc_uart_t __iomem *up)
 {
-	up->smc_rfcr = CPMFCR_GBL | CPMFCR_EB;
-	up->smc_tfcr = CPMFCR_GBL | CPMFCR_EB;
+	out_8(&up->smc_rfcr, CPMFCR_GBL | CPMFCR_EB);
+	out_8(&up->smc_tfcr, CPMFCR_GBL | CPMFCR_EB);
 }
 
-#define DPRAM_BASE	((unsigned char *)cpm_dpram_addr(0))
+#define DPRAM_BASE	((u8 __iomem __force *)cpm_dpram_addr(0))
 
 #endif
-- 
1.5.0.3
