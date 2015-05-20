Return-Path: <madalin.bucur@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0117.outbound.protection.outlook.com [207.46.100.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A4C291A07C3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 22:43:03 +1000 (AEST)
From: Madalin Bucur <madalin.bucur@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 4/4] powerpc/fsl-booke: Add T1024RDB FMan device tree
Date: Wed, 20 May 2015 15:41:40 +0300
Message-ID: <1432125700-7024-5-git-send-email-madalin.bucur@freescale.com>
In-Reply-To: <1432125700-7024-4-git-send-email-madalin.bucur@freescale.com>
References: <1432125700-7024-1-git-send-email-madalin.bucur@freescale.com>
 <1432125700-7024-2-git-send-email-madalin.bucur@freescale.com>
 <1432125700-7024-3-git-send-email-madalin.bucur@freescale.com>
 <1432125700-7024-4-git-send-email-madalin.bucur@freescale.com>
Reply-To: <madalin.bucur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Igal.Liberman@freescale.com, roy.pledge@freescale.com,
 Madalin Bucur <madalin.bucur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Madalin Bucur <madalin.bucur@freescale.com>
---
 arch/powerpc/boot/dts/t1024rdb.dts | 45 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/powerpc/boot/dts/t1024rdb.dts b/arch/powerpc/boot/dts/t1024rdb.dts
index 0984ae8..860e4c7 100644
--- a/arch/powerpc/boot/dts/t1024rdb.dts
+++ b/arch/powerpc/boot/dts/t1024rdb.dts
@@ -161,6 +161,51 @@
 				#size-cells = <0>;
 			};
 		};
+
+		fman@400000 {
+			fm1mac1: ethernet@e0000 {
+				phy-handle = <&xg_aqr105_phy3>;
+				phy-connection-type = "xgmii";
+				sleep = <&rcpm 0x80000000>;
+			};
+
+			fm1mac2: ethernet@e2000 {
+				sleep = <&rcpm 0x40000000>;
+			};
+
+			fm1mac3: ethernet@e4000 {
+				phy-handle = <&rgmii_phy2>;
+				phy-connection-type = "rgmii";
+				sleep = <&rcpm 0x20000000>;
+			};
+
+			fm1mac4: ethernet@e6000 {
+				phy-handle = <&rgmii_phy1>;
+				phy-connection-type = "rgmii";
+				sleep = <&rcpm 0x10000000>;
+			};
+
+
+			mdio0: mdio@fc000 {
+				rgmii_phy1: ethernet-phy@2 {
+					reg = <0x2>;
+				};
+				rgmii_phy2: ethernet-phy@6 {
+					reg = <0x6>;
+				};
+			};
+
+			xmdio0: mdio@fd000 {
+				xg_aqr105_phy3: ethernet-phy@1 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x1>;
+				};
+				sg_2500_aqr105_phy4: ethernet-phy@2 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x2>;
+				};
+			};
+		};
 	};
 
 	pci0: pcie@ffe240000 {
-- 
1.7.11.7
