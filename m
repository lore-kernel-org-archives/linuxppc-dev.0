Return-Path: <linuxppc-dev+bounces-22818-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3304CD4F26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 12:09:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghbxh0ntWz3bpm;
	Fri, 19 Jun 2026 22:09:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781870984;
	cv=none; b=R7ZTFOfOlCEMnnOZsuE3a4Dsg6QRJzy/oQlP/u3Q1ji+p4IU1nCKrFQvoDAXGCdIYCOuDSk9LgG8P6Ti/w+pjbqkGSZL+QlGKj2T/LY5MCpXsWg9KawoSZboThMt5ThJEZDpLZYD8zdoZTb//5KKG7y8SV9W8Z1IWIuAScv4NxVntd3kvHTtoOU7P80toXn4pvZybicpFg+h2PWAT7elLxrAS3Ipq6O/WUV7W3D7oHpq4xzVHR8pnbbo2G2Mmj3RgadxmUhj4pqBagAzxq6V1eOfuEPEpDmM65nlzMRFQFI1Y2DSECnquUHlXWsm3xDsI6nT13/+e9Fpl/wwy6dmjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781870984; c=relaxed/relaxed;
	bh=0GS0A+IFgITksiTouHWoieJdGp3AW5vhPLcHf+koJZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D6YpyEC5Bj6Me8zAXpFTn2QProveegWYfmLjEdWagdv94yKxijXJMLLco8NqpCvZHniWfuLniPFjcTwQv5J497xmnoeq3D1IJLI98z0dkcBDzPKL04TRbwiM/XbrPttRdLh5AKwL1HfYattOutsgtWxTTUBaLecikOkuhahbZi/2MMhFDQpb9Uu7zJpifjfRg59paCyJzOuTU71iilhdm8PREEeXHNXDBaCWI9krzmhg+wXqzWJjP8rAqbakNLLWSf2g/8Ied5tKkB7i0DxMOJcUoyjRr2VPybrKGb1q7sOfpBqlkaq/Zs7eIr1L0ZHsxvWKmGdY+xYFodp2+XVEaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KNry+8kk; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KNry+8kk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghbxg21vFz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 22:09:43 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C36AD601E1;
	Fri, 19 Jun 2026 12:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268961F00A3E;
	Fri, 19 Jun 2026 12:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781870979;
	bh=0GS0A+IFgITksiTouHWoieJdGp3AW5vhPLcHf+koJZg=;
	h=From:To:Cc:Subject:Date;
	b=KNry+8kkVktj0ZhaKHcA0HiSe/u4p1ROZqCSKW3Db2MO0nOo4lMnhmpnZEEf0B0Pz
	 o5MgVbi+hItnBSsN6pP/2T5f2orypo6fXjFCi+FgkOQFus0kiLDbtpjCNqsbrG2jr/
	 Z1kGkDTRkOfYcx1IQx92eBvyJ0MS/tLZwlKjxGVhzWwwI2P4qZbPl6aIjdcw+1AWEo
	 8p8YJkPygFPvrobz2RDQBdW5JMqPgNSlapePaCf949qSUmX1fWes4RiyVIhJV429E0
	 8RqQW82CmUKokgdQ7mm6wvjL12TSuRMoaFDFDsu7uGEqd4YbkHs169IpeOiUnuvj6k
	 i533b5F/9noVA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Remove dead non-preemption code
Date: Fri, 19 Jun 2026 14:08:28 +0200
Message-ID: <2bf10a0afffefb6aca44bf2f864cc17471a80e31.1781870889.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2071; i=chleroy@kernel.org; h=from:subject:message-id; bh=uEC5u4MSNV152j4uKm5LKCFNpyVETvn3Vh+1CHcRLp4=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWSZGpYsW+BQdsrRYN3pkJMdraZHrE/Va0QJbGee3VGzl u3xlFMXOkpZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBEvs1mZGid8CR2yf+T62Ui Z2udSs576tb/uvrKNivlM3d2hcy7xdDB8D+rO0T/W++Ba5LMEr4HDesW72D7YBew3bVRRit6kbg 4KwsA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Since commit 7dadeaa6e851 ("sched: Further restrict the preemption
modes"), powerpc always has CONFIG_PREEMPTION because only
CONFIG_PREEMPT and CONFIG_PREEMPT_LAZY are possible, even in
dynamic preemption mode (see sched_dynamic_mode).

As a consequence, need_irq_preemption() is always true and can be
removed.

And because commit bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY
feature") includes linux/irq-entry-common.h which already declares
sk_dynamic_irqentry_exit_cond_resched static key, asm/preempt.h
becauses useless and can be removed.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/powerpc/include/asm/preempt.h | 16 ----------------
 arch/powerpc/lib/vmx-helper.c      |  2 +-
 2 files changed, 1 insertion(+), 17 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/preempt.h

diff --git a/arch/powerpc/include/asm/preempt.h b/arch/powerpc/include/asm/preempt.h
deleted file mode 100644
index 000e2b9681f3..000000000000
--- a/arch/powerpc/include/asm/preempt.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_POWERPC_PREEMPT_H
-#define __ASM_POWERPC_PREEMPT_H
-
-#include <asm-generic/preempt.h>
-
-#if defined(CONFIG_PREEMPT_DYNAMIC)
-#include <linux/jump_label.h>
-DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
-#define need_irq_preemption() \
-	(static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
-#else
-#define need_irq_preemption()   (IS_ENABLED(CONFIG_PREEMPTION))
-#endif
-
-#endif /* __ASM_POWERPC_PREEMPT_H */
diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx-helper.c
index 57e897b60db8..cc9fb72cb4eb 100644
--- a/arch/powerpc/lib/vmx-helper.c
+++ b/arch/powerpc/lib/vmx-helper.c
@@ -46,7 +46,7 @@ int exit_vmx_usercopy(void)
 	 * set and we are preemptible. The hack here is to schedule a
 	 * decrementer to fire here and reschedule for us if necessary.
 	 */
-	if (need_irq_preemption() && need_resched())
+	if (need_resched())
 		set_dec(1);
 	return 0;
 }
-- 
2.54.0


