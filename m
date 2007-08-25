Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 702C5DDE09
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Aug 2007 08:08:10 +1000 (EST)
Date: Sun, 26 Aug 2007 00:08:11 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: linkstation updates
Message-ID: <Pine.LNX.4.60.0708252358440.3809@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

1. Fix RTC type - it is a rs5c372a, not rs5c372b
2. Configure both UART interrupts edge-triggered
3. Add a license header to ls_uart.c
4. Check for running on linkstation in a late_initcall() function. Needed 
   for multiplatform builds, even though linkstation doesn't support them 
   yet
5. Remove unneeded #include from linkstation.c

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

---

Nothing critical - just queue this for .24, please.

Thanks
Guennadi

 boot/dts/kuroboxHD.dts              |    4 ++--
 boot/dts/kuroboxHG.dts              |    4 ++--
 platforms/embedded6xx/linkstation.c |    1 -
 platforms/embedded6xx/ls_uart.c     |   14 ++++++++++++++
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/dts/kuroboxHD.dts b/arch/powerpc/boot/dts/kuroboxHD.dts
index 1225374..63ba351 100644
--- a/arch/powerpc/boot/dts/kuroboxHD.dts
+++ b/arch/powerpc/boot/dts/kuroboxHD.dts
@@ -72,7 +72,7 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHD.dtb -V 16 kuroboxHD.dts"
 
 			rtc@32 {
 				device_type = "rtc";
-				compatible = "ricoh,rs5c372b";
+				compatible = "ricoh,rs5c372a";
 				reg = <32>;
 			};
 		};
@@ -83,7 +83,7 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHD.dtb -V 16 kuroboxHD.dts"
 			reg = <80004500 8>;
 			clock-frequency = <5d08d88>;
 			current-speed = <2580>;
-			interrupts = <9 2>;
+			interrupts = <9 0>;
 			interrupt-parent = <&mpic>;
 		};
 
diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts b/arch/powerpc/boot/dts/kuroboxHG.dts
index 579aa8b..e8ce0e3 100644
--- a/arch/powerpc/boot/dts/kuroboxHG.dts
+++ b/arch/powerpc/boot/dts/kuroboxHG.dts
@@ -72,7 +72,7 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHG.dtb -V 16 kuroboxHG.dts"
 
 			rtc@32 {
 				device_type = "rtc";
-				compatible = "ricoh,rs5c372b";
+				compatible = "ricoh,rs5c372a";
 				reg = <32>;
 			};
 		};
@@ -83,7 +83,7 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHG.dtb -V 16 kuroboxHG.dts"
 			reg = <80004500 8>;
 			clock-frequency = <7c044a8>;
 			current-speed = <2580>;
-			interrupts = <9 2>;
+			interrupts = <9 0>;
 			interrupt-parent = <&mpic>;
 		};
 
diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index ab9e3f9..8ee0f0b 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/pci.h>
 #include <linux/initrd.h>
 #include <linux/mtd/physmap.h>
 
diff --git a/arch/powerpc/platforms/embedded6xx/ls_uart.c b/arch/powerpc/platforms/embedded6xx/ls_uart.c
index d0bee9f..0729641 100644
--- a/arch/powerpc/platforms/embedded6xx/ls_uart.c
+++ b/arch/powerpc/platforms/embedded6xx/ls_uart.c
@@ -1,3 +1,14 @@
+/*
+ * AVR power-management chip interface for the Buffalo Linkstation /
+ * Kurobox Platform.
+ *
+ * Author: 2006 (c) G. Liakhovetski
+ *	 g.liakhovetski@gmx.de
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of
+ * any kind, whether express or implied.
+ */
 #include <linux/workqueue.h>
 #include <linux/string.h>
 #include <linux/delay.h>
@@ -106,6 +117,9 @@ static int __init ls_uarts_init(void)
 	phys_addr_t phys_addr;
 	int len;
 
+	if (!machine_is(linkstation))
+		return 0;
+
 	avr = of_find_node_by_path("/soc10x/serial@80004500");
 	if (!avr)
 		return -EINVAL;
