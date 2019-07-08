Return-Path: <SRS0=cjtt=VF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A21C48BE7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 06:12:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D70E20844
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 06:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D70E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45hw8b0Br1zDqP3
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 16:12:15 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45hw701nM6zDqNJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jul 2019 16:10:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 45hw700wrbz9sN1; Mon,  8 Jul 2019 16:10:52 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45hw700h6pz9sN4; Mon,  8 Jul 2019 16:10:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/irq: Don't WARN continuously in
 arch_local_irq_restore()
Date: Mon,  8 Jul 2019 16:10:46 +1000
Message-Id: <20190708061046.7075-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When CONFIG_PPC_IRQ_SOFT_MASK_DEBUG is enabled (uncommon), we have a
series of WARN_ON's in arch_local_irq_restore().

These are "should never happen" conditions, but if they do happen they
can flood the console and render the system unusable. So switch them
to WARN_ON_ONCE().

Fixes: e2b36d591720 ("powerpc/64: Don't trace code that runs with the soft irq mask unreconciled")
Fixes: 9b81c0211c24 ("powerpc/64s: make PACA_IRQ_HARD_DIS track MSR[EE] closely")
Fixes: 7c0482e3d055 ("powerpc/irq: Fix another case of lazy IRQ state getting out of sync")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index ada901af4950..c9a6eac3075c 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -259,7 +259,7 @@ notrace void arch_local_irq_restore(unsigned long mask)
 	irq_happened = get_irq_happened();
 	if (!irq_happened) {
 #ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
-		WARN_ON(!(mfmsr() & MSR_EE));
+		WARN_ON_ONCE(!(mfmsr() & MSR_EE));
 #endif
 		return;
 	}
@@ -272,7 +272,7 @@ notrace void arch_local_irq_restore(unsigned long mask)
 	 */
 	if (!(irq_happened & PACA_IRQ_HARD_DIS)) {
 #ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
-		WARN_ON(!(mfmsr() & MSR_EE));
+		WARN_ON_ONCE(!(mfmsr() & MSR_EE));
 #endif
 		__hard_irq_disable();
 #ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
@@ -283,7 +283,7 @@ notrace void arch_local_irq_restore(unsigned long mask)
 		 * warn if we are wrong. Only do that when IRQ tracing
 		 * is enabled as mfmsr() can be costly.
 		 */
-		if (WARN_ON(mfmsr() & MSR_EE))
+		if (WARN_ON_ONCE(mfmsr() & MSR_EE))
 			__hard_irq_disable();
 #endif
 	}
-- 
2.20.1

