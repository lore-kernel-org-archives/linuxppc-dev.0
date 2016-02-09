Return-Path: <dave.long@linaro.org>
Received: from mail-qg0-x22f.google.com (mail-qg0-x22f.google.com
 [IPv6:2607:f8b0:400d:c04::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA0FA1A0205
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 16:39:06 +1100 (AEDT)
Received: by mail-qg0-x22f.google.com with SMTP id y9so129969695qgd.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Feb 2016 21:39:06 -0800 (PST)
From: David Long <dave.long@linaro.org>
To: "H. Peter Anvin" <hpa@zytor.com>,
 "chengang@emindsoft.com.cn" <chengang@emindsoft.com.cn>,
 Andy Lutomirski <luto@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Borislav Petkov <bp@suse.de>, Brian Gerst <brgerst@gmail.com>,
 David Hildenbrand <dahi@linux.vnet.ibm.com>,
 Denys Vlasenko <dvlasenk@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Oleg Nesterov <oleg@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Rashmica Gupta <rashmicy@gmail.com>,
 Rich Felker <dalias@libc.org>, Richard Kuo <rkuo@codeaurora.org>,
 Roland McGrath <roland@hack.frob.com>,
 Russell King <linux@arm.linux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH v3 2/2] Consolidate redundant register/stack access code
Date: Tue,  9 Feb 2016 00:38:57 -0500
Message-Id: <1454996337-7935-3-git-send-email-dave.long@linaro.org>
In-Reply-To: <1454996337-7935-1-git-send-email-dave.long@linaro.org>
References: <1454996337-7935-1-git-send-email-dave.long@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "David A. Long" <dave.long@linaro.org>

Several architectures have identical or functionally equivalent code
implementing parts of the HAVE_REGS_AND_STACK_ACCESS_API feature.  Move
that code out of the architecture directories.

Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/include/asm/ptrace.h          |  6 ---
 arch/arm/kernel/ptrace.c               | 67 +--------------------------------
 arch/hexagon/include/uapi/asm/ptrace.h |  3 --
 arch/powerpc/include/asm/ptrace.h      | 38 -------------------
 arch/powerpc/kernel/ptrace.c           | 34 +----------------
 arch/s390/include/asm/ptrace.h         |  3 --
 arch/s390/kernel/ptrace.c              | 69 ++++++++++------------------------
 arch/sh/include/asm/ptrace.h           | 39 -------------------
 arch/sh/kernel/Makefile                |  2 +-
 arch/sh/kernel/ptrace.c                | 33 ----------------
 arch/sh/kernel/ptrace_32.c             |  2 +-
 arch/sh/kernel/ptrace_64.c             |  2 +-
 arch/x86/include/asm/ptrace.h          | 37 ------------------
 arch/x86/kernel/ptrace.c               | 34 +----------------
 include/linux/ptrace.h                 | 42 +++++++++++++++++++++
 kernel/ptrace.c                        | 38 +++++++++++++++++++
 16 files changed, 106 insertions(+), 343 deletions(-)
 delete mode 100644 arch/sh/kernel/ptrace.c

diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 51622ba..84a0ea4 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -120,12 +120,6 @@ extern unsigned long profile_pc(struct pt_regs *regs);
 #include <linux/types.h>
 #define MAX_REG_OFFSET (offsetof(struct pt_regs, ARM_ORIG_r0))
 
-extern int regs_query_register_offset(const char *name);
-extern const char *regs_query_register_name(unsigned int offset);
-extern bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr);
-extern unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
-					       unsigned int n);
-
 /**
  * regs_get_register() - get register value from its offset
  * @regs:	   pt_regs from which register value is gotten
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 3b5a2ba..f26e23b 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -63,7 +63,7 @@
 #define REG_OFFSET_NAME(r) \
 	{.name = #r, .offset = offsetof(struct pt_regs, ARM_##r)}
 
-static const struct pt_regs_offset regoffset_table[] = {
+const struct pt_regs_offset regs_offset_table[] = {
 	REG_OFFSET_NAME(r0),
 	REG_OFFSET_NAME(r1),
 	REG_OFFSET_NAME(r2),
@@ -85,71 +85,6 @@ static const struct pt_regs_offset regoffset_table[] = {
 	REGS_OFFSET_END,
 };
 
-/**
- * regs_query_register_offset() - query register offset from its name
- * @name:	the name of a register
- *
- * regs_query_register_offset() returns the offset of a register in struct
- * pt_regs from its name. If the name is invalid, this returns -EINVAL;
- */
-int regs_query_register_offset(const char *name)
-{
-	const struct pt_regs_offset *roff;
-	for (roff = regoffset_table; roff->name != NULL; roff++)
-		if (!strcmp(roff->name, name))
-			return roff->offset;
-	return -EINVAL;
-}
-
-/**
- * regs_query_register_name() - query register name from its offset
- * @offset:	the offset of a register in struct pt_regs.
- *
- * regs_query_register_name() returns the name of a register from its
- * offset in struct pt_regs. If the @offset is invalid, this returns NULL;
- */
-const char *regs_query_register_name(unsigned int offset)
-{
-	const struct pt_regs_offset *roff;
-	for (roff = regoffset_table; roff->name != NULL; roff++)
-		if (roff->offset == offset)
-			return roff->name;
-	return NULL;
-}
-
-/**
- * regs_within_kernel_stack() - check the address in the stack
- * @regs:      pt_regs which contains kernel stack pointer.
- * @addr:      address which is checked.
- *
- * regs_within_kernel_stack() checks @addr is within the kernel stack page(s).
- * If @addr is within the kernel stack, it returns true. If not, returns false.
- */
-bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr)
-{
-	return ((addr & ~(THREAD_SIZE - 1))  ==
-		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1)));
-}
-
-/**
- * regs_get_kernel_stack_nth() - get Nth entry of the stack
- * @regs:	pt_regs which contains kernel stack pointer.
- * @n:		stack entry number.
- *
- * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack which
- * is specified by @regs. If the @n th entry is NOT in the kernel stack,
- * this returns 0.
- */
-unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
-{
-	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
-	addr += n;
-	if (regs_within_kernel_stack(regs, (unsigned long)addr))
-		return *addr;
-	else
-		return 0;
-}
-
 /*
  * this routine will get a word off of the processes privileged stack.
  * the offset is how far from the base addr as stored in the THREAD.
diff --git a/arch/hexagon/include/uapi/asm/ptrace.h b/arch/hexagon/include/uapi/asm/ptrace.h
index 065e5b3..0afb664 100644
--- a/arch/hexagon/include/uapi/asm/ptrace.h
+++ b/arch/hexagon/include/uapi/asm/ptrace.h
@@ -29,9 +29,6 @@
 #define profile_pc(regs) instruction_pointer(regs)
 
 /* kprobe-based event tracer support */
-extern int regs_query_register_offset(const char *name);
-extern const char *regs_query_register_name(unsigned int offset);
-
 #define current_pt_regs() \
 	((struct pt_regs *) \
 	 ((unsigned long)current_thread_info() + THREAD_SIZE) - 1)
diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index c0c61fa..64b9b3d 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -156,8 +156,6 @@ do {									      \
 
 #include <linux/stddef.h>
 #include <linux/thread_info.h>
-extern int regs_query_register_offset(const char *name);
-extern const char *regs_query_register_name(unsigned int offset);
 #define MAX_REG_OFFSET (offsetof(struct pt_regs, dsisr))
 
 /**
@@ -177,42 +175,6 @@ static inline unsigned long regs_get_register(struct pt_regs *regs,
 	return *(unsigned long *)((unsigned long)regs + offset);
 }
 
-/**
- * regs_within_kernel_stack() - check the address in the stack
- * @regs:      pt_regs which contains kernel stack pointer.
- * @addr:      address which is checked.
- *
- * regs_within_kernel_stack() checks @addr is within the kernel stack page(s).
- * If @addr is within the kernel stack, it returns true. If not, returns false.
- */
-
-static inline bool regs_within_kernel_stack(struct pt_regs *regs,
-						unsigned long addr)
-{
-	return ((addr & ~(THREAD_SIZE - 1))  ==
-		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1)));
-}
-
-/**
- * regs_get_kernel_stack_nth() - get Nth entry of the stack
- * @regs:	pt_regs which contains kernel stack pointer.
- * @n:		stack entry number.
- *
- * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack which
- * is specified by @regs. If the @n th entry is NOT in the kernel stack,
- * this returns 0.
- */
-static inline unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
-						      unsigned int n)
-{
-	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
-	addr += n;
-	if (regs_within_kernel_stack(regs, (unsigned long)addr))
-		return *addr;
-	else
-		return 0;
-}
-
 #endif /* __ASSEMBLY__ */
 
 #ifndef __powerpc64__
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 77bd4c4..1f8310a 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -57,7 +57,7 @@
 	{.name = STR(r##num), .offset = offsetof(struct pt_regs, gpr[num])}, \
 	{.name = STR(gpr##num), .offset = offsetof(struct pt_regs, gpr[num])}
 
-static const struct pt_regs_offset regoffset_table[] = {
+const struct pt_regs_offset regs_offset_table[] = {
 	GPR_OFFSET_NAME(0),
 	GPR_OFFSET_NAME(1),
 	GPR_OFFSET_NAME(2),
@@ -107,38 +107,6 @@ static const struct pt_regs_offset regoffset_table[] = {
 	REGS_OFFSET_END,
 };
 
-/**
- * regs_query_register_offset() - query register offset from its name
- * @name:	the name of a register
- *
- * regs_query_register_offset() returns the offset of a register in struct
- * pt_regs from its name. If the name is invalid, this returns -EINVAL;
- */
-int regs_query_register_offset(const char *name)
-{
-	const struct pt_regs_offset *roff;
-	for (roff = regoffset_table; roff->name != NULL; roff++)
-		if (!strcmp(roff->name, name))
-			return roff->offset;
-	return -EINVAL;
-}
-
-/**
- * regs_query_register_name() - query register name from its offset
- * @offset:	the offset of a register in struct pt_regs.
- *
- * regs_query_register_name() returns the name of a register from its
- * offset in struct pt_regs. If the @offset is invalid, this returns NULL;
- */
-const char *regs_query_register_name(unsigned int offset)
-{
-	const struct pt_regs_offset *roff;
-	for (roff = regoffset_table; roff->name != NULL; roff++)
-		if (roff->offset == offset)
-			return roff->name;
-	return NULL;
-}
-
 /*
  * does not yet catch signals sent when the child dies.
  * in exit.c or in signal.c.
diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index 99bc456..890bc54 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -164,10 +164,7 @@ static inline void instruction_pointer_set(struct pt_regs *regs,
 	regs->psw.addr = val;
 }
 
-int regs_query_register_offset(const char *name);
-const char *regs_query_register_name(unsigned int offset);
 unsigned long regs_get_register(struct pt_regs *regs, unsigned int offset);
-unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n);
 
 static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
 {
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 49b1c13..8e75a93 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -1430,9 +1430,26 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 	return &user_s390_view;
 }
 
-static const char *gpr_names[NUM_GPRS] = {
-	"r0", "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
-	"r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
+#define REG_OFFSET_NAME(r) {.name = "r" #r, .offset = r}
+
+const struct pt_regs_offset regs_offset_table[NUM_GPRS+1] = {
+	REG_OFFSET_NAME(0),
+	REG_OFFSET_NAME(1),
+	REG_OFFSET_NAME(2),
+	REG_OFFSET_NAME(3),
+	REG_OFFSET_NAME(4),
+	REG_OFFSET_NAME(5),
+	REG_OFFSET_NAME(6),
+	REG_OFFSET_NAME(7),
+	REG_OFFSET_NAME(8),
+	REG_OFFSET_NAME(9),
+	REG_OFFSET_NAME(10),
+	REG_OFFSET_NAME(11),
+	REG_OFFSET_NAME(12),
+	REG_OFFSET_NAME(13),
+	REG_OFFSET_NAME(14),
+	REG_OFFSET_NAME(15),
+	REGS_OFFSET_END
 };
 
 unsigned long regs_get_register(struct pt_regs *regs, unsigned int offset)
@@ -1441,49 +1458,3 @@ unsigned long regs_get_register(struct pt_regs *regs, unsigned int offset)
 		return 0;
 	return regs->gprs[offset];
 }
-
-int regs_query_register_offset(const char *name)
-{
-	unsigned long offset;
-
-	if (!name || *name != 'r')
-		return -EINVAL;
-	if (kstrtoul(name + 1, 10, &offset))
-		return -EINVAL;
-	if (offset >= NUM_GPRS)
-		return -EINVAL;
-	return offset;
-}
-
-const char *regs_query_register_name(unsigned int offset)
-{
-	if (offset >= NUM_GPRS)
-		return NULL;
-	return gpr_names[offset];
-}
-
-static int regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr)
-{
-	unsigned long ksp = kernel_stack_pointer(regs);
-
-	return (addr & ~(THREAD_SIZE - 1)) == (ksp & ~(THREAD_SIZE - 1));
-}
-
-/**
- * regs_get_kernel_stack_nth() - get Nth entry of the stack
- * @regs:pt_regs which contains kernel stack pointer.
- * @n:stack entry number.
- *
- * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack which
- * is specifined by @regs. If the @n th entry is NOT in the kernel stack,
- * this returns 0.
- */
-unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
-{
-	unsigned long addr;
-
-	addr = kernel_stack_pointer(regs) + n * sizeof(long);
-	if (!regs_within_kernel_stack(regs, addr))
-		return 0;
-	return *(unsigned long *)addr;
-}
diff --git a/arch/sh/include/asm/ptrace.h b/arch/sh/include/asm/ptrace.h
index 523955f..8045eb4 100644
--- a/arch/sh/include/asm/ptrace.h
+++ b/arch/sh/include/asm/ptrace.h
@@ -29,10 +29,6 @@
 	{.name = __stringify(tr##num), .offset = offsetof(struct pt_regs, tregs[num])}
 
 /* Query offset/name of register from its name/offset */
-extern int regs_query_register_offset(const char *name);
-extern const char *regs_query_register_name(unsigned int offset);
-
-extern const struct pt_regs_offset regoffset_table[];
 
 /**
  * regs_get_register() - get register value from its offset
@@ -51,41 +47,6 @@ static inline unsigned long regs_get_register(struct pt_regs *regs,
 	return *(unsigned long *)((unsigned long)regs + offset);
 }
 
-/**
- * regs_within_kernel_stack() - check the address in the stack
- * @regs:	pt_regs which contains kernel stack pointer.
- * @addr:	address which is checked.
- *
- * regs_within_kernel_stack() checks @addr is within the kernel stack page(s).
- * If @addr is within the kernel stack, it returns true. If not, returns false.
- */
-static inline int regs_within_kernel_stack(struct pt_regs *regs,
-					   unsigned long addr)
-{
-	return ((addr & ~(THREAD_SIZE - 1))  ==
-		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1)));
-}
-
-/**
- * regs_get_kernel_stack_nth() - get Nth entry of the stack
- * @regs:	pt_regs which contains kernel stack pointer.
- * @n:		stack entry number.
- *
- * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack which
- * is specified by @regs. If the @n th entry is NOT in the kernel stack,
- * this returns 0.
- */
-static inline unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
-						      unsigned int n)
-{
-	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
-	addr += n;
-	if (regs_within_kernel_stack(regs, (unsigned long)addr))
-		return *addr;
-	else
-		return 0;
-}
-
 struct perf_event;
 struct perf_sample_data;
 
diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index 2ccf36c..4ae9a11 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -14,7 +14,7 @@ CFLAGS_REMOVE_return_address.o = -pg
 obj-y	:= debugtraps.o dma-nommu.o dumpstack.o 		\
 	   idle.o io.o irq.o irq_$(BITS).o kdebugfs.o			\
 	   machvec.o nmi_debug.o process.o				\
-	   process_$(BITS).o ptrace.o ptrace_$(BITS).o			\
+	   process_$(BITS).o ptrace_$(BITS).o				\
 	   reboot.o return_address.o					\
 	   setup.o signal_$(BITS).o sys_sh.o 				\
 	   syscalls_$(BITS).o time.o topology.o traps.o			\
diff --git a/arch/sh/kernel/ptrace.c b/arch/sh/kernel/ptrace.c
deleted file mode 100644
index 0a05983..0000000
--- a/arch/sh/kernel/ptrace.c
+++ /dev/null
@@ -1,33 +0,0 @@
-#include <linux/ptrace.h>
-
-/**
- * regs_query_register_offset() - query register offset from its name
- * @name:	the name of a register
- *
- * regs_query_register_offset() returns the offset of a register in struct
- * pt_regs from its name. If the name is invalid, this returns -EINVAL;
- */
-int regs_query_register_offset(const char *name)
-{
-	const struct pt_regs_offset *roff;
-	for (roff = regoffset_table; roff->name != NULL; roff++)
-		if (!strcmp(roff->name, name))
-			return roff->offset;
-	return -EINVAL;
-}
-
-/**
- * regs_query_register_name() - query register name from its offset
- * @offset:	the offset of a register in struct pt_regs.
- *
- * regs_query_register_name() returns the name of a register from its
- * offset in struct pt_regs. If the @offset is invalid, this returns NULL;
- */
-const char *regs_query_register_name(unsigned int offset)
-{
-	const struct pt_regs_offset *roff;
-	for (roff = regoffset_table; roff->name != NULL; roff++)
-		if (roff->offset == offset)
-			return roff->name;
-	return NULL;
-}
diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index e6fe4f4..c5c385c 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -276,7 +276,7 @@ static int dspregs_active(struct task_struct *target,
 }
 #endif
 
-const struct pt_regs_offset regoffset_table[] = {
+const struct pt_regs_offset regs_offset_table[] = {
 	REG_OFFSET_NAME(0),
 	REG_OFFSET_NAME(1),
 	REG_OFFSET_NAME(2),
diff --git a/arch/sh/kernel/ptrace_64.c b/arch/sh/kernel/ptrace_64.c
index af55bb6..565227ef 100644
--- a/arch/sh/kernel/ptrace_64.c
+++ b/arch/sh/kernel/ptrace_64.c
@@ -252,7 +252,7 @@ static int fpregs_active(struct task_struct *target,
 }
 #endif
 
-const struct pt_regs_offset regoffset_table[] = {
+const struct pt_regs_offset regs_offset_table[] = {
 	REGS_OFFSET_NAME(pc),
 	REGS_OFFSET_NAME(sr),
 	REGS_OFFSET_NAME(syscall_nr),
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 6271281..0f498ff 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -156,8 +156,6 @@ static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
 #include <asm-generic/ptrace.h>
 
 /* Query offset/name of register from its name/offset */
-extern int regs_query_register_offset(const char *name);
-extern const char *regs_query_register_name(unsigned int offset);
 #define MAX_REG_OFFSET (offsetof(struct pt_regs, ss))
 
 /**
@@ -186,41 +184,6 @@ static inline unsigned long regs_get_register(struct pt_regs *regs,
 	return *(unsigned long *)((unsigned long)regs + offset);
 }
 
-/**
- * regs_within_kernel_stack() - check the address in the stack
- * @regs:	pt_regs which contains kernel stack pointer.
- * @addr:	address which is checked.
- *
- * regs_within_kernel_stack() checks @addr is within the kernel stack page(s).
- * If @addr is within the kernel stack, it returns true. If not, returns false.
- */
-static inline int regs_within_kernel_stack(struct pt_regs *regs,
-					   unsigned long addr)
-{
-	return ((addr & ~(THREAD_SIZE - 1))  ==
-		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1)));
-}
-
-/**
- * regs_get_kernel_stack_nth() - get Nth entry of the stack
- * @regs:	pt_regs which contains kernel stack pointer.
- * @n:		stack entry number.
- *
- * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack which
- * is specified by @regs. If the @n th entry is NOT in the kernel stack,
- * this returns 0.
- */
-static inline unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
-						      unsigned int n)
-{
-	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
-	addr += n;
-	if (regs_within_kernel_stack(regs, (unsigned long)addr))
-		return *addr;
-	else
-		return 0;
-}
-
 #define arch_has_single_step()	(1)
 #ifdef CONFIG_X86_DEBUGCTLMSR
 #define arch_has_block_step()	(1)
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index ff3314f..e380e3d 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -52,7 +52,7 @@ enum x86_regset {
 };
 
 
-static const struct pt_regs_offset regoffset_table[] = {
+const struct pt_regs_offset regs_offset_table[] = {
 #ifdef CONFIG_X86_64
 	REGS_OFFSET_NAME(r15),
 	REGS_OFFSET_NAME(r14),
@@ -85,38 +85,6 @@ static const struct pt_regs_offset regoffset_table[] = {
 	REGS_OFFSET_END,
 };
 
-/**
- * regs_query_register_offset() - query register offset from its name
- * @name:	the name of a register
- *
- * regs_query_register_offset() returns the offset of a register in struct
- * pt_regs from its name. If the name is invalid, this returns -EINVAL;
- */
-int regs_query_register_offset(const char *name)
-{
-	const struct pt_regs_offset *roff;
-	for (roff = regoffset_table; roff->name != NULL; roff++)
-		if (!strcmp(roff->name, name))
-			return roff->offset;
-	return -EINVAL;
-}
-
-/**
- * regs_query_register_name() - query register name from its offset
- * @offset:	the offset of a register in struct pt_regs.
- *
- * regs_query_register_name() returns the name of a register from its
- * offset in struct pt_regs. If the @offset is invalid, this returns NULL;
- */
-const char *regs_query_register_name(unsigned int offset)
-{
-	const struct pt_regs_offset *roff;
-	for (roff = regoffset_table; roff->name != NULL; roff++)
-		if (roff->offset == offset)
-			return roff->name;
-	return NULL;
-}
-
 /*
  * does not yet catch signals sent when the child dies.
  * in exit.c or in signal.c.
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 4e1c6fd..08423b0 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -416,6 +416,48 @@ struct pt_regs_offset {
 	int offset;
 };
 
+extern const struct pt_regs_offset regs_offset_table[];
+
+extern int regs_query_register_offset(const char *name);
+extern const char *regs_query_register_name(unsigned int offset);
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
+
+	addr += n;
+	if (regs_within_kernel_stack(regs, (unsigned long)addr))
+		return *addr;
+	else
+		return 0;
+}
+
 #endif	/* CONFIG_HAVE_REGS_AND_STACK_ACCESS_API */
 
 #endif
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 2341efe..f657018 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1264,3 +1264,41 @@ COMPAT_SYSCALL_DEFINE4(ptrace, compat_long_t, request, compat_long_t, pid,
 	return ret;
 }
 #endif	/* CONFIG_COMPAT */
+
+#ifdef CONFIG_HAVE_REGS_AND_STACK_ACCESS_API
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
+
+	for (roff = regs_offset_table; roff->name != NULL; roff++)
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
+
+	for (roff = regs_offset_table; roff->name != NULL; roff++)
+		if (roff->offset == offset)
+			return roff->name;
+	return NULL;
+}
+
+#endif /* CONFIG_HAVE_REGS_AND_STACK_ACCESS_API */
-- 
2.5.0
