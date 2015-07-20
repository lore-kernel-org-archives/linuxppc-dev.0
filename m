Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0101.outbound.protection.outlook.com [65.55.169.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B6E5B1A094B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 17:37:25 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, Zhao Qiang <B45475@freescale.com>
Subject: [PATCH] powerpc/p1010rdb:update dts for pcie interrupt-map
Date: Mon, 20 Jul 2015 15:32:19 +0800
Message-ID: <1437377539-15911-1-git-send-email-qiang.zhao@freescale.com>
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

From: Zhao Qiang <B45475@freescale.com>

p1010rdb-pb use the irq[4:5] for inta and intb to pcie,
it is active-high, so set it.

Signed-off-by: Zhao Qiang <B45475@freescale.com>
Change-Id: I29db41b4a8b5a67c18151099884edda6de4d9d1a
Reviewed-on: http://git.am.freescale.net:8181/9915
Tested-by: Review Code-CDREVIEW <CDREVIEW@freescale.com>
Reviewed-by: Xiaobo Xie <X.Xie@freescale.com>
Reviewed-by: Jose Rivera <German.Rivera@freescale.com>
---
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
index 1804ed7..4313ff6 100644
--- a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
@@ -59,8 +59,12 @@
 		interrupt-map-mask = <0xf800 0 0 7>;
 		interrupt-map = <
 			/* IDSEL 0x0 */
-			0000 0x0 0x0 0x1 &mpic 0x4 0x1 0x0 0x0
-			0000 0x0 0x0 0x2 &mpic 0x5 0x1 0x0 0x0
+			/*
+			 *irq[4:5] only for PCIe in dts, set to active-high
+			 *irq[6:7] is pulled up on board, set to active-low
+			 */
+			0000 0x0 0x0 0x1 &mpic 0x4 0x2 0x0 0x0
+			0000 0x0 0x0 0x2 &mpic 0x5 0x2 0x0 0x0
 			0000 0x0 0x0 0x3 &mpic 0x6 0x1 0x0 0x0
 			0000 0x0 0x0 0x4 &mpic 0x7 0x1 0x0 0x0
 			>;
-- 
2.1.0.27.g96db324
