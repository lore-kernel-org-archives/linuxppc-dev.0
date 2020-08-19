Return-Path: <SRS0=nuQA=B5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0F4C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 02:10:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B2020738
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 02:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="D7SCrTBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B2020738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BWWTh2hTnzDq9T
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 12:10:48 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BWWBS3CtgzDqsJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2020 11:57:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=D7SCrTBe; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4BWWBQ6qhQz9sPC; Wed, 19 Aug 2020 11:57:34 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BWWBQ4vrgz9sTg; Wed, 19 Aug 2020 11:57:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1597802254;
 bh=DymT0kLzg9Tf/u2TjpQq8hazeDb5T+7qPUv+otiurkg=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=D7SCrTBe3FNpUaLa+gxoHlOi2wuDuw9p80RvE5MMFxdjO1EEnro9DlSodjOznHyVe
 97Y/8MwsjBRVGofiQaSjPeab2+ZffxAMNQoRhM+gZRgrn1wPdfomwy0a+3eu2gVmIQ
 ZI2tS6i/nrY0bDNefL65JKBmpD76M6yHbZqf+5wNfaYhylV4awBYgJXlZ2vQRDSunJ
 hFVmiJk4aDpVDfhJoUNo/AxQmwnbS064q7+J8BU07B9w+AsEmRIaS06KgIoP0uJiFZ
 5EkURO51MfCey3+KDv6wTu9CXJYegYLeolCOZ4JGXoz3lfJ7S43leTvvAmsniezQ0X
 GKr8ONAruqzIQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/9] selftests/powerpc: Include asm/cputable.h from utils.h
Date: Wed, 19 Aug 2020 11:57:22 +1000
Message-Id: <20200819015727.1977134-4-mpe@ellerman.id.au>
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

utils.h provides have_hwcap() and have_hwcap2() which check for a
feature bit. Those bits are defined in asm/cputable.h, so include it
in utils.h so users of utils.h don't have to do it manually.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/alignment/alignment_handler.c | 2 --
 tools/testing/selftests/powerpc/include/utils.h               | 1 +
 tools/testing/selftests/powerpc/pmu/count_stcx_fail.c         | 1 -
 tools/testing/selftests/powerpc/pmu/per_event_excludes.c      | 2 --
 tools/testing/selftests/powerpc/stringloops/memcmp.c          | 2 +-
 tools/testing/selftests/powerpc/tm/tm.h                       | 3 +--
 6 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/powerpc/alignment/alignment_handler.c b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
index 55ef15184057..e4063eba4a5b 100644
--- a/tools/testing/selftests/powerpc/alignment/alignment_handler.c
+++ b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
@@ -55,8 +55,6 @@
 #include <setjmp.h>
 #include <signal.h>
 
-#include <asm/cputable.h>
-
 #include "utils.h"
 #include "instructions.h"
 
diff --git a/tools/testing/selftests/powerpc/include/utils.h b/tools/testing/selftests/powerpc/include/utils.h
index bba400d1bb90..052b5a775dc2 100644
--- a/tools/testing/selftests/powerpc/include/utils.h
+++ b/tools/testing/selftests/powerpc/include/utils.h
@@ -12,6 +12,7 @@
 #include <stdbool.h>
 #include <linux/auxvec.h>
 #include <linux/perf_event.h>
+#include <asm/cputable.h>
 #include "reg.h"
 
 /* Avoid headaches with PRI?64 - just use %ll? always */
diff --git a/tools/testing/selftests/powerpc/pmu/count_stcx_fail.c b/tools/testing/selftests/powerpc/pmu/count_stcx_fail.c
index 2980abca31e0..2070a1e2b3a5 100644
--- a/tools/testing/selftests/powerpc/pmu/count_stcx_fail.c
+++ b/tools/testing/selftests/powerpc/pmu/count_stcx_fail.c
@@ -9,7 +9,6 @@
 #include <stdbool.h>
 #include <string.h>
 #include <sys/prctl.h>
-#include <asm/cputable.h>
 
 #include "event.h"
 #include "utils.h"
diff --git a/tools/testing/selftests/powerpc/pmu/per_event_excludes.c b/tools/testing/selftests/powerpc/pmu/per_event_excludes.c
index 2d37942bf72b..ad32a09a6540 100644
--- a/tools/testing/selftests/powerpc/pmu/per_event_excludes.c
+++ b/tools/testing/selftests/powerpc/pmu/per_event_excludes.c
@@ -12,8 +12,6 @@
 #include <string.h>
 #include <sys/prctl.h>
 
-#include <asm/cputable.h>
-
 #include "event.h"
 #include "lib.h"
 #include "utils.h"
diff --git a/tools/testing/selftests/powerpc/stringloops/memcmp.c b/tools/testing/selftests/powerpc/stringloops/memcmp.c
index 979df3d98368..cb2f18855c8d 100644
--- a/tools/testing/selftests/powerpc/stringloops/memcmp.c
+++ b/tools/testing/selftests/powerpc/stringloops/memcmp.c
@@ -4,7 +4,7 @@
 #include <string.h>
 #include <sys/mman.h>
 #include <time.h>
-#include <asm/cputable.h>
+
 #include "utils.h"
 
 #define SIZE 256
diff --git a/tools/testing/selftests/powerpc/tm/tm.h b/tools/testing/selftests/powerpc/tm/tm.h
index c402464b038f..c5a1e5c163fc 100644
--- a/tools/testing/selftests/powerpc/tm/tm.h
+++ b/tools/testing/selftests/powerpc/tm/tm.h
@@ -6,9 +6,8 @@
 #ifndef _SELFTESTS_POWERPC_TM_TM_H
 #define _SELFTESTS_POWERPC_TM_TM_H
 
-#include <asm/tm.h>
-#include <asm/cputable.h>
 #include <stdbool.h>
+#include <asm/tm.h>
 
 #include "utils.h"
 
-- 
2.25.1

