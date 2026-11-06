Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0FF606A32C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OQ135yXp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLVRn6Hgrz2yjp;
	Fri, 06 Nov 2026 18:00:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.76
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793948405;
	cv=none; b=g0VSo/L32kr4CyRc4bP5uo9wWKf/po9fdWg4nGcRhyGDsEHxM0lebZ2d+mDObfQYP4yNIqqc8bih0pizitdlVtyfCpXKpR2KDHyTKaBXdfXfvggS3g3p6VV1caBK+lOUAVyGYMc2FqH0DzwzbiNpu2ROo2XfOCJgBz/GrV5IQRzrlb9Qk3CZK3mKW8rcRMEJ65RtfQM45PvG2lM+k+vsDorO0A8tEd0wYh3RXcflAfXjrrezO0zkphWerM373r75PHC+ZxzR268LZNF8dhFkGVc+5SKH8ZOba9qTRWGoZJWy556a8zX+vu9Dboo0e1FCE8r648MIzC9W5CvFFK3n1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793948405; c=relaxed/relaxed;
	bh=OcOt4PX0tQHzNhn0VTU6sv5KTaqGga1IVFO+qQedORk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLU4S3wAzkJhbkxWs/6h7GH6pXIHFJWtOITVtz67Y7a3aGXQPDAvsWM22uFn5z7Rktdhp1yxRe9ZSIz+StdorcByGaBl1B7VlLY1P37gLGISfk962kT+1yYg7AOeqUirpAeL0hLRPSGXoL3yvQoRkqevoQ9Fs7jXkNBmYfmNcZAqcfTXbAbMTlV5GrlYIuUxsnopEth2X9Y8da8mXr8hFpfS/pBhqj6MmBvj0Oa3lh2+Vb9nUOCTFCUqDteSHNN7n9N1YYJ6ZtkchHCoz4G+VWhhf9rqAe69O9sTlW4oQ4hjQmCd8n1v1aEJ0hQVZQ6GVvOEQcBmTgSXB0LjFKOv9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OQ135yXp; dkim-atps=neutral; spf=pass (client-ip=95.215.58.76; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OQ135yXp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.76; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-76.mta1.migadu.com [95.215.58.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLVRk2gWZz2xlj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 18:00:00 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=3ZBSNl6NQMmaNPPXZuPSoh3zWTH6z/X2ys0Il7SoJQY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793948377; v=1; x=1794553177;
 b=OQ135yXpIr2On9kCLVcHKB66wbY/9XnE9jgMuylMZcxWnBg5ejs0kivZuG+F9TF6SeHGvSey
 C4aZPBJ4rDvrdNQCQPzJX5Tic26erGhCz+6ro6sEZmxIwShxbUh3TDBgl2iAKb4OaPRne0rHMDF
 iyvVr3VG6p1Pa9Ztn1FmynAk=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id fab8f084cc4903d4;
	Fri, 06 Nov 2026 06:59:35 +0000
X-Mizu-Trace-ID: fab8f084cc4903d4
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	willy@infradead.org,
	jack@suse.cz,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	maddy@linux.ibm.com,
	npiggin@gmail.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	pfalcato@suse.de,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	leon@kernel.org,
	sj@kernel.org,
	rakie.kim@sk.com,
	rientjes@google.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	mhiramat@kernel.org,
	oleg@redhat.com,
	john.johansen@canonical.com,
	georgia.garcia@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	wufan@kernel.org,
	stephen.smalley.work@gmail.com,
	omosnacek@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH 09/13] fs/proc/task_mmu: convert VMA flag tests to use vma_flags_t
Date: Fri,  6 Nov 2026 14:59:25 +0800
Message-ID: <20261106065925.50906-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-late-2026-vma-flags-v1-9-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-9-0d3cd15ab75f@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Thu, Nov 05, 2026 at 09:31:00PM +0000, Lorenzo Stoakes (ARM) wrote:
>Replace use of the legacy vm_flags_t flags with vma_flags_t values where
>VMA flags are tested directly in /proc/$pid/[s]maps, pagemap, clear_refs
>and PROCMAP_QUERY.
>
>In replacing vm_flags_clear() (which takes the VMA write lock) with
>vma_clear_flags() (which does not) in clear_refs_write(), we explicitly
>write lock the VMA. The mmap write lock is already held at this point.
>
>The show_vma_header_prefix() and show_smap_vma_flags() output functions and
>the thp_vma_allowable_orders() call continue to use legacy flags for the
>time being.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---
> fs/proc/task_mmu.c | 43 ++++++++++++++++++++++---------------------
> 1 file changed, 22 insertions(+), 21 deletions(-)
>
>diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>index 22361607020d..b6e8ef15e40e 100644
>--- a/fs/proc/task_mmu.c
>+++ b/fs/proc/task_mmu.c
>@@ -569,18 +569,18 @@ static struct vm_area_struct *query_matching_vma(struct proc_maps_locking_ctx *l
> 
> 	/* VMA permissions should satisfy query flags */
> 	if (flags & PROCMAP_QUERY_VMA_FLAGS) {
>-		u32 perm = 0;
>+		vma_flags_t perm = EMPTY_VMA_FLAGS;
> 
> 		if (flags & PROCMAP_QUERY_VMA_READABLE)
>-			perm |= VM_READ;
>+			vma_flags_set(&perm, VMA_READ_BIT);
> 		if (flags & PROCMAP_QUERY_VMA_WRITABLE)
>-			perm |= VM_WRITE;
>+			vma_flags_set(&perm, VMA_WRITE_BIT);
> 		if (flags & PROCMAP_QUERY_VMA_EXECUTABLE)
>-			perm |= VM_EXEC;
>+			vma_flags_set(&perm, VMA_EXEC_BIT);
> 		if (flags & PROCMAP_QUERY_VMA_SHARED)
>-			perm |= VM_MAYSHARE;
>+			vma_flags_set(&perm, VMA_MAYSHARE_BIT);
> 
>-		if ((vma->vm_flags & perm) != perm)
>+		if (!vma_test_all_mask(vma, perm))
> 			goto skip_vma;
> 	}
> 
>@@ -647,13 +647,13 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
> 	karg.vma_end = vma->vm_end;
> 
> 	karg.vma_flags = 0;
>-	if (vma->vm_flags & VM_READ)
>+	if (vma_test(vma, VMA_READ_BIT))
> 		karg.vma_flags |= PROCMAP_QUERY_VMA_READABLE;
>-	if (vma->vm_flags & VM_WRITE)
>+	if (vma_test(vma, VMA_WRITE_BIT))
> 		karg.vma_flags |= PROCMAP_QUERY_VMA_WRITABLE;
>-	if (vma->vm_flags & VM_EXEC)
>+	if (vma_test(vma, VMA_EXEC_BIT))
> 		karg.vma_flags |= PROCMAP_QUERY_VMA_EXECUTABLE;
>-	if (vma->vm_flags & VM_MAYSHARE)
>+	if (vma_test(vma, VMA_MAYSHARE_BIT))
> 		karg.vma_flags |= PROCMAP_QUERY_VMA_SHARED;
> 
> 	karg.vma_page_size = vma_kernel_pagesize(vma);
>@@ -970,7 +970,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
> {
> 	struct mem_size_stats *mss = walk->private;
> 	struct vm_area_struct *vma = walk->vma;
>-	bool locked = !!(vma->vm_flags & VM_LOCKED);
>+	bool locked = vma_test(vma, VMA_LOCKED_BIT);
> 	struct page *page = NULL;
> 	bool present = false, young = false, dirty = false;
> 	pte_t ptent = ptep_get(pte);
>@@ -1017,7 +1017,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
> {
> 	struct mem_size_stats *mss = walk->private;
> 	struct vm_area_struct *vma = walk->vma;
>-	bool locked = !!(vma->vm_flags & VM_LOCKED);
>+	bool locked = vma_test(vma, VMA_LOCKED_BIT);
> 	struct page *page = NULL;
> 	bool present = false;
> 	struct folio *folio;
>@@ -1728,7 +1728,7 @@ static int clear_refs_test_walk(unsigned long start, unsigned long end,
> 	struct clear_refs_private *cp = walk->private;
> 	struct vm_area_struct *vma = walk->vma;
> 
>-	if (vma->vm_flags & VM_PFNMAP)
>+	if (vma_test(vma, VMA_PFNMAP_BIT))
> 		return 1;
> 
> 	/*
>@@ -1798,9 +1798,10 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
> 
> 		if (type == CLEAR_REFS_SOFT_DIRTY) {
> 			for_each_vma(vmi, vma) {
>-				if (!(vma->vm_flags & VM_SOFTDIRTY))
>+				if (!vma_test(vma, VMA_SOFTDIRTY_BIT))
> 					continue;
>-				vm_flags_clear(vma, VM_SOFTDIRTY);

vm_flags_clear() still warns on VM_SOFTDIRTY when pgtable_supports_soft_dirty()
is false. Did you mean to drop that?

(Vaguely recall you weren't too keen on that warn, though I could be wrong.)

Otherwise, LGTM!

Reviewed-by: Lance Yang <lance.yang@linux.dev>

