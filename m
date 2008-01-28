Return-Path: <bodonoghue@codehermit.ie>
Received: from lugano.hostireland.com (lugano.hostireland.com [67.192.77.34])
	by ozlabs.org (Postfix) with ESMTP id 3D815DDDE9
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 12:53:24 +1100 (EST)
Subject: PATCH[1/1] 8xx: Add clock-frequency to .dts brg entries
From: Bryan O'Donoghue <bodonoghue@codehermit.ie>
To: linuxppc-dev@ozlabs.org, scottwood@freescale.com
Content-Type: text/plain
Date: Mon, 28 Jan 2008 01:53:11 +0000
Message-Id: <1201485191.5537.55.camel@neuromancer.mindspace>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

cpm_uart_core has a dependency on fsl,cpm-brg/clock-frequency, this
means that a .dts that uses the cpm uart driver needs to supply a
clock-frequency entry for get_brgfreq to return a meaningful number.

Included is a patchset which adds the correct brgclk to the adder port -
@ 50Mhz and also adds an entry for mpc885ads - which I've noticed is
missing a clock-frequency entry.

Without an entry for clock-frequency in the .dts you'd get -1 as the
return value brgclk !

Signed-off-by: Bryan O'Donoghue <bodonoghue@codehermit.ie>
---

diff --git a/arch/powerpc/boot/dts/adder875-redboot.dts
b/arch/powerpc/boot/dts/adder875-redboot.dts
index 7c25d96..975f3d4 100644
--- a/arch/powerpc/boot/dts/adder875-redboot.dts
+++ b/arch/powerpc/boot/dts/adder875-redboot.dts
@@ -149,6 +149,7 @@
                                compatible = "fsl,mpc875-brg",
                                             "fsl,cpm1-brg",
                                             "fsl,cpm-brg";
+                               clock-frequency = <0x2faf080>;
                                reg = <0x9f0 0x10>;
                        };
 
diff --git a/arch/powerpc/boot/dts/adder875-uboot.dts
b/arch/powerpc/boot/dts/adder875-uboot.dts
index 605202f..18d6dd6 100644
--- a/arch/powerpc/boot/dts/adder875-uboot.dts
+++ b/arch/powerpc/boot/dts/adder875-uboot.dts
@@ -148,6 +148,7 @@
                                compatible = "fsl,mpc875-brg",
                                             "fsl,cpm1-brg",
                                             "fsl,cpm-brg";
+                               clock-frequency = <0x2faf080>;
                               reg = <0x9f0 0x10>;
                        };
 
diff --git a/arch/powerpc/boot/dts/mpc885ads.dts
b/arch/powerpc/boot/dts/mpc885ads.dts
index 8848e63..f2a437b 100644
--- a/arch/powerpc/boot/dts/mpc885ads.dts
+++ b/arch/powerpc/boot/dts/mpc885ads.dts
@@ -166,6 +166,7 @@
                                compatible = "fsl,mpc885-brg",
                                             "fsl,cpm1-brg",
                                             "fsl,cpm-brg";
+                               clock-frequency = <0>;
                                reg = <9f0 10>;
                        };
