Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D062C1007F9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:05:35 +1000 (EST)
Date: Wed, 18 May 2011 16:05:31 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH 3/7] powerpc/mm: 64-bit tlb miss: get PACA from memory rather
	than SPR
Message-ID: <20110518210531.GB29524@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20110518210453.GA29500@schlenkerla.am.freescale.net>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This saves a few cycles, at least on e5500.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/exception-64e.h |   16 +++++++---------
 arch/powerpc/kernel/paca.c               |    5 +++++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64e.h b/arch/powerpc/include/asm/exception-64e.h
index 6d53f31..6921261 100644
--- a/arch/powerpc/include/asm/exception-64e.h
+++ b/arch/powerpc/include/asm/exception-64e.h
@@ -62,16 +62,14 @@
 #define EX_TLB_ESR	( 9 * 8) /* Level 0 and 2 only */
 #define EX_TLB_SRR0	(10 * 8)
 #define EX_TLB_SRR1	(11 * 8)
-#define EX_TLB_MMUCR0	(12 * 8) /* Level 0 */
-#define EX_TLB_MAS1	(12 * 8) /* Level 0 */
-#define EX_TLB_MAS2	(13 * 8) /* Level 0 */
+#define EX_TLB_PACA	(12 * 8)
 #ifdef CONFIG_BOOK3E_MMU_TLB_STATS
-#define EX_TLB_R8	(14 * 8)
-#define EX_TLB_R9	(15 * 8)
-#define EX_TLB_LR	(16 * 8)
-#define EX_TLB_SIZE	(17 * 8)
+#define EX_TLB_R8	(13 * 8)
+#define EX_TLB_R9	(14 * 8)
+#define EX_TLB_LR	(15 * 8)
+#define EX_TLB_SIZE	(16 * 8)
 #else
-#define EX_TLB_SIZE	(14 * 8)
+#define EX_TLB_SIZE	(13 * 8)
 #endif
 
 #define	START_EXCEPTION(label)						\
@@ -98,7 +96,7 @@ exc_##label##_book3e:
 	std	r11,EX_TLB_R11(r12);					    \
 	mfspr	r11,SPRN_SPRG_TLB_SCRATCH;				    \
 	std	r13,EX_TLB_R13(r12);					    \
-	mfspr	r13,SPRN_SPRG_PACA;					    \
+	ld	r13,EX_TLB_PACA(r12);					    \
 	std	r14,EX_TLB_R14(r12);					    \
 	addi	r14,r12,EX_TLB_SIZE;					    \
 	std	r15,EX_TLB_R15(r12);					    \
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 102244e..814dae2 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -151,6 +151,11 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 #ifdef CONFIG_PPC_STD_MMU_64
 	new_paca->slb_shadow_ptr = &slb_shadow[cpu];
 #endif /* CONFIG_PPC_STD_MMU_64 */
+#ifdef CONFIG_PPC_BOOK3E
+	new_paca->extlb[0][EX_TLB_PACA / 8] = (u64)new_paca;
+	new_paca->extlb[1][EX_TLB_PACA / 8] = (u64)new_paca;
+	new_paca->extlb[2][EX_TLB_PACA / 8] = (u64)new_paca;
+#endif
 }
 
 /* Put the paca pointer into r13 and SPRG_PACA */
-- 
1.7.4.1
