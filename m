Return-Path: <Peter.Schaefer-Hutter@tfk-racoms.com>
Received: from rcprx1.tfk-racoms.com (rcprx1.tfk-racoms.com [195.245.55.49])
	by ozlabs.org (Postfix) with SMTP id 0197D67F52
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  8 Aug 2005 23:57:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 8 Aug 2005 15:57:37 +0200
Message-ID: <8E342283C2100540AAC5D10309705477749C5F@rcexc.racoms.loc>
From: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
To: "linuxppc-embedded list" <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] cpm_uart_core.c GCC4.x compilation fix
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

cpm_uart_core.c: needs some love to compile with GCC4.0.1.

Signed-off-by: Peter Schaefer-Hutter
<peter.schaefer-hutter@tfk-racoms.com>

--- a/drivers/serial/cpm_uart/cpm_uart_core.c	2005-08-08
15:49:16.725292392 +0200
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c	2005-08-08
15:33:47.691526992 +0200
@@ -1134,14 +1134,14 @@
 	return 0;
 }

-extern struct uart_driver cpm_reg;
+static struct uart_driver cpm_reg;
 static struct console cpm_scc_uart_console =3D {
-	.name		"ttyCPM",
-	.write		cpm_uart_console_write,
-	.device		uart_console_device,
-	.setup		cpm_uart_console_setup,
-	.flags		CON_PRINTBUFFER,
-	.index		-1,
+	.name		=3D "ttyCPM",
+	.write		=3D cpm_uart_console_write,
+	.device		=3D uart_console_device,
+	.setup		=3D cpm_uart_console_setup,
+	.flags		=3D CON_PRINTBUFFER,
+	.index		=3D -1,
 	.data		=3D &cpm_reg,
 };
=20
