Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56D9C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 11:34:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3442082D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 11:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3442082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kCDn2lVNzDrMc
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 22:34:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kC0l1M7QzDrM8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 22:24:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42kC0k0ym3z9s3q; Mon, 29 Oct 2018 22:24:06 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42kC0h6hpwz9s9m; Mon, 29 Oct 2018 22:24:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] selftests/powerpc/cache_shape: Fix out-of-tree build
Date: Mon, 29 Oct 2018 22:23:53 +1100
Message-Id: <20181029112353.15805-5-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181029112353.15805-1-mpe@ellerman.id.au>
References: <20181029112353.15805-1-mpe@ellerman.id.au>
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
Cc: joel@jms.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use TEST_GEN_PROGS and don't redefine all, this makes the out-of-tree
build work. We need to move the extra dependencies below the include
of lib.mk, because it adds the $(OUTPUT) prefix if it's defined.

We can also drop the clean rule, lib.mk does it for us.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/cache_shape/Makefile | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/powerpc/cache_shape/Makefile b/tools/testing/selftests/powerpc/cache_shape/Makefile
index ede4d3dae750..689f6c8ebcd8 100644
--- a/tools/testing/selftests/powerpc/cache_shape/Makefile
+++ b/tools/testing/selftests/powerpc/cache_shape/Makefile
@@ -1,12 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_PROGS := cache_shape
-
-all: $(TEST_PROGS)
-
-$(TEST_PROGS): ../harness.c ../utils.c
+TEST_GEN_PROGS := cache_shape
 
 top_srcdir = ../../../../..
 include ../../lib.mk
 
-clean:
-	rm -f $(TEST_PROGS) *.o
+$(TEST_GEN_PROGS): ../harness.c ../utils.c
-- 
2.17.2

