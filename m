Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9663A606A685
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/2Gr8yD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYq5m2HGzz2yDD;
	Wed, 25 Nov 2026 04:08:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795540124;
	cv=none; b=ovZx+ia1YYf4z9EKoDq9i/emj1ApTmXFxAJQ6BE8zq5O6Mr0SQRyY0HvVcjwTNCbA1ufi0s1cKIKeB+A2OQX9kXJnMuvMUk8z5bpOXCxXdB6/tdb+zjHXIt6RYoNh+A+4smt+U1accI30KIpeybfTieQ1/oSmrhqgSOC5/q/f93dC56irU/ZSPvsf+JBeSNTYw+WDMPh88zczkPTMTi0qQPZjfupgqqKod2PgTc1wJs3bi9dv+8btOgHGfK9rtwKpZJIm1PvigF3uYmwIWRJVHb7pJN3bhS0KoiugoK8jny/GiRzB2PJiAdROJEfR1S6gR6r63lmfzalaHjFqwQvDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795540124; c=relaxed/relaxed;
	bh=djZgOn9VBYR+Q9AtYg7HKx7q4q8fX2B7R8qd2HdvUdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GBqXg+mLDSQ98o3apdIzH95iNXSl3WSk3xmtHBvzXCvLQ6Kvtxyi8NCB5GFj3S8bWGqFMAuj7wDE+SYYD6MAX0uDsifykRYLc7Z4yUl5sVaiiKC5DXtSzp02WzaSxWEcHJlYMx2NK6YywbshhcwfI9xC7mhAL4p1Gc1wI6g9j9Kiv/O+FVDRbJ+meZbtcl0W1DOGiHCIRg8TzJrDM6sN3sjISlSb3nEUdluZliIv9AZwyOVn37uf3jcBque9C3kqYn9FXnuUqmesGLjI0hcmJk3ylqMUPQ/reirNTa1uFpsEUqwUg48RRTAL2LLJ3f+9Ybf0wiG5jhhpQ155dJWmHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/2Gr8yD; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/2Gr8yD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYq5l4Bhpz2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 04:08:43 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 38D5A457D3;
	Tue, 24 Nov 2026 17:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AE71F0156C;
	Tue, 24 Nov 2026 17:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540120;
	bh=djZgOn9VBYR+Q9AtYg7HKx7q4q8fX2B7R8qd2HdvUdc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=J/2Gr8yDo5beGxFwzhPsmkWc4NBWJPrU08XjePkaBs9Hev/Kfag2cTQiiupKETbne
	 sK2Hk/HEfq342+hSoO20KxjzaHGGZtCtKDFx2njJXQxKLWo6eb9o/MNZai5TGz+zVG
	 NXxD4OKJooIbeXWwkqP28zJ2Z/0ErhXpF/LqtsPTqg1djJDTpDfSsDCEVovFG8KRu5
	 E7PO2GK8pYj2ygIZuW4q1HzpQ4o64Zxe8BwmSIG28UAnMis7Euu8fzZJH8pa6PpWRf
	 kdm1dFW3slkoOoxAmG+5AARVEl41dtLS/gSImzOMtJ7LklBNoaMy9QgBaOH+bZLxKo
	 Uv/E9pi2T3Rfg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 24 Nov 2026 17:07:53 +0000
Subject: [PATCH v2 01/11] mm/filemap: convert fault and readahead logic to
 use vma_flags_t
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
Message-Id: <20261124-late-2026-vma-flags-v2-1-bf3fade93064@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4980; i=ljs@kernel.org;
 h=from:subject:message-id; bh=WlizbylF+gqp9MHD4jo2N4UTW7koXv3iwuSfjXWzIJY=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZj+R+ZRBYYpfZ891l0lXZSTubBRJj/6yfoe0q8GxNL
 MM/b9OajlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEyk+CkjwyqrhY71jw3YvxTv
 Oimnds3z7cSlRe11WT+3bLmbJaQ+05KRYbXBe7Ofjzf0Wk73y7byfqtX6nuhzHpLH9e+C5G5it8
 nMwEA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
file fault and mmap readahead logic.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Barry Song <baohua@kernel.org>
---
 mm/filemap.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index acf5e562b732..ce720c4c55f0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3359,13 +3359,14 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	struct address_space *mapping = file->f_mapping;
 	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
 	struct file *fpin = NULL;
-	vm_flags_t vm_flags = vmf->vma->vm_flags;
+	struct vm_area_struct *vma = vmf->vma;
 	bool force_thp_readahead = false;
 	unsigned int thp_order = 0;
 	unsigned short mmap_miss;
 
 	/* Use the readahead code, even if readahead is disabled */
-	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && (vm_flags & VM_HUGEPAGE)) {
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
+	    vma_test(vma, VMA_HUGEPAGE_BIT)) {
 		/*
 		 * Cap max THP order at 2MB: this is the common PMD-sized
 		 * hugepage size, and it avoids memory pressure from very
@@ -3385,20 +3386,21 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		 * If we don't want any read-ahead, don't bother.
 		 * VM_EXEC case below is already intended for random access.
 		 */
-		if ((vm_flags & (VM_RAND_READ | VM_EXEC)) == VM_RAND_READ)
+		if (vma_test(vma, VMA_RAND_READ_BIT) &&
+		    !vma_test(vma, VMA_EXEC_BIT))
 			return fpin;
 
 		if (!ra->ra_pages)
 			return fpin;
 
-		if (vm_flags & VM_SEQ_READ) {
+		if (vma_test(vma, VMA_SEQ_READ_BIT)) {
 			fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 			page_cache_sync_ra(&ractl, ra->ra_pages);
 			return fpin;
 		}
 	}
 
-	if (!(vm_flags & (VM_SEQ_READ | VM_EXEC))) {
+	if (!vma_test_any(vma, VMA_SEQ_READ_BIT, VMA_EXEC_BIT)) {
 		/* Avoid banging the cache line if not needed */
 		mmap_miss = READ_ONCE(ra->mmap_miss);
 		if (mmap_miss < MMAP_LOTSAMISS * 10)
@@ -3414,6 +3416,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 
 	if (force_thp_readahead) {
 		unsigned long folio_nr_pages = 1UL << thp_order;
+		const bool random_read = vma_test(vma, VMA_RAND_READ_BIT);
 
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		ractl._index &= ~(folio_nr_pages - 1);
@@ -3422,7 +3425,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		 * Fetch two folios so we get the chance to actually
 		 * readahead, unless we've been told not to.
 		 */
-		if (!(vm_flags & VM_RAND_READ))
+		if (!random_read)
 			ra->size *= 2;
 		ra->async_size = folio_nr_pages;
 		ra->order = thp_order;
@@ -3430,7 +3433,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		return fpin;
 	}
 
-	if (vm_flags & VM_EXEC) {
+	if (vma_test(vma, VMA_EXEC_BIT)) {
 		/*
 		 * Allow arch to request a preferred minimum folio order for
 		 * executable memory. This can often be beneficial to
@@ -3442,7 +3445,6 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		 * pad that might exist between sections, which would be a waste
 		 * of memory.
 		 */
-		struct vm_area_struct *vma = vmf->vma;
 		const unsigned long start = vma_start_pgoff(vma);
 		const unsigned long end = vma_end_pgoff(vma);
 		unsigned long ra_end;
@@ -3485,7 +3487,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	unsigned short mmap_miss;
 
 	/* If we don't want any read-ahead, don't bother */
-	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
+	if (vma_test(vmf->vma, VMA_RAND_READ_BIT) || !ra->ra_pages)
 		return fpin;
 
 	/*
@@ -3499,7 +3501,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	 * keep the counter symmetric.
 	 */
 	if (likely(!folio_test_locked(folio)) &&
-	    !(vmf->vma->vm_flags & (VM_SEQ_READ | VM_EXEC))) {
+	    !vma_test_any(vmf->vma, VMA_SEQ_READ_BIT, VMA_EXEC_BIT)) {
 		mmap_miss = READ_ONCE(ra->mmap_miss);
 		if (mmap_miss)
 			WRITE_ONCE(ra->mmap_miss, --mmap_miss);
@@ -3532,7 +3534,7 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
 	 * scenarios. Recheck the PTE without PT lock firstly, thereby reducing
 	 * the number of times we hold PT lock.
 	 */
-	if (!(vma->vm_flags & VM_LOCKED))
+	if (!vma_test(vma, VMA_LOCKED_BIT))
 		return 0;
 
 	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
@@ -4018,7 +4020,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		if ((map_ret & VM_FAULT_NOPAGE) &&
 		    !(vmf->flags & FAULT_FLAG_TRIED) &&
 		    !folio_test_workingset(folio) &&
-		    !(vma->vm_flags & (VM_SEQ_READ | VM_EXEC))) {
+		    !vma_test_any(vma, VMA_SEQ_READ_BIT, VMA_EXEC_BIT)) {
 			unsigned short mmap_miss;
 
 			mmap_miss = READ_ONCE(file->f_ra.mmap_miss);

-- 
2.56.1


