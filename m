Return-Path: <raj.khem@gmail.com>
Received: from mail-pf0-x22e.google.com (mail-pf0-x22e.google.com
 [IPv6:2607:f8b0:400e:c00::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qtbDH6x7YzDq9q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 16:00:15 +1000 (AEST)
Received: by mail-pf0-x22e.google.com with SMTP id c189so17661358pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Apr 2016 23:00:15 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Khem Raj <raj.khem@gmail.com>, Kees Cook <keescook@chromium.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/ptrace: Fix out of bounds array access warning
Date: Sun, 24 Apr 2016 23:00:06 -0700
Message-Id: <1461564006-22331-1-git-send-email-raj.khem@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

gcc-6 correctly warns about a out of bounds access

arch/powerpc/kernel/ptrace.c:407:24: warning: index 32 denotes an offset greater than size of 'u64[32][1] {aka long long unsigned int[32][1]}' [-Warray-bounds]
        offsetof(struct thread_fp_state, fpr[32][0]));
                        ^

check the end of array instead of beginning of next element to fix this

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/ptrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 30a03c0..269f80f 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -377,7 +377,7 @@ static int fpr_get(struct task_struct *target, const struct user_regset *regset,
 
 #else
 	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
-		     offsetof(struct thread_fp_state, fpr[32][0]));
+		     offsetof(struct thread_fp_state, fpr[31][1]));
 
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 				   &target->thread.fp_state, 0, -1);
@@ -405,7 +405,7 @@ static int fpr_set(struct task_struct *target, const struct user_regset *regset,
 	return 0;
 #else
 	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
-		     offsetof(struct thread_fp_state, fpr[32][0]));
+		     offsetof(struct thread_fp_state, fpr[31][1]));
 
 	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 				  &target->thread.fp_state, 0, -1);
-- 
2.8.0
