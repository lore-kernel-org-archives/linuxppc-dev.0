Return-Path: <B31939@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3957B2C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 12:58:29 +1000 (EST)
Received: from mail50-db9 (localhost [127.0.0.1])	by mail50-db9-R.bigfish.com
 (Postfix) with ESMTP id AA9FAC01E3	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 31 Jul 2013 02:58:23 +0000 (UTC)
Received: from DB9EHSMHS014.bigfish.com (unknown [10.174.16.234])	by
 mail50-db9.bigfish.com (Postfix) with ESMTP id 0863F2C023A	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 02:58:22 +0000 (UTC)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/dts: fix sRIO error interrupt for b4860
Date: Wed, 31 Jul 2013 10:59:07 +0800
Message-ID: <1375239547-8259-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Minghuan Lian <Minghuan.Lian@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For B4 platform, MPIC EISR register is in reversed bitmap order,
instead of "Error interrupt source 0-31. Bit 0 represents SRC0."
the correct ordering is "Error interrupt source 0-31. Bit 0
represents SRC31." This patch is to fix sRIO EISR bit value
of error interrupt in dts node.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
index e5cf6c8..9813975 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
@@ -41,7 +41,7 @@
 
 &rio {
 	compatible = "fsl,srio";
-	interrupts = <16 2 1 11>;
+	interrupts = <16 2 1 20>;
 	#address-cells = <2>;
 	#size-cells = <2>;
 	fsl,iommu-parent = <&pamu0>;
-- 
1.8.1.2
