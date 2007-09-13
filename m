Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 169CBDDFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 07:08:21 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/22] [POWERPC] linkstation updates
Date: Thu, 13 Sep 2007 16:07:43 -0500
Message-Id: <1189717687832-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11897176851400-git-send-email-galak@kernel.crashing.org>
References: <11897176803590-git-send-email-galak@kernel.crashing.org>
	<1189717681533-git-send-email-galak@kernel.crashing.org>
	<1189717683471-git-send-email-galak@kernel.crashing.org>
	<11897176841013-git-send-email-galak@kernel.crashing.org>
	<11897176851400-git-send-email-galak@kernel.crashing.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

1. Fix RTC type - it is a rs5c372a, not rs5c372b
2. Configure both UART interrupts edge-triggered
3. Add a license header to ls_uart.c
4. Check for running on linkstation in a late_initcall() function. Needed
   for multiplatform builds, even though linkstation doesn't support them
   yet
5. Remove unneeded #include from linkstation.c

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/kuroboxHD.dts              |    4 ++--
 arch/powerpc/boot/dts/kuroboxHG.dts              |    4 ++--
 arch/powerpc/platforms/embedded6xx/linkstation.c |    1 -
 arch/powerpc/platforms/embedded6xx/ls_uart.c     |   14 ++++++++++++++
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/dts/kuroboxHD.dts b/arch/powerpc/boot/dts/kuroboxHD.dts
index b0eeff0..a7b3714 100644
--- a/arch/powerpc/boot/dts/kuroboxHD.dts
+++ b/arch/powerpc/boot/dts/kuroboxHD.dts
@@ -69,7 +69,7 @@ XXXX add flash parts, rtc, ??
 
 			rtc@32 {
 				device_type = "rtc";
-				compatible = "ricoh,rs5c372b";
+				compatible = "ricoh,rs5c372a";
 				reg = <32>;
 			};
 		};
@@ -80,7 +80,7 @@ XXXX add flash parts, rtc, ??
 			reg = <80004500 8>;
 			clock-frequency = <5d08d88>;
 			current-speed = <2580>;
-			interrupts = <9 2>;
+			interrupts = <9 0>;
 			interrupt-parent = <&mpic>;
 		};
 
diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts b/arch/powerpc/boot/dts/kuroboxHG.dts
index ccd15a2..a0007b9 100644
--- a/arch/powerpc/boot/dts/kuroboxHG.dts
+++ b/arch/powerpc/boot/dts/kuroboxHG.dts
@@ -69,7 +69,7 @@ XXXX add flash parts, rtc, ??
 
 			rtc@32 {
 				device_type = "rtc";
-				compatible = "ricoh,rs5c372b";
+				compatible = "ricoh,rs5c372a";
 				reg = <32>;
 			};
 		};
@@ -80,7 +80,7 @@ XXXX add flash parts, rtc, ??
 			reg = <80004500 8>;
 			clock-frequency = <7c044a8>;
 			current-speed = <2580>;
-			interrupts = <9 2>;
+			interrupts = <9 0>;
 			interrupt-parent = <&mpic>;
 		};
 
diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index 61ca02c..f392374 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/pci.h>
 #include <linux/initrd.h>
 #include <linux/mtd/physmap.h>
 
diff --git a/arch/powerpc/platforms/embedded6xx/ls_uart.c b/arch/powerpc/platforms/embedded6xx/ls_uart.c
index 0d9f150..c99264c 100644
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
-- 
1.5.2.4
