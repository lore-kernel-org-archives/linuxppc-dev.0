Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DQ731ZGdzF22T
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 22:15:11 +1000 (AEST)
Message-Id: <9f7efcc085685717bb4c7b3a575138a1a1cd15ed.1537186089.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/2] powerpc: initial stack protector (-fstack-protector)
 support
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 17 Sep 2018 12:15:05 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Partialy copied from commit c743f38013aef ("ARM: initial stack protector
(-fstack-protector) support")

This is the very basic stuff without the changing canary upon
task switch yet.  Just the Kconfig option and a constant canary
value initialized at boot time.

This patch was tentatively added in the past (commit 6533b7c16ee5
("powerpc: Initial stack protector (-fstack-protector) support"))
but had to be reverted (commit f2574030b0e3 ("powerpc: Revert the
initial stack protector support") because GCC implementing it
differently whether it had been built with libc support or not.

Now, GCC offers the possibility to manually set the
stack-protector mode (global or tls) regardless of libc support.

This time, the patch selects HAVE_STACKPROTECTOR only if
-mstack-protector-guard=global is supported by GCC.

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
 arch/powerpc/Kconfig                      |  1 +
 arch/powerpc/Makefile                     |  4 +++
 arch/powerpc/include/asm/stackprotector.h | 41 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/Makefile              |  4 +++
 arch/powerpc/kernel/process.c             |  6 +++++
 5 files changed, 56 insertions(+)
 create mode 100644 arch/powerpc/include/asm/stackprotector.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index db0b6eebbfa5..3f5776ed99d3 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -181,6 +181,7 @@ config PPC
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_CBPF_JIT			if !PPC64
+	select HAVE_STACKPROTECTOR		if $(cc-option,-mstack-protector-guard=global)
 	select HAVE_CONTEXT_TRACKING		if PPC64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_STACKOVERFLOW
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 8397c7bd5880..0dbfdb6a145d 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -112,6 +112,10 @@ LDFLAGS		+= -m elf$(BITS)$(LDEMULATION)
 KBUILD_ARFLAGS	+= --target=elf$(BITS)-$(GNUTARGET)
 endif
 
+ifdef CONFIG_STACKPROTECTOR
+KBUILD_CFLAGS	+= -mstack-protector-guard=global
+endif
+
 LDFLAGS_vmlinux-y := -Bstatic
 LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
 LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
diff --git a/arch/powerpc/include/asm/stackprotector.h b/arch/powerpc/include/asm/stackprotector.h
new file mode 100644
index 000000000000..2556e227cdb2
--- /dev/null
+++ b/arch/powerpc/include/asm/stackprotector.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * GCC stack protector support.
+ *
+ * Stack protector works by putting predefined pattern at the start of
+ * the stack frame and verifying that it hasn't been overwritten when
+ * returning from the function.  The pattern is called stack canary
+ * and gcc expects it to be defined by a global variable called
+ * "__stack_chk_guard" on PPC.  This unfortunately means that on SMP
+ * we cannot have a different canary value per task.
+ */
+
+#ifndef _ASM_STACKPROTECTOR_H
+#define _ASM_STACKPROTECTOR_H
+
+#include <linux/random.h>
+#include <linux/version.h>
+#include <asm/reg.h>
+
+extern unsigned long __stack_chk_guard;
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
+	get_random_bytes(&canary, sizeof(canary));
+	canary ^= mftb();
+	canary ^= LINUX_VERSION_CODE;
+
+	current->stack_canary = canary;
+	__stack_chk_guard = current->stack_canary;
+}
+
+#endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 3b66f2c19c84..0556a7243d2a 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -20,6 +20,10 @@ CFLAGS_prom_init.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 CFLAGS_btext.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 CFLAGS_prom.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 
+# -fstack-protector triggers protection checks in this code,
+# but it is being used too early to link to meaningful stack_chk logic.
+CFLAGS_prom_init.o += $(call cc-option, -fno-stack-protector)
+
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
 CFLAGS_REMOVE_cputable.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 913c5725cdb2..8e9e90e8d773 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -69,6 +69,12 @@
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
 
+#ifdef CONFIG_STACKPROTECTOR
+#include <linux/stackprotector.h>
+unsigned long __stack_chk_guard __read_mostly;
+EXPORT_SYMBOL(__stack_chk_guard);
+#endif
+
 /* Transactional Memory debug */
 #ifdef TM_DEBUG_SW
 #define TM_DEBUG(x...) printk(KERN_INFO x)
-- 
2.13.3
