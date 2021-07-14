Return-Path: <SRS0=lYaZ=MG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D47C07E9A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Jul 2021 12:32:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C4960FF1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Jul 2021 12:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C4960FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GPxjb26nFz3bXV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Jul 2021 22:32:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com;
 envelope-from=zhuangyi1@huawei.com; receiver=<UNKNOWN>)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GPxj84zkzz2yZ6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jul 2021 22:32:25 +1000 (AEST)
Received: from dggeml757-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GPxCk6Cwzz7BR9;
 Wed, 14 Jul 2021 20:10:26 +0800 (CST)
Received: from huawei.com (10.90.53.225) by dggeml757-chm.china.huawei.com
 (10.1.199.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 14
 Jul 2021 20:13:59 +0800
From: Yi Zhuang <zhuangyi1@huawei.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>
Subject: [PATCH v2] powerpc/rtas_flash: fix a potential buffer overflow
Date: Wed, 14 Jul 2021 20:27:53 +0800
Message-ID: <20210714122753.76021-1-zhuangyi1@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeml757-chm.china.huawei.com (10.1.199.137)
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
Cc: hegdevasant@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, zhuangyi1@huawei.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Since snprintf() returns the possible output size instead of the
actual output size, the available flash_msg length returned by
get_validate_flash_msg may exceed the given buffer limit when
simple_read_from_buffer calls copy_to_user

Reported-by: kernel test robot <lkp@intel.com>
Fixes: a94a14720eaf5 powerpc/rtas_flash: Fix validate_flash buffer overflow issue
Signed-off-by: Yi Zhuang <zhuangyi1@huawei.com>
---
 arch/powerpc/kernel/rtas_flash.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index a99179d83538..062f0724c2ff 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -470,9 +470,14 @@ static int get_validate_flash_msg(struct rtas_validate_flash_t *args_buf,
 	if (args_buf->status >= VALIDATE_TMP_UPDATE) { 
 		n = sprintf(msg, "%d\n", args_buf->update_results);
 		if ((args_buf->update_results >= VALIDATE_CUR_UNKNOWN) ||
-		    (args_buf->update_results == VALIDATE_TMP_UPDATE))
+		    (args_buf->update_results == VALIDATE_TMP_UPDATE)) {
 			n += snprintf(msg + n, msglen - n, "%s\n",
 					args_buf->buf);
+			if (n >= msglen) {
+				n = msglen;
+				printk(KERN_ERR "FLASH: msg too long.\n");
+			}
+		}
 	} else {
 		n = sprintf(msg, "%d\n", args_buf->status);
 	}
-- 
2.26.0.106.g9fadedd

