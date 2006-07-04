Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 183CF67B7F
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jul 2006 14:11:30 +1000 (EST)
Subject: [PATCH] powerpc: Fix default clock for udbg_16550
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 14:11:23 +1000
Message-Id: <1151986283.13828.38.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes it possible to provide 0 as the clock value for
udbg_16550, making it default to the standard 1.8432Mhz clock

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-irq-work/arch/powerpc/kernel/udbg_16550.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/kernel/udbg_16550.c	2006-07-04 13:01:13.000000000 +1000
+++ linux-irq-work/arch/powerpc/kernel/udbg_16550.c	2006-07-04 13:05:59.000000000 +1000
@@ -81,10 +81,14 @@
 void udbg_init_uart(void __iomem *comport, unsigned int speed,
 		    unsigned int clock)
 {
-	unsigned int dll, base_bauds = clock / 16;
+	unsigned int dll, base_bauds;
 
+	if (clock == 0)
+		clock = 1843200;
 	if (speed == 0)
 		speed = 9600;
+
+	base_bauds = clock / 16;
 	dll = base_bauds / speed;
 
 	if (comport) {
