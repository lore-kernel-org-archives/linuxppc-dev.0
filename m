Return-Path: <mls.JOFT@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id E5637DDEEA
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Aug 2007 20:37:07 +1000 (EST)
Subject: [PATCH 2/2] [VIRTEX] Register AC97 Controller Reference with the
	platform bus
From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 12:37:04 +0200
Message-Id: <1186655824.7420.27.camel@localhost>
Mime-Version: 1.0
Cc: alsa-devel <alsa-devel@alsa-project.org>,
	Lorenz Kolb <lorenz.kolb@lkmail.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: Joachim Foerster <JOFT@gmx.de>

(Patch for Linus' master branch, date 2007/08/08)

Signed-off-by: Joachim Foerster <JOFT@gmx.de>
---
 arch/ppc/syslib/virtex_devices.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/syslib/virtex_devices.c b/arch/ppc/syslib/virtex_devices.c
index 62a9495..0d6f0ac 100644
--- a/arch/ppc/syslib/virtex_devices.c
+++ b/arch/ppc/syslib/virtex_devices.c
@@ -121,6 +121,29 @@
 	}, \
 }
 
+#define XPAR_AC97_CONTROLLER_REFERENCE(num) { \
+	.name = "ml403_ac97cr",	      \
+	.id = num, \
+	.num_resources = 3, \
+	.resource = (struct resource[]) { \
+	        { \
+		        .start = XPAR_OPB_AC97_CONTROLLER_REF_0_BASEADDR, \
+			.end = XPAR_OPB_AC97_CONTROLLER_REF_0_HIGHADDR, \
+			.flags = IORESOURCE_MEM, \
+		}, \
+		{ \
+			.start = XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_0_PLAYBACK_INTERRUPT_INTR, \
+			.end = XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_0_PLAYBACK_INTERRUPT_INTR, \
+			.flags = IORESOURCE_IRQ, \
+		}, \
+		{ \
+			.start = XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_0_RECORD_INTERRUPT_INTR, \
+			.end = XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_0_RECORD_INTERRUPT_INTR, \
+                        .flags = IORESOURCE_IRQ, \
+               }, \
+        }, \
+}
+
 /* UART 8250 driver platform data table */
 struct plat_serial8250_port virtex_serial_platform_data[] = {
 #if defined(XPAR_UARTNS550_0_BASEADDR)
@@ -221,6 +244,11 @@ struct platform_device virtex_platform_devices[] = {
 #if defined(XPAR_TFT_3_BASEADDR)
 	XPAR_TFT(3),
 #endif
+
+	/* AC97 Controller Reference instances */
+#if defined(XPAR_OPB_AC97_CONTROLLER_REF_0_BASEADDR)
+	XPAR_AC97_CONTROLLER_REFERENCE(0),
+#endif
 };
 
 /* Early serial support functions */
-- 
1.5.2.4
