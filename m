Return-Path: <linuxppc-dev+bounces-26388-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83818C624D4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 13:13:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ5rv13SNz2yvC;
	Tue, 01 Sep 2026 23:13:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788268398;
	cv=none; b=TgCAwM2LmtxAS/9q+z0rxhLjbvp+LZcHdrFCkpuzCeZwOBhEf6f3JSu4axj3a6oE/qT4SsDfAVIzpEH/JIa/wNzyA8UlIsnR18wZaUXBGPfhu7XW2nq3tMIyce49QNY2j/X2LJ4Dz1+rv6MBNgbN2aObJddVQjAvaxnmDgk1fCygx8z26/sRYrY3LuYBmaLe6TXJsaLFS4YMakIz19KLaNgWTA3NThmMQba2TuPTw4RY8J50OZia1BYBe1zFZTibptAirg/snQNffaDe0rZNthdW4oH5wO3289gEw2AHe+qx0K2RGsZQEUqqhr1BdMBDzEriFIWP6sm2pG3JWi0NBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788268398; c=relaxed/relaxed;
	bh=ej8iF7xfPiEfPTnmPieqHemFhNoLZwi/7BQqcltv+jE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fb5pMt0eSGOVHVJLJW9ctJ7J3XXhn1lwlo11Qkfr4dRBqLQX1KLcjliwD3ABd1H8ti6mWTHAk+CzH/nITt17PA8SbZ9PpLealuR+T50fS/o4Fvac0HN3PmpIl8oqKxz30IFvWDDl6PVDVi8HZWvh7OcCPaaow2jUx/Ms03ONE5t4R7rBxXsdXMSgKPSHtUrlUTckKpb4k+td1rdQh3Ho8R1qlznz+cVUR4P3tK3Lw3VKGSa+6H6YUuPN+No52U/9SwLrKvfKxPf40bq3ssC4uKO6jE8mucZlfbqi/5+OxqojZVkOJx1Z8iSA3Q2YBzZ4mFpSNd+qhEEXqckbMMKIPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=RJmnf4s+; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=RJmnf4s+; dkim-atps=neutral; spf=pass (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=zhouminqiang2@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=RJmnf4s+;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=RJmnf4s+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=zhouminqiang2@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ5rr0Ck8z2yqx
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 23:13:16 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ej8iF7xfPiEfPTnmPieqHemFhNoLZwi/7BQqcltv+jE=;
	b=RJmnf4s+dPHuguplmT7bWvDjoxvpH03+nzp6N/xE6ESgtpZreEhp8PHAG+KQ0CLfHf0V1rMHa
	H5LH2FpSZqjG/UjeoaBZilyVQbcjpZfC67nb2RtE81J9n5ANqwBlvsXQIMcb71kWoIFjzDFT7W4
	70k60Ji/5qVZ92dLYSamBpM=
Received: from canpmsgout05.his.huawei.com (unknown [172.19.92.145])
	by szxga04-in.huawei.com (SkyGuard) with ESMTPS id 4hZ5qT3BbCz126M6G
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2026 21:12:05 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ej8iF7xfPiEfPTnmPieqHemFhNoLZwi/7BQqcltv+jE=;
	b=RJmnf4s+dPHuguplmT7bWvDjoxvpH03+nzp6N/xE6ESgtpZreEhp8PHAG+KQ0CLfHf0V1rMHa
	H5LH2FpSZqjG/UjeoaBZilyVQbcjpZfC67nb2RtE81J9n5ANqwBlvsXQIMcb71kWoIFjzDFT7W4
	70k60Ji/5qVZ92dLYSamBpM=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hZ5bQ4C6rz12LF7;
	Tue,  1 Sep 2026 21:01:38 +0800 (CST)
Received: from dggpemr100018.china.huawei.com (unknown [7.185.36.64])
	by mail.maildlp.com (Postfix) with ESMTPS id 6458940538;
	Tue,  1 Sep 2026 21:12:55 +0800 (CST)
Received: from huawei.com (10.50.85.155) by dggpemr100018.china.huawei.com
 (7.185.36.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 1 Sep
 2026 21:12:54 +0800
From: zhouminqiang <zhouminqiang2@huawei.com>
To: <linux@armlinux.org.uk>, <vz@mleia.com>, <piotr.wojtaszczyk@timesys.com>,
	<maddy@linux.ibm.com>, <dwmw2@infradead.org>, <richard@nod.at>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-mtd@lists.infradead.org>,
	<chengzhihao1@huawei.com>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v3 4/8] jffs2: write verify: add byte-by-byte comparison on mismatch
Date: Tue, 1 Sep 2026 21:05:45 +0800
Message-ID: <20260901130549.1761342-5-zhouminqiang2@huawei.com>
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
index 31fef7466d04..a4cf1915b2bd 100644
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


