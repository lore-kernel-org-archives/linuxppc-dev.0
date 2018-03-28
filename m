Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B2cc40YRzF2KC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 20:28:32 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id g20-v6so1219154plo.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 02:28:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/5] powerpc/64: remove start_tb and accum_tb from
 thread_struct
Date: Wed, 28 Mar 2018 19:28:15 +1000
Message-Id: <20180328092819.27015-2-npiggin@gmail.com>
In-Reply-To: <20180328092819.27015-1-npiggin@gmail.com>
References: <20180328092819.27015-1-npiggin@gmail.com>
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
index 01299cdc9806..67eedcc6d803 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -251,10 +251,6 @@ struct thread_struct {
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
index ec4f363ebb89..9626b991da52 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1169,11 +1169,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
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
2.16.1
