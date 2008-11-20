Return-Path: <radford@galvanix.net>
Received: from mail.blackbean.org (cpe-67-49-92-118.socal.res.rr.com
	[67.49.92.118])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3AB0FDDE17
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 09:12:08 +1100 (EST)
Date: Thu, 20 Nov 2008 14:11:49 -0800
From: Jim Radford <radford@galvanix.net>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] ftrace: mcountrecord.pl for arm
Message-ID: <20081120221149.GA2470@blackbean.org>
References: <20081120203415.251344054@goodmis.org>
	<20081120220406.GA2159@blackbean.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081120220406.GA2159@blackbean.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Matt Fleming <mjf@gentoo.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.arm.linux.org.uk, linuxppc-dev@ozlabs.org,
	Paul Mundt <lethal@linux-sh.org>, Ingo Molnar <mingo@elte.hu>,
	Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ingo and Steven,

Here's an updated version of the arch/arm changes for dynamic ftrace
based on top of your latest tip/master.

-Jim

---
From: Jim Radford <radford@galvanix.com>
Subject: ftrace: enable dynamic ftrace for arm

Update to the latest api, syncing functions with the x86 versions.

Index: linux-2.6/arch/arm/Kconfig
===================================================================
--- linux-2.6.orig/arch/arm/Kconfig
+++ linux-2.6/arch/arm/Kconfig
@@ -16,7 +16,9 @@ config ARM
 	select HAVE_ARCH_KGDB
 	select HAVE_KPROBES if (!XIP_KERNEL)
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
-	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
+	select HAVE_FTRACE_MCOUNT_RECORD
+	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
+	select HAVE_FUNCTION_TRACER
 	select HAVE_GENERIC_DMA_COHERENT
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
Index: linux-2.6/arch/arm/include/asm/ftrace.h
===================================================================
--- linux-2.6.orig/arch/arm/include/asm/ftrace.h
+++ linux-2.6/arch/arm/include/asm/ftrace.h
@@ -7,6 +7,19 @@
 
 #ifndef __ASSEMBLY__
 extern void mcount(void);
+
+static inline unsigned long ftrace_call_adjust(unsigned long addr)
+{
+	return addr;
+}
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+
+struct dyn_arch_ftrace {
+	/* No extra data needed for x86 */
+};
+
+#endif /*  CONFIG_DYNAMIC_FTRACE */
 #endif
 
 #endif
Index: linux-2.6/arch/arm/kernel/entry-common.S
===================================================================
--- linux-2.6.orig/arch/arm/kernel/entry-common.S
+++ linux-2.6/arch/arm/kernel/entry-common.S
@@ -104,14 +104,7 @@ ENDPROC(ret_from_fork)
 #ifdef CONFIG_FUNCTION_TRACER
 #ifdef CONFIG_DYNAMIC_FTRACE
 ENTRY(mcount)
-	stmdb sp!, {r0-r3, lr}
-	mov r0, lr
-	sub r0, r0, #MCOUNT_INSN_SIZE
-
-	.globl mcount_call
-mcount_call:
-	bl ftrace_stub
-	ldmia sp!, {r0-r3, pc}
+	mov pc, lr
 
 ENTRY(ftrace_caller)
 	stmdb sp!, {r0-r3, lr}
Index: linux-2.6/arch/arm/kernel/ftrace.c
===================================================================
--- linux-2.6.orig/arch/arm/kernel/ftrace.c
+++ linux-2.6/arch/arm/kernel/ftrace.c
@@ -23,13 +23,13 @@
 static unsigned long bl_insn;
 static const unsigned long NOP = 0xe1a00000; /* mov r0, r0 */
 
-unsigned char *ftrace_nop_replace(void)
+static unsigned char *ftrace_nop_replace(void)
 {
 	return (char *)&NOP;
 }
 
 /* construct a branch (BL) instruction to addr */
-unsigned char *ftrace_call_replace(unsigned long pc, unsigned long addr)
+static unsigned char *ftrace_call_replace(unsigned long pc, unsigned long addr)
 {
 	long offset;
 
@@ -46,7 +46,7 @@ unsigned char *ftrace_call_replace(unsig
 	return (unsigned char *)&bl_insn;
 }
 
-int ftrace_modify_code(unsigned long pc, unsigned char *old_code,
+static int ftrace_modify_code(unsigned long pc, unsigned char *old_code,
 		       unsigned char *new_code)
 {
 	unsigned long err = 0, replaced = 0, old, new;
@@ -82,22 +82,46 @@ int ftrace_modify_code(unsigned long pc,
 	return err;
 }
 
+int ftrace_make_nop(struct module *mod,
+		    struct dyn_ftrace *rec, unsigned long addr)
+{
+	unsigned char *new, *old;
+	unsigned long ip = rec->ip;
+
+	old = ftrace_call_replace(ip, addr);
+	new = ftrace_nop_replace();
+
+	return ftrace_modify_code(rec->ip, old, new);
+}
+
+int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+{
+	unsigned char *new, *old;
+	unsigned long ip = rec->ip;
+
+	old = ftrace_nop_replace();
+	new = ftrace_call_replace(ip, addr);
+
+	return ftrace_modify_code(rec->ip, old, new);
+}
+
 int ftrace_update_ftrace_func(ftrace_func_t func)
 {
+	unsigned long ip = (unsigned long)(&ftrace_call);
+	unsigned char old[MCOUNT_INSN_SIZE], *new;
 	int ret;
-	unsigned long pc, old;
-	unsigned char *new;
 
-	pc = (unsigned long)&ftrace_call;
-	memcpy(&old, &ftrace_call, MCOUNT_INSN_SIZE);
-	new = ftrace_call_replace(pc, (unsigned long)func);
-	ret = ftrace_modify_code(pc, (unsigned char *)&old, new);
+	memcpy(old, &ftrace_call, sizeof(old));
+	new = ftrace_call_replace(ip, (unsigned long)func);
+	ret = ftrace_modify_code(ip, (unsigned char *)&old, new);
+
 	return ret;
 }
 
 /* run from kstop_machine */
 int __init ftrace_dyn_arch_init(void *data)
 {
-	ftrace_mcount_set(data);
+	/* The return code is retured via data */
+	*(unsigned long *)data = 0;
 	return 0;
 }
