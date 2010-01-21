Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp07.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6C26CB7CCD
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jan 2010 17:13:16 +1100 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp07.in.ibm.com (8.14.3/8.13.1) with ESMTP id o0L6DDnH025856
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jan 2010 11:43:13 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0L6DDh52040014
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jan 2010 11:43:13 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0L6DC3o005749
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jan 2010 17:13:13 +1100
Date: Thu, 21 Jan 2010 11:42:40 +0530
From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH -tip tracing/kprobes v3] Powerpc port of the kprobe-based
	event tracer
Message-ID: <20100121061240.GA21717@in.ibm.com>
References: <20100121060941.602302318@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, systemtap@sources.redhat.com,
	Ingo Molnar <mingo@elte.hu>, Masami Hiramatsu <mhiramat@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This patch ports the kprobe-based event tracer to powerpc. This patch
is based on x86 port. This brings powerpc on par with x86.

ChangeLog:
v2:
- Removed regs_get_argument_nth() API as function argument access syntax
  is dropped from kprobe-tracer. Please refer to mails below on Linux PPC
  mailing list:
  http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-January/079331.html
  http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-January/079332.html
v3:
- The registers gpr[0]...gpr[31] will now be represented as gpr0...gpr31
- The pt_regs structure members orig_gpr3 and result will not be exposed
  as they are not actual registers.
- Rebased to commit 605a39d5a0f4856214b37db954f553fba28bb616 of -tip

This patch is dependent on:
  http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-January/079331.html

Port the following API's to ppc for accessing registers and stack entries
from pt_regs.

- regs_query_register_offset(const char *name)
   Query the offset of "name" register.

- regs_query_register_name(unsigned int offset)
   Query the name of register by its offset.

- regs_get_register(struct pt_regs *regs, unsigned int offset)
   Get the value of a register by its offset.

- regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr)
   Check the address is in the kernel stack.

- regs_get_kernel_stack_nth(struct pt_regs *reg, unsigned int nth)
   Get Nth entry of the kernel stack. (N >= 0)

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@redhat.com>
---

 arch/powerpc/include/asm/ptrace.h |   61 ++++++++++++++++++++++
 arch/powerpc/kernel/ptrace.c      |  103 +++++++++++++++++++++++++++++++++++++
 kernel/trace/Kconfig              |    2 -
 3 files changed, 165 insertions(+), 1 deletions(-)


diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index cbd759e..f4a78c5 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -83,6 +83,7 @@ struct pt_regs {
 
 #define instruction_pointer(regs) ((regs)->nip)
 #define user_stack_pointer(regs) ((regs)->gpr[1])
+#define kernel_stack_pointer(regs) ((regs)->gpr[1])
 #define regs_return_value(regs) ((regs)->gpr[3])
 
 #ifdef CONFIG_SMP
@@ -131,6 +132,66 @@ do {									      \
 } while (0)
 #endif /* __powerpc64__ */
 
+/* Query offset/name of register from its name/offset */
+#include <linux/stddef.h>
+#include <linux/thread_info.h>
+extern int regs_query_register_offset(const char *name);
+extern const char *regs_query_register_name(unsigned int offset);
+#define MAX_REG_OFFSET (offsetof(struct pt_regs, dsisr))
+
+/**
+ * regs_get_register() - get register value from its offset
+ * @regs:	   pt_regs from which register value is gotten
+ * @offset:    offset number of the register.
+ *
+ * regs_get_register returns the value of a register whose offset from @regs.
+ * The @offset is the offset of the register in struct pt_regs.
+ * If @offset is bigger than MAX_REG_OFFSET, this returns 0.
+ */
+static inline unsigned long regs_get_register(struct pt_regs *regs,
+						unsigned int offset)
+{
+	if (unlikely(offset > MAX_REG_OFFSET))
+		return 0;
+	return *(unsigned long *)((unsigned long)regs + offset);
+}
+
+/**
+ * regs_within_kernel_stack() - check the address in the stack
+ * @regs:      pt_regs which contains kernel stack pointer.
+ * @addr:      address which is checked.
+ *
+ * regs_within_kernel_stack() checks @addr is within the kernel stack page(s).
+ * If @addr is within the kernel stack, it returns true. If not, returns false.
+ */
+
+static inline bool regs_within_kernel_stack(struct pt_regs *regs,
+						unsigned long addr)
+{
+	return ((addr & ~(THREAD_SIZE - 1))  ==
+		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1)));
+}
+
+/**
+ * regs_get_kernel_stack_nth() - get Nth entry of the stack
+ * @regs:	pt_regs which contains kernel stack pointer.
+ * @n:		stack entry number.
+ *
+ * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack which
+ * is specified by @regs. If the @n th entry is NOT in the kernel stack,
+ * this returns 0.
+ */
+static inline unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
+						      unsigned int n)
+{
+	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
+	addr += n;
+	if (regs_within_kernel_stack(regs, (unsigned long)addr))
+		return *addr;
+	else
+		return 0;
+}
+
 /*
  * These are defined as per linux/ptrace.h, which see.
  */
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index ef14988..56651c2 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -39,6 +39,109 @@
 #include <asm/system.h>
 
 /*
+ * The parameter save area on the stack is used to store arguments being passed
+ * to callee function and is located at fixed offset from stack pointer.
+ */
+#ifdef CONFIG_PPC32
+#define PARAMETER_SAVE_AREA_OFFSET	24  /* bytes */
+#else /* CONFIG_PPC32 */
+#define PARAMETER_SAVE_AREA_OFFSET	48  /* bytes */
+#endif
+
+struct pt_regs_offset {
+	const char *name;
+	int offset;
+};
+
+#define STR(s)	#s			/* convert to string */
+#define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
+#define GPR_OFFSET_NAME(num)	\
+	{.name = STR(gpr##num), .offset = offsetof(struct pt_regs, gpr[num])}
+#define REG_OFFSET_END {.name = NULL, .offset = 0}
+
+static const struct pt_regs_offset regoffset_table[] = {
+	GPR_OFFSET_NAME(0),
+	GPR_OFFSET_NAME(1),
+	GPR_OFFSET_NAME(2),
+	GPR_OFFSET_NAME(3),
+	GPR_OFFSET_NAME(4),
+	GPR_OFFSET_NAME(5),
+	GPR_OFFSET_NAME(6),
+	GPR_OFFSET_NAME(7),
+	GPR_OFFSET_NAME(8),
+	GPR_OFFSET_NAME(9),
+	GPR_OFFSET_NAME(10),
+	GPR_OFFSET_NAME(11),
+	GPR_OFFSET_NAME(12),
+	GPR_OFFSET_NAME(13),
+	GPR_OFFSET_NAME(14),
+	GPR_OFFSET_NAME(15),
+	GPR_OFFSET_NAME(16),
+	GPR_OFFSET_NAME(17),
+	GPR_OFFSET_NAME(18),
+	GPR_OFFSET_NAME(19),
+	GPR_OFFSET_NAME(20),
+	GPR_OFFSET_NAME(21),
+	GPR_OFFSET_NAME(22),
+	GPR_OFFSET_NAME(23),
+	GPR_OFFSET_NAME(24),
+	GPR_OFFSET_NAME(25),
+	GPR_OFFSET_NAME(26),
+	GPR_OFFSET_NAME(27),
+	GPR_OFFSET_NAME(28),
+	GPR_OFFSET_NAME(29),
+	GPR_OFFSET_NAME(30),
+	GPR_OFFSET_NAME(31),
+	REG_OFFSET_NAME(nip),
+	REG_OFFSET_NAME(msr),
+	REG_OFFSET_NAME(ctr),
+	REG_OFFSET_NAME(link),
+	REG_OFFSET_NAME(xer),
+	REG_OFFSET_NAME(ccr),
+#ifdef CONFIG_PPC64
+	REG_OFFSET_NAME(softe),
+#else
+	REG_OFFSET_NAME(mq),
+#endif
+	REG_OFFSET_NAME(trap),
+	REG_OFFSET_NAME(dar),
+	REG_OFFSET_NAME(dsisr),
+	REG_OFFSET_END,
+};
+
+/**
+ * regs_query_register_offset() - query register offset from its name
+ * @name:	the name of a register
+ *
+ * regs_query_register_offset() returns the offset of a register in struct
+ * pt_regs from its name. If the name is invalid, this returns -EINVAL;
+ */
+int regs_query_register_offset(const char *name)
+{
+	const struct pt_regs_offset *roff;
+	for (roff = regoffset_table; roff->name != NULL; roff++)
+		if (!strcmp(roff->name, name))
+			return roff->offset;
+	return -EINVAL;
+}
+
+/**
+ * regs_query_register_name() - query register name from its offset
+ * @offset:	the offset of a register in struct pt_regs.
+ *
+ * regs_query_register_name() returns the name of a register from its
+ * offset in struct pt_regs. If the @offset is invalid, this returns NULL;
+ */
+const char *regs_query_register_name(unsigned int offset)
+{
+	const struct pt_regs_offset *roff;
+	for (roff = regoffset_table; roff->name != NULL; roff++)
+		if (roff->offset == offset)
+			return roff->name;
+	return NULL;
+}
+
+/*
  * does not yet catch signals sent when the child dies.
  * in exit.c or in signal.c.
  */
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 6c22d8a..4d95966 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -451,7 +451,7 @@ config BLK_DEV_IO_TRACE
 
 config KPROBE_EVENT
 	depends on KPROBES
-	depends on X86
+	depends on X86 || PPC
 	bool "Enable kprobes-based dynamic events"
 	select TRACING
 	default y
