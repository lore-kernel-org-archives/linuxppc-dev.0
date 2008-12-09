Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3F9C6DDEE8
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 14:35:04 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	mB93Z0wZ012041
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Dec 2008 20:35:00 -0700 (MST)
From: Trent Piepho <tpiepho@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] powerpc: booke: Don't hard-code size of struct tlbcam
Date: Mon,  8 Dec 2008 19:34:55 -0800
Message-Id: <1228793699-23110-1-git-send-email-tpiepho@freescale.com>
Cc: Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some assembly code in head_fsl_booke.S hard-coded the size of struct tlbcam
to 20 when it indexed the TLBCAM table.  Anyone changing the size of struct
tlbcam would not know to expect that.

The kernel already has a system to get the size of C structures into
assembly language files, asm-offsets, so let's use it.

The definition of the struct gets moved to a header, so that asm-offsets.c
can include it.

Signed-off-by: Trent Piepho <tpiepho@freescale.com>
---
 arch/powerpc/kernel/asm-offsets.c    |    8 ++++++++
 arch/powerpc/kernel/head_fsl_booke.S |    2 +-
 arch/powerpc/mm/fsl_booke_mmu.c      |    8 +-------
 arch/powerpc/mm/mmu_decl.h           |    9 +++++++++
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 050abfd..4d62a8d 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -56,6 +56,10 @@
 #include "head_booke.h"
 #endif
 
+#if defined(CONFIG_FSL_BOOKE)
+#include "../mm/mmu_decl.h"
+#endif
+
 int main(void)
 {
 	DEFINE(THREAD, offsetof(struct task_struct, thread));
@@ -271,6 +275,10 @@ int main(void)
 	DEFINE(SAVED_KSP_LIMIT, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, saved_ksp_limit));
 #endif
 
+#ifdef CONFIG_FSL_BOOKE
+	DEFINE(TLBCAM_SIZE, sizeof(struct tlbcam));
+#endif
+
 	DEFINE(CLONE_VM, CLONE_VM);
 	DEFINE(CLONE_UNTRACED, CLONE_UNTRACED);
 
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 9a4639c..c591acb 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -909,7 +909,7 @@ KernelSPE:
 _GLOBAL(loadcam_entry)
 	lis	r4,TLBCAM@ha
 	addi	r4,r4,TLBCAM@l
-	mulli	r5,r3,20
+	mulli	r5,r3,TLBCAM_SIZE
 	add	r3,r5,r4
 	lwz	r4,0(r3)
 	mtspr	SPRN_MAS0,r4
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 23cee39..c9ee59a 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -61,13 +61,7 @@ static unsigned long __cam0, __cam1, __cam2;
 
 #define NUM_TLBCAMS	(16)
 
-struct tlbcam {
-   	u32	MAS0;
-	u32	MAS1;
-	u32	MAS2;
-	u32	MAS3;
-	u32	MAS7;
-} TLBCAM[NUM_TLBCAMS];
+struct tlbcam TLBCAM[NUM_TLBCAMS];
 
 struct tlbcamrange {
    	unsigned long start;
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index fab3cfa..f0d0aae 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -27,6 +27,15 @@ extern void hash_preload(struct mm_struct *mm, unsigned long ea,
 
 
 #ifdef CONFIG_PPC32
+
+struct tlbcam {
+	u32	MAS0;
+	u32	MAS1;
+	u32	MAS2;
+	u32	MAS3;
+	u32	MAS7;
+};
+
 extern void mapin_ram(void);
 extern int map_page(unsigned long va, phys_addr_t pa, int flags);
 extern void setbat(int index, unsigned long virt, phys_addr_t phys,
-- 
1.5.4.1
