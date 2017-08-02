Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1050.oracle.com (userp1050.oracle.com [156.151.31.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN4n257HFzDql1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 06:39:50 +1000 (AEST)
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v72KdmgF026596
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 20:39:48 GMT
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 mhocko@kernel.org
Subject: [v4 11/15] arm64/kasan: explicitly zero kasan shadow memory
Date: Wed,  2 Aug 2017 16:38:20 -0400
Message-Id: <1501706304-869240-12-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1501706304-869240-1-git-send-email-pasha.tatashin@oracle.com>
References: <1501706304-869240-1-git-send-email-pasha.tatashin@oracle.com>
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

We must explicitly zero the memory that is allocated by vmemmap_populate()
for kasan, as this memory does not go through struct page initialization
path.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
---
 arch/arm64/mm/kasan_init.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 81f03959a4ab..a57104bc54b8 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -135,6 +135,31 @@ static void __init clear_pgds(unsigned long start,
 		set_pgd(pgd_offset_k(start), __pgd(0));
 }
 
+/*
+ * Memory that was allocated by vmemmap_populate is not zeroed, so we must
+ * zero it here explicitly.
+ */
+static void
+zero_vemmap_populated_memory(void)
+{
+	struct memblock_region *reg;
+	u64 start, end;
+
+	for_each_memblock(memory, reg) {
+		start = __phys_to_virt(reg->base);
+		end = __phys_to_virt(reg->base + reg->size);
+
+		if (start >= end)
+			break;
+
+		memset((void *)start, 0, end - start);
+	}
+
+	start = (u64)kasan_mem_to_shadow(_stext);
+	end = (u64)kasan_mem_to_shadow(_end);
+	memset((void *)start, 0, end - start);
+}
+
 void __init kasan_init(void)
 {
 	u64 kimg_shadow_start, kimg_shadow_end;
@@ -205,6 +230,13 @@ void __init kasan_init(void)
 			pfn_pte(sym_to_pfn(kasan_zero_page), PAGE_KERNEL_RO));
 
 	memset(kasan_zero_page, 0, PAGE_SIZE);
+
+	/*
+	 * vmemmap_populate does not zero the memory, so we need to zero it
+	 * explicitly
+	 */
+	zero_vemmap_populated_memory();
+
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 
 	/* At this point kasan is fully initialized. Enable error messages */
-- 
2.13.3
