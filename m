Return-Path: <SRS0=wwxH=H2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD1DC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Feb 2021 12:22:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B9A64ED1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Feb 2021 12:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B9A64ED1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dlw5s3GM3z3cjr
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Feb 2021 23:22:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=canonical.com
 (client-ip=91.189.89.112; helo=youngberry.canonical.com;
 envelope-from=cascardo@canonical.com; receiver=<UNKNOWN>)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dlw5W62s7z30MG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2021 23:21:51 +1100 (AEDT)
Received: from 1.general.cascardo.us.vpn ([10.172.70.58]
 helo=localhost.localdomain) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <cascardo@canonical.com>)
 id 1lEtAm-0000rM-VA; Wed, 24 Feb 2021 12:21:45 +0000
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/perf: prevent mixed EBB and non-EBB events
Date: Wed, 24 Feb 2021 09:21:16 -0300
Message-Id: <20210224122116.221120-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.27.0
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
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, cascardo@canonical.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

EBB events must be under exclusive groups, so there is no mix of EBB and
non-EBB events on the same PMU. This requirement worked fine as perf core
would not allow other pinned events to be scheduled together with exclusive
events.

This assumption was broken by commit 1908dc911792 ("perf: Tweak
perf_event_attr::exclusive semantics").

After that, the test cpu_event_pinned_vs_ebb_test started succeeding after
read_events, but worse, the task would not have given access to PMC1, so
when it tried to write to it, it was killed with "illegal instruction".

Preventing mixed EBB and non-EBB events from being add to the same PMU will
just revert to the previous behavior and the test will succeed.

Fixes: 1908dc911792 (perf: Tweak perf_event_attr::exclusive semantics)
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 arch/powerpc/perf/core-book3s.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 43599e671d38..d767f7944f85 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1010,9 +1010,25 @@ static int check_excludes(struct perf_event **ctrs, unsigned int cflags[],
 			  int n_prev, int n_new)
 {
 	int eu = 0, ek = 0, eh = 0;
+	bool ebb = false;
 	int i, n, first;
 	struct perf_event *event;
 
+	n = n_prev + n_new;
+	if (n <= 1)
+		return 0;
+
+	first = 1;
+	for (i = 0; i < n; ++i) {
+		event = ctrs[i];
+		if (first) {
+			ebb = is_ebb_event(event);
+			first = 0;
+		} else if (is_ebb_event(event) != ebb) {
+			return -EAGAIN;
+		}
+	}
+
 	/*
 	 * If the PMU we're on supports per event exclude settings then we
 	 * don't need to do any of this logic. NB. This assumes no PMU has both
@@ -1021,10 +1037,6 @@ static int check_excludes(struct perf_event **ctrs, unsigned int cflags[],
 	if (ppmu->flags & PPMU_ARCH_207S)
 		return 0;
 
-	n = n_prev + n_new;
-	if (n <= 1)
-		return 0;
-
 	first = 1;
 	for (i = 0; i < n; ++i) {
 		if (cflags[i] & PPMU_LIMITED_PMC_OK) {
-- 
2.27.0

