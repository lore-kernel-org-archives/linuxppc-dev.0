Return-Path: <B25806@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 105F0B6F6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Aug 2011 20:58:14 +1000 (EST)
Received: from mail186-ch1 (localhost.localdomain [127.0.0.1])	by
	mail186-ch1-R.bigfish.com (Postfix) with ESMTP id A2B7511F00FA	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2011 10:58:07 +0000 (UTC)
Received: from CH1EHSMHS012.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.241])	by mail186-ch1.bigfish.com (Postfix) with ESMTP id
	686FD1358046	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Aug 2011 10:58:07 +0000 (UTC)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/p1023rds: Fix the error of bank-width of nor flash
Date: Fri, 12 Aug 2011 19:00:09 +0800
Message-ID: <1313146809-13686-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the p1023rds, a physical bus of nor flash is 16 bits width.
The bank-width is width (in bytes) of the bus width. So, the
value of bank-width of nor flash is not one, and it should be
two.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
---
 arch/powerpc/boot/dts/p1023rds.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1023rds.dts b/arch/powerpc/boot/dts/p1023rds.dts
index bfa96aa..d9b7767 100644
--- a/arch/powerpc/boot/dts/p1023rds.dts
+++ b/arch/powerpc/boot/dts/p1023rds.dts
@@ -387,7 +387,7 @@
 			#size-cells = <1>;
 			compatible = "cfi-flash";
 			reg = <0x0 0x0 0x02000000>;
-			bank-width = <1>;
+			bank-width = <2>;
 			device-width = <1>;
 			partition@0 {
 				label = "ramdisk";
-- 
1.5.6.5
