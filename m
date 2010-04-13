Return-Path: <markn@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 35EBFB7C06
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Apr 2010 14:12:33 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id o3D4CWgm009793
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Apr 2010 14:12:32 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3D4CWmq1851586
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Apr 2010 14:12:32 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3D4CWDr017614
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Apr 2010 14:12:32 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o3D4CWno017611
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Apr 2010 14:12:32 +1000
Received: from ubrain.localnet (haven.au.ibm.com [9.190.164.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.au.ibm.com (Postfix) with ESMTP id 01FC573607
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Apr 2010 14:12:32 +1000 (EST)
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc: Track backing pages allocated by
	vmemmap_populate()
Date: Tue, 13 Apr 2010 14:16:23 +1000
References: <201003261812.34095.markn@au1.ibm.com>
In-Reply-To: <201003261812.34095.markn@au1.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201004131416.23941.markn@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to keep track of the backing pages that get allocated by
vmemmap_populate() so that when we use kdump, the dump-capture kernel knows
where these pages are.

We use a linked list of structures that contain the physical address of the
backing page and corresponding virtual address to track the backing pages.
We can use an hlist to save space, because we never remove nodes.

vmemmap_populate() is called either at boot-time or on a memory hotplug
operation. We don't have to worry about the boot-time calls because they
will be inherently single-threaded, and for a memory hotplug operation
vmemmap_populate() is called through:
sparse_add_one_section()
            |
            V
kmalloc_section_memmap()
            |
            V
sparse_mem_map_populate()
            |
            V
vmemmap_populate()
and in sparse_add_one_section() we're protected by pgdat_resize_lock().
So, we don't need a spinlock to protect the vmemmap_list.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---

changes since v1:
 - use an hlist to save space in the structure
 - remove the spinlock because it's not needed

 arch/powerpc/include/asm/pgalloc-64.h |    7 +++++++
 arch/powerpc/mm/init_64.c             |   24 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

Index: upstream/arch/powerpc/include/asm/pgalloc-64.h
===================================================================
--- upstream.orig/arch/powerpc/include/asm/pgalloc-64.h
+++ upstream/arch/powerpc/include/asm/pgalloc-64.h
@@ -10,6 +10,13 @@
 #include <linux/slab.h>
 #include <linux/cpumask.h>
 #include <linux/percpu.h>
+#include <linux/list.h>
+
+struct vmemmap_backing {
+	unsigned long phys;
+	unsigned long virt_addr;
+	struct hlist_node hlist;
+};
 
 /*
  * Functions that deal with pagetables that could be at any level of
Index: upstream/arch/powerpc/mm/init_64.c
===================================================================
--- upstream.orig/arch/powerpc/mm/init_64.c
+++ upstream/arch/powerpc/mm/init_64.c
@@ -43,6 +43,7 @@
 #include <linux/lmb.h>
 #include <linux/hugetlb.h>
 #include <linux/slab.h>
+#include <linux/list.h>
 
 #include <asm/pgalloc.h>
 #include <asm/page.h>
@@ -252,6 +253,27 @@ static void __meminit vmemmap_create_map
 }
 #endif /* CONFIG_PPC_BOOK3E */
 
+HLIST_HEAD(vmemmap_list);
+
+static __meminit void vmemmap_list_populate(unsigned long phys,
+					    unsigned long start,
+					    int node)
+{
+	struct vmemmap_backing *vmem_back;
+
+	vmem_back = vmemmap_alloc_block(sizeof(struct vmemmap_backing), node);
+	if (unlikely(!vmem_back)) {
+		WARN_ON(1);
+		return;
+	}
+
+	vmem_back->phys = phys;
+	vmem_back->virt_addr = start;
+	INIT_HLIST_NODE(&vmem_back->hlist);
+
+	hlist_add_head(&vmem_back->hlist, &vmemmap_list);
+}
+
 int __meminit vmemmap_populate(struct page *start_page,
 			       unsigned long nr_pages, int node)
 {
@@ -276,6 +298,8 @@ int __meminit vmemmap_populate(struct pa
 		if (!p)
 			return -ENOMEM;
 
+		vmemmap_list_populate(__pa(p), start, node);
+
 		pr_debug("      * %016lx..%016lx allocated at %p\n",
 			 start, start + page_size, p);
 
