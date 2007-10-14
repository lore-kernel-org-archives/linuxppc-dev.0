Return-Path: <grant.likely@secretlab.ca>
Date: Sat, 13 Oct 2007 22:37:02 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/2] mpc52xx-uart: fix compile warning (format type mismatch)
In-reply-to: <20071014043657.23348.56519.stgit@trillian.cg.shawcable.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-id: <20071014043702.23348.7238.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071014043657.23348.56519.stgit@trillian.cg.shawcable.net>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Trivial compile warning fix

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/serial/mpc52xx_uart.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 035cca0..ec36ad7 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -756,8 +756,8 @@ mpc52xx_console_setup(struct console *co, char *options)
 	if (port->membase == NULL)
 		return -EINVAL;
 
-	pr_debug("mpc52xx-psc uart at %lx, mapped to %p, irq=%x, freq=%i\n",
-	         port->mapbase, port->membase, port->irq, port->uartclk);
+	pr_debug("mpc52xx-psc uart at %p, mapped to %p, irq=%x, freq=%i\n",
+	         (void*)port->mapbase, port->membase, port->irq, port->uartclk);
 
 	/* Setup the port parameters accoding to options */
 	if (options)
@@ -974,8 +974,8 @@ mpc52xx_uart_of_probe(struct of_device *op, const struct of_device_id *match)
 	port->mapbase = res.start;
 	port->irq = irq_of_parse_and_map(op->node, 0);
 
-	dev_dbg(&op->dev, "mpc52xx-psc uart at %lx, irq=%x, freq=%i\n",
-	        port->mapbase, port->irq, port->uartclk);
+	dev_dbg(&op->dev, "mpc52xx-psc uart at %p, irq=%x, freq=%i\n",
+	        (void*)port->mapbase, port->irq, port->uartclk);
 
 	if ((port->irq==NO_IRQ) || !port->mapbase) {
 		printk(KERN_ERR "Could not allocate resources for PSC\n");
