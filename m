Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id CB303B6F8F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jun 2011 08:27:17 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org,
	grant.likely@secretlab.ca
Subject: [PATCH] powerpc/5200: dts: digsy_mtc.dts: add timer0 and timer1 gpio
	properties
Date: Tue,  7 Jun 2011 00:27:05 +0200
Message-Id: <1307399225-15882-1-git-send-email-agust@denx.de>
In-Reply-To: <1305561764-5942-1-git-send-email-agust@denx.de>
References: <1305561764-5942-1-git-send-email-agust@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

timer0 and timer1 pins are used as simple GPIO on this board.
Add gpio-controller and #gpio-cells properties to timer nodes
so that we can control gpio lines using available MPC52xx
GPT driver.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/boot/dts/digsy_mtc.dts |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/digsy_mtc.dts b/arch/powerpc/boot/dts/digsy_mtc.dts
index e205d17..2aad7ae 100644
--- a/arch/powerpc/boot/dts/digsy_mtc.dts
+++ b/arch/powerpc/boot/dts/digsy_mtc.dts
@@ -23,7 +23,14 @@
 
 	soc5200@f0000000 {
 		timer@600 {	// General Purpose Timer
+			#gpio-cells = <2>;
 			fsl,has-wdt;
+			gpio-controller;
+		};
+
+		timer@610 {
+			#gpio-cells = <2>;
+			gpio-controller;
 		};
 
 		rtc@800 {
-- 
1.7.1
