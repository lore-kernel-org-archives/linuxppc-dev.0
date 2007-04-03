Return-Path: <SRS0+3550a31010a0b33b2856+1318+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CE0E5DDE30
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 00:26:28 +1000 (EST)
Subject: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: David Woodhouse <dwmw2@infradead.org>
To: paulus@samba.org
Content-Type: text/plain
Date: Tue, 03 Apr 2007 10:25:45 -0400
Message-Id: <1175610345.2665.15.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are proper device numbers registered for pmac_zilog now. Use them.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/drivers/serial/pmac_zilog.c b/drivers/serial/pmac_zilog.c
index 752ef07..579266d 100644
--- a/drivers/serial/pmac_zilog.c
+++ b/drivers/serial/pmac_zilog.c
@@ -99,9 +99,10 @@ static DEFINE_MUTEX(pmz_irq_mutex);
 
 static struct uart_driver pmz_uart_reg = {
 	.owner		=	THIS_MODULE,
-	.driver_name	=	"ttyS",
-	.dev_name	=	"ttyS",
-	.major		=	TTY_MAJOR,
+	.driver_name	=	"ttyPZ",
+	.dev_name	=	"ttyPZ",
+	.major		=	204,
+	.minor		=	192,
 };
 
 
@@ -1800,7 +1801,6 @@ static int __init pmz_register(void)
 	
 	pmz_uart_reg.nr = pmz_ports_count;
 	pmz_uart_reg.cons = PMACZILOG_CONSOLE;
-	pmz_uart_reg.minor = 64;
 
 	/*
 	 * Register this driver with the serial core

-- 
dwmw2
