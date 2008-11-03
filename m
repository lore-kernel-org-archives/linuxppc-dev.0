Return-Path: <r.buergel@unicontrol.de>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.161])
	by ozlabs.org (Postfix) with ESMTP id 789DFDDDEA
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Nov 2008 20:36:23 +1100 (EST)
Message-ID: <490EC5EF.50609@unicontrol.de>
Date: Mon, 03 Nov 2008 10:35:43 +0100
From: =?ISO-8859-1?Q?Ren=E9_B=FCrgel?= <r.buergel@unicontrol.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] mpc52xx_uart: report serial errors to users v2
References: <490950AF.1000303@unicontrol.de>
	<fa686aa40810300819w265c375euff3f46d7bb0a9176@mail.gmail.com>
In-Reply-To: <fa686aa40810300819w265c375euff3f46d7bb0a9176@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------050607070203060600000806"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050607070203060600000806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

I regenerated the patch with respect to your comments.

Grant Likely wrote:
> On Thu, Oct 30, 2008 at 12:14 AM, René Bürgel <r.buergel@unicontrol.de> wrote:
>   
>> Hi! This patch adds the capability to the mpc52xx-uart to report framing
>> errors, parity errors, breaks and overruns to userspace. These values may be
>> requested in userspace by using the ioctl TIOCGICOUNT.
>>
>> Signed-off-by: René Bürgel <r.buergel@unicontrol.de>
>>     
>
> Looks mostly good.  A few comments below.  Make sure you CC: me when
> you send the next version (which goes for all 5xxx patches).
>
> g.
>   
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
 
Unicontrol Systemtechnik GmbH
Geschäftsführer: Dipl.-Ing. Siegfried Heinze
Sitz der Gesellschaft: Frankenberg
Registergericht: Amtsgericht Chemnitz, HRB 15 475


--------------050607070203060600000806
Content-Type: text/plain;
 name="121-mpc52xx_serial_icounter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="121-mpc52xx_serial_icounter.patch"

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 6117d3d..2669aec 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -752,10 +752,15 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 			if (status & MPC52xx_PSC_SR_RB) {
 				flag = TTY_BREAK;
 				uart_handle_break(port);
-			} else if (status & MPC52xx_PSC_SR_PE)
+				port->icount.brk++;
+			} else if (status & MPC52xx_PSC_SR_PE) {
 				flag = TTY_PARITY;
-			else if (status & MPC52xx_PSC_SR_FE)
+				port->icount.parity++;
+			}
+			else if (status & MPC52xx_PSC_SR_FE) {
 				flag = TTY_FRAME;
+				port->icount.frame++;
+			}
 
 			/* Clear error condition */
 			out_8(&PSC(port)->command, MPC52xx_PSC_RST_ERR_STAT);
@@ -769,6 +774,7 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 			 * affect the current character
 			 */
 			tty_insert_flip_char(tty, 0, TTY_OVERRUN);
+			port->icount.overrun++;
 		}
 	}
 

--------------050607070203060600000806--
