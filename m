Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 5/5] powerpc: Dynamically calculate the dabrx based on
 kernel/user/hypervisor
Date: Thu,  6 Sep 2012 15:17:51 +1000
Message-Id: <1346908671-7464-5-git-send-email-mikey@neuling.org>
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

Currently we mark the DABRX to interrupt on all matches
(hypervisor/kernel/user and then filter in software.  We can be a lot
smarter now that we can set the DABRX dynamically.

This sets the DABRX based on the flags passed by the user.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/hw_breakpoint.h |    1 +
 arch/powerpc/kernel/hw_breakpoint.c      |   15 +++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index c6f48eb..4234245 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -28,6 +28,7 @@
 
 struct arch_hw_breakpoint {
 	unsigned long	address;
+	unsigned long	dabrx;
 	int		type;
 	u8		len; /* length of the target data symbol */
 	bool		extraneous_interrupt;
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 6891d79..a89cae4 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -73,7 +73,7 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	 * If so, DABR will be populated in single_step_dabr_instruction().
 	 */
 	if (current->thread.last_hit_ubp != bp)
-		set_dabr(info->address | info->type | DABR_TRANSLATION, DABRX_ALL);
+		set_dabr(info->address | info->type | DABR_TRANSLATION, info->dabrx);
 
 	return 0;
 }
@@ -170,6 +170,13 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 
 	info->address = bp->attr.bp_addr;
 	info->len = bp->attr.bp_len;
+	info->dabrx = DABRX_ALL;
+	if (bp->attr.exclude_user)
+		info->dabrx &= ~DABRX_USER;
+	if (bp->attr.exclude_kernel)
+		info->dabrx &= ~DABRX_KERNEL;
+	if (bp->attr.exclude_hv)
+		info->dabrx &= ~DABRX_HYP;
 
 	/*
 	 * Since breakpoint length can be a maximum of HW_BREAKPOINT_LEN(8)
@@ -197,7 +204,7 @@ void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs)
 
 	info = counter_arch_bp(tsk->thread.last_hit_ubp);
 	regs->msr &= ~MSR_SE;
-	set_dabr(info->address | info->type | DABR_TRANSLATION, DABRX_ALL);
+	set_dabr(info->address | info->type | DABR_TRANSLATION, info->dabrx);
 	tsk->thread.last_hit_ubp = NULL;
 }
 
@@ -281,7 +288,7 @@ int __kprobes hw_breakpoint_handler(struct die_args *args)
 	if (!info->extraneous_interrupt)
 		perf_bp_event(bp, regs);
 
-	set_dabr(info->address | info->type | DABR_TRANSLATION, DABRX_ALL);
+	set_dabr(info->address | info->type | DABR_TRANSLATION, info->dabrx);
 out:
 	rcu_read_unlock();
 	return rc;
@@ -313,7 +320,7 @@ int __kprobes single_step_dabr_instruction(struct die_args *args)
 	if (!info->extraneous_interrupt)
 		perf_bp_event(bp, regs);
 
-	set_dabr(info->address | info->type | DABR_TRANSLATION, DABRX_ALL);
+	set_dabr(info->address | info->type | DABR_TRANSLATION, info->dabrx);
 	current->thread.last_hit_ubp = NULL;
 
 	/*
-- 
1.7.9.5
