Return-Path: <linuxppc-dev+bounces-26619-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4334BC79F8B
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Sep 2026 03:32:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcwk93h79z30VS;
	Sun, 06 Sep 2026 13:32:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788665537;
	cv=none; b=nQCEO2IsxElPqri3OCh6CBskSmueQE0q6nX06GuZtFGwsGTlwKcJK5jnvJ3mXaEyA1wCNhIaQgfI794SHPA+SNMrUUTsmRWuynqjf7PgFg4QQaFtQegXJK9CaAdy6KkUFA1ofTcSBmGrf256GTlRmaJBm1+oMnX3uSXvpBc8B3XbHtV7bR2WqX0MRIecBrF1QfGNa06J2YTBig5iW7M9WGsFJkuyRWI3FqbEmXzQpdmGJjaFjULE637SVu0sAXI8vm2x6ZiQBf2iPS7GCT8m7tcVd0GlX6RQBPKPaxw/GgTbOEmiwjN7MPxHvO41UXGMpuxaLWHOL+Etv/d2swGEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788665537; c=relaxed/relaxed;
	bh=gUreMzQdlJ56nk7uXq3/J731VGiUi2E1FvKOmAvunM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myNFEVK4PPYKt2CPV3rXWqzWTtzP66eA4a3I3U+mzDEU2uflwXOyL1XutUXkUYYfCE3gohp7WTGOlfY+c23IJhlnJ99ZzGqqC+gRyL2xYmLV3SUFBzzHRP5QGo9S46TFek/3s+cSXgtLAbaDKjVDOWmfZjKJBXQMr6IIMcq0HE0LBUnMUrtv4NL2u2qK+v74XiX9H4pRSQ2q8bZXqLRQVis67BudKmwSVI8vpF9oy6kE116bunZECfECV4jJrssOZF2qTRam5oGApl20DuUlgBao9pk4qLzr3FyVVlVIW3ZRxG49X0waK/u+Li4IZZsvmj7tQx3mDbKIKMm7RaQaYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=zhouminqiang@huaweicloud.com; receiver=lists.ozlabs.org) smtp.mailfrom=huaweicloud.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=zhouminqiang@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcwk827Ypz30BW
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 13:32:16 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hcwGK6NxGzKHMRw
	for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Sep 2026 11:11:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CC9844058C
	for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Sep 2026 11:12:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBnUAsW2pxqmzytAw--.18069S8;
	Sun, 06 Sep 2026 11:12:35 +0800 (CST)
From: Zhou Minqiang <zhouminqiang2@huawei.com>
To: linux@armlinux.org.uk,
	vz@mleia.com,
	piotr.wojtaszczyk@timesys.com,
	maddy@linux.ibm.com,
	dwmw2@infradead.org,
	richard@nod.at
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-mtd@lists.infradead.org,
	chengzhihao1@huawei.com,
	yangerkun@huawei.com,
	yi.zhang@huawei.com,
	zhouminqiang <zhouminqiang2@huawei.com>
Subject: [PATCH v4 4/8] jffs2: write verify: add byte-by-byte comparison on mismatch
Date: Sun,  6 Sep 2026 11:03:40 +0800
Message-ID: <20260906030344.2448622-5-zhouminqiang2@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260906030344.2448622-1-zhouminqiang2@huawei.com>
References: <20260906030344.2448622-1-zhouminqiang2@huawei.com>
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
X-CM-TRANSID:cCh0CgBnUAsW2pxqmzytAw--.18069S8
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyxtF18ZFykZF4xXF1fWFg_yoW5Cw1kpr
	say34ayF48Jry7WrsIkFs5C3W3J3y8Gr4xKrW3A34fZa18Z34IgayFqF17ArWFyFZ7X3Wj
	9FZ0kr1rGFn8tFDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
	0Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC
	6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxV
	Aaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07x20xyl4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUxF4iUUUUU
Sender: zhouminqiang@huaweicloud.com
X-CM-SenderInfo: 52kr3z5lqtxttqj6x35dzhxuhorxvhhfrp/

From: zhouminqiang <zhouminqiang2@huawei.com>

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
index 7e52241de457..b2ce642e9bc5 100644
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


