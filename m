Return-Path: <linuxppc-dev+bounces-26383-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FDCC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 13:13:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ5rs3CjLz2yrS;
	Tue, 01 Sep 2026 23:13:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788268397;
	cv=none; b=V8nFQHTdwCIefDu+SSGmo7eUQsdu9e5UFavNYm6L33IAeYsIiWor9QQE7K13VAg6p/a+h//iNRZzoTfGvmW7lXWRYluG5gE67oYf9YnuDi3Z8GbIJpAwthImxV0OJ7SjWi2eyGoTq3M7az6uIL+TXh1iF+RvHBn7oCunN4skEdJeogz2xkjyeM8XiVKQVpfyhh7FmNowegnV5AnSyPd/ywQbzcpBfGReey0+8v6KuWJI90oTacBtKos3G+7iaU72HIcDARbID5jYi24bu7TQ2UQeXlFKkROQiAzkOHH0cwpjtcZdqlmWLtRXoSWu0L3qCyYYpZ39V07GrqPVIF7UqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788268397; c=relaxed/relaxed;
	bh=bLJ7so2eQ04eUxA7uRgkuQiNgLyO0A/w5Eo0GY7ooL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K86sAyIz/ckR1USzYPzJc/mtxlTvbVy8pI/SZNK92ol8JhNfXTaL7GffwxbvTB4hRcLY9sFhT58jur1nGEaGoZijNj1RpISrLFVmTeqhN2vfBYC53kxXehoRln8rwmjq2De9p3z5TX2J/dyNPaazm6SqY5BANsoQdGcDk+TYD75JeqlNxJUZL9EwGOrzkPz+fgUrmw8SeIgRzXB0ceVoMzFel9VX1Z7BPGR33ZcnnQV6KqRmPoaLiX4zNv+d+GSjX0XnEK1yq5JEs7Xmj2VoMSzn+bKSaS5L21yJviBaSitLFBCTlBmPKSNmM9JXdi/10GYWZgi6N+k/ZOwbN7TxQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xTyBELc/; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xTyBELc/; dkim-atps=neutral; spf=pass (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=zhouminqiang2@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xTyBELc/;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xTyBELc/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=zhouminqiang2@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ5rl6tDFz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 23:13:11 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bLJ7so2eQ04eUxA7uRgkuQiNgLyO0A/w5Eo0GY7ooL8=;
	b=xTyBELc/cInYBPOUaTwt3ILOfZ8Pf1/HI1d647R/Wj1c7mrsUsFgGo6dMICOPm6/A2FvA1OPa
	OLpDQ8pLDW77LCeJ/wMWwQZwTA8vs7oqYp02u/NAFMCA1JTKhXa+1DFZkbttwNYqEJRvMcS+5Dk
	X8P9UZhgp21LbdrV9BHtios=
Received: from canpmsgout04.his.huawei.com (unknown [172.19.92.133])
	by szxga04-in.huawei.com (SkyGuard) with ESMTPS id 4hZ5qT3MHdz126M6d
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2026 21:12:05 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bLJ7so2eQ04eUxA7uRgkuQiNgLyO0A/w5Eo0GY7ooL8=;
	b=xTyBELc/cInYBPOUaTwt3ILOfZ8Pf1/HI1d647R/Wj1c7mrsUsFgGo6dMICOPm6/A2FvA1OPa
	OLpDQ8pLDW77LCeJ/wMWwQZwTA8vs7oqYp02u/NAFMCA1JTKhXa+1DFZkbttwNYqEJRvMcS+5Dk
	X8P9UZhgp21LbdrV9BHtios=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hZ5bz1vPzz1prLc;
	Tue,  1 Sep 2026 21:02:07 +0800 (CST)
Received: from dggpemr100018.china.huawei.com (unknown [7.185.36.64])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E33440579;
	Tue,  1 Sep 2026 21:12:58 +0800 (CST)
Received: from huawei.com (10.50.85.155) by dggpemr100018.china.huawei.com
 (7.185.36.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 1 Sep
 2026 21:12:57 +0800
From: zhouminqiang <zhouminqiang2@huawei.com>
To: <linux@armlinux.org.uk>, <vz@mleia.com>, <piotr.wojtaszczyk@timesys.com>,
	<maddy@linux.ibm.com>, <dwmw2@infradead.org>, <richard@nod.at>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-mtd@lists.infradead.org>,
	<chengzhihao1@huawei.com>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v3 8/8] jffs2: add runtime toggle for write verification
Date: Tue, 1 Sep 2026 21:05:49 +0800
Message-ID: <20260901130549.1761342-9-zhouminqiang2@huawei.com>
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

Write verification is a diagnostic facility that adds read-back
overhead to every write. In production, this overhead is undesirable
unless fault isolation is required.

Add a module parameter jffs2.write_verify (bool, 0644) that defaults
to off when CONFIG_JFFS2_FS_WRITE_VERIFY is enabled. The verification
entry checks READ_ONCE(jffs2_write_verify) and returns immediately
when disabled, avoiding any overhead. The parameter can be toggled at
runtime via /sys/module/jffs2/parameters/write_verify or set at
boot/modprobe time.

Signed-off-by: zhouminqiang <zhouminqiang2@huawei.com>
---
 fs/jffs2/Kconfig  |  8 ++++++++
 fs/jffs2/writev.c | 23 +++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/fs/jffs2/Kconfig b/fs/jffs2/Kconfig
index 556025a5d438..03dadbd003cd 100644
--- a/fs/jffs2/Kconfig
+++ b/fs/jffs2/Kconfig
@@ -61,6 +61,14 @@ config JFFS2_FS_WRITE_VERIFY
 	  tell transport/program-time corruption from post-commit media
 	  damage.
 
+	  Verification defaults to off when this option is selected and can
+	  be enabled at runtime via sysfs:
+
+	    /sys/module/jffs2/parameters/write_verify
+
+	  Write 0 to disable, 1 to enable.  Boot/modprobe parameter
+	  jffs2.write_verify=0|1 is also supported.
+
 	  If unsure, say 'N'.
 
 config JFFS2_SUMMARY
diff --git a/fs/jffs2/writev.c b/fs/jffs2/writev.c
index 604a14bb5710..342c413be95c 100644
--- a/fs/jffs2/writev.c
+++ b/fs/jffs2/writev.c
@@ -9,12 +9,32 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/mtd/mtd.h>
 #include "nodelist.h"
 
 #ifdef CONFIG_JFFS2_FS_WRITE_VERIFY
+/*
+ * Optional read-back after writes.
+ *
+ * Catch cases where data is corrupted after node CRCs are calculated but
+ * before it is correctly programmed -- e.g. in RAM or during DMA/bus
+ * transfer to the flash controller -- so mtd_write() succeeds while the
+ * medium does not match the in-memory image.
+ *
+ * Runtime toggle: /sys/module/jffs2/parameters/write_verify
+ * (also boot/modprobe: jffs2.write_verify=0|1)
+ */
+static bool jffs2_write_verify;
+module_param_named(write_verify, jffs2_write_verify, bool, 0644);
+MODULE_PARM_DESC(write_verify,
+		 "Verify flash writes by reading back (default: N)");
+
+
 int jffs2_verify_write(struct jffs2_sb_info *c, const unsigned char *buf,
 			      uint32_t ofs, size_t len)
 {
@@ -23,6 +43,9 @@ int jffs2_verify_write(struct jffs2_sb_info *c, const unsigned char *buf,
 	char *eccstr;
 	void *verify_buf;
 
+	if (!READ_ONCE(jffs2_write_verify))
+		return 0;
+
 	verify_buf = kmalloc(len, GFP_NOFS | __GFP_NOWARN);
 	if (!verify_buf) {
 		pr_warn("%s(): verify buffer allocation failed, skipping verification\n",
-- 
2.52.0


