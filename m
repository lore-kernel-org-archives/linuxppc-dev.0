Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLKfp3ndyzDr9B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 10:13:22 +1000 (AEST)
Received: by mail-qt0-x243.google.com with SMTP id c15so11605464qta.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 17:13:22 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, linuxram@us.ibm.com,
 bauerman@linux.vnet.ibm.com, mhocko@kernel.org
Subject: [RFC v7 24/25] powerpc: Deliver SEGV signal on pkey violation
Date: Sun, 30 Jul 2017 17:12:25 -0700
Message-Id: <1501459946-11619-25-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The value of the AMR register at the time of exception
is made available in gp_regs[PT_AMR] of the siginfo.

The value of the pkey, whose protection got violated,
is made available in si_pkey field of the siginfo structure.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/uapi/asm/ptrace.h |    1 +
 arch/powerpc/kernel/signal_32.c        |    5 +++++
 arch/powerpc/kernel/signal_64.c        |    4 ++++
 arch/powerpc/kernel/traps.c            |   15 +++++++++++++++
 4 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index 8036b38..fc9c9c0 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -110,6 +110,7 @@ struct pt_regs {
 #define PT_RESULT 43
 #define PT_DSCR 44
 #define PT_REGS_COUNT 44
+#define PT_AMR	45
 
 #define PT_FPR0	48	/* each FP reg occupies 2 slots in this space */
 
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 97bb138..9c4a7f3 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -500,6 +500,11 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
 				   (unsigned long) &frame->tramp[2]);
 	}
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	if (__put_user(get_paca()->paca_amr, &frame->mc_gregs[PT_AMR]))
+		return 1;
+#endif /*  CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 	return 0;
 }
 
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index c83c115..86a4262 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -174,6 +174,10 @@ static long setup_sigcontext(struct sigcontext __user *sc,
 	if (set != NULL)
 		err |=  __put_user(set->sig[0], &sc->oldmask);
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	err |= __put_user(get_paca()->paca_amr, &sc->gp_regs[PT_AMR]);
+#endif /*  CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 	return err;
 }
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index d4e545d..fe1e7c7 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -20,6 +20,7 @@
 #include <linux/sched/debug.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/pkeys.h>
 #include <linux/stddef.h>
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
@@ -247,6 +248,15 @@ void user_single_step_siginfo(struct task_struct *tsk,
 	info->si_addr = (void __user *)regs->nip;
 }
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+static void fill_sig_info_pkey(int si_code, siginfo_t *info, unsigned long addr)
+{
+	if (si_code != SEGV_PKUERR)
+		return;
+	info->si_pkey = get_paca()->paca_pkey;
+}
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 {
 	siginfo_t info;
@@ -274,6 +284,11 @@ void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 	info.si_signo = signr;
 	info.si_code = code;
 	info.si_addr = (void __user *) addr;
+
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	fill_sig_info_pkey(code, &info, addr);
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 	force_sig_info(signr, &info, current);
 }
 
-- 
1.7.1
