Return-Path: <equinox@diac24.net>
Received: from eidolon.nox.tf (eidolon.nox.tf [IPv6:2a07:2ec0:2185::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GXK61K3CzF3NN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 09:01:13 +1000 (AEST)
Date: Fri, 21 Sep 2018 00:48:56 +0200
From: David Lamparter <equinox@diac24.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <swood@redhat.com>
Subject: [PATCH ppc-next] powerpc/fsl-booke: don't load early TLB at once
Message-ID: <20180920224856.GJ487685@eidolon.nox.tf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a *partial* revert of "powerpc/85xx: Load all early TLB entries
at once" (d9e1831a420267a7ced708bb259d65b0a3c0344d.)

My dusty old P4080DS just completely fails to boot (no output at all)
without this revert.  I have no clue what's going on here, I just
bisected it down and since it looks like an optimization to me I just
reverted it - and voilá, the P4080 boots again.

Cc: Scott Wood <swood@redhat.com>
Signed-off-by: David Lamparter <equinox@diac24.net>
---
I'm not subscribed to linuxppc-dev, please keep me in Cc:.  Also I
contribute to the kernel only very rarely and have no clue how to find
out when the appropriate time in the merge window is to submit things to
linuxppc-dev... my apologies.
---
 arch/powerpc/mm/fsl_booke_mmu.c  |  3 +-
 arch/powerpc/mm/mmu_decl.h       |  1 -
 arch/powerpc/mm/tlb_nohash_low.S | 63 --------------------------------
 3 files changed, 2 insertions(+), 65 deletions(-)

diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 080d49b26c3a..f301a4c32c66 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -143,6 +143,8 @@ static void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 	tlbcam_addrs[index].start = virt;
 	tlbcam_addrs[index].limit = virt + size - 1;
 	tlbcam_addrs[index].phys = phys;
+
+	loadcam_entry(index);
 }
 
 unsigned long calc_cam_sz(unsigned long ram, unsigned long virt,
@@ -195,7 +197,6 @@ static unsigned long map_mem_in_cams_addr(phys_addr_t phys, unsigned long virt,
 	if (dryrun)
 		return amount_mapped;
 
-	loadcam_multi(0, i, max_cam_idx);
 	tlbcam_index = i;
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index e5d779eed181..9a14de6a3ca9 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -140,7 +140,6 @@ extern int switch_to_as1(void);
 extern void restore_to_as0(int esel, int offset, void *dt_ptr, int bootcpu);
 #endif
 extern void loadcam_entry(unsigned int index);
-extern void loadcam_multi(int first_idx, int num, int tmp_idx);
 
 struct tlbcam {
 	u32	MAS0;
diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/tlb_nohash_low.S
index e066a658acac..b5fa6c6a940f 100644
--- a/arch/powerpc/mm/tlb_nohash_low.S
+++ b/arch/powerpc/mm/tlb_nohash_low.S
@@ -402,7 +402,6 @@ _GLOBAL(set_context)
  * extern void loadcam_entry(unsigned int index)
  *
  * Load TLBCAM[index] entry in to the L2 CAM MMU
- * Must preserve r7, r8, r9, and r10
  */
 _GLOBAL(loadcam_entry)
 	mflr	r5
@@ -426,66 +425,4 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_BIG_PHYS)
 	tlbwe
 	isync
 	blr
-
-/*
- * Load multiple TLB entries at once, using an alternate-space
- * trampoline so that we don't have to care about whether the same
- * TLB entry maps us before and after.
- *
- * r3 = first entry to write
- * r4 = number of entries to write
- * r5 = temporary tlb entry
- */
-_GLOBAL(loadcam_multi)
-	mflr	r8
-
-	/*
-	 * Set up temporary TLB entry that is the same as what we're
-	 * running from, but in AS=1.
-	 */
-	bl	1f
-1:	mflr	r6
-	tlbsx	0,r8
-	mfspr	r6,SPRN_MAS1
-	ori	r6,r6,MAS1_TS
-	mtspr	SPRN_MAS1,r6
-	mfspr	r6,SPRN_MAS0
-	rlwimi	r6,r5,MAS0_ESEL_SHIFT,MAS0_ESEL_MASK
-	mr	r7,r5
-	mtspr	SPRN_MAS0,r6
-	isync
-	tlbwe
-	isync
-
-	/* Switch to AS=1 */
-	mfmsr	r6
-	ori	r6,r6,MSR_IS|MSR_DS
-	mtmsr	r6
-	isync
-
-	mr	r9,r3
-	add	r10,r3,r4
-2:	bl	loadcam_entry
-	addi	r9,r9,1
-	cmpw	r9,r10
-	mr	r3,r9
-	blt	2b
-
-	/* Return to AS=0 and clear the temporary entry */
-	mfmsr	r6
-	rlwinm.	r6,r6,0,~(MSR_IS|MSR_DS)
-	mtmsr	r6
-	isync
-
-	li	r6,0
-	mtspr	SPRN_MAS1,r6
-	rlwinm	r6,r7,MAS0_ESEL_SHIFT,MAS0_ESEL_MASK
-	oris	r6,r6,MAS0_TLBSEL(1)@h
-	mtspr	SPRN_MAS0,r6
-	isync
-	tlbwe
-	isync
-
-	mtlr	r8
-	blr
 #endif
-- 
2.18.0
