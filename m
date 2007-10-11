Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 970CBDE0B9
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 05:10:39 +1000 (EST)
Date: Thu, 11 Oct 2007 23:09:25 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC: Add legacy serial support for OPB with flattened
	device tree.
Message-ID: <20071011190925.GA22704@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200710111909.39927.arnd@arndb.de>
Cc: arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently find_legacy_serial_ports() can find no serial ports on the OPB
with flattened device. Thus no legacy boot console can be initialized.
Just the early udbg console works, which is initialized with udbg_init_44x_as1
on the UART's physical address specified in kernel config. This happens
because we look for ns16750 serial devices only and expect opb node to have
a device type property. This patch makes it look for ns16550-compatible
devices and use of_device_is_compatible() for opb in case device type is not
specified.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/kernel/legacy_serial.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -pruN linux-2.6.orig/arch/powerpc/kernel/legacy_serial.c linux-2.6/arch/powerpc/kernel/legacy_serial.c
--- linux-2.6.orig/arch/powerpc/kernel/legacy_serial.c	2007-10-11 17:12:09.000000000 +0400
+++ linux-2.6/arch/powerpc/kernel/legacy_serial.c	2007-10-11 23:01:25.000000000 +0400
@@ -340,9 +340,10 @@ void __init find_legacy_serial_ports(voi
 	}
 
 	/* First fill our array with opb bus ports */
-	for (np = NULL; (np = of_find_compatible_node(np, "serial", "ns16750")) != NULL;) {
+	for (np = NULL; (np = of_find_compatible_node(np, "serial", "ns16550")) != NULL;) {
 		struct device_node *opb = of_get_parent(np);
-		if (opb && !strcmp(opb->type, "opb")) {
+		if (opb && (!strcmp(opb->type, "opb") ||
+			    of_device_is_compatible(opb, "ibm,opb"))) {
 			index = add_legacy_soc_port(np, np);
 			if (index >= 0 && np == stdout)
 				legacy_serial_console = index;
