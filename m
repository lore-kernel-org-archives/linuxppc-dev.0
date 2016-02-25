Return-Path: <xuelin.shi@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0130.outbound.protection.outlook.com [65.55.169.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79EE21A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 16:11:11 +1100 (AEDT)
From: <xuelin.shi@nxp.com>
To: <robh+dt@kernel.org>, <scott.wood@nxp.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>, Xuelin Shi
 <xuelin.shi@nxp.com>
Subject: [PATCH] powerpc/p5040: Add device node for RAID Engine 
Date: Thu, 25 Feb 2016 09:14:05 +0800
Message-ID: <1456362845-12169-1-git-send-email-xuelin.shi@nxp.com>
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

From: Xuelin Shi <xuelin.shi@nxp.com>

add the missing RAID Engine device node for p5040.
otherwise, the device can not be detected.

Signed-off-by: Xuelin Shi <xuelin.shi@nxp.com>
---
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi | 1 +
 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi  | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
index 2f227b1..e2bd931 100644
--- a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
@@ -420,6 +420,7 @@
 		fsl,iommu-parent = <&pamu4>;
 	};
 
+/include/ "qoriq-raid1.0-0.dtsi"
 /include/ "qoriq-qman1.dtsi"
 /include/ "qoriq-bman1.dtsi"
 
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
index 0659d5b..dbd5775 100644
--- a/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
@@ -73,6 +73,12 @@
 		rtic_d = &rtic_d;
 		sec_mon = &sec_mon;
 
+		raideng = &raideng;
+		raideng_jr0 = &raideng_jr0;
+		raideng_jr1 = &raideng_jr1;
+		raideng_jr2 = &raideng_jr2;
+		raideng_jr3 = &raideng_jr3;
+
 		fman0 = &fman0;
 		fman1 = &fman1;
 		ethernet0 = &enet0;
-- 
1.8.4
