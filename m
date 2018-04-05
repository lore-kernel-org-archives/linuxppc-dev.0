Return-Path: <bsingharora@gmail.com>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40H0XW3lYxzF1pr
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 21:12:11 +1000 (AEST)
Received: by mail-io0-x243.google.com with SMTP id x77so23867009ioi.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Apr 2018 04:12:11 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: [RFC 2/2] powerpc/mm/memtrace: Let the arch hotunplug code flush cache
Date: Thu,  5 Apr 2018 21:11:53 +1000
Message-Id: <20180405111153.907-2-bsingharora@gmail.com>
In-Reply-To: <20180405111153.907-1-bsingharora@gmail.com>
References: <20180405111153.907-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Don't do this via custom code, instead now that we have support
in the arch hotplug/hotunplug code, rely on those routines
to do the right thing.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/platforms/powernv/memtrace.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
index de470caf0784..fc222a0c2ac4 100644
--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -82,19 +82,6 @@ static const struct file_operations memtrace_fops = {
 	.open	= simple_open,
 };
 
-static void flush_memory_region(u64 base, u64 size)
-{
-	unsigned long line_size = ppc64_caches.l1d.size;
-	u64 end = base + size;
-	u64 addr;
-
-	base = round_down(base, line_size);
-	end = round_up(end, line_size);
-
-	for (addr = base; addr < end; addr += line_size)
-		asm volatile("dcbf 0,%0" : "=r" (addr) :: "memory");
-}
-
 static int check_memblock_online(struct memory_block *mem, void *arg)
 {
 	if (mem->state != MEM_ONLINE)
@@ -132,10 +119,6 @@ static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64 nr_pages)
 	walk_memory_range(start_pfn, end_pfn, (void *)MEM_OFFLINE,
 			  change_memblock_state);
 
-	/* RCU grace period? */
-	flush_memory_region((u64)__va(start_pfn << PAGE_SHIFT),
-			    nr_pages << PAGE_SHIFT);
-
 	lock_device_hotplug();
 	remove_memory(nid, start_pfn << PAGE_SHIFT, nr_pages << PAGE_SHIFT);
 	unlock_device_hotplug();
-- 
2.13.6
