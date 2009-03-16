Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D892FDDF26
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 08:21:22 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n2GLLIcc003186
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 16:21:19 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: 
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 1/4] powerpc/mm: Respect _PAGE_COHERENT on classic ppc32 SW
	TLB load machines
Date: Mon, 16 Mar 2009 16:21:15 -0500
Message-Id: <1237238478-30493-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since we now set _PAGE_COHERENT in the Linux PTE we shouldn't be clearing
it out before we setup the SW TLB.  Today all the SW TLB machines
(603/e300) that we support are non-SMP, however there are some errata on
some devices that cause us to set _PAGE_COHERENT via CPU_FTR_NEED_COHERENT.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

* We need to respect how CPU_FTR_NEED_COHERENT is set

 arch/powerpc/kernel/head_32.S |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index f8c2e6b..d0bad4b 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -514,8 +514,11 @@ InstructionTLBMiss:
 	and	r1,r1,r2		/* writable if _RW and _DIRTY */
 	rlwimi	r3,r3,32-1,30,30	/* _PAGE_USER -> PP msb */
 	rlwimi	r3,r3,32-1,31,31	/* _PAGE_USER -> PP lsb */
-	ori	r1,r1,0xe14		/* clear out reserved bits and M */
+	ori	r1,r1,0xe04		/* clear out reserved bits */
 	andc	r1,r3,r1		/* PP = user? (rw&dirty? 2: 3): 0 */
+BEGIN_FTR_SECTION
+	rlwinm	r1,r1,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
+END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	mtspr	SPRN_RPA,r1
 	mfspr	r3,SPRN_IMISS
 	tlbli	r3
@@ -588,8 +591,11 @@ DataLoadTLBMiss:
 	and	r1,r1,r2		/* writable if _RW and _DIRTY */
 	rlwimi	r3,r3,32-1,30,30	/* _PAGE_USER -> PP msb */
 	rlwimi	r3,r3,32-1,31,31	/* _PAGE_USER -> PP lsb */
-	ori	r1,r1,0xe14		/* clear out reserved bits and M */
+	ori	r1,r1,0xe04		/* clear out reserved bits */
 	andc	r1,r3,r1		/* PP = user? (rw&dirty? 2: 3): 0 */
+BEGIN_FTR_SECTION
+	rlwinm	r1,r1,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
+END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	mtspr	SPRN_RPA,r1
 	mfspr	r3,SPRN_DMISS
 	tlbld	r3
@@ -656,8 +662,11 @@ DataStoreTLBMiss:
 	stw	r3,0(r2)		/* update PTE (accessed/dirty bits) */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
 	rlwimi	r3,r3,32-1,30,30	/* _PAGE_USER -> PP msb */
-	li	r1,0xe15		/* clear out reserved bits and M */
+	li	r1,0xe05		/* clear out reserved bits & PP lsb */
 	andc	r1,r3,r1		/* PP = user? 2: 0 */
+BEGIN_FTR_SECTION
+	rlwinm	r1,r1,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
+END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	mtspr	SPRN_RPA,r1
 	mfspr	r3,SPRN_DMISS
 	tlbld	r3
-- 
1.5.6.6
