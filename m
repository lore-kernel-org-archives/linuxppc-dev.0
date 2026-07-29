Return-Path: <linuxppc-dev+bounces-24958-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F540C54F52
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 01:29:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8vrf3gFMz2ykf;
	Wed, 29 Jul 2026 11:29:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785288578;
	cv=none; b=VkkzNnQ+AxRgO8t/AA+Cx8hJJTdvrztW2ByOFmMPqnHkMiFPRA6Q7j3mcoozv7ie3nBODVDxNnnRK9TzYLc4Q/HpKCqVvWifZn7VLFiSw7xmdSGyHnteUYRlUsPFIm6BeCvxmekdDilUY0I54mLJ8H/2pzuUHVJx2YDMfgEeS4hXiR1DKCakhf5SNO8nMSMPgxIiwYQIiYS5vhTAQuBnKf/fRJsoUI2w4DnDlZInjQJ/u3WNNg4B//IW9VfWiKZpI2SoinC3LNMnCNRCNADZpLn9lbIONZXqT+QduAZ4bbEaPL7qRUNkh1KwhLfO7nomswgWDDg2NDFGXyj1q/0AHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785288578; c=relaxed/relaxed;
	bh=BxzLiWI4cdI/ksC9wsJhk90k2fWRCD0GRES3OUH/72g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e70KLxjWtWkf3ZGgYjqliPh9chWUvLUVZWa/4vcs7jPDNHuc+wQUXLRyyxP0DjAnypr9RmYbltMLwvZpMhHdGgETYJnsPzUd6LHvtc7h41QLYpK6T6xNILXR8uSXbFFXG2miUfLfF+8bTR+Kl2GbNzsJ/URBsnHO1mwy32jlYLj366E3P7jQQpSay9bOpYMh8ukICpo14kCm6cH/ddWI3SvrmkwUqt7B2IhtH1JhsaqV1JafzbJofsp0P/NiAop3FMgC1aJUjaNbjmVM01rnbff2qJFZqUzZJWqsl+H4nq6msrmGmZad87rgT/dgBTDhaQijZ6UqpsjwGoE4UB8iMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ktXP12RJ; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ktXP12RJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8vrc5x5kz2ydn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 11:29:36 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BxzLiWI4cdI/ksC9wsJhk90k2fWRCD0GRES3OUH/72g=;
	b=ktXP12RJZscAAV64qHCLX9bFBZTEthSmNzZJA32uDAc8Jl1wLU/UCJKG9ppMSBN8YTgKj42MP
	ctEVPL1wW/rBxnvWU0S9zFc66jOO/Vjv2w2HwpjycCNWS3mNp4ID7gv4FR1cg5jdOBz4ebeRJ8t
	as4UYiMhA2km2qDToX7J+8g=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4h8vdJ1jq1zcbP3;
	Wed, 29 Jul 2026 09:19:48 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C1CC40561;
	Wed, 29 Jul 2026 09:29:29 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Jul
 2026 09:29:28 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <sourabhjain@linux.ibm.com>, <rppt@kernel.org>,
	<baoquan.he@linux.dev>, <hbathini@linux.ibm.com>, <adityag@linux.ibm.com>,
	<ritesh.list@gmail.com>, <bauerman@linux.ibm.com>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2 3/3] powerpc/kexec_file: Prevent kexec range truncation
Date: Wed, 29 Jul 2026 09:29:48 +0800
Message-ID: <20260729012948.2797865-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729012948.2797865-1-ruanjinjie@huawei.com>
References: <20260729012948.2797865-1-ruanjinjie@huawei.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Sashiko AI review pointed out the following issue.

The __merge_memory_ranges() function incorrectly handles overlapping
memory ranges when merging them. Although sort_memory_ranges() sorts all
ranges by their start address in ascending order beforehand, the merge
logic remains defective in two ways:

1. It compares the current range's start against the previous element (i-1)
   instead of the running target index (idx)

2. It unconditionally overwrites 'ranges[idx].end' with 'ranges[i].end'.

This logic flaw leads to critical memory truncation when a larger memory
range completely subsumes subsequent smaller ranges.

For example, consider a sorted input array with three ranges:
  Range A (idx=0): [0x1000 - 0x9000]
  Range B (i=1):   [0x2000 - 0x5000] (completely inside Range A)
  Range C (i=2):   [0x6000 - 0x8000] (completely inside Range A)

1. When i=1 (Range B):
   ranges[1].start (0x2000) <= ranges[0].end + 1 (0x9001) is TRUE.
   The code executes: ranges[0].end = ranges[1].end, which erroneously
   shrinks Range A's end from 0x9000 down to 0x5000.

2. When i=2 (Range C):
   ranges[2].start (0x6000) <= ranges[1].end + 1 (0x5001) is FALSE.
   The code falls into the else block, creating a broken new range.

As a result, valid memory fragments [0x5001 - 0x5fff] and [0x8001 - 0x9000]
are completely lost from the kexec exclude lists, potentially allowing
the crash kernel to overwrite active memory, causing data corruption
or crashes.

Fix this by ensuring the start of the current range is compared against the
end of the active merged range (idx), and use max() to safely prevent the
outer boundary from being truncated.

Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org
Fixes: 180adfc532a8 ("powerpc/kexec_file: Add helper functions for getting memory ranges")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/powerpc/kexec/ranges.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
index e5fea23b191b..539061d14a77 100644
--- a/arch/powerpc/kexec/ranges.c
+++ b/arch/powerpc/kexec/ranges.c
@@ -21,6 +21,7 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/memblock.h>
+#include <linux/minmax.h>
 #include <linux/crash_core.h>
 #include <asm/sections.h>
 #include <asm/kexec_ranges.h>
@@ -105,19 +106,16 @@ static void __merge_memory_ranges(struct crash_mem *mem_rngs)
 	struct range *ranges;
 	int i, idx;
 
-	if (!mem_rngs)
+	if (!mem_rngs || mem_rngs->nr_ranges <= 1)
 		return;
 
 	idx = 0;
-	ranges = &(mem_rngs->ranges[0]);
+	ranges = mem_rngs->ranges;
 	for (i = 1; i < mem_rngs->nr_ranges; i++) {
-		if (ranges[i].start <= (ranges[i-1].end + 1))
-			ranges[idx].end = ranges[i].end;
+		if (ranges[i].start <= (ranges[idx].end + 1))
+			ranges[idx].end = max(ranges[idx].end, ranges[i].end);
 		else {
 			idx++;
-			if (i == idx)
-				continue;
-
 			ranges[idx] = ranges[i];
 		}
 	}
-- 
2.34.1


