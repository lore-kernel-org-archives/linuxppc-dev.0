Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 2E8C22C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 02:50:54 +1000 (EST)
Date: Sun, 21 Apr 2013 18:47:59 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH] ptrace/powerpc: dont flush_ptrace_hw_breakpoint() on fork()
Message-ID: <20130421164759.GA5537@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch_dup_task_struct() does flush_ptrace_hw_breakpoint(src), this
destroys the parent's breakpoints for no reason. We should clear
child->thread.ptrace_bps[] copied by dup_task_struct() instead.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Michael Neuling <mikey@neuling.org>

--- x/arch/powerpc/kernel/process.c
+++ x/arch/powerpc/kernel/process.c
@@ -910,10 +910,6 @@ int arch_dup_task_struct(struct task_str
 	flush_altivec_to_thread(src);
 	flush_vsx_to_thread(src);
 	flush_spe_to_thread(src);
-#ifdef CONFIG_HAVE_HW_BREAKPOINT
-	flush_ptrace_hw_breakpoint(src);
-#endif /* CONFIG_HAVE_HW_BREAKPOINT */
-
 	*dst = *src;
 	return 0;
 }
@@ -984,6 +980,10 @@ int copy_thread(unsigned long clone_flag
 	p->thread.ksp_limit = (unsigned long)task_stack_page(p) +
 				_ALIGN_UP(sizeof(struct thread_info), 16);
 
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	p->thread.ptrace_bps[0] = NULL;
+#endif
+
 #ifdef CONFIG_PPC_STD_MMU_64
 	if (mmu_has_feature(MMU_FTR_SLB)) {
 		unsigned long sp_vsid;
