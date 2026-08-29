Return-Path: <linuxppc-dev+bounces-26181-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B916C61DCB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Aug 2026 07:54:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hX6vq2Bs6z2xlZ;
	Sat, 29 Aug 2026 17:53:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787985846;
	cv=none; b=Pow0ngfZPdFIuDHZoHsjTNk9nOhudnZTnCDEH7JoGPWKrAZ8mHdUAuSWHM1drBBp2rxl1otUqNXwF844dog2jSBMVKwIrcpQ6dcKu00L32FOTwTc67AjosCbKreAlEgPpZHMZh5QDWwsJCugVj/RetBoN6qqjWPwbLmSTt/S244xv3+z1jvvAjcV2TyhXh/MXpzTemzQMF/lbr1iWQNxJpRmJGrBrKyOPFEn56K+/30ZfUHAQcFiFT75fn3+BHhsMUr0kIAXALiozO2ILiyUpkb7b3Jeswy0LwocrcGCh6hwNuLiJ1v/ZqWEaeyPYKvsKD6FjWc339EfgwpvdsBvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787985846; c=relaxed/relaxed;
	bh=ktiYUYsUp5uCXnvJH/BfqE9fq8l5SXsVdqzLvfHOlV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fm3IMEwp3nWy+Vsme4P6Zs4/CQsCwxvGSmE22Ubt5FthyuE5AoBMotk3+P5rq3kSBPK9VJyiLu/uP3j7OcdKu5tZwL5RqJVVWFOSrVNmC4Vy+HXfPIZWAPCOlb8sfBlGKn3RRVWm2iTsflbgJT9+8eNjG/VuPMNACD0Yc6dMxBw2Es0suCkkgqXIiHmRMRqD2xNPgxMA6ms4HEnXkNw6hf9HTfAc28zsS8LkFJGjUOwjCYmyxK7xymXNvc0tRori0nAeC7uP/1dmam6PF2I4tqzE+n5NDvEQafUXC+6g9mAEf5BCBLeh3SrPwFB/r0WuXfHA87QLbiG/7p4RY3Uu0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=C7JNq/9n; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=C7JNq/9n; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhouminqiang2@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=C7JNq/9n;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=C7JNq/9n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhouminqiang2@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hX5M42Xfrz2xZV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Aug 2026 16:43:57 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ktiYUYsUp5uCXnvJH/BfqE9fq8l5SXsVdqzLvfHOlV4=;
	b=C7JNq/9nW8O1L4+qB8K+5l2GGzD9N3sj5EVi4EnDL5oF6x+3kjr/TdY9xkttUhd/epZ+ev4bJ
	5hgEztLJqonv6F5ys20YZ0BjHoNMDdhG8jwXb6tQTPxKCRn3gSjQig20fZertp3RZEGPOPARqMX
	1uaVaJBSLupvQPWZ6L7moek=
Received: from canpmsgout08.his.huawei.com (unknown [172.19.92.156])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4hX4xM28nJz1BFqN
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Aug 2026 14:25:11 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ktiYUYsUp5uCXnvJH/BfqE9fq8l5SXsVdqzLvfHOlV4=;
	b=C7JNq/9nW8O1L4+qB8K+5l2GGzD9N3sj5EVi4EnDL5oF6x+3kjr/TdY9xkttUhd/epZ+ev4bJ
	5hgEztLJqonv6F5ys20YZ0BjHoNMDdhG8jwXb6tQTPxKCRn3gSjQig20fZertp3RZEGPOPARqMX
	1uaVaJBSLupvQPWZ6L7moek=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hX4jJ3V8WzmVXs;
	Sat, 29 Aug 2026 14:14:44 +0800 (CST)
Received: from dggpemr100018.china.huawei.com (unknown [7.185.36.64])
	by mail.maildlp.com (Postfix) with ESMTPS id 17D3B40578;
	Sat, 29 Aug 2026 14:25:32 +0800 (CST)
Received: from huawei.com (10.50.85.155) by dggpemr100018.china.huawei.com
 (7.185.36.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Sat, 29 Aug
 2026 14:25:31 +0800
From: zhouminqiang <zhouminqiang2@huawei.com>
To: <linux@armlinux.org.uk>, <vz@mleia.com>, <piotr.wojtaszczyk@timesys.com>,
	<maddy@linux.ibm.com>, <dwmw2@infradead.org>, <richard@nod.at>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-mtd@lists.infradead.org>,
	<chengzhihao1@huawei.com>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v2 3/7] jffs2: write verify: add byte-by-byte comparison on mismatch
Date: Sat, 29 Aug 2026 14:16:53 +0800
Message-ID: <20260829061658.306854-4-zhouminqiang2@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260829061658.306854-1-zhouminqiang2@huawei.com>
References: <20260829061658.306854-1-zhouminqiang2@huawei.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.85.155]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemr100018.china.huawei.com (7.185.36.64)

jffs2_verify_write() uses memcmp() to compare the write buffer
against data read back from flash. On mismatch, the current code
dumps the entire source and read-back data, which will become
impractical once the verify path is extended to NOR flash where
a single write can span PAGE_SIZE.

Add a byte-by-byte comparison after the memcmp() mismatch path
to locate the exact mismatch offset, reporting the first
differing offset and dumping up to 128 bytes of both the source
and read-back data. memcmp() remains on the hotpath for
successful writes, and the byte-by-byte loop only runs when an
error is actually detected.

Signed-off-by: zhouminqiang <zhouminqiang2@huawei.com>
---
 fs/jffs2/wbuf.c | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
index f10be57c5543..74e169dedab7 100644
--- a/fs/jffs2/wbuf.c
+++ b/fs/jffs2/wbuf.c
@@ -231,7 +231,7 @@ static int jffs2_verify_write(struct jffs2_sb_info *c, unsigned char *buf,
 			      uint32_t ofs)
 {
 	int ret;
-	size_t retlen;
+	size_t retlen, i;
 	char *eccstr;
 	void *verify_buf;
 
@@ -246,10 +246,10 @@ static int jffs2_verify_write(struct jffs2_sb_info *c, unsigned char *buf,
 
 	if (ret && ret != -EUCLEAN && ret != -EBADMSG) {
 		pr_warn("%s(): Read back of page at %08x failed: %d\n",
-			__func__, c->wbuf_ofs, ret);
+			__func__, ofs, ret);
 		goto out_free;
 	} else if (retlen != c->wbuf_pagesize) {
-		pr_warn("%s(): Read back of page at %08x gave short read: %zd not %d\n",
+		pr_warn("%s(): Read back of page at %08x gave short read: %zu not %d\n",
 			__func__, ofs, retlen, c->wbuf_pagesize);
 		ret = -EIO;
 		goto out_free;
@@ -259,24 +259,34 @@ static int jffs2_verify_write(struct jffs2_sb_info *c, unsigned char *buf,
 		goto out_free;
 	}
 
-	if (ret == -EUCLEAN)
-		eccstr = "corrected";
-	else if (ret == -EBADMSG)
-		eccstr = "correction failed";
-	else
-		eccstr = "OK or unused";
+	for (i = 0; i < c->wbuf_pagesize; i++) {
+		uint8_t c1 = ((uint8_t *)buf)[i];
+		uint8_t c2 = ((uint8_t *)verify_buf)[i];
+		int dump_len;
 
-	pr_warn("Write verify error (ECC %s) at %08x. Wrote:\n",
-		eccstr, c->wbuf_ofs);
-	print_hex_dump(KERN_WARNING, "", DUMP_PREFIX_OFFSET, 16, 1,
-		       c->wbuf, c->wbuf_pagesize, 0);
+		if (c1 == c2)
+			continue;
 
-	pr_warn("Read back:\n");
-	print_hex_dump(KERN_WARNING, "", DUMP_PREFIX_OFFSET, 16, 1,
-		       verify_buf, c->wbuf_pagesize, 0);
+		if (ret == -EUCLEAN)
+			eccstr = "corrected";
+		else if (ret == -EBADMSG)
+			eccstr = "correction failed";
+		else
+			eccstr = "OK or unused";
 
-	kfree(verify_buf);
-	return -EIO;
+		dump_len = min_t(int, 128, c->wbuf_pagesize - i);
+		pr_warn("Write verify error (ECC %s) at %08x (+%zu/%d). Wrote:\n",
+			eccstr, ofs, i, c->wbuf_pagesize);
+		print_hex_dump(KERN_WARNING, "", DUMP_PREFIX_OFFSET, 16, 1,
+			       buf + i, dump_len, 0);
+
+		pr_warn("Read back:\n");
+		print_hex_dump(KERN_WARNING, "", DUMP_PREFIX_OFFSET, 16, 1,
+			       verify_buf + i, dump_len, 0);
+
+		ret = -EIO;
+		goto out_free;
+	}
 
 out_free:
 	kfree(verify_buf);
-- 
2.52.0


