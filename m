Return-Path: <galak@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id CDAE267F91
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Aug 2005 13:41:41 +1000 (EST)
Date: Mon, 8 Aug 2005 22:41:17 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0508082240430.5117@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] cpm_uart: needs some love to compile with GCC4.0.1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fixed problems so we can build with gcc-4.0.1

Signed-off-by: Peter Schaefer-Hutter <peter.schaefer-hutter@tfk-racoms.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit dcc63579f883d388c5b4f69c4adc82423cab1de2
tree f856b999bdc0182e6299ec0000d4432380af0ac0
parent 1de80554bcae877dce3b6d878053eb092ef65c72
author Kumar K. Gala <kumar.gala@freescale.com> Mon, 08 Aug 2005 22:38:28 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Mon, 08 Aug 2005 22:38:28 -0500

 drivers/serial/cpm_uart/cpm_uart_core.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -1134,14 +1134,14 @@ static int __init cpm_uart_console_setup
 	return 0;
 }
 
-extern struct uart_driver cpm_reg;
+static struct uart_driver cpm_reg;
 static struct console cpm_scc_uart_console = {
-	.name		"ttyCPM",
-	.write		cpm_uart_console_write,
-	.device		uart_console_device,
-	.setup		cpm_uart_console_setup,
-	.flags		CON_PRINTBUFFER,
-	.index		-1,
+	.name		= "ttyCPM",
+	.write		= cpm_uart_console_write,
+	.device		= uart_console_device,
+	.setup		= cpm_uart_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
 	.data		= &cpm_reg,
 };
 
