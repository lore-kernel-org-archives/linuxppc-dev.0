Return-Path: <r.buergel@unicontrol.de>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.161])
	by ozlabs.org (Postfix) with ESMTP id 79025DDDE7
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 17:24:15 +1100 (EST)
Received: from obelix.unicontrol.de
	(pd907c61f.dip0.t-ipconnect.de [217.7.198.31])
	by post.webmailer.de (fruni mo58) (RZmta 17.14)
	with ESMTP id p002a7k9U0Tt3U for <linuxppc-dev@ozlabs.org>;
	Thu, 30 Oct 2008 07:24:13 +0100 (MET)
	(envelope-from: <r.buergel@unicontrol.de>)
Received: from localhost (localhost [127.0.0.1])
	by obelix.unicontrol.de (Postfix on SuSE Linux 8.1 (i386)) with ESMTP
	id 3C08617DFC
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 07:22:50 +0100 (CET)
Received: from [192.168.1.55] (arkturus.unicontrol.de [192.168.1.55])
	by obelix.unicontrol.de (Postfix on SuSE Linux 8.1 (i386)) with ESMTP
	id 5618B17DFB
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 07:22:46 +0100 (CET)
Message-ID: <490950AF.1000303@unicontrol.de>
Date: Thu, 30 Oct 2008 07:14:07 +0100
From: =?ISO-8859-15?Q?Ren=E9_B=FCrgel?= <r.buergel@unicontrol.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] mpc52xx_uart: report serial errors to users
Content-Type: multipart/mixed; boundary="------------010201030106060407010806"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010201030106060407010806
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi! This patch adds the capability to the mpc52xx-uart to report framing 
errors, parity errors, breaks and overruns to userspace. These values 
may be requested in userspace by using the ioctl TIOCGICOUNT.

Signed-off-by: René Bürgel <r.buergel@unicontrol.de>

Kind regards, René Bürgel

-- 
René Bürgel
Software Engineer
Unicontrol Systemtechnik GmbH
OT Dittersbach
Sachsenburger Weg 34
09669 Frankenberg
 
Tel.: 03 72 06/ 88 73 - 19
Fax: 03 72 06/ 88 73 - 60
E-Mail: r.buergel@unicontrol.de
Internet: www.unicontrol.de



--------------010201030106060407010806
Content-Type: text/plain;
 name="121-mpc52xx_serial_icounter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="121-mpc52xx_serial_icounter.patch"

--- drivers/serial/mpc52xx_uart.c	2008-08-07 15:55:43.000000000 +0200
+++ drivers/serial/mpc52xx_uart_orig.c	2008-09-11 13:19:12.000000000 +0200
@@ -752,10 +752,17 @@
 			if (status & MPC52xx_PSC_SR_RB) {
 				flag = TTY_BREAK;
 				uart_handle_break(port);
+				port->icount.brk++;
 			} else if (status & MPC52xx_PSC_SR_PE)
+			{
 				flag = TTY_PARITY;
+				port->icount.parity++;
+			}
 			else if (status & MPC52xx_PSC_SR_FE)
+			{
 				flag = TTY_FRAME;
+				port->icount.frame++;
+			}
 
 			/* Clear error condition */
 			out_8(&PSC(port)->command, MPC52xx_PSC_RST_ERR_STAT);
@@ -769,6 +776,7 @@
 			 * affect the current character
 			 */
 			tty_insert_flip_char(tty, 0, TTY_OVERRUN);
+			port->icount.overrun++;
 		}
 	}
 

--------------010201030106060407010806--
