Return-Path: <dgibson@ozlabs.org>
Date: Mon, 14 May 2007 14:54:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Small fixes for the Ebony device tree
Message-ID: <20070514045404.GP6517@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch corrects a number of minor errors in the Ebony device tree:
	- Missing (given as 0) cache sizes are added to the CPU node
	- device_type properties are removed from nodes which don't
have a reasonably well defined device_type binding.  This does require
a very small code change to locate the busses to be probed for
of_platform devices by 'compatible' instead of 'device_type'.
	- A node is added for the SRAM controller
	- The unit address of the small-flash node is adjusted to
correctly reflect the reg property.
	- device_type values for the MAL and ZMII are updated to
reflected more up-to-date versions of the binding.
	- An incorrect offset in the partition map for the large-flash
node is corrected.
	- Some redundant values, already commented out are removed
entirely.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

The flash partition offset correction, at least, should go into
2.6.22.  I think the rest while only borderline "bugfixes" is also
reasonable for inclusion in 2.6.22.

Index: working-2.6/arch/powerpc/boot/dts/ebony.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/ebony.dts	2007-05-08 15:07:45.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2007-05-14 14:38:39.000000000 +1000
@@ -33,8 +33,8 @@
 			timebase-frequency = <0>; // Filled in by zImage
 			i-cache-line-size = <32>;
 			d-cache-line-size = <32>;
-			i-cache-size = <0>;
-			d-cache-size = <0>;
+			i-cache-size = <2000000>; /* 32 kB */
+			d-cache-size = <2000000>; /* 32 kB */
 			dcr-controller;
 			dcr-access-method = "native";
 		};
@@ -46,7 +46,6 @@
 	};
 
 	UIC0: interrupt-controller0 {
-		device_type = "ibm,uic";
 		compatible = "ibm,uic-440gp", "ibm,uic";
 		interrupt-controller;
 		cell-index = <0>;
@@ -58,7 +57,6 @@
 	};
 
 	UIC1: interrupt-controller1 {
-		device_type = "ibm,uic";
 		compatible = "ibm,uic-440gp", "ibm,uic";
 		interrupt-controller;
 		cell-index = <1>;
@@ -71,14 +69,12 @@
 	};
 
 	CPC0: cpc {
-		device_type = "ibm,cpc";
 		compatible = "ibm,cpc-440gp";
 		dcr-reg = <0b0 003 0e0 010>;
 		// FIXME: anything else?
 	};
 
 	plb {
-		device_type = "ibm,plb";
 		compatible = "ibm,plb-440gp", "ibm,plb4";
 		#address-cells = <2>;
 		#size-cells = <1>;
@@ -86,21 +82,24 @@
 		clock-frequency = <0>; // Filled in by zImage
 
 		SDRAM0: sdram {
-			device_type = "memory-controller";
 			compatible = "ibm,sdram-440gp", "ibm,sdram";
 			dcr-reg = <010 2>;
 			// FIXME: anything else?
 		};
 
+		SRAM0: sram {
+			compatible = "ibm,sram440gp";
+			dcr-reg = <020 8 00a 1>;
+		};
+
 		DMA0: dma {
 			// FIXME: ???
-			device_type = "ibm,dma-4xx";
 			compatible = "ibm,dma-440gp", "ibm,dma-4xx";
 			dcr-reg = <100 027>;
 		};
 
 		MAL0: mcmal {
-			device_type = "mcmal-dma";
+			device_type = "dma-controller";
 			compatible = "ibm,mcmal-440gp", "ibm,mcmal";
 			dcr-reg = <180 62>;
 			num-tx-chans = <4>;
@@ -119,7 +118,6 @@
 		};
 
 		POB0: opb {
-			device_type = "ibm,opb";
 			compatible = "ibm,opb-440gp", "ibm,opb";
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -133,7 +131,6 @@
 			clock-frequency = <0>; // Filled in by zImage
 
 			EBC0: ebc {
-				device_type = "ibm,ebc";
 				compatible = "ibm,ebc-440gp";
 				dcr-reg = <012 2>;
 				#address-cells = <2>;
@@ -147,7 +144,7 @@
 				interrupts = <5 4>;
 				interrupt-parent = <&UIC1>;
 
-				small-flash@0,0 {
+				small-flash@0,80000 {
 					device_type = "rom";
 					compatible = "direct-mapped";
 					probe-type = "JEDEC";
@@ -159,7 +156,6 @@
 
 				ds1743@1,0 {
 					/* NVRAM & RTC */
-					device_type = "nvram";
 					compatible = "ds1743";
 					reg = <1 0 2000>;
 				};
@@ -170,7 +166,7 @@
 					probe-type = "JEDEC";
 					bank-width = <1>;
 					partitions = <0 380000
-						      280000 80000>;
+						      380000 80000>;
 					partition-names = "fs", "firmware";
 					reg = <2 0 400000>;
 				};
@@ -226,13 +222,12 @@
 
 			GPIO0: gpio@40000700 {
 				/* FIXME */
-				device_type = "gpio";
 				compatible = "ibm,gpio-440gp";
 				reg = <40000700 20>;
 			};
 
 			ZMII0: emac-zmii@40000780 {
-				device_type = "emac-zmii";
+				device_type = "zmii-interface";
 				compatible = "ibm,zmii-440gp", "ibm,zmii";
 				reg = <40000780 c>;
 			};
@@ -299,9 +294,5 @@
 
 	chosen {
 		linux,stdout-path = "/plb/opb/serial@40000200";
-//		linux,initrd-start = <0>; /* FIXME */
-//		linux,initrd-end = <0>;
-//		bootargs = "";
 	};
 };
-
Index: working-2.6/arch/powerpc/platforms/44x/ebony.c
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/44x/ebony.c	2007-05-08 15:07:45.000000000 +1000
+++ working-2.6/arch/powerpc/platforms/44x/ebony.c	2007-05-14 14:37:51.000000000 +1000
@@ -27,9 +27,9 @@
 #include "44x.h"
 
 static struct of_device_id ebony_of_bus[] = {
-	{ .type = "ibm,plb", },
-	{ .type = "ibm,opb", },
-	{ .type = "ibm,ebc", },
+	{ .compatible = "ibm,plb", },
+	{ .compatible = "ibm,opb", },
+	{ .compatible = "ibm,ebc", },
 	{},
 };
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
