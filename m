Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id AB8F168099
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 01:37:54 +1000 (EST)
Message-ID: <42FB70D0.3000004@ru.mvista.com>
Date: Thu, 11 Aug 2005 19:37:52 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@freescale.com>
Content-Type: multipart/mixed; boundary="------------040607090600040909070709"
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] cpm_uart: added missed spinlock initialization
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040607090600040909070709
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

The lack of spin_lock_init causes badness in the preempt configuration.
The fix is trivial.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

-- 
Sincerely,
Vitaly

--------------040607090600040909070709
Content-Type: text/x-patch;
 name="cpm_uart_spinlock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpm_uart_spinlock.patch"

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -1045,6 +1045,7 @@ static int __init cpm_uart_console_setup
 	port =
 	    (struct uart_port *)&cpm_uart_ports[cpm_uart_port_map[co->index]];
 	pinfo = (struct uart_cpm_port *)port;
+	spin_lock_init(&port->lock);
 	
 	pinfo->flags |= FLAG_CONSOLE;
 

--------------040607090600040909070709--
