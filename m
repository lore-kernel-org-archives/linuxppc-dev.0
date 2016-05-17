Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r87ZP4jxYzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 17:02:53 +1000 (AEST)
Message-Id: <23b2c2daf71f89678cb1863e41ac87ee0eb1df7e.1463468056.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1463468051.git.christophe.leroy@c-s.fr>
References: <cover.1463468051.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 4/7] powerpc/8xx: unpin all TLBs before flushing
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 17 May 2016 09:02:49 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bootloader may have pinned some TLB entries so the kernel must
unpin them before flushing TLBs with tlbia otherwise pinned TLB
entries won't get flushed

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: No change
v3: No change

 arch/powerpc/kernel/head_8xx.S | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 44f4edb..d9a1656 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -797,6 +797,14 @@ start_here:
  * these mappings is mapped by page tables.
  */
 initial_mmu:
+	li	r8, 0
+	mtspr	SPRN_MI_CTR, r8		/* remove PINNED ITLB entries */
+	lis	r10, MD_RESETVAL@h
+#ifndef CONFIG_8xx_COPYBACK
+	oris	r10, r10, MD_WTDEF@h
+#endif
+	mtspr	SPRN_MD_CTR, r10	/* remove PINNED DTLB entries */
+
 	tlbia			/* Invalidate all TLB entries */
 /* Always pin the first 8 MB ITLB to prevent ITLB
    misses while mucking around with SRR0/SRR1 in asm
@@ -807,16 +815,10 @@ initial_mmu:
 	mtspr	SPRN_MI_CTR, r8	/* Set instruction MMU control */
 
 #ifdef CONFIG_PIN_TLB
-	lis	r10, (MD_RSV4I | MD_RESETVAL)@h
+	oris	r10, r10, MD_RSV4I@h
 	ori	r10, r10, 0x1c00
-	mr	r8, r10
-#else
-	lis	r10, MD_RESETVAL@h
-#endif
-#ifndef CONFIG_8xx_COPYBACK
-	oris	r10, r10, MD_WTDEF@h
-#endif
 	mtspr	SPRN_MD_CTR, r10	/* Set data TLB control */
+#endif
 
 	/* Now map the lower 8 Meg into the TLBs.  For this quick hack,
 	 * we can load the instruction and data TLB registers with the
-- 
2.1.0
