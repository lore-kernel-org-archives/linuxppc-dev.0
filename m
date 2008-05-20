Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 585DBDE699
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 05:38:48 +1000 (EST)
Subject: [PATCH] Fix cpm uart corruption with PREEMPT_RT
To: <linuxppc-dev@ozlabs.org>
Message-Id: <20080520193917.C7ED15AF22@innovsys.com>
Date: Tue, 20 May 2008 14:39:17 -0500 (CDT)
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
Also only take lock if not in an oops.

Signed-off-by: Rune Torgersen <runet@innovsys.com>

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index fb93403..11bee62 100755
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -1214,6 +1214,14 @@ static void cpm_uart_console_write(struct console *co, const char *s,
 	unsigned int i;
 	cbd_t __iomem *bdp, *bdbase;
 	unsigned char *cp;
+	unsigned long flags;
+	int nolock = oops_in_progress;
+
+	if (unlikely(nolock)) {
+		local_irq_save(flags);
+	} else {
+		spin_lock_irqsave(&pinfo->port.lock, flags);
+	}
 
 	/* Get the address of the host memory buffer.
 	 */
@@ -1282,6 +1290,12 @@ static void cpm_uart_console_write(struct console *co, const char *s,
 		;
 
 	pinfo->tx_cur = bdp;
+
+	if (unlikely(nolock)) {
+		local_irq_restore(flags);
+	} else {
+		spin_unlock_irqrestore(&pinfo->port.lock, flags);
+	}
 }
 
 
