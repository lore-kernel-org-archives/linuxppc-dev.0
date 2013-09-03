Return-Path: <B38951@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C0EFC2C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Sep 2013 17:54:40 +1000 (EST)
Received: from mail178-co9 (localhost [127.0.0.1])	by
 mail178-co9-R.bigfish.com (Postfix) with ESMTP id DD15E640200	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Sep 2013 07:54:35 +0000 (UTC)
Received: from CO9EHSMHS021.bigfish.com (unknown [10.236.132.237])	by
 mail178-co9.bigfish.com (Postfix) with ESMTP id 824B5A0003F	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Sep 2013 07:54:33 +0000 (UTC)
From: Jia Hongtao <hongtao.jia@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <B07421@freescale.com>
Subject: [PATCH] powerpc: Add I2C bus multiplexer node for B4 and T4240QDS
Date: Tue, 3 Sep 2013 15:51:44 +0800
Message-ID: <1378194704-29909-1-git-send-email-hongtao.jia@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In both B4 and T4240QDS platform PCA9547 I2C bus multiplexer is used.

Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
---
 arch/powerpc/boot/dts/b4qds.dtsi   | 4 ++++
 arch/powerpc/boot/dts/t4240qds.dts | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/powerpc/boot/dts/b4qds.dtsi b/arch/powerpc/boot/dts/b4qds.dtsi
index e6d2f8f..2aa3399 100644
--- a/arch/powerpc/boot/dts/b4qds.dtsi
+++ b/arch/powerpc/boot/dts/b4qds.dtsi
@@ -120,6 +120,10 @@
 		};
 
 		i2c@118000 {
+			pca9547@77 {
+				compatible = "philips,pca9547";
+				reg = <0x77>;
+			};
 			eeprom@50 {
 				compatible = "at24,24c64";
 				reg = <0x50>;
diff --git a/arch/powerpc/boot/dts/t4240qds.dts b/arch/powerpc/boot/dts/t4240qds.dts
index 0555976..084db57 100644
--- a/arch/powerpc/boot/dts/t4240qds.dts
+++ b/arch/powerpc/boot/dts/t4240qds.dts
@@ -118,6 +118,10 @@
 		};
 
 		i2c@118000 {
+			pca9547@77 {
+				compatible = "philips,pca9547";
+				reg = <0x77>;
+			};
 			eeprom@51 {
 				compatible = "at24,24c256";
 				reg = <0x51>;
-- 
1.8.0
