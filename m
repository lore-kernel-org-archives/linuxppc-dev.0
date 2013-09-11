Return-Path: <B45475@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0EFAC2C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 13:53:10 +1000 (EST)
Received: from mail192-db9 (localhost [127.0.0.1])	by
 mail192-db9-R.bigfish.com (Postfix) with ESMTP id D139E5000DE	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 03:53:04 +0000 (UTC)
Received: from DB9EHSMHS027.bigfish.com (unknown [10.174.16.225])	by
 mail192-db9.bigfish.com (Postfix) with ESMTP id 70D423C0085	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 03:53:02 +0000 (UTC)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/p1010rdb:remove interrupts of ethernet-phy in device
 tree
Date: Wed, 11 Sep 2013 11:49:14 +0800
Message-ID: <1378871354-22763-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475@freescale.com>,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since P1010RDB-PA and P1010RDB-PB boards use different external PHY
interrupt signals.
And actually the PHY interrupt is not used effectively with
corresponding interrupt handler.
So we can remove the interrupts node without side-effect to comply
with both P1010RDB-PA and P1010RDB-PB.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
 arch/powerpc/boot/dts/p1010rdb.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1010rdb.dtsi b/arch/powerpc/boot/dts/p1010rdb.dtsi
index 7fc3402..2433ae4 100644
--- a/arch/powerpc/boot/dts/p1010rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1010rdb.dtsi
@@ -199,17 +199,14 @@
 
 	mdio@24000 {
 		phy0: ethernet-phy@0 {
-			interrupts = <3 1 0 0>;
 			reg = <0x1>;
 		};
 
 		phy1: ethernet-phy@1 {
-			interrupts = <2 1 0 0>;
 			reg = <0x0>;
 		};
 
 		phy2: ethernet-phy@2 {
-			interrupts = <2 1 0 0>;
 			reg = <0x2>;
 		};
 
-- 
1.8.0
