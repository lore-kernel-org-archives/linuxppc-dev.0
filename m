Return-Path: <fkan@amcc.com>
Received: from sdcmail01.amcc.com (sdcmail01.amcc.com [198.137.200.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id ED4F4DDE1B
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 03:50:03 +1000 (EST)
From: Feng Kan <fkan@amcc.com>
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Subject: [PATCH 3/3 v3] Add 4xx SATA dts node documentation
Date: Wed,  6 May 2009 10:49:46 -0700
Message-Id: <1241632186-2613-1-git-send-email-fkan@amcc.com>
Cc: Feng Kan <fkan@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Feng Kan <fkan@amcc.com>
---
 Documentation/powerpc/dts-bindings/4xx/sata.txt |   24 +++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/4xx/sata.txt

diff --git a/Documentation/powerpc/dts-bindings/4xx/sata.txt b/Documentation/powerpc/dts-bindings/4xx/sata.txt
new file mode 100644
index 0000000..3ce00d0
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/4xx/sata.txt
@@ -0,0 +1,24 @@
+AMCC SoC SATA Support 
+
+This following is only for the 460ex support for Designware SATA core
+
+Required properties:
+- compatible : "amcc,sata-460ex".
+- reg : the first set defines SATA controller register, the second set
+        is for the AHB DMA controller for SATA.
+- interrupt-parent: UIC3
+- interrupts: one for SATA and one for the DMA
+
+Notes:
+The SATA is only available when the first PCIe port is disabled.
+
+Example:
+
+SATA0: sata@bffd1000 {
+	compatible = "amcc,sata-460ex";
+        reg = <4 0xbffd1000 0x800 4 0xbffd0800 0x400>;
+	interrupt-parent = <&UIC3>;
+	interrupts = <0 4       /* SATA */
+		      5 4>;     /* AHBDMA */
+};
+
-- 
1.5.5
