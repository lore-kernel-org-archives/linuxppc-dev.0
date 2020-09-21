Return-Path: <SRS0=a2eB=C6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC23C43464
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2020 11:32:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 075AE20874
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2020 11:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075AE20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bw2Nv2pS9zDqfD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2020 21:32:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=wangwensheng4@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bw2JM3SgZzDq5n
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2020 21:28:51 +1000 (AEST)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 61D5732AC86CC64EB1AB;
 Mon, 21 Sep 2020 19:28:47 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 19:28:40 +0800
From: Wang Wensheng <wangwensheng4@huawei.com>
To: <mpe@ellerman.id.au>, <benh@kernel.crashing.org>, <paulus@samba.org>,
 <sourabhjain@linux.ibm.com>, <wangwensheng4@huawei.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] powerpc/opalcore: Fix symbol undeclared warning
Date: Mon, 21 Sep 2020 11:26:01 +0000
Message-ID: <20200921112601.85543-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Build kernel with `C=2`:
arch/powerpc/platforms/powernv/opal-core.c:74:16: warning: symbol
'mpipl_kobj' was not declared. Should it be static?

Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 arch/powerpc/platforms/powernv/opal-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
index 6dba3b62269f..c25f9f254f05 100644
--- a/arch/powerpc/platforms/powernv/opal-core.c
+++ b/arch/powerpc/platforms/powernv/opal-core.c
@@ -71,7 +71,7 @@ static LIST_HEAD(opalcore_list);
 static struct opalcore_config *oc_conf;
 static const struct opal_mpipl_fadump *opalc_metadata;
 static const struct opal_mpipl_fadump *opalc_cpu_metadata;
-struct kobject *mpipl_kobj;
+static struct kobject *mpipl_kobj;
 
 /*
  * Set crashing CPU's signal to SIGUSR1. if the kernel is triggered
-- 
2.25.0

