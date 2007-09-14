Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D77BDDDF30
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 05:01:25 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8EJ1Mpe020081
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 15:01:22 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8EJ1BeG406002
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 13:01:11 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8EJ1B0M020902
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 13:01:11 -0600
Message-Id: <20070914185649.272138000@linux.vnet.ibm.com>>
References: <20070914185410.387074000@linux.vnet.ibm.com>>
Date: Fri, 14 Sep 2007 13:54:13 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch 3/4] 4xx: Convert Walnut flash mappings to new binding
In-Reply-To: <20070914185410.387074000@linux.vnet.ibm.com>>
Content-Type: text/plain
Mime-Version: 1.0
Cc: david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A new binding for flash devices was recently introduced.  This updates the
Walnut DTS to use the new binding.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/boot/dts/walnut.dts |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- linux-2.6.orig/arch/powerpc/boot/dts/walnut.dts
+++ linux-2.6/arch/powerpc/boot/dts/walnut.dts
@@ -137,6 +137,10 @@
 			dcr-reg = <012 2>;
 			#address-cells = <2>;
 			#size-cells = <1>;
+			/* The ranges property is supplied by the bootwrapper
+			 * and is based on the firmware's configuration of the
+			 * EBC bridge
+			 */
 			clock-frequency = <0>; /* Filled in by zImage */
 
 			sram@0,0 {
@@ -144,13 +148,16 @@
 			};
 
 			flash@0,80000 {
-				device_type = "rom";
-				compatible = "direct-mapped";
-				probe-type = "JEDEC";
+				compatible = "jedec-flash";
 				bank-width = <1>;
-				partitions = <0 80000>;
-				partition-names = "OpenBIOS";
 				reg = <0 80000 80000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				partition@0 {
+					label = "OpenBIOS";
+					reg = <0 80000>;
+					read-only;
+				};
 			};
 
 			ds1743@1,0 {

-- 
