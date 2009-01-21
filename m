Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 346DBDDEEC
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 07:55:34 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d14so241704and.39
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 12:55:32 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 5/8] powerpc/5200: Don't specify IRQF_SHARED in PSC UART driver
To: linuxppc-dev@ozlabs.org
Date: Wed, 21 Jan 2009 13:55:29 -0700
Message-ID: <20090121205529.31232.64801.stgit@localhost.localdomain>
In-Reply-To: <20090121205506.31232.27908.stgit@localhost.localdomain>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

The MPC5200 PSC device is wired up to a dedicated interrupt line
which is never shared.  This patch removes the IRQF_SHARED flag
from the request_irq() call which eliminates the "IRQF_DISABLED
is not guaranteed on shared IRQs" warning message from the console
output.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/serial/mpc52xx_uart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index d73d7da..7f72f8c 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -522,7 +522,7 @@ mpc52xx_uart_startup(struct uart_port *port)
 
 	/* Request IRQ */
 	ret = request_irq(port->irq, mpc52xx_uart_int,
-		IRQF_DISABLED | IRQF_SAMPLE_RANDOM | IRQF_SHARED,
+		IRQF_DISABLED | IRQF_SAMPLE_RANDOM,
 		"mpc52xx_psc_uart", port);
 	if (ret)
 		return ret;
