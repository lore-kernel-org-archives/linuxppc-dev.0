Return-Path: <SRS0+5a975b97460a6157554b+1319+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 36CC1DDFDD
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 10:02:23 +1000 (EST)
Subject: [PATCH v2] Stop pmac_zilog from abusing 8250's device numbers.
From: David Woodhouse <dwmw2@infradead.org>
To: Brad Boyer <flar@allandria.com>
In-Reply-To: <20070403212928.GA12951@cynthia.pants.nu>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<1175642916.10567.24.camel@shinybook.infradead.org>
	<20070403212928.GA12951@cynthia.pants.nu>
Content-Type: text/plain
Date: Tue, 03 Apr 2007 20:01:35 -0400
Message-Id: <1175644895.10567.34.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are proper device numbers registered for pmac_zilog now. Use them,
and change the name of the device to 'ttyPZ%d'. This allows the
pmac_zilog and 8250 drivers to co-exist in the kernel.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/drivers/serial/pmac_zilog.c b/drivers/serial/pmac_zilog.c
index 752ef07..2ab23af 100644
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
 
 
@@ -1776,7 +1777,7 @@ static void pmz_console_write(struct console *con, const char *s, unsigned int c
 static int __init pmz_console_setup(struct console *co, char *options);
 
 static struct console pmz_console = {
-	.name	=	"ttyS",
+	.name	=	"ttyPZ",
 	.write	=	pmz_console_write,
 	.device	=	uart_console_device,
 	.setup	=	pmz_console_setup,
@@ -1800,7 +1801,6 @@ static int __init pmz_register(void)
 	
 	pmz_uart_reg.nr = pmz_ports_count;
 	pmz_uart_reg.cons = PMACZILOG_CONSOLE;
-	pmz_uart_reg.minor = 64;
 
 	/*
 	 * Register this driver with the serial core

-- 
dwmw2
