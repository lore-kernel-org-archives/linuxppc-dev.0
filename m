Return-Path: <bgill@blarg.am.freescale.net>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 21DD9DDF79
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 05:21:02 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m88JKs5v020639
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Sep 2008 12:20:55 -0700 (MST)
Received: from blarg.am.freescale.net (blarg.am.freescale.net [10.82.19.176])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	m88JKro0014171
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Sep 2008 14:20:54 -0500 (CDT)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Pass actual dev ptr to dma_* in ucc and cpm_uart serial
Date: Mon,  8 Sep 2008 14:20:53 -0500
Message-Id: <1220901653-12812-1-git-send-email-becky.bruce@freescale.com>
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
 drivers/serial/cpm_uart/cpm_uart_cpm2.c |    6 +++---
 drivers/serial/ucc_uart.c               |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

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
