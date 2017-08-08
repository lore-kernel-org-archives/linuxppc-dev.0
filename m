Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRXxQ4fcRzDqp9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 21:59:06 +1000 (AEST)
Message-Id: <66f1ce3afcc79a8828ada3cebec8f6278b874ab2.1502191399.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1502191399.git.christophe.leroy@c-s.fr>
References: <cover.1502191399.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 12/12] powerpc/8xx: Remove cpu dependent macro instructions
 from head_8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue,  8 Aug 2017 13:59:02 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

head_8xx is dedicated to 8xx so no need to use macros that
depends on the CPU

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index a1c2a2cfec7e..471936704261 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -123,7 +123,6 @@ turn_on_mmu:
 	lis	r0,start_here@h
 	ori	r0,r0,start_here@l
 	mtspr	SPRN_SRR0,r0
-	SYNC
 	rfi				/* enables MMU */
 
 /*
@@ -170,7 +169,7 @@ turn_on_mmu:
 	stw	r1,0(r11);	\
 	tovirt(r1,r11);			/* set new kernel sp */	\
 	li	r10,MSR_KERNEL & ~(MSR_IR|MSR_DR); /* can take exceptions */ \
-	MTMSRD(r10);			/* (except for mach check in rtas) */ \
+	mtmsr	r10;		\
 	stw	r0,GPR0(r11);	\
 	SAVE_4GPRS(3, r11);	\
 	SAVE_2GPRS(7, r11)
@@ -915,10 +914,8 @@ start_here:
 	rfi
 /* Load up the kernel context */
 2:
-	SYNC			/* Force all PTE updates to finish */
 	tlbia			/* Clear all TLB entries */
 	sync			/* wait for tlbia/tlbie to finish */
-	TLBSYNC			/* ... on all CPUs */
 
 	/* set up the PTE pointers for the Abatron bdiGDB.
 	*/
-- 
2.13.3
