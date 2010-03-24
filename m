Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8DFD8B7CEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Mar 2010 19:18:35 +1100 (EST)
Subject: [PATCH 1/2] mm/vmalloc: Export purge_vmap_area_lazy()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Mar 2010 18:56:31 +1100
Message-ID: <1269417391.8599.188.camel@pasglop>
Mime-Version: 1.0
Cc: Nick Piggin <npiggin@suse.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some powerpc code needs to ensure that all previous iounmap/vunmap has
really been flushed out of the MMU hash table. Without that, various
hotplug operations may fail when trying to return those pieces to
the hypervisor due to existing active mappings.

This exports purge_vmap_area_lazy() to allow the powerpc code to perform
that purge when unplugging devices.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 include/linux/vmalloc.h |    1 +
 mm/vmalloc.c            |    5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

Nick, care to give me an Ack so I can get that upstream along with
the next patch ASAP (and back into distros) ?

Thanks !
Ben.

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 227c2a5..0d0ae4e 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -99,6 +99,7 @@ extern int map_kernel_range_noflush(unsigned long start, unsigned long size,
 				    pgprot_t prot, struct page **pages);
 extern void unmap_kernel_range_noflush(unsigned long addr, unsigned long size);
 extern void unmap_kernel_range(unsigned long addr, unsigned long size);
+extern void purge_vmap_area_lazy(void);
 
 /* Allocate/destroy a 'vmalloc' VM area. */
 extern struct vm_struct *alloc_vm_area(size_t size);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ae00746..d25c741 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -317,8 +317,6 @@ static void __insert_vmap_area(struct vmap_area *va)
 		list_add_rcu(&va->list, &vmap_area_list);
 }
 
-static void purge_vmap_area_lazy(void);
-
 /*
  * Allocate a region of KVA of the specified size and alignment, within the
  * vstart and vend.
@@ -590,12 +588,13 @@ static void try_purge_vmap_area_lazy(void)
 /*
  * Kick off a purge of the outstanding lazy areas.
  */
-static void purge_vmap_area_lazy(void)
+void purge_vmap_area_lazy(void)
 {
 	unsigned long start = ULONG_MAX, end = 0;
 
 	__purge_vmap_area_lazy(&start, &end, 1, 0);
 }
+EXPORT_SYMBOL_GPL(purge_vmap_area_lazy);
 
 /*
  * Free and unmap a vmap area, caller ensuring flush_cache_vunmap had been
