Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAD9C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Apr 2022 06:47:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KnXVz04Ksz3bd5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Apr 2022 16:47:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=meizu.com (client-ip=112.91.151.210; helo=mail.meizu.com;
 envelope-from=baihaowen@meizu.com; receiver=<UNKNOWN>)
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KnXVR5N3bz2xF8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2022 16:46:51 +1000 (AEST)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 26 Apr
 2022 14:46:27 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 26 Apr
 2022 14:46:25 +0800
From: Haowen Bai <baihaowen@meizu.com>
To: <kjain@linux.ibm.com>
Subject: [PATCH V2] selftests/powerpc/pmu: Fix unsigned function returning
 negative constant
Date: Tue, 26 Apr 2022 14:46:23 +0800
Message-ID: <1650955583-29581-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <0e4b0f8e-6c45-8d14-303f-2168f5004a12@linux.ibm.com>
References: <0e4b0f8e-6c45-8d14-303f-2168f5004a12@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
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
Cc: shuah@kernel.org, baihaowen@meizu.com, linux-kernel@vger.kernel.org,
 paulus@samba.org, linux-kselftest@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The function __perf_reg_mask has an unsigned return type, but returns a
negative constant to indicate an error condition. So we change unsigned
to int.

Fixes: 5f6c3061af7c ("selftests/powerpc/pmu: Add utility functions to post
process the mmap buffer")

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
V1->V2: add fix tag.

 tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c b/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c
index fca054bbc094..c01a31d5f4ee 100644
--- a/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c
+++ b/tools/testing/selftests/powerpc/pmu/sampling_tests/misc.c
@@ -274,7 +274,7 @@ u64 *get_intr_regs(struct event *event, void *sample_buff)
 	return intr_regs;
 }
 
-static const unsigned int __perf_reg_mask(const char *register_name)
+static const int __perf_reg_mask(const char *register_name)
 {
 	if (!strcmp(register_name, "R0"))
 		return 0;
-- 
2.7.4

