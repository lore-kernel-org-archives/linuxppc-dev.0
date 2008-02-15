Return-Path: <pkiryukhin@ru.mvista.com>
Received: from smtp02.mtu.ru (smtp02.mtu.ru [62.5.255.49])
	by ozlabs.org (Postfix) with ESMTP id 772B4DDED3
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 00:28:27 +1100 (EST)
Received: from smtp02.mtu.ru (localhost [127.0.0.1])
	by smtp02.mtu.ru (Postfix) with ESMTP id 305992DF1A
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 16:28:22 +0300 (MSK)
Received: from [192.168.1.3] (ppp83-237-251-59.pppoe.mtu-net.ru
	[83.237.251.59]) by smtp02.mtu.ru (Postfix) with ESMTP id 131642DD1E
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 16:28:21 +0300 (MSK)
Message-ID: <47B593E1.2060905@ru.mvista.com>
Date: Fri, 15 Feb 2008 16:30:09 +0300
From: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] [POWERPC] Enable correct operation of serial ports with
	nonzero regshift.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add regshift reading to serial drivers.
This enables correct operation of serial ports with 
nonzero regshift such as Xilinx opb 16550 uart.

Signed-off-by: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>

 arch/powerpc/kernel/legacy_serial.c |    6 +++++-
 drivers/serial/of_serial.c          |    6 ++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 61dd174..949e41c 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -50,7 +50,7 @@ static int __init add_legacy_port(struct device_node *np, int want_index,
 				  phys_addr_t taddr, unsigned long irq,
 				  upf_t flags, int irq_check_parent)
 {
-	const u32 *clk, *spd;
+	const u32 *clk, *spd, *regshift;
 	u32 clock = BASE_BAUD * 16;
 	int index;
 
@@ -62,6 +62,9 @@ static int __init add_legacy_port(struct device_node *np, int want_index,
 	/* get default speed if present */
 	spd = of_get_property(np, "current-speed", NULL);
 
+	/* get regshift if present*/
+	regshift = of_get_property(np, "reg-shift", NULL);
+
 	/* If we have a location index, then try to use it */
 	if (want_index >= 0 && want_index < MAX_LEGACY_SERIAL_PORTS)
 		index = want_index;
@@ -104,6 +107,7 @@ static int __init add_legacy_port(struct device_node *np, int want_index,
 	legacy_serial_ports[index].uartclk = clock;
 	legacy_serial_ports[index].irq = irq;
 	legacy_serial_ports[index].flags = flags;
+	legacy_serial_ports[index].regshift = regshift ? (u8)*regshift : 0;
 	legacy_serial_infos[index].taddr = taddr;
 	legacy_serial_infos[index].np = of_node_get(np);
 	legacy_serial_infos[index].clock = clock;
diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
index a64d858..3f09c5a 100644
--- a/drivers/serial/of_serial.c
+++ b/drivers/serial/of_serial.c
@@ -30,7 +30,7 @@ static int __devinit of_platform_serial_setup(struct of_device *ofdev,
 {
 	struct resource resource;
 	struct device_node *np = ofdev->node;
-	const unsigned int *clk, *spd;
+	const unsigned int *clk, *spd, *regshift;
 	int ret;
 
 	memset(port, 0, sizeof *port);
@@ -40,7 +40,7 @@ static int __devinit of_platform_serial_setup(struct of_device *ofdev,
 		dev_warn(&ofdev->dev, "no clock-frequency property set\n");
 		return -ENODEV;
 	}
-
+	regshift = of_get_property(np, "reg-shift", NULL);
 	ret = of_address_to_resource(np, 0, &resource);
 	if (ret) {
 		dev_warn(&ofdev->dev, "invalid address\n");
@@ -57,6 +57,8 @@ static int __devinit of_platform_serial_setup(struct of_device *ofdev,
 		| UPF_FIXED_PORT;
 	port->dev = &ofdev->dev;
 	port->custom_divisor = *clk / (16 * (*spd));
+	if (regshift)
+		port->regshift = *regshift;
 
 	return 0;
 }
