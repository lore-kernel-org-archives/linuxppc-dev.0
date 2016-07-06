Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkntz2jj5zDqvZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 14:33:31 +1000 (AEST)
Message-ID: <1467779601.13965.99.camel@kernel.crashing.org>
Subject: [RFC/PATCH 1/4] powerpc/64/kexec: NULL check "clear_all" in
 kexec_sequence
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Anton Blanchard
 <anton@au1.ibm.com>
Date: Wed, 06 Jul 2016 14:33:21 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With Radix, it can be NULL even on !BOOKE these days so replace
the ifdef with a NULL check which is cleaner anyway.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
Currently only compile tested

 arch/powerpc/kernel/misc_64.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 5974837..5ae00fd 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -659,7 +659,9 @@ _GLOBAL(kexec_sequence)
 	li	r6,1
 	stw	r6,kexec_flag-1b(5)
 
-#ifndef CONFIG_PPC_BOOK3E
+	cmpdi	r27,0
+	beq	1f
+
 	/* clear out hardware hash page table and tlb */
 #if !defined(_CALL_ELF) || _CALL_ELF != 2
 	ld	r12,0(r27)		/* deref function descriptor */
@@ -668,7 +670,6 @@ _GLOBAL(kexec_sequence)
 #endif
 	mtctr	r12
 	bctrl				/* mmu_hash_ops.hpte_clear_all(void); */
-#endif /* !CONFIG_PPC_BOOK3E */
 
 /*
  *   kexec image calling is:
@@ -695,7 +696,7 @@ _GLOBAL(kexec_sequence)
  *    are the boot cpu ?????
  *    other device tree differences (prop sizes, va vs pa, etc)...
  */
-	mr	r3,r25	# my phys cpu
+1:	mr	r3,r25	# my phys cpu
 	mr	r4,r30	# start, aka phys mem offset
 	mtlr	4
 	li	r5,0
