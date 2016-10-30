Return-Path: <christophe.jaillet@wanadoo.fr>
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr
 [80.12.242.124])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6Spy5WWhzDvP3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 06:53:28 +1100 (AEDT)
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: imunsie@au1.ibm.com,
	fbarrat@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] cxl: Fix memory allocation failure test
Date: Sun, 30 Oct 2016 20:35:57 +0100
Message-Id: <20161030193557.23862-1-christophe.jaillet@wanadoo.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

'cxl_context_alloc()' does not return an error pointer. It is just a
shortcut for a call to 'kzalloc' with 'sizeof(struct cxl_context)' as the
size parameter.

So its return value should be compared with NULL.
While fixing it, simplify a bit the code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
un-compiled because I don't have the required  cross build environment.
---
 drivers/misc/cxl/api.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 2e5233b60971..2b88ad8a2a89 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -30,10 +30,8 @@ struct cxl_context *cxl_dev_context_init(struct pci_dev *dev)
 		return ERR_CAST(afu);
 
 	ctx = cxl_context_alloc();
-	if (IS_ERR(ctx)) {
-		rc = PTR_ERR(ctx);
-		goto err_dev;
-	}
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
 
 	ctx->kernelapi = true;
 
@@ -61,7 +59,6 @@ struct cxl_context *cxl_dev_context_init(struct pci_dev *dev)
 	kfree(mapping);
 err_ctx:
 	kfree(ctx);
-err_dev:
 	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_GPL(cxl_dev_context_init);
-- 
2.9.3
