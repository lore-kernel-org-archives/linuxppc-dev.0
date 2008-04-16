Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 83DBADDFC3
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 19:10:27 +1000 (EST)
Received: from smtp.belgium.cse-semaphore.com (localhost [127.0.0.1])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id B3D1EA856
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 11:10:24 +0200 (CEST)
Received: from pclaurent.belgium.cse-semaphore.com
	(pclaurent.belgium.cse-semaphore.com [192.168.1.47])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 99773A7E5
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 11:10:24 +0200 (CEST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linux-ppc list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Modem control lines support for the cpm_uart driver
Date: Wed, 16 Apr 2008 11:10:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200804161110.21778.laurentp@cse-semaphore.com>
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
bindings.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
---
 Documentation/powerpc/booting-without-of.txt |   10 ++++++
 drivers/serial/cpm_uart/cpm_uart.h           |   10 ++++++
 drivers/serial/cpm_uart/cpm_uart_core.c      |   40 ++++++++++++++++++++++++--
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 1e5572a..012f231 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1976,6 +1976,14 @@ platforms are moved over to use the flattened-device-tree model.
    - fsl,cpm2-scc-uart
    - fsl,qe-uart
 
+   Modem control lines connected to GPIO controllers are listed in the
+   gpios property as described in section VIII.1 in the following order:
+
+   CTS, RTS, DCD, DSR, DTR, and RI.
+
+   The gpios property is optional and can be left out when control lines are
+   not used.
+
    Example:
 
 	serial@11a00 {
@@ -1987,6 +1995,8 @@ platforms are moved over to use the flattened-device-tree model.
 		interrupt-parent = <&PIC>;
 		fsl,cpm-brg = <1>;
 		fsl,cpm-command = <00800000>;
+		gpios = <&gpio_c 15 0
+			 &gpio_d 29 0>;
 	};
 
    iii) Network
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
 	int 			wait_closing;
 	/* value to combine with opcode to form cpm command */
 	u32			command;
+	int			gpios[NUM_GPIOS];
 };
 
 #ifndef CONFIG_PPC_CPM_NEW_BINDING
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index 7a704ff..0f08071 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -42,6 +42,8 @@
 #include <linux/bootmem.h>
 #include <linux/dma-mapping.h>
 #include <linux/fs_uart_pd.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -152,13 +154,41 @@ static unsigned int cpm_uart_tx_empty(struct uart_port *port)
 
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
@@ -959,6 +989,7 @@ static int cpm_uart_init_port(struct device_node *np,
 	void __iomem *mem, *pram;
 	int len;
 	int ret;
+	int i;
 
 	data = of_get_property(np, "fsl,cpm-brg", &len);
 	if (!data || len != 4) {
@@ -1017,6 +1048,9 @@ static int cpm_uart_init_port(struct device_node *np,
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
