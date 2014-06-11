Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFBEC1A054F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 18:24:02 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Wed, 11 Jun 2014 13:53:59 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 09FADE0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 13:54:57 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5B8O6fv61997080
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 13:54:07 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5B8NrRt017776
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 13:53:53 +0530
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/4] powerpc: implement vmemmap_list_free()
Date: Wed, 11 Jun 2014 16:23:36 +0800
Message-Id: <1402475019-19699-1-git-send-email-zhong@linux.vnet.ibm.com>
Cc: paulus@samba.org, Li Zhong <zhong@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch implements vmemmap_list_free() for vmemmap_free().

The freed entries will be removed from vmemmap_list, and form a freed list,
with next as the header. The next position in the last allocated page is kept
at the list tail.

When allocation, if there are freed entries left, get it from the freed list;
if no freed entries left, get it like before from the last allocated pages.

With this change, realmode_pfn_to_page() also needs to be changed to walk
all the entries in the vmemmap_list, as the virt_addr of the entries might not
be stored in order anymore.

It helps to reuse the memory when continuous doing memory hot-plug/remove
operations, but didn't reclaim the pages already allocated, so the memory usage
will only increase, but won't exceed the value for the largest memory
configuration.

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/init_64.c |   62 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index e3734ed..fa5d28b 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -226,14 +226,24 @@ static void __meminit vmemmap_create_mapping(unsigned long start,
 #endif /* CONFIG_PPC_BOOK3E */
 
 struct vmemmap_backing *vmemmap_list;
+static struct vmemmap_backing *next;
+static int num_left;
+static int num_freed;
 
 static __meminit struct vmemmap_backing * vmemmap_list_alloc(int node)
 {
-	static struct vmemmap_backing *next;
-	static int num_left;
+	struct vmemmap_backing *vmem_back;
+	/* get from freed entries first */
+	if (num_freed) {
+		num_freed--;
+		vmem_back = next;
+		next = next->list;
+
+		return vmem_back;
+	}
 
 	/* allocate a page when required and hand out chunks */
-	if (!next || !num_left) {
+	if (!num_left) {
 		next = vmemmap_alloc_block(PAGE_SIZE, node);
 		if (unlikely(!next)) {
 			WARN_ON(1);
@@ -266,6 +276,38 @@ static __meminit void vmemmap_list_populate(unsigned long phys,
 	vmemmap_list = vmem_back;
 }
 
+static unsigned long vmemmap_list_free(unsigned long start)
+{
+	struct vmemmap_backing *vmem_back, *vmem_back_prev;
+
+	vmem_back_prev = vmem_back = vmemmap_list;
+
+	/* look for it with prev pointer recorded */
+	for (; vmem_back; vmem_back = vmem_back->list) {
+		if (vmem_back->virt_addr == start)
+			break;
+		vmem_back_prev = vmem_back;
+	}
+
+	if (unlikely(!vmem_back)) {
+		WARN_ON(1);
+		return 0;
+	}
+
+	/* remove it from vmemmap_list */
+	if (vmem_back == vmemmap_list) /* remove head */
+		vmemmap_list = vmem_back->list;
+	else
+		vmem_back_prev->list = vmem_back->list;
+
+	/* next point to this freed entry */
+	vmem_back->list = next;
+	next = vmem_back;
+	num_freed++;
+
+	return vmem_back->phys;
+}
+
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 {
 	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
@@ -331,16 +373,16 @@ struct page *realmode_pfn_to_page(unsigned long pfn)
 		if (pg_va < vmem_back->virt_addr)
 			continue;
 
-		/* Check that page struct is not split between real pages */
-		if ((pg_va + sizeof(struct page)) >
-				(vmem_back->virt_addr + page_size))
-			return NULL;
-
-		page = (struct page *) (vmem_back->phys + pg_va -
+		/* After vmemmap_list entry free is possible, need check all */
+		if ((pg_va + sizeof(struct page)) <=
+				(vmem_back->virt_addr + page_size)) {
+			page = (struct page *) (vmem_back->phys + pg_va -
 				vmem_back->virt_addr);
-		return page;
+			return page;
+		}
 	}
 
+	/* Probably that page struct is split between real pages */
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(realmode_pfn_to_page);
-- 
1.7.9.5
