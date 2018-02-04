Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zYz7w61YQzDqkY
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 16:01:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	greg@kroah.com
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH v4.4 backport 03/16] powerpc: Fix VSX enabling/flushing to
 also test MSR_FP and MSR_VEC
Date: Sun,  4 Feb 2018 15:59:57 +1100
Message-Id: <20180204050010.13669-4-mpe@ellerman.id.au>
In-Reply-To: <20180204050010.13669-1-mpe@ellerman.id.au>
References: <20180204050010.13669-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 5a69aec945d27e78abac9fd032533d3aaebf7c1e upstream.

VSX uses a combination of the old vector registers, the old FP
registers and new "second halves" of the FP registers.

Thus when we need to see the VSX state in the thread struct
(flush_vsx_to_thread()) or when we'll use the VSX in the kernel
(enable_kernel_vsx()) we need to ensure they are all flushed into
the thread struct if either of them is individually enabled.

Unfortunately we only tested if the whole VSX was enabled, not if they
were individually enabled.

Fixes: 72cd7b44bc99 ("powerpc: Uncomment and make enable_kernel_vsx() routine available")
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[mpe: Backported due to changed context]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/process.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index cf788d7d7e56..a9b10812cbfd 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -209,7 +209,8 @@ void enable_kernel_vsx(void)
 	WARN_ON(preemptible());
 
 #ifdef CONFIG_SMP
-	if (current->thread.regs && (current->thread.regs->msr & MSR_VSX))
+	if (current->thread.regs &&
+	    (current->thread.regs->msr & (MSR_VSX|MSR_VEC|MSR_FP)))
 		giveup_vsx(current);
 	else
 		giveup_vsx(NULL);	/* just enable vsx for kernel - force */
@@ -231,7 +232,7 @@ void flush_vsx_to_thread(struct task_struct *tsk)
 {
 	if (tsk->thread.regs) {
 		preempt_disable();
-		if (tsk->thread.regs->msr & MSR_VSX) {
+		if (tsk->thread.regs->msr & (MSR_VSX|MSR_VEC|MSR_FP)) {
 #ifdef CONFIG_SMP
 			BUG_ON(tsk != current);
 #endif
-- 
2.14.1
