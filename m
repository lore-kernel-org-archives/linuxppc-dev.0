Return-Path: <B31939@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1AE3B2C0306
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 17:15:51 +1000 (EST)
Received: from mail123-tx2 (localhost [127.0.0.1])	by
 mail123-tx2-R.bigfish.com (Postfix) with ESMTP id 05F134E0177	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 07:15:48 +0000 (UTC)
Received: from TX2EHSMHS014.bigfish.com (unknown [10.9.14.234])	by
 mail123-tx2.bigfish.com (Postfix) with ESMTP id 2FF134A0058	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 07:15:45 +0000 (UTC)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/5] powerpc/dts: update MSI bindings doc for MPIC v4.3
Date: Fri, 14 Jun 2013 15:15:57 +0800
Message-ID: <1371194159-17332-3-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Minghuan Lian <Minghuan.Lian@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add compatible "fsl,mpic-msi-v4.3" for MPIC v4.3. MPIC v4.3 contains
MSIIR and MSIIR1. MSIIR supports 8 MSI registers and MSIIR1 supports
16 MSI registers, but uses different IBS and SRS shift. When using
MSIR1, the interrupt number is not consecutive. It is hard to use
'msi-available-ranges' to describe the ranges of the available
interrupt and the ranges are related to the application, rather than
the description of the hardware. this patch also removes
'msi-available-ranges' property.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
 .../devicetree/bindings/powerpc/fsl/msi-pic.txt    | 49 ++++++++++------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt b/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
index 5693877..e851e93 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
@@ -1,26 +1,23 @@
 * Freescale MSI interrupt controller
 
 Required properties:
-- compatible : compatible list, contains 2 entries,
+- compatible : compatible list, may contains one or two entries,
   first is "fsl,CHIP-msi", where CHIP is the processor(mpc8610, mpc8572,
-  etc.) and the second is "fsl,mpic-msi" or "fsl,ipic-msi" depending on
-  the parent type.
+  etc.) and the second is "fsl,mpic-msi" or "fsl,ipic-msi" or
+  "fsl,mpic-msi-v4.3" depending on the parent type and version. If mpic
+  version is 4.3, the number of MSI registers is increased to 16, MSIIR1 is
+  provided to access these 16 registers, compatible "fsl,mpic-msi-v4.3"
+  should be used.
 
 - reg : It may contain one or two regions. The first region should contain
   the address and the length of the shared message interrupt register set.
-  The second region should contain the address of aliased MSIIR register for
-  platforms that have such an alias.
-
-- msi-available-ranges: use <start count> style section to define which
-  msi interrupt can be used in the 256 msi interrupts. This property is
-  optional, without this, all the 256 MSI interrupts can be used.
-  Each available range must begin and end on a multiple of 32 (i.e.
-  no splitting an individual MSI register or the associated PIC interrupt).
+  The second region should contain the address of aliased MSIIR or MSIIR1
+  register for platforms that have such an alias, if using MSIIR1, the second
+  region must be added because different MSI group has different MSIRR1 offset.
 
 - interrupts : each one of the interrupts here is one entry per 32 MSIs,
   and routed to the host interrupt controller. the interrupts should
-  be set as edge sensitive.  If msi-available-ranges is present, only
-  the interrupts that correspond to available ranges shall be present.
+  be set as edge sensitive.
 
 - interrupt-parent: the phandle for the interrupt controller
   that services interrupts for this device. for 83xx cpu, the interrupts
@@ -39,20 +36,18 @@ Optional properties:
 
 Example:
 	msi@41600 {
-		compatible = "fsl,mpc8610-msi", "fsl,mpic-msi";
-		reg = <0x41600 0x80>;
-		msi-available-ranges = <0 0x100>;
-		interrupts = <
-			0xe0 0
-			0xe1 0
-			0xe2 0
-			0xe3 0
-			0xe4 0
-			0xe5 0
-			0xe6 0
-			0xe7 0>;
-		interrupt-parent = <&mpic>;
-	};
+	compatible = "fsl,mpic-msi";
+	reg = <0x41600 0x200 0x44140 4>;
+	interrupts = <
+		0xe0 0 0 0
+		0xe1 0 0 0
+		0xe2 0 0 0
+		0xe3 0 0 0
+		0xe4 0 0 0
+		0xe5 0 0 0
+		0xe6 0 0 0
+		0xe7 0 0 0>;
+};
 
 The Freescale hypervisor and msi-address-64
 -------------------------------------------
-- 
1.8.1.2
