Return-Path: <SRS0=ST+l=CX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F467C43461
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2020 04:17:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B24821655
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2020 04:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B24821655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BqY3V4dpMzDqcW
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2020 14:17:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=liushixin2@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BqXwv6BtTzDqTG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2020 14:11:23 +1000 (AEST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 8BD54B3DD203246DF187;
 Mon, 14 Sep 2020 11:55:22 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Mon, 14 Sep 2020
 11:55:12 +0800
From: Liu Shixin <liushixin2@huawei.com>
To: Li Yang <leoyang.li@nxp.com>
Subject: [PATCH -next] soc/qman: convert to use be32_add_cpu()
Date: Mon, 14 Sep 2020 12:17:52 +0800
Message-ID: <20200914041752.3702104-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 14 Sep 2020 14:15:25 +1000
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
Cc: Liu Shixin <liushixin2@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
drivers/soc/fsl/qbman/qman_test_api.c---
 drivers/soc/fsl/qbman/qman_test_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/qman_test_api.c b/drivers/soc/fsl/qbman/qman_test_api.c
index 2895d062cf51..7066b2f1467c 100644
--- a/drivers/soc/fsl/qbman/qman_test_api.c
+++ b/drivers/soc/fsl/qbman/qman_test_api.c
@@ -86,7 +86,7 @@ static void fd_inc(struct qm_fd *fd)
 	len--;
 	qm_fd_set_param(fd, fmt, off, len);
 
-	fd->cmd = cpu_to_be32(be32_to_cpu(fd->cmd) + 1);
+	be32_add_cpu(&fd->cmd, 1);
 }
 
 /* The only part of the 'fd' we can't memcmp() is the ppid */
-- 
2.25.1

