Return-Path: <SRS0=AUN+=F4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3375C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Dec 2020 13:27:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EDDD2222B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Dec 2020 13:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EDDD2222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D1rTN45QpzDqP3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Dec 2020 00:27:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com;
 envelope-from=zhengyongjun3@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D1rQb6NkBzDqLp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Dec 2020 00:24:35 +1100 (AEDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D1rPN1Rx9zhx4B;
 Thu, 24 Dec 2020 21:23:36 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Thu, 24 Dec 2020 21:24:10 +0800
From: Zheng Yongjun <zhengyongjun3@huawei.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next] misc: ocxl: use DEFINE_MUTEX() for mutex lock
Date: Thu, 24 Dec 2020 21:24:46 +0800
Message-ID: <20201224132446.31286-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.138.68]
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
Cc: fbarrat@linux.ibm.com, gregkh@linuxfoundation.org, ajd@linux.ibm.com,
 arnd@arndb.de, Zheng Yongjun <zhengyongjun3@huawei.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

mutex lock can be initialized automatically with DEFINE_MUTEX()
rather than explicitly calling mutex_init().

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/misc/ocxl/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index 4d1b44de1492..e70525eedaae 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -15,7 +15,7 @@
 
 static dev_t ocxl_dev;
 static struct class *ocxl_class;
-static struct mutex minors_idr_lock;
+static DEFINE_MUTEX(minors_idr_lock);
 static struct idr minors_idr;
 
 static struct ocxl_file_info *find_and_get_file_info(dev_t devno)
@@ -588,7 +588,6 @@ int ocxl_file_init(void)
 {
 	int rc;
 
-	mutex_init(&minors_idr_lock);
 	idr_init(&minors_idr);
 
 	rc = alloc_chrdev_region(&ocxl_dev, 0, OCXL_NUM_MINORS, "ocxl");
-- 
2.22.0

