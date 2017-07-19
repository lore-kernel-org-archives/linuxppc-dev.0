Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC4NF2T3szDrLr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:50:37 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 06/24] powerpc/mm: Use symbolic constants for filtering SRR1
 bits on ISIs
Date: Wed, 19 Jul 2017 14:49:28 +1000
Message-Id: <20170719044946.22030-6-benh@kernel.crashing.org>
In-Reply-To: <20170719044946.22030-1-benh@kernel.crashing.org>
References: <20170719044946.22030-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This uses the newly defined constants for this rather than open-coded
numbers. There is a side effect on 64-bit which is to pass through
some of the new P9 bits which we didn't before.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/exceptions-64s.S | 2 +-
 arch/powerpc/kernel/head_32.S        | 4 ++--
 arch/powerpc/kernel/head_8xx.S       | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 0e6aedd7066d..3e447e017da2 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -541,7 +541,7 @@ EXC_COMMON_BEGIN(instruction_access_common)
 	RECONCILE_IRQ_STATE(r10, r11)
 	ld	r12,_MSR(r1)
 	ld	r3,_NIP(r1)
-	andis.	r4,r12,0x5820
+	andis.	r4,r12,DSISR_BAD_FAULT_64S@h
 	li	r5,0x400
 	std	r3,_DAR(r1)
 	std	r4,_DSISR(r1)
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 86ad3eeadf67..463c78286b66 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -403,13 +403,13 @@ DataAccess:
 	DO_KVM  0x400
 InstructionAccess:
 	EXCEPTION_PROLOG
-	andis.	r0,r9,0x4000		/* no pte found? */
+	andis.	r0,r9,SRR1_ISI_NOPT@h	/* no pte found? */
 	beq	1f			/* if so, try to put a PTE */
 	li	r3,0			/* into the hash table */
 	mr	r4,r12			/* SRR0 is fault address */
 	bl	hash_page
 1:	mr	r4,r12
-	andis.	r5,r9,0x4820		/* Filter relevant SRR1 bits */
+	andis.	r5,r9,DSISR_SRR1_MATCH_32S@h /* Filter relevant SRR1 bits */
 	EXC_XFER_LITE(0x400, handle_page_fault)
 
 /* External interrupt */
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index da3afa2c1658..07ddced6bab3 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -569,8 +569,8 @@ _ENTRY(DTLBMiss_jmp)
 InstructionTLBError:
 	EXCEPTION_PROLOG
 	mr	r4,r12
-	andis.	r5,r9,0x4820		/* Filter relevant SRR1 bits */
-	andis.	r10,r9,0x4000
+	andis.	r5,r9,DSISR_SRR1_MATCH_32S@h /* Filter relevant SRR1 bits */
+	andis.	r10,r9,SRR1_ISI_NOPT@h
 	beq+	1f
 	tlbie	r4
 itlbie:
-- 
2.13.3
