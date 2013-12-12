Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	Ulrich.Weigand@de.ibm.com
Subject: [PATCH 1/8] powerpc: PTRACE_PEEKUSR always returns FPR0
Date: Thu, 12 Dec 2013 15:59:34 +1100
Message-Id: <1386824381-14032-2-git-send-email-anton@samba.org>
In-Reply-To: <1386824381-14032-1-git-send-email-anton@samba.org>
References: <1386824381-14032-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>

There is a bug in using ptrace to access FPRs via PTRACE_PEEKUSR /
PTRACE_POKEUSR. In effect, trying to access any of the FPRs always
really accesses FPR0, which does seriously break debugging :-)

The problem seems to have been introduced by commit 3ad26e5c4459d
(Merge branch 'for-kvm' into next).

[ It is indeed a merge conflict between Paul's FPU/VSX state rework
and my LE patches - Anton ]

Signed-off-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/ptrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 75fb404..2e3d2bf 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1555,7 +1555,7 @@ long arch_ptrace(struct task_struct *child, long request,
 
 			flush_fp_to_thread(child);
 			if (fpidx < (PT_FPSCR - PT_FPR0))
-				memcpy(&tmp, &child->thread.fp_state.fpr,
+				memcpy(&tmp, &child->thread.TS_FPR(fpidx),
 				       sizeof(long));
 			else
 				tmp = child->thread.fp_state.fpscr;
@@ -1588,7 +1588,7 @@ long arch_ptrace(struct task_struct *child, long request,
 
 			flush_fp_to_thread(child);
 			if (fpidx < (PT_FPSCR - PT_FPR0))
-				memcpy(&child->thread.fp_state.fpr, &data,
+				memcpy(&child->thread.TS_FPR(fpidx), &data,
 				       sizeof(long));
 			else
 				child->thread.fp_state.fpscr = data;
-- 
1.8.3.2
