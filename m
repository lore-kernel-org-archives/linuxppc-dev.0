Return-Path: <anton@samba.org>
Date: Wed, 9 Jan 2013 10:48:15 +1100
From: Anton Blanchard <anton@samba.org>
To: eparis@redhat.com, viro@zeniv.linux.org.uk, benh@kernel.crashing.org,
 paulus@samba.org
Subject: [PATCH 3/4] powerpc: Optimise 64bit syscall auditing entry path
Message-ID: <20130109104815.2b85895a@kryten>
In-Reply-To: <20130109104617.74e995a5@kryten>
References: <20130109104617.74e995a5@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Add an assembly fast path for the syscall audit entry path on
64bit. Some distros enable auditing by default which forces us
through the syscall auditing path even if there are no rules.

I wrote some test cases to validate the patch:

http://ozlabs.org/~anton/junkcode/audit_tests.tar.gz

And to test the performance I ran a simple null syscall
microbenchmark on a POWER7 box:

http://ozlabs.org/~anton/junkcode/null_syscall.c

Baseline: 949.2 cycles
Patched:  920.6 cycles

An improvement of 3%. Most of the potential gains are masked by
the syscall audit exit path which will be fixed in a
subsequent patch.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/kernel/entry_64.S
===================================================================
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -34,6 +34,12 @@
 #include <asm/ftrace.h>
 #include <asm/hw_irq.h>
 
+/* Avoid __ASSEMBLER__'ifying <linux/audit.h> just for this.  */
+#include <linux/elf-em.h>
+#define AUDIT_ARCH_PPC		(EM_PPC)
+#define AUDIT_ARCH_PPC64	(EM_PPC64|__AUDIT_ARCH_64BIT)
+#define __AUDIT_ARCH_64BIT 0x80000000
+
 /*
  * System calls.
  */
@@ -244,6 +250,10 @@ syscall_error:
 	
 /* Traced system call support */
 syscall_dotrace:
+#ifdef CONFIG_AUDITSYSCALL
+	andi.	r11,r10,(_TIF_SYSCALL_T_OR_A & ~_TIF_SYSCALL_AUDIT)
+	beq	audit_entry
+#endif
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.do_syscall_trace_enter
@@ -253,6 +263,7 @@ syscall_dotrace:
 	 * for the call number to look up in the table (r0).
 	 */
 	mr	r0,r3
+.Laudit_entry_return:
 	ld	r3,GPR3(r1)
 	ld	r4,GPR4(r1)
 	ld	r5,GPR5(r1)
@@ -264,6 +275,34 @@ syscall_dotrace:
 	ld	r10,TI_FLAGS(r10)
 	b	.Lsyscall_dotrace_cont
 
+#ifdef CONFIG_AUDITSYSCALL
+audit_entry:
+	ld	r4,GPR0(r1)
+	ld	r5,GPR3(r1)
+	ld	r6,GPR4(r1)
+	ld	r7,GPR5(r1)
+	ld	r8,GPR6(r1)
+
+	andi.	r11,r10,_TIF_32BIT
+	beq	1f
+
+	lis	r3,AUDIT_ARCH_PPC@h
+	ori	r3,r3,AUDIT_ARCH_PPC@l
+	clrldi	r5,r5,32
+	clrldi	r6,r6,32
+	clrldi	r7,r7,32
+	clrldi	r8,r8,32
+	bl	.__audit_syscall_entry
+	ld	r0,GPR0(r1)
+	b	.Laudit_entry_return
+
+1:	lis	r3,AUDIT_ARCH_PPC64@h
+	ori	r3,r3,AUDIT_ARCH_PPC64@l
+	bl	.__audit_syscall_entry
+	ld	r0,GPR0(r1)
+	b	.Laudit_entry_return
+#endif
+
 syscall_enosys:
 	li	r3,-ENOSYS
 	b	syscall_exit
