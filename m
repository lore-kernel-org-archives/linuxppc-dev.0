Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420gJv2nBwzF31M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 19:27:52 +1000 (AEST)
From: Colin King <colin.king@canonical.com>
To: Roy Pledge <Roy.Pledge@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fsl: remove redundant pointer 'priv'
Date: Wed, 29 Aug 2018 10:27:46 +0100
Message-Id: <20180829092746.30674-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Colin Ian King <colin.king@canonical.com>

Pointer 'priv' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
variable 'priv' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/soc/fsl/dpio/dpio-driver.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
index b60b77bfaffa..e58fcc9096e8 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -50,13 +50,10 @@ static void unregister_dpio_irq_handlers(struct fsl_mc_device *dpio_dev)
 
 static int register_dpio_irq_handlers(struct fsl_mc_device *dpio_dev, int cpu)
 {
-	struct dpio_priv *priv;
 	int error;
 	struct fsl_mc_device_irq *irq;
 	cpumask_t mask;
 
-	priv = dev_get_drvdata(&dpio_dev->dev);
-
 	irq = dpio_dev->irqs[0];
 	error = devm_request_irq(&dpio_dev->dev,
 				 irq->msi_desc->irq,
-- 
2.17.1
