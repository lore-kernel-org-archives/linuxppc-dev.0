Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 845BF67A71
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Mar 2005 19:21:11 +1100 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
Date: Tue, 1 Mar 2005 09:21:06 +0100
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200503010921.06854.g.jaeger@sysgo.com>
Subject: [PATCH][PPC32] OpenBios support for Ebony
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

this patch adds support for OpenBios on Ebony, as Matt Porter has suggested.
It will provide same functionality as the pibs extension for Luan and
Ocotea.

Signed-off-by: Gerhard Jaeger <gjaeger@sysgo.com>

diff -purN linux-2.6.11-rc5/arch/ppc/boot/simple/Makefile linux-2.6.11-rc5.ob/arch/ppc/boot/simple/Makefile
--- linux-2.6.11-rc5/arch/ppc/boot/simple/Makefile	2005-02-24 17:39:46.000000000 +0100
+++ linux-2.6.11-rc5.ob/arch/ppc/boot/simple/Makefile	2005-02-28 16:40:26.000000000 +0100
@@ -65,6 +65,7 @@ zimageinitrd-$(CONFIG_IBM_OPENBIOS)	:= z
 zimageinitrd-$(CONFIG_EBONY)		:= zImage.initrd-TREE
          end-$(CONFIG_EBONY)		:= ebony
   entrypoint-$(CONFIG_EBONY)		:= 0x01000000
+     extra.o-$(CONFIG_EBONY)		:= openbios.o
 
       zimage-$(CONFIG_LUAN)		:= zImage-TREE
 zimageinitrd-$(CONFIG_LUAN)		:= zImage.initrd-TREE
diff -purN linux-2.6.11-rc5/arch/ppc/boot/simple/openbios.c linux-2.6.11-rc5.ob/arch/ppc/boot/simple/openbios.c
--- linux-2.6.11-rc5/arch/ppc/boot/simple/openbios.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc5.ob/arch/ppc/boot/simple/openbios.c	2005-02-28 16:41:15.000000000 +0100
@@ -0,0 +1,37 @@
+/*
+ * arch/ppc/boot/simple/openbios.c
+ *
+ * 2005 (c) SYSGO AG - g.jaeger@sysgo.com
+ * This file is licensed under the terms of the GNU General Public 
+ * License version 2.  This program is licensed "as is" without 
+ * any warranty of any kind, whether express or implied.
+ *
+ * Derived from arch/ppc/boot/simple/pibs.c (from MontaVista)
+ */
+
+#include <linux/types.h>
+#include <linux/config.h>
+#include <linux/string.h>
+#include <asm/ppcboot.h>
+#include <platforms/4xx/ebony.h>
+
+extern unsigned long decompress_kernel(unsigned long load_addr, int num_words,
+				       unsigned long cksum);
+
+/* We need to make sure that this is before the images to ensure
+ * that it's in a mapped location. */
+bd_t hold_resid_buf __attribute__ ((__section__ (".data.boot")));
+bd_t *hold_residual = &hold_resid_buf;
+
+void *
+load_kernel(unsigned long load_addr, int num_words, unsigned long cksum,
+		void *ign1, void *ign2)
+{
+	decompress_kernel(load_addr, num_words, cksum);
+
+	/* simply copy the MAC addresses */
+	memcpy(hold_residual->bi_enetaddr,  (char *)EBONY_OPENBIOS_MAC_BASE, 6);
+	memcpy(hold_residual->bi_enet1addr, (char *)(EBONY_OPENBIOS_MAC_BASE+EBONY_OPENBIOS_MAC_OFFSET), 6);
+
+	return (void *)hold_residual;
+}
diff -purN linux-2.6.11-rc5/arch/ppc/platforms/4xx/ebony.c linux-2.6.11-rc5.ob/arch/ppc/platforms/4xx/ebony.c
--- linux-2.6.11-rc5/arch/ppc/platforms/4xx/ebony.c	2005-02-24 17:40:47.000000000 +0100
+++ linux-2.6.11-rc5.ob/arch/ppc/platforms/4xx/ebony.c	2005-02-28 16:05:15.000000000 +0100
@@ -49,8 +49,19 @@
 #include <asm/todc.h>
 #include <asm/bootinfo.h>
 #include <asm/ppc4xx_pic.h>
+#include <asm/ppcboot.h>
 
 #include <syslib/gen550.h>
+#include <syslib/ibm440gp_common.h>
+
+/*
+ * This is a horrible kludge, we eventually need to abstract this
+ * generic PHY stuff, so the  standard phy mode defines can be
+ * easily used from arch code.
+ */
+#include "../../../../drivers/net/ibm_emac/ibm_emac_phy.h"
+
+bd_t __res;
 
 static struct ibm44x_clocks clocks __initdata;
 
@@ -258,19 +269,21 @@ ebony_early_serial_map(void)
 static void __init
 ebony_setup_arch(void)
 {
-	unsigned char * vpd_base;
 	struct ocp_def *def;
 	struct ocp_func_emac_data *emacdata;
 
 	/* Set mac_addr for each EMAC */
-	vpd_base = ioremap64(EBONY_VPD_BASE, EBONY_VPD_SIZE);
 	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 0);
 	emacdata = def->additions;
-	memcpy(emacdata->mac_addr, EBONY_NA0_ADDR(vpd_base), 6);
+	emacdata->phy_map = 0x00000001;	/* Skip 0x00 */
+	emacdata->phy_mode = PHY_MODE_RMII;
+	memcpy(emacdata->mac_addr, __res.bi_enetaddr, 6);
+
 	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 1);
 	emacdata = def->additions;
-	memcpy(emacdata->mac_addr, EBONY_NA1_ADDR(vpd_base), 6);
-	iounmap(vpd_base);
+	emacdata->phy_map = 0x00000001;	/* Skip 0x00 */
+	emacdata->phy_mode = PHY_MODE_RMII;
+	memcpy(emacdata->mac_addr, __res.bi_enet1addr, 6);
 
 	/*
 	 * Determine various clocks.
@@ -314,7 +327,14 @@ ebony_setup_arch(void)
 void __init platform_init(unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, unsigned long r7)
 {
-	parse_bootinfo((struct bi_record *) (r3 + KERNELBASE));
+	parse_bootinfo(find_bootinfo());
+
+	/*
+	 * If we were passed in a board information, copy it into the
+	 * residual data area.
+	 */
+	if (r3)
+		__res = *(bd_t *)(r3 + KERNELBASE);
 
 	ibm44x_platform_init();
 
diff -purN linux-2.6.11-rc5/arch/ppc/platforms/4xx/ebony.h linux-2.6.11-rc5.ob/arch/ppc/platforms/4xx/ebony.h
--- linux-2.6.11-rc5/arch/ppc/platforms/4xx/ebony.h	2005-02-28 17:08:51.000000000 +0100
+++ linux-2.6.11-rc5.ob/arch/ppc/platforms/4xx/ebony.h	2005-02-28 16:33:46.000000000 +0100
@@ -23,13 +23,9 @@
 /* F/W TLB mapping used in bootloader glue to reset EMAC */
 #define PPC44x_EMAC0_MR0	0xE0000800
 
-/* Macros to get at Ebony VPD info */
-#define EBONY_VPD_BASE		0x00000001fffffe00ULL
-#define EBONY_VPD_SIZE		0x24
-#define EBONY_NA0_OFFSET	0x0c
-#define EBONY_NA1_OFFSET	0x18
-#define EBONY_NA0_ADDR(base)	(base + EBONY_NA0_OFFSET)
-#define EBONY_NA1_ADDR(base)	(base + EBONY_NA1_OFFSET)
+/* Where to find the MAC info */
+#define EBONY_OPENBIOS_MAC_BASE   0xfffffe0c
+#define EBONY_OPENBIOS_MAC_OFFSET 0x0c
 
 /* Default clock rates for Rev. B and Rev. C silicon */
 #define EBONY_440GP_RB_SYSCLK	33000000
