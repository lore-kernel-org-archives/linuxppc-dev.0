Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9206E100816
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2011 10:42:40 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: alan@linux.intel.com, gregkh@suse.de, scottwood@freescale.com,
 galak@kernel.crashing.org
Subject: [PATCH 4/6] serial: make 8250 timeout use the specified IRQ handler
Date: Sun,  4 Dec 2011 18:42:21 -0500
Message-Id: <1323042143-25330-5-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1323042143-25330-1-git-send-email-paul.gortmaker@windriver.com>
References: <1322783258-20443-1-git-send-email-paul.gortmaker@windriver.com>
 <1323042143-25330-1-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current 8250 timeout code duplicates the code path in
serial8250_default_handle_irq and then serial8250_handle_irq
i.e. reading iir, check for IIR_NO_INT, and then calling
serial8250_handle_port.

So the immediate thought is to replace the duplicated code
with a call to serial8250_default_handle_irq.

But this highlights a problem.  We let 8250 driver variants
use their own IRQ handler via specifying their own custom
->handle_irq, but in the event of a timeout, we ignore their
handler and implicitly run serial8250_default_handle_irq instead.

So, go through the struct to get ->handle_irq and call that,
which for most will still be serial8250_default_handle_irq.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/8250.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index 91afe7a..9e7780d 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -1738,11 +1738,8 @@ static void serial_unlink_irq_chain(struct uart_8250_port *up)
 static void serial8250_timeout(unsigned long data)
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)data;
-	unsigned int iir;
 
-	iir = serial_in(up, UART_IIR);
-	if (!(iir & UART_IIR_NO_INT))
-		serial8250_handle_port(up);
+	up->port.handle_irq(&up->port);
 	mod_timer(&up->timer, jiffies + uart_poll_timeout(&up->port));
 }
 
-- 
1.7.7
