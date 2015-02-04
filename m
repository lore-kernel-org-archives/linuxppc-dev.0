Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 260351A014B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 01:49:12 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Subject: [PATCH v4 1/5] powerpc/8xx: macro for handling CPU15 errata
Message-Id: <20150204144908.5BFD91A5E8E@localhost.localdomain>
Date: Wed,  4 Feb 2015 15:49:08 +0100 (CET)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Having a macro will help keep clear code.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
v2: no change
v3: Fixed the macro (missing -) and changed macro name to be more explicit
v4: Respined against scootwood.git next (0dc294f7)

 arch/powerpc/kernel/head_8xx.S | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 9b53fe1..1279018 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -297,6 +297,17 @@ SystemCall:
  * We have to use the MD_xxx registers for the tablewalk because the
  * equivalent MI_xxx registers only perform the attribute functions.
  */
+
+#ifdef CONFIG_8xx_CPU15
+#define INVALIDATE_ADJACENT_PAGES_CPU15(tmp, addr)	\
+	addi	tmp, addr, PAGE_SIZE;	\
+	tlbie	tmp;			\
+	addi	tmp, addr, -PAGE_SIZE;	\
+	tlbie	tmp
+#else
+#define INVALIDATE_ADJACENT_PAGES_CPU15(tmp, addr)
+#endif
+
 InstructionTLBMiss:
 #ifdef CONFIG_8xx_CPU6
 	mtspr	SPRN_DAR, r3
@@ -304,12 +315,7 @@ InstructionTLBMiss:
 	EXCEPTION_PROLOG_0
 	mtspr	SPRN_SPRG_SCRATCH2, r10
 	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
-#ifdef CONFIG_8xx_CPU15
-	addi	r11, r10, PAGE_SIZE
-	tlbie	r11
-	addi	r11, r10, -PAGE_SIZE
-	tlbie	r11
-#endif
+	INVALIDATE_ADJACENT_PAGES_CPU15(r11, r10)
 
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
-- 
2.1.0
