Return-Path: <dbaryshkov@gmail.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id 5AAD3B7D59
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jun 2010 17:16:25 +1000 (EST)
Received: by bwz8 with SMTP id 8so1331855bwz.15
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jun 2010 00:16:23 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] lite5200: fix ethernet phy address
Date: Thu, 10 Jun 2010 11:16:20 +0400
Message-Id: <1276154181-25534-1-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Yogesh Chaudhari <mr.yogesh@gmail.com>, Paul Mackerras <paulus@samba.org>,
	=?UTF-8?q?Ren=C3=A9=20B=C3=BCrgel?= <r.buergel@unicontrol.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

According to my schematics, on Lite5200 board ethernet phy uses address
0 (all ADDR lines are pulled down). With this change I can talk to
onboard phy (LXT971) and correctly use autonegotiation.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: René Bürgel <r.buergel@unicontrol.de>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Yogesh Chaudhari <mr.yogesh@gmail.com>
Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/boot/dts/lite5200.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index 82ff2b1..2b64d8e 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -230,8 +230,8 @@
 			reg = <0x3000 0x400>;	// fec range, since we need to setup fec interrupts
 			interrupts = <2 5 0>;	// these are for "mii command finished", not link changes & co.
 
-			phy0: ethernet-phy@1 {
-				reg = <1>;
+			phy0: ethernet-phy@0 {
+				reg = <0>;
 			};
 		};
 
-- 
1.7.1
