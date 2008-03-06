Return-Path: <vitb@kernel.crashing.org>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 16813DDF0D
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 22:47:59 +1100 (EST)
Date: Thu, 6 Mar 2008 13:53:30 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [POWERPC] 8xx: fix swap
Message-ID: <20080306135330.6d5462d2@vitb.ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This makes swap routines operate correctly on the ppc_8xx based machines.
Code has been revalidated on mpc885ads (8M sdram) with recent kernel. Based
on patch from Yuri Tikhonov <yur@emcraft.com> to do the same on arch/ppc
instance.

Recent kernel's size makes swap feature very important on low-memory platforms,
those are actually non-operable without it.

Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
---

 arch/powerpc/kernel/head_8xx.S      |   30 +++++++++++++++++++++++++++++-
 include/asm-powerpc/pgtable-ppc32.h |    8 --------
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index f745839..3c9452d 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -332,8 +332,18 @@ InstructionTLBMiss:
 	mfspr	r11, SPRN_MD_TWC	/* ....and get the pte address */
 	lwz	r10, 0(r11)	/* Get the pte */
 
+#ifdef CONFIG_SWAP
+	/* do not set the _PAGE_ACCESSED bit of a non-present page */
+	andi.	r11, r10, _PAGE_PRESENT
+	beq	4f
+	ori	r10, r10, _PAGE_ACCESSED
+	mfspr	r11, SPRN_MD_TWC	/* get the pte address again */
+	stw	r10, 0(r11)
+4:
+#else
 	ori	r10, r10, _PAGE_ACCESSED
 	stw	r10, 0(r11)
+#endif
 
 	/* The Linux PTE won't go exactly into the MMU TLB.
 	 * Software indicator bits 21, 22 and 28 must be clear.
@@ -398,8 +408,17 @@ DataStoreTLBMiss:
 	DO_8xx_CPU6(0x3b80, r3)
 	mtspr	SPRN_MD_TWC, r11
 
-	mfspr	r11, SPRN_MD_TWC	/* get the pte address again */
+#ifdef CONFIG_SWAP
+	/* do not set the _PAGE_ACCESSED bit of a non-present page */
+	andi.	r11, r10, _PAGE_PRESENT
+	beq	4f
 	ori	r10, r10, _PAGE_ACCESSED
+4:
+	/* and update pte in table */
+#else
+	ori	r10, r10, _PAGE_ACCESSED
+#endif
+	mfspr	r11, SPRN_MD_TWC	/* get the pte address again */
 	stw	r10, 0(r11)
 
 	/* The Linux PTE won't go exactly into the MMU TLB.
@@ -507,7 +526,16 @@ DataTLBError:
 
 	/* Update 'changed', among others.
 	*/
+#ifdef CONFIG_SWAP
+	ori	r10, r10, _PAGE_DIRTY|_PAGE_HWWRITE
+	/* do not set the _PAGE_ACCESSED bit of a non-present page */
+	andi.	r11, r10, _PAGE_PRESENT
+	beq	4f
+	ori	r10, r10, _PAGE_ACCESSED
+4:
+#else
 	ori	r10, r10, _PAGE_DIRTY|_PAGE_ACCESSED|_PAGE_HWWRITE
+#endif
 	mfspr	r11, SPRN_MD_TWC		/* Get pte address again */
 	stw	r10, 0(r11)		/* and update pte in table */
 
diff --git a/include/asm-powerpc/pgtable-ppc32.h b/include/asm-powerpc/pgtable-ppc32.h
index d1332bb..2c79f55 100644
--- a/include/asm-powerpc/pgtable-ppc32.h
+++ b/include/asm-powerpc/pgtable-ppc32.h
@@ -339,14 +339,6 @@ extern int icache_44x_need_flush;
 #define _PMD_PAGE_MASK	0x000c
 #define _PMD_PAGE_8M	0x000c
 
-/*
- * The 8xx TLB miss handler allegedly sets _PAGE_ACCESSED in the PTE
- * for an address even if _PAGE_PRESENT is not set, as a performance
- * optimization.  This is a bug if you ever want to use swap unless
- * _PAGE_ACCESSED is 2, which it isn't, or unless you have 8xx-specific
- * definitions for __swp_entry etc. below, which would be gross.
- *  -- paulus
- */
 #define _PTE_NONE_MASK _PAGE_ACCESSED
 
 #else /* CONFIG_6xx */


-- 
Sincerely, 
Vitaly
