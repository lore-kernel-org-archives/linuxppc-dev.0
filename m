Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1E7C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 11:26:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85AA22082D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 11:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AA22082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kC333mDtzDrvG
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 22:26:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kC0d1pJLzDrL6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 22:24:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42kC0b06g1z9s3q; Mon, 29 Oct 2018 22:23:59 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42kC0Z3KXYz9s9J; Mon, 29 Oct 2018 22:23:57 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] selftests/powerpc/ptrace: Fix out-of-tree build
Date: Mon, 29 Oct 2018 22:23:49 +1100
Message-Id: <20181029112353.15805-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.2
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

From: Joel Stanley <joel@jms.id.au>

We should use TEST_GEN_PROGS, not TEST_PROGS. That tells the selftests
makefile (lib.mk) that those tests are generated (built), and so it
adds the $(OUTPUT) prefix for us, making the out-of-tree build work
correctly.

It also means we don't need our own clean rule, lib.mk does it.

We also have to update the ptrace-pkey and core-pkey rules to use
$(OUTPUT).

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/ptrace/Makefile | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index 9b35ca8e8f13..8d3f006c98cc 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_PROGS := ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr \
+TEST_GEN_PROGS := ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr \
               ptrace-tar ptrace-tm-tar ptrace-tm-spd-tar ptrace-vsx ptrace-tm-vsx \
               ptrace-tm-spd-vsx ptrace-tm-spr ptrace-hwbreak ptrace-pkey core-pkey \
               perf-hwbreak ptrace-syscall
@@ -7,14 +7,9 @@ TEST_PROGS := ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr \
 top_srcdir = ../../../../..
 include ../../lib.mk
 
-all: $(TEST_PROGS)
-
 CFLAGS += -m64 -I../../../../../usr/include -I../tm -mhtm -fno-pie
 
-ptrace-pkey core-pkey: child.h
-ptrace-pkey core-pkey: LDLIBS += -pthread
-
-$(TEST_PROGS): ../harness.c ../utils.c ../lib/reg.S ptrace.h
+$(OUTPUT)/ptrace-pkey $(OUTPUT)/core-pkey: child.h
+$(OUTPUT)/ptrace-pkey $(OUTPUT)/core-pkey: LDLIBS += -pthread
 
-clean:
-	rm -f $(TEST_PROGS) *.o
+$(TEST_GEN_PROGS): ../harness.c ../utils.c ../lib/reg.S ptrace.h
-- 
2.17.2

