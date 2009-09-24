Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8648CB7B68
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 16:09:23 +1000 (EST)
Subject: [PATCH] Fix build of cpm_uart due to core changes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 24 Sep 2009 16:09:13 +1000
Message-Id: <1253772553.7103.402.camel@pasglop>
Mime-Version: 1.0
Cc: alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit ebd2c8f6d2ec4012c267ecb95e72a57b8355a705
"serial: kill off uart_info"

broke the build of this driver, possibly because the driver isn't
in drivers/serial and thus was missed by Alan. This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Vitaly: Care to send a patch to move the whole driver to drivers/serial where
it belongs or there's too many nasty dependencies to headers inside of
arch/powerpc/ ?

In the meantime, I'll put that in my merge branch which I'll ask Linus to
pull hopefully tomorrow (waiting for a test result from Rex to see if the
8xx problems are all gone)

Cheers,
Ben.

---
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index 8d349b2..300cea7 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -649,7 +649,7 @@ static int cpm_uart_tx_pump(struct uart_port *port)
 	u8 *p;
 	int count;
 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
-	struct circ_buf *xmit = &port->info->xmit;
+	struct circ_buf *xmit = &port->state->xmit;
 
 	/* Handle xon/xoff */
 	if (port->x_char) {
