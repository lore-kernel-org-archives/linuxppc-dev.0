Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 4732DDDDA2
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 06:15:25 +1000 (EST)
From: Wolfgang Denk <wd@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/12] mpc5121ads: Clean up and fix NAND description in
	mpc5121ads DTS.
Date: Wed,  6 May 2009 22:15:14 +0200
Message-Id: <1241640919-4650-8-git-send-email-wd@denx.de>
In-Reply-To: <1241640919-4650-1-git-send-email-wd@denx.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
Cc: Piotr Ziecik <kosmo@semihalf.com>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Piotr Ziecik <kosmo@semihalf.com>

- Removed unused properties.
- Corrected NAND flash chip size.

Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
Signed-off-by: Wolfgang Denk <wd@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: John Rigby <jcrigby@gmail.com>
---
 arch/powerpc/boot/dts/mpc5121ads.dts |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
index 1b83a9d..93fe12a 100644
--- a/arch/powerpc/boot/dts/mpc5121ads.dts
+++ b/arch/powerpc/boot/dts/mpc5121ads.dts
@@ -62,17 +62,12 @@
 		interrupt-parent = < &ipic >;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		bank-width = <1>;
 		// ADS has two Hynix 512MB Nand flash chips in a single
-		// stacked package .
+		// stacked package.
 		chips = <2>;
-		nand0@0 {
-			label = "nand0";
-			reg = <0x00000000 0x02000000>; 	// first 32 MB of chip 0
-		};
-		nand1@20000000 {
-			label = "nand1";
-			reg = <0x20000000 0x02000000>; 	// first 32 MB of chip 1
+		nand@0 {
+			label = "nand";
+			reg = <0x00000000 0x40000000>;	// 512MB + 512MB
 		};
 	};
 
-- 
1.6.0.6
