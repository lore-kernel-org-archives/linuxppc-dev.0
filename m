Return-Path: <kniht@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 04EA2DE613
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 08:24:15 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2QLMjPe009926
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 17:22:45 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2QLOBI6146616
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 15:24:11 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2QLOBqJ026924
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 15:24:11 -0600
Message-ID: <47EABF09.6090302@linux.vnet.ibm.com>
Date: Wed, 26 Mar 2008 16:24:25 -0500
From: Jon Tollefson <kniht@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
	Linux Memory Management List <linux-mm@kvack.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/4] allow arch specific function for allocating gigantic pages
References: <47EABE2D.7080400@linux.vnet.ibm.com>
In-Reply-To: <47EABE2D.7080400@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>, Andi Kleen <andi@firstfloor.org>,
	Adam Litke <agl@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Allow alloc_bm_huge_page() to be overridden by architectures that can't always use bootmem.
This requires huge_boot_pages to be available for use by this function.  Also huge_page_size()
and other functions need to use a long so that they can handle the 16G page size.


Signed-off-by: Jon Tollefson <kniht@linux.vnet.ibm.com>
---

 include/linux/hugetlb.h |   10 +++++++++-
 mm/hugetlb.c            |   21 +++++++++------------
 2 files changed, 18 insertions(+), 13 deletions(-)


diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index a8de3c1..35a41be 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -35,6 +35,7 @@ void hugetlb_unreserve_pages(struct inode *inode, long offset, long freed);
 extern unsigned long hugepages_treat_as_movable;
 extern const unsigned long hugetlb_zero, hugetlb_infinity;
 extern int sysctl_hugetlb_shm_group;
+extern struct list_head huge_boot_pages;
 
 /* arch callbacks */
 
@@ -219,9 +220,15 @@ struct hstate {
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
 	unsigned long parsed_hugepages;
 };
+struct huge_bm_page {
+	struct list_head list;
+	struct hstate *hstate;
+};
 
 void __init huge_add_hstate(unsigned order);
 struct hstate *huge_lookup_hstate(unsigned long pagesize);
+/* arch callback */
+int alloc_bm_huge_page(struct hstate *h);
 
 #ifndef HUGE_MAX_HSTATE
 #define HUGE_MAX_HSTATE 1
@@ -248,7 +255,7 @@ static inline struct hstate *hstate_inode(struct inode *i)
 	return HUGETLBFS_I(i)->hstate;
 }
 
-static inline unsigned huge_page_size(struct hstate *h)
+static inline unsigned long huge_page_size(struct hstate *h)
 {
 	return PAGE_SIZE << h->order;
 }
@@ -273,6 +280,7 @@ extern unsigned long sysctl_overcommit_huge_pages[HUGE_MAX_HSTATE];
 
 #else
 struct hstate {};
+#define alloc_bm_huge_page(h) NULL
 #define hstate_file(f) NULL
 #define hstate_vma(v) NULL
 #define hstate_inode(i) NULL
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c28b8b6..a0017b0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -27,6 +27,7 @@ unsigned long max_huge_pages[HUGE_MAX_HSTATE];
 unsigned long sysctl_overcommit_huge_pages[HUGE_MAX_HSTATE];
 static gfp_t htlb_alloc_mask = GFP_HIGHUSER;
 unsigned long hugepages_treat_as_movable;
+struct list_head huge_boot_pages;
 
 static int max_hstate = 1;
 
@@ -43,7 +44,8 @@ struct hstate *parsed_hstate __initdata = &global_hstate;
  */
 static DEFINE_SPINLOCK(hugetlb_lock);
 
-static void clear_huge_page(struct page *page, unsigned long addr, unsigned sz)
+static void clear_huge_page(struct page *page, unsigned long addr,
+			    unsigned long sz)
 {
 	int i;
 
@@ -521,14 +523,8 @@ static __init char *memfmt(char *buf, unsigned long n)
 	return buf;
 }
 
-static __initdata LIST_HEAD(huge_boot_pages);
-
-struct huge_bm_page {
-	struct list_head list;
-	struct hstate *hstate;
-};
-
-static int __init alloc_bm_huge_page(struct hstate *h)
+/* Can be overriden by architectures */
+__attribute__((weak)) int alloc_bm_huge_page(struct hstate *h)
 {
 	struct huge_bm_page *m;
 	m = __alloc_bootmem_node_nopanic(NODE_DATA(h->hugetlb_next_nid),
@@ -614,6 +610,7 @@ static int __init hugetlb_init(void)
 {
 	if (HPAGE_SHIFT == 0)
 		return 0;
+	INIT_LIST_HEAD(&huge_boot_pages);
 	return hugetlb_init_hstate(&global_hstate);
 }
 module_init(hugetlb_init);
@@ -866,7 +863,7 @@ int hugetlb_report_meminfo(char *buf)
 	n += dump_field(buf + n, offsetof(struct hstate, surplus_huge_pages));
 	n += sprintf(buf + n, "Hugepagesize:   ");
 	for_each_hstate (h)
-		n += sprintf(buf + n, " %5u", huge_page_size(h) / 1024);
+		n += sprintf(buf + n, " %5lu", huge_page_size(h) / 1024);
 	n += sprintf(buf + n, " kB\n");
 	return n;
 }
@@ -947,7 +944,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	unsigned long addr;
 	int cow;
 	struct hstate *h = hstate_vma(vma);
-	unsigned sz = huge_page_size(h);
+	unsigned long sz = huge_page_size(h);
 
 	cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
 
@@ -992,7 +989,7 @@ void __unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
 	struct page *page;
 	struct page *tmp;
 	struct hstate *h = hstate_vma(vma);
-	unsigned sz = huge_page_size(h);
+	unsigned long sz = huge_page_size(h);
 
 	/*
 	 * A page gathering list, protected by per file i_mmap_lock. The
