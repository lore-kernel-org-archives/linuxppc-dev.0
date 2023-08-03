Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A345DC00528
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:07:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RGmJp2RHPz3cX3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Aug 2023 21:07:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RGmJG1KgFz3bTk
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2023 21:06:54 +1000 (AEST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RGlsJ0WpczVjsK;
	Thu,  3 Aug 2023 18:47:00 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 18:48:45 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<qiang.zhao@nxp.com>, <leoyang.li@nxp.com>, <michal.simek@amd.com>,
	<robh@kernel.org>
Subject: [PATCH -next 1/2] soc: fsl: qe: Do not check for 0 return after calling platform_get_irq()
Date: Thu, 3 Aug 2023 18:48:06 +0800
Message-ID: <20230803104807.814005-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803104807.814005-1-ruanjinjie@huawei.com>
References: <20230803104807.814005-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
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
Cc: ruanjinjie@huawei.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There is no possible for platform_get_irq() to
return 0. Use the return value from platform_get_irq().

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/soc/fsl/qe/qe_ic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index bbae3d39c7be..8ab6e51e4f28 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -435,8 +435,8 @@ static int qe_ic_init(struct platform_device *pdev)
 	qe_ic->virq_high = platform_get_irq(pdev, 0);
 	qe_ic->virq_low = platform_get_irq(pdev, 1);
 
-	if (qe_ic->virq_low <= 0)
-		return -ENODEV;
+	if (qe_ic->virq_low < 0)
+		return qe_ic->virq_low;
 
 	if (qe_ic->virq_high > 0 && qe_ic->virq_high != qe_ic->virq_low) {
 		low_handler = qe_ic_cascade_low;
-- 
2.34.1

