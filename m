Return-Path: <rashmica.g@gmail.com>
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41s9BF6NkPzDr5t
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 14:26:13 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id r64-v6so1846815pgr.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2018 21:26:13 -0700 (PDT)
From: Rashmica Gupta <rashmica.g@gmail.com>
To: mpe@ellerman.id.au, bsingharora@gmail.com, mikey@neuling.org,
 linuxppc-dev@lists.ozlabs.org, anton@samba.org
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Subject: [PATCH] powerpc/memtrace: Remove memory in chunks
Date: Fri, 17 Aug 2018 14:25:01 +1000
Message-Id: <20180817042501.15538-1-rashmica.g@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When hot-removing memory release_mem_region_adjustable() splits iomem
resources if they are not the exact size of the memory being
hot-deleted. Adding this memory back to the kernel adds a new resource.

Eg a node has memory 0x0 - 0xfffffffff. Hot-removing 1GB from
0xf40000000 results in the single resource 0x0-0xfffffffff being split
into two resources: 0x0-0xf3fffffff and 0xf80000000-0xfffffffff.

When we hot-add the memory back we now have three resources:
0x0-0xf3fffffff, 0xf40000000-0xf7fffffff, and 0xf80000000-0xfffffffff.

This is an issue if we try to remove some memory that overlaps
resources. Eg when trying to remove 2GB at address 0xf40000000,
release_mem_region_adjustable() fails as it expects the chunk of memory
to be within the boundaries of a single resource. We then get the
warning: "Unable to release resource" and attempting to use memtrace
again gives us this error: "bash: echo: write error: Resource
temporarily unavailable"

This patch makes memtrace remove memory in chunks that are always the
same size from an address that is always equal to end_of_memory -
n*size, for some n. So hotremoving and hotadding memory of different
sizes will now not attempt to remove memory that spans multiple
resources.

Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
---

To replicate the above issue hot-remove and hot-add memory of different
sizes a bunch of times. This does it for me on POWER8 and POWER9: 
for i in `seq 1 10`; do
echo $(( $i * 268435456))  >  /sys/kernel/debug/powerpc/memtrace/enable 
echo '.'
done

 arch/powerpc/platforms/powernv/memtrace.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
index 51fe0862dcab..c5749f898652 100644
--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -119,17 +119,15 @@ static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64 nr_pages)
 	walk_memory_range(start_pfn, end_pfn, (void *)MEM_OFFLINE,
 			  change_memblock_state);
 
-	lock_device_hotplug();
-	remove_memory(nid, start_pfn << PAGE_SHIFT, nr_pages << PAGE_SHIFT);
-	unlock_device_hotplug();
 
 	return true;
 }
 
 static u64 memtrace_alloc_node(u32 nid, u64 size)
 {
-	u64 start_pfn, end_pfn, nr_pages;
+	u64 start_pfn, end_pfn, nr_pages, pfn;
 	u64 base_pfn;
+	u64 bytes = memory_block_size_bytes();
 
 	if (!node_spanned_pages(nid))
 		return 0;
@@ -142,8 +140,20 @@ static u64 memtrace_alloc_node(u32 nid, u64 size)
 	end_pfn = round_down(end_pfn - nr_pages, nr_pages);
 
 	for (base_pfn = end_pfn; base_pfn > start_pfn; base_pfn -= nr_pages) {
-		if (memtrace_offline_pages(nid, base_pfn, nr_pages) == true)
+		if (memtrace_offline_pages(nid, base_pfn, nr_pages) == true) {
+			/* Remove memory in memory block size chunks so that
+			 * iomem resources are always split to the same size
+			 * and we never try to remove memory that spans two
+			 * iomem resources.
+			 */
+			lock_device_hotplug();
+			end_pfn = base_pfn + nr_pages;
+			for (pfn = base_pfn; pfn < end_pfn; pfn += bytes>> PAGE_SHIFT) {
+				remove_memory(nid, pfn << PAGE_SHIFT, bytes);
+			}
+			unlock_device_hotplug();
 			return base_pfn << PAGE_SHIFT;
+		}
 	}
 
 	return 0;
-- 
2.14.4
