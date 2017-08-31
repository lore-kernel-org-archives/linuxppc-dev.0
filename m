Return-Path: <haren@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjYc82Lq5zDqmV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 17:17:44 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7V7GCnU093123
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 03:17:41 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cpar7cdfr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 03:17:41 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Thu, 31 Aug 2017 01:17:40 -0600
Subject: [PATCH V4 5/7] crypto/nx: Use kzalloc for workmem allocation
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, herbert@gondor.apana.org.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 mikey@neuling.org, ddstreet@ieee.org, linuxram@us.ibm.com,
 npiggin@gmail.com, benh@kernel.crashing.org, suka@us.ibm.com,
 hbabu@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 31 Aug 2017 00:17:25 -0700
Mime-Version: 1.0
Message-Id: <1504163845.4681.8.camel@hbabu-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Send window is opened / closed for each crypto session.
So initializes txwin in workmem.

Signed-off-by: Haren Myneni <haren@us.ibm.com>
---
 drivers/crypto/nx/nx-842.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/nx/nx-842.c b/drivers/crypto/nx/nx-842.c
index d94e25df503b..da3cb8c35ec7 100644
--- a/drivers/crypto/nx/nx-842.c
+++ b/drivers/crypto/nx/nx-842.c
@@ -116,7 +116,7 @@ int nx842_crypto_init(struct crypto_tfm *tfm, struct nx842_driver *driver)
 
 	spin_lock_init(&ctx->lock);
 	ctx->driver = driver;
-	ctx->wmem = kmalloc(driver->workmem_size, GFP_KERNEL);
+	ctx->wmem = kzalloc(driver->workmem_size, GFP_KERNEL);
 	ctx->sbounce = (u8 *)__get_free_pages(GFP_KERNEL, BOUNCE_BUFFER_ORDER);
 	ctx->dbounce = (u8 *)__get_free_pages(GFP_KERNEL, BOUNCE_BUFFER_ORDER);
 	if (!ctx->wmem || !ctx->sbounce || !ctx->dbounce) {
-- 
2.11.0
