Return-Path: <anton@samba.org>
Date: Mon, 1 Aug 2011 15:30:04 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Lack! of! ibm,io-events! not! that! important!
Message-ID: <20110801153004.0e8af5df@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The ibm,io-events code is a bit verbose with its error messages.
Reverse the reporting so we only print when we successfully enable
I/O event interrupts.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/platforms/pseries/io_event_irq.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/platforms/pseries/io_event_irq.c	2011-07-26 08:50:11.291231586 +1000
+++ linux-powerpc/arch/powerpc/platforms/pseries/io_event_irq.c	2011-07-26 08:51:39.992772071 +1000
@@ -212,17 +212,15 @@ static int __init ioei_init(void)
 	struct device_node *np;
 
 	ioei_check_exception_token = rtas_token("check-exception");
-	if (ioei_check_exception_token == RTAS_UNKNOWN_SERVICE) {
-		pr_warning("IO Event IRQ not supported on this system !\n");
+	if (ioei_check_exception_token == RTAS_UNKNOWN_SERVICE)
 		return -ENODEV;
-	}
+
 	np = of_find_node_by_path("/event-sources/ibm,io-events");
 	if (np) {
 		request_event_sources_irqs(np, ioei_interrupt, "IO_EVENT");
+		pr_info("IBM I/O event interrupts enabled\n");
 		of_node_put(np);
 	} else {
-		pr_err("io_event_irq: No ibm,io-events on system! "
-		       "IO Event interrupt disabled.\n");
 		return -ENODEV;
 	}
 	return 0;
