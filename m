Return-Path: <mware@elphinstone.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 73853B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Jul 2009 21:51:06 +1000 (EST)
Received: from ipmail04.adl2.internode.on.net (ipmail04.adl2.internode.on.net
	[203.16.214.57]) by ozlabs.org (Postfix) with ESMTP id 4E6BBDDDB6
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Jul 2009 21:51:05 +1000 (EST)
Message-ID: <4A645A27.7040002@elphinstone.net>
Date: Mon, 20 Jul 2009 21:51:03 +1000
From: Mark Ware <mware@elphinstone.net>
MIME-Version: 1.0
To: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
Subject: [RFC/PATCH] powerpc: Don't use alloc_bootmem in cpm_uart_cpm2.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is another alloc_bootmem() -> kzalloc() change, this time to
fix the non-fatal badness caused when booting with a cpm2_uart console.

Signed-Off-By: Mark Ware <mware@elphinstone.net>

---
  drivers/serial/cpm_uart/cpm_uart_cpm2.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c 
b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index 141c0a3..a9802e7 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -132,7 +132,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, 
unsigned int is_con)
  	memsz = L1_CACHE_ALIGN(pinfo->rx_nrfifos * pinfo->rx_fifosize) +
  	    L1_CACHE_ALIGN(pinfo->tx_nrfifos * pinfo->tx_fifosize);
  	if (is_con) {
-		mem_addr = alloc_bootmem(memsz);
+		mem_addr = kzalloc(memsz, GFP_NOWAIT);
  		dma_addr = virt_to_bus(mem_addr);
  	}
  	else
-- 
1.5.6.5
