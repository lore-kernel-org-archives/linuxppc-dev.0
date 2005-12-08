Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 510F368897
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2005 21:48:46 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guy Yasko <gyasko@gmail.com>
In-Reply-To: <87bqzs5cio.fsf@oedipa.disorg>
References: <20051026215535.GA5713@campbell-lange.net>
	<1133124018.7768.107.camel@gaston> <87veydaftb.fsf@oedipa.disorg>
	<1133130209.7768.136.camel@gaston> <877jatemic.fsf@oedipa.disorg>
	<1133132287.7768.138.camel@gaston> <87oe45d0j4.fsf@oedipa.disorg>
	<1133142131.7768.156.camel@gaston> <87ek51cycq.fsf@oedipa.disorg>
	<1133145863.7768.165.camel@gaston>
	<73eb1cf90511271913k1786facev55038e567c51d19c@mail.gmail.com>
	<1133150158.7768.177.camel@gaston> <87zmnpbe34.fsf@oedipa.disorg>
	<1133151191.7768.183.camel@gaston> <87hd9wak4a.fsf@oedipa.disorg>
	<1133210294.7768.190.camel@gaston>  <87bqzs5cio.fsf@oedipa.disorg>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 21:48:00 +1100
Message-Id: <1134038881.11760.11.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Fix boot on some 12" powerbooks, need testers on others
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch against 2.6.15-rc5 might help fixing boot on some recent
powerbooks like some 12" aluminium. However, I need urgently some
testers with other models of powerbooks and mac mini to tell me if it
causes any regression (that is before tomorrow) so it _might_ have a
chance to make it in 2.6.15.

Index: linux-work/arch/powerpc/platforms/powermac/feature.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/feature.c	2005-11-19 10:56:07.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/feature.c	2005-12-08 21:45:30.000000000 +1100
@@ -1650,11 +1650,17 @@
 	 */
 
 	if (macio->type == macio_intrepid) {
-		if (enable)
-			UN_OUT(UNI_N_CLOCK_SPREADING, 2);
-		else
-			UN_OUT(UNI_N_CLOCK_SPREADING, 0);
-		mdelay(40);
+		struct device_node *clock =
+			of_find_node_by_path("/uni-n@f8000000/hw-clock");
+		if (clock && get_property(clock, "platform-do-clockspreading",
+					  NULL)) {
+			if (enable)
+				UN_OUT(UNI_N_CLOCK_SPREADING, 2);
+			else
+				UN_OUT(UNI_N_CLOCK_SPREADING, 0);
+			mdelay(40);
+		}
+		of_node_put(clock);
 	}
 
 	while (machine_is_compatible("PowerBook5,2") ||
Index: linux-work/arch/ppc/platforms/pmac_feature.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_feature.c	2005-11-14 20:32:16.000000000 +1100
+++ linux-work/arch/ppc/platforms/pmac_feature.c	2005-12-08 21:45:48.000000000 +1100
@@ -1606,11 +1606,17 @@
 	 */
 
 	if (macio->type == macio_intrepid) {
-		if (enable)
-			UN_OUT(UNI_N_CLOCK_SPREADING, 2);
-		else
-			UN_OUT(UNI_N_CLOCK_SPREADING, 0);
-		mdelay(40);
+		struct device_node *clock =
+			of_find_node_by_path("/uni-n@f8000000/hw-clock");
+		if (clock && get_property(clock, "platform-do-clockspreading",
+					  NULL)) {
+			if (enable)
+				UN_OUT(UNI_N_CLOCK_SPREADING, 2);
+			else
+				UN_OUT(UNI_N_CLOCK_SPREADING, 0);
+			mdelay(40);
+		}
+		of_node_put(clock);
 	}
 
 	while (machine_is_compatible("PowerBook5,2") ||
