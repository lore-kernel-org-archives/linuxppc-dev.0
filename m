Return-Path: <shawnxjin@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.201])
	by ozlabs.org (Postfix) with ESMTP id F22EF67A70
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Feb 2005 05:46:49 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id 1so111826rny
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Feb 2005 10:46:15 -0800 (PST)
Message-ID: <c3d0340b05022310396240c8ac@mail.gmail.com>
Date: Wed, 23 Feb 2005 10:39:34 -0800
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_457_21317652.1109183974725"
Subject: [PATCH] Ebony's UBoot awareness
Reply-To: Shawn Jin <shawnxjin@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_457_21317652.1109183974725
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This adds UBoot support on Ebony board and also sets emac's PHY mode
explicitly during initialization as Eugene Surovegin provided.

Regards,
-Shawn.

------=_Part_457_21317652.1109183974725
Content-Type: text/plain; name="ebony-emac.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="ebony-emac.diff"

diff -Nur orig/linux-2.6.10/arch/ppc/platforms/4xx/ebony.c code/linux-2.6.1=
0/arch/ppc/platforms/4xx/ebony.c
--- orig/linux-2.6.10/arch/ppc/platforms/4xx/ebony.c=092004-12-24 13:35:40.=
000000000 -0800
+++ code/linux-2.6.10/arch/ppc/platforms/4xx/ebony.c=092005-02-23 10:05:32.=
043954000 -0800
@@ -49,10 +49,14 @@
 #include <asm/todc.h>
 #include <asm/bootinfo.h>
 #include <asm/ppc4xx_pic.h>
+#include <asm/ppcboot.h>
=20
 #include <syslib/gen550.h>
=20
+#include "../../../../drivers/net/ibm_emac/ibm_emac_phy.h"
+
 static struct ibm44x_clocks clocks __initdata;
+bd_t __res;
=20
 /*
  * Ebony IRQ triggering/polarity settings
@@ -182,6 +186,41 @@
 =09(writel(value, (u32)pcix_reg_base+offset))
=20
 /*
+ * Set mac address for each EMAC
+ * If uboot sets MAC addresses for each EMAC, use them.
+ * Otherwise fetch from Ebony VPD.
+ *
+ */
+static void __init
+ebony_set_emacdata(void)
+{
+=09unsigned char * vpd_base;
+=09struct ocp_def *def;
+=09struct ocp_func_emac_data *emacdata;
+
+=09vpd_base =3D ioremap64(EBONY_VPD_BASE, EBONY_VPD_SIZE);
+
+=09def =3D ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 0);
+=09emacdata =3D def->additions;
+=09emacdata->phy_mode =3D PHY_MODE_RMII;
+=09if (!strncmp(__res.bi_enetaddr, "\0xFF\0xFF\0xFF\0xFF\0xFF\0xFF", 6))
+=09  =09memcpy(emacdata->mac_addr, __res.bi_enetaddr, 6);
+=09else
+=09=09memcpy(emacdata->mac_addr, EBONY_NA0_ADDR(vpd_base), 6);
+
+=09def =3D ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 1);
+=09emacdata =3D def->additions;
+=09emacdata->phy_mode =3D PHY_MODE_RMII;
+=09if (!strncmp(__res.bi_enet1addr, "\0xFF\0xFF\0xFF\0xFF\0xFF\0xFF", 6))
+=09  =09memcpy(emacdata->mac_addr, __res.bi_enet1addr, 6);
+=09else
+=09=09memcpy(emacdata->mac_addr, EBONY_NA1_ADDR(vpd_base), 6);
+
+=09iounmap(vpd_base);
+
+}
+
+/*
  * FIXME: This is only here to "make it work".  This will move
  * to a ibm_pcix.c which will contain a generic IBM PCIX bridge
  * configuration library. -Matt
@@ -309,19 +348,7 @@
 static void __init
 ebony_setup_arch(void)
 {
-=09unsigned char * vpd_base;
-=09struct ocp_def *def;
-=09struct ocp_func_emac_data *emacdata;
-
-=09/* Set mac_addr for each EMAC */
-=09vpd_base =3D ioremap64(EBONY_VPD_BASE, EBONY_VPD_SIZE);
-=09def =3D ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 0);
-=09emacdata =3D def->additions;
-=09memcpy(emacdata->mac_addr, EBONY_NA0_ADDR(vpd_base), 6);
-=09def =3D ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 1);
-=09emacdata =3D def->additions;
-=09memcpy(emacdata->mac_addr, EBONY_NA1_ADDR(vpd_base), 6);
-=09iounmap(vpd_base);
+  =09ebony_set_emacdata();
=20
 =09/*
 =09 * Determine various clocks.
@@ -368,7 +395,20 @@
 void __init platform_init(unsigned long r3, unsigned long r4,
 =09=09unsigned long r5, unsigned long r6, unsigned long r7)
 {
-=09parse_bootinfo((struct bi_record *) (r3 + KERNELBASE));
+=09parse_bootinfo(find_bootinfo());
+
+=09/*
+=09 * If we were passed in a board information, copy it into the
+=09 * residual data area.
+=09 */
+=09if (r3)
+=09=09__res =3D *(bd_t *)(r3 + KERNELBASE);
+
+=09/* Copy the kernel command line arguments to a safe place. */
+=09if (r6) {
+=09=09*(char *) (r7 + KERNELBASE) =3D 0;
+=09=09strcpy(cmd_line, (char *) (r6 + KERNELBASE));
+=09}
=20
 =09ibm44x_platform_init();
=20

------=_Part_457_21317652.1109183974725--
