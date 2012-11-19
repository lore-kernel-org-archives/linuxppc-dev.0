Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id EB1292C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:32:59 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 211/493] hwrng: remove use of __devinit
Date: Mon, 19 Nov 2012 13:22:40 -0500
Message-Id: <1353349642-3677-211-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: Olof Johansson <olof@lixom.net>, Deepak Saxena <dsaxena@plexity.net>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Deepak Saxena <dsaxena@plexity.net> 
Cc: Olof Johansson <olof@lixom.net> 
Cc: linuxppc-dev@lists.ozlabs.org 
---
 drivers/char/hw_random/bcm63xx-rng.c    | 2 +-
 drivers/char/hw_random/exynos-rng.c     | 2 +-
 drivers/char/hw_random/n2-drv.c         | 4 ++--
 drivers/char/hw_random/octeon-rng.c     | 2 +-
 drivers/char/hw_random/omap-rng.c       | 2 +-
 drivers/char/hw_random/pasemi-rng.c     | 2 +-
 drivers/char/hw_random/ppc4xx-rng.c     | 2 +-
 drivers/char/hw_random/timeriomem-rng.c | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/char/hw_random/bcm63xx-rng.c b/drivers/char/hw_random/bcm63xx-rng.c
index 95bcc88..c46fc74 100644
--- a/drivers/char/hw_random/bcm63xx-rng.c
+++ b/drivers/char/hw_random/bcm63xx-rng.c
@@ -61,7 +61,7 @@ static int bcm63xx_rng_data_read(struct hwrng *rng, u32 *data)
 	return 4;
 }
 
-static int __devinit bcm63xx_rng_probe(struct platform_device *pdev)
+static int bcm63xx_rng_probe(struct platform_device *pdev)
 {
 	struct resource *r;
 	struct clk *clk;
diff --git a/drivers/char/hw_random/exynos-rng.c b/drivers/char/hw_random/exynos-rng.c
index 046d6ae..92d302a 100644
--- a/drivers/char/hw_random/exynos-rng.c
+++ b/drivers/char/hw_random/exynos-rng.c
@@ -101,7 +101,7 @@ static int exynos_read(struct hwrng *rng, void *buf,
 	return 4;
 }
 
-static int __devinit exynos_rng_probe(struct platform_device *pdev)
+static int exynos_rng_probe(struct platform_device *pdev)
 {
 	struct exynos_rng *exynos_rng;
 
diff --git a/drivers/char/hw_random/n2-drv.c b/drivers/char/hw_random/n2-drv.c
index cbde832..432235b 100644
--- a/drivers/char/hw_random/n2-drv.c
+++ b/drivers/char/hw_random/n2-drv.c
@@ -611,7 +611,7 @@ static void n2rng_work(struct work_struct *work)
 		schedule_delayed_work(&np->work, HZ * 2);
 }
 
-static void __devinit n2rng_driver_version(void)
+static void n2rng_driver_version(void)
 {
 	static int n2rng_version_printed;
 
@@ -620,7 +620,7 @@ static void __devinit n2rng_driver_version(void)
 }
 
 static const struct of_device_id n2rng_match[];
-static int __devinit n2rng_probe(struct platform_device *op)
+static int n2rng_probe(struct platform_device *op)
 {
 	const struct of_device_id *match;
 	int multi_capable;
diff --git a/drivers/char/hw_random/octeon-rng.c b/drivers/char/hw_random/octeon-rng.c
index 5c34c09..1eada56 100644
--- a/drivers/char/hw_random/octeon-rng.c
+++ b/drivers/char/hw_random/octeon-rng.c
@@ -56,7 +56,7 @@ static int octeon_rng_data_read(struct hwrng *rng, u32 *data)
 	return sizeof(u32);
 }
 
-static int __devinit octeon_rng_probe(struct platform_device *pdev)
+static int octeon_rng_probe(struct platform_device *pdev)
 {
 	struct resource *res_ports;
 	struct resource *res_result;
diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index 45e467d..d8c54e2 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -104,7 +104,7 @@ static struct hwrng omap_rng_ops = {
 	.data_read	= omap_rng_data_read,
 };
 
-static int __devinit omap_rng_probe(struct platform_device *pdev)
+static int omap_rng_probe(struct platform_device *pdev)
 {
 	struct omap_rng_private_data *priv;
 	int ret;
diff --git a/drivers/char/hw_random/pasemi-rng.c b/drivers/char/hw_random/pasemi-rng.c
index 3a63267..da5dfb5 100644
--- a/drivers/char/hw_random/pasemi-rng.c
+++ b/drivers/char/hw_random/pasemi-rng.c
@@ -94,7 +94,7 @@ static struct hwrng pasemi_rng = {
 	.data_read	= pasemi_rng_data_read,
 };
 
-static int __devinit rng_probe(struct platform_device *ofdev)
+static int rng_probe(struct platform_device *ofdev)
 {
 	void __iomem *rng_regs;
 	struct device_node *rng_np = ofdev->dev.of_node;
diff --git a/drivers/char/hw_random/ppc4xx-rng.c b/drivers/char/hw_random/ppc4xx-rng.c
index c51762c..c4b89c2 100644
--- a/drivers/char/hw_random/ppc4xx-rng.c
+++ b/drivers/char/hw_random/ppc4xx-rng.c
@@ -90,7 +90,7 @@ static struct hwrng ppc4xx_rng = {
 	.data_read = ppc4xx_rng_data_read,
 };
 
-static int __devinit ppc4xx_rng_probe(struct platform_device *dev)
+static int ppc4xx_rng_probe(struct platform_device *dev)
 {
 	void __iomem *rng_regs;
 	int err = 0;
diff --git a/drivers/char/hw_random/timeriomem-rng.c b/drivers/char/hw_random/timeriomem-rng.c
index d5144ec..0153d0c 100644
--- a/drivers/char/hw_random/timeriomem-rng.c
+++ b/drivers/char/hw_random/timeriomem-rng.c
@@ -88,7 +88,7 @@ static struct hwrng timeriomem_rng_ops = {
 	.priv		= 0,
 };
 
-static int __devinit timeriomem_rng_probe(struct platform_device *pdev)
+static int timeriomem_rng_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	int ret;
-- 
1.8.0
