Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15050C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 10:19:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92EB420883
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 10:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92EB420883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qj7d3QLNzF3H0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 21:19:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qj5g2X5wzF2HT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 21:17:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42qj5g18xNz9sBh; Wed,  7 Nov 2018 21:17:27 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42qj5g0wh2z9sCw; Wed,  7 Nov 2018 21:17:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] selftests/powerpc: Fix wild_bctr test to work on BE
Date: Wed,  7 Nov 2018 21:17:23 +1100
Message-Id: <20181107101723.24970-1-mpe@ellerman.id.au>
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

The selftest I recently added to test branching to an out-of-bounds
NIP doesn't work on big endian. It does fail but not in the right way.
That is it SEGVs trying to load from the opd at BAD_NIP, but it never
gets as far as branching to BAD_NIP.

To fix it we need to create an opd which is reachable but which holds
the bad address.

Fixes: b7683fc66eba ("selftests/powerpc: Add a test of wild bctr")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/mm/wild_bctr.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/mm/wild_bctr.c b/tools/testing/selftests/powerpc/mm/wild_bctr.c
index 1b0e9e9a2ddc..dda314bb59dd 100644
--- a/tools/testing/selftests/powerpc/mm/wild_bctr.c
+++ b/tools/testing/selftests/powerpc/mm/wild_bctr.c
@@ -105,6 +105,20 @@ static void dump_regs(void)
 	}
 }
 
+#ifdef __BIG_ENDIAN__
+struct opd {
+	unsigned long ip;
+	unsigned long toc;
+	unsigned long env;
+};
+static struct opd bad_opd = {
+	.ip = BAD_NIP,
+};
+#define BAD_FUNC (&bad_opd)
+#else
+#define BAD_FUNC BAD_NIP
+#endif
+
 int test_wild_bctr(void)
 {
 	int (*func_ptr)(void);
@@ -133,7 +147,7 @@ int test_wild_bctr(void)
 
 		poison_regs();
 
-		func_ptr = (int (*)(void))BAD_NIP;
+		func_ptr = (int (*)(void))BAD_FUNC;
 		func_ptr();
 
 		FAIL_IF(1); /* we didn't segv? */
-- 
2.17.2

