Return-Path: <mhench@engagenet.com>
Received: from owa.engagenet.com (unknown [66.195.150.24])
	by ozlabs.org (Postfix) with ESMTP id 48443DDF9E
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 04:39:28 +1100 (EST)
MIME-Version: 1.0
Subject: [[PATCH] corrected MPC8313 NAND fixes
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 19 Mar 2008 12:40:15 -0500
Message-ID: <6629C06B144F5C4098DFF95C4FF9DAF702BA1D11@mailsrv.engagenet.com>
From: "Mike Hench" <mhench@engagenet.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix a race condition in fsl_elbc_run_command
Fix incorrect usage of clearbits32 that bashed option register
Remove work around for bashed register

Signed-off-by: Mike Hench <mhench@elutions.com>

---

--- linux-2.6.25-rc5.orig/drivers/mtd/nand/fsl_elbc_nand.c
2008-03-10 00:22:27.000000000 -0500
+++ linux-2.6.25-rc5/drivers/mtd/nand/fsl_elbc_nand.c	2008-03-19
12:34:36.000000000 -0500
@@ -379,11 +379,11 @@ static int fsl_elbc_run_command(struct m
 	         in_be32(&lbc->fbar), in_be32(&lbc->fpar),
 	         in_be32(&lbc->fbcr), priv->bank);
=20
+	ctrl->irq_status =3D 0;
 	/* execute special operation */
 	out_be32(&lbc->lsor, priv->bank);
=20
 	/* wait for FCM complete flag or timeout */
-	ctrl->irq_status =3D 0;
 	wait_event_timeout(ctrl->irq_wait, ctrl->irq_status,
 	                   FCM_TIMEOUT_MSECS * HZ/1000);
 	ctrl->status =3D ctrl->irq_status;
@@ -861,7 +861,7 @@ static int fsl_elbc_chip_init_tail(struc
 	/* adjust Option Register and ECC to match Flash page size */
 	if (mtd->writesize =3D=3D 512) {
 		priv->page_size =3D 0;
-		clrbits32(&lbc->bank[priv->bank].or, ~OR_FCM_PGS);
+		clrbits32(&lbc->bank[priv->bank].or, OR_FCM_PGS);
 	} else if (mtd->writesize =3D=3D 2048) {
 		priv->page_size =3D 1;
 		setbits32(&lbc->bank[priv->bank].or, OR_FCM_PGS);
@@ -882,11 +882,6 @@ static int fsl_elbc_chip_init_tail(struc
 		return -1;
 	}
=20
-	/* The default u-boot configuration on MPC8313ERDB causes
errors;
-	 * more delay is needed.  This should be safe for other boards
-	 * as well.
-	 */
-	setbits32(&lbc->bank[priv->bank].or, 0x70);
 	return 0;
 }
