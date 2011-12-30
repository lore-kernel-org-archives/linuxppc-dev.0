Return-Path: <R64188@freescale.com>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 5A51FB6FBD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Dec 2011 04:45:54 +1100 (EST)
From: Jason Jin <Jason.jin@freescale.com>
To: <tiejun.chen@windriver.com>, <kexin.hao@windriver.com>,
 <Bo.Liu@windriver.com>
Subject: [PATCH 82/94] USB: ehci-fsl: Fix 'have_sysif_regs' detection
Date: Sat, 31 Dec 2011 00:51:38 +0800
Message-ID: <1325263910-14057-83-git-send-email-Jason.jin@freescale.com>
In-Reply-To: <1325263910-14057-1-git-send-email-Jason.jin@freescale.com>
References: <1325263910-14057-1-git-send-email-Jason.jin@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: b14898@freescale.com, David Brownell <dbrownell@users.sourceforge.net>,
 Pan Jiafei <Jiafei.Pan@freescale.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, b37022@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Pan Jiafei <Jiafei.Pan@freescale.com>

extract from vendor drop QorIQ-DPAA-SDK-20111026-systembuilder.iso

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
Integrated-by: Pan Jiafei <Jiafei.Pan@freescale.com>
---
 drivers/usb/host/ehci-fsl.c      |   13 -------------
 drivers/usb/host/ehci-fsl.h      |    3 ---
 drivers/usb/host/fsl-mph-dr-of.c |   11 ++++++++---
 3 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index ac5f38d..22baaec 100644
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
1.7.5.1
