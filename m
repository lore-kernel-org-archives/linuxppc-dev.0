Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 5E073DDEF1
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 07:30:52 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j5so354177wah.9
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Mar 2009 12:30:50 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc/5200: remove sysfs debug file from GPT driver
To: linuxppc-dev@ozlabs.org
Date: Fri, 06 Mar 2009 13:30:45 -0700
Message-ID: <20090306203044.22371.75222.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Remove poorly designed debug sysfs attribute entry from the GPT driver.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/52xx/mpc52xx_gpt.c |   39 -----------------------------
 1 files changed, 0 insertions(+), 39 deletions(-)


diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index cb038dc..bfbcd41 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -335,44 +335,6 @@ static void
 mpc52xx_gpt_gpio_setup(struct mpc52xx_gpt_priv *p, struct device_node *np) { }
 #endif /* defined(CONFIG_GPIOLIB) */
 
-/***********************************************************************
- * SYSFS attributes
- */
-#if defined(CONFIG_SYSFS)
-static ssize_t mpc52xx_gpt_show_regs(struct device *dev,
-				     struct device_attribute *attr, char *buf)
-{
-	struct mpc52xx_gpt_priv *gpt = dev_get_drvdata(dev);
-	int i, len = 0;
-	u32 __iomem *regs = (void __iomem *) gpt->regs;
-
-	for (i = 0; i < 4; i++)
-		len += sprintf(buf + len, "%.8x ", in_be32(regs + i));
-	len += sprintf(buf + len, "\n");
-
-	return len;
-}
-
-static struct device_attribute mpc52xx_gpt_attrib[] = {
-	__ATTR(regs, S_IRUGO | S_IWUSR, mpc52xx_gpt_show_regs, NULL),
-};
-
-static void mpc52xx_gpt_create_attribs(struct mpc52xx_gpt_priv *gpt)
-{
-	int i, err = 0;
-
-	for (i = 0; i < ARRAY_SIZE(mpc52xx_gpt_attrib); i++) {
-		err = device_create_file(gpt->dev, &mpc52xx_gpt_attrib[i]);
-		if (err)
-			dev_err(gpt->dev, "error creating attribute %i\n", i);
-	}
-
-}
-
-#else /* defined(CONFIG_SYSFS) */
-static void mpc52xx_gpt_create_attribs(struct mpc52xx_gpt_priv *) { return 0; }
-#endif /* defined(CONFIG_SYSFS) */
-
 /* ---------------------------------------------------------------------
  * of_platform bus binding code
  */
@@ -395,7 +357,6 @@ static int __devinit mpc52xx_gpt_probe(struct of_device *ofdev,
 
 	dev_set_drvdata(&ofdev->dev, gpt);
 
-	mpc52xx_gpt_create_attribs(gpt);
 	mpc52xx_gpt_gpio_setup(gpt, ofdev->node);
 	mpc52xx_gpt_irq_setup(gpt, ofdev->node);
 
