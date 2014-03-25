Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 04/33] powerpc: Remove some unnecessary uses of _GLOBAL() and
 _STATIC()
Date: Tue, 25 Mar 2014 22:44:10 +1100
Message-Id: <1395747879-5948-5-git-send-email-anton@samba.org>
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

There is no need to create a function descriptor for functions
called locally out of assembly.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/exceptions-64e.S |  4 ++--
 arch/powerpc/kernel/exceptions-64s.S |  2 +-
 arch/powerpc/kernel/head_64.S        | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 5e37338..c8ac8a0 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -1596,14 +1596,14 @@ _GLOBAL(book3e_secondary_thread_init)
 	mflr	r28
 	b	3b
 
-_STATIC(init_core_book3e)
+init_core_book3e:
 	/* Establish the interrupt vector base */
 	LOAD_REG_IMMEDIATE(r3, interrupt_base_book3e)
 	mtspr	SPRN_IVPR,r3
 	sync
 	blr
 
-_STATIC(init_thread_book3e)
+init_thread_book3e:
 	lis	r3,(SPRN_EPCR_ICM | SPRN_EPCR_GICM)@h
 	mtspr	SPRN_EPCR,r3
 
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 7e87b64..a695a23 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1538,7 +1538,7 @@ power4_fixup_nap:
  * Hash table stuff
  */
 	.align	7
-_STATIC(do_hash_page)
+do_hash_page:
 	std	r3,_DAR(r1)
 	std	r4,_DSISR(r1)
 
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 8d7c868..8284124 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -299,7 +299,7 @@ generic_secondary_common_init:
  * Assumes we're mapped EA == RA if the MMU is on.
  */
 #ifdef CONFIG_PPC_BOOK3S
-_STATIC(__mmu_off)
+__mmu_off:
 	mfmsr	r3
 	andi.	r0,r3,MSR_IR|MSR_DR
 	beqlr
@@ -324,7 +324,7 @@ _STATIC(__mmu_off)
  *                 DT block, r4 is a physical pointer to the kernel itself
  *
  */
-_GLOBAL(__start_initialization_multiplatform)
+__start_initialization_multiplatform:
 	/* Make sure we are running in 64 bits mode */
 	bl	enable_64b_mode
 
@@ -376,7 +376,7 @@ _GLOBAL(__start_initialization_multiplatform)
 	b	__after_prom_start
 #endif /* CONFIG_PPC_BOOK3E */
 
-_INIT_STATIC(__boot_from_prom)
+__boot_from_prom:
 #ifdef CONFIG_PPC_OF_BOOT_TRAMPOLINE
 	/* Save parameters */
 	mr	r31,r3
@@ -414,7 +414,7 @@ _INIT_STATIC(__boot_from_prom)
 	 * from OF while CONFIG_PPC_OF_BOOT_TRAMPOLINE isn't selected */
 	trap
 
-_STATIC(__after_prom_start)
+__after_prom_start:
 #ifdef CONFIG_RELOCATABLE
 	/* process relocations for the final address of the kernel */
 	lis	r25,PAGE_OFFSET@highest	/* compute virtual base of kernel */
@@ -674,7 +674,7 @@ _GLOBAL(start_secondary_resume)
 /*
  * This subroutine clobbers r11 and r12
  */
-_GLOBAL(enable_64b_mode)
+enable_64b_mode:
 	mfmsr	r11			/* grab the current MSR */
 #ifdef CONFIG_PPC_BOOK3E
 	oris	r11,r11,0x8000		/* CM bit set, we'll set ICM later */
@@ -715,7 +715,7 @@ p_toc:	.llong	__toc_start + 0x8000 - 0b
 /*
  * This is where the main kernel code starts.
  */
-_INIT_STATIC(start_here_multiplatform)
+start_here_multiplatform:
 	/* set up the TOC */
 	bl      relative_toc
 	tovirt(r2,r2)
-- 
1.8.3.2
