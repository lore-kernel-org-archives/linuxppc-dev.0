Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 93DD52C0327
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 22:54:54 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2 1/8] powerpc/fsl_booke: protect the access to MAS7 with
 MMU_FTR_BIG_PHYS
Date: Thu, 4 Jul 2013 20:54:07 +0800
Message-ID: <1372942454-25191-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
References: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The e500v1 doesn't implement the MAS7, so we should avoid to access
this register on that implementations. Some code use the
CONFIG_PHYS_64BIT to protect these accesses, but this is not accurate.
In theory we can enable the CONFIG_PHYS_64BIT for a e500v1 board and
the CONFIG_PHYS_64BIT is also enabled by default in mpc85xx_defconfig
which definitely have the support for e500v1 board. The MMU_FTR_BIG_PHYS
should be the right choice.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
A new patch in v2.

 arch/powerpc/kernel/entry_32.S                | 8 +++++---
 arch/powerpc/kernel/fsl_booke_entry_mapping.S | 6 ++++--
 arch/powerpc/kernel/head_fsl_booke.S          | 4 ++++
 arch/powerpc/mm/hugetlbpage-book3e.c          | 3 ++-
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 22b45a4..2ce22c2 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -75,10 +75,10 @@ crit_transfer_to_handler:
 	stw	r0,MAS3(r11)
 	mfspr	r0,SPRN_MAS6
 	stw	r0,MAS6(r11)
-#ifdef CONFIG_PHYS_64BIT
+BEGIN_MMU_FTR_SECTION
 	mfspr	r0,SPRN_MAS7
 	stw	r0,MAS7(r11)
-#endif /* CONFIG_PHYS_64BIT */
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_BIG_PHYS)
 #endif /* CONFIG_PPC_BOOK3E_MMU */
 #ifdef CONFIG_44x
 	mfspr	r0,SPRN_MMUCR
@@ -1112,8 +1112,10 @@ exc_exit_restart_end:
 #if defined(CONFIG_PPC_BOOK3E_MMU)
 #ifdef CONFIG_PHYS_64BIT
 #define	RESTORE_MAS7							\
+BEGIN_MMU_FTR_SECTION							\
 	lwz	r11,MAS7(r1);						\
-	mtspr	SPRN_MAS7,r11;
+	mtspr	SPRN_MAS7,r11;						\
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_BIG_PHYS)
 #else
 #define	RESTORE_MAS7
 #endif /* CONFIG_PHYS_64BIT */
diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
index a92c79b..2201f84 100644
--- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
+++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
@@ -88,9 +88,11 @@ skpinv:	addi	r6,r6,1				/* Increment */
 1:	mflr	r7
 
 	mfspr	r8,SPRN_MAS3
-#ifdef CONFIG_PHYS_64BIT
+BEGIN_MMU_FTR_SECTION
 	mfspr	r23,SPRN_MAS7
-#endif
+MMU_FTR_SECTION_ELSE
+	li	r23,0
+ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_BIG_PHYS)
 	and	r8,r6,r8
 	subfic	r9,r6,-4096
 	and	r9,r9,r7
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index d10a7ca..a04a48d 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -82,7 +82,11 @@ _ENTRY(_start);
 	and	r19,r3,r18		/* r19 = page offset */
 	andc	r31,r20,r18		/* r31 = page base */
 	or	r31,r31,r19		/* r31 = devtree phys addr */
+BEGIN_MMU_FTR_SECTION
 	mfspr	r30,SPRN_MAS7
+MMU_FTR_SECTION_ELSE
+	li	r30,0
+ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_BIG_PHYS)
 
 	li	r25,0			/* phys kernel start (low) */
 	li	r24,0			/* CPU number */
diff --git a/arch/powerpc/mm/hugetlbpage-book3e.c b/arch/powerpc/mm/hugetlbpage-book3e.c
index 3bc7006..ac63e7e 100644
--- a/arch/powerpc/mm/hugetlbpage-book3e.c
+++ b/arch/powerpc/mm/hugetlbpage-book3e.c
@@ -103,7 +103,8 @@ void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
 	if (mmu_has_feature(MMU_FTR_USE_PAIRED_MAS)) {
 		mtspr(SPRN_MAS7_MAS3, mas7_3);
 	} else {
-		mtspr(SPRN_MAS7, upper_32_bits(mas7_3));
+		if (mmu_has_feature(MMU_FTR_BIG_PHYS))
+			mtspr(SPRN_MAS7, upper_32_bits(mas7_3));
 		mtspr(SPRN_MAS3, lower_32_bits(mas7_3));
 	}
 
-- 
1.8.1.4
