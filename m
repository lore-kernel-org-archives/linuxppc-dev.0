Return-Path: <anton@samba.org>
Date: Thu, 5 Apr 2012 14:23:27 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/4] powerpc: Hide some system call labels from profile tools
Message-ID: <20120405142327.6038bbb4@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


syscall_dotrace_cont and syscall_error_cont tend to complicate perf
output so make them local.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/entry_64.S
===================================================================
--- linux-build.orig/arch/powerpc/kernel/entry_64.S	2012-03-22 22:41:21.209137690 +1100
+++ linux-build/arch/powerpc/kernel/entry_64.S	2012-03-22 22:47:04.479314599 +1100
@@ -154,7 +154,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLP
 	ld	r10,TI_FLAGS(r11)
 	andi.	r11,r10,_TIF_SYSCALL_T_OR_A
 	bne-	syscall_dotrace
-syscall_dotrace_cont:
+.Lsyscall_dotrace_cont:
 	cmpldi	0,r0,NR_syscalls
 	bge-	syscall_enosys
 
@@ -211,7 +211,7 @@ syscall_exit:
 	cmpld	r3,r11
 	ld	r5,_CCR(r1)
 	bge-	syscall_error
-syscall_error_cont:
+.Lsyscall_error_cont:
 	ld	r7,_NIP(r1)
 BEGIN_FTR_SECTION
 	stdcx.	r0,0,r1			/* to clear the reservation */
@@ -246,7 +246,7 @@ syscall_error:
 	oris	r5,r5,0x1000	/* Set SO bit in CR */
 	neg	r3,r3
 	std	r5,_CCR(r1)
-	b	syscall_error_cont
+	b	.Lsyscall_error_cont
 	
 /* Traced system call support */
 syscall_dotrace:
@@ -268,7 +268,7 @@ syscall_dotrace:
 	addi	r9,r1,STACK_FRAME_OVERHEAD
 	clrrdi	r10,r1,THREAD_SHIFT
 	ld	r10,TI_FLAGS(r10)
-	b	syscall_dotrace_cont
+	b	.Lsyscall_dotrace_cont
 
 syscall_enosys:
 	li	r3,-ENOSYS
