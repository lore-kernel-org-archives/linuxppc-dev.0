Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFE6C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 08:42:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ACAC2075C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 08:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACAC2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZN0t0xLwzDqgj
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 19:42:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ZMyr5WdbzDqfX
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 19:40:36 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x098csi8040401
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Jan 2019 03:40:34 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pw92nj3n8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Jan 2019 03:40:34 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 9 Jan 2019 08:40:31 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 9 Jan 2019 08:40:27 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x098eQeh57475092
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 9 Jan 2019 08:40:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E22B52054;
 Wed,  9 Jan 2019 08:40:26 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.42.126])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 439425204E;
 Wed,  9 Jan 2019 08:40:24 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH V6 3/4] powerpc/mm/iommu: Allow migration of cma allocated
 pages during mm_iommu_get
In-Reply-To: <20190109015359.GE20586@redhat.com>
References: <20190108045110.28597-1-aneesh.kumar@linux.ibm.com>
 <20190108045110.28597-4-aneesh.kumar@linux.ibm.com>
 <20190109015359.GE20586@redhat.com>
Date: Wed, 09 Jan 2019 14:10:22 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19010908-0008-0000-0000-000002AE3337
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010908-0009-0000-0000-0000221A3437
Message-Id: <87a7kajkax.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-09_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090075
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Andrea Arcangeli <aarcange@redhat.com> writes:

> Hello,
>
> On Tue, Jan 08, 2019 at 10:21:09AM +0530, Aneesh Kumar K.V wrote:
>> @@ -187,41 +149,25 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
>>  		goto unlock_exit;
>>  	}
>>  
>> +	ret = get_user_pages_cma_migrate(ua, entries, 1, mem->hpages);
>
> In terms of gup APIs, I've been wondering if this shall become
> get_user_pages_longerm(FOLL_CMA_MIGRATE). So basically moving this
> CMA migrate logic inside get_user_pages_longerm.

Do we need the FOLL_CMA_MIGRATE flag? Wondering whether a long term pin
won't imply a CMA migrate? What is the benefit of that FOLL_CMA_MIGRATE
flags. We can do better by taking a list of pages for migration and I
guess it is much simpler if we limit that migration logic to
get_user_pages_longterm()?

I ended up with something like below. Do you suggest we should add those
isolate_lru and other details via FOLL_CMA_MIGRATE flag and do that when
we take the page reference instead of doing this by iterating the page array in
get_user_pages_longterm as in the below diff?

diff --git a/mm/gup.c b/mm/gup.c
index 05acd7e2eb22..6e8152594e83 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -13,6 +13,9 @@
 #include <linux/sched/signal.h>
 #include <linux/rwsem.h>
 #include <linux/hugetlb.h>
+#include <linux/migrate.h>
+#include <linux/mm_inline.h>
+#include <linux/sched/mm.h>
 
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
@@ -1126,7 +1129,167 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
 }
 EXPORT_SYMBOL(get_user_pages);
 
+#if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
+
 #ifdef CONFIG_FS_DAX
+static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
+{
+	long i;
+	struct vm_area_struct *vma_prev = NULL;
+
+	for (i = 0; i < nr_pages; i++) {
+		struct vm_area_struct *vma = vmas[i];
+
+		if (vma == vma_prev)
+			continue;
+
+		vma_prev = vma;
+
+		if (vma_is_fsdax(vma))
+			return true;
+	}
+	return false;
+}
+#else
+static inline bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
+{
+	return false;
+}
+#endif
+
+#ifdef CONFIG_CMA
+static struct page *new_non_cma_page(struct page *page, unsigned long private)
+{
+	/*
+	 * We want to make sure we allocate the new page from the same node
+	 * as the source page.
+	 */
+	int nid = page_to_nid(page);
+	/*
+	 * Trying to allocate a page for migration. Ignore allocation
+	 * failure warnings. We don't force __GFP_THISNODE here because
+	 * this node here is the node where we have CMA reservation and
+	 * in some case these nodes will have really less non movable
+	 * allocation memory.
+	 */
+	gfp_t gfp_mask = GFP_USER | __GFP_NOWARN;
+
+	if (PageHighMem(page))
+		gfp_mask |= __GFP_HIGHMEM;
+
+#ifdef CONFIG_HUGETLB_PAGE
+	if (PageHuge(page)) {
+		struct hstate *h = page_hstate(page);
+		/*
+		 * We don't want to dequeue from the pool because pool pages will
+		 * mostly be from the CMA region.
+		 */
+		return alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
+	}
+#endif
+	if (PageTransHuge(page)) {
+		struct page *thp;
+		/*
+		 * ignore allocation failure warnings
+		 */
+		gfp_t thp_gfpmask = GFP_TRANSHUGE | __GFP_NOWARN;
+
+		/*
+		 * Remove the movable mask so that we don't allocate from
+		 * CMA area again.
+		 */
+		thp_gfpmask &= ~__GFP_MOVABLE;
+		thp = __alloc_pages_node(nid, thp_gfpmask, HPAGE_PMD_ORDER);
+		if (!thp)
+			return NULL;
+		prep_transhuge_page(thp);
+		return thp;
+	}
+
+	return __alloc_pages_node(nid, gfp_mask, 0);
+}
+
+static long check_and_migrate_cma_pages(unsigned long start, long nr_pages,
+					unsigned int gup_flags,
+					struct page **pages,
+					struct vm_area_struct **vmas)
+{
+	long i;
+	bool drain_allow = true;
+	bool migrate_allow = true;
+	LIST_HEAD(cma_page_list);
+
+check_again:
+	for (i = 0; i < nr_pages; i++) {
+		/*
+		 * If we get a page from the CMA zone, since we are going to
+		 * be pinning these entries, we might as well move them out
+		 * of the CMA zone if possible.
+		 */
+		if (is_migrate_cma_page(pages[i])) {
+
+			struct page *head = compound_head(pages[i]);
+
+			if (PageHuge(head)) {
+				isolate_huge_page(head, &cma_page_list);
+			} else {
+				if (!PageLRU(head) && drain_allow) {
+					lru_add_drain_all();
+					drain_allow = false;
+				}
+
+				if (!isolate_lru_page(head)) {
+					list_add_tail(&head->lru, &cma_page_list);
+					mod_node_page_state(page_pgdat(head),
+							    NR_ISOLATED_ANON +
+							    page_is_file_cache(head),
+							    hpage_nr_pages(head));
+				}
+			}
+		}
+	}
+
+	if (!list_empty(&cma_page_list)) {
+		/*
+		 * drop the above get_user_pages reference.
+		 */
+		for (i = 0; i < nr_pages; i++)
+			put_page(pages[i]);
+
+		if (migrate_pages(&cma_page_list, new_non_cma_page,
+				  NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
+			/*
+			 * some of the pages failed migration. Do get_user_pages
+			 * without migration.
+			 */
+			migrate_allow = false;
+
+			if (!list_empty(&cma_page_list))
+				putback_movable_pages(&cma_page_list);
+		}
+		/*
+		 * We did migrate all the pages, Try to get the page references again
+		 * migrating any new CMA pages which we failed to isolate earlier.
+		 */
+		nr_pages = get_user_pages(start, nr_pages, gup_flags, pages, vmas);
+		if ((nr_pages > 0) && migrate_allow) {
+			drain_allow = true;
+			goto check_again;
+		}
+	}
+
+	return nr_pages;
+}
+#else
+static inline long check_and_migrate_cma_pages(unsigned long start, long nr_pages,
+					       unsigned int gup_flags,
+					       struct page **pages,
+					       struct vm_area_struct **vmas)
+{
+	return nr_pages;
+}
+#endif
+
 /*
  * This is the same as get_user_pages() in that it assumes we are
  * operating on the current task's mm, but it goes further to validate
@@ -1140,11 +1303,11 @@ EXPORT_SYMBOL(get_user_pages);
  * Contrast this to iov_iter_get_pages() usages which are transient.
  */
 long get_user_pages_longterm(unsigned long start, unsigned long nr_pages,
-		unsigned int gup_flags, struct page **pages,
-		struct vm_area_struct **vmas_arg)
+			     unsigned int gup_flags, struct page **pages,
+			     struct vm_area_struct **vmas_arg)
 {
 	struct vm_area_struct **vmas = vmas_arg;
-	struct vm_area_struct *vma_prev = NULL;
+	unsigned long flags;
 	long rc, i;
 
 	if (!pages)
@@ -1157,31 +1320,20 @@ long get_user_pages_longterm(unsigned long start, unsigned long nr_pages,
 			return -ENOMEM;
 	}
 
+	flags = memalloc_nocma_save();
 	rc = get_user_pages(start, nr_pages, gup_flags, pages, vmas);
+	memalloc_nocma_restore(flags);
+	if (rc < 0)
+		goto out;
 
-	for (i = 0; i < rc; i++) {
-		struct vm_area_struct *vma = vmas[i];
-
-		if (vma == vma_prev)
-			continue;
-
-		vma_prev = vma;
-
-		if (vma_is_fsdax(vma))
-			break;
-	}
-
-	/*
-	 * Either get_user_pages() failed, or the vma validation
-	 * succeeded, in either case we don't need to put_page() before
-	 * returning.
-	 */
-	if (i >= rc)
+	if (check_dax_vmas(vmas, rc)) {
+		for (i = 0; i < rc; i++)
+			put_page(pages[i]);
+		rc = -EOPNOTSUPP;
 		goto out;
+	}
 
-	for (i = 0; i < rc; i++)
-		put_page(pages[i]);
-	rc = -EOPNOTSUPP;
+	rc = check_and_migrate_cma_pages(start, rc, gup_flags, pages, vmas);
 out:
 	if (vmas != vmas_arg)
 		kfree(vmas);

