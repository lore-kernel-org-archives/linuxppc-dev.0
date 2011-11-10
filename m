Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 618D8100899
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 03:07:24 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAAG7JCV027740
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 10:07:19 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/11] powerpc/85xx: Add P1020RDB 36-bit address map device
 tree
Date: Thu, 10 Nov 2011 10:07:09 -0600
Message-Id: <1320941229-29557-11-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1320941229-29557-10-git-send-email-galak@kernel.crashing.org>
References: <1320941229-29557-1-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-2-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-3-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-4-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-5-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-6-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-7-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-8-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-9-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-10-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/p1020rdb_36b.dts |   66 ++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1020rdb_36b.dts

diff --git a/arch/powerpc/boot/dts/p1020rdb_36b.dts b/arch/powerpc/boot/dts/p1020rdb_36b.dts
new file mode 100644
index 0000000..bdbdb60
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1020rdb_36b.dts
@@ -0,0 +1,66 @@
+/*
+ * P1020 RDB Device Tree Source (36-bit address map)
+ *
+ * Copyright 2009-2011 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/include/ "fsl/p1020si-pre.dtsi"
+/ {
+	model = "fsl,P1020RDB";
+	compatible = "fsl,P1020RDB";
+
+	memory {
+		device_type = "memory";
+	};
+
+	board_lbc: lbc: localbus@fffe05000 {
+		reg = <0xf 0xffe05000 0 0x1000>;
+
+		/* NOR, NAND Flashes and Vitesse 5 port L2 switch */
+		ranges = <0x0 0x0 0xf 0xef000000 0x01000000
+			  0x1 0x0 0xf 0xffa00000 0x00040000
+			  0x2 0x0 0xf 0xffb00000 0x00020000>;
+	};
+
+	board_soc: soc: soc@fffe00000 {
+		ranges = <0x0 0xf 0xffe00000 0x100000>;
+	};
+
+	pci0: pcie@fffe09000 {
+		reg = <0xf 0xffe09000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xc0000000 0xc 0x20000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xc0000000
+				  0x2000000 0x0 0xc0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	pci1: pcie@fffe0a000 {
+		reg = <0xf 0xffe0a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0x80000000 0xc 0x00000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0x80000000
+				  0x2000000 0x0 0x80000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+};
+
+/include/ "p1020rdb.dtsi"
+/include/ "fsl/p1020si-post.dtsi"
-- 
1.7.3.4
