Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m96v5NTHzF1QZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 20:05:43 +1000 (AEST)
Message-Id: <bf46e67182d88b66e8e852bf432c4df331611489.1526464250.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1526464250.git.christophe.leroy@c-s.fr>
References: <cover.1526464250.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 08/14] powerpc/8xx: Remove PTE_ATOMIC_UPDATES
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 16 May 2018 12:05:39 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 1bc54c03117b9 ("powerpc: rework 4xx PTE access and TLB miss")
introduced non atomic PTE updates and started the work of removing
PTE updates in TLB miss handlers, but kept PTE_ATOMIC_UPDATES for the
8xx with the following comment:
/* Until my rework is finished, 8xx still needs atomic PTE updates */

commit fe11dc3f9628e ("powerpc/8xx: Update TLB asm so it behaves as linux
mm expects") removed all PTE updates done in TLB miss handlers

Therefore, atomic PTE updates are not needed anymore for the 8xx

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index a9a2919251e0..31401320c1a5 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -54,9 +54,6 @@
 #define _PMD_GUARDED	0x0010
 #define _PMD_USER	0x0020	/* APG 1 */
 
-/* Until my rework is finished, 8xx still needs atomic PTE updates */
-#define PTE_ATOMIC_UPDATES	1
-
 #ifdef CONFIG_PPC_16K_PAGES
 #define _PAGE_PSIZE	_PAGE_HUGE
 #endif
-- 
2.13.3
