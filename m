Return-Path: <david@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KFmQ0f4dzF3Dw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 19:15:50 +1000 (AEST)
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 xen-devel@lists.xenproject.org, devel@linuxdriverproject.org,
 David Hildenbrand <david@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Rashmica Gupta <rashmica.g@gmail.com>,
 Balbir Singh <bsingharora@gmail.com>, Michael Neuling <mikey@neuling.org>
Subject: [PATCH v2 5/6] powerpc/powernv: hold device_hotplug_lock when calling
 memtrace_offline_pages()
Date: Tue, 25 Sep 2018 11:14:56 +0200
Message-Id: <20180925091457.28651-6-david@redhat.com>
In-Reply-To: <20180925091457.28651-1-david@redhat.com>
References: <20180925091457.28651-1-david@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Let's perform all checking + offlining + removing under
device_hotplug_lock, so nobody can mess with these devices via
sysfs concurrently.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Neuling <mikey@neuling.org>
Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/powernv/memtrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
index fdd48f1a39f7..d84d09c56af9 100644
--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -70,6 +70,7 @@ static int change_memblock_state(struct memory_block *mem, void *arg)
 	return 0;
 }
 
+/* called with device_hotplug_lock held */
 static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64 nr_pages)
 {
 	u64 end_pfn = start_pfn + nr_pages - 1;
@@ -111,6 +112,7 @@ static u64 memtrace_alloc_node(u32 nid, u64 size)
 	end_pfn = round_down(end_pfn - nr_pages, nr_pages);
 
 	for (base_pfn = end_pfn; base_pfn > start_pfn; base_pfn -= nr_pages) {
+		lock_device_hotplug();
 		if (memtrace_offline_pages(nid, base_pfn, nr_pages) == true) {
 			/*
 			 * Remove memory in memory block size chunks so that
@@ -118,7 +120,6 @@ static u64 memtrace_alloc_node(u32 nid, u64 size)
 			 * we never try to remove memory that spans two iomem
 			 * resources.
 			 */
-			lock_device_hotplug();
 			end_pfn = base_pfn + nr_pages;
 			for (pfn = base_pfn; pfn < end_pfn; pfn += bytes>> PAGE_SHIFT) {
 				__remove_memory(nid, pfn << PAGE_SHIFT, bytes);
@@ -126,6 +127,7 @@ static u64 memtrace_alloc_node(u32 nid, u64 size)
 			unlock_device_hotplug();
 			return base_pfn << PAGE_SHIFT;
 		}
+		unlock_device_hotplug();
 	}
 
 	return 0;
-- 
2.17.1
