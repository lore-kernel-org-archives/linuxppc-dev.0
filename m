Return-Path: <dja@axtens.net>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSwHR37nnzDrqH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 15:33:23 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id h5so1522pao.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 22:33:23 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 5/5] powerpc/sparse: Add more assembler prototypes
Date: Tue,  6 Sep 2016 15:32:43 +1000
Message-Id: <1473139963-7496-5-git-send-email-dja@axtens.net>
In-Reply-To: <1473139963-7496-1-git-send-email-dja@axtens.net>
References: <1473139963-7496-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Another set of things that are only called from assembler and so need
prototypes to keep sparse happy.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

v2: Fix a couple of issues identified by the 0day bot:
    - different definition of sys_swapendian for 32/64
    - the previous fadump patch fixes a weird interaction with headers
      that the bot picked up.

Again, created semi-programatically and compile-tested against
top-level defconfigs.
---
 arch/powerpc/include/asm/asm-prototypes.h | 37 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/irq.c                 |  1 +
 arch/powerpc/kernel/process.c             |  1 +
 arch/powerpc/kernel/prom_init.c           |  1 +
 arch/powerpc/kernel/ptrace.c              |  1 +
 arch/powerpc/kernel/signal_32.c           |  1 +
 arch/powerpc/kernel/signal_64.c           |  1 +
 arch/powerpc/kernel/syscalls.c            |  1 +
 arch/powerpc/kernel/time.c                |  1 +
 9 files changed, 45 insertions(+)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index ce8c1158a2c0..250c04e28670 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -18,6 +18,8 @@
 #include <linux/kvm_host.h>
 #endif
 
+#include <uapi/asm/ucontext.h>
+
 /* SMP */
 extern struct thread_info *current_set[NR_CPUS];
 extern struct thread_info *secondary_ti;
@@ -116,4 +118,39 @@ int kvmppc_rm_h_cppr(struct kvm_vcpu *vcpu, unsigned long cppr);
 int kvmppc_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr);
 #endif
 
+/* signals, syscalls and interrupts */
+#ifdef CONFIG_PPC64
+int sys_swapcontext(struct ucontext __user *old_ctx,
+                    struct ucontext __user *new_ctx,
+                    long ctx_size, long r6, long r7, long r8, struct pt_regs *regs);
+#else
+long sys_swapcontext(struct ucontext __user *old_ctx,
+                    struct ucontext __user *new_ctx,
+                    int ctx_size, int r6, int r7, int r8, struct pt_regs *regs);
+#endif
+long sys_switch_endian(void);
+notrace unsigned int __check_irq_replay(void);
+void notrace restore_interrupts(void);
+
+/* ptrace */
+long do_syscall_trace_enter(struct pt_regs *regs);
+void do_syscall_trace_leave(struct pt_regs *regs);
+
+/* process */
+void restore_math(struct pt_regs *regs);
+void restore_tm_state(struct pt_regs *regs);
+
+/* prom_init (OpenFirmware) */
+unsigned long __init prom_init(unsigned long r3, unsigned long r4,
+                               unsigned long pp,
+                               unsigned long r6, unsigned long r7,
+                               unsigned long kbase);
+
+/* setup */
+void __init early_setup(unsigned long dt_ptr);
+void early_setup_secondary(void);
+
+/* time */
+void accumulate_stolen_time(void);
+
 #endif /* _ASM_POWERPC_ASM_PROTOTYPES_H */
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 08887cf2b20e..9594ac8e7090 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -67,6 +67,7 @@
 #include <asm/smp.h>
 #include <asm/debug.h>
 #include <asm/livepatch.h>
+#include <asm/asm-prototypes.h>
 
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 9ee2623e0f67..ce8a26a0c947 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -59,6 +59,7 @@
 #include <asm/exec.h>
 #include <asm/livepatch.h>
 #include <asm/cpu_has_feature.h>
+#include <asm/asm-prototypes.h>
 
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 4e74fc588a3f..84b0d677f6ce 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -42,6 +42,7 @@
 #include <asm/sections.h>
 #include <asm/machdep.h>
 #include <asm/opal.h>
+#include <asm/asm-prototypes.h>
 
 #include <linux/linux_logo.h>
 
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index bf91658a8a40..2299bf60780d 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -39,6 +39,7 @@
 #include <asm/pgtable.h>
 #include <asm/switch_to.h>
 #include <asm/tm.h>
+#include <asm/asm-prototypes.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index b6aa378aff63..c35186b46590 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -44,6 +44,7 @@
 #include <asm/vdso.h>
 #include <asm/switch_to.h>
 #include <asm/tm.h>
+#include <asm/asm-prototypes.h>
 #ifdef CONFIG_PPC64
 #include "ppc32.h"
 #include <asm/unistd.h>
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 7e49984d4331..3e8feb1824d8 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -35,6 +35,7 @@
 #include <asm/vdso.h>
 #include <asm/switch_to.h>
 #include <asm/tm.h>
+#include <asm/asm-prototypes.h>
 
 #include "signal.h"
 
diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index 5fa92706444b..644cce3d8dce 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -40,6 +40,7 @@
 #include <asm/syscalls.h>
 #include <asm/time.h>
 #include <asm/unistd.h>
+#include <asm/asm-prototypes.h>
 
 static inline unsigned long do_mmap2(unsigned long addr, size_t len,
 			unsigned long prot, unsigned long flags,
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 3efbedefba6a..67859b7d1c97 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -73,6 +73,7 @@
 #include <asm/vdso_datapage.h>
 #include <asm/firmware.h>
 #include <asm/cputime.h>
+#include <asm/asm-prototypes.h>
 
 /* powerpc clocksource/clockevent code */
 
-- 
2.7.4
