Return-Path: <SRS0=qf4I=IN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6509DC433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 12:05:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE0C64E41
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 12:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE0C64E41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DzZqw1JTBz302b
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 23:05:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.35; helo=szxga07-in.huawei.com;
 envelope-from=heying24@huawei.com; receiver=<UNKNOWN>)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DzZqY6FMGz2xgB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Mar 2021 23:05:12 +1100 (AEDT)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DzZnF3C5wz8xYP;
 Mon, 15 Mar 2021 20:03:13 +0800 (CST)
Received: from huawei.com (10.67.174.47) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Mon, 15 Mar 2021
 20:04:56 +0800
From: He Ying <heying24@huawei.com>
To: <mpe@ellerman.id.au>, <benh@kernel.crashing.org>, <paulus@samba.org>,
 <npiggin@gmail.com>, <dja@axtens.net>, <akpm@linux-foundation.org>,
 <rppt@kernel.org>, <aneesh.kumar@linux.ibm.com>, <clg@kaod.org>
Subject: [PATCH] powerpc: Fix missing prototype problems for
 "arch/powerpc/kernel/setup_64.c"
Date: Mon, 15 Mar 2021 08:04:44 -0400
Message-ID: <20210315120444.215905-1-heying24@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.47]
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
Cc: johnny.chenyi@huawei.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The variables 'uaccess_fulsh' and 'entry_flush' are not referenced
outside the file. So define them as static to avoid the warnings.

And add a prototype for the function 'panic_smp_self_stop' for the
same purpose.

Sparse also warns that 'rfi_flush' should be static. However, it's
referenced outside the file.

The warnings about the file reported by sparse are as follows:
arch/powerpc/kernel/setup_64.c:422:6: warning: symbol 'panic_smp_self_stop' was not declared. Should it be static?
arch/powerpc/kernel/setup_64.c:951:6: warning: symbol 'rfi_flush' was not declared. Should it be static?
arch/powerpc/kernel/setup_64.c:952:6: warning: symbol 'entry_flush' was not declared. Should it be static?
arch/powerpc/kernel/setup_64.c:953:6: warning: symbol 'uaccess_flush' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: He Ying <heying24@huawei.com>
---
 arch/powerpc/kernel/setup_64.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 560ed8b975e7..603aacd8527b 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -71,6 +71,8 @@
 
 #include "setup.h"
 
+extern void panic_smp_self_stop(void);
+
 int spinning_secondaries;
 u64 ppc64_pft_size;
 
@@ -949,8 +951,8 @@ static bool no_rfi_flush;
 static bool no_entry_flush;
 static bool no_uaccess_flush;
 bool rfi_flush;
-bool entry_flush;
-bool uaccess_flush;
+static bool entry_flush;
+static bool uaccess_flush;
 DEFINE_STATIC_KEY_FALSE(uaccess_flush_key);
 EXPORT_SYMBOL(uaccess_flush_key);
 
-- 
2.17.1

