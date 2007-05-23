Return-Path: <jrigby@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 76243DDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 May 2007 03:32:00 +1000 (EST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] Fix mpc52xx_uart_of_assign to use correct index
Date: Wed, 23 May 2007 11:30:55 -0600
Message-Id: <1179941455907-git-send-email-jrigby@freescale.com>
Cc: Sylvain Munaut <tnt@246tNt.com>, John Rigby <jrigby@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Use idx as index into mpc52xx_uart_nodes instead of i

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 drivers/serial/mpc52xx_uart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 3cc2fb9..0648017 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -1114,7 +1114,7 @@ mpc52xx_uart_of_assign(struct device_node *np, int idx)
 	/* If the slot is already occupied, then swap slots */
 	if (mpc52xx_uart_nodes[idx] && (free_idx != -1))
 		mpc52xx_uart_nodes[free_idx] = mpc52xx_uart_nodes[idx];
-	mpc52xx_uart_nodes[i] = np;
+	mpc52xx_uart_nodes[idx] = np;
 }
 
 static void
-- 
1.5.1.1.174.gabbf5
