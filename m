Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D28FECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 04:08:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC8992145D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 04:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8992145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bspD54ZpzF3RY
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 15:08:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bsmD5YjHzF3Nd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 15:06:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42bsmD2YJkz9sDJ; Fri, 19 Oct 2018 15:06:20 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42bsmD1kvQz9sDK; Fri, 19 Oct 2018 15:06:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] selftests/powerpc: Fix out-of-tree build errors
Date: Fri, 19 Oct 2018 15:06:16 +1100
Message-Id: <20181019040616.345-1-mpe@ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Some of our Makefiles don't do the right thing when building the
selftests with O=, fix them up.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/cache_shape/Makefile   | 2 --
 tools/testing/selftests/powerpc/ptrace/Makefile        | 2 --
 tools/testing/selftests/powerpc/signal/Makefile        | 2 --
 tools/testing/selftests/powerpc/switch_endian/Makefile | 1 +
 4 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/testing/selftests/powerpc/cache_shape/Makefile b/tools/testing/selftests/powerpc/cache_shape/Makefile
index ede4d3dae750..62e947ca9921 100644
--- a/tools/testing/selftests/powerpc/cache_shape/Makefile
+++ b/tools/testing/selftests/powerpc/cache_shape/Makefile
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_PROGS := cache_shape
 
-all: $(TEST_PROGS)
-
 $(TEST_PROGS): ../harness.c ../utils.c
 
 top_srcdir = ../../../../..
diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index 9b35ca8e8f13..6ac71b629276 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -7,8 +7,6 @@ TEST_PROGS := ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr \
 top_srcdir = ../../../../..
 include ../../lib.mk
 
-all: $(TEST_PROGS)
-
 CFLAGS += -m64 -I../../../../../usr/include -I../tm -mhtm -fno-pie
 
 ptrace-pkey core-pkey: child.h
diff --git a/tools/testing/selftests/powerpc/signal/Makefile b/tools/testing/selftests/powerpc/signal/Makefile
index 1fca25c6ace0..d34a7c7710db 100644
--- a/tools/testing/selftests/powerpc/signal/Makefile
+++ b/tools/testing/selftests/powerpc/signal/Makefile
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_PROGS := signal signal_tm
 
-all: $(TEST_PROGS)
-
 $(TEST_PROGS): ../harness.c ../utils.c signal.S
 
 CFLAGS += -maltivec
diff --git a/tools/testing/selftests/powerpc/switch_endian/Makefile b/tools/testing/selftests/powerpc/switch_endian/Makefile
index fcd2dcb8972b..bdc081afedb0 100644
--- a/tools/testing/selftests/powerpc/switch_endian/Makefile
+++ b/tools/testing/selftests/powerpc/switch_endian/Makefile
@@ -8,6 +8,7 @@ EXTRA_CLEAN = $(OUTPUT)/*.o $(OUTPUT)/check-reversed.S
 top_srcdir = ../../../../..
 include ../../lib.mk
 
+$(OUTPUT)/switch_endian_test: ASFLAGS += -I $(OUTPUT)
 $(OUTPUT)/switch_endian_test: $(OUTPUT)/check-reversed.S
 
 $(OUTPUT)/check-reversed.o: $(OUTPUT)/check.o
-- 
2.17.2

