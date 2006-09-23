Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 761FF67B83
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 10:39:54 +1000 (EST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat
	Linux)) id 1GQvYX-0002iX-IN
	for linuxppc-dev@ozlabs.org; Sat, 23 Sep 2006 01:39:45 +0100
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] UPIO_TSI cleanup
Message-Id: <E1GQvYX-0002iX-IN@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Sat, 23 Sep 2006 01:39:45 +0100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


(le32_to_cpu(x) >> 8) & 0xff is a very odd way to spell (x >> 16) & 0xff,
even if that code is hit only on ppc.  The value is host-endian - we've
got it from readl(), after all...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/serial/8250.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 0ae9ced..10c2daa 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -320,8 +320,8 @@ #endif
 
 	case UPIO_TSI:
 		if (offset == UART_IIR) {
-			tmp = readl((u32 *)(up->port.membase + UART_RX));
-			return (cpu_to_le32(tmp) >> 8) & 0xff;
+			tmp = readl(up->port.membase + (UART_IIR & ~3));
+			return (tmp >> 16) & 0xff; /* UART_IIR % 4 == 2 */
 		} else
 			return readb(up->port.membase + offset);
 
-- 
1.4.2.GIT
