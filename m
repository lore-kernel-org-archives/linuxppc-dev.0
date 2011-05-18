Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
	[216.32.180.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0610DB6F6E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:20:53 +1000 (EST)
Date: Wed, 18 May 2011 16:05:35 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH 5/7] powerpc/mm: 64-bit: don't handle non-standard page sizes
Message-ID: <20110518210535.GD29524@schlenkerla.am.freescale.net>
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

I don't see where any non-standard page size will be set in the
kernel page tables, so don't waste time checking for it.  It wouldn't
work with TLB0 on an FSL MMU anyway, so if there's something I missed
(or which is out-of-tree), it's relying on implementation-specific
behavior.  If there's an out-of-tree need for occasional 4K mappings
with CONFIG_PPC_64K_PAGES, perhaps this check could only be done when
that is defined.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/mm/tlb_low_64e.S |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index 922fece..e782023 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -232,19 +232,6 @@ finish_normal_tlb_miss:
 	rlwimi	r11,r14,32-19,27,31	/* Insert WIMGE */
 	mtspr	SPRN_MAS2,r11
 
-	/* Check page size, if not standard, update MAS1 */
-	rldicl	r11,r14,64-8,64-8
-#ifdef CONFIG_PPC_64K_PAGES
-	cmpldi	cr0,r11,BOOK3E_PAGESZ_64K
-#else
-	cmpldi	cr0,r11,BOOK3E_PAGESZ_4K
-#endif
-	beq-	1f
-	mfspr	r11,SPRN_MAS1
-	rlwimi	r11,r14,31,21,24
-	rlwinm	r11,r11,0,21,19
-	mtspr	SPRN_MAS1,r11
-1:
 	/* Move RPN in position */
 	rldicr	r11,r14,64-(PTE_RPN_SHIFT-PAGE_SHIFT),63-PAGE_SHIFT
 	clrldi	r15,r11,12		/* Clear crap at the top */
-- 
1.7.4.1
