Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 30DDBB6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 05:58:56 +1000 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/5] powerpc: mem_init should call memblock_is_reserved with
	phys_addr_t
Date: Tue, 28 Jun 2011 14:54:46 -0500
Message-Id: <13092910702553-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <13092910103675-git-send-email-beckyb@kernel.crashing.org>
References: <1309290888309-git-send-email-beckyb@kernel.crashing.org>
	<13092909493748-git-send-email-beckyb@kernel.crashing.org>
	<13092910103675-git-send-email-beckyb@kernel.crashing.org>
Cc: wli@holomorphy.com, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Becky Bruce <beckyb@kernel.crashing.org>

This has been broken for a while but hasn't been an issue until
now because nobody was reserving regions at high addresses.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/mm/mem.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 57e545b..097b288 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -337,8 +337,9 @@ void __init mem_init(void)
 
 		highmem_mapnr = lowmem_end_addr >> PAGE_SHIFT;
 		for (pfn = highmem_mapnr; pfn < max_mapnr; ++pfn) {
+			phys_addr_t paddr = (phys_addr_t)pfn << PAGE_SHIFT;
 			struct page *page = pfn_to_page(pfn);
-			if (memblock_is_reserved(pfn << PAGE_SHIFT))
+			if (memblock_is_reserved(paddr))
 				continue;
 			ClearPageReserved(page);
 			init_page_count(page);
-- 
1.5.6.5
