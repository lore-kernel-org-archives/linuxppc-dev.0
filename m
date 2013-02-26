Return-Path: <B37781@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 597582C02A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 14:38:49 +1100 (EST)
From: Jiucheng Xu <Jiucheng.Xu@freescale.com>
To: <galak@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: Reserve a partition of NOR flash for QE ucode
 firmware
Date: Tue, 26 Feb 2013 10:33:36 +0800
Message-ID: <1361846016-9023-1-git-send-email-Jiucheng.Xu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Jiucheng Xu <Jiucheng.Xu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Due to the partition of JFFS2 overlaps with QE ucode firmware, So JFFS2
will break QE ucode. Shrink JFFS2's partition to reserve the space of
QE ucode firmware.

Signed-off-by: Jiucheng Xu <Jiucheng.Xu@freescale.com>
---
 arch/powerpc/boot/dts/p1021rdb-pc.dtsi |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1021rdb-pc.dtsi b/arch/powerpc/boot/dts/p1021rdb-pc.dtsi
index c13abfb..d6274c5 100644
--- a/arch/powerpc/boot/dts/p1021rdb-pc.dtsi
+++ b/arch/powerpc/boot/dts/p1021rdb-pc.dtsi
@@ -62,11 +62,19 @@
 		};
 
 		partition@400000 {
-			/* 11MB for JFFS2 based Root file System */
-			reg = <0x00400000 0x00b00000>;
+			/* 10.75MB for JFFS2 based Root file System */
+			reg = <0x00400000 0x00ac0000>;
 			label = "NOR JFFS2 Root File System";
 		};
 
+		partition@ec0000 {
+			/* This location must not be altered  */
+			/* 256KB for QE ucode firmware*/
+			reg = <0x00ec0000 0x00040000>;
+			label = "NOR QE microcode firmware";
+			read-only;
+		};
+
 		partition@f00000 {
 			/* This location must not be altered  */
 			/* 512KB for u-boot Bootloader Image */
-- 
1.6.4
