Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LQnf672nzDqjv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 17:05:58 +1000 (AEST)
Message-Id: <8e81b0647fea15e533a73ad4e9063c059fdfc6df.1537987712.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 1/2] powerpc/32: add stack protector support
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu, 27 Sep 2018 07:05:53 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This functionality was tentatively added in the past
(commit 6533b7c16ee5 ("powerpc: Initial stack protector
(-fstack-protector) support")) but had to be reverted
(commit f2574030b0e3 ("powerpc: Revert the initial stack
protector support") because of GCC implementing it differently
whether it had been built with libc support or not.

Now, GCC offers the possibility to manually set the
stack-protector mode (global or tls) regardless of libc support.

This time, the patch selects HAVE_STACKPROTECTOR only if
-mstack-protector-guard=tls is supported by GCC.

On PPC32, as register r2 points to current task_struct at
all time, the stack_canary located inside task_struct can be
used directly by using the following GCC options:
-mstack-protector-guard=tls
-mstack-protector-guard-reg=r2
-mstack-protector-guard-offset=offsetof(struct task_struct, stack_canary))

The protector is disabled for prom_init and bootx_init as
it is too early to handle it properly.

 $ echo CORRUPT_STACK > /sys/kernel/debug/provoke-crash/DIRECT
[  134.943666] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: lkdtm_CORRUPT_STACK+0x64/0x64
[  134.943666]
[  134.955414] CPU: 0 PID: 283 Comm: sh Not tainted 4.18.0-s3k-dev-12143-ga3272be41209 #835
[  134.963380] Call Trace:
[  134.965860] [c6615d60] [c001f76c] panic+0x118/0x260 (unreliable)
[  134.971775] [c6615dc0] [c001f654] panic+0x0/0x260
[  134.976435] [c6615dd0] [c032c368] lkdtm_CORRUPT_STACK_STRONG+0x0/0x64
[  134.982769] [c6615e00] [ffffffff] 0xffffffff

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v5: Using get_random_canary() and masking canary with CANARY_MASK

 v4: disable stack protector in bootx_init

 v3: the offset is now defined by a rule in the Makefile. No need anymore
     to take stack_canary out of the randomised area of task_struct

 arch/powerpc/Kconfig                      |  1 +
 arch/powerpc/Makefile                     | 10 +++++++++
 arch/powerpc/include/asm/stackprotector.h | 34 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/Makefile              |  2 ++
 arch/powerpc/kernel/asm-offsets.c         |  3 +++
 arch/powerpc/platforms/powermac/Makefile  |  1 +
 6 files changed, 51 insertions(+)
 create mode 100644 arch/powerpc/include/asm/stackprotector.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a80669209155..3bcb05929931 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -180,6 +180,7 @@ config PPC
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_CBPF_JIT			if !PPC64
+	select HAVE_STACKPROTECTOR		if $(cc-option,-mstack-protector-guard=tls) && PPC32
 	select HAVE_CONTEXT_TRACKING		if PPC64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_STACKOVERFLOW
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 07d9dce7eda6..45b8eb4d8fe7 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -112,6 +112,9 @@ KBUILD_LDFLAGS	+= -m elf$(BITS)$(LDEMULATION)
 KBUILD_ARFLAGS	+= --target=elf$(BITS)-$(GNUTARGET)
 endif
 
+cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard=tls
+cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard-reg=r2
+
 LDFLAGS_vmlinux-y := -Bstatic
 LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
 LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
@@ -404,6 +407,13 @@ archclean:
 
 archprepare: checkbin
 
+ifdef CONFIG_STACKPROTECTOR
+prepare: stack_protector_prepare
+
+stack_protector_prepare: prepare0
+	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "TASK_CANARY") print $$3;}' include/generated/asm-offsets.h))
+endif
+
 # Use the file '.tmp_gas_check' for binutils tests, as gas won't output
 # to stdout and these checks are run even on install targets.
 TOUT	:= .tmp_gas_check
diff --git a/arch/powerpc/include/asm/stackprotector.h b/arch/powerpc/include/asm/stackprotector.h
new file mode 100644
index 000000000000..d05d969c98c2
--- /dev/null
+++ b/arch/powerpc/include/asm/stackprotector.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * GCC stack protector support.
+ *
+ */
+
+#ifndef _ASM_STACKPROTECTOR_H
+#define _ASM_STACKPROTECTOR_H
+
+#include <linux/random.h>
+#include <linux/version.h>
+#include <asm/reg.h>
+#include <asm/current.h>
+
+/*
+ * Initialize the stackprotector canary value.
+ *
+ * NOTE: this must only be called from functions that never return,
+ * and it must always be inlined.
+ */
+static __always_inline void boot_init_stack_canary(void)
+{
+	unsigned long canary;
+
+	/* Try to get a semi random initial value. */
+	canary = get_random_canary();
+	canary ^= mftb();
+	canary ^= LINUX_VERSION_CODE;
+	canary &= CANARY_MASK;
+
+	current->stack_canary = canary;
+}
+
+#endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 1e64cfe22a83..85ffa488dfb5 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -20,6 +20,8 @@ CFLAGS_prom_init.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 CFLAGS_btext.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 CFLAGS_prom.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 
+CFLAGS_prom_init.o += $(call cc-option, -fno-stack-protector)
+
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
 CFLAGS_REMOVE_cputable.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index ba9d0fc98730..a992f7a53cf3 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -79,6 +79,9 @@ int main(void)
 {
 	OFFSET(THREAD, task_struct, thread);
 	OFFSET(MM, task_struct, mm);
+#ifdef CONFIG_STACKPROTECTOR
+	OFFSET(TASK_CANARY, task_struct, stack_canary);
+#endif
 	OFFSET(MMCONTEXTID, mm_struct, context.id);
 #ifdef CONFIG_PPC64
 	DEFINE(SIGSEGV, SIGSEGV);
diff --git a/arch/powerpc/platforms/powermac/Makefile b/arch/powerpc/platforms/powermac/Makefile
index 561a67d65e4d..923bfb340433 100644
--- a/arch/powerpc/platforms/powermac/Makefile
+++ b/arch/powerpc/platforms/powermac/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS_bootx_init.o  		+= -fPIC
+CFLAGS_bootx_init.o  		+= $(call cc-option, -fno-stack-protector)
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
-- 
2.13.3
