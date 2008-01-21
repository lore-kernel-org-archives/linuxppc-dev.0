Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 9F349DDDFC
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 02:37:25 +1100 (EST)
Date: Mon, 21 Jan 2008 16:37:45 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] autodetect serial console on pegasos2
Message-ID: <20080121153745.GA8725@aepfle.de>
References: <20070331150823.GA25421@aepfle.de>
	<20080121152900.GA8664@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080121152900.GA8664@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Autodetect the serial console on Pegasos2.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 arch/powerpc/platforms/chrp/setup.c |   52 ++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -251,6 +251,57 @@ static void briq_restart(char *cmd)
 	for(;;);
 }
 
+/*
+ * Per default, input/output-device points to the keyboard/screen
+ * If no card is installed, the built-in serial port is used as a fallback.
+ * But unfortunately, the firmware does not connect /chosen/{stdin,stdout}
+ * the the built-in serial node. Instead, a /failsafe node is created.
+ */
+static void chrp_init_early(void)
+{
+	struct device_node *node;
+	const char *property;
+
+	if (strstr(cmd_line, "console="))
+		return;
+	/* find the boot console from /chosen/stdout */
+	if (!of_chosen)
+		return;
+	node = of_find_node_by_path("/");
+	if (!node)
+		return;
+	property = of_get_property(node, "model", NULL);
+	if (!property)
+		goto out_put;
+	if (strcmp(property, "Pegasos2"))
+		goto out_put;
+	/* this is a Pegasos2 */
+	property = of_get_property(of_chosen, "linux,stdout-path", NULL);
+	if (!property)
+		goto out_put;
+	of_node_put(node);
+	node = of_find_node_by_path(property);
+	if (!node)
+		return;
+	property = of_get_property(node, "device_type", NULL);
+	if (!property)
+		goto out_put;
+	if (strcmp(property, "serial"))
+		goto out_put;
+	/*
+	 * The 9pin connector is either /failsafe
+	 * or /pci@80000000/isa@C/serial@i2F8
+	 * The optional graphics card has also type 'serial' in VGA mode.
+	 */
+	property = of_get_property(node, "name", NULL);
+	if (!property)
+		goto out_put;
+	if (!strcmp(property, "failsafe") || !strcmp(property, "serial"))
+		add_preferred_console("ttyS", 0, NULL);
+out_put:
+	of_node_put(node);
+}
+
 void __init chrp_setup_arch(void)
 {
 	struct device_node *root = of_find_node_by_path("/");
@@ -594,6 +645,7 @@ define_machine(chrp) {
 	.probe			= chrp_probe,
 	.setup_arch		= chrp_setup_arch,
 	.init			= chrp_init2,
+	.init_early		= chrp_init_early,
 	.show_cpuinfo		= chrp_show_cpuinfo,
 	.init_IRQ		= chrp_init_IRQ,
 	.restart		= rtas_restart,
