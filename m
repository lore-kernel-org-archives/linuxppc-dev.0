Return-Path: <linnj@wolfgang-pc.public.xilinx.com>
Received: from outbound10-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5ECB1DDE1E
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 10:22:16 +1100 (EST)
From: John Linn <john.linn@xilinx.com>
To: linuxppc-dev@ozlabs.org,
	grant.likely@secretlab.ca
Subject: [PATCH 2/3] [POWERPC][V3] Xilinx: of_serial support for Xilinx uart
	16550.
Date: Wed,  2 Apr 2008 16:22:19 -0700
Message-Id: <20080402232213.5D87515B8067@mail37-sin.bigfish.com>
Cc: John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Xilinx 16550 uart core is not a standard 16550 because it uses
word-based addressing rather than byte-based addressing. With
additional properties it is compatible with the open firmware
'ns16550' compatible binding.

This code updates the of_serial driver to handle the reg-offset
and reg-shift properties to enable this core to be used.

Signed-off-by: John Linn <john.linn@xilinx.com>
---

V3 has fixes suggested by Grant. They were incorporated and tested.

 Documentation/powerpc/booting-without-of.txt |   10 ++++++++++
 drivers/serial/of_serial.c                   |   14 +++++++++++++-
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 87f4d84..4066ec8 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -2539,6 +2539,16 @@ platforms are moved over to use the flattened-device-tree model.
                       differ between different families.  May be
                       'virtex2p', 'virtex4', or 'virtex5'.
 
+      iv) Xilinx Uart 16550
+
+      Xilinx UART 16550 devices are very similar to the NS16550 but with
+      different register spacing and an offset from the base address.
+
+      Requred properties:
+       - clock-frequency : Frequency of the clock input
+       - reg-offset : A value of 3 is required
+       - reg-shift : A value of 2 is required
+
    More devices will be defined as this spec matures.
 
 VII - Specifying interrupt information for devices
diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
index 2efb892..73c47a5 100644
--- a/drivers/serial/of_serial.c
+++ b/drivers/serial/of_serial.c
@@ -31,7 +31,8 @@ static int __devinit of_platform_serial_setup(struct of_device *ofdev,
 	struct resource resource;
 	struct device_node *np = ofdev->node;
 	const unsigned int *clk, *spd;
-	int ret;
+	const u32 *prop;
+	int ret, prop_size;
 
 	memset(port, 0, sizeof *port);
 	spd = of_get_property(np, "current-speed", NULL);
@@ -49,6 +50,17 @@ static int __devinit of_platform_serial_setup(struct of_device *ofdev,
 
 	spin_lock_init(&port->lock);
 	port->mapbase = resource.start;
+
+	/* Check for shifted address mapping */
+	prop = of_get_property(np, "reg-offset", &prop_size);
+	if (prop && (prop_size == sizeof(u32)))
+		port->mapbase += *prop;
+
+	/* Check for registers offset within the devices address range */
+	prop = of_get_property(np, "reg-shift", &prop_size);
+	if (prop && (prop_size == sizeof(u32)))
+		port->regshift = *prop;
+
 	port->irq = irq_of_parse_and_map(np, 0);
 	port->iotype = UPIO_MEM;
 	port->type = type;
-- 
1.5.2.1
