Return-Path: <bsingharora@gmail.com>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40HSmz3vF9zF204
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 15:24:35 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id v13so274014iob.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Apr 2018 22:24:35 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, rashmica.g@gmail.com, benh@kernel.crashing.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH 1/2] powerpc/mm: Flush cache on memory hot(un)plug
Date: Fri,  6 Apr 2018 15:24:23 +1000
Message-Id: <20180406052424.29841-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds support for flushing potentially dirty
cache lines when memory is hot-plugged/hot-un-plugged.
The support is currently limited to 64 bit systems.

The bug was exposed when mappings for a device were
actually hot-unplugged and plugged in back later.
A similar issue was observed during the development
of memtrace, but memtrace does it's own flushing of
region via a custom routine.

These patches do a flush both on hotplug/unplug to
clear any stale data in the cache w.r.t mappings,
there is a small race window where a clean cache
line may be created again just prior to tearing
down the mapping.

The patches were tested by disabling the flush
routines in memtrace and doing I/O on the trace
file. The system immediately checkstops (quite
reliablly if prior to the hot-unplug of the memtrace
region, we memset the regions we are about to
hot unplug). After these patches no custom flushing
is needed in the memtrace code.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/mm/mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 85245ef97e72..0a8959b15b39 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -143,6 +143,7 @@ int __meminit arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *
 			start, start + size, rc);
 		return -EFAULT;
 	}
+	flush_inval_dcache_range(start, start + size);
 
 	return __add_pages(nid, start_pfn, nr_pages, altmap, want_memblock);
 }
@@ -169,6 +170,7 @@ int __meminit arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap
 
 	/* Remove htab bolted mappings for this section of memory */
 	start = (unsigned long)__va(start);
+	flush_inval_dcache_range(start, start + size);
 	ret = remove_section_mapping(start, start + size);
 
 	/* Ensure all vmalloc mappings are flushed in case they also
-- 
2.13.6
