Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EF6ECDDDF4
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 04:13:08 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	lADHD3PM007555
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 10:13:04 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lADHD3Tq003620
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 11:13:03 -0600 (CST)
Subject: [PATCH] POWERPC: Clean out asm/of_{platform, device}.h
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1194973983.12888.17.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Tue, 13 Nov 2007 11:13:03 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Convert #include of asm/of_{platform, device}.h into
linux/of_{platform,device}.h for a few scattered platforms.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/platforms/embedded6xx/holly.c |    2 +-
 arch/powerpc/platforms/pasemi/gpio_mdio.c  |    2 +-
 arch/powerpc/platforms/pasemi/setup.c      |    2 +-
 arch/powerpc/platforms/powermac/setup.c    |    4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index b6de2b5..ce91787 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -26,6 +26,7 @@
 #include <linux/serial.h>
 #include <linux/tty.h>
 #include <linux/serial_core.h>
+#include <linux/of_platform.h>
 
 #include <asm/system.h>
 #include <asm/time.h>
@@ -39,7 +40,6 @@
 #include <asm/tsi108_irq.h>
 #include <asm/tsi108_pci.h>
 #include <asm/mpic.h>
-#include <asm/of_platform.h>
 
 #undef DEBUG
 
diff --git a/arch/powerpc/platforms/pasemi/gpio_mdio.c b/arch/powerpc/platforms/pasemi/gpio_mdio.c
index dae9f65..33409a2 100644
--- a/arch/powerpc/platforms/pasemi/gpio_mdio.c
+++ b/arch/powerpc/platforms/pasemi/gpio_mdio.c
@@ -30,7 +30,7 @@
 #include <linux/interrupt.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
-#include <asm/of_platform.h>
+#include <linux/of_platform.h>
 
 #define DELAY 1
 
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 3a5d112..a4e6b53 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -27,6 +27,7 @@
 #include <linux/delay.h>
 #include <linux/console.h>
 #include <linux/pci.h>
+#include <linux/of_platform.h>
 
 #include <asm/prom.h>
 #include <asm/system.h>
@@ -35,7 +36,6 @@
 #include <asm/mpic.h>
 #include <asm/smp.h>
 #include <asm/time.h>
-#include <asm/of_platform.h>
 
 #include <pcmcia/ss.h>
 #include <pcmcia/cistpl.h>
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 02c5330..3acb59d 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -51,6 +51,8 @@
 #include <linux/root_dev.h>
 #include <linux/bitops.h>
 #include <linux/suspend.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
 
 #include <asm/reg.h>
 #include <asm/sections.h>
@@ -68,8 +70,6 @@
 #include <asm/btext.h>
 #include <asm/pmac_feature.h>
 #include <asm/time.h>
-#include <asm/of_device.h>
-#include <asm/of_platform.h>
 #include <asm/mmu_context.h>
 #include <asm/iommu.h>
 #include <asm/smu.h>
-- 
1.5.3
