Return-Path: <linuxppc-dev+bounces-26183-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6874C61DCB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Aug 2026 07:54:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hX6wX2cTJz2xq0;
	Sat, 29 Aug 2026 17:54:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787985847;
	cv=none; b=kbpXd1PF9/6dB1eLHWDm9OCjTs+yoWdZyERwT2ocGBBCVu1CfbfjOH3oz8unm4yfeOXxIft7m2CibHU/8egemox2UWhc0+7b/JVUEsBfcAjBEQv5NnyMzYLG/iHNQatrYgRnc2I94qxJdUlNkIIQlEtXuPVY+Oz28PBKv458TviqS9MLqKcHgrKp46M2OuEJdx+UbTd2zS+J/iwaNRgBWUrusAzQpY0osaOR/oOA8rj8EJ9BuwXvQzeEi4Tp0I3QFZFg+7pL9SQOAMHLMXtbV7VSakpejk22od6pU8cOAj4knYWw0u/ZuvQncxq/xGa0mPP2psxIopgCz1mN/euDxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787985847; c=relaxed/relaxed;
	bh=TJPANoRDN+fYMKpdt+JU9S3bLccMRqCiof0MgFwWlzU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQpzoG484cfMBcOhyocYq9NHArfSR6IcV0386IEB1uZOuP6qSwYJ5tcxchVPuUIZzc9AZ49+w9rOVjRh1FuMwnYOnOQVdDDXu3dQky/fhVSSrabdiTqKUXfhB4RmoUX1UTCa+aKICG7ugYMj0CgMeCEPqgDdO+c83sPpyJuJfP96Dby5/O/LxCyyrjs56bSJVd59ZMYG5aELXgZfqN+u0eNrA29l6RU6EQSm6gOyGTI49IcRJHV/Yr1+m4y88suJ9rr9TSMeHUkPTZV2GzpBbjrCfnwXjeUP0OFLDvryuAc7PfYYPNayM/hfHCQicim9AnWsztnBCuDrv+NrFVkI9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=e1y7l4Ph; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=e1y7l4Ph; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhouminqiang2@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=e1y7l4Ph;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=e1y7l4Ph;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhouminqiang2@huawei.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1091 seconds by postgrey-1.37 at boromir; Sat, 29 Aug 2026 16:44:00 AEST
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hX5M42Sytz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Aug 2026 16:43:57 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TJPANoRDN+fYMKpdt+JU9S3bLccMRqCiof0MgFwWlzU=;
	b=e1y7l4PhB4SfaOvwKAgMRqpDb/LHbrOvtd4RRG+s06Bp4xSgq0ZtZIK38odls8nOMy+Pssfhs
	dIjbctOBeEbXuDyPgy+AkY4UfTzbYxhEcpy+gjZcQ9qv73489a4eDbvWgIWcyRat6z/ITUyOQq+
	TAfgjFIDi2aRqlLcXMYK00s=
Received: from canpmsgout05.his.huawei.com (unknown [172.19.92.145])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4hX4xM4HYVz1BFqN
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Aug 2026 14:25:11 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TJPANoRDN+fYMKpdt+JU9S3bLccMRqCiof0MgFwWlzU=;
	b=e1y7l4PhB4SfaOvwKAgMRqpDb/LHbrOvtd4RRG+s06Bp4xSgq0ZtZIK38odls8nOMy+Pssfhs
	dIjbctOBeEbXuDyPgy+AkY4UfTzbYxhEcpy+gjZcQ9qv73489a4eDbvWgIWcyRat6z/ITUyOQq+
	TAfgjFIDi2aRqlLcXMYK00s=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hX4jz5zbRz12LDl;
	Sat, 29 Aug 2026 14:15:19 +0800 (CST)
Received: from dggpemr100018.china.huawei.com (unknown [7.185.36.64])
	by mail.maildlp.com (Postfix) with ESMTPS id 483714057D;
	Sat, 29 Aug 2026 14:25:35 +0800 (CST)
Received: from huawei.com (10.50.85.155) by dggpemr100018.china.huawei.com
 (7.185.36.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Sat, 29 Aug
 2026 14:25:34 +0800
From: zhouminqiang <zhouminqiang2@huawei.com>
To: <linux@armlinux.org.uk>, <vz@mleia.com>, <piotr.wojtaszczyk@timesys.com>,
	<maddy@linux.ibm.com>, <dwmw2@infradead.org>, <richard@nod.at>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-mtd@lists.infradead.org>,
	<chengzhihao1@huawei.com>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v2 7/7] jffs2: add runtime toggle for write verification
Date: Sat, 29 Aug 2026 14:16:57 +0800
Message-ID: <20260829061658.306854-8-zhouminqiang2@huawei.com>
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
index 75b4244e93b8..913183329c54 100644
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
 	verify_buf = kmalloc(len, GFP_NOFS);
 	if (!verify_buf) {
 		pr_warn("%s(): verify buffer allocation failed, skipping verification\n",
-- 
2.52.0


