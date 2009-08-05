Return-Path: <julia@diku.dk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EC702B6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 23:25:22 +1000 (EST)
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8609EDDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 23:25:22 +1000 (EST)
Date: Wed, 5 Aug 2009 15:25:08 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 4/4] drivers/serial/mpc52xx_uart.c: Use UPIO_MEM rather than
	SERIAL_IO_MEM
Message-ID: <Pine.LNX.4.64.0908051524220.20453@pc-004.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

As in the commit 9b4a1617772d6d5ab5eeda0cd95302fae119e359, use UPIO_MEM
rather than SERIAL_IO_MEM.  Both have the same value.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@has_sc@
@@

#include <linux/serial_core.h>

@depends on has_sc@
@@

- SERIAL_IO_MEM
+ UPIO_MEM
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/serial/mpc52xx_uart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -705,7 +705,7 @@ mpc52xx_uart_verify_port(struct uart_por
 		return -EINVAL;
 
 	if ((ser->irq != port->irq) ||
-	    (ser->io_type != SERIAL_IO_MEM) ||
+	    (ser->io_type != UPIO_MEM) ||
 	    (ser->baud_base != port->uartclk)  ||
 	    (ser->iomem_base != (void *)port->mapbase) ||
 	    (ser->hub6 != 0))
