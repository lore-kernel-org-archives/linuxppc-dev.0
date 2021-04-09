Return-Path: <SRS0=fTJU=JG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F561C433B4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Apr 2021 10:00:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF776115B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Apr 2021 10:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF776115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FGtsw0DMgz3br7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Apr 2021 20:00:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com;
 envelope-from=zhengzucheng@huawei.com; receiver=<UNKNOWN>)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FGtNP6lLgz2xb6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Apr 2021 19:38:13 +1000 (AEST)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGtK61pdJzPpZZ;
 Fri,  9 Apr 2021 17:35:22 +0800 (CST)
Received: from huawei.com (10.67.174.166) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 17:38:09 +0800
From: Zucheng Zheng <zhengzucheng@huawei.com>
To: <benh@kernel.crashing.org>, <mpe@ellerman.id.au>, <paulus@samba.org>,
 <rppt@kernel.org>, <christophe.leroy@csgroup.eu>,
 <akpm@linux-foundation.org>, <oohall@gmail.com>
Subject: [PATCH -next] powerpc/pmac: Make some symbols static
Date: Fri, 9 Apr 2021 17:38:15 +0800
Message-ID: <20210409093815.118619-1-zhengzucheng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.166]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Fri, 09 Apr 2021 19:59:37 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

ppc_override_l2cr/ppc_override_l2cr_value/has_l2cache symbol is not used
outside of setup.c, so commit marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zucheng Zheng <zhengzucheng@huawei.com>
---
 arch/powerpc/platforms/powermac/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 86aee3f2483f..db5107c80485 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -71,9 +71,9 @@
 
 #undef SHOW_GATWICK_IRQS
 
-int ppc_override_l2cr = 0;
-int ppc_override_l2cr_value;
-int has_l2cache = 0;
+static int ppc_override_l2cr;
+static int ppc_override_l2cr_value;
+static int has_l2cache;
 
 int pmac_newworld;
 
-- 
2.17.1

