Return-Path: <madalin.bucur@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0142.outbound.protection.outlook.com [157.56.111.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9977C1A0728
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 22:43:02 +1000 (AEST)
From: Madalin Bucur <madalin.bucur@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 3/4] powerpc/fsl-booke: Add T1024RDB QBMan device tree
Date: Wed, 20 May 2015 15:41:39 +0300
Message-ID: <1432125700-7024-4-git-send-email-madalin.bucur@freescale.com>
In-Reply-To: <1432125700-7024-3-git-send-email-madalin.bucur@freescale.com>
References: <1432125700-7024-1-git-send-email-madalin.bucur@freescale.com>
 <1432125700-7024-2-git-send-email-madalin.bucur@freescale.com>
 <1432125700-7024-3-git-send-email-madalin.bucur@freescale.com>
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
 arch/powerpc/boot/dts/t1024rdb.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/powerpc/boot/dts/t1024rdb.dts b/arch/powerpc/boot/dts/t1024rdb.dts
index eb1d51b..0984ae8 100644
--- a/arch/powerpc/boot/dts/t1024rdb.dts
+++ b/arch/powerpc/boot/dts/t1024rdb.dts
@@ -41,6 +41,25 @@
 	#size-cells = <2>;
 	interrupt-parent = <&mpic>;
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		bman_fbpr: bman-fbpr {
+			size = <0 0x1000000>;
+			alignment = <0 0x1000000>;
+		};
+		qman_fqd: qman-fqd {
+			size = <0 0x400000>;
+			alignment = <0 0x400000>;
+		};
+		qman_pfdr: qman-pfdr {
+			size = <0 0x2000000>;
+			alignment = <0 0x2000000>;
+		};
+	};
+
 	ifc: localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x2000>;
 		ranges = <0 0 0xf 0xe8000000 0x08000000
@@ -82,6 +101,14 @@
 		ranges = <0x00000000 0xf 0x00000000 0x01072000>;
 	};
 
+	bportals: bman-portals@ff4000000 {
+		ranges = <0x0 0xf 0xf4000000 0x2000000>;
+	};
+
+	qportals: qman-portals@ff6000000 {
+		ranges = <0x0 0xf 0xf6000000 0x2000000>;
+	};
+
 	soc: soc@ffe000000 {
 		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
 		reg = <0xf 0xfe000000 0 0x00001000>;
@@ -183,3 +210,4 @@
 };
 
 /include/ "fsl/t1024si-post.dtsi"
+/include/ "fsl/qoriq-dpaa-res3.dtsi"
-- 
1.7.11.7
