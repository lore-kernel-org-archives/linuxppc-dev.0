Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/5] powerpc: Use consistent name info for arch_hw_breakpoint
Date: Thu,  6 Sep 2012 15:17:48 +1000
Message-Id: <1346908671-7464-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1346908671-7464-1-git-send-email-mikey@neuling.org>
References: <1346908671-7464-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change bp_info to info to be consistent with the rest of this file.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/hw_breakpoint.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 956a4c4..6767445 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -294,7 +294,7 @@ int __kprobes single_step_dabr_instruction(struct die_args *args)
 {
 	struct pt_regs *regs = args->regs;
 	struct perf_event *bp = NULL;
-	struct arch_hw_breakpoint *bp_info;
+	struct arch_hw_breakpoint *info;
 
 	bp = current->thread.last_hit_ubp;
 	/*
@@ -304,16 +304,16 @@ int __kprobes single_step_dabr_instruction(struct die_args *args)
 	if (!bp)
 		return NOTIFY_DONE;
 
-	bp_info = counter_arch_bp(bp);
+	info = counter_arch_bp(bp);
 
 	/*
 	 * We shall invoke the user-defined callback function in the single
 	 * stepping handler to confirm to 'trigger-after-execute' semantics
 	 */
-	if (!bp_info->extraneous_interrupt)
+	if (!info->extraneous_interrupt)
 		perf_bp_event(bp, regs);
 
-	set_dabr(bp_info->address | bp_info->type | DABR_TRANSLATION);
+	set_dabr(info->address | info->type | DABR_TRANSLATION);
 	current->thread.last_hit_ubp = NULL;
 
 	/*
-- 
1.7.9.5
