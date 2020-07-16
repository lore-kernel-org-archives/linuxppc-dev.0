Return-Path: <SRS0=Exvj=A3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4B6C433E1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 12:24:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 668272065F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 12:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="q35X4nHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668272065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B6tjR3dY9zDqxs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 22:24:27 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B6tfK44HyzDqKN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2020 22:21:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=q35X4nHY; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4B6tfK29xqz9sSt; Thu, 16 Jul 2020 22:21:45 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4B6tfK0whDz9sT6; Thu, 16 Jul 2020 22:21:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1594902105;
 bh=60RrPK2aNaQucsqp2EqE5F8O+RE8ske4b9xZ023f6Ic=;
 h=From:To:Subject:Date:From;
 b=q35X4nHY2J5+ZAylPEjDzjoJpoe1wPlJStTx8WOHJrHJR1a5PdgP0NDDkk3ZmeKAT
 Vagh2iB7qT4Y5fB/2tkNY7glfhdUazwfb39D4ZAeJElDpROg3cpFxOph1ZX21hiX0j
 +37uTTJK+2CO3s7gwkWd9cUeE+m6QP81/k59BsI4xdxORitsTHf7N/PCHZP2s3KLNx
 8Iqi3iDPLTNME9eXJWF9pcxXu8Il4J/CKjAk8pEei3ennEfLRcZ4qFo0pVcpKpjGQO
 Sf20L5ohOiWqD4vTTG9Fs/e9kVZ3eFJTgtQSK6OV7JMRxHvczKbRoo927jwrazbO5g
 QcsLY5y5CCr7A==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] selftests/powerpc: Run per_event_excludes test on Power8 or
 later
Date: Thu, 16 Jul 2020 22:21:42 +1000
Message-Id: <20200716122142.3776261-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
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

The per_event_excludes test wants to run on Power8 or later. But
currently it checks that AT_BASE_PLATFORM *equals* power8, which means
it only runs on Power8.

Fix it to check for the ISA 2.07 feature, which will be set on Power8
and later CPUs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/pmu/per_event_excludes.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/powerpc/pmu/per_event_excludes.c b/tools/testing/selftests/powerpc/pmu/per_event_excludes.c
index 2756fe2efdc5..2d37942bf72b 100644
--- a/tools/testing/selftests/powerpc/pmu/per_event_excludes.c
+++ b/tools/testing/selftests/powerpc/pmu/per_event_excludes.c
@@ -12,6 +12,8 @@
 #include <string.h>
 #include <sys/prctl.h>
 
+#include <asm/cputable.h>
+
 #include "event.h"
 #include "lib.h"
 #include "utils.h"
@@ -23,12 +25,9 @@
 static int per_event_excludes(void)
 {
 	struct event *e, events[4];
-	char *platform;
 	int i;
 
-	platform = (char *)get_auxv_entry(AT_BASE_PLATFORM);
-	FAIL_IF(!platform);
-	SKIP_IF(strcmp(platform, "power8") != 0);
+	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_2_07));
 
 	/*
 	 * We need to create the events disabled, otherwise the running/enabled
-- 
2.25.1

