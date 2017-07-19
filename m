Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC4N120QnzDrLj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:50:25 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 05/24] powerpc/mm: Update bits used to skip hash_page
Date: Wed, 19 Jul 2017 14:49:27 +1000
Message-Id: <20170719044946.22030-5-benh@kernel.crashing.org>
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

We test a number of bits from DSISR/SRR1 before deciding
to call hash_page(). If any of these is set, we go directly
to do_page_fault() as the bit indicate a fault that needs
to be handled there (no hashing needed).

This updates the current open-coded masks to use the new
DSISR definitions.

This *does* change the masks actually used in two ways:

 - We used to test various bits that were defined as "always 0"
in the architecture and could be repurposed for something
else. From now on, we just ignore such bits.

 - We were missing some new bits defined on P9

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/exceptions-64s.S | 6 ++++--
 arch/powerpc/kernel/head_32.S        | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index e6d8354d79ef..0e6aedd7066d 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1477,8 +1477,10 @@ USE_TEXT_SECTION()
  */
 	.balign	IFETCH_ALIGN_BYTES
 do_hash_page:
-#ifdef CONFIG_PPC_STD_MMU_64
-	andis.	r0,r4,0xa450		/* weird error? */
+	#ifdef CONFIG_PPC_STD_MMU_64
+	lis	r0,DSISR_BAD_FAULT_64S@h
+	ori	r0,r0,DSISR_BAD_FAULT_64S@l
+	and.	r0,r4,r0		/* weird error? */
 	bne-	handle_page_fault	/* if not, try to insert a HPTE */
 	CURRENT_THREAD_INFO(r11, r1)
 	lwz	r0,TI_PREEMPT(r11)	/* If we're in an "NMI" */
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index f11d1cd6e314..86ad3eeadf67 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -388,7 +388,7 @@ DataAccess:
 	EXCEPTION_PROLOG
 	mfspr	r10,SPRN_DSISR
 	stw	r10,_DSISR(r11)
-	andis.	r0,r10,0xa470		/* weird error? */
+	andis.	r0,r10,DSISR_BAD_FAULT_32S@h
 	bne	1f			/* if not, try to put a PTE */
 	mfspr	r4,SPRN_DAR		/* into the hash table */
 	rlwinm	r3,r10,32-15,21,21	/* DSISR_STORE -> _PAGE_RW */
-- 
2.13.3
