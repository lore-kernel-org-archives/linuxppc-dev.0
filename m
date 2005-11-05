Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 345C7686A0
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  6 Nov 2005 07:01:27 +1100 (EST)
Date: Sat, 5 Nov 2005 13:03:32 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051105150332.GB6577@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32 8xx: MPC8xx PCMCIA update
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Paul,

The following patch updates the MPC8xx PCMCIA driver:

- Kconfig entry: dependency on 8xx
- Makefile: fix whitespace breakage
- m8xx_pcmcia.c:
	- asm/segment.h is gone
	- use generic PCMCIA suspend/resume methods

Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

diff -u ../git/linux-2.6/drivers/pcmcia/Kconfig linux-2.6-git-wednov02/drivers/pcmcia/Kconfig
--- ../git/linux-2.6/drivers/pcmcia/Kconfig	2005-11-01 07:58:24.000000000 -0600
+++ linux-2.6-git-wednov02/drivers/pcmcia/Kconfig	2005-11-03 05:52:05.000000000 -0600
@@ -156,7 +156,7 @@
 
 config PCMCIA_M8XX
         tristate "MPC8xx PCMCIA support"
-        depends on PCMCIA && PPC
+        depends on PCMCIA && PPC && 8xx 
         select PCCARD_NONSTATIC
         help
         Say Y here to include support for PowerPC 8xx series PCMCIA
diff -u ../git/linux-2.6/drivers/pcmcia/Makefile linux-2.6-git-wednov02/drivers/pcmcia/Makefile
--- ../git/linux-2.6/drivers/pcmcia/Makefile	2005-11-01 07:58:24.000000000 -0600
+++ linux-2.6-git-wednov02/drivers/pcmcia/Makefile	2005-11-03 05:50:16.000000000 -0600
@@ -25,7 +25,7 @@
 obj-$(CONFIG_I82365)				+= i82365.o
 obj-$(CONFIG_I82092)				+= i82092.o
 obj-$(CONFIG_TCIC)				+= tcic.o
-obj-$(CONFIG_PCMCIA_M8XX)                              += m8xx_pcmcia.o
+obj-$(CONFIG_PCMCIA_M8XX)			+= m8xx_pcmcia.o
 obj-$(CONFIG_HD64465_PCMCIA)			+= hd64465_ss.o
 obj-$(CONFIG_PCMCIA_SA1100)			+= sa11xx_core.o sa1100_cs.o
 obj-$(CONFIG_PCMCIA_SA1111)			+= sa11xx_core.o sa1111_cs.o
@@ -47,10 +47,10 @@
 au1x00_ss-$(CONFIG_MIPS_PB1500)			+= au1000_pb1x00.o
 au1x00_ss-$(CONFIG_MIPS_DB1000)			+= au1000_db1x00.o
 au1x00_ss-$(CONFIG_MIPS_DB1100)			+= au1000_db1x00.o
-au1x00_ss-$(CONFIG_MIPS_DB1200)                 += au1000_db1x00.o
+au1x00_ss-$(CONFIG_MIPS_DB1200)			+= au1000_db1x00.o
 au1x00_ss-$(CONFIG_MIPS_DB1500)			+= au1000_db1x00.o
 au1x00_ss-$(CONFIG_MIPS_DB1550)			+= au1000_db1x00.o
-au1x00_ss-$(CONFIG_MIPS_XXS1500)               += au1000_xxs1500.o
+au1x00_ss-$(CONFIG_MIPS_XXS1500)		+= au1000_xxs1500.o
 
 sa1111_cs-y					+= sa1111_generic.o
 sa1111_cs-$(CONFIG_ASSABET_NEPONSET)		+= sa1100_neponset.o
diff -u ../git/linux-2.6/drivers/pcmcia/m8xx_pcmcia.c linux-2.6-git-wednov02/drivers/pcmcia/m8xx_pcmcia.c
--- ../git/linux-2.6/drivers/pcmcia/m8xx_pcmcia.c	2005-11-01 07:58:24.000000000 -0600
+++ linux-2.6-git-wednov02/drivers/pcmcia/m8xx_pcmcia.c	2005-11-03 05:47:57.000000000 -0600
@@ -39,7 +39,6 @@
 
 #include <asm/io.h>
 #include <asm/bitops.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 
 #include <linux/kernel.h>
@@ -50,6 +49,7 @@
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
 
 #include <asm/mpc8xx.h>
 #include <asm/8xx_immap.h>
@@ -546,29 +546,11 @@
 	free_irq(pcmcia_schlvl, NULL);
 }
 
-/* copied from tcic.c */
-
-static int m8xx_drv_suspend(struct device *dev, pm_message_t state, u32 level)
-{
-        int ret = 0;
-        if (level == SUSPEND_SAVE_STATE)
-                ret = pcmcia_socket_dev_suspend(dev, state);
-        return ret;
-}
-
-static int m8xx_drv_resume(struct device *dev, u32 level)
-{
-        int ret = 0;
-        if (level == RESUME_RESTORE_STATE)
-                ret = pcmcia_socket_dev_resume(dev);
-        return ret;
-}
-
 static struct device_driver m8xx_driver = {
         .name = "m8xx-pcmcia",
         .bus = &platform_bus_type,
-        .suspend = m8xx_drv_suspend,
-        .resume = m8xx_drv_resume,
+        .suspend = pcmcia_socket_dev_suspend,
+        .resume = pcmcia_socket_dev_resume,
 };
 
 static struct platform_device m8xx_device = {
