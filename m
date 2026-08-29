Return-Path: <linuxppc-dev+bounces-26186-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCF9C61DCB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Aug 2026 07:55:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hX6x44vWmz304Q;
	Sat, 29 Aug 2026 17:55:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787985883;
	cv=none; b=P28HaAFbXAPGpd+6YaIpocalaEhARK25+wSb+CgbYuXiFV2RKXDit1Aye7PuMSW/gTNUfvIKN7ihlqgMD5HPsPoe029cCMnUcOj30H0l7BKjY/L6ShbUlUT0ygqZKA1KPo7BvKTcKY3EiI2AgbNDXe3xdzaw75mfZjEtF7b12y5uH+oxoM9hZNlbXeTak01GkQfymJBCa11uiG+XMbYlEnmaoZRBbByNNwnT60Mp5i8TxpBBQCKH1xBOo8fZVIKT9Jo1ApvtG7FA2JPX+CXM/WCCEPdRqitWRXz4jmLEK90i7cKStsziqZvWzaClpjOC++2aSZQ/JszVsAdRFTTVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787985883; c=relaxed/relaxed;
	bh=Pn2SmxuVjFwFpqXGdu8OZwKamj1BHEHNT/tHVR/vSTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YkQ7SehAS+RsmTjqsf/HtM/KpbSgu8XQrEypEVDMtnscIu7+HTV8M7IvzBJiMyaukdUWTfjOaOObcabN4vZoNwVRMBdWVrKMsbIJRTRBCjELevic55+6aRjtSMKksLxRRrreG+XA2cC8Iqw6Q0mkrw5Usnods2w6rsbm3MLB21n+/QRtS+6AqyG+3f2kSyTY7J1jYGDIeT/CapquhkH9FbWJhD61+9KZ619XxJ60Rx9Zi0aFsnB4pi94C8DpZpyCLn+oAKInmd6ksHqIGeB/oAFIVO2CaLdK3zOPYOsaWzc2choJ/ZdLm5hSxXzu8NEELjmqPh0sqjixNifz0fupQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=dYeGUVwc; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=dYeGUVwc; dkim-atps=neutral; spf=pass (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=zhouminqiang2@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=dYeGUVwc;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=dYeGUVwc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=zhouminqiang2@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hX5Mt1JGyz2xnS
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Aug 2026 16:44:41 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Pn2SmxuVjFwFpqXGdu8OZwKamj1BHEHNT/tHVR/vSTw=;
	b=dYeGUVwcG1LDa8xv9mPu47y6etjh2IMRAV9Drf7EGVvZKHnrOiJzZOm2ruTqAFBUstbuwQrh2
	Jez+frkwp1AVHS4qRmwFzYQlODzEuoODMXTOqsDQe1Js8QxpnK1mfV+L15PYfsSTrmKmx+pS+8K
	Nk8NutdrLYEa65TYILoJIIo=
Received: from canpmsgout10.his.huawei.com (unknown [172.19.92.130])
	by szxga04-in.huawei.com (SkyGuard) with ESMTPS id 4hX4ww3rJbz126M2C
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Aug 2026 14:24:48 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Pn2SmxuVjFwFpqXGdu8OZwKamj1BHEHNT/tHVR/vSTw=;
	b=dYeGUVwcG1LDa8xv9mPu47y6etjh2IMRAV9Drf7EGVvZKHnrOiJzZOm2ruTqAFBUstbuwQrh2
	Jez+frkwp1AVHS4qRmwFzYQlODzEuoODMXTOqsDQe1Js8QxpnK1mfV+L15PYfsSTrmKmx+pS+8K
	Nk8NutdrLYEa65TYILoJIIo=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hX4jL0gjdz1K9D2;
	Sat, 29 Aug 2026 14:14:46 +0800 (CST)
Received: from dggpemr100018.china.huawei.com (unknown [7.185.36.64])
	by mail.maildlp.com (Postfix) with ESMTPS id A9F524055B;
	Sat, 29 Aug 2026 14:25:33 +0800 (CST)
Received: from huawei.com (10.50.85.155) by dggpemr100018.china.huawei.com
 (7.185.36.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Sat, 29 Aug
 2026 14:25:32 +0800
From: zhouminqiang <zhouminqiang2@huawei.com>
To: <linux@armlinux.org.uk>, <vz@mleia.com>, <piotr.wojtaszczyk@timesys.com>,
	<maddy@linux.ibm.com>, <dwmw2@infradead.org>, <richard@nod.at>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-mtd@lists.infradead.org>,
	<chengzhihao1@huawei.com>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v2 5/7] jffs2: add write verification to NOR direct write paths
Date: Sat, 29 Aug 2026 14:16:55 +0800
Message-ID: <20260829061658.306854-6-zhouminqiang2@huawei.com>
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

NOR Flash and other non-writebuffered devices write directly through
jffs2_flash_direct_writev() and jffs2_flash_direct_write() without
any write-back verification. If mtd_write() succeeds but the readable
medium differs from JFFS2's source buffer, a later node CRC failure
cannot distinguish transport/program-time corruption from post-commit
media damage.

Move jffs2_verify_write() from wbuf.c to writev.c so it can be shared
by both writebuffered and direct write paths. Add jffs2_verify_writev()
to iterate over kvec entries and verify each one individually. In both
direct write functions, add mtd_write() return value and retlen checks,
and invoke verification after a successful complete write.

In jffs2_flash_direct_writev(), move the mtd_writev() call before
jffs2_sum_add_kvec() so that *retlen is always set by the MTD layer
first. The original ordering let jffs2_sum_add_kvec() return early on
error without ever touching *retlen, leaving the caller's retlen check
to read an uninitialized value. Keep the same order in
jffs2_flash_direct_write().

Signed-off-by: zhouminqiang <zhouminqiang2@huawei.com>
---
 fs/jffs2/os-linux.h |  11 ++++
 fs/jffs2/wbuf.c     |  70 -------------------------
 fs/jffs2/writev.c   | 121 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 131 insertions(+), 71 deletions(-)

diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
index 86ab014a349c..e73ef643fd97 100644
--- a/fs/jffs2/os-linux.h
+++ b/fs/jffs2/os-linux.h
@@ -192,6 +192,17 @@ int jffs2_flash_direct_writev(struct jffs2_sb_info *c, const struct kvec *vecs,
 int jffs2_flash_direct_write(struct jffs2_sb_info *c, loff_t ofs, size_t len,
 			size_t *retlen, const u_char *buf);
 
+#ifdef CONFIG_JFFS2_FS_WBUF_VERIFY
+int jffs2_verify_write(struct jffs2_sb_info *c, const unsigned char *buf,
+		       uint32_t ofs, size_t len);
+int jffs2_verify_writev(struct jffs2_sb_info *c,
+		       const struct kvec *vecs,
+		       unsigned long count, loff_t to);
+#else
+#define jffs2_verify_write(c, b, o, l) (0)
+#define jffs2_verify_writev(c, v, cnt, t) (0)
+#endif
+
 #endif /* __JFFS2_OS_LINUX_H__ */
 
 
diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
index 81f3538ca258..2f4937951a0c 100644
--- a/fs/jffs2/wbuf.c
+++ b/fs/jffs2/wbuf.c
@@ -226,76 +226,6 @@ static struct jffs2_raw_node_ref **jffs2_incore_replace_raw(struct jffs2_sb_info
 	return NULL;
 }
 
-#ifdef CONFIG_JFFS2_FS_WBUF_VERIFY
-static int jffs2_verify_write(struct jffs2_sb_info *c, unsigned char *buf,
-			      uint32_t ofs, size_t len)
-{
-	int ret;
-	size_t retlen, i;
-	char *eccstr;
-	void *verify_buf;
-
-	verify_buf = kmalloc(len, GFP_NOFS);
-	if (!verify_buf) {
-		pr_warn("%s(): verify buffer allocation failed, skipping verification\n",
-			__func__);
-		return 0;
-	}
-
-	ret = mtd_read(c->mtd, ofs, len, &retlen, verify_buf);
-
-	if (ret && ret != -EUCLEAN && ret != -EBADMSG) {
-		pr_warn("%s(): Read back of page at %08x failed: %d\n",
-			__func__, ofs, ret);
-		goto out_free;
-	} else if (retlen != len) {
-		pr_warn("%s(): Read back of page at %08x gave short read: %zu not %zu\n",
-			__func__, ofs, retlen, len);
-		ret = -EIO;
-		goto out_free;
-	}
-	if (!memcmp(buf, verify_buf, len)) {
-		ret = 0;
-		goto out_free;
-	}
-
-	for (i = 0; i < len; i++) {
-		uint8_t c1 = ((uint8_t *)buf)[i];
-		uint8_t c2 = ((uint8_t *)verify_buf)[i];
-		int dump_len;
-
-		if (c1 == c2)
-			continue;
-
-		if (ret == -EUCLEAN)
-			eccstr = "corrected";
-		else if (ret == -EBADMSG)
-			eccstr = "correction failed";
-		else
-			eccstr = "OK or unused";
-
-		dump_len = min_t(int, 128, len - i);
-		pr_warn("Write verify error (ECC %s) at %08x (+%zu/%zu). Wrote:\n",
-			eccstr, ofs, i, len);
-		print_hex_dump(KERN_WARNING, "", DUMP_PREFIX_OFFSET, 16, 1,
-			       buf + i, dump_len, 0);
-
-		pr_warn("Read back:\n");
-		print_hex_dump(KERN_WARNING, "", DUMP_PREFIX_OFFSET, 16, 1,
-			       verify_buf + i, dump_len, 0);
-
-		ret = -EIO;
-		goto out_free;
-	}
-
-out_free:
-	kfree(verify_buf);
-	return ret;
-}
-#else
-#define jffs2_verify_write(c,b,o,l) (0)
-#endif
-
 /* Recover from failure to write wbuf. Recover the nodes up to the
  * wbuf, not the one which we were starting to try to write. */
 
diff --git a/fs/jffs2/writev.c b/fs/jffs2/writev.c
index a1bda9dab3f8..2cb8cb030ae3 100644
--- a/fs/jffs2/writev.c
+++ b/fs/jffs2/writev.c
@@ -10,12 +10,121 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/mtd/mtd.h>
 #include "nodelist.h"
 
+#ifdef CONFIG_JFFS2_FS_WBUF_VERIFY
+int jffs2_verify_write(struct jffs2_sb_info *c, const unsigned char *buf,
+			      uint32_t ofs, size_t len)
+{
+	int ret;
+	size_t retlen, i;
+	char *eccstr;
+	void *verify_buf;
+
+	verify_buf = kmalloc(len, GFP_NOFS);
+	if (!verify_buf) {
+		pr_warn("%s(): verify buffer allocation failed, skipping verification\n",
+			__func__);
+		return 0;
+	}
+
+	ret = mtd_read(c->mtd, ofs, len, &retlen, verify_buf);
+
+	if (ret && ret != -EUCLEAN && ret != -EBADMSG) {
+		pr_warn("%s(): Read back of page at %08x failed: %d\n",
+			__func__, ofs, ret);
+		goto out_free;
+	} else if (retlen != len) {
+		pr_warn("%s(): Read back of page at %08x gave short read: %zu not %zu\n",
+			__func__, ofs, retlen, len);
+		ret = -EIO;
+		goto out_free;
+	}
+	if (!memcmp(buf, verify_buf, len)) {
+		ret = 0;
+		goto out_free;
+	}
+
+	for (i = 0; i < len; i++) {
+		uint8_t c1 = ((uint8_t *)buf)[i];
+		uint8_t c2 = ((uint8_t *)verify_buf)[i];
+		int dump_len;
+
+		if (c1 == c2)
+			continue;
+
+		if (ret == -EUCLEAN)
+			eccstr = "corrected";
+		else if (ret == -EBADMSG)
+			eccstr = "correction failed";
+		else
+			eccstr = "OK or unused";
+
+		dump_len = min_t(int, 128, len - i);
+		pr_warn("Write verify error (ECC %s) at %08x (+%zu/%zu). Wrote:\n",
+			eccstr, ofs, i, len);
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
+
+out_free:
+	kfree(verify_buf);
+	return ret;
+}
+
+int jffs2_verify_writev(struct jffs2_sb_info *c,
+			const struct kvec *vecs,
+			unsigned long count, loff_t to)
+{
+	loff_t ofs = to;
+	unsigned long i;
+	int ret;
+
+	for (i = 0; i < count; i++) {
+		if (!vecs[i].iov_len)
+			continue;
+		ret = jffs2_verify_write(c, vecs[i].iov_base, ofs,
+					 vecs[i].iov_len);
+		if (ret)
+			return ret;
+		ofs += vecs[i].iov_len;
+	}
+	return 0;
+}
+#endif /* CONFIG_JFFS2_FS_WBUF_VERIFY */
+
 int jffs2_flash_direct_writev(struct jffs2_sb_info *c, const struct kvec *vecs,
 			      unsigned long count, loff_t to, size_t *retlen)
 {
+	int ret;
+
+	ret = mtd_writev(c->mtd, vecs, count, to, retlen);
+
+	if (ret) {
+		pr_warn("%s(): Write failed with %d\n", __func__, ret);
+	} else {
+		size_t totlen = 0;
+		unsigned long i;
+
+		for (i = 0; i < count; i++)
+			totlen += vecs[i].iov_len;
+		if (*retlen != totlen) {
+			pr_warn("%s(): Write was short: %zu instead of %zu\n",
+				__func__, *retlen, totlen);
+			ret = -EIO;
+		} else
+			ret = jffs2_verify_writev(c, vecs, count, to);
+	}
+
 	if (!jffs2_is_writebuffered(c)) {
 		if (jffs2_sum_active()) {
 			int res;
@@ -26,15 +135,25 @@ int jffs2_flash_direct_writev(struct jffs2_sb_info *c, const struct kvec *vecs,
 		}
 	}
 
-	return mtd_writev(c->mtd, vecs, count, to, retlen);
+	return ret;
 }
 
 int jffs2_flash_direct_write(struct jffs2_sb_info *c, loff_t ofs, size_t len,
 			size_t *retlen, const u_char *buf)
 {
 	int ret;
+
 	ret = mtd_write(c->mtd, ofs, len, retlen, buf);
 
+	if (ret) {
+		pr_warn("%s(): Write failed with %d\n", __func__, ret);
+	} else if (*retlen != len) {
+		pr_warn("%s(): Write was short: %zu instead of %zu\n",
+			__func__, *retlen, len);
+		ret = -EIO;
+	} else
+		ret = jffs2_verify_write(c, buf, ofs, len);
+
 	if (jffs2_sum_active()) {
 		struct kvec vecs[1];
 		int res;
-- 
2.52.0


