Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: stable@vger.kernel.org
MIME-Version: 1.0
Subject: [stable] [PATCH] powerpc/ptrace: Fix build with gcc 4.6
Date: Tue, 11 Dec 2012 14:35:13 +1100
Message-ID: <15012.1355196913@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

gcc (rightfully) complains that we are accessing beyond the
end of the fpr array (we do, to access the fpscr).

The only sane thing to do (whether anything in that code can be
called remotely sane is debatable) is to special case fpscr and
handle it as a separate statement.

I initially tried to do it it by making the array access conditional
to index < PT_FPSCR and using a 3rd else leg but for some reason gcc
was unable to understand it and still spewed the warning.

So I ended up with something a tad more intricated but it seems to
build on 32-bit and on 64-bit with and without VSX.

commit e69b742a6793dc5bf16f6eedca534d4bc10d68b2

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
cc: stable@vger.kernel.org (for 3.0 only)

--- 
Mr Stable: This seemed to miss 3.0 stable, please add...

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 05b7dd2..18447c4 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1497,9 +1497,14 @@ long arch_ptrace(struct task_struct *child, long request,
 		if (index < PT_FPR0) {
 			tmp = ptrace_get_reg(child, (int) index);
 		} else {
+			unsigned int fpidx = index - PT_FPR0;
+
 			flush_fp_to_thread(child);
-			tmp = ((unsigned long *)child->thread.fpr)
-				[TS_FPRWIDTH * (index - PT_FPR0)];
+			if (fpidx < (PT_FPSCR - PT_FPR0))
+				tmp = ((unsigned long *)child->thread.fpr)
+					[fpidx * TS_FPRWIDTH];
+			else
+				tmp = child->thread.fpscr.val;
 		}
 		ret = put_user(tmp, datalp);
 		break;
@@ -1525,9 +1530,14 @@ long arch_ptrace(struct task_struct *child, long request,
 		if (index < PT_FPR0) {
 			ret = ptrace_put_reg(child, index, data);
 		} else {
+			unsigned int fpidx = index - PT_FPR0;
+
 			flush_fp_to_thread(child);
-			((unsigned long *)child->thread.fpr)
-				[TS_FPRWIDTH * (index - PT_FPR0)] = data;
+			if (fpidx < (PT_FPSCR - PT_FPR0))
+				((unsigned long *)child->thread.fpr)
+					[fpidx * TS_FPRWIDTH] = data;
+			else
+				child->thread.fpscr.val = data;
 			ret = 0;
 		}
 		break;
