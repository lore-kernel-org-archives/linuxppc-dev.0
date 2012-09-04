Return-Path: <anton@samba.org>
Date: Tue, 4 Sep 2012 12:51:10 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 4/4] powerpc: Restore correct DSCR in context switch
Message-ID: <20120904125110.102244f3@kryten>
In-Reply-To: <20120904124756.4ddeb535@kryten>
References: <20120904124756.4ddeb535@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


During a context switch we always restore the per thread DSCR value.
If we aren't doing explicit DSCR management
(ie thread.dscr_inherit == 0) and the default DSCR changed while
the process has been sleeping we end up with the wrong value.

Check thread.dscr_inherit and select the default DSCR or per thread
DSCR as required.

This was found with the following test case, when running with
more threads than CPUs (ie forcing context switching):

http://ozlabs.org/~anton/junkcode/dscr_default_test.c

With the four patches applied I can run a combination of all
test cases successfully at the same time:

http://ozlabs.org/~anton/junkcode/dscr_default_test.c
http://ozlabs.org/~anton/junkcode/dscr_explicit_test.c
http://ozlabs.org/~anton/junkcode/dscr_inherit_test.c

Signed-off-by: Anton Blanchard <anton@samba.org>  
Cc: <stable@kernel.org> # 3.0+
---

Index: b/arch/powerpc/kernel/entry_64.S
===================================================================
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -370,6 +370,12 @@ _GLOBAL(ret_from_fork)
 	li	r3,0
 	b	syscall_exit
 
+	.section	".toc","aw"
+DSCR_DEFAULT:
+	.tc dscr_default[TC],dscr_default
+
+	.section	".text"
+
 /*
  * This routine switches between two different tasks.  The process
  * state of one is saved on its kernel stack.  Then the state
@@ -509,9 +515,6 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEG
 	mr	r1,r8		/* start using new stack pointer */
 	std	r7,PACAKSAVE(r13)
 
-	ld	r6,_CCR(r1)
-	mtcrf	0xFF,r6
-
 #ifdef CONFIG_ALTIVEC
 BEGIN_FTR_SECTION
 	ld	r0,THREAD_VRSAVE(r4)
@@ -520,14 +523,22 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_PPC64
 BEGIN_FTR_SECTION
+	lwz	r6,THREAD_DSCR_INHERIT(r4)
+	ld	r7,DSCR_DEFAULT@toc(2)
 	ld	r0,THREAD_DSCR(r4)
-	cmpd	r0,r25
-	beq	1f
+	cmpwi	r6,0
+	bne	1f
+	ld	r0,0(r7)
+1:	cmpd	r0,r25
+	beq	2f
 	mtspr	SPRN_DSCR,r0
-1:	
+2:
 END_FTR_SECTION_IFSET(CPU_FTR_DSCR)
 #endif
 
+	ld	r6,_CCR(r1)
+	mtcrf	0xFF,r6
+
 	/* r3-r13 are destroyed -- Cort */
 	REST_8GPRS(14, r1)
 	REST_10GPRS(22, r1)
Index: b/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -76,6 +76,7 @@ int main(void)
 	DEFINE(SIGSEGV, SIGSEGV);
 	DEFINE(NMI_MASK, NMI_MASK);
 	DEFINE(THREAD_DSCR, offsetof(struct thread_struct, dscr));
+	DEFINE(THREAD_DSCR_INHERIT, offsetof(struct thread_struct, dscr_inherit));
 #else
 	DEFINE(THREAD_INFO, offsetof(struct task_struct, stack));
 #endif /* CONFIG_PPC64 */
