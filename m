Return-Path: <vbordug@ru.mvista.com>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 92DF6679F8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Apr 2006 02:26:49 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 4/4] ppc32 CPM_UART: Fixed odd address translations
Date: Tue, 25 Apr 2006 20:26:46 +0400
Message-Id: <20060425162646.23551.61674.stgit@vitb.ru.mvista.com>
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


Current address translation methods can produce wrong results, because
virt_to_bus and vice versa may not produce correct offsets on dma-allocated
memory. The right way is, while tracking both phys and virt address of the
window that has been allocated for boffer descriptors, and use those
numbers to compute the offset and make translation properly.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 drivers/serial/cpm_uart/cpm_uart.h      |   33 +++++++++++++++++++++++++++++++
 drivers/serial/cpm_uart/cpm_uart_core.c |   31 ++++++++---------------------
 drivers/serial/cpm_uart/cpm_uart_cpm1.c |    7 ++++---
 drivers/serial/cpm_uart/cpm_uart_cpm2.c |    5 ++++-
 4 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart.h b/drivers/serial/cpm_uart/cpm_uart.h
index 17f2c7a..9db402c 100644
--- a/drivers/serial/cpm_uart/cpm_uart.h
+++ b/drivers/serial/cpm_uart/cpm_uart.h
@@ -66,6 +66,7 @@ struct uart_cpm_port {
 	uint			 dp_addr;
 	void			*mem_addr;
 	dma_addr_t		 dma_addr;
+	u32			mem_size;
 	/* helpers */
 	int			 baud;
 	int			 bits;
@@ -92,4 +93,36 @@ void scc2_lineif(struct uart_cpm_port *p
 void scc3_lineif(struct uart_cpm_port *pinfo);
 void scc4_lineif(struct uart_cpm_port *pinfo);
 
+/* 
+   virtual to phys transtalion
+*/
+static inline unsigned long cpu2cpm_addr(void* addr, struct uart_cpm_port *pinfo)
+{
+	int offset;
+	u32 val = (u32)addr;
+	/* sane check */
+	if ((val >= (u32)pinfo->mem_addr) && 
+			(val<((u32)pinfo->mem_addr + pinfo->mem_size))) {
+		offset = val - (u32)pinfo->mem_addr;
+		return pinfo->dma_addr+offset;
+	}
+	printk("%s(): address %x to translate out of range!\n", __FUNCTION__, val);
+	return 0;
+}
+
+static inline void *cpm2cpu_addr(unsigned long addr, struct uart_cpm_port *pinfo)
+{	
+	int offset;
+	u32 val = addr;
+	/* sane check */
+	if ((val >= pinfo->dma_addr) && 
+			(val<(pinfo->dma_addr + pinfo->mem_size))) {
+		offset = val - (u32)pinfo->dma_addr;
+		return (void*)(pinfo->mem_addr+offset);
+	}
+	printk("%s(): address %x to translate out of range!\n", __FUNCTION__, val);
+	return 0;
+}
+
+
 #endif /* CPM_UART_H */
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index 8f33815..3549073 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -72,19 +72,6 @@ static void cpm_uart_initbd(struct uart_
 
 /**************************************************************/
 
-static inline unsigned long cpu2cpm_addr(void *addr)
-{
-	if ((unsigned long)addr >= CPM_ADDR)
-		return (unsigned long)addr;
-	return virt_to_bus(addr);
-}
-
-static inline void *cpm2cpu_addr(unsigned long addr)
-{
-	if (addr >= CPM_ADDR)
-		return (void *)addr;
-	return bus_to_virt(addr);
-}
 
 /* Place-holder for board-specific stuff */
 struct platform_device* __attribute__ ((weak)) __init
@@ -290,7 +277,7 @@ static void cpm_uart_int_rx(struct uart_
 		}
 
 		/* get pointer */
-		cp = cpm2cpu_addr(bdp->cbd_bufaddr);
+		cp = cpm2cpu_addr(bdp->cbd_bufaddr, pinfo);
 
 		/* loop through the buffer */
 		while (i-- > 0) {
@@ -633,7 +620,7 @@ static int cpm_uart_tx_pump(struct uart_
 		/* Pick next descriptor and fill from buffer */
 		bdp = pinfo->tx_cur;
 
-		p = cpm2cpu_addr(bdp->cbd_bufaddr);
+		p = cpm2cpu_addr(bdp->cbd_bufaddr, pinfo);
 
 		*p++ = port->x_char;
 		bdp->cbd_datlen = 1;
@@ -660,7 +647,7 @@ static int cpm_uart_tx_pump(struct uart_
 
 	while (!(bdp->cbd_sc & BD_SC_READY) && (xmit->tail != xmit->head)) {
 		count = 0;
-		p = cpm2cpu_addr(bdp->cbd_bufaddr);
+		p = cpm2cpu_addr(bdp->cbd_bufaddr, pinfo);
 		while (count < pinfo->tx_fifosize) {
 			*p++ = xmit->buf[xmit->tail];
 			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
@@ -709,12 +696,12 @@ static void cpm_uart_initbd(struct uart_
 	mem_addr = pinfo->mem_addr;
 	bdp = pinfo->rx_cur = pinfo->rx_bd_base;
 	for (i = 0; i < (pinfo->rx_nrfifos - 1); i++, bdp++) {
-		bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr);
+		bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr, pinfo);
 		bdp->cbd_sc = BD_SC_EMPTY | BD_SC_INTRPT;
 		mem_addr += pinfo->rx_fifosize;
 	}
 
-	bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr);
+	bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr, pinfo);
 	bdp->cbd_sc = BD_SC_WRAP | BD_SC_EMPTY | BD_SC_INTRPT;
 
 	/* Set the physical address of the host memory
@@ -724,12 +711,12 @@ static void cpm_uart_initbd(struct uart_
 	mem_addr = pinfo->mem_addr + L1_CACHE_ALIGN(pinfo->rx_nrfifos * pinfo->rx_fifosize);
 	bdp = pinfo->tx_cur = pinfo->tx_bd_base;
 	for (i = 0; i < (pinfo->tx_nrfifos - 1); i++, bdp++) {
-		bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr);
+		bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr, pinfo);
 		bdp->cbd_sc = BD_SC_INTRPT;
 		mem_addr += pinfo->tx_fifosize;
 	}
 
-	bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr);
+	bdp->cbd_bufaddr = cpu2cpm_addr(mem_addr, pinfo);
 	bdp->cbd_sc = BD_SC_WRAP | BD_SC_INTRPT;
 }
 
@@ -1099,7 +1086,7 @@ static void cpm_uart_console_write(struc
 		 * If the buffer address is in the CPM DPRAM, don't
 		 * convert it.
 		 */
-		cp = cpm2cpu_addr(bdp->cbd_bufaddr);
+		cp = cpm2cpu_addr(bdp->cbd_bufaddr, pinfo);
 
 		*cp = *s;
 
@@ -1116,7 +1103,7 @@ static void cpm_uart_console_write(struc
 			while ((bdp->cbd_sc & BD_SC_READY) != 0)
 				;
 
-			cp = cpm2cpu_addr(bdp->cbd_bufaddr);
+			cp = cpm2cpu_addr(bdp->cbd_bufaddr, pinfo);
 
 			*cp = 13;
 			bdp->cbd_datlen = 1;
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
index 31223aa..a5a3062 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
@@ -144,7 +144,7 @@ int cpm_uart_allocbuf(struct uart_cpm_po
 		/* was hostalloc but changed cause it blows away the */
 		/* large tlb mapping when pinning the kernel area    */
 		mem_addr = (u8 *) cpm_dpram_addr(cpm_dpalloc(memsz, 8));
-		dma_addr = 0;
+		dma_addr = (u32)mem_addr;
 	} else
 		mem_addr = dma_alloc_coherent(NULL, memsz, &dma_addr,
 					      GFP_KERNEL);
@@ -157,8 +157,9 @@ int cpm_uart_allocbuf(struct uart_cpm_po
 	}
 
 	pinfo->dp_addr = dp_offset;
-	pinfo->mem_addr = mem_addr;
-	pinfo->dma_addr = dma_addr;
+	pinfo->mem_addr = mem_addr;             /*  virtual address*/
+	pinfo->dma_addr = dma_addr;             /*  physical address*/
+	pinfo->mem_size = memsz;
 
 	pinfo->rx_buf = mem_addr;
 	pinfo->tx_buf = pinfo->rx_buf + L1_CACHE_ALIGN(pinfo->rx_nrfifos
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index c9c3b1d..7c6b07a 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -209,8 +209,10 @@ int cpm_uart_allocbuf(struct uart_cpm_po
 
 	memsz = L1_CACHE_ALIGN(pinfo->rx_nrfifos * pinfo->rx_fifosize) +
 	    L1_CACHE_ALIGN(pinfo->tx_nrfifos * pinfo->tx_fifosize);
-	if (is_con)
+	if (is_con) {
 		mem_addr = alloc_bootmem(memsz);
+		dma_addr = mem_addr;
+	}
 	else
 		mem_addr = dma_alloc_coherent(NULL, memsz, &dma_addr,
 					      GFP_KERNEL);
@@ -225,6 +227,7 @@ int cpm_uart_allocbuf(struct uart_cpm_po
 	pinfo->dp_addr = dp_offset;
 	pinfo->mem_addr = mem_addr;
 	pinfo->dma_addr = dma_addr;
+	pinfo->mem_size = memsz;
 
 	pinfo->rx_buf = mem_addr;
 	pinfo->tx_buf = pinfo->rx_buf + L1_CACHE_ALIGN(pinfo->rx_nrfifos
