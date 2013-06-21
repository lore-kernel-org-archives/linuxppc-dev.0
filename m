Return-Path: <B31939@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AAA662C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2013 20:58:56 +1000 (EST)
Received: from mail115-db8 (localhost [127.0.0.1])	by
 mail115-db8-R.bigfish.com (Postfix) with ESMTP id 1D4C840120	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2013 10:58:50 +0000 (UTC)
Received: from DB8EHSMHS022.bigfish.com (unknown [10.174.8.253])	by
 mail115-db8.bigfish.com (Postfix) with ESMTP id 8DB662C004B	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2013 10:58:48 +0000 (UTC)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/3 v2] powerpc/dts: update MSI bindings doc for MPIC v4.3
Date: Fri, 21 Jun 2013 18:59:12 +0800
Message-ID: <1371812354-1962-1-git-send-email-Minghuan.Lian@freescale.com>
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
interrupt, so MPIC v4.3 does not support this property.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
v2 log:
1. move msi-available-ranges to optional properties.

 .../devicetree/bindings/powerpc/fsl/msi-pic.txt    | 51 +++++++++++++++++-----
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt b/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
index 5693877..d82b080 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
@@ -1,21 +1,20 @@
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
+  should be used. The first entry is optional, the second entry must be
+  required.
 
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
+  region must be added because different MSI group has different MSIIR1 offset.
 
 - interrupts : each one of the interrupts here is one entry per 32 MSIs,
   and routed to the host interrupt controller. the interrupts should
@@ -28,6 +27,14 @@ Required properties:
   to MPIC.
 
 Optional properties:
+- msi-available-ranges: use <start count> style section to define which
+  msi interrupt can be used in the 256 msi interrupts. This property is
+  optional, without this, all the MSI interrupts can be used.
+  Each available range must begin and end on a multiple of 32 (i.e.
+  no splitting an individual MSI register or the associated PIC interrupt).
+  MPIC v4.3 does not support this property because the 32 interrupts of an
+  individual register are not continuous when using MSIIR1.
+
 - msi-address-64: 64-bit PCI address of the MSIIR register. The MSIIR register
   is used for MSI messaging.  The address of MSIIR in PCI address space is
   the MSI message address.
@@ -54,6 +61,28 @@ Example:
 		interrupt-parent = <&mpic>;
 	};
 
+	msi@41600 {
+		compatible = "fsl,mpic-msi-v4.3";
+		reg = <0x41600 0x200 0x44148 4>;
+		interrupts = <
+			0xe0 0 0 0
+			0xe1 0 0 0
+			0xe2 0 0 0
+			0xe3 0 0 0
+			0xe4 0 0 0
+			0xe5 0 0 0
+			0xe6 0 0 0
+			0xe7 0 0 0
+			0x100 0 0 0
+			0x101 0 0 0
+			0x102 0 0 0
+			0x103 0 0 0
+			0x104 0 0 0
+			0x105 0 0 0
+			0x106 0 0 0
+			0x107 0 0 0>;
+	};
+
 The Freescale hypervisor and msi-address-64
 -------------------------------------------
 Normally, PCI devices have access to all of CCSR via an ATMU mapping.  The
-- 
1.8.1.2
