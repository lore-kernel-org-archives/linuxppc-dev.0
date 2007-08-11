Return-Path: <mls.JOFT@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 33CA8DDF79
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 12 Aug 2007 02:24:56 +1000 (EST)
Subject: Re: [PATCHv2 2/2] [VIRTEX] Register AC97 Controller Reference with
	the platform bus
From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hsl6sws0s.wl%tiwai@suse.de>
References: <1186655810.7420.26.camel@localhost> <s5hsl6sws0s.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Sat, 11 Aug 2007 18:24:50 +0200
Message-Id: <1186849490.20835.34.camel@localhost>
Mime-Version: 1.0
Cc: alsa-devel <alsa-devel@alsa-project.org>,
	Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	Lorenz Kolb <lorenz.kolb@lkmail.de>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Grant, Takashi, Stephen,

I tried to correct the issues here, too. But unfortunately Xilinx EDK
uses such long #define macro names. I guess we have to leave it the way
it is?


From: Joachim Foerster <JOFT@gmx.de>

(Patch for Linus' master branch, date 2007/08/08)

Signed-off-by: Joachim Foerster <JOFT@gmx.de>
---
 arch/ppc/syslib/virtex_devices.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/syslib/virtex_devices.c b/arch/ppc/syslib/virtex_devices.c
index 62a9495..d0b04d6 100644
--- a/arch/ppc/syslib/virtex_devices.c
+++ b/arch/ppc/syslib/virtex_devices.c
@@ -121,6 +121,29 @@
 	}, \
 }
 
+#define XPAR_AC97_CONTROLLER_REFERENCE(num) { \
+	.name = "ml403-ac97cr", \
+	.id = num, \
+	.num_resources = 3, \
+	.resource = (struct resource[]) { \
+		{ \
+			.start = XPAR_OPB_AC97_CONTROLLER_REF_##num##_BASEADDR, \
+			.end = XPAR_OPB_AC97_CONTROLLER_REF_##num##_HIGHADDR, \
+			.flags = IORESOURCE_MEM, \
+		}, \
+		{ \
+			.start = XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_##num##_PLAYBACK_INTERRUPT_INTR, \
+			.end = XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_##num##_PLAYBACK_INTERRUPT_INTR, \
+			.flags = IORESOURCE_IRQ, \
+		}, \
+		{ \
+			.start = XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_##num##_RECORD_INTERRUPT_INTR, \
+			.end = XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_##num##_RECORD_INTERRUPT_INTR, \
+			.flags = IORESOURCE_IRQ, \
+		}, \
+	}, \
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
