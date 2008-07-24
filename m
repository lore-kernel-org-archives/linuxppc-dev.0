Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 00E1CDE15F
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 02:36:40 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCHv2] cpm_uart: Modem control lines support
Date: Thu, 24 Jul 2008 18:36:37 +0200
References: <200804161110.21778.laurentp@cse-semaphore.com>
	<200807241705.03340.laurentp@cse-semaphore.com>
	<2F3F000A-AC69-4C15-A535-F93B60BA191E@kernel.crashing.org>
In-Reply-To: <2F3F000A-AC69-4C15-A535-F93B60BA191E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807241836.37913.laurentp@cse-semaphore.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch replaces the get_mctrl/set_mctrl stubs with modem control line
read/write access through the GPIO lib.

Available modem control lines are described in the device tree using GPIO
bindings. The driver expect a GPIO pin for each of the CTS, RTS, DCD, DSR,
DTR and RI signals. Unused control lines can be left out.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
---
 Documentation/powerpc/booting-without-of.txt |   10 ++++++
 drivers/serial/cpm_uart/cpm_uart.h           |   10 ++++++
 drivers/serial/cpm_uart/cpm_uart_core.c      |   40 ++++++++++++++++++++++++--
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/cpm_qe/serial.txt b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/serial.txt
index 1d2a772..21a3484 100644
--- a/Documentation/powerpc/dts-bindings/fsl/cpm_qe/serial.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/cpm_qe/serial.txt
@@ -7,6 +7,15 @@
 - fsl,cpm2-scc-uart
 - fsl,qe-uart
 
+Modem control lines connected to GPIO controllers are listed in the gpios
+property as described in booting-without-of.txt, section IX.1 in the following
+order:
+
+CTS, RTS, DCD, DSR, DTR, and RI.
+
+The gpios property is optional and can be left out when control lines are
+not used.
+
 Example:
 
 	serial@11a00 {
@@ -18,4 +27,6 @@
 		interrupt-parent = <&PIC>;
 		fsl,cpm-brg = <1>;
 		fsl,cpm-command = <00800000>;
+		gpios = <&gpio_c 15 0
+			 &gpio_d 29 0>;
 	};
diff --git a/drivers/serial/cpm_uart/cpm_uart.h b/drivers/serial/cpm_uart/cpm_uart.h
index 0cc39f8..d0c55e2 100644
--- a/drivers/serial/cpm_uart/cpm_uart.h
+++ b/drivers/serial/cpm_uart/cpm_uart.h
@@ -50,6 +50,15 @@
 
 #define SCC_WAIT_CLOSING 100
 
+#define GPIO_CTS	0
+#define GPIO_RTS	1
+#define GPIO_DCD	2
+#define GPIO_DSR	3
+#define GPIO_DTR	4
+#define GPIO_RI		5
+
+#define NUM_GPIOS	(GPIO_RI+1)
+
 struct uart_cpm_port {
 	struct uart_port	port;
 	u16			rx_nrfifos;
@@ -82,6 +91,7 @@ struct uart_cpm_port {
 	int			wait_closing;
 	/* value to combine with opcode to form cpm command */
 	u32			command;
+	int			gpios[NUM_GPIOS];
 };
 
 extern int cpm_uart_nr;
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index d10a16e..d3c19e5 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -43,6 +43,8 @@
 #include <linux/dma-mapping.h>
 #include <linux/fs_uart_pd.h>
 #include <linux/of_platform.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -96,13 +98,41 @@ static unsigned int cpm_uart_tx_empty(struct uart_port *port)
 
 static void cpm_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	/* Whee. Do nothing. */
+	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
+
+	if (pinfo->gpios[GPIO_RTS] >= 0)
+		gpio_set_value(pinfo->gpios[GPIO_RTS], !(mctrl & TIOCM_RTS));
+
+	if (pinfo->gpios[GPIO_DTR] >= 0)
+		gpio_set_value(pinfo->gpios[GPIO_DTR], !(mctrl & TIOCM_DTR));
 }
 
 static unsigned int cpm_uart_get_mctrl(struct uart_port *port)
 {
-	/* Whee. Do nothing. */
-	return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
+	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
+	unsigned int mctrl = TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+
+	if (pinfo->gpios[GPIO_CTS] >= 0) {
+		if (gpio_get_value(pinfo->gpios[GPIO_CTS]))
+			mctrl &= ~TIOCM_CTS;
+	}
+
+	if (pinfo->gpios[GPIO_DSR] >= 0) {
+		if (gpio_get_value(pinfo->gpios[GPIO_DSR]))
+			mctrl &= ~TIOCM_DSR;
+	}
+
+	if (pinfo->gpios[GPIO_DCD] >= 0) {
+		if (gpio_get_value(pinfo->gpios[GPIO_DCD]))
+			mctrl &= ~TIOCM_CAR;
+	}
+
+	if (pinfo->gpios[GPIO_RI] >= 0) {
+		if (!gpio_get_value(pinfo->gpios[GPIO_RI]))
+			mctrl |= TIOCM_RNG;
+	}
+
+	return mctrl;
 }
 
 /*
@@ -893,6 +923,7 @@ static int cpm_uart_init_port(struct device_node *np,
 	void __iomem *mem, *pram;
 	int len;
 	int ret;
+	int i;
 
 	data = of_get_property(np, "fsl,cpm-brg", &len);
 	if (!data || len != 4) {
@@ -952,6 +983,9 @@ static int cpm_uart_init_port(struct device_node *np,
 		goto out_pram;
 	}
 
+	for (i = 0; i < NUM_GPIOS; i++)
+		pinfo->gpios[i] = of_get_gpio(np, i);
+
 	return cpm_uart_request_port(&pinfo->port);
 
 out_pram:
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
