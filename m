Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40czKb6vFCzDqnn
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 03:20:03 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id 82-v6so15851887pge.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2018 10:20:03 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 05/11] powerpc/64: remove start_tb and accum_tb from
 thread_struct
Date: Sat,  5 May 2018 03:19:29 +1000
Message-Id: <20180504171935.25410-6-npiggin@gmail.com>
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

These fields are only written to.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/processor.h | 4 ----
 arch/powerpc/kernel/process.c        | 6 +-----
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index c4b36a494a63..eff269adfa71 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -264,10 +264,6 @@ struct thread_struct {
 	struct thread_fp_state	*fp_save_area;
 	int		fpexc_mode;	/* floating-point exception mode */
 	unsigned int	align_ctl;	/* alignment handling control */
-#ifdef CONFIG_PPC64
-	unsigned long	start_tb;	/* Start purr when proc switched in */
-	unsigned long	accum_tb;	/* Total accumulated purr for process */
-#endif
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	struct perf_event *ptrace_bps[HBP_NUM];
 	/*
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 1237f13fed51..ff7344d996e3 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1187,11 +1187,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	 */
 	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
 		struct cpu_usage *cu = this_cpu_ptr(&cpu_usage_array);
-		long unsigned start_tb, current_tb;
-		start_tb = old_thread->start_tb;
-		cu->current_tb = current_tb = mfspr(SPRN_PURR);
-		old_thread->accum_tb += (current_tb - start_tb);
-		new_thread->start_tb = current_tb;
+		cu->current_tb = mfspr(SPRN_PURR);
 	}
 #endif /* CONFIG_PPC64 */
 
-- 
2.17.0
