Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A69F51A05BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 19:51:46 +1000 (AEST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7E1D614010F
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 19:51:46 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 27 Aug 2015 19:51:45 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6EC5E3578057
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 19:51:43 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7R9pYOo59113508
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 19:51:43 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7R9pAbq022091
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 19:51:10 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>
Cc: mikey <mikey@neuling.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Matt Ochs <mrochs@us.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 1/2] cxl: Fix + cleanup error paths in cxl_dev_context_init
Date: Thu, 27 Aug 2015 19:50:18 +1000
Message-Id: <1440669019-23800-1-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

If the cxl_context_alloc() call fails, we return immediately without
releasing the reference on the AFU device, allowing it to leak.

This patch switches to using goto style error handling so that the
device is released in common code for both error paths, and will also
simplify things if we add additional initialisation in this function in
the future.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/api.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index f49e3e5..005adc7 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -25,19 +25,24 @@ struct cxl_context *cxl_dev_context_init(struct pci_dev *dev)
 
 	get_device(&afu->dev);
 	ctx = cxl_context_alloc();
-	if (IS_ERR(ctx))
-		return ctx;
+	if (IS_ERR(ctx)) {
+		rc = PTR_ERR(ctx);
+		goto err_dev;
+	}
 
 	/* Make it a slave context.  We can promote it later? */
 	rc = cxl_context_init(ctx, afu, false, NULL);
-	if (rc) {
-		kfree(ctx);
-		put_device(&afu->dev);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (rc)
+		goto err_ctx;
 	cxl_assign_psn_space(ctx);
 
 	return ctx;
+
+err_ctx:
+	kfree(ctx);
+err_dev:
+	put_device(&afu->dev);
+	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_GPL(cxl_dev_context_init);
 
-- 
2.1.4
