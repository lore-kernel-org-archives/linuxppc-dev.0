Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A14C10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 20:58:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B40320684
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 20:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B40320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kHlg45GpzDqHW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 06:58:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ldufour@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44k6B82Rn1zDqDZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 23:47:22 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3GDl0eV060749
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 09:47:20 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rwe36nyh3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 09:47:04 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.ibm.com>;
 Tue, 16 Apr 2019 14:46:36 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Apr 2019 14:46:26 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3GDkPQA33620156
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2019 13:46:25 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19B424C040;
 Tue, 16 Apr 2019 13:46:25 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7D134C046;
 Tue, 16 Apr 2019 13:46:23 +0000 (GMT)
Received: from nimbus.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.33])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2019 13:46:23 +0000 (GMT)
From: Laurent Dufour <ldufour@linux.ibm.com>
To: akpm@linux-foundation.org, mhocko@kernel.org, peterz@infradead.org,
 kirill@shutemov.name, ak@linux.intel.com, dave@stgolabs.net,
 jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
 aneesh.kumar@linux.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 sergey.senozhatsky.work@gmail.com, Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 David Rientjes <rientjes@google.com>, Jerome Glisse <jglisse@redhat.com>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>,
 Minchan Kim <minchan@kernel.org>, Punit Agrawal <punitagrawal@gmail.com>,
 vinayak menon <vinayakm.list@gmail.com>,
 Yang Shi <yang.shi@linux.alibaba.com>, zhong jiang <zhongjiang@huawei.com>,
 Haiyan Song <haiyanx.song@intel.com>,
 Balbir Singh <bsingharora@gmail.com>, sj38.park@gmail.com,
 Michel Lespinasse <walken@google.com>, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v12 21/31] mm: Introduce find_vma_rcu()
Date: Tue, 16 Apr 2019 15:45:12 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190416134522.17540-1-ldufour@linux.ibm.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041613-4275-0000-0000-000003287656
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041613-4276-0000-0000-00003837A75D
Message-Id: <20190416134522.17540-22-ldufour@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-16_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=966 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160093
X-Mailman-Approved-At: Wed, 17 Apr 2019 06:55:22 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, linux-mm@kvack.org, paulmck@linux.vnet.ibm.com,
 Tim Chen <tim.c.chen@linux.intel.com>, haren@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This allows to search for a VMA structure without holding the mmap_sem.

The search is repeated while the mm seqlock is changing and until we found
a valid VMA.

While under the RCU protection, a reference is taken on the VMA, so the
caller must call put_vma() once it not more need the VMA structure.

At the time a VMA is inserted in the MM RB tree, in vma_rb_insert(), a
reference is taken to the VMA by calling get_vma().

When removing a VMA from the MM RB tree, the VMA is not release immediately
but at the end of the RCU grace period through vm_rcu_put(). This ensures
that the VMA remains allocated until the end the RCU grace period.

Since the vm_file pointer, if valid, is released in put_vma(), there is no
guarantee that the file pointer will be valid on the returned VMA.

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 include/linux/mm_types.h |  1 +
 mm/internal.h            |  5 ++-
 mm/mmap.c                | 76 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6a6159e11a3f..9af6694cb95d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -287,6 +287,7 @@ struct vm_area_struct {
 
 #ifdef CONFIG_SPECULATIVE_PAGE_FAULT
 	atomic_t vm_ref_count;
+	struct rcu_head vm_rcu;
 #endif
 	struct rb_node vm_rb;
 
diff --git a/mm/internal.h b/mm/internal.h
index 302382bed406..1e368e4afe3c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -55,7 +55,10 @@ static inline void put_vma(struct vm_area_struct *vma)
 		__free_vma(vma);
 }
 
-#else
+extern struct vm_area_struct *find_vma_rcu(struct mm_struct *mm,
+					   unsigned long addr);
+
+#else /* CONFIG_SPECULATIVE_PAGE_FAULT */
 
 static inline void get_vma(struct vm_area_struct *vma)
 {
diff --git a/mm/mmap.c b/mm/mmap.c
index c106440dcae7..34bf261dc2c8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -179,6 +179,18 @@ static inline void mm_write_sequnlock(struct mm_struct *mm)
 {
 	write_sequnlock(&mm->mm_seq);
 }
+
+static void __vm_rcu_put(struct rcu_head *head)
+{
+	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
+						  vm_rcu);
+	put_vma(vma);
+}
+static void vm_rcu_put(struct vm_area_struct *vma)
+{
+	VM_BUG_ON_VMA(!RB_EMPTY_NODE(&vma->vm_rb), vma);
+	call_rcu(&vma->vm_rcu, __vm_rcu_put);
+}
 #else
 static inline void mm_write_seqlock(struct mm_struct *mm)
 {
@@ -190,6 +202,8 @@ static inline void mm_write_sequnlock(struct mm_struct *mm)
 
 void __free_vma(struct vm_area_struct *vma)
 {
+	if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT))
+		VM_BUG_ON_VMA(!RB_EMPTY_NODE(&vma->vm_rb), vma);
 	mpol_put(vma_policy(vma));
 	vm_area_free(vma);
 }
@@ -197,11 +211,24 @@ void __free_vma(struct vm_area_struct *vma)
 /*
  * Close a vm structure and free it, returning the next.
  */
-static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
+static struct vm_area_struct *__remove_vma(struct vm_area_struct *vma)
 {
 	struct vm_area_struct *next = vma->vm_next;
 
 	might_sleep();
+	if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT) &&
+	    !RB_EMPTY_NODE(&vma->vm_rb)) {
+		/*
+		 * If the VMA is still linked in the RB tree, we must release
+		 * that reference by calling put_vma().
+		 * This should only happen when called from exit_mmap().
+		 * We forcely clear the node to satisfy the chec in
+		 * __free_vma(). This is safe since the RB tree is not walked
+		 * anymore.
+		 */
+		RB_CLEAR_NODE(&vma->vm_rb);
+		put_vma(vma);
+	}
 	if (vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
 	if (vma->vm_file)
@@ -211,6 +238,13 @@ static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
 	return next;
 }
 
+static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
+{
+	if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT))
+		VM_BUG_ON_VMA(!RB_EMPTY_NODE(&vma->vm_rb), vma);
+	return __remove_vma(vma);
+}
+
 static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long flags,
 		struct list_head *uf);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
@@ -475,7 +509,7 @@ static inline void vma_rb_insert(struct vm_area_struct *vma,
 
 	/* All rb_subtree_gap values must be consistent prior to insertion */
 	validate_mm_rb(root, NULL);
-
+	get_vma(vma);
 	rb_insert_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
 }
 
@@ -491,6 +525,14 @@ static void __vma_rb_erase(struct vm_area_struct *vma, struct mm_struct *mm)
 	mm_write_seqlock(mm);
 	rb_erase_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
 	mm_write_sequnlock(mm);	/* wmb */
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	/*
+	 * Ensure the removal is complete before clearing the node.
+	 * Matched by vma_has_changed()/handle_speculative_fault().
+	 */
+	RB_CLEAR_NODE(&vma->vm_rb);
+	vm_rcu_put(vma);
+#endif
 }
 
 static __always_inline void vma_rb_erase_ignore(struct vm_area_struct *vma,
@@ -2331,6 +2373,34 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 
 EXPORT_SYMBOL(find_vma);
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+/*
+ * Like find_vma() but under the protection of RCU and the mm sequence counter.
+ * The vma returned has to be relaesed by the caller through the call to
+ * put_vma()
+ */
+struct vm_area_struct *find_vma_rcu(struct mm_struct *mm, unsigned long addr)
+{
+	struct vm_area_struct *vma = NULL;
+	unsigned int seq;
+
+	do {
+		if (vma)
+			put_vma(vma);
+
+		seq = read_seqbegin(&mm->mm_seq);
+
+		rcu_read_lock();
+		vma = find_vma(mm, addr);
+		if (vma)
+			get_vma(vma);
+		rcu_read_unlock();
+	} while (read_seqretry(&mm->mm_seq, seq));
+
+	return vma;
+}
+#endif
+
 /*
  * Same as find_vma, but also return a pointer to the previous VMA in *pprev.
  */
@@ -3231,7 +3301,7 @@ void exit_mmap(struct mm_struct *mm)
 	while (vma) {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
-		vma = remove_vma(vma);
+		vma = __remove_vma(vma);
 	}
 	vm_unacct_memory(nr_accounted);
 }
-- 
2.21.0

