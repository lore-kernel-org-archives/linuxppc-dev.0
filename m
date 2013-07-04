Return-Path: <R65777@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8ABB52C0182
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 17:06:24 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>, <agraf@suse.de>,
 <tiejun.chen@windriver.com>, <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>, <mikey@neuling.org>,
 <scottwood@freescale.com>, <sfr@canb.auug.org.au>
Subject: [PATCH 1/4 v6] powerpc: export debug registers save function for KVM
Date: Thu, 4 Jul 2013 12:27:44 +0530
Message-ID: <1372921067-19678-2-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1372921067-19678-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1372921067-19678-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

KVM need this function when switching from vcpu to user-space
thread. My subsequent patch will use this function.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
v5->v6
 - switch_booke_debug_regs() not guarded by the compiler switch

 arch/powerpc/include/asm/switch_to.h |    1 +
 arch/powerpc/kernel/process.c        |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 200d763..db68f1d 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -29,6 +29,7 @@ extern void giveup_vsx(struct task_struct *);
 extern void enable_kernel_spe(void);
 extern void giveup_spe(struct task_struct *);
 extern void load_up_spe(struct task_struct *);
+extern void switch_booke_debug_regs(struct thread_struct *new_thread);
 
 #ifndef CONFIG_SMP
 extern void discard_lazy_cpu_state(void);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 01ff496..da586aa 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -362,12 +362,13 @@ static void prime_debug_regs(struct thread_struct *thread)
  * debug registers, set the debug registers from the values
  * stored in the new thread.
  */
-static void switch_booke_debug_regs(struct thread_struct *new_thread)
+void switch_booke_debug_regs(struct thread_struct *new_thread)
 {
 	if ((current->thread.debug.dbcr0 & DBCR0_IDM)
 		|| (new_thread->debug.dbcr0 & DBCR0_IDM))
 			prime_debug_regs(new_thread);
 }
+EXPORT_SYMBOL_GPL(switch_booke_debug_regs);
 #else	/* !CONFIG_PPC_ADV_DEBUG_REGS */
 #ifndef CONFIG_HAVE_HW_BREAKPOINT
 static void set_debug_reg_defaults(struct thread_struct *thread)
-- 
1.7.0.4
