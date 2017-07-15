Return-Path: <ijc-relay-phiayoh8@benson.default.arb33.uk0.bigv.io>
Received: from benson.default.arb33.uk0.bigv.io
 (benson.default.arb33.uk0.bigv.io [IPv6:2001:41c9:1:41d::16])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x8l9L3YpHzDql1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jul 2017 19:48:06 +1000 (AEST)
From: Ian Campbell <ijc@hellion.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Ian Campbell <ijc@hellion.org.uk>, Ivan Mikhaylov <ivan@de.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 devicetree@vger.kernel.org
Subject: [PATCH] powerpc/44x/fsp2: correct dtb reg property for /sdhci@020c0000
Date: Sat, 15 Jul 2017 10:03:02 +0100
Message-Id: <20170715090302.23105-1-ijc@hellion.org.uk>
Sender: ijc-relay-phiayoh8@benson.default.arb33.uk0.bigv.io
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Building the split device-tree tree[0] highlighted that upstream commit
9eec6cb142bd ("powerpc/44x/fsp2: Add device tree for FSP2 board") introduced
this warning when building the device tree:

$ make CROSS_COMPILE=powerpc-linux-gnu- ARCH=powerpc fsp2.dtb
  CHK     scripts/mod/devicetable-offsets.h
  DTC     arch/powerpc/boot/fsp2.dtb
arch/powerpc/boot/fsp2.dtb: Warning (reg_format): "reg" property in /sdhci@020c0000 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)

This commit adds the second adress cell as zeroes to resolve the warning. Note:
I have no access to or information about this platform so this is purely a
guess as to the fix. An alternative would be to adjust #address-cells, but
whether that is correct or not depends on the platform.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
Cc: Ivan Mikhaylov <ivan@de.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/boot/dts/fsp2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/fsp2.dts b/arch/powerpc/boot/dts/fsp2.dts
index 475953ada707..ab6d2346527f 100644
--- a/arch/powerpc/boot/dts/fsp2.dts
+++ b/arch/powerpc/boot/dts/fsp2.dts
@@ -362,7 +362,7 @@
 	mmc0: sdhci@020c0000 {
 		compatible	= "st,sdhci-stih407", "st,sdhci";
 		status		= "disabled";
-		reg		= <0x020c0000 0x20000>;
+		reg		= <0x00000000 0x020c0000 0x20000>;
 		reg-names	= "mmc";
 		interrupt-parent = <&UIC1_3>;
 		interrupts	= <21 0x4 22 0x4>;
-- 
2.11.0
