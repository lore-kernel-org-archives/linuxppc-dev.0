Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xVTnj5fklzDrGk
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Aug 2017 16:47:37 +1000 (AEST)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Timur Tabi <timur@tabi.org>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] serial: uuc_uart: constify uart_ops structures
Date: Sun, 13 Aug 2017 08:21:44 +0200
Message-Id: <1502605310-4314-6-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1502605310-4314-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1502605310-4314-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These uart_ops structures are only stored in the ops field of a
uart_port structure and this fields is const, so the uart_ops
structures can also be const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/tty/serial/ucc_uart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 481eb29..55b7027 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1085,7 +1085,7 @@ static int qe_uart_verify_port(struct uart_port *port,
  *
  * Details on these functions can be found in Documentation/serial/driver
  */
-static struct uart_ops qe_uart_pops = {
+static const struct uart_ops qe_uart_pops = {
 	.tx_empty       = qe_uart_tx_empty,
 	.set_mctrl      = qe_uart_set_mctrl,
 	.get_mctrl      = qe_uart_get_mctrl,
