Return-Path: <martyn.welch@ge.com>
Received: from exprod5og113.obsmtp.com (exprod5og113.obsmtp.com [64.18.0.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6E657B7DF6
	for <linuxppc-dev@ozlabs.org>; Fri, 14 May 2010 20:36:00 +1000 (EST)
From: Martyn Welch <martyn.welch@ge.com>
Subject: [PATCH] powerpc: Add i8042 keyboard and mouse irq parsing
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, benh@kernel.crashing.org
Date: Fri, 14 May 2010 11:35:54 +0100
Message-ID: <20100514102905.7807.27638.stgit@ES-J7S4D2J.amer.consind.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, linux-input@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the irqs for the i8042, which historically provides keyboard and
mouse (aux) support, is hardwired in the driver rather than parsing the
dts.

In addition the interrupts are provided in the dts, but in a way that is
not easily parsable using irq_of_parse_and_map().

This patch modifies the powerpc legacy IO code to attempt to parse the
device tree for this information, failing back to the hardcoded values if
it fails. For this to succeed the interrupts for the keyboard and mouse
ports need to be moved from the parent i8042 node to the individual port
nodes.

Signed-off-by: Martyn Welch <martyn.welch@ge.com>
---

To get irq_of_parse_and_map() to successfully parse the interrupts, I had
to do this to my device tree:

@@ -120,16 +120,17 @@
                                #address-cells = <1>;
                                reg = <1 0x60 0x1
                                       1 0x64 0x1>;
-                               interrupts = <1 1 12 1>;
                                interrupt-parent = <&lpc_pic>;
 
                                keyboard@0 {
                                        reg = <0x0>;
+                                       interrupts = <1 1>;
                                        compatible = "pnpPNP,303";
                                };
 
                                mouse@1 {
                                        reg = <0x1>;
+                                       interrupts = <12 1>;
                                        compatible = "pnpPNP,f03";
                                };
                        };

I'm not sure how to parse for the correct interrupt if I don't do this. I
this is incorrect and someone could advise me on how the existing device
tree layout can be properly parsed, I'll happily modify this patch.


 arch/powerpc/kernel/setup-common.c |   34 +++++++++++++++++++++++++++++++---
 drivers/input/serio/i8042-io.h     |    8 ++++++++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 03dd6a2..9c4dc4c 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -93,6 +93,10 @@ struct screen_info screen_info = {
 	.orig_video_points = 16
 };
 
+/* Variables required to store legacy IO irq routing */
+int of_i8042_kbd_irq;
+int of_i8042_aux_irq;
+
 #ifdef __DO_IRQ_CANON
 /* XXX should go elsewhere eventually */
 int ppc_do_canonicalize_irqs;
@@ -555,13 +559,37 @@ void probe_machine(void)
 /* Match a class of boards, not a specific device configuration. */
 int check_legacy_ioport(unsigned long base_port)
 {
-	struct device_node *parent, *np = NULL;
+	struct device_node *parent, *np = NULL, *np_aux = NULL;
 	int ret = -ENODEV;
 
 	switch(base_port) {
 	case I8042_DATA_REG:
-		if (!(np = of_find_compatible_node(NULL, NULL, "pnpPNP,303")))
-			np = of_find_compatible_node(NULL, NULL, "pnpPNP,f03");
+		np = of_find_compatible_node(NULL, NULL, "pnpPNP,303");
+		if (np) {
+			/*
+			 * Attempt to parse DTS for keyboard irq, fallback to
+			 * standard.
+			 */
+			of_i8042_kbd_irq = irq_of_parse_and_map(np, 0);
+			if (!of_i8042_kbd_irq)
+				of_i8042_kbd_irq = 1;
+		}
+
+		np_aux = of_find_compatible_node(NULL, NULL, "pnpPNP,f03");
+		if (np_aux) {
+			if (!np) {
+				of_node_put(np);
+				np = np_aux;
+			}
+			/*
+			 * Attempt to parse DTS for mouse (aux) irq, fallback to
+			 * standard.
+			 */
+			of_i8042_aux_irq = irq_of_parse_and_map(np_aux, 0);
+			if (!of_i8042_aux_irq)
+				of_i8042_aux_irq = 12;
+		}
+
 		if (np) {
 			parent = of_get_parent(np);
 			of_node_put(np);
diff --git a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
index 847f4aa..8fc8753 100644
--- a/drivers/input/serio/i8042-io.h
+++ b/drivers/input/serio/i8042-io.h
@@ -19,6 +19,11 @@
  * IRQs.
  */
 
+#if defined(CONFIG_PPC)
+extern int of_i8042_kbd_irq;
+extern int of_i8042_aux_irq;
+#endif
+
 #ifdef __alpha__
 # define I8042_KBD_IRQ	1
 # define I8042_AUX_IRQ	(RTC_PORT(0) == 0x170 ? 9 : 12)	/* Jensen is special */
@@ -27,6 +32,9 @@
 #include <asm/irq.h>
 #elif defined(CONFIG_SH_CAYMAN)
 #include <asm/irq.h>
+#elif defined(CONFIG_PPC)
+#define I8042_KBD_IRQ	of_i8042_kbd_irq
+#define I8042_AUX_IRQ	of_i8042_aux_irq
 #else
 # define I8042_KBD_IRQ	1
 # define I8042_AUX_IRQ	12


--
Martyn Welch (Principal Software Engineer)   |   Registered in England and
GE Intelligent Platforms                     |   Wales (3828642) at 100
T +44(0)127322748                            |   Barbirolli Square, Manchester,
E martyn.welch@ge.com                        |   M2 3AB  VAT:GB 927559189
