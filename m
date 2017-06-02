Return-Path: <npiggin@gmail.com>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfGMy4bBQzDqL4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 17:40:30 +1000 (AEST)
Received: by mail-it0-x241.google.com with SMTP id 67so8871665itx.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Jun 2017 00:40:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Anton Blanchard <anton@samba.org>
Subject: [PATCH 10/14] powerpc/64: CTRL[RUN] run-latch setting optimisation
Date: Fri,  2 Jun 2017 17:39:42 +1000
Message-Id: <20170602073946.8983-11-npiggin@gmail.com>
In-Reply-To: <20170602073946.8983-1-npiggin@gmail.com>
References: <20170602073946.8983-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CTRL register is read-only except bit 63 which is the run
latch control. This means it can be updated with a mtspr rather
than mfspr/mtspr.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/process.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 5cbb8b1faf7e..633ec9967141 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1964,12 +1964,8 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
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
 
@@ -1977,13 +1973,9 @@ void notrace __ppc64_runlatch_on(void)
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
