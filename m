Return-Path: <R65777@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 19E7B2C02F1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 15:34:39 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>, <agraf@suse.de>,
 <scottwood@freescale.com>, <tiejun.chen@windriver.com>,
 <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <mikey@neuling.org>
Subject: [PATCH 3/6 v5] powerpc: export debug registers save function for KVM
Date: Wed, 26 Jun 2013 11:12:23 +0530
Message-ID: <1372225346-5029-4-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1372225346-5029-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1372225346-5029-1-git-send-email-Bharat.Bhushan@freescale.com>
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
 arch/powerpc/include/asm/switch_to.h |    4 ++++
 arch/powerpc/kernel/process.c        |    3 ++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 200d763..50b357f 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -30,6 +30,10 @@ extern void enable_kernel_spe(void);
 extern void giveup_spe(struct task_struct *);
 extern void load_up_spe(struct task_struct *);
 
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
+extern void switch_booke_debug_regs(struct thread_struct *new_thread);
+#endif
+
 #ifndef CONFIG_SMP
 extern void discard_lazy_cpu_state(void);
 #else
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
