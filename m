Return-Path: <linuxppc-dev+bounces-26384-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC1DC624D6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 13:13:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ5rs42y1z2yrW;
	Tue, 01 Sep 2026 23:13:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788268397;
	cv=none; b=KmFSTgAV5Dv3TIB9h/ygqhBL5C0mT1rwEsRDyHrNlPHekTYpbs0wcf0pwWVHlIIvgRwtZS1t1m0zhTbmgDjiLMo7BQtfvOrwD+V6wwI5WWIpQHgYa8/+CAHUk7szXvPOdpIGzc4eZA0pH8oaBu/T58MXZVdiBjDDwcKPxn4d7SwxsnZOgMcQV6abSymUhrvkdq7TQwRv/o1kWd6CieR45FGEbvOKQLcp/HNBIcRIkqeEwjpg8UxIQ55Y4iqsmX0YTJugYEYatyocVAAujaVYmAhiQna9XE4yn1ZqRsSbwyPH9qXna98dZ1kVZAUvbQb4i9IXZKKUmjqGLXsHRY41Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788268397; c=relaxed/relaxed;
	bh=XttkQrGGxgVvdqaU8oqPJsj1rOoam2GxZi/pM1qFyT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVaOowWqZQKnCQ4T/F7rleYEnVxawLSCyjOLewM6+43r97N32vIEeUqyJM6fjHwK/+9oK3Jg1pUQCgVKO8GWwajMZomIOYuqvEYY3hwzLtWWRByu9bcPsh9SDuiKWy4EiPveWD2txHbWNhxdpRiksHKwcyZQ1hOdQs+zQjNE8B4FD/NFKukvlmIL38n2SpNfLh4efWe1GTHogz40ejLOzG5HQw002N2x09kEWE+mSk8rv50LLlV5BncjvwS80h7nKN8djK6kV1sxuU48BFt79DaZBXtbd2h+OJEhCx/G/wGHFS7R/gS/Be+4z0GKPNNaYmSaQnvf9wrAD2+/CI6ldQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=oqdtTUz1; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=oqdtTUz1; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhouminqiang2@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=oqdtTUz1;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=oqdtTUz1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhouminqiang2@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ5rl4WYDz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 23:13:11 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XttkQrGGxgVvdqaU8oqPJsj1rOoam2GxZi/pM1qFyT4=;
	b=oqdtTUz137cwCvq0Vima4V9QcWzM4sStSL8ZtpjXR8tPlPAwKkGSMw/X2mcn8CYGdD1RMM1EU
	0zBr7kXbFBEZNkx7360byyUndc2bPGLy9WXrEM88bvSKaENFLj7zly0SL4WVixAWzB+1+7mQTOJ
	zMAr1SQGMXcfEmia1jBeVwQ=
Received: from canpmsgout06.his.huawei.com (unknown [172.19.92.157])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4hZ5qw6x8Qz1BG6W
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2026 21:12:28 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XttkQrGGxgVvdqaU8oqPJsj1rOoam2GxZi/pM1qFyT4=;
	b=oqdtTUz137cwCvq0Vima4V9QcWzM4sStSL8ZtpjXR8tPlPAwKkGSMw/X2mcn8CYGdD1RMM1EU
	0zBr7kXbFBEZNkx7360byyUndc2bPGLy9WXrEM88bvSKaENFLj7zly0SL4WVixAWzB+1+7mQTOJ
	zMAr1SQGMXcfEmia1jBeVwQ=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hZ5bz1Nx9zRhRG;
	Tue,  1 Sep 2026 21:02:07 +0800 (CST)
Received: from dggpemr100018.china.huawei.com (unknown [7.185.36.64])
	by mail.maildlp.com (Postfix) with ESMTPS id 92A1240538;
	Tue,  1 Sep 2026 21:12:54 +0800 (CST)
Received: from huawei.com (10.50.85.155) by dggpemr100018.china.huawei.com
 (7.185.36.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 1 Sep
 2026 21:12:53 +0800
From: zhouminqiang <zhouminqiang2@huawei.com>
To: <linux@armlinux.org.uk>, <vz@mleia.com>, <piotr.wojtaszczyk@timesys.com>,
	<maddy@linux.ibm.com>, <dwmw2@infradead.org>, <richard@nod.at>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-mtd@lists.infradead.org>,
	<chengzhihao1@huawei.com>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v3 3/8] jffs2: replace per-superblock verify buffer with per-write buffer
Date: Tue, 1 Sep 2026 21:05:44 +0800
Message-ID: <20260901130549.1761342-4-zhouminqiang2@huawei.com>
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

Subsequent patches will extend write verification to additional write
paths that may execute concurrently. A shared per-superblock buffer
would require a coarse lock to serialize all verification, hurting
concurrency.

To avoid this contention, remove the wbuf_verify field from
jffs2_sb_info, along with the scattered kmalloc/kfree of wbuf_verify
in jffs2_nand_flash_setup, jffs2_dataflash_setup,
jffs2_nor_wbuf_flash_setup and their corresponding cleanup functions.

Instead, allocate a temporary buffer inside jffs2_verify_write(),
giving each invocation its own buffer and eliminating the shared state.

Signed-off-by: zhouminqiang <zhouminqiang2@huawei.com>
---
 fs/jffs2/jffs2_fs_sb.h |  3 ---
 fs/jffs2/wbuf.c        | 61 ++++++++++++++++--------------------------
 2 files changed, 23 insertions(+), 41 deletions(-)

diff --git a/fs/jffs2/jffs2_fs_sb.h b/fs/jffs2/jffs2_fs_sb.h
index 5a7091746f68..8a75870d3fc8 100644
--- a/fs/jffs2/jffs2_fs_sb.h
+++ b/fs/jffs2/jffs2_fs_sb.h
@@ -124,9 +124,6 @@ struct jffs2_sb_info {
 
 	uint32_t wbuf_pagesize; /* 0 for NOR and other flashes with no wbuf */
 
-#ifdef CONFIG_JFFS2_FS_WBUF_VERIFY
-	unsigned char *wbuf_verify; /* read-back buffer for verification */
-#endif
 #ifdef CONFIG_JFFS2_FS_WRITEBUFFER
 	unsigned char *wbuf; /* Write-behind buffer for NAND flash */
 	uint32_t wbuf_ofs;
diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
index 360a291d9fd5..31fef7466d04 100644
--- a/fs/jffs2/wbuf.c
+++ b/fs/jffs2/wbuf.c
@@ -233,19 +233,31 @@ static int jffs2_verify_write(struct jffs2_sb_info *c, unsigned char *buf,
 	int ret;
 	size_t retlen;
 	char *eccstr;
+	void *verify_buf;
+
+	verify_buf = kmalloc(c->wbuf_pagesize, GFP_NOFS);
+	if (!verify_buf) {
+		pr_warn("%s(): verify buffer allocation failed, skipping verification\n",
+			__func__);
+		return 0;
+	}
+
+	ret = mtd_read(c->mtd, ofs, c->wbuf_pagesize, &retlen, verify_buf);
 
-	ret = mtd_read(c->mtd, ofs, c->wbuf_pagesize, &retlen, c->wbuf_verify);
 	if (ret && ret != -EUCLEAN && ret != -EBADMSG) {
 		pr_warn("%s(): Read back of page at %08x failed: %d\n",
 			__func__, c->wbuf_ofs, ret);
-		return ret;
+		goto out_free;
 	} else if (retlen != c->wbuf_pagesize) {
 		pr_warn("%s(): Read back of page at %08x gave short read: %zd not %d\n",
 			__func__, ofs, retlen, c->wbuf_pagesize);
-		return -EIO;
+		ret = -EIO;
+		goto out_free;
+	}
+	if (!memcmp(buf, verify_buf, c->wbuf_pagesize)) {
+		ret = 0;
+		goto out_free;
 	}
-	if (!memcmp(buf, c->wbuf_verify, c->wbuf_pagesize))
-		return 0;
 
 	if (ret == -EUCLEAN)
 		eccstr = "corrected";
@@ -261,9 +273,14 @@ static int jffs2_verify_write(struct jffs2_sb_info *c, unsigned char *buf,
 
 	pr_warn("Read back:\n");
 	print_hex_dump(KERN_WARNING, "", DUMP_PREFIX_OFFSET, 16, 1,
-		       c->wbuf_verify, c->wbuf_pagesize, 0);
+		       verify_buf, c->wbuf_pagesize, 0);
 
+	kfree(verify_buf);
 	return -EIO;
+
+out_free:
+	kfree(verify_buf);
+	return ret;
 }
 #else
 #define jffs2_verify_write(c,b,o) (0)
@@ -1217,22 +1234,11 @@ int jffs2_nand_flash_setup(struct jffs2_sb_info *c)
 		return -ENOMEM;
 	}
 
-#ifdef CONFIG_JFFS2_FS_WBUF_VERIFY
-	c->wbuf_verify = kmalloc(c->wbuf_pagesize, GFP_KERNEL);
-	if (!c->wbuf_verify) {
-		kfree(c->oobbuf);
-		kfree(c->wbuf);
-		return -ENOMEM;
-	}
-#endif
 	return 0;
 }
 
 void jffs2_nand_flash_cleanup(struct jffs2_sb_info *c)
 {
-#ifdef CONFIG_JFFS2_FS_WBUF_VERIFY
-	kfree(c->wbuf_verify);
-#endif
 	kfree(c->wbuf);
 	kfree(c->oobbuf);
 }
@@ -1272,14 +1278,6 @@ int jffs2_dataflash_setup(struct jffs2_sb_info *c) {
 	if (!c->wbuf)
 		return -ENOMEM;
 
-#ifdef CONFIG_JFFS2_FS_WBUF_VERIFY
-	c->wbuf_verify = kmalloc(c->wbuf_pagesize, GFP_KERNEL);
-	if (!c->wbuf_verify) {
-		kfree(c->wbuf);
-		return -ENOMEM;
-	}
-#endif
-
 	pr_info("write-buffering enabled buffer (%d) erasesize (%d)\n",
 		c->wbuf_pagesize, c->sector_size);
 
@@ -1287,9 +1285,6 @@ int jffs2_dataflash_setup(struct jffs2_sb_info *c) {
 }
 
 void jffs2_dataflash_cleanup(struct jffs2_sb_info *c) {
-#ifdef CONFIG_JFFS2_FS_WBUF_VERIFY
-	kfree(c->wbuf_verify);
-#endif
 	kfree(c->wbuf);
 }
 
@@ -1309,20 +1304,10 @@ int jffs2_nor_wbuf_flash_setup(struct jffs2_sb_info *c) {
 	if (!c->wbuf)
 		return -ENOMEM;
 
-#ifdef CONFIG_JFFS2_FS_WBUF_VERIFY
-	c->wbuf_verify = kmalloc(c->wbuf_pagesize, GFP_KERNEL);
-	if (!c->wbuf_verify) {
-		kfree(c->wbuf);
-		return -ENOMEM;
-	}
-#endif
 	return 0;
 }
 
 void jffs2_nor_wbuf_flash_cleanup(struct jffs2_sb_info *c) {
-#ifdef CONFIG_JFFS2_FS_WBUF_VERIFY
-	kfree(c->wbuf_verify);
-#endif
 	kfree(c->wbuf);
 }
 
-- 
2.52.0


