Return-Path: <tnt@246tNt.com>
Received: from outmx006.isp.belgacom.be (outmx006.isp.belgacom.be
	[195.238.4.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C1842DDDE5
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 09:14:19 +1100 (EST)
Received: from outmx006.isp.belgacom.be (localhost [127.0.0.1])
	by outmx006.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1CMECPJ013395
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 23:14:13 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 01/10] powerpc/serial: Dispose irq mapping when done in
	mpc52xx_serial.c
Date: Mon, 12 Feb 2007 23:13:19 +0100
Message-Id: <11713184091057-git-send-email-tnt@246tNt.com>
In-Reply-To: <11713184081457-git-send-email-tnt@246tNt.com>
References: <11713184081457-git-send-email-tnt@246tNt.com>
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/serial/mpc52xx_uart.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 6999816..ee4ebaf 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -999,6 +999,9 @@ mpc52xx_uart_of_remove(struct of_device 
 	if (port)
 		uart_remove_one_port(&mpc52xx_uart_driver, port);
 
+	if (port->irq != NO_IRQ)
+		irq_dispose_mapping(port->irq);
+
 	return 0;
 }
 
-- 
1.4.2
