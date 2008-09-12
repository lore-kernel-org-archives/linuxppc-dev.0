Return-Path: <bgill@blarg.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D2BFBDDF80
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Sep 2008 01:43:10 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m8CFh2ZT026131
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 08:43:03 -0700 (MST)
Received: from blarg.am.freescale.net (blarg.am.freescale.net [10.82.19.176])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	m8CFgvKN023807
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 10:43:02 -0500 (CDT)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V2] Pass actual dev ptr to dma_* in ucc and cpm_uart serial
Date: Fri, 12 Sep 2008 10:42:56 -0500
Message-Id: <1221234176-14937-1-git-send-email-becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We're currently passing NULL, and really shouldn't be.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
---
 drivers/serial/cpm_uart/cpm_uart_core.c |    3 +++
 drivers/serial/cpm_uart/cpm_uart_cpm1.c |    6 +++---
 drivers/serial/cpm_uart/cpm_uart_cpm2.c |    6 +++---
 drivers/serial/ucc_uart.c               |    4 ++--
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index 25efca5..a6c4d74 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -1333,6 +1333,9 @@ static int __devinit cpm_uart_probe(struct of_device *ofdev,
 	if (ret)
 		return ret;
 
+	/* initialize the device pointer for the port */
+	pinfo->port.dev = &ofdev->dev;
+
 	return uart_add_one_port(&cpm_reg, &pinfo->port);
 }
 
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
index 0f0aff0..1b94c56 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
@@ -100,7 +100,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
 		mem_addr = (u8 *) cpm_dpram_addr(cpm_dpalloc(memsz, 8));
 		dma_addr = (u32)cpm_dpram_phys(mem_addr);
 	} else
-		mem_addr = dma_alloc_coherent(NULL, memsz, &dma_addr,
+		mem_addr = dma_alloc_coherent(pinfo->port.dev, memsz, &dma_addr,
 					      GFP_KERNEL);
 
 	if (mem_addr == NULL) {
@@ -127,8 +127,8 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
 
 void cpm_uart_freebuf(struct uart_cpm_port *pinfo)
 {
-	dma_free_coherent(NULL, L1_CACHE_ALIGN(pinfo->rx_nrfifos *
-					       pinfo->rx_fifosize) +
+	dma_free_coherent(pinfo->port.dev, L1_CACHE_ALIGN(pinfo->rx_nrfifos *
+							  pinfo->rx_fifosize) +
 			  L1_CACHE_ALIGN(pinfo->tx_nrfifos *
 					 pinfo->tx_fifosize), pinfo->mem_addr,
 			  pinfo->dma_addr);
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index b8db4d3..141c0a3 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -136,7 +136,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
 		dma_addr = virt_to_bus(mem_addr);
 	}
 	else
-		mem_addr = dma_alloc_coherent(NULL, memsz, &dma_addr,
+		mem_addr = dma_alloc_coherent(pinfo->port.dev, memsz, &dma_addr,
 					      GFP_KERNEL);
 
 	if (mem_addr == NULL) {
@@ -163,8 +163,8 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
 
 void cpm_uart_freebuf(struct uart_cpm_port *pinfo)
 {
-	dma_free_coherent(NULL, L1_CACHE_ALIGN(pinfo->rx_nrfifos *
-					       pinfo->rx_fifosize) +
+	dma_free_coherent(pinfo->port.dev, L1_CACHE_ALIGN(pinfo->rx_nrfifos *
+							  pinfo->rx_fifosize) +
 			  L1_CACHE_ALIGN(pinfo->tx_nrfifos *
 					 pinfo->tx_fifosize), (void __force *)pinfo->mem_addr,
 			  pinfo->dma_addr);
diff --git a/drivers/serial/ucc_uart.c b/drivers/serial/ucc_uart.c
index 5c5d18d..539c933 100644
--- a/drivers/serial/ucc_uart.c
+++ b/drivers/serial/ucc_uart.c
@@ -1009,7 +1009,7 @@ static int qe_uart_request_port(struct uart_port *port)
 	rx_size = L1_CACHE_ALIGN(qe_port->rx_nrfifos * qe_port->rx_fifosize);
 	tx_size = L1_CACHE_ALIGN(qe_port->tx_nrfifos * qe_port->tx_fifosize);
 
-	bd_virt = dma_alloc_coherent(NULL, rx_size + tx_size, &bd_dma_addr,
+	bd_virt = dma_alloc_coherent(port->dev, rx_size + tx_size, &bd_dma_addr,
 		GFP_KERNEL);
 	if (!bd_virt) {
 		dev_err(port->dev, "could not allocate buffer descriptors\n");
@@ -1051,7 +1051,7 @@ static void qe_uart_release_port(struct uart_port *port)
 		container_of(port, struct uart_qe_port, port);
 	struct ucc_slow_private *uccs = qe_port->us_private;
 
-	dma_free_coherent(NULL, qe_port->bd_size, qe_port->bd_virt,
+	dma_free_coherent(port->dev, qe_port->bd_size, qe_port->bd_virt,
 			  qe_port->bd_dma_addr);
 
 	ucc_slow_free(uccs);
-- 
1.5.5.1
