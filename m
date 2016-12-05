Return-Path: <alexander.stein@systec-electronic.com>
Received: from webbox1416.server-home.net (webbox1416.server-home.net
 [77.236.96.61])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tXTwl4tYPzDvyQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 02:59:51 +1100 (AEDT)
From: Alexander Stein <alexander.stein@systec-electronic.com>
To: Timur Tabi <timur@tabi.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
Subject: [PATCH 1/1] serial/uuc_uart: Set shutdown timeout to CONFIG_HZ
 independent 2ms
Date: Mon,  5 Dec 2016 16:50:58 +0100
Message-Id: <1480953058-4958-1-git-send-email-alexander.stein@systec-electronic.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

schedule_timeout takes a timeout in jiffies resolution. So pass 2ms
as a converted jiffies value. This makes the timeout independent of
CONFIG_HZ.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/tty/serial/ucc_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 481eb29..c6c01a4 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -827,7 +827,7 @@ static void qe_uart_shutdown(struct uart_port *port)
 			break;
 		}
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(2);
+		schedule_timeout(msecs_to_jiffies(2));
 	}
 
 	if (qe_port->wait_closing) {
-- 
2.7.3
