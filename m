Return-Path: <greg.weeks@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id AE1A767A6B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 03:44:37 +1100 (EST)
Message-ID: <42386274.2020504@timesys.com>
Date: Wed, 16 Mar 2005 11:44:36 -0500
From: Greg Weeks <greg.weeks@timesys.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: multipart/mixed; boundary="------------070305080305030605010102"
Subject: [patch] fix unitilized spinlock in cpm driver when used as console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070305080305030605010102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix unitilized spinlock in the cpm scc driver when used as console.

Signed-off-by: Greg Weeks <greg.weeks@timesys.com>



--------------070305080305030605010102
Content-Type: text/x-patch;
 name="cpm.console.spinlock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpm.console.spinlock.patch"

--- all/drivers/serial/cpm_uart/cpm_uart_core.c-orig
+++ all/drivers/serial/cpm_uart/cpm_uart_core.c

@@ -1038,6 +1038,7 @@
 
 	port =
 	    (struct uart_port *)&cpm_uart_ports[cpm_uart_port_map[co->index]];
+	spin_lock_init(&(port->lock));
 	pinfo = (struct uart_cpm_port *)port;
 	
 	pinfo->flags |= FLAG_CONSOLE;

--------------070305080305030605010102--
