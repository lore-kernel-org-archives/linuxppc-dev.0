Return-Path: <markn@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C0597B7D11
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Apr 2010 12:17:08 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id o3M2HKpc025305
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Apr 2010 12:17:20 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3M2H89b1077316
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Apr 2010 12:17:08 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3M2H7bW029236
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Apr 2010 12:17:08 +1000
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] powerpc: Track backing pages allocated by
	vmemmap_populate()
Date: Thu, 22 Apr 2010 12:21:03 +1000
References: <201003261812.34095.markn@au1.ibm.com>
	<1271157404.13059.102.camel@pasglop>
	<201004140938.46705.markn@au1.ibm.com>
In-Reply-To: <201004140938.46705.markn@au1.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201004221221.03422.markn@au1.ibm.com>
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

We use a simple linked list of structures that contain the physical address
of the backing page and corresponding virtual address to track the backing
pages.
To save space, we just use a pointer to the next struct vmemmap_backing. We
can also do this because we never remove nodes.  We call the pointer "list"
to be compatible with changes made to the crash utility.

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

We allocate space for the vmemmap_backing structs by allocating whole pages
in vmemmap_list_alloc() and then handing out chunks of this to
vmemmap_list_populate().

This means that we waste at most just under one page, but this keeps the code
is simple.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---

changes since v2:
 - use a pointer to the next struct vmemmap_backing instead of an hlist
 - add vmemmap_list_alloc() to allocate space for vmemmap_backing structs
   a page at-a-time when needed 

changes since v1:
 - use an hlist to save space in the structure
 - remove the spinlock because it's not needed

 arch/powerpc/include/asm/pgalloc-64.h |    6 ++++
 arch/powerpc/mm/init_64.c             |   43 ++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

Index: upstream/arch/powerpc/include/asm/pgalloc-64.h
===================================================================
--- upstream.orig/arch/powerpc/include/asm/pgalloc-64.h
+++ upstream/arch/powerpc/include/asm/pgalloc-64.h
@@ -11,6 +11,12 @@
 #include <linux/cpumask.h>
 #include <linux/percpu.h>
 
+struct vmemmap_backing {
+	struct vmemmap_backing *list;
+	unsigned long phys;
+	unsigned long virt_addr;
+};
+
 /*
  * Functions that deal with pagetables that could be at any level of
  * the table need to be passed an "index_size" so they know how to
Index: upstream/arch/powerpc/mm/init_64.c
===================================================================
--- upstream.orig/arch/powerpc/mm/init_64.c
+++ upstream/arch/powerpc/mm/init_64.c
@@ -252,6 +252,47 @@ static void __meminit vmemmap_create_map
 }
 #endif /* CONFIG_PPC_BOOK3E */
 
+struct vmemmap_backing *vmemmap_list;
+
+static __meminit struct vmemmap_backing * vmemmap_list_alloc(int node)
+{
+	static struct vmemmap_backing *next;
+	static int num_left;
+
+	/* allocate a page when required and hand out chunks */
+	if (!next || !num_left) {
+		next = vmemmap_alloc_block(PAGE_SIZE, node);
+		if (unlikely(!next)) {
+			WARN_ON(1);
+			return NULL;
+		}
+		num_left = PAGE_SIZE / sizeof(struct vmemmap_backing);
+	}
+
+	num_left--;
+
+	return next++;
+}
+
+static __meminit void vmemmap_list_populate(unsigned long phys,
+					    unsigned long start,
+					    int node)
+{
+	struct vmemmap_backing *vmem_back;
+
+	vmem_back = vmemmap_list_alloc(node);
+	if (unlikely(!vmem_back)) {
+		WARN_ON(1);
+		return;
+	}
+
+	vmem_back->phys = phys;
+	vmem_back->virt_addr = start;
+	vmem_back->list = vmemmap_list;
+
+	vmemmap_list = vmem_back;
+}
+
 int __meminit vmemmap_populate(struct page *start_page,
 			       unsigned long nr_pages, int node)
 {
@@ -276,6 +317,8 @@ int __meminit vmemmap_populate(struct pa
 		if (!p)
 			return -ENOMEM;
 
+		vmemmap_list_populate(__pa(p), start, node);
+
 		pr_debug("      * %016lx..%016lx allocated at %p\n",
 			 start, start + page_size, p);
 
