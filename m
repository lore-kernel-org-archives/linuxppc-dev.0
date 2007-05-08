Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BA7A6DDE11
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 03:19:32 +1000 (EST)
Date: Tue, 8 May 2007 12:19:21 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] cpm_uart: cpm_uart_set_termios should take ktermios,
	not termios
Message-ID: <20070508171921.GA8941@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This eliminates some warnings.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 drivers/serial/cpm_uart/cpm_uart_core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index 7a3b97f..6823b8b 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -482,7 +482,8 @@ static void cpm_uart_shutdown(struct uart_port *port)
 }
 
 static void cpm_uart_set_termios(struct uart_port *port,
-				 struct termios *termios, struct termios *old)
+                                 struct ktermios *termios,
+                                 struct ktermios *old)
 {
 	int baud;
 	unsigned long flags;
-- 
1.5.0.3
