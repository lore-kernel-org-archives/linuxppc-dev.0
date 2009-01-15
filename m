Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id C3336DE12D
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 19:48:49 +1100 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id C2D161C01FBC
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 09:48:47 +0100 (CET)
Received: from lancy.denx.de (p4FF04F34.dip.t-dialin.net [79.240.79.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 50F1790215
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 09:48:47 +0100 (CET)
Message-ID: <496EF86D.3010708@grandegger.com>
Date: Thu, 15 Jan 2009 09:48:45 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] POWERPC: MPC52xx: add function to return ext. clock frequency
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the utility function mpc52xx_get_xtal_freq() to get
the frequency of the external oscillator clock connected to the pin
SYS_XTAL_IN. The MSCAN may us it as clock source. Unfortunately, this
value is not available from the FDT blob, but it can be determined
from the IPB frequency.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/include/asm/mpc52xx.h           |    1 
 arch/powerpc/platforms/52xx/mpc52xx_common.c |   37 +++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

Index: linux-2.6/arch/powerpc/include/asm/mpc52xx.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/mpc52xx.h
+++ linux-2.6/arch/powerpc/include/asm/mpc52xx.h
@@ -273,6 +273,7 @@ extern void mpc5200_setup_xlb_arbiter(vo
 extern void mpc52xx_declare_of_platform_devices(void);
 extern void mpc52xx_map_common_devices(void);
 extern int mpc52xx_set_psc_clkdiv(int psc_id, int clkdiv);
+extern unsigned int mpc52xx_get_xtal_freq(struct device_node *node);
 extern void mpc52xx_restart(char *cmd);
 
 /* mpc52xx_pic.c */
Index: linux-2.6/arch/powerpc/platforms/52xx/mpc52xx_common.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ linux-2.6/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -205,6 +205,43 @@ int mpc52xx_set_psc_clkdiv(int psc_id, i
 EXPORT_SYMBOL(mpc52xx_set_psc_clkdiv);
 
 /**
+ * mpc52xx_get_xtal_freq - Get SYS_XTAL_IN frequency for a device
+ *
+ * @node: device node
+ *
+ * Returns the frequency of the external oscillator clock connected
+ * to the SYS_XTAL_IN pin, or 0 if it cannot be determined.
+ */
+unsigned int mpc52xx_get_xtal_freq(struct device_node *node)
+{
+	u32 val;
+	unsigned int freq;
+
+	if (!mpc52xx_cdm)
+		return 0;
+
+	freq = mpc52xx_find_ipb_freq(node);
+	if (!freq)
+		return 0;
+
+	if (in_8(&mpc52xx_cdm->ipb_clk_sel) & 0x1)
+		freq *= 2;
+
+	val  = in_be32(&mpc52xx_cdm->rstcfg);
+	if (val & (1 << 5))
+		freq *= 8;
+	else
+		freq *= 4;
+	if (val & (1 << 6))
+		freq /= 12;
+	else
+		freq /= 16;
+
+	return freq;
+}
+EXPORT_SYMBOL(mpc52xx_get_xtal_freq);
+
+/**
  * mpc52xx_restart: ppc_md->restart hook for mpc5200 using the watchdog timer
  */
 void
