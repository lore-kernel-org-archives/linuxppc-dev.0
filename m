Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ABD2D1A0171
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 20:12:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/6] powerpc/mm: Remove duplicate declaration of setbat()
Date: Wed, 25 Mar 2015 20:11:54 +1100
Message-Id: <1427274719-25890-1-git-send-email-mpe@ellerman.id.au>
Cc: aneesh.kumar@in.ibm.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is already declared in mmu_decl.h, so we don't need a second
version in the C file.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/pgtable_32.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 03b1a3b0fbd5..72555ab145cd 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -54,9 +54,6 @@ extern char etext[], _stext[];
 #ifdef HAVE_BATS
 extern phys_addr_t v_mapped_by_bats(unsigned long va);
 extern unsigned long p_mapped_by_bats(phys_addr_t pa);
-void setbat(int index, unsigned long virt, phys_addr_t phys,
-	    unsigned int size, int flags);
-
 #else /* !HAVE_BATS */
 #define v_mapped_by_bats(x)	(0UL)
 #define p_mapped_by_bats(x)	(0UL)
-- 
2.1.0
