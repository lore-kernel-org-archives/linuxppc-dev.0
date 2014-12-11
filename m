Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0107.outbound.protection.outlook.com [157.56.110.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 672761A0027
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 11:56:53 +1100 (AEDT)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] memory/fsl-corenet-cf: Add t1040 support
Date: Wed, 10 Dec 2014 18:56:22 -0600
Message-ID: <1418259382-21697-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

T1040 has a different version of corenet-cf, despite being incorrectly
labelled with a fsl,corenet2-cf compatible.  The t1040 version of
corenet-cf has a version register that can be read to distinguish.  The
t4240/b4860 version officially does not, but testing shows that it does
and has a different value, so use that.  If somehow this ends up not
being reliable and we treat a t4240/b4860 as a t1040 (the reverse
should not happen, as t1040's version register is official), currently
the worst that should happen is writing to reserved bits to enable
events that don't exist.

The changes to the t1040 version of corenet-cf that this driver cares
about are the addition of two new error events.  There are also changes
to the format of cecar2, which is printed, but not interpreted, by this
driver.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 drivers/memory/fsl-corenet-cf.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/fsl-corenet-cf.c b/drivers/memory/fsl-corenet-cf.c
index c9443fc..94c952e 100644
--- a/drivers/memory/fsl-corenet-cf.c
+++ b/drivers/memory/fsl-corenet-cf.c
@@ -27,18 +27,29 @@ enum ccf_version {
 struct ccf_info {
 	enum ccf_version version;
 	int err_reg_offs;
+	bool has_brr;
 };
 
 static const struct ccf_info ccf1_info = {
 	.version = CCF1,
 	.err_reg_offs = 0xa00,
+	.has_brr = false,
 };
 
 static const struct ccf_info ccf2_info = {
 	.version = CCF2,
 	.err_reg_offs = 0xe40,
+	.has_brr = true,
 };
 
+/*
+ * This register is present but not documented, with different values for
+ * IP_ID, on other chips with fsl,corenet2-cf such as t4240 and b4860.
+ */
+#define CCF_BRR			0xbf8
+#define CCF_BRR_IPID		0xffff0000
+#define CCF_BRR_IPID_T1040	0x09310000
+
 static const struct of_device_id ccf_matches[] = {
 	{
 		.compatible = "fsl,corenet1-cf",
@@ -66,6 +77,8 @@ struct ccf_err_regs {
 /* LAE/CV also valid for errdis and errinten */
 #define ERRDET_LAE		(1 << 0)  /* Local Access Error */
 #define ERRDET_CV		(1 << 1)  /* Coherency Violation */
+#define ERRDET_UTID		(1 << 2)  /* Unavailable Target ID (t1040) */
+#define ERRDET_MCST		(1 << 3)  /* Multicast Stash (t1040) */
 #define ERRDET_CTYPE_SHIFT	26	  /* Capture Type (ccf2 only) */
 #define ERRDET_CTYPE_MASK	(0x1f << ERRDET_CTYPE_SHIFT)
 #define ERRDET_CAP		(1 << 31) /* Capture Valid (ccf2 only) */
@@ -84,6 +97,7 @@ struct ccf_private {
 	struct device *dev;
 	void __iomem *regs;
 	struct ccf_err_regs __iomem *err_regs;
+	bool t1040;
 };
 
 static irqreturn_t ccf_irq(int irq, void *dev_id)
@@ -142,6 +156,12 @@ static irqreturn_t ccf_irq(int irq, void *dev_id)
 	if (errdet & ERRDET_CV)
 		dev_crit(ccf->dev, "Coherency Violation\n");
 
+	if (errdet & ERRDET_UTID)
+		dev_crit(ccf->dev, "Unavailable Target ID\n");
+
+	if (errdet & ERRDET_MCST)
+		dev_crit(ccf->dev, "Multicast Stash\n");
+
 	if (cap_valid) {
 		dev_crit(ccf->dev, "address 0x%09llx, src id 0x%x\n",
 			 addr, src_id);
@@ -157,6 +177,7 @@ static int ccf_probe(struct platform_device *pdev)
 	struct ccf_private *ccf;
 	struct resource *r;
 	const struct of_device_id *match;
+	u32 errinten;
 	int ret, irq;
 
 	match = of_match_device(ccf_matches, &pdev->dev);
@@ -183,6 +204,13 @@ static int ccf_probe(struct platform_device *pdev)
 	ccf->info = match->data;
 	ccf->err_regs = ccf->regs + ccf->info->err_reg_offs;
 
+	if (ccf->info->has_brr) {
+		u32 brr = ioread32be(ccf->regs + CCF_BRR);
+
+		if ((brr & CCF_BRR_IPID) == CCF_BRR_IPID_T1040)
+			ccf->t1040 = true;
+	}
+
 	dev_set_drvdata(&pdev->dev, ccf);
 
 	irq = platform_get_irq(pdev, 0);
@@ -197,15 +225,19 @@ static int ccf_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	errinten = ERRDET_LAE | ERRDET_CV;
+	if (ccf->t1040)
+		errinten |= ERRDET_UTID | ERRDET_MCST;
+
 	switch (ccf->info->version) {
 	case CCF1:
 		/* On CCF1 this register enables rather than disables. */
-		iowrite32be(ERRDET_LAE | ERRDET_CV, &ccf->err_regs->errdis);
+		iowrite32be(errinten, &ccf->err_regs->errdis);
 		break;
 
 	case CCF2:
 		iowrite32be(0, &ccf->err_regs->errdis);
-		iowrite32be(ERRDET_LAE | ERRDET_CV, &ccf->err_regs->errinten);
+		iowrite32be(errinten, &ccf->err_regs->errinten);
 		break;
 	}
 
-- 
2.1.0
