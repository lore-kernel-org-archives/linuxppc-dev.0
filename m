Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 526DDDDE24
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 18:42:23 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC] cpm_uart: Add generic clock API support to set baudrates
Date: Mon, 28 Jul 2008 10:42:16 +0200
References: <200807241405.21770.laurentp@cse-semaphore.com>
	<01409579-8A92-4A16-9C66-7C751BB348E7@kernel.crashing.org>
In-Reply-To: <01409579-8A92-4A16-9C66-7C751BB348E7@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807281042.16872.laurentp@cse-semaphore.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch introduces baudrate setting support via the generic clock API.
When present the optional device tree clock property is used instead of
fsl-cpm-brg. Platforms can then define complex clock schemes, to output
the serial clock on an external pin for instance.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
---
 drivers/serial/cpm_uart/cpm_uart.h      |    1 +
 drivers/serial/cpm_uart/cpm_uart_core.c |   26 +++++++++++++++++++-------
 2 files changed, 20 insertions(+), 7 deletions(-)

On Friday 25 July 2008, Kumar Gala wrote:
> I'm having problems applying due to mailer formatting.

*sigh* I'll definitely have to fix GPG support in kmail. Sorry about the
annoyance.

diff --git a/drivers/serial/cpm_uart/cpm_uart.h b/drivers/serial/cpm_uart/cpm_uart.h
index d0c55e2..2e64c03 100644
--- a/drivers/serial/cpm_uart/cpm_uart.h
+++ b/drivers/serial/cpm_uart/cpm_uart.h
@@ -77,6 +77,7 @@ struct uart_cpm_port {
 	unsigned char		*rx_buf;
 	u32			flags;
 	void			(*set_lineif)(struct uart_cpm_port *);
+	struct clk		*clk;
 	u8			brg;
 	uint			 dp_addr;
 	void 			*mem_addr;
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index d3c19e5..438e460 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -44,6 +44,7 @@
 #include <linux/fs_uart_pd.h>
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
+#include <linux/clk.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -641,7 +642,10 @@ static void cpm_uart_set_termios(struct uart_port *port,
 		out_be16(&sccp->scc_psmr, (sbits << 12) | scval);
 	}
 
-	cpm_set_brg(pinfo->brg - 1, baud);
+	if (pinfo->clk)
+		clk_set_rate(pinfo->clk, baud);
+	else
+		cpm_set_brg(pinfo->brg - 1, baud);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -991,13 +995,21 @@ static int cpm_uart_init_port(struct device_node *np,
 	int ret;
 	int i;
 
-	data = of_get_property(np, "fsl,cpm-brg", &len);
-	if (!data || len != 4) {
-		printk(KERN_ERR "CPM UART %s has no/invalid "
-		                "fsl,cpm-brg property.\n", np->name);
-		return -EINVAL;
+	data = of_get_property(np, "clock", NULL);
+	if (data) {
+		struct clk *clk = clk_get(NULL, (const char*)data);
+		if (!IS_ERR(clk))
+			pinfo->clk = clk;
+	}
+	if (!pinfo->clk) {
+		data = of_get_property(np, "fsl,cpm-brg", &len);
+		if (!data || len != 4) {
+			printk(KERN_ERR "CPM UART %s has no/invalid "
+			                "fsl,cpm-brg property.\n", np->name);
+			return -EINVAL;
+		}
+		pinfo->brg = *data;
 	}
-	pinfo->brg = *data;
 
 	data = of_get_property(np, "fsl,cpm-command", &len);
 	if (!data || len != 4) {
-- 
1.5.0


-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75
