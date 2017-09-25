Return-Path: <haren@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y0vhM2jNtzDsP3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 16:44:35 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8P6hxin123592
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 02:44:33 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d6usbugwf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 02:44:33 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Mon, 25 Sep 2017 02:44:31 -0400
Subject: [PATCH 2/2] crypto/nx: Do not initialize workmem allocation
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: herbert@gondor.apana.org.au, mpe@ellerman.id.au, ddstreet@ieee.org,
 mikey@neuling.org, suka@us.ibm.com, npiggin@gmail.com
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 24 Sep 2017 23:44:13 -0700
Mime-Version: 1.0
Message-Id: <1506321853.13257.6.camel@hbabu-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[PATCH 2/2] crypto/nx: Do not initialize workmem allocation

We are using percpu send window on P9 NX (powerNV) instead of opening /
closing per each crypto session. Means txwin is removed from workmem.
So we do not need to initialize workmem for each request.

Signed-off-by: Haren Myneni <haren@us.ibm.com>
---
 drivers/crypto/nx/nx-842.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/nx/nx-842.c b/drivers/crypto/nx/nx-842.c
index da3cb8c..d94e25d 100644
--- a/drivers/crypto/nx/nx-842.c
+++ b/drivers/crypto/nx/nx-842.c
@@ -116,7 +116,7 @@ int nx842_crypto_init(struct crypto_tfm *tfm, struct nx842_driver *driver)
 
 	spin_lock_init(&ctx->lock);
 	ctx->driver = driver;
-	ctx->wmem = kzalloc(driver->workmem_size, GFP_KERNEL);
+	ctx->wmem = kmalloc(driver->workmem_size, GFP_KERNEL);
 	ctx->sbounce = (u8 *)__get_free_pages(GFP_KERNEL, BOUNCE_BUFFER_ORDER);
 	ctx->dbounce = (u8 *)__get_free_pages(GFP_KERNEL, BOUNCE_BUFFER_ORDER);
 	if (!ctx->wmem || !ctx->sbounce || !ctx->dbounce) {
-- 
1.8.3.1
