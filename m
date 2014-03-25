Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 09/33] powerpc: ABIv2 function calls must place target address
 in r12
Date: Tue, 25 Mar 2014 22:44:15 +1100
Message-Id: <1395747879-5948-10-git-send-email-anton@samba.org>
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

To establish addressability quickly, ABIv2 requires the target
address of the function being called to be in r12. Fix a number of
places in assembly code that we do indirect function calls.

We need to avoid function descriptors on ABIv2 too.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/entry_64.S |  4 ++--
 arch/powerpc/kernel/head_64.S  | 20 +++++++++++---------
 arch/powerpc/kernel/misc_64.S  |  8 ++++++--
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2662f02..d23d752 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -174,8 +174,8 @@ system_call:			/* label this so stack traces look sane */
 	clrldi	r8,r8,32
 15:
 	slwi	r0,r0,4
-	ldx	r10,r11,r0	/* Fetch system call handler [ptr] */
-	mtctr   r10
+	ldx	r12,r11,r0	/* Fetch system call handler [ptr] */
+	mtctr   r12
 	bctrl			/* Call handler */
 
 syscall_exit:
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 8284124..97329a1 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -140,16 +140,18 @@ __secondary_hold:
 	tovirt(r26,r26)
 #endif
 	/* All secondary cpus wait here until told to start. */
-100:	ld	r4,__secondary_hold_spinloop-_stext(r26)
-	cmpdi	0,r4,0
+100:	ld	r12,__secondary_hold_spinloop-_stext(r26)
+	cmpdi	0,r12,0
 	beq	100b
 
 #if defined(CONFIG_SMP) || defined(CONFIG_KEXEC)
 #ifdef CONFIG_PPC_BOOK3E
-	tovirt(r4,r4)
+	tovirt(r12,r12)
 #endif
-	ld	r4,0(r4)		/* deref function descriptor */
-	mtctr	r4
+#if !defined(_CALL_ELF) || _CALL_ELF != 2
+	ld	r12,0(r12)		/* deref function descriptor */
+#endif
+	mtctr	r12
 	mr	r3,r24
 	/*
 	 * it may be the case that other platforms have r4 right to
@@ -267,8 +269,8 @@ generic_secondary_common_init:
 	ld	r23,CPU_SPEC_RESTORE(r23)
 	cmpdi	0,r23,0
 	beq	3f
-	ld	r23,0(r23)
-	mtctr	r23
+	ld	r12,0(r23)
+	mtctr	r12
 	bctrl
 
 3:	LOAD_REG_ADDR(r3, spinning_secondaries) /* Decrement spinning_secondaries */
@@ -468,8 +470,8 @@ __after_prom_start:
 					/* this includes the code being	 */
 					/* executed here.		 */
 	addis	r8,r3,(4f - _stext)@ha	/* Jump to the copy of this code */
-	addi	r8,r8,(4f - _stext)@l	/* that we just made */
-	mtctr	r8
+	addi	r12,r8,(4f - _stext)@l	/* that we just made */
+	mtctr	r12
 	bctr
 
 .balign 8
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index b39cf4a..bda85a1 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -595,8 +595,12 @@ _GLOBAL(kexec_sequence)
 	stw	r6,kexec_flag-1b(5)
 
 	/* clear out hardware hash page table and tlb */
-	ld	r5,0(r27)		/* deref function descriptor */
-	mtctr	r5
+#if !defined(_CALL_ELF) || _CALL_ELF != 2
+	ld	r12,0(r27)		/* deref function descriptor */
+#else
+	mr	r12,r27
+#endif
+	mtctr	r12
 	bctrl				/* ppc_md.hpte_clear_all(void); */
 
 /*
-- 
1.8.3.2
