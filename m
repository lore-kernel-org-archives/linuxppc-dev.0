Return-Path: <SRS0=BcJT=SB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D864BC43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 05:56:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B6B4218A3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 05:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6B4218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44WSXX4cCwzDqTF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 16:56:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=yuehaibing@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44WSVl3lznzDqJc
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 16:54:55 +1100 (AEDT)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id EAD3CE56EA9477378F1D;
 Sat, 30 Mar 2019 13:54:45 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Sat, 30 Mar 2019
 13:54:38 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <haren@us.ibm.com>, <herbert@gondor.apana.org.au>, <davem@davemloft.net>, 
 <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>
Subject: [PATCH -next] crypto: nx842 - remove set but not used variables
 'dpadding' and 'max_sync_size'
Date: Sat, 30 Mar 2019 13:54:29 +0800
Message-ID: <20190330055429.25848-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: YueHaibing <yuehaibing@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: YueHaibing <yuehaibing@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/crypto/nx/nx-842.c: In function 'decompress':
drivers/crypto/nx/nx-842.c:356:25: warning: variable 'dpadding' set but not used [-Wunused-but-set-variable]
drivers/crypto/nx/nx-842-pseries.c: In function 'nx842_pseries_compress':
drivers/crypto/nx/nx-842-pseries.c:299:15: warning: variable 'max_sync_size' set but not used [-Wunused-but-set-variable]
drivers/crypto/nx/nx-842-pseries.c: In function 'nx842_pseries_decompress':
drivers/crypto/nx/nx-842-pseries.c:430:15: warning: variable 'max_sync_size' set but not used [-Wunused-but-set-variable]

They are not used any more and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/crypto/nx/nx-842-pseries.c | 6 ++----
 drivers/crypto/nx/nx-842.c         | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/nx/nx-842-pseries.c b/drivers/crypto/nx/nx-842-pseries.c
index 6686997..5793284 100644
--- a/drivers/crypto/nx/nx-842-pseries.c
+++ b/drivers/crypto/nx/nx-842-pseries.c
@@ -296,7 +296,7 @@ static int nx842_pseries_compress(const unsigned char *in, unsigned int inlen,
 	struct nx842_workmem *workmem;
 	struct nx842_scatterlist slin, slout;
 	struct nx_csbcpb *csbcpb;
-	int ret = 0, max_sync_size;
+	int ret = 0;
 	unsigned long inbuf, outbuf;
 	struct vio_pfo_op op = {
 		.done = NULL,
@@ -319,7 +319,6 @@ static int nx842_pseries_compress(const unsigned char *in, unsigned int inlen,
 		rcu_read_unlock();
 		return -ENODEV;
 	}
-	max_sync_size = local_devdata->max_sync_size;
 	dev = local_devdata->dev;
 
 	/* Init scatterlist */
@@ -427,7 +426,7 @@ static int nx842_pseries_decompress(const unsigned char *in, unsigned int inlen,
 	struct nx842_workmem *workmem;
 	struct nx842_scatterlist slin, slout;
 	struct nx_csbcpb *csbcpb;
-	int ret = 0, max_sync_size;
+	int ret = 0;
 	unsigned long inbuf, outbuf;
 	struct vio_pfo_op op = {
 		.done = NULL,
@@ -451,7 +450,6 @@ static int nx842_pseries_decompress(const unsigned char *in, unsigned int inlen,
 		rcu_read_unlock();
 		return -ENODEV;
 	}
-	max_sync_size = local_devdata->max_sync_size;
 	dev = local_devdata->dev;
 
 	workmem = PTR_ALIGN(wmem, WORKMEM_ALIGN);
diff --git a/drivers/crypto/nx/nx-842.c b/drivers/crypto/nx/nx-842.c
index d94e25d..f06565d 100644
--- a/drivers/crypto/nx/nx-842.c
+++ b/drivers/crypto/nx/nx-842.c
@@ -353,7 +353,7 @@ static int decompress(struct nx842_crypto_ctx *ctx,
 	unsigned int adj_slen = slen;
 	u8 *src = p->in, *dst = p->out;
 	u16 padding = be16_to_cpu(g->padding);
-	int ret, spadding = 0, dpadding = 0;
+	int ret, spadding = 0;
 	ktime_t timeout;
 
 	if (!slen || !required_len)
@@ -413,7 +413,6 @@ static int decompress(struct nx842_crypto_ctx *ctx,
 		spadding = 0;
 		dst = p->out;
 		dlen = p->oremain;
-		dpadding = 0;
 		if (dlen < required_len) { /* have ignore bytes */
 			dst = ctx->dbounce;
 			dlen = BOUNCE_BUFFER_SIZE;
-- 
2.7.0


