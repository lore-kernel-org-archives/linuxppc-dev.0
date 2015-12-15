Return-Path: <qiang.zhao@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0130.outbound.protection.outlook.com [207.46.100.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0261D1A0246
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 13:49:02 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
CC: <robh+dt@kernel.org>, <scottwood@freescale.com>, Zhao Qiang
 <qiang.zhao@freescale.com>
Subject: [PATCH] p1010rdb:update dts for pcie interrupt-map
Date: Tue, 15 Dec 2015 10:41:18 +0800
Message-ID: <1450147278-28773-1-git-send-email-qiang.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

p1010rdb use the irq[4:5] for inta and intb to pcie,
it is active-high, so set it.

Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
---
 arch/powerpc/boot/dts/fsl/p1010rdb.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/p1010rdb.dtsi b/arch/powerpc/boot/dts/fsl/p1010rdb.dtsi
index 0f0ced6..14b6295 100644
--- a/arch/powerpc/boot/dts/fsl/p1010rdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1010rdb.dtsi
@@ -215,3 +215,19 @@
 		phy-connection-type = "sgmii";
 	};
 };
+
+&pci0 {
+	pcie@0 {
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			/*
+			 *irq[4:5] are active-high
+			 *irq[6:7] are active-low
+			 */
+			0000 0x0 0x0 0x1 &mpic 0x4 0x2 0x0 0x0
+			0000 0x0 0x0 0x2 &mpic 0x5 0x2 0x0 0x0
+			0000 0x0 0x0 0x3 &mpic 0x6 0x1 0x0 0x0
+			0000 0x0 0x0 0x4 &mpic 0x7 0x1 0x0 0x0
+			>;
+	};
+};
-- 
2.1.0.27.g96db324
