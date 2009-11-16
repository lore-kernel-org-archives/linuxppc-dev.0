Return-Path: <dbaryshkov@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.24])
	by ozlabs.org (Postfix) with ESMTP id 55123B7BCD
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 00:59:02 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 4so1611792eyf.33
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 05:59:01 -0800 (PST)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/4] mpc8349emitx: add gpio controller declarations
Date: Mon, 16 Nov 2009 16:58:51 +0300
Message-Id: <1258379934-32352-2-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1258379934-32352-1-git-send-email-dbaryshkov@gmail.com>
References: <1258379934-32352-1-git-send-email-dbaryshkov@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpc8349 bears two GPIO controllers. Enable support for them.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/boot/dts/mpc8349emitx.dts |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index feeeb7f..16872c9 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -63,6 +63,24 @@
 			reg = <0x200 0x100>;
 		};
 
+		gpio1: gpio-controller@c00 {
+			#gpio-cells = <2>;
+			compatible = "fsl,mpc8349-gpio";
+			reg = <0xc00 0x100>;
+			interrupts = <74 0x8>;
+			interrupt-parent = <&ipic>;
+			gpio-controller;
+		};
+
+		gpio2: gpio-controller@d00 {
+			#gpio-cells = <2>;
+			compatible = "fsl,mpc8349-gpio";
+			reg = <0xd00 0x100>;
+			interrupts = <75 0x8>;
+			interrupt-parent = <&ipic>;
+			gpio-controller;
+		};
+
 		i2c@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.6.5
