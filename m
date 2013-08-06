Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 38/63] powerpc: PTRACE_PEEKUSR/PTRACE_POKEUSER of FPR
 registers in little endian builds
Date: Wed,  7 Aug 2013 02:01:55 +1000
Message-Id: <1375804940-22050-39-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

FPRs overlap the high 64bits of the first 32 VSX registers. The
ptrace FP read/write code assumes big endian ordering and grabs
the lowest 64 bits.

Fix this by using the TS_FPR macro which does the right thing.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/ptrace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 9a0d24c..8d5d4e9 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1554,8 +1554,8 @@ long arch_ptrace(struct task_struct *child, long request,
 
 			flush_fp_to_thread(child);
 			if (fpidx < (PT_FPSCR - PT_FPR0))
-				tmp = ((unsigned long *)child->thread.fpr)
-					[fpidx * TS_FPRWIDTH];
+				memcpy(&tmp, &child->thread.TS_FPR(fpidx),
+				       sizeof(long));
 			else
 				tmp = child->thread.fpscr.val;
 		}
@@ -1587,8 +1587,8 @@ long arch_ptrace(struct task_struct *child, long request,
 
 			flush_fp_to_thread(child);
 			if (fpidx < (PT_FPSCR - PT_FPR0))
-				((unsigned long *)child->thread.fpr)
-					[fpidx * TS_FPRWIDTH] = data;
+				memcpy(&child->thread.TS_FPR(fpidx), &data,
+				       sizeof(long));
 			else
 				child->thread.fpscr.val = data;
 			ret = 0;
-- 
1.8.1.2
