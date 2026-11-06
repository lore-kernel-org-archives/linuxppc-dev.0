Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A987D606D82C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XyhloYBR
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLhbS1lBLz2xPb;
	Sat, 07 Nov 2026 01:37:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793975844;
	cv=none; b=YN3YUXB5Ol5HNEkEh8uW7WjJUO2EjNy1QPA8CPSKdzm3x+dIoDH/26Vox5Zdp+yHeMXgcItnlJjeHzszZNwNec0Dfj/oKtEtNgOjjgGLm237oVapCrVQEoV4CYIv2HGhWzZIrXuxlXLl57L2XlIJ94tNE4pGgLdlMc9bTX9L3W3Ayjva4j0OtOtrqQtblNASVA0NYC71hZ25gZgEfQi+FHpRvPhbcmxNFBN/TH+LVKITZZoq6eaBAhcn/daAOK73cp3tkWbVW4z2d9wLU37iIns4nMYJsV1U2WUl2nMJfOLP5Viv3guP+N6Ch848vxIiW3ym7uGjPTNDGCzYi40kKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793975844; c=relaxed/relaxed;
	bh=keIAQnphxXzZvo7hqiOt5+X+8kVcH3dwqTVAhWNwa0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oovfhtGVNSq+mw7hApa1rWSDD056AKLscWGVCXTA+plRxLrLp0ZWeKvHuodJQEgkOQJE5ubKVAKEc2HI5C7iO2YG4+GnJwtX20xSrfHWDPiqRXkOCjEfJdfcK6bnLIzCV/TqsxKOPKN5H0wyiXnDHODirogXhX1YZeYs3ftA5L1fev0Yd+cjt+ANizj1o3sva1Hcuir5GAHy/nNsDDvCeTUshVRbS4h5yU9G6x8iMl4EMURm9s0t+vlCypgLfpMWjQRdtHsgwGqLq05crFq5p0Kch9A7oDTYMMSQhfdgUuth1xX3CsUPNmGkULEQw6X/ZEFQoroZlQ4QIeMB6octpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XyhloYBR; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XyhloYBR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLhbR26h6z2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 01:37:23 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CD97D60A81;
	Fri,  6 Nov 2026 14:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6EB1F008A6;
	Fri,  6 Nov 2026 14:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793975840;
	bh=keIAQnphxXzZvo7hqiOt5+X+8kVcH3dwqTVAhWNwa0Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XyhloYBRU5PZfGy0zwVshpBAJFi+mIJTXNNHmRhQZ7EzgoDIjVDmnidnrNgrc9V7u
	 aVX495bpwJHG0YCLC7BkhFjwSvRyFwfvT7/9JZU5dfEhDsGnT1lXzgYCb70owp8FNi
	 dYSqAyaH21pE3nSP1vh9MqvsnWtYSHcG3feZOdlP+KPLwhdj+vU58l5hR5WVLLRwvi
	 gmlDSu/X2hi4GCV6LieIYl9ofm2sFNdnX0juU1RB4aGUsoM9j1IuKlaqvo4WKejCFh
	 9Ur0h9FMMX/2KDlz/jUbXYiE2GBFYYVYINV90SkMOqsvDM+6OfhVyTMbJDwj1Hp5ro
	 zXiwPTj3+pYTg==
Message-ID: <631047fa-8a19-44b8-9fed-6607ec79a1c1@kernel.org>
Date: Fri, 6 Nov 2026 15:36:55 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] mm: convert THP VMA flag tests to use vma_flags_t
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
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
 Christian Brauner <brauner@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, John Johansen
 <john.johansen@canonical.com>, Georgia Garcia
 <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, damon@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-5-0d3cd15ab75f@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261105-late-2026-vma-flags-v1-5-0d3cd15ab75f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 22:30, Lorenzo Stoakes (ARM) wrote:
> Replace use of the legacy vm_flags_t flags with vma_flags_t values where
> VMA flags are tested directly in the THP and khugepaged logic.
> 
> The thp_vma_allowable_orders() family of functions, hugepage_madvise() and
> khugepaged_enter_vma() continue to take legacy flags for the time being.
> 
> Also update BUG_ON()'s to VM_WARN_ON_ONCE() while here.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/huge_memory.c | 32 ++++++++++++++++----------------
>  mm/khugepaged.c  |  8 +++++---
>  2 files changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 7e589a2fb02d..764e693b422f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1257,7 +1257,7 @@ __setup("thp_anon=", setup_thp_anon);
>  
>  pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
>  {
> -	if (likely(vma->vm_flags & VM_WRITE))
> +	if (likely(vma_test(vma, VMA_WRITE_BIT)))
>  		pmd = pmd_mkwrite(pmd, vma);
>  	return pmd;
>  }
> @@ -1517,7 +1517,7 @@ vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf)
>   */
>  gfp_t vma_thp_gfp_mask(struct vm_area_struct *vma)
>  {
> -	const bool vma_madvised = vma && (vma->vm_flags & VM_HUGEPAGE);
> +	const bool vma_madvised = vma && vma_test(vma, VMA_HUGEPAGE_BIT);
>  
>  	/* Always do synchronous compaction */
>  	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
> @@ -1716,10 +1716,9 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn,
>  	 * but we need to be consistent with PTEs and architectures that
>  	 * can't support a 'special' bit.
>  	 */
> -	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
> -	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
> -						(VM_PFNMAP|VM_MIXEDMAP));
> -	BUG_ON((vma->vm_flags & VM_PFNMAP) && vma_is_cow_mapping(vma));
> +	VM_WARN_ON_ONCE(!vma_test_any(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT));
> +	VM_WARN_ON_ONCE(vma_test_all(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT));
> +	VM_WARN_ON_ONCE(vma_test(vma, VMA_PFNMAP_BIT) && vma_is_cow_mapping(vma));
>  
>  	if (unlikely(is_huge_zero_pfn(pfn)))
>  		return VM_FAULT_SIGBUS;
> @@ -1750,7 +1749,7 @@ EXPORT_SYMBOL_GPL(vmf_insert_folio_pmd);
>  #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>  static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
>  {
> -	if (likely(vma->vm_flags & VM_WRITE))
> +	if (likely(vma_test(vma, VMA_WRITE_BIT)))
>  		pud = pud_mkwrite(pud);
>  	return pud;
>  }
> @@ -1827,10 +1826,9 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn,
>  	 * but we need to be consistent with PTEs and architectures that
>  	 * can't support a 'special' bit.
>  	 */
> -	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
> -	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
> -						(VM_PFNMAP|VM_MIXEDMAP));
> -	BUG_ON((vma->vm_flags & VM_PFNMAP) && vma_is_cow_mapping(vma));
> +	VM_WARN_ON_ONCE(!vma_test_any(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT));
> +	VM_WARN_ON_ONCE(vma_test_all(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT));
> +	VM_WARN_ON_ONCE(vma_test(vma, VMA_PFNMAP_BIT) && vma_is_cow_mapping(vma));
>  
>  	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
>  
> @@ -2262,7 +2260,7 @@ static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
>  {
>  	struct page *page;
>  
> -	if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)))
> +	if (WARN_ON_ONCE(!vma_test(vma, VMA_WRITE_BIT)))
>  		return false;
>  
>  	/* Don't touch entries that are not even readable (NUMA hinting). */
> @@ -2277,7 +2275,7 @@ static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
>  	if (userfaultfd_huge_pmd_wp(vma, pmd))
>  		return false;
>  
> -	if (!(vma->vm_flags & VM_SHARED)) {
> +	if (!vma_test(vma, VMA_SHARED_BIT)) {
>  		/* See can_change_pte_writable(). */
>  		page = vm_normal_page_pmd(vma, addr, pmd);
>  		return page && PageAnon(page) && PageAnonExclusive(page);
> @@ -3568,7 +3566,8 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
>  
>  	if (pmd_dirty(orig_pmd))
>  		folio_set_dirty(folio);
> -	if (folio_test_dirty(folio) && !(vma->vm_flags & VM_DROPPABLE)) {
> +	if (folio_test_dirty(folio) &&
> +	    !vma_test_single_mask(vma, VMA_DROPPABLE)) {
>  		folio_set_swapbacked(folio);
>  		return false;
>  	}
> @@ -3600,7 +3599,8 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
>  	 */
>  	if (pmd_dirty(orig_pmd))
>  		folio_set_dirty(folio);
> -	if (folio_test_dirty(folio) && !(vma->vm_flags & VM_DROPPABLE)) {
> +	if (folio_test_dirty(folio) &&
> +	    !vma_test_single_mask(vma, VMA_DROPPABLE)) {
>  		folio_set_swapbacked(folio);
>  		set_pmd_at(mm, addr, pmdp, orig_pmd);
>  		return false;
> @@ -3614,7 +3614,7 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
>  	folio_remove_rmap_pmd(folio, pmd_page(orig_pmd), vma);
>  	zap_deposited_table(mm, pmdp);
>  	add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
> -	if (vma->vm_flags & VM_LOCKED)
> +	if (vma_test(vma, VMA_LOCKED_BIT))
>  		mlock_drain_local();
>  	folio_put(folio);
>  
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 0d3bd9e23613..a2c7c6a0768d 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -640,7 +640,8 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  		 * If the vma has the VM_DROPPABLE flag, the collapse will
>  		 * preserve the lazyfree property without needing to skip.
>  		 */
> -		if (cc->policy.anon_skip_lazyfree && !(vma->vm_flags & VM_DROPPABLE) &&
> +		if (cc->policy.anon_skip_lazyfree &&
> +		    !vma_test_single_mask(vma, VMA_DROPPABLE) &&
>  		    folio_test_lazyfree(folio) && !pte_dirty(pteval)) {
>  			result = SCAN_PAGE_LAZYFREE;
>  			goto out;
> @@ -1683,7 +1684,8 @@ static enum scan_result collapse_scan_anon(struct vm_area_struct *vma,
>  		 * If the vma has the VM_DROPPABLE flag, the collapse will
>  		 * preserve the lazyfree property without needing to skip.
>  		 */
> -		if (cc->policy.anon_skip_lazyfree && !(vma->vm_flags & VM_DROPPABLE) &&
> +		if (cc->policy.anon_skip_lazyfree &&
> +		    !vma_test_single_mask(vma, VMA_DROPPABLE) &&
>  		    folio_test_lazyfree(folio) && !pte_dirty(pteval)) {
>  			result = SCAN_PAGE_LAZYFREE;
>  			failed_pfn = folio_pfn(folio);
> @@ -1948,7 +1950,7 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
>  	 * So page lock of folio does not protect from it, so we must not drop
>  	 * ptl before pgt_pmd is removed, so uffd private needs pml taken now.
>  	 */
> -	if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
> +	if (userfaultfd_armed(vma) && !vma_test(vma, VMA_SHARED_BIT))
>  		pml = pmd_lock(mm, pmd);

A patch in mm/core.git will remove that entirely.

Right now it results in a conflict between mm-new and mm/core.git.

Beat to drop this here entirely. (I can also drop it when applying)

-- 
Cheers,

David

