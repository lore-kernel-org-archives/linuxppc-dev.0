Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E3231B70E4
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Nov 2010 09:29:54 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/mm: Fix build error in setup_initial_memory_limit
Date: Wed, 10 Nov 2010 16:29:49 -0600
Message-Id: <1289428189-27258-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/powerpc/mm/tlb_nohash.c: In function 'setup_initial_memory_limit':
arch/powerpc/mm/tlb_nohash.c:588:29: error: 'ppc64_memblock_base' undeclared (first use in this function)
arch/powerpc/mm/tlb_nohash.c:588:29: note: each undeclared identifier is reported only once for each function it appears in

Due to a copy/paste typo with the following commit:

	commit cd3db0c4ca3d237e7ad20f7107216e575705d2b0
	Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
	Date:   Tue Jul 6 15:39:02 2010 -0700

	    memblock: Remove rmo_size, burry it in arch/powerpc where it belongs

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Ben,

I think this is correct, but haven't really looked at all the code.

- k

 arch/powerpc/mm/tlb_nohash.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 36c0c44..2a030d8 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -585,6 +585,6 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	ppc64_rma_size = min_t(u64, first_memblock_size, 0x40000000);
 
 	/* Finally limit subsequent allocations */
-	memblock_set_current_limit(ppc64_memblock_base + ppc64_rma_size);
+	memblock_set_current_limit(first_memblock_base + ppc64_rma_size);
 }
 #endif /* CONFIG_PPC64 */
-- 
1.7.2.3
