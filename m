Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zpKB65m2DzF1lD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Feb 2018 18:15:42 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id v3so6244243plg.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 23:15:42 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/3] powerpc/pseries: put cede MSR[EE] check under
 IRQ_SOFT_MASK_DEBUG
Date: Sat, 24 Feb 2018 17:15:25 +1000
Message-Id: <20180224071527.5053-2-npiggin@gmail.com>
In-Reply-To: <20180224071527.5053-1-npiggin@gmail.com>
References: <20180224071527.5053-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This check does not catch IRQ soft mask bugs, but this option
is slightly more suitable than TRACE_IRQFLAGS.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/plpar_wrappers.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index 55eddf50d149..86f220110890 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -45,10 +45,10 @@ static inline long extended_cede_processor(unsigned long latency_hint)
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
2.16.1
