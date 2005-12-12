Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 30ADA688F3
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2005 13:15:10 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 13:13:24 +1100
Message-Id: <1134353605.6989.69.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Fix clock spreading setting on some powermacs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The code that sets the clock spreading feature of the Intrepid ASIC
must not be run on some machine models or those won't boot. This
fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This is 2.6.15 material.


Index: linux-work/arch/powerpc/platforms/powermac/feature.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/feature.c	2005-11-19 10:56:07.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/feature.c	2005-12-12 12:17:02.000000000 +1100
@@ -1650,11 +1650,19 @@
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
+			printk(KERN_INFO "%sabling clock spreading on Intrepid"
+			       " ASIC\n", enable ? "En" : "Dis");
+			if (enable)
+				UN_OUT(UNI_N_CLOCK_SPREADING, 2);
+			else
+				UN_OUT(UNI_N_CLOCK_SPREADING, 0);
+			mdelay(40);
+		}
+		of_node_put(clock);
 	}
 
 	while (machine_is_compatible("PowerBook5,2") ||
@@ -1724,6 +1732,9 @@
 			pmac_low_i2c_close(ui2c);
 			break;
 		}
+		printk(KERN_INFO "%sabling clock spreading on i2c clock chip\n",
+		       enable ? "En" : "Dis");
+
 		pmac_low_i2c_setmode(ui2c, pmac_low_i2c_mode_stdsub);
 		rc = pmac_low_i2c_xfer(ui2c, 0xd2 | pmac_low_i2c_write, 0x80, buffer, 9);
 		DBG("write result: %d,", rc);
Index: linux-work/arch/ppc/platforms/pmac_feature.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_feature.c	2005-11-14 20:32:16.000000000 +1100
+++ linux-work/arch/ppc/platforms/pmac_feature.c	2005-12-12 12:16:38.000000000 +1100
@@ -1606,11 +1606,19 @@
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
+			printk(KERN_INFO "%sabling clock spreading on Intrepid"
+			       " ASIC\n", enable ? "En" : "Dis");
+			if (enable)
+				UN_OUT(UNI_N_CLOCK_SPREADING, 2);
+			else
+				UN_OUT(UNI_N_CLOCK_SPREADING, 0);
+			mdelay(40);
+		}
+		of_node_put(clock);
 	}
 
 	while (machine_is_compatible("PowerBook5,2") ||
@@ -1680,6 +1688,8 @@
 			pmac_low_i2c_close(ui2c);
 			break;
 		}
+		printk(KERN_INFO "%sabling clock spreading on i2c clock chip\n",
+		       enable ? "En" : "Dis");
 		pmac_low_i2c_setmode(ui2c, pmac_low_i2c_mode_stdsub);
 		rc = pmac_low_i2c_xfer(ui2c, 0xd2 | pmac_low_i2c_write, 0x80, buffer, 9);
 		DBG("write result: %d,", rc);
