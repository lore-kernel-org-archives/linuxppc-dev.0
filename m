Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsxZg6rH0zF1mg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 15:46:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexander.Levin@microsoft.com
Cc: stable@vger.kernel.org,
	linuxppc-dev@ozlabs.org,
	npiggin@gmail.com
Subject: [PATCH v4.1 backport 14/15] powerpc/ptrace: Fix out of bounds array
 access warning
Date: Fri,  2 Mar 2018 15:45:48 +1100
Message-Id: <20180302044549.14930-15-mpe@ellerman.id.au>
In-Reply-To: <20180302044549.14930-1-mpe@ellerman.id.au>
References: <20180302044549.14930-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Khem Raj <raj.khem@gmail.com>

commit 1e407ee3b21f981140491d5b8a36422979ca246f upstream.

gcc-6 correctly warns about a out of bounds access

arch/powerpc/kernel/ptrace.c:407:24: warning: index 32 denotes an offset greater than size of 'u64[32][1] {aka long long unsigned int[32][1]}' [-Warray-bounds]
        offsetof(struct thread_fp_state, fpr[32][0]));
                        ^

check the end of array instead of beginning of next element to fix this

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Acked-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/ptrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index f21897b42057..93f200f14e19 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -376,7 +376,7 @@ static int fpr_get(struct task_struct *target, const struct user_regset *regset,
 
 #else
 	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
-		     offsetof(struct thread_fp_state, fpr[32][0]));
+		     offsetof(struct thread_fp_state, fpr[32]));
 
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 				   &target->thread.fp_state, 0, -1);
@@ -404,7 +404,7 @@ static int fpr_set(struct task_struct *target, const struct user_regset *regset,
 	return 0;
 #else
 	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
-		     offsetof(struct thread_fp_state, fpr[32][0]));
+		     offsetof(struct thread_fp_state, fpr[32]));
 
 	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 				  &target->thread.fp_state, 0, -1);
-- 
2.14.1
