Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C5554DDECD
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 03:30:25 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l8IHTDMW031115
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 21:29:13 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l8IHTDcm031112
	for linuxppc-dev@ozlabs.org; Tue, 18 Sep 2007 21:29:13 +0400
Date: Tue, 18 Sep 2007 21:29:13 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] PowerPC: Fix Sequoia MAL0 and EMAC dts entries.
Message-ID: <20070918172913.GA31098@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070918172510.GA30944@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

According to PowerPC 440EPx documentation,
MAL0 is comprised of four channels (two transmit and two receive).
Each channel is dedicated to one of two EMAC cores.
This patch fixes Sequoia DTS MAL0 entry and EMAC entries,
assigning correct channel numbers to EMACs.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/boot/dts/sequoia.dts |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -ruN linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts linux-2.6/arch/powerpc/boot/dts/sequoia.dts
--- linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts	2007-09-18 15:32:18.000000000 +0400
+++ linux-2.6/arch/powerpc/boot/dts/sequoia.dts	2007-09-18 21:11:00.000000000 +0400
@@ -107,8 +107,8 @@
 		MAL0: mcmal {
 			compatible = "ibm,mcmal-440epx", "ibm,mcmal2";
 			dcr-reg = <180 62>;
-			num-tx-chans = <4>;
-			num-rx-chans = <4>;
+			num-tx-chans = <2>;
+			num-rx-chans = <2>;
 			interrupt-parent = <&MAL0>;
 			interrupts = <0 1 2 3 4>;
 			#interrupt-cells = <1>;
@@ -239,7 +239,7 @@
 				reg = <ef600e00 70>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
-				mal-tx-channel = <0 1>;
+				mal-tx-channel = <0>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
 				max-frame-size = <5dc>;
@@ -265,7 +265,7 @@
 				reg = <ef600f00 70>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
-				mal-tx-channel = <2 3>;
+				mal-tx-channel = <1>;
 				mal-rx-channel = <1>;
 				cell-index = <1>;
 				max-frame-size = <5dc>;
