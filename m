Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3787DDDF0C
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 00:46:21 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: 
Subject: [PATCH] powerpc/mm: Fix Respect _PAGE_COHERENT on classic ppc32 SW
	TLB load machines
Date: Mon, 23 Mar 2009 08:46:14 -0500
Message-Id: <1237815974-21282-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant picked up the wrong version of "Respect _PAGE_COHERENT on classic
ppc32 SW" (commit a4bd6a93c3f14691c8a29e53eb04dc734b27f0db)

It was missing the code to actually deal with the fixup of
_PAGE_COHERENT based on the CPU feature.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/head_32.S |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 7db2e42..d794a63 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -513,6 +513,9 @@ InstructionTLBMiss:
 	rlwimi	r3,r3,32-1,31,31	/* _PAGE_USER -> PP lsb */
 	ori	r1,r1,0xe04		/* clear out reserved bits */
 	andc	r1,r3,r1		/* PP = user? (rw&dirty? 2: 3): 0 */
+BEGIN_FTR_SECTION
+	rlwinm	r1,r1,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
+END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	mtspr	SPRN_RPA,r1
 	mfspr	r3,SPRN_IMISS
 	tlbli	r3
@@ -587,6 +590,9 @@ DataLoadTLBMiss:
 	rlwimi	r3,r3,32-1,31,31	/* _PAGE_USER -> PP lsb */
 	ori	r1,r1,0xe04		/* clear out reserved bits */
 	andc	r1,r3,r1		/* PP = user? (rw&dirty? 2: 3): 0 */
+BEGIN_FTR_SECTION
+	rlwinm	r1,r1,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
+END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	mtspr	SPRN_RPA,r1
 	mfspr	r3,SPRN_DMISS
 	tlbld	r3
@@ -655,6 +661,9 @@ DataStoreTLBMiss:
 	rlwimi	r3,r3,32-1,30,30	/* _PAGE_USER -> PP msb */
 	li	r1,0xe05		/* clear out reserved bits & PP lsb */
 	andc	r1,r3,r1		/* PP = user? 2: 0 */
+BEGIN_FTR_SECTION
+	rlwinm	r1,r1,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
+END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	mtspr	SPRN_RPA,r1
 	mfspr	r3,SPRN_DMISS
 	tlbld	r3
-- 
1.5.6.6
