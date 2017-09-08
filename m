Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpss81HV1zDrd1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Sep 2017 08:47:24 +1000 (AEST)
Received: by mail-qt0-x244.google.com with SMTP id h21so2358588qth.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 15:47:24 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: [PATCH 23/25] powerpc: Deliver SEGV signal on pkey violation
Date: Fri,  8 Sep 2017 15:45:11 -0700
Message-Id: <1504910713-7094-32-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The value of the pkey, whose protection got violated,
is made available in si_pkey field of the siginfo structure.

Also keep the thread's pkey-register fields up2date.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/kernel/traps.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index ec74e20..f2a310d 100644
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
@@ -265,6 +266,15 @@ void user_single_step_siginfo(struct task_struct *tsk,
 	info->si_addr = (void __user *)regs->nip;
 }
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+static void fill_sig_info_pkey(int si_code, siginfo_t *info, unsigned long addr)
+{
+	if (info->si_signo != SIGSEGV || si_code != SEGV_PKUERR)
+		return;
+	info->si_pkey = get_paca()->paca_pkey;
+}
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 {
 	siginfo_t info;
@@ -292,6 +302,18 @@ void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 	info.si_signo = signr;
 	info.si_code = code;
 	info.si_addr = (void __user *) addr;
+
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	/*
+	 * update the thread's pkey related fields.
+	 * core-dump handlers and other sub-systems
+	 * depend on those values.
+	 */
+	thread_pkey_regs_save(&current->thread);
+	/* update the violated-key value */
+	fill_sig_info_pkey(code, &info, addr);
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 	force_sig_info(signr, &info, current);
 }
 
-- 
1.7.1
