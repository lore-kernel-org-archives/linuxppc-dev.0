Return-Path: <kpoole@mrv.com>
Received: from mailserver.corp.int.mrv.com (mx2.lb.mrv.com [66.43.110.200])
	by ozlabs.org (Postfix) with ESMTP id C624B679E7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Apr 2006 05:24:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: kernel 2.6.15: cpm_uart driver broken?
Date: Wed, 19 Apr 2006 15:24:55 -0400
Message-ID: <4D8794260B62C940BBA7150CC5EB3BD432D4F4@bosmail.BOS.int.mrv.com>
From: "Kenneth Poole" <kpoole@mrv.com>
To: "Vitaly Bordug" <vbordug@ru.mvista.com>,
	"David Jander" <david.jander@protonic.nl>
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




>If there is any code to reference, I'd appreciate it (and merge to the
>driver).=20

Ok, here's a patch, below. It includes changes for DMA buffer allocation
as discussed. This is untested, because the CPM uart driver for our
platforms has many other modifications that don't apply.

It also includes a fix for sending x_char in cpm_uart_tx_pump(). This
allows the actual x_char to be sent, instead of the next regular
character.

-------------------------------------------------------------
--- cpm_uart_core.c.orig	2006-04-19 10:24:47.000000000 -0400
+++ cpm_uart_core.c	2006-04-19 10:51:43.000000000 -0400
@@ -71,20 +71,6 @@
=20
 /**************************************************************/
=20
-static inline unsigned long cpu2cpm_addr(void *addr)
-{
-	if ((unsigned long)addr >=3D CPM_ADDR)
-		return (unsigned long)addr;
-	return virt_to_bus(addr);
-}
-
-static inline void *cpm2cpu_addr(unsigned long addr)
-{
-	if (addr >=3D CPM_ADDR)
-		return (void *)addr;
-	return bus_to_virt(addr);
-}
-
 /*
  * Check, if transmit buffers are processed
 */
@@ -261,7 +247,7 @@
 		}
=20
 		/* get pointer */
-		cp =3D cpm2cpu_addr(bdp->cbd_bufaddr);
+		cp =3D (unsigned char *)pinfo->mem_addr +
(bdp->cbd_bufaddr - pinfo->dma_addr);
=20
 		/* loop through the buffer */
 		while (i-- > 0) {
@@ -606,11 +592,12 @@
 		/* Pick next descriptor and fill from buffer */
 		bdp =3D pinfo->tx_cur;
=20
-		p =3D cpm2cpu_addr(bdp->cbd_bufaddr);
+		p =3D (unsigned char *)pinfo->mem_addr + (bdp->cbd_bufaddr
- pinfo->dma_addr);
=20
-		*p++ =3D xmit->buf[xmit->tail];
+		*p =3D port->x_char;
 		bdp->cbd_datlen =3D 1;
 		bdp->cbd_sc |=3D BD_SC_READY;
+		__asm__("eieio");
 		/* Get next BD. */
 		if (bdp->cbd_sc & BD_SC_WRAP)
 			bdp =3D pinfo->tx_bd_base;
@@ -633,7 +620,7 @@
=20
 	while (!(bdp->cbd_sc & BD_SC_READY) && (xmit->tail !=3D
xmit->head)) {
 		count =3D 0;
-		p =3D cpm2cpu_addr(bdp->cbd_bufaddr);
+		p =3D (unsigned char *)pinfo->mem_addr + (bdp->cbd_bufaddr
- pinfo->dma_addr);
 		while (count < pinfo->tx_fifosize) {
 			*p++ =3D xmit->buf[xmit->tail];
 			xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE
- 1);
@@ -670,39 +657,37 @@
 static void cpm_uart_initbd(struct uart_cpm_port *pinfo)
 {
 	int i;
-	u8 *mem_addr;
+	dma_addr_t dma_addr;
 	volatile cbd_t *bdp;
=20
 	pr_debug("CPM uart[%d]:initbd\n", pinfo->port.line);
=20
 	/* Set the physical address of the host memory
-	 * buffers in the buffer descriptors, and the
-	 * virtual address for us to work with.
+	 * buffers in the buffer descriptors.
 	 */
-	mem_addr =3D pinfo->mem_addr;
+	dma_addr =3D pinfo->dma_addr;
 	bdp =3D pinfo->rx_cur =3D pinfo->rx_bd_base;
 	for (i =3D 0; i < (pinfo->rx_nrfifos - 1); i++, bdp++) {
-		bdp->cbd_bufaddr =3D cpu2cpm_addr(mem_addr);
+		bdp->cbd_bufaddr =3D dma_addr;
 		bdp->cbd_sc =3D BD_SC_EMPTY | BD_SC_INTRPT;
-		mem_addr +=3D pinfo->rx_fifosize;
+		dma_addr +=3D pinfo->rx_fifosize;
 	}
-
-	bdp->cbd_bufaddr =3D cpu2cpm_addr(mem_addr);
+=09
+	bdp->cbd_bufaddr =3D dma_addr;
 	bdp->cbd_sc =3D BD_SC_WRAP | BD_SC_EMPTY | BD_SC_INTRPT;
=20
 	/* Set the physical address of the host memory
-	 * buffers in the buffer descriptors, and the
-	 * virtual address for us to work with.
+	 * buffers in the buffer descriptors.
 	 */
-	mem_addr =3D pinfo->mem_addr + L1_CACHE_ALIGN(pinfo->rx_nrfifos *
pinfo->rx_fifosize);
+	dma_addr =3D pinfo->dma_addr + L1_CACHE_ALIGN(pinfo->rx_nrfifos *
pinfo->rx_fifosize);
 	bdp =3D pinfo->tx_cur =3D pinfo->tx_bd_base;
 	for (i =3D 0; i < (pinfo->tx_nrfifos - 1); i++, bdp++) {
-		bdp->cbd_bufaddr =3D cpu2cpm_addr(mem_addr);
+		bdp->cbd_bufaddr =3D dma_addr;
 		bdp->cbd_sc =3D BD_SC_INTRPT;
-		mem_addr +=3D pinfo->tx_fifosize;
+		dma_addr +=3D pinfo->tx_fifosize;
 	}
-
-	bdp->cbd_bufaddr =3D cpu2cpm_addr(mem_addr);
+=09
+	bdp->cbd_bufaddr =3D dma_addr;
 	bdp->cbd_sc =3D BD_SC_WRAP | BD_SC_INTRPT;
 }
=20
@@ -1032,7 +1017,7 @@
 		 * If the buffer address is in the CPM DPRAM, don't
 		 * convert it.
 		 */
-		cp =3D cpm2cpu_addr(bdp->cbd_bufaddr);
+		cp =3D (unsigned char *)pinfo->mem_addr +
(bdp->cbd_bufaddr - pinfo->dma_addr);
=20
 		*cp =3D *s;
=20
@@ -1049,7 +1034,7 @@
 			while ((bdp->cbd_sc & BD_SC_READY) !=3D 0)
 				;
=20
-			cp =3D cpm2cpu_addr(bdp->cbd_bufaddr);
+			cp =3D (unsigned char *)pinfo->mem_addr +
(bdp->cbd_bufaddr - pinfo->dma_addr);
=20
 			*cp =3D 13;
 			bdp->cbd_datlen =3D 1;
--- cpm_uart_cpm1.c.orig	2006-04-19 10:26:46.000000000 -0400
+++ cpm_uart_cpm1.c	2006-04-19 10:32:05.000000000 -0400
@@ -191,7 +191,7 @@
 		/* was hostalloc but changed cause it blows away the */
 		/* large tlb mapping when pinning the kernel area    */
 		mem_addr =3D (u8 *) cpm_dpram_addr(cpm_dpalloc(memsz, 8));
-		dma_addr =3D 0;
+		dma_addr =3D (dma_addr_t)mem_addr;
 	} else
 		mem_addr =3D dma_alloc_coherent(NULL, memsz, &dma_addr,
 					      GFP_KERNEL);

----------------------------------------------------------

Ken Poole
kpoole@bos.mrv.com
=20
