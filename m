Return-Path: <martyn.welch@ge.com>
Received: from exprod5og110.obsmtp.com (exprod5og110.obsmtp.com [64.18.0.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3229B7D66
	for <linuxppc-dev@ozlabs.org>; Tue, 25 May 2010 18:09:21 +1000 (EST)
From: Martyn Welch <martyn.welch@ge.com>
Subject: [PATCH v3] powerpc: Add i8042 keyboard and mouse irq parsing
To: Grant Likely <grant.likely@secretlab.ca>, benh@kernel.crashing.org
Date: Tue, 25 May 2010 09:09:16 +0100
Message-ID: <20100525080834.29149.70967.stgit@ES-J7S4D2J.amer.consind.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
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
dts.  This patch modifies the powerpc legacy IO code to attempt to parse
the device tree for this information, failing back to the hardcoded values
if it fails.

Signed-off-by: Martyn Welch <martyn.welch@ge.com>
---

v2: This patch no longer requires the DTS files to be modified, reading the
interrupts from the current location as suggested by Grant.

v3: Code compacted as suggested by Grant.

 arch/powerpc/kernel/setup-common.c |   13 +++++++++++++
 drivers/input/serio/i8042-io.h     |    5 +++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 48f0a00..3d169bb 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -94,6 +94,10 @@ struct screen_info screen_info = {
 	.orig_video_points = 16
 };
 
+/* Variables required to store legacy IO irq routing */
+int of_i8042_kbd_irq;
+int of_i8042_aux_irq;
+
 #ifdef __DO_IRQ_CANON
 /* XXX should go elsewhere eventually */
 int ppc_do_canonicalize_irqs;
@@ -567,6 +571,15 @@ int check_legacy_ioport(unsigned long base_port)
 			np = of_find_compatible_node(NULL, NULL, "pnpPNP,f03");
 		if (np) {
 			parent = of_get_parent(np);
+
+			of_i8042_kbd_irq = irq_of_parse_and_map(parent, 0);
+			if (!of_i8042_kbd_irq)
+				of_i8042_kbd_irq = 1;
+
+			of_i8042_aux_irq = irq_of_parse_and_map(parent, 1);
+			if (!of_i8042_aux_irq)
+				of_i8042_aux_irq = 12;
+
 			of_node_put(np);
 			np = parent;
 			break;
diff --git a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
index 847f4aa..5d48bb6 100644
--- a/drivers/input/serio/i8042-io.h
+++ b/drivers/input/serio/i8042-io.h
@@ -27,6 +27,11 @@
 #include <asm/irq.h>
 #elif defined(CONFIG_SH_CAYMAN)
 #include <asm/irq.h>
+#elif defined(CONFIG_PPC)
+extern int of_i8042_kbd_irq;
+extern int of_i8042_aux_irq;
+# define I8042_KBD_IRQ  of_i8042_kbd_irq
+# define I8042_AUX_IRQ  of_i8042_aux_irq
 #else
 # define I8042_KBD_IRQ	1
 # define I8042_AUX_IRQ	12


--
Martyn Welch (Principal Software Engineer)   |   Registered in England and
GE Intelligent Platforms                     |   Wales (3828642) at 100
T +44(0)127322748                            |   Barbirolli Square, Manchester,
E martyn.welch@ge.com                        |   M2 3AB  VAT:GB 927559189
