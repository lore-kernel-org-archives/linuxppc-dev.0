Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk90Z72vHzDqNZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 01:52:14 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id v18so4996726pgb.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 08:52:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 13/14] powerpc/64: runlatch CTRL[RUN] set optimisation
Date: Fri,  9 Jun 2017 01:51:12 +1000
Message-Id: <20170608155113.21300-14-npiggin@gmail.com>
In-Reply-To: <20170608155113.21300-1-npiggin@gmail.com>
References: <20170608155113.21300-1-npiggin@gmail.com>
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
 arch/powerpc/kernel/process.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 6273b5d5baec..29865c817b02 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1991,12 +1991,8 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 void notrace __ppc64_runlatch_on(void)
 {
 	struct thread_info *ti = current_thread_info();
-	unsigned long ctrl;
-
-	ctrl = mfspr(SPRN_CTRLF);
-	ctrl |= CTRL_RUNLATCH;
-	mtspr(SPRN_CTRLT, ctrl);
 
+	mtspr(SPRN_CTRLT, CTRL_RUNLATCH);
 	ti->local_flags |= _TLF_RUNLATCH;
 }
 
@@ -2004,13 +2000,9 @@ void notrace __ppc64_runlatch_on(void)
 void notrace __ppc64_runlatch_off(void)
 {
 	struct thread_info *ti = current_thread_info();
-	unsigned long ctrl;
 
 	ti->local_flags &= ~_TLF_RUNLATCH;
-
-	ctrl = mfspr(SPRN_CTRLF);
-	ctrl &= ~CTRL_RUNLATCH;
-	mtspr(SPRN_CTRLT, ctrl);
+	mtspr(SPRN_CTRLT, 0);
 }
 #endif /* CONFIG_PPC64 */
 
-- 
2.11.0
