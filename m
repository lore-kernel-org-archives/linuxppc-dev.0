Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyB026tr3zDr5T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 06:18:42 +1000 (AEST)
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 mhocko@kernel.org, ard.biesheuvel@linaro.org, mark.rutland@arm.com,
 will.deacon@arm.com, catalin.marinas@arm.com, sam@ravnborg.org,
 mgorman@techsingularity.net, steven.sistare@oracle.com,
 daniel.m.jordan@oracle.com, bob.picco@oracle.com
Subject: [PATCH v9 11/12] arm64/kasan: use kasan_map_populate()
Date: Wed, 20 Sep 2017 16:17:13 -0400
Message-Id: <20170920201714.19817-12-pasha.tatashin@oracle.com>
In-Reply-To: <20170920201714.19817-1-pasha.tatashin@oracle.com>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To optimize the performance of struct page initialization,
vmemmap_populate() will no longer zero memory.

Therefore, we must use a new interface to allocate and map kasan shadow
memory, that also zeroes memory for us.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/arm64/mm/kasan_init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 81f03959a4ab..b6e92cfa3ea3 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -161,11 +161,11 @@ void __init kasan_init(void)
 
 	clear_pgds(KASAN_SHADOW_START, KASAN_SHADOW_END);
 
-	vmemmap_populate(kimg_shadow_start, kimg_shadow_end,
-			 pfn_to_nid(virt_to_pfn(lm_alias(_text))));
+	kasan_map_populate(kimg_shadow_start, kimg_shadow_end,
+			   pfn_to_nid(virt_to_pfn(lm_alias(_text))));
 
 	/*
-	 * vmemmap_populate() has populated the shadow region that covers the
+	 * kasan_map_populate() has populated the shadow region that covers the
 	 * kernel image with SWAPPER_BLOCK_SIZE mappings, so we have to round
 	 * the start and end addresses to SWAPPER_BLOCK_SIZE as well, to prevent
 	 * kasan_populate_zero_shadow() from replacing the page table entries
@@ -191,9 +191,9 @@ void __init kasan_init(void)
 		if (start >= end)
 			break;
 
-		vmemmap_populate((unsigned long)kasan_mem_to_shadow(start),
-				(unsigned long)kasan_mem_to_shadow(end),
-				pfn_to_nid(virt_to_pfn(start)));
+		kasan_map_populate((unsigned long)kasan_mem_to_shadow(start),
+				   (unsigned long)kasan_mem_to_shadow(end),
+				   pfn_to_nid(virt_to_pfn(start)));
 	}
 
 	/*
-- 
2.14.1
