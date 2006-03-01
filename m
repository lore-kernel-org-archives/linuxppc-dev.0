Return-Path: <wfarnsworth@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [63.81.120.158])
	by ozlabs.org (Postfix) with ESMTP id AD06A67A45
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Mar 2006 10:47:40 +1100 (EST)
Subject: Re: [PATCH 2/6] Add UIC settings for 440SP & Luan
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <1141256751.25761.19.camel@rhino.az.mvista.com>
References: <1141256113.25761.14.camel@rhino.az.mvista.com>
	<1141256751.25761.19.camel@rhino.az.mvista.com>
Content-Type: multipart/mixed; boundary="=-2NWzHiW2T9qzb7Fs2Jr/"
Message-Id: <1141256859.25758.22.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 01 Mar 2006 16:47:39 -0700
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-2NWzHiW2T9qzb7Fs2Jr/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This adds the necessary structures for the UIC polarity and triggering
on the 440SP & Luan.

-Wade

Signed off by: Wade Farnsworth <wfarnsworth@mvista.com>

--=-2NWzHiW2T9qzb7Fs2Jr/
Content-Disposition: attachment; filename=luan-uic.patch
Content-Type: text/x-patch; name=luan-uic.patch
Content-Transfer-Encoding: 7bit

diff --git a/arch/ppc/platforms/4xx/ibm440sp.c b/arch/ppc/platforms/4xx/ibm440sp.c
--- a/arch/ppc/platforms/4xx/ibm440sp.c
+++ b/arch/ppc/platforms/4xx/ibm440sp.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <platforms/4xx/ibm440sp.h>
 #include <asm/ocp.h>
+#include <asm/ppc4xx_pic.h>
 
 static struct ocp_func_emac_data ibm440sp_emac0_def = {
 	.rgmii_idx	= -1,		/* No RGMII */
@@ -129,3 +130,15 @@ struct ocp_def core_ocp[] = {
 	{ .vendor	= OCP_VENDOR_INVALID
 	}
 };
+
+/* Polarity and triggering settings for internal interrupt sources */
+struct ppc4xx_uic_settings ppc4xx_core_uic_cfg[] __initdata = {
+	{ .polarity     = 0xffffffff,
+	  .triggering   = 0x01084004,
+	  .ext_irq_mask = 0x00000000,
+	},
+	{ .polarity     = 0x7fff83ff,
+	  .triggering   = 0x00000000,
+	  .ext_irq_mask = 0x80007c00,   /* IRQ7 - IRQ9 */
+	},
+};
diff --git a/arch/ppc/platforms/4xx/luan.c b/arch/ppc/platforms/4xx/luan.c
--- a/arch/ppc/platforms/4xx/luan.c
+++ b/arch/ppc/platforms/4xx/luan.c
@@ -56,6 +56,18 @@ extern bd_t __res;
 
 static struct ibm44x_clocks clocks __initdata;
 
+/*
+ * Luan external IRQ triggering/polarity settings
+ */
+unsigned char ppc4xx_uic_ext_irq_cfg[] __initdata = {
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ0 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ1 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ2 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE), /* IRQ3 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE), /* IRQ4 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ5 */
+};
+
 static void __init
 luan_calibrate_decr(void)
 {

--=-2NWzHiW2T9qzb7Fs2Jr/--
