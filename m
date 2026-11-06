Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41336606D817
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hCunnEIZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLbTS3294z2xNC;
	Fri, 06 Nov 2026 21:46:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793962012;
	cv=none; b=EHhLbDH9SE43dqI8OBRjY8cGsuDw2/7fh/bgsiUHuT1oW19hQ06V+xN7Jk0WLn3B+pLuESHMAxrQaVX80QBi+Kh4A5CZuuN71vRIHIT0GpY43UazQ0ufs0MZqn0r++kz9NLVF9BdZJle0o7lcQwGV8cZdBsRkmcrdcqqRjWq/QdHLsH7FlMZOxD2mueGoZDRa3OU/1iwZNJwYnIWxswyb1kIjPdAd1E4GhgeI+jErI157wQUHvK4aOdlyLSp3Fic0ZA9ScmnsprTn8Yc1LnKJWUpg/Uh8PbiAiLtULKgToSD0IwHGxRIZmYvvmCd46K021pb9Sj/yfcJ/oBbjcqe0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793962012; c=relaxed/relaxed;
	bh=R4UXJ8D6lFItiQJcibx9Gvr2Xk0BfzjmL2Cx9RaqZ2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhuYQ870X8c/grNVexb5w8tYe0uc8lPBevMB5zEehYLDaO4hpqawOQQFC1itly5nIGaOqlghRnVvULZB9vLpLR5zJmJXkZG3PgLOQa+FpfsTpnV+lYZz+fPR/I0TZHRji5mTkkX/mWqPDPAezmQ/B3n/tQKSNEaAeZV/YVkrJgVoVN6gEGB8V2M+oX8IGhQtvqlMMPvmo/Lj0v22WTNnejszBmUOuHhXFWfVzpdkAaLVioHPDE+h2SFndYA91npFVA/KWJ8M0o9YpyKBgAUr0rF6+yL7D9ESpHtF8v2h48R1Bi5SGxx4Y+wkkxH9aTTx/9zbU8vcHvN5lh+9JaQjRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hCunnEIZ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hCunnEIZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLbTR4zKmz2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 21:46:51 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6844843A2F;
	Fri,  6 Nov 2026 10:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0321F0089F;
	Fri,  6 Nov 2026 10:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793962009;
	bh=R4UXJ8D6lFItiQJcibx9Gvr2Xk0BfzjmL2Cx9RaqZ2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hCunnEIZfKlr6qoMUNMOsdGsxQ7IjWUgxiafHv1Z+GtVnHVIkVloNm7JSe0jucf4v
	 Be00OZ6LyBekuVn6BjvLPY9n2k+e1AmiDi7InnmDdbDQGdSnjuudqzxDjYAlNYhG2v
	 SnIHZ4gjFJUpZLBedEUDIPptonWTz9uotLA6iRgOA5X7/RHU+Qv1IOi7Qmd5Lw5GMa
	 S4EJI6CpXc1502QDo0gR7VlleOn0nXISLFq96tAGYmHD/6PzuqiHbzA0uFQN4lnX9K
	 Fvb6evOecIr4CJf2MUAMnT/LJw8xU/8SNUha42jnLM4sIhXYighfjJoCreU0/7wDnB
	 tlpx359Zg2mQQ==
Date: Fri, 6 Nov 2026 10:46:29 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, jgg@ziepe.ca, 
	jhubbard@nvidia.com, peterx@redhat.com, willy@infradead.org, jack@suse.cz, 
	riel@surriel.com, liam@infradead.org, vbabka@kernel.org, harry@kernel.org, 
	jannh@google.com, ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, baolin.wang@linux.alibaba.com, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, usama.arif@linux.dev, 
	kas@kernel.org, xu.xin@linux.dev, chengming.zhou@linux.dev, maddy@linux.ibm.com, 
	npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, ritesh.list@gmail.com, 
	sshegde@linux.ibm.com, pfalcato@suse.de, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	baoquan.he@linux.dev, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	leon@kernel.org, sj@kernel.org, rakie.kim@sk.com, rientjes@google.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, mhiramat@kernel.org, oleg@redhat.com, 
	john.johansen@canonical.com, georgia.garcia@canonical.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, wufan@kernel.org, 
	stephen.smalley.work@gmail.com, omosnacek@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, damon@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 09/13] fs/proc/task_mmu: convert VMA flag tests to use
 vma_flags_t
Message-ID: <au2tJWwPamlmx1Q4@gremlin>
References: <20261105-late-2026-vma-flags-v1-9-0d3cd15ab75f@kernel.org>
 <20261106065925.50906-1-lance.yang@linux.dev>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106065925.50906-1-lance.yang@linux.dev>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 02:59:25PM +0800, Lance Yang wrote:
>
> On Thu, Nov 05, 2026 at 09:31:00PM +0000, Lorenzo Stoakes (ARM) wrote:
> >Replace use of the legacy vm_flags_t flags with vma_flags_t values where
> >VMA flags are tested directly in /proc/$pid/[s]maps, pagemap, clear_refs
> >and PROCMAP_QUERY.
> >
> >In replacing vm_flags_clear() (which takes the VMA write lock) with
> >vma_clear_flags() (which does not) in clear_refs_write(), we explicitly
> >write lock the VMA. The mmap write lock is already held at this point.
> >
> >The show_vma_header_prefix() and show_smap_vma_flags() output functions and
> >the thp_vma_allowable_orders() call continue to use legacy flags for the
> >time being.
> >
> >No functional change intended.
> >
> >Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >---
> > fs/proc/task_mmu.c | 43 ++++++++++++++++++++++---------------------
> > 1 file changed, 22 insertions(+), 21 deletions(-)
> >
> >diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> >index 22361607020d..b6e8ef15e40e 100644
> >--- a/fs/proc/task_mmu.c
> >+++ b/fs/proc/task_mmu.c
> >@@ -569,18 +569,18 @@ static struct vm_area_struct *query_matching_vma(struct proc_maps_locking_ctx *l
> >
> > 	/* VMA permissions should satisfy query flags */
> > 	if (flags & PROCMAP_QUERY_VMA_FLAGS) {
> >-		u32 perm = 0;
> >+		vma_flags_t perm = EMPTY_VMA_FLAGS;
> >
> > 		if (flags & PROCMAP_QUERY_VMA_READABLE)
> >-			perm |= VM_READ;
> >+			vma_flags_set(&perm, VMA_READ_BIT);
> > 		if (flags & PROCMAP_QUERY_VMA_WRITABLE)
> >-			perm |= VM_WRITE;
> >+			vma_flags_set(&perm, VMA_WRITE_BIT);
> > 		if (flags & PROCMAP_QUERY_VMA_EXECUTABLE)
> >-			perm |= VM_EXEC;
> >+			vma_flags_set(&perm, VMA_EXEC_BIT);
> > 		if (flags & PROCMAP_QUERY_VMA_SHARED)
> >-			perm |= VM_MAYSHARE;
> >+			vma_flags_set(&perm, VMA_MAYSHARE_BIT);
> >
> >-		if ((vma->vm_flags & perm) != perm)
> >+		if (!vma_test_all_mask(vma, perm))
> > 			goto skip_vma;
> > 	}
> >
> >@@ -647,13 +647,13 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
> > 	karg.vma_end = vma->vm_end;
> >
> > 	karg.vma_flags = 0;
> >-	if (vma->vm_flags & VM_READ)
> >+	if (vma_test(vma, VMA_READ_BIT))
> > 		karg.vma_flags |= PROCMAP_QUERY_VMA_READABLE;
> >-	if (vma->vm_flags & VM_WRITE)
> >+	if (vma_test(vma, VMA_WRITE_BIT))
> > 		karg.vma_flags |= PROCMAP_QUERY_VMA_WRITABLE;
> >-	if (vma->vm_flags & VM_EXEC)
> >+	if (vma_test(vma, VMA_EXEC_BIT))
> > 		karg.vma_flags |= PROCMAP_QUERY_VMA_EXECUTABLE;
> >-	if (vma->vm_flags & VM_MAYSHARE)
> >+	if (vma_test(vma, VMA_MAYSHARE_BIT))
> > 		karg.vma_flags |= PROCMAP_QUERY_VMA_SHARED;
> >
> > 	karg.vma_page_size = vma_kernel_pagesize(vma);
> >@@ -970,7 +970,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
> > {
> > 	struct mem_size_stats *mss = walk->private;
> > 	struct vm_area_struct *vma = walk->vma;
> >-	bool locked = !!(vma->vm_flags & VM_LOCKED);
> >+	bool locked = vma_test(vma, VMA_LOCKED_BIT);
> > 	struct page *page = NULL;
> > 	bool present = false, young = false, dirty = false;
> > 	pte_t ptent = ptep_get(pte);
> >@@ -1017,7 +1017,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
> > {
> > 	struct mem_size_stats *mss = walk->private;
> > 	struct vm_area_struct *vma = walk->vma;
> >-	bool locked = !!(vma->vm_flags & VM_LOCKED);
> >+	bool locked = vma_test(vma, VMA_LOCKED_BIT);
> > 	struct page *page = NULL;
> > 	bool present = false;
> > 	struct folio *folio;
> >@@ -1728,7 +1728,7 @@ static int clear_refs_test_walk(unsigned long start, unsigned long end,
> > 	struct clear_refs_private *cp = walk->private;
> > 	struct vm_area_struct *vma = walk->vma;
> >
> >-	if (vma->vm_flags & VM_PFNMAP)
> >+	if (vma_test(vma, VMA_PFNMAP_BIT))
> > 		return 1;
> >
> > 	/*
> >@@ -1798,9 +1798,10 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
> >
> > 		if (type == CLEAR_REFS_SOFT_DIRTY) {
> > 			for_each_vma(vmi, vma) {
> >-				if (!(vma->vm_flags & VM_SOFTDIRTY))
> >+				if (!vma_test(vma, VMA_SOFTDIRTY_BIT))
> > 					continue;
> >-				vm_flags_clear(vma, VM_SOFTDIRTY);
>
> vm_flags_clear() still warns on VM_SOFTDIRTY when pgtable_supports_soft_dirty()
> is false. Did you mean to drop that?

Yep it's silly. Checking every single operation with VMA_SOFTDIRTY_BIT for
whether CONFIG_MEM_SOFT_DIRTY is enabled, which is not done for literally any
other VMA flag, is ludicrous frankly :)

>
> (Vaguely recall you weren't too keen on that warn, though I could be wrong.)
>
> Otherwise, LGTM!
>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>

Thanks!

--
Cheers, Lorenzo

