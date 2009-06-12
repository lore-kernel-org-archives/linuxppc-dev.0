Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A81AEB71B6
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Jun 2009 03:57:14 +1000 (EST)
Received: from mail-px0-f199.google.com (mail-px0-f199.google.com
	[209.85.216.199]) by ozlabs.org (Postfix) with ESMTP id B02B1DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jun 2009 03:57:12 +1000 (EST)
Received: by pxi37 with SMTP id 37so305579pxi.17
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 10:57:11 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] fbdev/xilinxfb: Fix improper casting and tighen up probe path
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	benh@kernel.crashing.org, john.linn@xilinx.com
Date: Fri, 12 Jun 2009 11:57:06 -0600
Message-ID: <20090612175634.12827.12207.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

The xilinxfb driver is improperly casting a physical address to a
u32, and the probe routine isn't as straight forward as it could be.
(discovered by gcc spitting out warnings on most recent change to
xilinxfb driver).

This patch fixes the cast and simplifies the probe path.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

John, can you please test and verify this fix is correct?

Thanks,
g.

 drivers/video/xilinxfb.c |   59 ++++++++++++++++++----------------------------
 1 files changed, 23 insertions(+), 36 deletions(-)


diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 7a868bd..b68b331 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -124,7 +124,6 @@ struct xilinxfb_drvdata {
 						registers */
 
 	dcr_host_t      dcr_host;
-	unsigned int    dcr_start;
 	unsigned int    dcr_len;
 
 	void		*fb_virt;	/* virt. address of the frame buffer */
@@ -325,8 +324,8 @@ static int xilinxfb_assign(struct device *dev,
 					drvdata->regs);
 	}
 	/* Put a banner in the log (for DEBUG) */
-	dev_dbg(dev, "fb: phys=%p, virt=%p, size=%x\n",
-		(void *)drvdata->fb_phys, drvdata->fb_virt, fbsize);
+	dev_dbg(dev, "fb: phys=%llx, virt=%p, size=%x\n",
+		(unsigned long long)drvdata->fb_phys, drvdata->fb_virt, fbsize);
 
 	return 0;	/* success */
 
@@ -404,9 +403,7 @@ xilinxfb_of_probe(struct of_device *op, const struct of_device_id *match)
 	u32 tft_access;
 	struct xilinxfb_platform_data pdata;
 	struct resource res;
-	int size, rc;
-	int start = 0, len = 0;
-	dcr_host_t dcr_host;
+	int size, rc, start;
 	struct xilinxfb_drvdata *drvdata;
 
 	/* Copy with the default pdata (not a ptr reference!) */
@@ -414,35 +411,39 @@ xilinxfb_of_probe(struct of_device *op, const struct of_device_id *match)
 
 	dev_dbg(&op->dev, "xilinxfb_of_probe(%p, %p)\n", op, match);
 
+	/* Allocate the driver data region */
+	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata) {
+		dev_err(&op->dev, "Couldn't allocate device private record\n");
+		return -ENOMEM;
+	}
+
 	/*
 	 * To check whether the core is connected directly to DCR or PLB
 	 * interface and initialize the tft_access accordingly.
 	 */
 	p = (u32 *)of_get_property(op->node, "xlnx,dcr-splb-slave-if", NULL);
-
-	if (p)
-		tft_access = *p;
-	else
-		tft_access = 0;		/* For backward compatibility */
+	tft_access = p ? *p : 0;
 
 	/*
 	 * Fill the resource structure if its direct PLB interface
 	 * otherwise fill the dcr_host structure.
 	 */
 	if (tft_access) {
+		drvdata->flags |= PLB_ACCESS_FLAG;
 		rc = of_address_to_resource(op->node, 0, &res);
 		if (rc) {
 			dev_err(&op->dev, "invalid address\n");
-			return -ENODEV;
+			goto err;
 		}
-
 	} else {
+		res.start = 0;
 		start = dcr_resource_start(op->node, 0);
-		len = dcr_resource_len(op->node, 0);
-		dcr_host = dcr_map(op->node, start, len);
-		if (!DCR_MAP_OK(dcr_host)) {
-			dev_err(&op->dev, "invalid address\n");
-			return -ENODEV;
+		drvdata->dcr_len = dcr_resource_len(op->node, 0);
+		drvdata->dcr_host = dcr_map(op->node, start, drvdata->len);
+		if (!DCR_MAP_OK(drvdata->dcr_host)) {
+			dev_err(&op->dev, "invalid DCR address\n");
+			goto err;
 		}
 	}
 
@@ -467,26 +468,12 @@ xilinxfb_of_probe(struct of_device *op, const struct of_device_id *match)
 	if (of_find_property(op->node, "rotate-display", NULL))
 		pdata.rotate_screen = 1;
 
-	/* Allocate the driver data region */
-	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
-	if (!drvdata) {
-		dev_err(&op->dev, "Couldn't allocate device private record\n");
-		return -ENOMEM;
-	}
 	dev_set_drvdata(&op->dev, drvdata);
+	return xilinxfb_assign(&op->dev, drvdata, res.start, &pdata);
 
-	if (tft_access)
-		drvdata->flags |= PLB_ACCESS_FLAG;
-
-	/* Arguments are passed based on the interface */
-	if (drvdata->flags & PLB_ACCESS_FLAG) {
-		return xilinxfb_assign(&op->dev, drvdata, res.start, &pdata);
-	} else {
-		drvdata->dcr_start = start;
-		drvdata->dcr_len = len;
-		drvdata->dcr_host = dcr_host;
-		return xilinxfb_assign(&op->dev, drvdata, 0, &pdata);
-	}
+ err:
+	kfree(drvdata);
+	return -ENODEV;
 }
 
 static int __devexit xilinxfb_of_remove(struct of_device *op)
