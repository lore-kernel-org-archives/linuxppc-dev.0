Return-Path: <tnt@246tNt.com>
Received: from outmx023.isp.belgacom.be (outmx023.isp.belgacom.be
	[195.238.4.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A6808DDE41
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 09:18:57 +1100 (EST)
Received: from outmx023.isp.belgacom.be (localhost [127.0.0.1])
	by outmx023.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1FMIrwV028996
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 23:18:53 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45D4DC20.9070506@246tNt.com>
Date: Thu, 15 Feb 2007 23:18:08 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>, Linux PPC dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/serial: Dispose irq mapping when done in
	mpc52xx_serial.c
References: <11713184081457-git-send-email-tnt@246tNt.com>
In-Reply-To: <11713184081457-git-send-email-tnt@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1
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
Hi Paulus,

This is a 'fixed' version of the uart patch. The test on port->irq != NO_IRQ is
removed. But I added a check for port because it might be NULL ...

	Sylvain
---
 drivers/serial/mpc52xx_uart.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 955bbd6..8d24cd5 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -995,8 +995,10 @@ mpc52xx_uart_of_remove(struct of_device 
 	struct uart_port *port = dev_get_drvdata(&op->dev);
 	dev_set_drvdata(&op->dev, NULL);
 
-	if (port)
+	if (port) {
 		uart_remove_one_port(&mpc52xx_uart_driver, port);
+		irq_dispose_mapping(port->irq);
+	}
 
 	return 0;
 }

-- 
1.4.2
