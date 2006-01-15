Return-Path: <vbordug@ru.mvista.com>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9D0F368A4F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Jan 2006 02:44:25 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH] PPC32 CPM_UART: update to utilize the new TTY flip API
Date: Sun, 15 Jan 2006 18:44:09 +0300
Message-Id: <20060115154409.1627.95041.stgit@vitb.dev.rtsoft.ru>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This replaces old direct usage of tty->flip stuff with relative flip API
calls.
---

 drivers/serial/cpm_uart/cpm_uart_core.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index 16af562..5e25c2d 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -252,12 +252,9 @@ static void cpm_uart_int_rx(struct uart_
 		/* If we have not enough room in tty flip buffer, then we try
 		 * later, which will be the next rx-interrupt or a timeout
 		 */
-		if ((tty->flip.count + i) >= TTY_FLIPBUF_SIZE) {
-			tty->flip.work.func((void *)tty);
-			if ((tty->flip.count + i) >= TTY_FLIPBUF_SIZE) {
-				printk(KERN_WARNING "TTY_DONT_FLIP set\n");
-				return;
-			}
+		if(tty_buffer_request_room(tty, i) < i) {
+			printk(KERN_WARNING "No room in flip buffer\n");
+			return;
 		}
 
 		/* get pointer */
@@ -276,9 +273,7 @@ static void cpm_uart_int_rx(struct uart_
 				continue;
 
 		      error_return:
-			*tty->flip.char_buf_ptr++ = ch;
-			*tty->flip.flag_buf_ptr++ = flg;
-			tty->flip.count++;
+			tty_insert_flip_char(tty, ch, flg);
 
 		}		/* End while (i--) */
 
