Return-Path: <dogoil@etinsys.com>
Received: from jupiter.etinsys.com (unknown [220.76.45.3])
	by ozlabs.org (Postfix) with ESMTP id 17CC0DDE02
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 16:31:23 +1100 (EST)
Received: from smkim (dogoil.etinsys.com [220.76.45.33])
	by jupiter.etinsys.com (8.13.8/8.13.8) with ESMTP id l0F5VWXJ004760
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 14:31:32 +0900 (KST)
Message-Id: <200701150531.l0F5VWXJ004760@jupiter.etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: <linuxppc-dev@ozlabs.org>
Subject: RE: [PATCH] kvme080 board support patch
Date: Mon, 15 Jan 2007 14:31:08 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200701120145.l0C1jc1x019343@jupiter.etinsys.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

This patch makes kvme080 board use hardware watchdog timer to restart.
This is an incremental patch of
http://patchwork.ozlabs.org/linuxppc/patch?id=8898
and http://patchwork.ozlabs.org/linuxppc/patch?id=8937.

Regards,
Sangmoon Kim

Signed-off-by: Sangmoon Kim <dogoil@etinsys.com>

diff --git a/arch/powerpc/boot/dts/kvme080.dts
b/arch/powerpc/boot/dts/kvme080.dts
index 8628421..6c02f2d 100644
--- a/arch/powerpc/boot/dts/kvme080.dts
+++ b/arch/powerpc/boot/dts/kvme080.dts
@@ -162,6 +162,12 @@
 		reg = <ff000000 7fff0>;
 	};
 
+	watchdog@ff07fff7 {
+		device_type = "watchdog";
+		compatible = "ds155x_wdt";
+		reg = <ff07fff7 1>;
+	};
+
 	rtc@ff07fff8 {
 		device_type = "rtc";
 		reg = <ff07fff8 8>;
diff --git a/arch/powerpc/platforms/embedded6xx/kvme080.c
b/arch/powerpc/platforms/embedded6xx/kvme080.c
index 8da3464..fe06f03 100644
--- a/arch/powerpc/platforms/embedded6xx/kvme080.c
+++ b/arch/powerpc/platforms/embedded6xx/kvme080.c
@@ -23,6 +23,7 @@ #include <asm/mpic.h>
 
 static unsigned char *nvram_base = (unsigned char *)NULL;
 static ssize_t nvram_size = 0;
+static unsigned char *watchdog_base = (unsigned char *)NULL;
 
 static int __init
 kvme080_probe(void)
@@ -96,6 +97,15 @@ #endif
 		}
 	}
 
+	dnp = of_find_compatible_node(NULL, "watchdog", "ds155x_wdt");
+	if (dnp) {
+		prop = of_get_address(dnp, 0, &size, NULL);
+		paddr = (phys_addr_t)of_translate_address(dnp, prop);
+		if (paddr != (phys_addr_t)OF_BAD_ADDR) {
+			watchdog_base = ioremap(paddr, (ssize_t)
nvram_size);
+		}
+	}
+
 	printk(KERN_INFO "Etin Systems KVME080 Board\n");
 	printk(KERN_INFO "Port by Sangmoon Kim (dogoil@etinsys.com)\n");
 }
@@ -131,9 +141,10 @@ static void
 kvme080_restart(char *cmd)
 {
 	local_irq_disable();
-	mtspr(SPRN_SRR0, 0xfff00100);
-	mtspr(SPRN_SRR1, 0x00000000);
-	asm volatile("rfi");
+	if (watchdog_base)
+		writeb(0x84, watchdog_base);
+	for(;;);
+	/* NOTREACHED */
 }
 
 static void
