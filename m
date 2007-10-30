Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 30 Oct 2007 16:16:54 +1100
Subject: [RFC/PATCH] powerpc: Deal with 44x virtually tagged icache
Message-Id: <20071030051713.5B8B9DE174@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 44x family has an interesting "feature" which is a virtually
tagged instruction cache (yuck !). So far, we haven't dealt with
it properly, which means we've been mostly lucky or people didn't
report the problems, unless people have been running custom patches
in their distro...

This is an attempt at fixing it properly. I chose to do it by
setting a global flag whenever we change a PTE that was previously
marked executable, and flush the entire instruction cache upon
return to user space when that happens.

This is a bit heavy handed, but it's hard to do more fine grained
flushes as the icbi instruction, on those processor, for some very
strange reasons (since the cache is virtually mapped) still requires
a valid TLB entry for reading in the target address space, which
isn't something I want to deal with.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Fortunately, we don't support SMP on these or this solution wouldn't
work.

It does mean we do a bit of over-flushing on swap but on the
other hand, the code is simple. Another option would have been
to do the iccci after any syscall that potentially unmaps or
changes a mapping, like sys_munmap, sys_mremap, sys_sbrk, but
also the shmem stuff etc... I decided there was just too many
and was worried I would miss one.

This not very tested as I don't have a test case at hand showing the
problem and didn't feel like writing one today :-) It boots though.

Careful eyes will notice I didn't do the flush on fast_exception_return,
which shouldn't be necessary.

 arch/powerpc/kernel/entry_32.S      |   25 +++++++++++++++++++++++++
 arch/powerpc/kernel/misc_32.S       |    9 +++++++++
 arch/powerpc/mm/44x_mmu.c           |    1 +
 include/asm-powerpc/pgtable-ppc32.h |   13 +++++++++++++
 4 files changed, 48 insertions(+)

Index: linux-work/arch/powerpc/kernel/entry_32.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/entry_32.S	2007-10-15 11:19:35.000000000 +1000
+++ linux-work/arch/powerpc/kernel/entry_32.S	2007-10-30 16:09:51.000000000 +1100
@@ -244,6 +244,13 @@ syscall_exit_cont:
 	andis.	r10,r0,DBCR0_IC@h
 	bnel-	load_dbcr0
 #endif
+#ifdef CONFIG_44x
+	lis	r4,icache_44x_need_flush@ha
+	lwz	r5,icache_44x_need_flush@l(r4)
+	cmplwi	cr0,r5,0
+	bne-	2f
+1:
+#endif /* CONFIG_44x */
 	stwcx.	r0,0,r1			/* to clear the reservation */
 	lwz	r4,_LINK(r1)
 	lwz	r5,_CCR(r1)
@@ -259,6 +266,13 @@ syscall_exit_cont:
 	SYNC
 	RFI
 
+#ifdef CONFIG_44x
+2:	li	r7,0
+	iccci	r0,r0
+	stw	r7,icache_44x_need_flush@l(r4)
+	b	1b
+#endif  /* CONFIG_44x */
+
 66:	li	r3,-ENOSYS
 	b	ret_from_syscall
 
@@ -683,6 +697,17 @@ resume_kernel:
 
 	/* interrupts are hard-disabled at this point */
 restore:
+#ifdef CONFIG_44x
+	lis	r4,icache_44x_need_flush@ha
+	lwz	r5,icache_44x_need_flush@l(r4)
+	cmplwi	cr0,r5,0
+	beq+	1f
+	iccci	r0,r0
+	li	r6,0
+	iccci	r0,r0
+	stw	r6,icache_44x_need_flush@l(r4)
+1:
+#endif  /* CONFIG_44x */
 	lwz	r0,GPR0(r1)
 	lwz	r2,GPR2(r1)
 	REST_4GPRS(3, r1)
Index: linux-work/arch/powerpc/mm/44x_mmu.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/44x_mmu.c	2007-09-28 11:42:05.000000000 +1000
+++ linux-work/arch/powerpc/mm/44x_mmu.c	2007-10-30 15:30:50.000000000 +1100
@@ -35,6 +35,7 @@
  */
 unsigned int tlb_44x_index; /* = 0 */
 unsigned int tlb_44x_hwater = PPC44x_TLB_SIZE - 1 - PPC44x_EARLY_TLBS;
+int icache_44x_need_flush;
 
 /*
  * "Pins" a 256MB TLB entry in AS0 for kernel lowmem
Index: linux-work/include/asm-powerpc/pgtable-ppc32.h
===================================================================
--- linux-work.orig/include/asm-powerpc/pgtable-ppc32.h	2007-09-28 11:42:10.000000000 +1000
+++ linux-work/include/asm-powerpc/pgtable-ppc32.h	2007-10-30 15:30:50.000000000 +1100
@@ -11,6 +11,11 @@
 extern unsigned long va_to_phys(unsigned long address);
 extern pte_t *va_to_pte(unsigned long address);
 extern unsigned long ioremap_bot, ioremap_base;
+
+#ifdef CONFIG_44x
+extern int icache_44x_need_flush;
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 /*
@@ -562,6 +567,10 @@ static inline unsigned long pte_update(p
 	: "=&r" (old), "=&r" (tmp), "=m" (*p)
 	: "r" (p), "r" (clr), "r" (set), "m" (*p)
 	: "cc" );
+#ifdef CONFIG_44x
+	if ((old & _PAGE_USER) && (old & _PAGE_HWEXEC))
+		icache_44x_need_flush = 1;
+#endif
 	return old;
 }
 #else
@@ -582,6 +591,10 @@ static inline unsigned long long pte_upd
 	: "=&r" (old), "=&r" (tmp), "=m" (*p)
 	: "r" (p), "r" ((unsigned long)(p) + 4), "r" (clr), "r" (set), "m" (*p)
 	: "cc" );
+#ifdef CONFIG_44x
+	if ((old & _PAGE_USER) && (old & _PAGE_HWEXEC))
+		icache_44x_need_flush = 1;
+#endif
 	return old;
 }
 #endif
Index: linux-work/arch/powerpc/kernel/misc_32.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/misc_32.S	2007-10-30 15:15:03.000000000 +1100
+++ linux-work/arch/powerpc/kernel/misc_32.S	2007-10-30 15:30:50.000000000 +1100
@@ -543,12 +543,21 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_I
 	addi	r3,r3,L1_CACHE_BYTES
 	bdnz	0b
 	sync
+#ifndef CONFIG_44x
+	/* We don't flush the icache on 44x. Those have a virtual icache
+	 * and we don't have access to the virtual address here (it's
+	 * not the page vaddr but where it's mapped in user space). The
+	 * flushing of the icache on these is handled elsewhere, when
+	 * a change in the address space occurs, before returning to
+	 * user space
+	 */
 	mtctr	r4
 1:	icbi	0,r6
 	addi	r6,r6,L1_CACHE_BYTES
 	bdnz	1b
 	sync
 	isync
+#endif /* CONFIG_44x */
 	blr
 
 /*
