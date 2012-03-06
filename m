Return-Path: <B35336@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B0A5CB7004
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 20:05:10 +1100 (EST)
Received: from mail31-ch1 (localhost [127.0.0.1])	by mail31-ch1-R.bigfish.com
 (Postfix) with ESMTP id B22323803D2	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Mar 2012 09:05:04 +0000 (UTC)
Received: from CH1EHSMHS022.bigfish.com (snatpool3.int.messaging.microsoft.com
 [10.43.68.227])	by mail31-ch1.bigfish.com (Postfix) with ESMTP id
 F3F8B240045
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 09:05:02 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 9/9] powerpc/mpc8548cds: add 36-bit dts
Date: Tue, 6 Mar 2012 17:06:45 +0800
Message-ID: <1331024805-15926-8-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
References: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Create mpc8548cds_36b.dts. Support 36-bit mode.

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/boot/dts/mpc8548cds_36b.dts |   86 ++++++++++++++++++++++++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc8548cds_36b.dts

diff --git a/arch/powerpc/boot/dts/mpc8548cds_36b.dts b/arch/powerpc/boot/dts/mpc8548cds_36b.dts
new file mode 100644
index 0000000..10e551b
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8548cds_36b.dts
@@ -0,0 +1,86 @@
+/*
+ * MPC8548 CDS Device Tree Source (36-bit address map)
+ *
+ * Copyright 2012 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/include/ "fsl/mpc8548si-pre.dtsi"
+
+/ {
+	model = "MPC8548CDS";
+	compatible = "MPC8548CDS", "MPC85xxCDS";
+
+	memory {
+		device_type = "memory";
+		reg = <0 0 0x0 0x8000000>;	// 128M at 0x0
+	};
+
+	board_lbc: lbc: localbus@fe0005000 {
+		reg = <0xf 0xe0005000 0 0x1000>;
+
+		ranges = <0x0 0x0 0xf 0xff000000 0x01000000
+			  0x1 0x0 0xf 0xf8004000 0x00001000>;
+
+	};
+
+	board_soc: soc: soc8548@fe0000000 {
+		ranges = <0 0xf 0xe0000000 0x100000>;
+	};
+
+	board_pci0: pci0: pci@fe0008000 {
+		reg = <0xf 0xe0008000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xe0000000 0xc 0x00000000 0x0 0x10000000
+			  0x1000000 0x0 0x00000000 0xf 0xe2000000 0x0 0x800000>;
+		clock-frequency = <66666666>;
+	};
+
+	pci1: pci@fe0009000 {
+		reg = <0xf 0xe0009000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xe0000000 0xc 0x10000000 0x0 0x10000000
+			  0x1000000 0x0 0x00000000 0xf 0xe2800000 0x0 0x800000>;
+		clock-frequency = <66666666>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+
+			/* IDSEL 0x15 */
+			0xa800 0x0 0x0 0x1 &mpic 0xb 0x1 0 0
+			0xa800 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
+			0xa800 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
+			0xa800 0x0 0x0 0x4 &mpic 0x3 0x1 0 0>;
+	};
+
+	pci2: pcie@fe000a000 {
+		reg = <0xf 0xe000a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0xf 0xe3000000 0x0 0x100000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xa0000000
+				  0x2000000 0x0 0xa0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	rio: rapidio@fe00c0000 {
+		reg = <0xf 0xe00c0000 0x0 0x20000>;
+		port1 {
+			ranges = <0x0 0x0 0xc 0x40000000 0x0 0x20000000>;
+		};
+	};
+};
+
+/*
+ * mpc8548cds.dtsi must be last to ensure board_pci0 overrides pci0 settings
+ * for interrupt-map & interrupt-map-mask.
+ */
+
+/include/ "fsl/mpc8548si-post.dtsi"
+/include/ "mpc8548cds.dtsi"
-- 
1.6.4.1
