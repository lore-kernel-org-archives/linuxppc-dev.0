Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slv070w1xzDvLH
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Oct 2016 00:27:02 +1000 (AEST)
Message-Id: <55ab3b5e81cc63a130df787708144bfcd43d85f1.1475181427.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1475181427.git.christophe.leroy@c-s.fr>
References: <cover.1475181427.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/2] powerpc: initial stack protector (-fstack-protector)
 support
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Nicolas Pitre <nicolas.pitre@linaro.org>
Date: Fri, 30 Sep 2016 16:26:58 +0200 (CEST)
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

Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                      |  1 +
 arch/powerpc/include/asm/stackprotector.h | 38 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/Makefile              |  5 ++++
 arch/powerpc/kernel/process.c             |  6 +++++
 4 files changed, 50 insertions(+)
 create mode 100644 arch/powerpc/include/asm/stackprotector.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 59e53f4..2947dab 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -162,6 +162,7 @@ config PPC
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_ARCH_HARDENED_USERCOPY
 	select HAVE_KERNEL_GZIP
+	select HAVE_CC_STACKPROTECTOR
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
diff --git a/arch/powerpc/include/asm/stackprotector.h b/arch/powerpc/include/asm/stackprotector.h
new file mode 100644
index 0000000..de00332
--- /dev/null
+++ b/arch/powerpc/include/asm/stackprotector.h
@@ -0,0 +1,38 @@
+/*
+ * GCC stack protector support.
+ *
+ * Stack protector works by putting predefined pattern at the start of
+ * the stack frame and verifying that it hasn't been overwritten when
+ * returning from the function.  The pattern is called stack canary
+ * and gcc expects it to be defined by a global variable called
+ * "__stack_chk_guard" on ARM.  This unfortunately means that on SMP
+ * we cannot have a different canary value per task.
+ */
+
+#ifndef _ASM_STACKPROTECTOR_H
+#define _ASM_STACKPROTECTOR_H 1
+
+#include <linux/random.h>
+#include <linux/version.h>
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
+	canary ^= LINUX_VERSION_CODE;
+
+	current->stack_canary = canary;
+	__stack_chk_guard = current->stack_canary;
+}
+
+#endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index e59ed6a..4a62179 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -19,6 +19,11 @@ CFLAGS_init.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 CFLAGS_btext.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 CFLAGS_prom.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 
+# -fstack-protector triggers protection checks in this code,
+# but it is being used too early to link to meaningful stack_chk logic.
+nossp_flags := $(call cc-option, -fno-stack-protector)
+CFLAGS_prom_init.o := $(nossp_flags)
+
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
 CFLAGS_REMOVE_cputable.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ce8a26a..ba8f32a 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -64,6 +64,12 @@
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
 
+#ifdef CONFIG_CC_STACKPROTECTOR
+#include <linux/stackprotector.h>
+unsigned long __stack_chk_guard __read_mostly;
+EXPORT_SYMBOL(__stack_chk_guard);
+#endif
+
 /* Transactional Memory debug */
 #ifdef TM_DEBUG_SW
 #define TM_DEBUG(x...) printk(KERN_INFO x)
-- 
2.1.0
