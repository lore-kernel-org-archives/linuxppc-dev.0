Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:1c35:abcd:42:0:1])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E7502B6FBC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2012 04:39:31 +1100 (EST)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/p2020rdb p1010rdb: lower spi flash freq to 40Mhz
Date: Thu, 15 Mar 2012 18:40:28 +0100
Message-Id: <1331833228-14903-2-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1331833228-14903-1-git-send-email-bigeasy@linutronix.de>
References: <1331833228-14903-1-git-send-email-bigeasy@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is here most likely since the FSL bsp. Back in the FSL bsp it was
set to 50Mhz and working. However the driver divided the SoC freq. only
by 2. According to the TRM the platform clock (which the manual refers
in its formula) is the system clock divided by two. So in the end it has
to divide by 4 and this is what the fsl-spi driver in tree is doing.
Since then the flash is not wokring I guess. After chaning the freq from
50Mhz to 40Mhz like others do then I can access the flash.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/boot/dts/p1010rdb.dtsi |    2 +-
 arch/powerpc/boot/dts/p2020rdb.dts  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1010rdb.dtsi b/arch/powerpc/boot/dts/p1010rdb.dtsi
index d4c4a77..1c41ef0 100644
--- a/arch/powerpc/boot/dts/p1010rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1010rdb.dtsi
@@ -138,7 +138,7 @@
 			#size-cells = <1>;
 			compatible = "spansion,s25sl12801";
 			reg = <0>;
-			spi-max-frequency = <50000000>;
+			spi-max-frequency = <40000000>;
 
 			partition@0 {
 				/* 1MB for u-boot Bootloader Image */
diff --git a/arch/powerpc/boot/dts/p2020rdb.dts b/arch/powerpc/boot/dts/p2020rdb.dts
index 8f25ef2..153bc76 100644
--- a/arch/powerpc/boot/dts/p2020rdb.dts
+++ b/arch/powerpc/boot/dts/p2020rdb.dts
@@ -157,7 +157,7 @@
 				#size-cells = <1>;
 				compatible = "spansion,s25sl12801";
 				reg = <0>;
-				spi-max-frequency = <50000000>;
+				spi-max-frequency = <40000000>;
 
 				partition@0 {
 					/* 512KB for u-boot Bootloader Image */
-- 
1.7.9.1
