Return-Path: <linuxppc-dev+bounces-26382-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93189C624D4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 13:13:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ5rr092mz2xns;
	Tue, 01 Sep 2026 23:13:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788268395;
	cv=none; b=KsvSgcOQZ29BUJgtAz8FOvBbtKhOvuNumv65wgbCPtmGkNhhYc+M4JeYTP9a4kVQhF5DmEd9yiOk6oHBg5IW9PSn/ZV/GaXw2cDhaKcuy4YEgzUsLS4SvAfL5A6YxzxTFEjf1vofZC3VpyoRo6Kj8y+XAsQwkPlr4vl9WS6pS3Ewu1pS4QsdJfJvwF2kUZ8E4rQiThhyO+lH9Q2U/ju5P4DsyVKYgzV/3Q9KxUZgWu8n6N9d37biGv5SdJMZbKslp8/wKeopjU4QaoMIX4/H/yBSm67lXRKST0Ur4DJxMQDAs7YIWd/9KJQ/7/gbe1Ij2blK0sx88yFqGXkm8+keUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788268395; c=relaxed/relaxed;
	bh=jmt8bfKaSGroqiOHkxuJ59AWSDBasbhKv+fimUwo2ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVAV3lhUopftEM2W2pIqGuSU2+MbbK+u/bA98sZCV+Nrb9mRyPcIaN9Lq4jV8O/5lEj40FsxfCqxZs5oKB44530iXFzXmWQKMetL/Lx3pWpIohio0RhWig1vydl5+mO7coUw6eZ4NczIFLJ2JgHXMlzN3fQVNVpEPLPq/CSRCmKv7uZp2/h5t9v4KqPZanr0AsxB4FjsYGmU7UUjB2zq5mnwgPcA8Plt7x4xR1RLvBXooo4OCBC9GQa6E8rqAMqP/mLT/DLXt5toxc1ztwWHVs9MBSeJWcD1wvM+dfj5DFIappTwVn4f7LLZ7lVUfIT7ZfxmF6IL2T3jLUibrrcTuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SnOUKHK7; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SnOUKHK7; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhouminqiang2@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SnOUKHK7;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SnOUKHK7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhouminqiang2@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ5rk06Wbz2xGt
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 23:13:09 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jmt8bfKaSGroqiOHkxuJ59AWSDBasbhKv+fimUwo2ec=;
	b=SnOUKHK7srA5XzCvNruBLQJ8WsP61zC6VrSs0oTk/y2cy3kcOHaattF4xdIGxjEUtJdOgROK7
	Je098/rXxtn4d8hc7wUdoJJ2NqX+573LFF4DDb7ttqU+D5QlKy46ZAWoHROcH9r1MfCejaz/rTt
	owHk9qEkMapLh42wTEIs6a4=
Received: from canpmsgout07.his.huawei.com (unknown [172.19.92.160])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4hZ5qx3gGwz1BG6W
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2026 21:12:29 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jmt8bfKaSGroqiOHkxuJ59AWSDBasbhKv+fimUwo2ec=;
	b=SnOUKHK7srA5XzCvNruBLQJ8WsP61zC6VrSs0oTk/y2cy3kcOHaattF4xdIGxjEUtJdOgROK7
	Je098/rXxtn4d8hc7wUdoJJ2NqX+573LFF4DDb7ttqU+D5QlKy46ZAWoHROcH9r1MfCejaz/rTt
	owHk9qEkMapLh42wTEIs6a4=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hZ5by4lbJzLlXZ;
	Tue,  1 Sep 2026 21:02:06 +0800 (CST)
Received: from dggpemr100018.china.huawei.com (unknown [7.185.36.64])
	by mail.maildlp.com (Postfix) with ESMTPS id 280A940563;
	Tue,  1 Sep 2026 21:12:56 +0800 (CST)
Received: from huawei.com (10.50.85.155) by dggpemr100018.china.huawei.com
 (7.185.36.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 1 Sep
 2026 21:12:55 +0800
From: zhouminqiang <zhouminqiang2@huawei.com>
To: <linux@armlinux.org.uk>, <vz@mleia.com>, <piotr.wojtaszczyk@timesys.com>,
	<maddy@linux.ibm.com>, <dwmw2@infradead.org>, <richard@nod.at>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-mtd@lists.infradead.org>,
	<chengzhihao1@huawei.com>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v3 5/8] jffs2: add write verification to direct page writes in flash_writev
Date: Tue, 1 Sep 2026 21:05:46 +0800
Message-ID: <20260901130549.1761342-6-zhouminqiang2@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260901130549.1761342-1-zhouminqiang2@huawei.com>
References: <20260901130549.1761342-1-zhouminqiang2@huawei.com>
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemr100018.china.huawei.com (7.185.36.64)

jffs2_flash_writev() performs writes in three phases: phase 1 fills
the write buffer and flushes it when full, phase 2 writes full pages
directly via mtd_write() bypassing the buffer, and phase 3 fills the
remaining data into the write buffer.

Phases 1 and 3 both invoke __jffs2_flush_wbuf() when the buffer is
full, which includes write-back verification when
CONFIG_JFFS2_FS_WBUF_VERIFY is enabled. However phase 2, which
handles the bulk of the write data, calls mtd_write() directly
without any verification.

Phase 2 direct writes may span multiple wbuf_pagesize pages. Extend
jffs2_verify_write() with a len parameter to specify the data length
to verify, and add the verification call after the phase 2
mtd_write() to cover this gap. Also add __GFP_NOWARN to the kmalloc
in jffs2_verify_write() to suppress high-order allocation warnings
when verifying summary writes on large-erasesize NAND.

Signed-off-by: zhouminqiang <zhouminqiang2@huawei.com>
---
 fs/jffs2/wbuf.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
index a4cf1915b2bd..715cdb8df427 100644
--- a/fs/jffs2/wbuf.c
+++ b/fs/jffs2/wbuf.c
@@ -228,38 +228,38 @@ static struct jffs2_raw_node_ref **jffs2_incore_replace_raw(struct jffs2_sb_info
 
 #ifdef CONFIG_JFFS2_FS_WBUF_VERIFY
 static int jffs2_verify_write(struct jffs2_sb_info *c, unsigned char *buf,
-			      uint32_t ofs)
+			      uint32_t ofs, size_t len)
 {
 	int ret;
 	size_t retlen, i;
 	char *eccstr;
 	void *verify_buf;
 
-	verify_buf = kmalloc(c->wbuf_pagesize, GFP_NOFS);
+	verify_buf = kmalloc(len, GFP_NOFS | __GFP_NOWARN);
 	if (!verify_buf) {
 		pr_warn("%s(): verify buffer allocation failed, skipping verification\n",
 			__func__);
 		return 0;
 	}
 
-	ret = mtd_read(c->mtd, ofs, c->wbuf_pagesize, &retlen, verify_buf);
+	ret = mtd_read(c->mtd, ofs, len, &retlen, verify_buf);
 
 	if (ret && ret != -EUCLEAN && ret != -EBADMSG) {
 		pr_warn("%s(): Read back of page at %08x failed: %d\n",
 			__func__, ofs, ret);
 		goto out_free;
-	} else if (retlen != c->wbuf_pagesize) {
-		pr_warn("%s(): Read back of page at %08x gave short read: %zu not %d\n",
-			__func__, ofs, retlen, c->wbuf_pagesize);
+	} else if (retlen != len) {
+		pr_warn("%s(): Read back of page at %08x gave short read: %zu not %zu\n",
+			__func__, ofs, retlen, len);
 		ret = -EIO;
 		goto out_free;
 	}
-	if (!memcmp(buf, verify_buf, c->wbuf_pagesize)) {
+	if (!memcmp(buf, verify_buf, len)) {
 		ret = 0;
 		goto out_free;
 	}
 
-	for (i = 0; i < c->wbuf_pagesize; i++) {
+	for (i = 0; i < len; i++) {
 		uint8_t c1 = ((uint8_t *)buf)[i];
 		uint8_t c2 = ((uint8_t *)verify_buf)[i];
 		int dump_len;
@@ -274,9 +274,9 @@ static int jffs2_verify_write(struct jffs2_sb_info *c, unsigned char *buf,
 		else
 			eccstr = "OK or unused";
 
-		dump_len = min_t(int, 128, c->wbuf_pagesize - i);
-		pr_warn("Write verify error (ECC %s) at %08x (+%zu/%d). Wrote:\n",
-			eccstr, ofs, i, c->wbuf_pagesize);
+		dump_len = min_t(int, 128, len - i);
+		pr_warn("Write verify error (ECC %s) at %08x (+%zu/%zu). Wrote:\n",
+			eccstr, ofs, i, len);
 		print_hex_dump(KERN_WARNING, "", DUMP_PREFIX_OFFSET, 16, 1,
 			       buf + i, dump_len, 0);
 
@@ -293,7 +293,7 @@ static int jffs2_verify_write(struct jffs2_sb_info *c, unsigned char *buf,
 	return ret;
 }
 #else
-#define jffs2_verify_write(c,b,o) (0)
+#define jffs2_verify_write(c,b,o,l) (0)
 #endif
 
 /* Recover from failure to write wbuf. Recover the nodes up to the
@@ -458,7 +458,7 @@ static void jffs2_wbuf_recover(struct jffs2_sb_info *c)
 			ret = mtd_write(c->mtd, ofs, towrite, &retlen,
 					rewrite_buf);
 
-		if (ret || retlen != towrite || jffs2_verify_write(c, rewrite_buf, ofs)) {
+		if (ret || retlen != towrite || jffs2_verify_write(c, rewrite_buf, ofs, towrite)) {
 			/* Argh. We tried. Really we did. */
 			pr_crit("Recovery of wbuf failed due to a second write error. Data loss ensues.\n");
 			kfree(buf);
@@ -676,7 +676,10 @@ static int __jffs2_flush_wbuf(struct jffs2_sb_info *c, int pad)
 			retlen, c->wbuf_pagesize);
 		ret = -EIO;
 		goto wfail;
-	} else if ((ret = jffs2_verify_write(c, c->wbuf, c->wbuf_ofs))) {
+	}
+
+	ret = jffs2_verify_write(c, c->wbuf, c->wbuf_ofs, c->wbuf_pagesize);
+	if (ret) {
 	wfail:
 		jffs2_wbuf_recover(c);
 
@@ -908,6 +911,10 @@ int jffs2_flash_writev(struct jffs2_sb_info *c, const struct kvec *invecs,
 			if (ret < 0 || wbuf_retlen != PAGE_DIV(vlen))
 				goto outfile;
 
+			ret = jffs2_verify_write(c, v, outvec_to, PAGE_DIV(vlen));
+			if (ret)
+				goto outfile;
+
 			vlen -= wbuf_retlen;
 			outvec_to += wbuf_retlen;
 			c->wbuf_ofs = outvec_to;
-- 
2.52.0


