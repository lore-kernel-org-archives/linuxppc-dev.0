Return-Path: <pantelis.antoniou@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.202])
	by ozlabs.org (Postfix) with ESMTP id D161367E78
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Aug 2005 23:58:15 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i24so1218754wra
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 02 Aug 2005 06:58:14 -0700 (PDT)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Date: Tue, 2 Aug 2005 19:09:45 +0300
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Jr57CfX81RlFIug"
Message-Id: <200508021909.45729.pantelis.antoniou@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] cpm_uart: make dpram allocation actually work
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_Jr57CfX81RlFIug
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

  Hi Marcelo

While the idea of allocating console buffers from dpram is sound, 
the initial implementation didn't actually work :)

The following patch fixes it (tested and booted on 2.6.13-rc4).

Regards

Pantelis

--------------------------------------------------------------

Signed-Off-By: Pantelis Antoniou <panto@intracom.gr>

--Boundary-00=_Jr57CfX81RlFIug
Content-Type: text/x-diff; charset="us-ascii"; name="cpm_uart-dpram-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cpm_uart-dpram-fix.patch"

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -70,6 +70,20 @@ static void cpm_uart_initbd(struct uart_
 
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
@@ -243,7 +257,7 @@ static void cpm_uart_int_rx(struct uart_
 		}
 
 		/* get pointer */
-		cp = (unsigned char *)bus_to_virt(bdp->cbd_bufaddr);
+		cp = cpm2cpu_addr(bdp->cbd_bufaddr);
 
 		/* loop through the buffer */
 		while (i-- > 0) {
@@ -569,7 +583,8 @@ static int cpm_uart_tx_pump(struct uart_
 		/* Pick next descriptor and fill from buffer */
 		bdp = pinfo->tx_cur;
 
-		p = bus_to_virt(bdp->cbd_bufaddr);
+		p = cpm2cpu_addr(bdp->cbd_bufaddr);
+
 		*p++ = xmit->buf[xmit->tail];
 		bdp->cbd_datlen = 1;
 		bdp->cbd_sc |= BD_SC_READY;
@@ -595,7 +610,7 @@ static int cpm_uart_tx_pump(struct uart_
 
 	while (!(bdp->cbd_sc & BD_SC_READY) && (xmit->tail != xmit->head)) {
 		count = 0;
-		p = bus_to_virt(bdp->cbd_bufaddr);
+		p = cpm2cpu_addr(bdp->cbd_bufaddr);
 		while (count < pinfo->tx_fifosize) {
 			*p++ = xmit->buf[xmit->tail];
 			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
@@ -643,12 +658,12 @@ static void cpm_uart_initbd(struct uart_
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
@@ -658,12 +673,12 @@ static void cpm_uart_initbd(struct uart_
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
 
@@ -983,10 +998,7 @@ static void cpm_uart_console_write(struc
 		 * If the buffer address is in the CPM DPRAM, don't
 		 * convert it.
 		 */
-		if ((uint) (bdp->cbd_bufaddr) > (uint) CPM_ADDR)
-			cp = (unsigned char *) (bdp->cbd_bufaddr);
-		else
-			cp = bus_to_virt(bdp->cbd_bufaddr);
+		cp = cpm2cpu_addr(bdp->cbd_bufaddr);
 		
 		*cp = *s;
 
@@ -1003,10 +1015,7 @@ static void cpm_uart_console_write(struc
 			while ((bdp->cbd_sc & BD_SC_READY) != 0)
 				;
 
-			if ((uint) (bdp->cbd_bufaddr) > (uint) CPM_ADDR)
-				cp = (unsigned char *) (bdp->cbd_bufaddr);
-			else
-				cp = bus_to_virt(bdp->cbd_bufaddr);
+			cp = cpm2cpu_addr(bdp->cbd_bufaddr);
 
 			*cp = 13;
 			bdp->cbd_datlen = 1;
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
@@ -185,6 +185,8 @@ int cpm_uart_allocbuf(struct uart_cpm_po
 	memsz = L1_CACHE_ALIGN(pinfo->rx_nrfifos * pinfo->rx_fifosize) +
 	    L1_CACHE_ALIGN(pinfo->tx_nrfifos * pinfo->tx_fifosize);
 	if (is_con) {
+		/* was hostalloc but changed cause it blows away the */
+		/* large tlb mapping when pinning the kernel area    */
 		mem_addr = (u8 *) cpm_dpram_addr(cpm_dpalloc(memsz, 8));
 		dma_addr = 0;
 	} else

--Boundary-00=_Jr57CfX81RlFIug--
