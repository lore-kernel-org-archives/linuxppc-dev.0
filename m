Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40czKR1L54zDqjk
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 03:19:55 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id e9so13934979pfi.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2018 10:19:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 02/11] powerpc/pseries: put cede MSR[EE] check under
 IRQ_SOFT_MASK_DEBUG
Date: Sat,  5 May 2018 03:19:26 +1000
Message-Id: <20180504171935.25410-3-npiggin@gmail.com>
In-Reply-To: <20180504171935.25410-1-npiggin@gmail.com>
References: <20180504171935.25410-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This check does not catch IRQ soft mask bugs, but this option is
slightly more suitable than TRACE_IRQFLAGS.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/plpar_wrappers.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index 96c1a46acbd0..cff5a411e595 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -39,10 +39,10 @@ static inline long extended_cede_processor(unsigned long latency_hint)
 	set_cede_latency_hint(latency_hint);
 
 	rc = cede_processor();
-#ifdef CONFIG_TRACE_IRQFLAGS
-		/* Ensure that H_CEDE returns with IRQs on */
-		if (WARN_ON(!(mfmsr() & MSR_EE)))
-			__hard_irq_enable();
+#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
+	/* Ensure that H_CEDE returns with IRQs on */
+	if (WARN_ON(!(mfmsr() & MSR_EE)))
+		__hard_irq_enable();
 #endif
 
 	set_cede_latency_hint(old_latency_hint);
-- 
2.17.0
