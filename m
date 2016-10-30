Return-Path: <christophe.jaillet@wanadoo.fr>
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr
 [80.12.242.132])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6WBx5mp9zDvWG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 08:40:57 +1100 (AEDT)
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: imunsie@au1.ibm.com,
	fbarrat@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] cxl: Fix error handling
Date: Sun, 30 Oct 2016 22:40:47 +0100
Message-Id: <20161030214047.25037-1-christophe.jaillet@wanadoo.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

'cxl_dev_context_init()' returns an error pointer in case of error, not
NULL. So test it with IS_ERR.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
un-compiled because I don't have the required  cross build environment.
---
 drivers/misc/cxl/pci.c | 2 +-
 drivers/misc/cxl/phb.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index e96be9ca4e60..80a87ab25b83 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1921,7 +1921,7 @@ static pci_ers_result_t cxl_pci_slot_reset(struct pci_dev *pdev)
 				goto err;
 
 			ctx = cxl_dev_context_init(afu_dev);
-			if (!ctx)
+			if (IS_ERR(ctx))
 				goto err;
 
 			afu_dev->dev.archdata.cxl_ctx = ctx;
diff --git a/drivers/misc/cxl/phb.c b/drivers/misc/cxl/phb.c
index 0935d44c1770..6ec69ada19f4 100644
--- a/drivers/misc/cxl/phb.c
+++ b/drivers/misc/cxl/phb.c
@@ -20,7 +20,7 @@ bool _cxl_pci_associate_default_context(struct pci_dev *dev, struct cxl_afu *afu
 	 * in the virtual phb, we'll need a default context to attach them to.
 	 */
 	ctx = cxl_dev_context_init(dev);
-	if (!ctx)
+	if (IS_ERR(ctx))
 		return false;
 	dev->dev.archdata.cxl_ctx = ctx;
 
-- 
2.9.3
