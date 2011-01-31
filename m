Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D96CBB7102
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Feb 2011 05:14:00 +1100 (EST)
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-usb@vger.kernel.org
Subject: [PATCH 31/42] USB: ehci-fsl: Fix 'have_sysif_regs' detection
Date: Mon, 31 Jan 2011 10:12:56 -0800
Message-Id: <1296497587-16068-31-git-send-email-gregkh@suse.de>
In-Reply-To: <20110131181013.GA6949@kroah.com>
References: <20110131181013.GA6949@kroah.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>, Peter Tyser <ptyser@xes-inc.com>,
	Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Peter Tyser <ptyser@xes-inc.com>

Previously a check was done on an ID register at the base of a CPU's
internal USB registers to determine if system interface regsiters were
present.  The check looked for an ID register that had the format
ID[0:5] == ~ID[8:13] as described in the MPC5121 User's Manual to
determine if a MPC5121 or MPC83xx/85xx was being used.

There are two issues with this method:
- The ID register is not defined on the MPC83xx/85xx CPUs, so its
  unclear what is being checked on them.
- Newer CPUs such as the P4080 also don't document the ID register, but
  do share the same format as the MPC5121.  Thus the previous code did
  not set 'have_sysif_regs' properly which results in the P4080 not
  properly initializing its USB ports.

Using the device tree 'compatible' node is a cleaner way to determine if
'have_sysif_regs' should be set and resolves the USB initialization issue
seen on the P4080.

Tested on a P4080-based system and compile tested on mpc512x_defconfig
with Freescale EHCI driver enabled.

Cc: Anatolij Gustschin <agust@denx.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Peter Tyser <ptyser@xes-inc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/host/ehci-fsl.c      |   13 -------------
 drivers/usb/host/ehci-fsl.h      |    3 ---
 drivers/usb/host/fsl-mph-dr-of.c |   11 ++++++++---
 3 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 86e4289..5c761df 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -52,7 +52,6 @@ static int usb_hcd_fsl_probe(const struct hc_driver *driver,
 	struct resource *res;
 	int irq;
 	int retval;
-	unsigned int temp;
 
 	pr_debug("initializing FSL-SOC USB Controller\n");
 
@@ -126,18 +125,6 @@ static int usb_hcd_fsl_probe(const struct hc_driver *driver,
 		goto err3;
 	}
 
-	/*
-	 * Check if it is MPC5121 SoC, otherwise set pdata->have_sysif_regs
-	 * flag for 83xx or 8536 system interface registers.
-	 */
-	if (pdata->big_endian_mmio)
-		temp = in_be32(hcd->regs + FSL_SOC_USB_ID);
-	else
-		temp = in_le32(hcd->regs + FSL_SOC_USB_ID);
-
-	if ((temp & ID_MSK) != (~((temp & NID_MSK) >> 8) & ID_MSK))
-		pdata->have_sysif_regs = 1;
-
 	/* Enable USB controller, 83xx or 8536 */
 	if (pdata->have_sysif_regs)
 		setbits32(hcd->regs + FSL_SOC_USB_CTRL, 0x4);
diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
index 2c83537..3fabed3 100644
--- a/drivers/usb/host/ehci-fsl.h
+++ b/drivers/usb/host/ehci-fsl.h
@@ -19,9 +19,6 @@
 #define _EHCI_FSL_H
 
 /* offsets for the non-ehci registers in the FSL SOC USB controller */
-#define FSL_SOC_USB_ID		0x0
-#define ID_MSK			0x3f
-#define NID_MSK			0x3f00
 #define FSL_SOC_USB_ULPIVP	0x170
 #define FSL_SOC_USB_PORTSC1	0x184
 #define PORT_PTS_MSK		(3<<30)
diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index 574b99e..79a66d6 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -262,19 +262,24 @@ static void fsl_usb2_mpc5121_exit(struct platform_device *pdev)
 	}
 }
 
-struct fsl_usb2_platform_data fsl_usb2_mpc5121_pd = {
+static struct fsl_usb2_platform_data fsl_usb2_mpc5121_pd = {
 	.big_endian_desc = 1,
 	.big_endian_mmio = 1,
 	.es = 1,
+	.have_sysif_regs = 0,
 	.le_setup_buf = 1,
 	.init = fsl_usb2_mpc5121_init,
 	.exit = fsl_usb2_mpc5121_exit,
 };
 #endif /* CONFIG_PPC_MPC512x */
 
+static struct fsl_usb2_platform_data fsl_usb2_mpc8xxx_pd = {
+	.have_sysif_regs = 1,
+};
+
 static const struct of_device_id fsl_usb2_mph_dr_of_match[] = {
-	{ .compatible = "fsl-usb2-mph", },
-	{ .compatible = "fsl-usb2-dr", },
+	{ .compatible = "fsl-usb2-mph", .data = &fsl_usb2_mpc8xxx_pd, },
+	{ .compatible = "fsl-usb2-dr", .data = &fsl_usb2_mpc8xxx_pd, },
 #ifdef CONFIG_PPC_MPC512x
 	{ .compatible = "fsl,mpc5121-usb2-dr", .data = &fsl_usb2_mpc5121_pd, },
 #endif
-- 
1.7.1
