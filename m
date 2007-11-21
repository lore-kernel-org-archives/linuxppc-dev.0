Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18243.41278.72798.100000@cargo.ozlabs.ibm.com>
Date: Wed, 21 Nov 2007 14:08:46 +1100
From: Paul Mackerras <paulus@samba.org>
To: Ulrich Drepper <drepper@redhat.com>, linuxppc-dev@ozlabs.org
Subject: [PATCH] sys_indirect kernel implementation for PowerPC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This implements sys_indirect for 32-bit and 64-bit powerpc machines,
including a 32-bit compatibility implementation for 64-bit powerpc.
I decided to use assembly language for call_syscall because on 64-bit
powerpc the system call table has the addresses of the function text
rather than pointers to function descriptors; hence the system call
functions can't be called from C via the system call table.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
This patch applies on top of Ulrich Drepper's series adding the
generic and x86-specific code for sys_indirect.

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 69a91bd..fd6781c 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -461,6 +461,25 @@ ppc_swapcontext:
 	b	sys_swapcontext
 
 /*
+ * long call_compat_syscall(struct indirect_registers32 *regs)
+ * This function assumes that regs->syscall_nr has already been validated.
+ */
+_GLOBAL(call_syscall)
+	lwz	r0,0(r3)	/* system call number */
+	lis	r11,sys_call_table@ha
+	addi	r11,r11,sys_call_table@l
+	slwi	r0,r0,2
+	lwzx	r10,r11,r0
+	mtctr	r10
+	lwz	r4,8(r3)
+	lwz	r5,12(r3)
+	lwz	r6,16(r3)
+	lwz	r7,20(r3)
+	lwz	r8,24(r3)
+	lwz	r3,4(r3)
+	bctr
+
+/*
  * Top-level page fault handling.
  * This is in assembler because if do_page_fault tells us that
  * it is a bad kernel page fault, we want to save the non-volatile
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 148a354..516ee70 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -315,6 +315,43 @@ _GLOBAL(ret_from_fork)
 	b	syscall_exit
 
 /*
+ * long call_syscall(struct indirect_registers *regs)
+ * This function assumes that regs->syscall_nr has already been validated.
+ */
+_GLOBAL(call_syscall)
+	ld	r11,.SYS_CALL_TABLE@toc(2)
+	ld	r0,0(r3)	/* system call number */
+	sldi	r0,r0,4
+	ldx	r10,r11,r0
+	mtctr	r10
+	ld	r4,16(r3)
+	ld	r5,24(r3)
+	ld	r6,32(r3)
+	ld	r7,40(r3)
+	ld	r8,48(r3)
+	ld	r3,8(r3)
+	bctr
+
+/*
+ * long call_compat_syscall(struct indirect_registers32 *regs)
+ * This function assumes that regs->syscall_nr has already been validated.
+ */
+_GLOBAL(call_compat_syscall)
+	ld	r11,.SYS_CALL_TABLE@toc(2)
+	lwz	r0,0(r3)	/* system call number */
+	sldi	r0,r0,4
+	addi	r11,r11,8
+	ldx	r10,r11,r0
+	mtctr	r10
+	lwz	r4,8(r3)
+	lwz	r5,12(r3)
+	lwz	r6,16(r3)
+	lwz	r7,20(r3)
+	lwz	r8,24(r3)
+	lwz	r3,4(r3)
+	bctr
+
+/*
  * This routine switches between two different tasks.  The process
  * state of one is saved on its kernel stack.  Then the state
  * of the other is restored from its kernel stack.  The memory
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index 4a4f5c6..fcaf0b2 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -826,3 +826,37 @@ asmlinkage long compat_sys_sync_file_range2(int fd, unsigned int flags,
 
 	return sys_sync_file_range(fd, offset, nbytes, flags);
 }
+
+long compat_sys_indirect(struct indirect_registers32 __user *userregs,
+			 void __user *userparams, size_t paramslen,
+			 int flags)
+{
+	struct indirect_registers32 regs;
+	long result;
+
+	if (unlikely(flags != 0))
+		return -EINVAL;
+
+	if (copy_from_user(&regs, userregs, sizeof(regs)))
+		return -EFAULT;
+
+	switch (regs.syscall_nr) {
+#define INDSYSCALL(name) __NR_##name
+#include <linux/indirect.h>
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (paramslen > sizeof(union indirect_params))
+		return -EINVAL;
+
+	result = -EFAULT;
+	if (!copy_from_user(&current->indirect_params, userparams, paramslen))
+		result = call_compat_syscall(&regs);
+
+	memset(&current->indirect_params, '\0', paramslen);
+
+	return result;
+}
diff --git a/include/asm-powerpc/indirect.h b/include/asm-powerpc/indirect.h
new file mode 100644
index 0000000..fcc6729
--- /dev/null
+++ b/include/asm-powerpc/indirect.h
@@ -0,0 +1,32 @@
+#ifndef _ASM_POWERPC_INDIRECT_H_
+#define _ASM_POWERPC_INDIRECT_H_
+/*
+ * Copyright 2007 Paul Mackerras <paulus@au1.ibm.com>, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+struct indirect_registers {
+	unsigned long syscall_nr;
+	unsigned long args[6];
+};
+
+extern long call_syscall(struct indirect_registers *regs);
+
+#define INDIRECT_SYSCALL(regs)		(regs)->syscall_nr
+#define CALL_INDIRECT(regs)		call_syscall(regs)
+
+#ifdef CONFIG_PPC64
+struct indirect_registers32 {
+	unsigned int syscall_nr;
+	unsigned int args[6];
+};
+
+extern long call_compat_syscall(struct indirect_registers32 *regs);
+
+#endif /* CONFIG_PPC64 */
+
+#endif /* _ASM_POWERPC_INDIRECT_H_ */
diff --git a/include/asm-powerpc/systbl.h b/include/asm-powerpc/systbl.h
index 11d5383..de2f4d7 100644
--- a/include/asm-powerpc/systbl.h
+++ b/include/asm-powerpc/systbl.h
@@ -313,3 +313,4 @@ COMPAT_SYS_SPU(timerfd)
 SYSCALL_SPU(eventfd)
 COMPAT_SYS_SPU(sync_file_range2)
 COMPAT_SYS(fallocate)
+COMPAT_SYS(indirect)
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index 97d82b6..400e4a6 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -332,10 +332,11 @@
 #define __NR_eventfd		307
 #define __NR_sync_file_range2	308
 #define __NR_fallocate		309
+#define __NR_indirect		310
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		310
+#define __NR_syscalls		311
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
