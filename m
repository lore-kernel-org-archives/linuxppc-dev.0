Return-Path: <camelia.groza@nxp.com>
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GFZw03X0zF3Fg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 21:57:11 +1000 (AEST)
From: Camelia Groza <camelia.groza@nxp.com>
To: oss@buserror.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Camelia Groza <camelia.groza@nxp.com>
Subject: [PATCH] powerpc/dts/fsl: t2080rdb: reorder the Cortina PHY XFI lanes
Date: Thu, 20 Sep 2018 14:47:01 +0300
Message-Id: <1537444021-10113-1-git-send-email-camelia.groza@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

According to the T2080RDB schematics, for the CS4315 PHY, the XFI 1 lane is
connected to SFP 2 and the XFI 2 lane is connected to SFP 1. Change the
device tree to reflect the correct PHY order and port association.

Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
---
 arch/powerpc/boot/dts/fsl/t2080rdb.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t2080rdb.dts b/arch/powerpc/boot/dts/fsl/t2080rdb.dts
index 55c0210..092a400 100644
--- a/arch/powerpc/boot/dts/fsl/t2080rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t2080rdb.dts
@@ -77,12 +77,12 @@
 		};

 		ethernet@f0000 {
-			phy-handle = <&xg_cs4315_phy1>;
+			phy-handle = <&xg_cs4315_phy2>;
 			phy-connection-type = "xgmii";
 		};

 		ethernet@f2000 {
-			phy-handle = <&xg_cs4315_phy2>;
+			phy-handle = <&xg_cs4315_phy1>;
 			phy-connection-type = "xgmii";
 		};

--
1.9.1
