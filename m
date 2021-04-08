Return-Path: <SRS0=7qm+=JF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4180C433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Apr 2021 04:18:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B0761107
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Apr 2021 04:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B0761107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FG7Kt5cjyz3c03
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Apr 2021 14:18:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com;
 envelope-from=lihuafei1@huawei.com; receiver=<UNKNOWN>)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FG6tW6dnBz2ysw
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Apr 2021 13:58:11 +1000 (AEST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FG6qv2lV3zyNjT;
 Thu,  8 Apr 2021 11:55:55 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 11:57:58 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <mpe@ellerman.id.au>, <benh@kernel.crashing.org>, <paulus@samba.org>,
 <npiggin@gmail.com>, <ganeshgr@linux.ibm.com>, <christophe.leroy@csgroup.eu>, 
 <mahesh@linux.ibm.com>, <clg@kaod.org>, <santosh@fossix.org>
Subject: [PATCH -next] powerpc/mce: Make symbol 'mce_ue_event_work' static
Date: Thu, 8 Apr 2021 11:58:02 +0800
Message-ID: <20210408035802.31853-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 08 Apr 2021 14:17:47 +1000
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
Cc: zhangjinhao2@huawei.com, yangjihong1@huawei.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 lihuafei1@huawei.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The sparse tool complains as follows:

arch/powerpc/kernel/mce.c:43:1: warning:
 symbol 'mce_ue_event_work' was not declared. Should it be static?

This symbol is not used outside of mce.c, so this commit marks it
static.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/powerpc/kernel/mce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 11f0cae086ed..6aa6b1cda1ed 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -40,7 +40,7 @@ static struct irq_work mce_ue_event_irq_work = {
 	.func = machine_check_ue_irq_work,
 };
 
-DECLARE_WORK(mce_ue_event_work, machine_process_ue_event);
+static DECLARE_WORK(mce_ue_event_work, machine_process_ue_event);
 
 static BLOCKING_NOTIFIER_HEAD(mce_notifier_list);
 
-- 
2.17.1

