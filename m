Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xPqqx2Zv3zDqk9
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Aug 2017 03:03:25 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id p13so4853079pfd.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Aug 2017 10:03:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 09/13] powerpc/64: runlatch CTRL[RUN] set optimisation
Date: Sun,  6 Aug 2017 03:02:37 +1000
Message-Id: <20170805170241.22966-10-npiggin@gmail.com>
In-Reply-To: <20170805170241.22966-1-npiggin@gmail.com>
References: <20170805170241.22966-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CTRL register is read-only except bit 63 which is the run latch
control. This means it can be updated with a mtspr rather than
mfspr/mtspr.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/process.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 9f3e2c932dcc..75306b6e1812 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1994,11 +1994,25 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 void notrace __ppc64_runlatch_on(void)
 {
 	struct thread_info *ti = current_thread_info();
-	unsigned long ctrl;
 
-	ctrl = mfspr(SPRN_CTRLF);
-	ctrl |= CTRL_RUNLATCH;
-	mtspr(SPRN_CTRLT, ctrl);
+	if (cpu_has_feature(CPU_FTR_ARCH_206)) {
+		/*
+		 * Least significant bit (RUN) is the only writable bit of
+		 * the CTRL register, so we can avoid mfspr. 2.06 is not the
+		 * earliest ISA where this is the case, but it's convenient.
+		 */
+		mtspr(SPRN_CTRLT, CTRL_RUNLATCH);
+	} else {
+		unsigned long ctrl;
+
+		/*
+		 * Some architectures (e.g., Cell) have writable fields other
+		 * than RUN, so do the read-modify-write.
+		 */
+		ctrl = mfspr(SPRN_CTRLF);
+		ctrl |= CTRL_RUNLATCH;
+		mtspr(SPRN_CTRLT, ctrl);
+	}
 
 	ti->local_flags |= _TLF_RUNLATCH;
 }
@@ -2007,13 +2021,18 @@ void notrace __ppc64_runlatch_on(void)
 void notrace __ppc64_runlatch_off(void)
 {
 	struct thread_info *ti = current_thread_info();
-	unsigned long ctrl;
 
 	ti->local_flags &= ~_TLF_RUNLATCH;
 
-	ctrl = mfspr(SPRN_CTRLF);
-	ctrl &= ~CTRL_RUNLATCH;
-	mtspr(SPRN_CTRLT, ctrl);
+	if (cpu_has_feature(CPU_FTR_ARCH_206)) {
+		mtspr(SPRN_CTRLT, 0);
+	} else {
+		unsigned long ctrl;
+
+		ctrl = mfspr(SPRN_CTRLF);
+		ctrl &= ~CTRL_RUNLATCH;
+		mtspr(SPRN_CTRLT, ctrl);
+	}
 }
 #endif /* CONFIG_PPC64 */
 
-- 
2.11.0
