Return-Path: <ashish.kalra@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8003DB707C
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Jun 2009 22:48:13 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 165CFDDD0B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 22:48:11 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n5TClj9I005253
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 05:47:56 -0700 (MST)
Received: from zin33exm20.fsl.freescale.net (zin33exm20.ap.freescale.net
	[10.232.192.5])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n5TClhdc014701
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 07:47:44 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [PATCH] sata_fsl: hard and soft reset split
Date: Mon, 29 Jun 2009 18:17:42 +0530
Message-ID: <16444A0F3094A24C83EAB7836A12C63B24F994@zin33exm20.fsl.freescale.net>
From: "Kalra Ashish-B00888" <ashish.kalra@freescale.com>
To: <linux-ide@vger.kernel.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Split sata_fsl_softreset() into hard and soft resets to make
error-handling more efficient & device and PMP detection more reliable.

Also includes fix for PMP support, driver tested with Sil3726, Sil4726 &
Exar PMP controllers.

Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>
---
 drivers/ata/sata_fsl.c |   85
+++++++++++++++++++++++++-----------------------
 1 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 5751145..c8e2fad 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -708,34 +708,17 @@ static unsigned int sata_fsl_dev_classify(struct
ata_port *ap)
 	return ata_dev_classify(&tf);
 }
=20
-static int sata_fsl_prereset(struct ata_link *link, unsigned long
deadline)
-{
-	/* FIXME: Never skip softreset, sata_fsl_softreset() is
-	 * combination of soft and hard resets.  sata_fsl_softreset()
-	 * needs to be splitted into soft and hard resets.
-	 */
-	return 0;
-}
-
-static int sata_fsl_softreset(struct ata_link *link, unsigned int
*class,
+static int sata_fsl_hardreset(struct ata_link *link, unsigned int
*class,
 					unsigned long deadline)
 {
 	struct ata_port *ap =3D link->ap;
-	struct sata_fsl_port_priv *pp =3D ap->private_data;
 	struct sata_fsl_host_priv *host_priv =3D ap->host->private_data;
 	void __iomem *hcr_base =3D host_priv->hcr_base;
-	int pmp =3D sata_srst_pmp(link);
 	u32 temp;
-	struct ata_taskfile tf;
-	u8 *cfis;
-	u32 Serror;
 	int i =3D 0;
 	unsigned long start_jiffies;
=20
-	DPRINTK("in xx_softreset\n");
-
-	if (pmp !=3D SATA_PMP_CTRL_PORT)
-		goto issue_srst;
+	DPRINTK("in xx_hardreset\n");
=20
 try_offline_again:
 	/*
@@ -750,7 +733,7 @@ try_offline_again:
=20
 	if (temp & ONLINE) {
 		ata_port_printk(ap, KERN_ERR,
-				"Softreset failed, not off-lined %d\n",
i);
+				"Hardreset failed, not off-lined %d\n",
i);
=20
 		/*
 		 * Try to offline controller atleast twice
@@ -762,7 +745,7 @@ try_offline_again:
 			goto try_offline_again;
 	}
=20
-	DPRINTK("softreset, controller off-lined\n");
+	DPRINTK("hardreset, controller off-lined\n");
 	VPRINTK("HStatus =3D 0x%x\n", ioread32(hcr_base + HSTATUS));
 	VPRINTK("HControl =3D 0x%x\n", ioread32(hcr_base + HCONTROL));
=20
@@ -787,11 +770,11 @@ try_offline_again:
=20
 	if (!(temp & ONLINE)) {
 		ata_port_printk(ap, KERN_ERR,
-				"Softreset failed, not on-lined\n");
+				"Hardreset failed, not on-lined\n");
 		goto err;
 	}
=20
-	DPRINTK("softreset, controller off-lined & on-lined\n");
+	DPRINTK("hardreset, controller off-lined & on-lined\n");
 	VPRINTK("HStatus =3D 0x%x\n", ioread32(hcr_base + HSTATUS));
 	VPRINTK("HControl =3D 0x%x\n", ioread32(hcr_base + HCONTROL));
=20
@@ -807,7 +790,7 @@ try_offline_again:
 				"No Device OR PHYRDY change,Hstatus =3D
0x%x\n",
 				ioread32(hcr_base + HSTATUS));
 		*class =3D ATA_DEV_NONE;
-		goto out;
+		return 0;
 	}
=20
 	/*
@@ -820,11 +803,44 @@ try_offline_again:
 	if ((temp & 0xFF) !=3D 0x18) {
 		ata_port_printk(ap, KERN_WARNING, "No Signature
Update\n");
 		*class =3D ATA_DEV_NONE;
-		goto out;
+		goto do_followup_srst;
 	} else {
 		ata_port_printk(ap, KERN_INFO,
 				"Signature Update detected @ %d
msecs\n",
 				jiffies_to_msecs(jiffies -
start_jiffies));
+		*class =3D sata_fsl_dev_classify(ap);
+		return 0;
+	}
+
+do_followup_srst:
+	/*
+	 * request libATA to perform follow-up softreset
+	 */
+	return -EAGAIN;
+
+err:
+	return -EIO;
+}
+
+static int sata_fsl_softreset(struct ata_link *link, unsigned int
*class,
+					unsigned long deadline)
+{
+	struct ata_port *ap =3D link->ap;
+	struct sata_fsl_port_priv *pp =3D ap->private_data;
+	struct sata_fsl_host_priv *host_priv =3D ap->host->private_data;
+	void __iomem *hcr_base =3D host_priv->hcr_base;
+	int pmp =3D sata_srst_pmp(link);
+	u32 temp;
+	struct ata_taskfile tf;
+	u8 *cfis;
+	u32 Serror;
+
+	DPRINTK("in xx_softreset\n");
+
+	if (ata_link_offline(link)) {
+		DPRINTK("PHY reports no device\n");
+		*class =3D ATA_DEV_NONE;
+		return 0;
 	}
=20
 	/*
@@ -835,7 +851,6 @@ try_offline_again:
 	 * reached here, we can send a command to the target device
 	 */
=20
-issue_srst:
 	DPRINTK("Sending SRST/device reset\n");
=20
 	ata_tf_init(link->device, &tf);
@@ -861,6 +876,8 @@ issue_srst:
 		ioread32(CA + hcr_base), ioread32(CC + hcr_base));
=20
 	iowrite32(0xFFFF, CC + hcr_base);
+	if (pmp !=3D SATA_PMP_CTRL_PORT)
+		iowrite32(pmp, CQPMP + hcr_base);
 	iowrite32(1, CQ + hcr_base);
=20
 	temp =3D ata_wait_register(CQ + hcr_base, 0x1, 0x1, 1, 5000);
@@ -927,7 +944,6 @@ issue_srst:
 		VPRINTK("cereg =3D 0x%x\n", ioread32(hcr_base + CE));
 	}
=20
-out:
 	return 0;
=20
 err:
@@ -988,19 +1004,6 @@ static void sata_fsl_error_intr(struct ata_port
*ap)
 	if (hstatus & FATAL_ERROR_DECODE) {
 		ehi->err_mask |=3D AC_ERR_ATA_BUS;
 		ehi->action |=3D ATA_EH_SOFTRESET;
-
-		/*
-		 * Ignore serror in case of fatal errors as we always
want
-		 * to do a soft-reset of the FSL SATA controller.
Analyzing
-		 * serror may cause libata to schedule a hard-reset
action,
-		 * and hard-reset currently does not do controller
-		 * offline/online, causing command timeouts and leads to
an
-		 * un-recoverable state, hence make libATA ignore
-		 * autopsy in case of fatal errors.
-		 */
-
-		ehi->flags |=3D ATA_EHI_NO_AUTOPSY;
-
 		freeze =3D 1;
 	}
=20
@@ -1272,8 +1275,8 @@ static struct ata_port_operations sata_fsl_ops =3D =
{
=20
 	.freeze =3D sata_fsl_freeze,
 	.thaw =3D sata_fsl_thaw,
-	.prereset =3D sata_fsl_prereset,
 	.softreset =3D sata_fsl_softreset,
+	.hardreset =3D sata_fsl_hardreset,
 	.pmp_softreset =3D sata_fsl_softreset,
 	.error_handler =3D sata_fsl_error_handler,
 	.post_internal_cmd =3D sata_fsl_post_internal_cmd,
--=20
1.6.0
