Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 44015DE20D
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 08:24:03 +1100 (EST)
Message-ID: <47279CF0.4050600@harris.com>
Date: Tue, 30 Oct 2007 17:06:56 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: PPC405GP Walnut irq patch
Content-Type: multipart/mixed; boundary="------------070408000205090000060500"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070408000205090000060500
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi - I have found a bug in the ARCH=powerpc Walnut BSP.  The order of 
the ethernet interrupts in the walnut.dts file doesn't match the 
documentation.  I discovered this when porting the BSP to a custom board 
- the ethernet would not work.  The attached patch corrects that.

This is the first patch I am submitting, so please advise me if there is 
anything I should do differently.

Signed-off-by: Steve Falco <sfalco at harris.com>



--------------070408000205090000060500
Content-Type: text/x-patch;
 name="irq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="irq.patch"

--- walnut.dts.orig	2007-10-30 15:27:49.000000000 -0400
+++ walnut.dts	2007-10-30 15:29:40.000000000 -0400
@@ -67,7 +67,7 @@
 			num-tx-chans = <2>;
 			num-rx-chans = <1>;
 			interrupt-parent = <&UIC0>;
-			interrupts = <a 4 b 4 c 4 d 4 e 4>;
+			interrupts = <b 4 c 4 a 4 d 4 e 4>;
 		};
 
 		POB0: opb {
@@ -117,7 +117,7 @@
 				device_type = "network";
 				compatible = "ibm,emac-405gp", "ibm,emac";
 				interrupt-parent = <&UIC0>;
-				interrupts = <9 4 f 4>;
+				interrupts = <f 4 9 4>;
 				reg = <ef600800 70>;
 				mal-device = <&MAL>;
 				mal-tx-channel = <0 1>;

--------------070408000205090000060500--
