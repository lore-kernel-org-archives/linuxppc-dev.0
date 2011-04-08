Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <46db3f277b05346f7d50d31907ebcb6b11696c6d.1302247340.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc/book3e: Fix extlb size
Date: Fri,  8 Apr 2011 17:22:23 +1000 (EST)
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The calculation of the size for the exception save area of the TLB
miss handler is wrong, luckily it's too big not too small.

Rework it to make it a bit clearer, and also correct. We want 3 save
areas, each EX_TLB_SIZE _bytes_.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/paca.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index ec57540..c3416ca 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -106,7 +106,8 @@ struct paca_struct {
 	pgd_t *pgd;			/* Current PGD */
 	pgd_t *kernel_pgd;		/* Kernel PGD */
 	u64 exgen[8] __attribute__((aligned(0x80)));
-	u64 extlb[EX_TLB_SIZE*3] __attribute__((aligned(0x80)));
+	/* We can have up to 3 levels of reentrancy in the TLB miss handler */
+	u64 extlb[3][EX_TLB_SIZE / sizeof(u64)] __attribute__((aligned(0x80)));
 	u64 exmc[8];		/* used for machine checks */
 	u64 excrit[8];		/* used for crit interrupts */
 	u64 exdbg[8];		/* used for debug interrupts */
-- 
1.7.1
