Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18671606A339
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jkzC2a+a
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYq705rjGz3bV6;
	Wed, 25 Nov 2026 04:09:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795540188;
	cv=none; b=Nv4IoGA3RYu1EqGJ69p9biYWx2n25dJ3MtPYqywJtlQIxzlG4jLZ4LP07QMjUhdR9HPAKG5qE+BkLgrRn7Uvq0geK96KjjDQe5VZvWaFAQrs2KLcIZL9d8r60gs8+s+K5W0pww+VpxqMO+BBIPYxLJ3ANkP+fpnad5R9XuVgoKgfm7aHLt3OdVxTB7BWbU6oDHZieVmrgFmsQUSu+36wsYU38bfBrvKKWBanQEehE34T4sv/JJ3sJEA5Z14iwcXuJY+YxS59tGQu8EnItXfx7aTgcYB7wP4ZmM3/0mwUeLu4C8pd6OEMTlFwwJ4cygd7ZXSCAH8fezZCUwCbweXyuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795540188; c=relaxed/relaxed;
	bh=YclyTtXqNnQdGvI9jnDQFJEd0E/8CqwfDJYvEat0bqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dqr0k/Bkpv/HdC72EDVYShajG1LWJnTz8Tb2Fx2F4wwnv5O1VGTe7zFij8j8cB3nIf/08PxizSAdAjQQmA/4TdGh+Lozu4fnc1fKJKW8z52fTJXbL9MxKi70EEAqxVgev2+iyGdnRq+gbd5cUkN34Hdsn4GcWTdoRQm8PkgbPKVtpZZnd9/Wwy5KpyZI/jAGZyck91tVnf+ZRD+PwcZBpzEVT0Ko0Bk2CAhGYmtzFRCfI5k1EZOhREbrvehTV+FMMu3suaQYjEJ2OLV1+yU/qKkU5yfyql6hF4wzHIRzCTw2/rVsUj5VlB0m34B63hKnR36kaQb39O1W4UYQyd+veA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jkzC2a+a; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jkzC2a+a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYq6z5Cryz30WS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 04:09:47 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5C0AE62802;
	Tue, 24 Nov 2026 17:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16371F000C4;
	Tue, 24 Nov 2026 17:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540184;
	bh=YclyTtXqNnQdGvI9jnDQFJEd0E/8CqwfDJYvEat0bqs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jkzC2a+aMfOyVwhIHIy8q9yJecm2vc9VL678HftWY3TxEE/0ZNPlME7YujEwnYn9z
	 FTa4M3SP7m7Ej6Jt0blVuGRSgzboclBeWOk0xs17xTDThsjv+BFHaTBZGKS1/wiI6o
	 9EK5dE35qj7Abe5PZ80OaWBa0nrbFc4KaSs2dtQtR8q/RY9xQVQ7ManzAU3x9r+JWb
	 xQwlXNKr8rWofrzCRFt9JPBfodVr9JNjDz8Qdh1c5qXb9nwa5+oz85ds+rhVoRtrGG
	 LEO33qTrtjp2AbWCM48t+wRW1PvNOHKdq0GLrL5p6NE7jC2ViG6I6d+55Uwa45uDIN
	 Zk3Buh+FbwKEA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 24 Nov 2026 17:07:56 +0000
Subject: [PATCH v2 04/11] fs/proc/task_mmu: convert VMA flag tests to use
 vma_flags_t
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-late-2026-vma-flags-v2-4-bf3fade93064@kernel.org>
References: <20261124-late-2026-vma-flags-v2-0-bf3fade93064@kernel.org>
In-Reply-To: <20261124-late-2026-vma-flags-v2-0-bf3fade93064@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
 SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, 
 David Rientjes <rientjes@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 John Johansen <john.johansen@canonical.com>, 
 Georgia Garcia <georgia.garcia@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 kvm@vger.kernel.org, damon@lists.linux.dev, 
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5764; i=ljs@kernel.org;
 h=from:subject:message-id; bh=ysk3iQAfSMfEoRIiDBDNg+T+CZGoVOl2Cec5+TiCHYU=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZj+RKfdbhvnbs/sGulU3LXxxLFzFz6HR+3y5WvZ5P9
 en5fdb/O0pZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjARLg1Ghh/1L5mkP9nL2Buc
 bWQS8V17PfyZXuubzt0HHvMxfTntJMPIsC/ybmFhp1k4X2F8iBqD+J4JGfPnOO50nsq+w4VTWfY
 /FwA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace use of the legacy vm_flags_t flags with vma_flags_t values where
VMA flags are tested directly in /proc/$pid/[s]maps, pagemap, clear_refs
and PROCMAP_QUERY.

In replacing vm_flags_clear() (which takes the VMA write lock) with
vma_clear_flags() (which does not) in clear_refs_write(), we explicitly
write lock the VMA. The mmap write lock is already held at this point.

Note that vm_flags_clear() asserts that the page tables support soft-dirty
when clearing VM_SOFTDIRTY, whereas vma_clear_flags() does not. No other
VMA flag is checked this way, so this assert is intentionally dropped.

The show_vma_header_prefix() and show_smap_vma_flags() output functions and
the thp_vma_allowable_orders() call continue to use legacy flags for the
time being.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
---
 fs/proc/task_mmu.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d2a524c6ad4b..a6ed28174718 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -570,18 +570,18 @@ static struct vm_area_struct *query_matching_vma(struct proc_maps_locking_ctx *l
 
 	/* VMA permissions should satisfy query flags */
 	if (flags & PROCMAP_QUERY_VMA_FLAGS) {
-		u32 perm = 0;
+		vma_flags_t perm = EMPTY_VMA_FLAGS;
 
 		if (flags & PROCMAP_QUERY_VMA_READABLE)
-			perm |= VM_READ;
+			vma_flags_set(&perm, VMA_READ_BIT);
 		if (flags & PROCMAP_QUERY_VMA_WRITABLE)
-			perm |= VM_WRITE;
+			vma_flags_set(&perm, VMA_WRITE_BIT);
 		if (flags & PROCMAP_QUERY_VMA_EXECUTABLE)
-			perm |= VM_EXEC;
+			vma_flags_set(&perm, VMA_EXEC_BIT);
 		if (flags & PROCMAP_QUERY_VMA_SHARED)
-			perm |= VM_MAYSHARE;
+			vma_flags_set(&perm, VMA_MAYSHARE_BIT);
 
-		if ((vma->vm_flags & perm) != perm)
+		if (!vma_test_all_mask(vma, perm))
 			goto skip_vma;
 	}
 
@@ -648,13 +648,13 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
 	karg.vma_end = vma->vm_end;
 
 	karg.vma_flags = 0;
-	if (vma->vm_flags & VM_READ)
+	if (vma_test(vma, VMA_READ_BIT))
 		karg.vma_flags |= PROCMAP_QUERY_VMA_READABLE;
-	if (vma->vm_flags & VM_WRITE)
+	if (vma_test(vma, VMA_WRITE_BIT))
 		karg.vma_flags |= PROCMAP_QUERY_VMA_WRITABLE;
-	if (vma->vm_flags & VM_EXEC)
+	if (vma_test(vma, VMA_EXEC_BIT))
 		karg.vma_flags |= PROCMAP_QUERY_VMA_EXECUTABLE;
-	if (vma->vm_flags & VM_MAYSHARE)
+	if (vma_test(vma, VMA_MAYSHARE_BIT))
 		karg.vma_flags |= PROCMAP_QUERY_VMA_SHARED;
 
 	karg.vma_page_size = vma_kernel_pagesize(vma);
@@ -971,7 +971,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 {
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
-	bool locked = !!(vma->vm_flags & VM_LOCKED);
+	bool locked = vma_test(vma, VMA_LOCKED_BIT);
 	struct page *page = NULL;
 	bool present = false, young = false, dirty = false;
 	pte_t ptent = ptep_get(pte);
@@ -1018,7 +1018,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 {
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
-	bool locked = !!(vma->vm_flags & VM_LOCKED);
+	bool locked = vma_test(vma, VMA_LOCKED_BIT);
 	struct page *page = NULL;
 	bool present = false;
 	struct folio *folio;
@@ -1732,7 +1732,7 @@ static int clear_refs_test_walk(unsigned long start, unsigned long end,
 	struct clear_refs_private *cp = walk->private;
 	struct vm_area_struct *vma = walk->vma;
 
-	if (vma->vm_flags & VM_PFNMAP)
+	if (vma_test(vma, VMA_PFNMAP_BIT))
 		return 1;
 
 	/*
@@ -1802,9 +1802,10 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			for_each_vma(vmi, vma) {
-				if (!(vma->vm_flags & VM_SOFTDIRTY))
+				if (!vma_test(vma, VMA_SOFTDIRTY_BIT))
 					continue;
-				vm_flags_clear(vma, VM_SOFTDIRTY);
+				vma_start_write(vma);
+				vma_clear_flags(vma, VMA_SOFTDIRTY_BIT);
 				vma_set_page_prot(vma);
 			}
 
@@ -1908,7 +1909,7 @@ static int pagemap_pte_hole(unsigned long start, unsigned long end,
 			break;
 
 		/* Addresses in the VMA. */
-		if (vma->vm_flags & VM_SOFTDIRTY)
+		if (vma_test(vma, VMA_SOFTDIRTY_BIT))
 			pme = make_pme(0, PM_SOFT_DIRTY);
 		for (; addr < min(end, vma->vm_end); addr += PAGE_SIZE) {
 			err = add_to_pagemap(&pme, pm);
@@ -1980,7 +1981,7 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 	}
 
 out:
-	if (vma->vm_flags & VM_SOFTDIRTY)
+	if (vma_test(vma, VMA_SOFTDIRTY_BIT))
 		flags |= PM_SOFT_DIRTY;
 
 	return make_pme(frame, flags);
@@ -1998,7 +1999,7 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 	struct folio *folio = NULL;
 	int err = 0;
 
-	if (vma->vm_flags & VM_SOFTDIRTY)
+	if (vma_test(vma, VMA_SOFTDIRTY_BIT))
 		flags |= PM_SOFT_DIRTY;
 
 	if (pmd_none(pmd))
@@ -2120,7 +2121,7 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 	int err = 0;
 	pte_t pte;
 
-	if (vma->vm_flags & VM_SOFTDIRTY)
+	if (vma_test(vma, VMA_SOFTDIRTY_BIT))
 		flags |= PM_SOFT_DIRTY;
 
 	ptl = huge_pte_lock(hstate_vma(vma), walk->mm, ptep);
@@ -2629,13 +2630,13 @@ static int pagemap_scan_test_walk(unsigned long start, unsigned long end,
 		 */
 	}
 
-	if (vma->vm_flags & VM_PFNMAP)
+	if (vma_test(vma, VMA_PFNMAP_BIT))
 		return 1;
 
 	if (wp_allowed)
 		vma_category |= PAGE_IS_WPALLOWED;
 
-	if (vma->vm_flags & VM_SOFTDIRTY)
+	if (vma_test(vma, VMA_SOFTDIRTY_BIT))
 		vma_category |= PAGE_IS_SOFT_DIRTY;
 
 	if (!pagemap_scan_is_interesting_vma(vma_category, p))

-- 
2.56.1


