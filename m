Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6F6E0DDEF2
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 18:25:22 +1000 (EST)
Date: Tue, 02 Oct 2007 17:25:16 +0900 (JST)
Message-Id: <20071002.172516.-494087187.kouish@swc.toshiba.co.jp>
Subject: [PATCH 4/5] Celleb: Serial I/O update
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is an update patch for Serial I/O on Celleb.
  - Detection algorithm has been changed

Signed-off-by: Kou Ishizaki <Kou.Ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/platforms/celleb/scc_sio.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/scc_sio.c
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/scc_sio.c
@@ -1,7 +1,7 @@
 /*
  * setup serial port in SCC
  *
- * (C) Copyright 2006 TOSHIBA CORPORATION
+ * (C) Copyright 2006-2007 TOSHIBA CORPORATION
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -42,40 +42,40 @@ static struct {
 static int __init txx9_serial_init(void)
 {
 	extern int early_serial_txx9_setup(struct uart_port *port);
-	struct device_node *node;
+	struct device_node *node = NULL;
 	int i;
 	struct uart_port req;
 	struct of_irq irq;
 	struct resource res;
 
-	node = of_find_node_by_path("/ioif1/sio");
-	if (!node)
-		return 0;
-
-	for(i = 0; i < sizeof(txx9_scc_tab)/sizeof(txx9_scc_tab[0]); i++) {
-		if (!(txx9_serial_bitmap & (1<<i)))
-			continue;
-
-		if (of_irq_map_one(node, i, &irq))
-			continue;
-		if (of_address_to_resource(node, txx9_scc_tab[i].index, &res))
-			continue;
-
-		memset(&req, 0, sizeof(req));
-		req.line = i;
-		req.iotype = UPIO_MEM;
-		req.mapbase = res.start + txx9_scc_tab[i].offset;
+	while ((node = of_find_compatible_node(node,
+				"serial", "toshiba,sio-scc")) != NULL) {
+		for (i = 0; i < ARRAY_SIZE(txx9_scc_tab); i++) {
+			if (!(txx9_serial_bitmap & (1<<i)))
+				continue;
+
+			if (of_irq_map_one(node, i, &irq))
+				continue;
+			if (of_address_to_resource(node,
+				txx9_scc_tab[i].index, &res))
+				continue;
+
+			memset(&req, 0, sizeof(req));
+			req.line = i;
+			req.iotype = UPIO_MEM;
+			req.mapbase = res.start + txx9_scc_tab[i].offset;
 #ifdef CONFIG_SERIAL_TXX9_CONSOLE
-		req.membase = ioremap(req.mapbase, 0x24);
+			req.membase = ioremap(req.mapbase, 0x24);
 #endif
-		req.irq = irq_create_of_mapping(irq.controller,
-			irq.specifier, irq.size);
-		req.flags |= UPF_IOREMAP | UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
-		req.uartclk = 83300000;
-		early_serial_txx9_setup(&req);
+			req.irq = irq_create_of_mapping(irq.controller,
+				irq.specifier, irq.size);
+			req.flags |= UPF_IOREMAP | UPF_BUGGY_UART
+				/*HAVE_CTS_LINE*/;
+			req.uartclk = 83300000;
+			early_serial_txx9_setup(&req);
+		}
 	}
 
-	of_node_put(node);
 	return 0;
 }
 
