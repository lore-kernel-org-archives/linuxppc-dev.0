Return-Path: <SRS0=nuQA=B5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FB5C433E1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 02:18:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE48C205CB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 02:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="cWzwY3HW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE48C205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BWWf56lMKzDqtp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 12:18:05 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BWWBT6f2VzDqsJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2020 11:57:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=cWzwY3HW; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4BWWBT5nFvz9sPC; Wed, 19 Aug 2020 11:57:37 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BWWBT4NxRz9sTg; Wed, 19 Aug 2020 11:57:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1597802257;
 bh=rNa4O4vXEy6JD2X3ZVrqL1CEBgHUoFIHyMwiNZo7m/o=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=cWzwY3HWyZqydlMIefGXQpbVFNNWKw0UdTR36zVX5vfNw5ARTT4aeG7xnt0CQvM49
 24PJ2IaTGefopgpC1JOwt+xCPmw1AYvCnEbJB45YYwi+qbZ8E/XyfC7DlDVL1gmFja
 vwHxwvTk2RZRU4pLO7VUjsLw2jb5lf8KowhY2oHzRcQycbkAi11x+qntPowgVkLFfn
 A68JtZOUNVC5nRtsoNnfEB0edlDWKuUgA0CKjS1gkAe0adJ7nTF8cZ4u+z+yjamVTe
 lYoE/hJn8x1+Ohrf6gsNiuxFM82FfGGnRVTxL/akWUdbLWRQ4Hi12OAPA5jKgmOrHy
 eeqxw0FVa250w==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 7/9] selftests/powerpc: Skip L3 bank test on older CPUs
Date: Wed, 19 Aug 2020 11:57:25 +1000
Message-Id: <20200819015727.1977134-7-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819015727.1977134-1-mpe@ellerman.id.au>
References: <20200819015727.1977134-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This is a test of specific piece of logic in isa207-common.c, which is
only used on Power8 or later. So skip it on older CPUs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/pmu/l3_bank_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/powerpc/pmu/l3_bank_test.c b/tools/testing/selftests/powerpc/pmu/l3_bank_test.c
index a96d512a18c4..a5dfa9bf3b9f 100644
--- a/tools/testing/selftests/powerpc/pmu/l3_bank_test.c
+++ b/tools/testing/selftests/powerpc/pmu/l3_bank_test.c
@@ -20,6 +20,9 @@ static int l3_bank_test(void)
 	char *p;
 	int i;
 
+	// The L3 bank logic is only used on Power8 or later
+	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_2_07));
+
 	p = malloc(MALLOC_SIZE);
 	FAIL_IF(!p);
 
-- 
2.25.1

