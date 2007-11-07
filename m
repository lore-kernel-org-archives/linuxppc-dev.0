Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 6BF07DDE3D
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 03:15:24 +1100 (EST)
Received: from pd4mr3so.prod.shaw.ca
	(pd4mr3so-qfe3.prod.shaw.ca [10.0.141.214]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JR500B5Y93XRQA0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 07 Nov 2007 09:14:21 -0700 (MST)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
	by pd4mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JR500GU493VR390@pd4mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 07 Nov 2007 09:14:20 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep 5
	2006))
	with ESMTP id <0JR5000EX93SJB60@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 07 Nov 2007 09:14:19 -0700 (MST)
Date: Wed, 07 Nov 2007 09:14:15 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] Register AC97 Controller Reference with the platform bus
To: linuxppc-dev@ozlabs.org, JOFT@gmx.de, jwboyer@linux.vnet.ibm.com
Message-id: <20071107161142.7901.51817.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Joachim Foerster <mls.JOFT@gmx.de>

Add AC97 platform bus registration for Xilinx Virtex platforms.

Signed-off-by: Joachim Foerster <JOFT@gmx.de>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Josh, can you please pick up this patch into your .24 queue.  I know it's
arch/ppc, but it is harmless and it is required to get the AC97 device
driver working on Virtex boards.  It's pretty much a bug fix in that regard.

Cheers,
g.

 arch/ppc/syslib/virtex_devices.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/syslib/virtex_devices.c b/arch/ppc/syslib/virtex_devices.c
index 96188f8..95ee313 100644
--- a/arch/ppc/syslib/virtex_devices.c
+++ b/arch/ppc/syslib/virtex_devices.c
@@ -169,6 +169,29 @@
 	}, \
 }
 
+#define XPAR_AC97_CONTROLLER_REFERENCE(num) { \
+	.name = "ml403_ac97cr", \
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
@@ -303,6 +326,14 @@ struct platform_device virtex_platform_devices[] = {
 #if defined(XPAR_TFT_3_BASEADDR)
 	XPAR_TFT(3),
 #endif
+
+	/* AC97 Controller Reference instances */
+#if defined(XPAR_OPB_AC97_CONTROLLER_REF_0_BASEADDR)
+	XPAR_AC97_CONTROLLER_REFERENCE(0),
+#endif
+#if defined(XPAR_OPB_AC97_CONTROLLER_REF_1_BASEADDR)
+	XPAR_AC97_CONTROLLER_REFERENCE(1),
+#endif
 };
 
 /* Early serial support functions */
