Return-Path: <SRS0=I40Z=CT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F886C433E2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 14:32:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCFF22076C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 14:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFF22076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BnLvc1tg7zDqft
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2020 00:32:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.32; helo=huawei.com;
 envelope-from=yanaijie@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BnLg62yHbzDqWH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2020 00:21:49 +1000 (AEST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id CFA006BE360D71439816;
 Thu, 10 Sep 2020 22:05:06 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 22:04:56 +0800
From: Jason Yan <yanaijie@huawei.com>
To: <Roy.Pledge@nxp.com>, <leoyang.li@nxp.com>, <youri.querry_1@nxp.com>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] soc: fsl: dpio: remove set but not used 'addr_cena'
Date: Thu, 10 Sep 2020 22:04:15 +0800
Message-ID: <20200910140415.1132266-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
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
Cc: Hulk Robot <hulkci@huawei.com>, Jason Yan <yanaijie@huawei.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This addresses the following gcc warning with "make W=1":

drivers/soc/fsl/dpio/qbman-portal.c: In function
‘qbman_swp_enqueue_multiple_direct’:
drivers/soc/fsl/dpio/qbman-portal.c:650:11: warning: variable
‘addr_cena’ set but not used [-Wunused-but-set-variable]
  650 |  uint64_t addr_cena;
      |           ^~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/soc/fsl/dpio/qbman-portal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
index 0ab85bfb116f..659b4a570d5b 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -647,7 +647,6 @@ int qbman_swp_enqueue_multiple_direct(struct qbman_swp *s,
 	const uint32_t *cl = (uint32_t *)d;
 	uint32_t eqcr_ci, eqcr_pi, half_mask, full_mask;
 	int i, num_enqueued = 0;
-	uint64_t addr_cena;
 
 	spin_lock(&s->access_spinlock);
 	half_mask = (s->eqcr.pi_ci_mask>>1);
@@ -701,7 +700,6 @@ int qbman_swp_enqueue_multiple_direct(struct qbman_swp *s,
 
 	/* Flush all the cacheline without load/store in between */
 	eqcr_pi = s->eqcr.pi;
-	addr_cena = (size_t)s->addr_cena;
 	for (i = 0; i < num_enqueued; i++)
 		eqcr_pi++;
 	s->eqcr.pi = eqcr_pi & full_mask;
-- 
2.25.4

