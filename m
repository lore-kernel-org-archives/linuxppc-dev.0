Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id DF843DE0E1
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 05:27:47 +1000 (EST)
Subject: [PATCH] Fix cpm uart corruption with PREEMPT_RT
To: <linuxppc-dev@ozlabs.org>
Message-Id: <20080520192816.7F7E15AF22@innovsys.com>
Date: Tue, 20 May 2008 14:28:16 -0500 (CDT)
From: runet@innovsys.com (Rune Torgersen)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix CPM serial port corruption when running with CONFIG_PREEMPT_RT.
Userland usage of console, and kernel printf's were stepping on each others toes.

Signed-off-by: Rune Torgersen <runet@innovsys.com>

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index fb93403..79c109d 100755
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -1214,7 +1214,9 @@ static void cpm_uart_console_write(struct console *co, const char *s,
 	unsigned int i;
 	cbd_t __iomem *bdp, *bdbase;
 	unsigned char *cp;
+	unsigned long flags;
 
+	spin_lock_irqsave(&pinfo->port.lock, flags);
 	/* Get the address of the host memory buffer.
 	 */
 	bdp = pinfo->tx_cur;
@@ -1282,6 +1284,8 @@ static void cpm_uart_console_write(struct console *co, const char *s,
 		;
 
 	pinfo->tx_cur = bdp;
+
+	spin_unlock_irqrestore(&pinfo->port.lock, flags);
 }
 
 
