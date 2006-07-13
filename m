Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx017.isp.belgacom.be (outmx017.isp.belgacom.be
	[195.238.4.116])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 297AA67B72
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jul 2006 00:53:36 +1000 (EST)
Received: from outmx017.isp.belgacom.be (localhost [127.0.0.1])
	by outmx017.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k6DErQaJ015010
	for <linuxppc-embedded@ozlabs.org>; Thu, 13 Jul 2006 16:53:27 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx017.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k6DErPVc014993
	for <linuxppc-embedded@ozlabs.org>; Thu, 13 Jul 2006 16:53:25 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: cpm_uart_port_map not initialised before serial console setup
Date: Thu, 13 Jul 2006 16:55:35 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_n7ltEFo+YdUowME"
Message-Id: <200607131655.35899.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_n7ltEFo+YdUowME
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everybody,

while trying to use SCC1 as a serial console, I found a bug in the cpm_uart 
driver.

The cpm_uart_port_map table is initialised by cpm_uart_count() which is called 
in cpm_uart_init() at module_init() time. cpm_uart_console_setup(), called at 
console_initcall() time, accesses cpm_uart_port_map, leading to a crash when 
using any serial port except SMC1 as the serial console.

I attached a very simple patch to fix the problem, but it might be subject to 
race conditions. Could anyone familiar with the cpm_uart driver have a look 
at it ?

Best regards,

Laurent Pinchart

--Boundary-00=_n7ltEFo+YdUowME
Content-Type: text/x-diff;
  charset="us-ascii";
  name="cpm_uart.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cpm_uart.patch"

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index a632897..a3c30f5 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -1240,6 +1240,7 @@ static struct console cpm_scc_uart_conso
 
 int __init cpm_uart_console_init(void)
 {
+	cpm_uart_count();
 	register_console(&cpm_scc_uart_console);
 	return 0;
 }

--Boundary-00=_n7ltEFo+YdUowME--
