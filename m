Return-Path: <tnt@246tNt.com>
Received: from outmx020.isp.belgacom.be (outmx020.isp.belgacom.be
	[195.238.4.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5C379DDF12
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 09:32:07 +1100 (EST)
Received: from outmx020.isp.belgacom.be (localhost [127.0.0.1])
	by outmx020.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l02MVuGr002695
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Jan 2007 23:31:56 +0100
	(envelope-from <tnt@246tNt.com>)
From: Sylvain Munaut <tnt@246tNt.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/4] powerpc/serial: Dispose irq mapping when done in
	mpc52xx_serial.c
Date: Tue,  2 Jan 2007 23:29:52 +0100
Message-Id: <116777699771-git-send-email-tnt@246tNt.com>
In-Reply-To: <1167776995690-git-send-email-tnt@246tNt.com>
References: <1167776995690-git-send-email-tnt@246tNt.com>
Cc: Linux PPC DEV <linuxppc-dev@ozlabs.org>, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 drivers/serial/mpc52xx_uart.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 9d11a75..eef3b02 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -997,6 +997,9 @@ mpc52xx_uart_of_remove(struct of_device 
 	if (port)
 		uart_remove_one_port(&mpc52xx_uart_driver, port);
 
+	if (port->irq != NO_IRQ)
+		irq_dispose_mapping(port->irq);
+
 	return 0;
 }
 
-- 
1.4.2
