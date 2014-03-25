Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 03/33] powerpc: Don't use a function descriptor for system
 call table
Date: Tue, 25 Mar 2014 22:44:09 +1100
Message-Id: <1395747879-5948-4-git-send-email-anton@samba.org>
In-Reply-To: <1395747879-5948-1-git-send-email-anton@samba.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is no need to create a function descriptor for the system call
table. By using one we force the system call table into the text
section and it really belongs in the rodata section.

This also removes another use of dot symbols.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/entry_64.S | 6 +++---
 arch/powerpc/kernel/systbl.S   | 6 +++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2d92eeb..2662f02 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -39,8 +39,8 @@
  * System calls.
  */
 	.section	".toc","aw"
-.SYS_CALL_TABLE:
-	.tc .sys_call_table[TC],.sys_call_table
+SYS_CALL_TABLE:
+	.tc sys_call_table[TC],sys_call_table
 
 /* This value is used to mark exception frames on the stack. */
 exception_marker:
@@ -162,7 +162,7 @@ system_call:			/* label this so stack traces look sane */
  * Need to vector to 32 Bit or default sys_call_table here,
  * based on caller's run-mode / personality.
  */
-	ld	r11,.SYS_CALL_TABLE@toc(2)
+	ld	r11,SYS_CALL_TABLE@toc(2)
 	andi.	r10,r10,_TIF_32BIT
 	beq	15f
 	addi	r11,r11,8	/* use 32-bit syscall entries */
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 93219c3..75822f9 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -36,6 +36,8 @@
 #define PPC_SYS_SPU(func)	PPC_SYS(func)
 #define SYSX_SPU(f, f3264, f32)	SYSX(f, f3264, f32)
 
+.section .rodata,"a"
+
 #ifdef CONFIG_PPC64
 #define sys_sigpending	sys_ni_syscall
 #define sys_old_getrlimit sys_ni_syscall
@@ -43,5 +45,7 @@
 	.p2align	3
 #endif
 
-_GLOBAL(sys_call_table)
+.globl sys_call_table
+sys_call_table:
+
 #include <asm/systbl.h>
-- 
1.8.3.2
