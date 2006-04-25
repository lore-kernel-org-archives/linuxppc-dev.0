Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 681BE67A3B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Apr 2006 19:53:25 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] fix cpm_uart driver for PQ1...
Date: Tue, 25 Apr 2006 11:55:50 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_mIfTEtwQfQDMkST"
Message-Id: <200604251155.50781.david.jander@protonic.nl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_mIfTEtwQfQDMkST
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi,

This patch fixes the following three problems:

1. Memory mapping virtual<-->dma is broken in the case that 
CONFIG_CONSISTENT_START > CPM_ADDR.

2. SCC uart sends a break sequence each time it is stopped with the 
CPM_CR_STOP_TX command. That means that each time an application closes the 
serial device, a break is transmitted.

3. Implemented default BRG routing for PQ1 (in the same sense as it is done 
for PQ2).

Signed-off-by: David Jander

Regards,

David.


--Boundary-00=_mIfTEtwQfQDMkST
Content-Type: text/x-diff;
  charset="us-ascii";
  name="cpm_uart_patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cpm_uart_patch.diff"

diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
@@ -138,25 +138,33 @@ void smc2_lineif(struct uart_cpm_port *p
 
 void scc1_lineif(struct uart_cpm_port *pinfo)
 {
+	volatile cpm8xx_t *cp = cpmp;
 	/* XXX SCC1: insert port configuration here */
+	cp->cp_sicr = (cp->cp_sicr & ~0x0000003f) | 0x00000000; /* Route BRG1 to SCC1 */
 	pinfo->brg = 1;
 }
 
 void scc2_lineif(struct uart_cpm_port *pinfo)
 {
+	volatile cpm8xx_t *cp = cpmp;
 	/* XXX SCC2: insert port configuration here */
+	cp->cp_sicr = (cp->cp_sicr & ~0x00003f00) | 0x00000900; /* Route BRG2 to SCC2 */
 	pinfo->brg = 2;
 }
 
 void scc3_lineif(struct uart_cpm_port *pinfo)
 {
+	volatile cpm8xx_t *cp = cpmp;
 	/* XXX SCC3: insert port configuration here */
+	cp->cp_sicr = (cp->cp_sicr & ~0x003f0000) | 0x00120000; /* Route BRG3 to SCC3 */
 	pinfo->brg = 3;
 }
 
 void scc4_lineif(struct uart_cpm_port *pinfo)
 {
+	volatile cpm8xx_t *cp = cpmp;
 	/* XXX SCC4: insert port configuration here */
+	cp->cp_sicr = (cp->cp_sicr & ~0x3f000000) | 0x1b000000; /* Route BRG4 to SCC4 */
 	pinfo->brg = 4;
 }
 
@@ -191,11 +199,11 @@ int cpm_uart_allocbuf(struct uart_cpm_po
 		/* was hostalloc but changed cause it blows away the */
 		/* large tlb mapping when pinning the kernel area    */
 		mem_addr = (u8 *) cpm_dpram_addr(cpm_dpalloc(memsz, 8));
-		dma_addr = 0;
+		dma_addr = (dma_addr_t)mem_addr;
 	} else
 		mem_addr = dma_alloc_coherent(NULL, memsz, &dma_addr,
 					      GFP_KERNEL);
-
+	
 	if (mem_addr == NULL) {
 		cpm_dpfree(dp_offset);
 		printk(KERN_ERR
@@ -206,6 +214,7 @@ int cpm_uart_allocbuf(struct uart_cpm_po
 	pinfo->dp_addr = dp_offset;
 	pinfo->mem_addr = mem_addr;
 	pinfo->dma_addr = dma_addr;
+	pinfo->dma_offset = (dma_addr_t)((unsigned long)dma_addr - (unsigned long)mem_addr);
 
 	pinfo->rx_buf = mem_addr;
 	pinfo->tx_buf = pinfo->rx_buf + L1_CACHE_ALIGN(pinfo->rx_nrfifos
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -71,17 +71,19 @@ static void cpm_uart_initbd(struct uart_
 
 /**************************************************************/
 
-static inline unsigned long cpu2cpm_addr(void *addr)
+static inline unsigned long cpu2cpm_addr(void *addr, unsigned long offset)
 {
-	if ((unsigned long)addr >= CPM_ADDR)
-		return (unsigned long)addr;
+	if (((unsigned long)addr >= CPM_ADDR) 
+		|| ((unsigned long)addr >= CONFIG_CONSISTENT_START))
+		return (unsigned long)addr + offset;
 	return virt_to_bus(addr);
 }
 
-static inline void *cpm2cpu_addr(unsigned long addr)
+static inline void *cpm2cpu_addr(unsigned long addr, unsigned long offset)
 {
-	if (addr >= CPM_ADDR)
-		return (void *)addr;
+	if (((unsigned long)(addr - offset) >= CPM_ADDR) 
+		|| ((unsigned long)(addr - offset) >= CONFIG_CONSISTENT_START))
+		return (void *)(addr - offset);
 	return bus_to_virt(addr);
 }
 
@@ -260,7 +262,7 @@ static void cpm_uart_int_rx(struct uart_
 		}
 
 		/* get pointer */
-		cp = cpm2cpu_addr(bdp->cbd_bufaddr);
+		cp = cpm2cpu_addr(bdp->cbd_bufaddr, pinfo->dma_offset);
 
 		/* loop through the buffer */
 		while (i-- > 0) {
@@ -441,7 +443,8 @@ static void cpm_uart_shutdown(struct uar
 		}
 
 		/* Shut them really down */
-		cpm_line_cr_cmd(line, CPM_CR_STOP_TX);
+		if (IS_SMC(pinfo)) cpm_line_cr_cmd(line, CPM_CR_STOP_TX);
+		else cpm_line_cr_cmd(line, CPM_CR_STOP_TX+1); /* Do graceful stop of SCC uart */
 	}
 }
 
@@ -603,7 +606,7 @@ static int cpm_uart_tx_pump(struct uart_
 		/* Pick next descriptor and fill from buffer */
 		bdp = pinfo->tx_cur;
 
-		p = cpm2cpu_addr(bdp->cbd_bufaddr);
+		p = cpm2cpu_addr(bdp->cbd_bufaddr, pinfo->dma_offset);
 
 		*p++ = xmit->buf[xmit->tail];
 		bdp->cbd_datlen = 1;
@@ -630,7 +633,7 @@ static int cpm_uart_tx_pump(struct uart_
 
 	while (!(bdp->cbd_sc & BD_SC_READY) && (xmit->tail != xmit->head)) {
 		count = 0;
-		p = cpm2cpu_addr(bdp->cbd_bufaddr);
+		p = cpm2cpu_addr(bdp->cbd_bufaddr, pinfo->dma_offset);
 		while (count < pinfo->tx_fifosize) {
 			*p++ = xmit->buf[xmit->tail];
 			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
@@ -668,6 +671,7 @@ static void cpm_uart_initbd(struct uart_
 {
 	int i;
 	u8 *mem_addr;
+	unsigned long dma_offset;
 	volatile cbd_t *bdp;
 
 	pr_debug("CPM uart[%d]:initbd\n", pinfo->port.line);
@@ -677,14 +681,15 @@ static void cpm_uart_initbd(struct uart_
 	 * virtual address for us to work with.
 	 */
 	mem_addr = pinfo->mem_addr;
+	dma_offset = pinfo->dma_offset;
 	bdp = pinfo->rx_cur = pinfo->rx_bd_base;
 	for (i = 0; i < (pinfo->rx_nrfifos - 1); i++, bdp++) {
-		bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr);
+		bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr, dma_offset);
 		bdp->cbd_sc = BD_SC_EMPTY | BD_SC_INTRPT;
 		mem_addr += pinfo->rx_fifosize;
 	}
 
-	bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr);
+	bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr, dma_offset);
 	bdp->cbd_sc = BD_SC_WRAP | BD_SC_EMPTY | BD_SC_INTRPT;
 
 	/* Set the physical address of the host memory
@@ -694,12 +699,12 @@ static void cpm_uart_initbd(struct uart_
 	mem_addr = pinfo->mem_addr + L1_CACHE_ALIGN(pinfo->rx_nrfifos * pinfo->rx_fifosize);
 	bdp = pinfo->tx_cur = pinfo->tx_bd_base;
 	for (i = 0; i < (pinfo->tx_nrfifos - 1); i++, bdp++) {
-		bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr);
+		bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr, dma_offset);
 		bdp->cbd_sc = BD_SC_INTRPT;
 		mem_addr += pinfo->tx_fifosize;
 	}
 
-	bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr);
+	bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr, dma_offset);
 	bdp->cbd_sc = BD_SC_WRAP | BD_SC_INTRPT;
 }
 
@@ -1029,7 +1034,7 @@ static void cpm_uart_console_write(struc
 		 * If the buffer address is in the CPM DPRAM, don't
 		 * convert it.
 		 */
-		cp = cpm2cpu_addr(bdp->cbd_bufaddr);
+		cp = cpm2cpu_addr(bdp->cbd_bufaddr, pinfo->dma_offset);
 
 		*cp = *s;
 
@@ -1046,7 +1051,7 @@ static void cpm_uart_console_write(struc
 			while ((bdp->cbd_sc & BD_SC_READY) != 0)
 				;
 
-			cp = cpm2cpu_addr(bdp->cbd_bufaddr);
+			cp = cpm2cpu_addr(bdp->cbd_bufaddr, pinfo->dma_offset);
 
 			*cp = 13;
 			bdp->cbd_datlen = 1;
diff --git a/drivers/serial/cpm_uart/cpm_uart.h b/drivers/serial/cpm_uart/cpm_uart.h
--- a/drivers/serial/cpm_uart/cpm_uart.h
+++ b/drivers/serial/cpm_uart/cpm_uart.h
@@ -64,6 +64,7 @@ struct uart_cpm_port {
 	uint			 dp_addr;
 	void			*mem_addr;
 	dma_addr_t		 dma_addr;
+	unsigned long	 dma_offset;
 	/* helpers */
 	int			 baud;
 	int			 bits;

--Boundary-00=_mIfTEtwQfQDMkST--
