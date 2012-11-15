Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 466A52C035D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 20:40:11 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH 3/6] book3e/kexec/kdump: create a 1:1 TLB mapping
Date: Thu, 15 Nov 2012 17:39:53 +0800
Message-ID: <1352972396-13489-4-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1352972396-13489-1-git-send-email-tiejun.chen@windriver.com>
References: <1352972396-13489-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

book3e have no real MMU mode so we have to create a 1:1 TLB
mapping to make sure we can access the real physical address.
And correct something to support this pseudo real mode on book3e.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kernel/head_64.S |    9 ++++---
 arch/powerpc/kernel/misc_64.S |   55 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index aa7df52..d51ffc0 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -425,12 +425,12 @@ _STATIC(__after_prom_start)
 	tovirt(r3,r3)			/* on booke, we already run at PAGE_OFFSET */
 #endif
 	mr.	r4,r26			/* In some cases the loader may  */
+#if defined(CONFIG_PPC_BOOK3E)
+	tovirt(r4,r4)
+#endif
 	beq	9f			/* have already put us at zero */
 	li	r6,0x100		/* Start offset, the first 0x100 */
 					/* bytes were copied earlier.	 */
-#ifdef CONFIG_PPC_BOOK3E
-	tovirt(r6,r6)			/* on booke, we already run at PAGE_OFFSET */
-#endif
 
 #ifdef CONFIG_RELOCATABLE
 /*
@@ -472,6 +472,9 @@ _STATIC(__after_prom_start)
 p_end:	.llong	_end - _stext
 
 4:	/* Now copy the rest of the kernel up to _end */
+#if defined(CONFIG_PPC_BOOK3E)
+	tovirt(r26,r26)
+#endif
 	addis	r5,r26,(p_end - _stext)@ha
 	ld	r5,(p_end - _stext)@l(r5)	/* get _end */
 5:	bl	.copy_and_flush		/* copy the rest */
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index c2acf8c..ffe6043 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -449,6 +449,49 @@ kexec_flag:
 
 
 #ifdef CONFIG_KEXEC
+#ifdef CONFIG_PPC_BOOK3E
+/* BOOK3E have no a real MMU mode so we have to setup the initial TLB
+ * for a core to map v:0 to p:0 as 1:1. This current implementation
+ * assume that 1G is enough for kexec.
+ */
+#include <asm/mmu.h>
+kexec_create_tlb:
+	/* Invalidate all TLBs to avoid any TLB conflict. */
+	PPC_TLBILX_ALL(0,R0)
+	sync
+	isync
+
+	mfspr	r10,SPRN_TLB1CFG
+	andi.	r10,r10,TLBnCFG_N_ENTRY	/* Extract # entries */
+	subi	r10,r10,1		/* Often its always safe to use last */
+	lis	r9,MAS0_TLBSEL(1)@h
+	rlwimi	r9,r10,16,4,15		/* Setup MAS0 = TLBSEL | ESEL(r9) */
+
+/* Setup a temp mapping v:0 to p:0 as 1:1 and return to it.
+ */
+#ifdef CONFIG_SMP
+#define M_IF_SMP	MAS2_M
+#else
+#define M_IF_SMP	0
+#endif
+	mtspr	SPRN_MAS0,r9
+
+	lis	r9,(MAS1_VALID|MAS1_IPROT)@h
+	ori	r9,r9,(MAS1_TSIZE(BOOK3E_PAGESZ_1GB))@l
+	mtspr	SPRN_MAS1,r9
+
+	LOAD_REG_IMMEDIATE(r9, 0x0 | M_IF_SMP)
+	mtspr	SPRN_MAS2,r9
+
+	LOAD_REG_IMMEDIATE(r9, 0x0 | MAS3_SR | MAS3_SW | MAS3_SX)
+	mtspr	SPRN_MAS3,r9
+	li	r9,0
+	mtspr	SPRN_MAS7,r9
+
+	tlbwe
+	isync
+	blr
+#endif
 
 /* kexec_smp_wait(void)
  *
@@ -462,6 +505,10 @@ kexec_flag:
  */
 _GLOBAL(kexec_smp_wait)
 	lhz	r3,PACAHWCPUID(r13)
+#ifdef CONFIG_PPC_BOOK3E
+	/* Create a 1:1 mapping. */
+	bl	kexec_create_tlb
+#endif
 	bl	real_mode
 
 	li	r4,KEXEC_STATE_REAL_MODE
@@ -478,6 +525,7 @@ _GLOBAL(kexec_smp_wait)
  * don't overwrite r3 here, it is live for kexec_wait above.
  */
 real_mode:	/* assume normal blr return */
+#ifndef CONFIG_PPC_BOOK3E
 1:	li	r9,MSR_RI
 	li	r10,MSR_DR|MSR_IR
 	mflr	r11		/* return address to SRR0 */
@@ -489,7 +537,10 @@ real_mode:	/* assume normal blr return */
 	mtspr	SPRN_SRR1,r10
 	mtspr	SPRN_SRR0,r11
 	rfid
-
+#else
+	/* the real mode is nothing for book3e. */
+	blr
+#endif
 
 /*
  * kexec_sequence(newstack, start, image, control, clear_all())
@@ -538,6 +589,8 @@ _GLOBAL(kexec_sequence)
 	mtmsrd	r3,1
 #else
 	wrteei	0
+	/* Create a 1:1 mapping. */
+	bl	kexec_create_tlb
 #endif
 
 	/* copy dest pages, flush whole dest image */
-- 
1.7.9.5
