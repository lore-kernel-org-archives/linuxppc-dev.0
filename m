Return-Path: <B21989@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E865F2C0171
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 17:40:27 +1000 (EST)
Received: from mail181-ch1 (localhost [127.0.0.1])	by
 mail181-ch1-R.bigfish.com (Postfix) with ESMTP id 299076028E	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 07:40:21 +0000 (UTC)
Received: from CH1EHSMHS004.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.234])	by mail181-ch1.bigfish.com (Postfix) with ESMTP id
 1103D40211
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 07:40:20 +0000 (UTC)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/p3041: change espi input-clock from 40MHz to 35MHz
Date: Tue, 17 Jul 2012 15:18:31 +0800
Message-ID: <1342509511-13942-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Default CCB on P3041 is 750MHz, but espi cannot work at 40MHz with this CCB,
so we need to slow down the clock rate of espi to 35MHz to make it work stable
with the CCB.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
 arch/powerpc/boot/dts/p3041ds.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/p3041ds.dts b/arch/powerpc/boot/dts/p3041ds.dts
index 22a215e..6cdcadc 100644
--- a/arch/powerpc/boot/dts/p3041ds.dts
+++ b/arch/powerpc/boot/dts/p3041ds.dts
@@ -58,7 +58,7 @@
 				#size-cells = <1>;
 				compatible = "spansion,s25sl12801";
 				reg = <0>;
-				spi-max-frequency = <40000000>; /* input clock */
+				spi-max-frequency = <35000000>; /* input clock */
 				partition@u-boot {
 					label = "u-boot";
 					reg = <0x00000000 0x00100000>;
-- 
1.6.4
