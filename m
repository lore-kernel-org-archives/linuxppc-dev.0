Return-Path: <B35336@freescale.com>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id AA7CFB7610
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 20:56:17 +1100 (EST)
Received: from mail110-tx2 (localhost.localdomain [127.0.0.1])	by
 mail110-tx2-R.bigfish.com (Postfix) with ESMTP id CFA8F600399	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 09:55:59 +0000 (UTC)
Received: from TX2EHSMHS038.bigfish.com (unknown [10.9.14.244])	by
 mail110-tx2.bigfish.com (Postfix) with ESMTP id 619B91058056	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 09:55:40 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 5/7] fsl_pmc: update device bindings
Date: Wed, 16 Nov 2011 17:55:43 +0800
Message-ID: <1321437344-19253-5-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1321437344-19253-1-git-send-email-chenhui.zhao@freescale.com>
References: <1321437344-19253-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Li Yang <leoli@freescale.com>

Signed-off-by: Li Yang <leoli@freescale.com>
---
 .../devicetree/bindings/powerpc/fsl/pmc.txt        |   63 +++++++++++--------
 1 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt b/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
index 07256b7..d84b4f8 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/pmc.txt
@@ -9,22 +9,27 @@ Properties:
 
   "fsl,mpc8548-pmc" should be listed for any chip whose PMC is
   compatible.  "fsl,mpc8536-pmc" should also be listed for any chip
-  whose PMC is compatible, and implies deep-sleep capability.
+  whose PMC is compatible, and implies deep-sleep capability and
+  wake on user defined packet(wakeup on ARP).
+
+  "fsl,p1022-pmc" should be listed for any chip whose PMC is
+  compatible, and implies lossless Ethernet capability during sleep.
 
   "fsl,mpc8641d-pmc" should be listed for any chip whose PMC is
   compatible; all statements below that apply to "fsl,mpc8548-pmc" also
   apply to "fsl,mpc8641d-pmc".
 
   Compatibility does not include bit assignments in SCCR/PMCDR/DEVDISR; these
-  bit assignments are indicated via the sleep specifier in each device's
-  sleep property.
+  bit assignments are indicated via the clock nodes.  Device which has a
+  controllable clock source should have a "clk-handle" property pointing
+  to the clock node.
 
 - reg: For devices compatible with "fsl,mpc8349-pmc", the first resource
   is the PMC block, and the second resource is the Clock Configuration
   block.
 
-  For devices compatible with "fsl,mpc8548-pmc", the first resource
-  is a 32-byte block beginning with DEVDISR.
+  For devices compatible with "fsl,mpc8548-pmc", the second resource
+  is a 32-byte block beginning with DEVDISR if supported.
 
 - interrupts: For "fsl,mpc8349-pmc"-compatible devices, the first
   resource is the PMC block interrupt.
@@ -33,31 +38,35 @@ Properties:
   this is a phandle to an "fsl,gtm" node on which timer 4 can be used as
   a wakeup source from deep sleep.
 
-Sleep specifiers:
+Clock nodes:
+The clock nodes are to describe the masks in PM controller registers for each
+soc clock.
+- fsl,pmcdr-mask: For "fsl,mpc8548-pmc"-compatible devices, the mask will be
+  ORed into PMCDR before suspend if the device using this clock is the wake-up
+  source and need to be running during low power mode; clear the mask if
+  otherwise.
 
-  fsl,mpc8349-pmc: Sleep specifiers consist of one cell.  For each bit
-  that is set in the cell, the corresponding bit in SCCR will be saved
-  and cleared on suspend, and restored on resume.  This sleep controller
-  supports disabling and resuming devices at any time.
+- fsl,sccr-mask: For "fsl,mpc8349-pmc"-compatible devices, the corresponding
+  bit specified by the mask in SCCR will be saved and cleared on suspend, and
+  restored on resume.
 
-  fsl,mpc8536-pmc: Sleep specifiers consist of three cells, the third of
-  which will be ORed into PMCDR upon suspend, and cleared from PMCDR
-  upon resume.  The first two cells are as described for fsl,mpc8578-pmc.
-  This sleep controller only supports disabling devices during system
-  sleep, or permanently.
-
-  fsl,mpc8548-pmc: Sleep specifiers consist of one or two cells, the
-  first of which will be ORed into DEVDISR (and the second into
-  DEVDISR2, if present -- this cell should be zero or absent if the
-  hardware does not have DEVDISR2) upon a request for permanent device
-  disabling.  This sleep controller does not support configuring devices
-  to disable during system sleep (unless supported by another compatible
-  match), or dynamically.
+- fsl,devdisr-mask: Contain one or two cells, depending on the availability of
+  DEVDISR2 register.  For compatible devices, the mask will be ORed into DEVDISR
+  or DEVDISR2 when the clock should be permenently disabled.
 
 Example:
 
-	power@b00 {
-		compatible = "fsl,mpc8313-pmc", "fsl,mpc8349-pmc";
-		reg = <0xb00 0x100 0xa00 0x100>;
-		interrupts = <80 8>;
+	power@e0070 {
+		compatible = "fsl,mpc8536-pmc", "fsl,mpc8548-pmc";
+		reg = <0xe0070 0x20>;
+
+		etsec1_clk: soc-clk@24 {
+			fsl,pmcdr-mask = <0x00000080>;
+		};
+		etsec2_clk: soc-clk@25 {
+			fsl,pmcdr-mask = <0x00000040>;
+		};
+		etsec3_clk: soc-clk@26 {
+			fsl,pmcdr-mask = <0x00000020>;
+		};
 	};
-- 
1.6.4.1
