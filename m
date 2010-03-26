Return-Path: <markn@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2077AB7CB6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Mar 2010 18:08:45 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id o2Q78jfS019705
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Mar 2010 18:08:45 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2Q72bUT929986
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Mar 2010 18:02:38 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2Q78i0S011700
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Mar 2010 18:08:44 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o2Q78isT011694
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Mar 2010 18:08:44 +1100
Received: from ubrain.localnet (haven.au.ibm.com [9.190.164.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.au.ibm.com (Postfix) with ESMTP id DD18F73692
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Mar 2010 18:08:43 +1100 (EST)
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Track backing pages used allocated by
	vmemmap_populate()
Date: Fri, 26 Mar 2010 18:12:34 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201003261812.34095.markn@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to keep track of the backing pages that get allocated by
vmemmap_populate() so that when we use kdump, the dump-capture kernel can
find these pages in memory.

We use a linked list of structures that contain the physical address of the
backing page and corresponding virtual address to track the backing pages.
And we use a simple spinlock to protect the vmemmap_list.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
 arch/powerpc/include/asm/pgalloc-64.h |    7 +++++++
 arch/powerpc/mm/init_64.c             |   27 +++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

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
+	struct list_head list;
+};
 
 /*
  * Functions that deal with pagetables that could be at any level of
Index: upstream/arch/powerpc/mm/init_64.c
===================================================================
--- upstream.orig/arch/powerpc/mm/init_64.c
+++ upstream/arch/powerpc/mm/init_64.c
@@ -42,6 +42,7 @@
 #include <linux/poison.h>
 #include <linux/lmb.h>
 #include <linux/hugetlb.h>
+#include <linux/list.h>
 
 #include <asm/pgalloc.h>
 #include <asm/page.h>
@@ -251,6 +252,30 @@ static void __meminit vmemmap_create_map
 }
 #endif /* CONFIG_PPC_BOOK3E */
 
+LIST_HEAD(vmemmap_list);
+DEFINE_SPINLOCK(vmemmap_list_lock);
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
+	INIT_LIST_HEAD(&vmem_back->list);
+
+	spin_lock(&vmemmap_list_lock);
+	list_add(&vmem_back->list, &vmemmap_list);
+	spin_unlock(&vmemmap_list_lock);
+}
+
 int __meminit vmemmap_populate(struct page *start_page,
 			       unsigned long nr_pages, int node)
 {
@@ -275,6 +300,8 @@ int __meminit vmemmap_populate(struct pa
 		if (!p)
 			return -ENOMEM;
 
+		vmemmap_list_populate(__pa(p), start, node);
+
 		pr_debug("      * %016lx..%016lx allocated at %p\n",
 			 start, start + page_size, p);
 
