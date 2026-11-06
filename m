Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6EA606A326
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=L+sGU7gU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLg2c6YPcz2xNC;
	Sat, 07 Nov 2026 00:27:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.114
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793951395;
	cv=none; b=Mp0ZO/BKopwGz0q8PM0qy6Ev/8mOL38sELtAZUvjeCud3ZaAQrgdN9SBt94YkruEdG5/bQA3vjHqpiP/mDLovIR7qnoSLDDG3AdWzkCBPWd162Xz0TWhP+Tpr452zBYKW/8EY9owO88cz6eAqGFx/6D0u+Quzg8mKf8xSyhgpbhgzBPi0k3K+sKxAgMZQfzOVVeX+hLvyLITJeOWjQCSfv37WABE1Mq+r/Xq/GN6fu3UflY9ime8pGvctAty+wfKK5PGxJYPP4kV9vQ08FFc0wB5Laq4qqLaVjhh+evpYDJ5ZUepWgJZuxqqAhQ2aCLekajEpbN6PYRDdhO3d/qvXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793951395; c=relaxed/relaxed;
	bh=J6SE0s1+Cmv2tEQyGLs4E7WejNQSVW6EagB3ds9ygbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAXl9QrddXVUNxDYqzTE8k6Lt9u9h63AIZ07H1rsHhsNYP3BTdSygpFuC450ojcYPLkTietCEPiozguQc2lzLLW4mgKwRmI4Brn0MLQl7a0ottcXQ/swekkGTjVO213eH+g10Z7c9L+bHf3bYwOxgHXxyXI6NYe2Zi7MEA5/PRyl6MplWVKIjVFVnJtPac8HcO0n5aZquOkEkiCKZCQRH7NQ5TACemPJ1wCDvNmeV1056sqPr91OLB9JGCjCUkFHKrOYEuVc9dfJTHGukvBbUpribv9KvYSxlbeyyWZ5IGsjjYwYJ2hCTX/eGDPUiiNi+YnWbEMNSXyvf5y2HX6jZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=L+sGU7gU; dkim-atps=neutral; spf=pass (client-ip=95.215.58.114; helo=mta1.migadu.com; envelope-from=xu.xin@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=L+sGU7gU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.114; helo=mta1.migadu.com; envelope-from=xu.xin@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 399 seconds by postgrey-1.37 at boromir; Fri, 06 Nov 2026 18:49:54 AEDT
Received: from mta1.migadu.com (out-114.mta1.migadu.com [95.215.58.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLWYG3DgGz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 18:49:54 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=PtWTq6nqlzK8T9nMNNfK0YJy8biQ9MHHy5p7qGOpMUs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793951376; v=1; x=1794556176;
 b=L+sGU7gUPH9tYmxFohc7GiJThfvfHXqpgJkm9pxixf6BgykZ7r+wdDT2/jb9cE9zv+fvHb4Y
 YMc2Y1cjreg7GjeOdznhw6PgRmD8R7chDd6jcylJzQK1Qamp15S/sDoRVAJeQwom4lL+l+8MaFG
 bgk2Czk+1ge3bRKOkT/VLdqE=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta11.migadu.com with ESMTPS id 9c50986a3e384fa4;
	Fri, 06 Nov 2026 07:42:54 +0000
X-Mizu-Trace-ID: 9c50986a3e384fa4
X-Migadu-Flow: FLOW_OUT
Date: Fri, 6 Nov 2026 15:42:19 +0800
From: "Xu Xin (vivo)" <xu.xin@linux.dev>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>,
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Pedro Falcato <pfalcato@suse.de>, Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>,
	SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>,
	David Rientjes <rientjes@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org, damon@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 06/13] mm/ksm: convert VMA flag tests to use vma_flags_t
Message-ID: <au2E2/Q3yQacg5pk@dgvxl46587.localhost.localdomain>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-6-0d3cd15ab75f@kernel.org>
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
In-Reply-To: <20261105-late-2026-vma-flags-v1-6-0d3cd15ab75f@kernel.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 09:30:57PM +0000, Lorenzo Stoakes (ARM) wrote:
> Replace use of the legacy vm_flags_t flags with vma_flags_t values where
> KSM tests VMA flags directly.
> 
> The ksm_madvise() interface continues to take legacy flags for the time
> being.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/ksm.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

LGTM! Thanks!

Reviewed-by: Xu Xin (vivo) <xu.xin@linux.dev>

> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index d6f736a1aa2f..61b772bba229 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -779,7 +779,7 @@ static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
>  	if (ksm_test_exit(mm))
>  		return NULL;
>  	vma = vma_lookup(mm, addr);
> -	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma_has_anon_rmap(vma))
> +	if (!vma || !vma_test(vma, VMA_MERGEABLE_BIT) || !vma_has_anon_rmap(vma))
>  		return NULL;
>  	return vma;
>  }
> @@ -1243,7 +1243,8 @@ static int unmerge_and_remove_all_rmap_items(void)
>  			goto mm_exiting;
>  
>  		for_each_vma(vmi, vma) {
> -			if (!(vma->vm_flags & VM_MERGEABLE) || !vma_has_anon_rmap(vma))
> +			if (!vma_test(vma, VMA_MERGEABLE_BIT) ||
> +			    !vma_has_anon_rmap(vma))
>  				continue;
>  			err = break_ksm(vma, vma->vm_start, vma->vm_end, false);
>  			if (err)
> @@ -2698,7 +2699,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>  		goto no_vmas;
>  
>  	for_each_vma(vmi, vma) {
> -		if (!(vma->vm_flags & VM_MERGEABLE))
> +		if (!vma_test(vma, VMA_MERGEABLE_BIT))
>  			continue;
>  		if (ksm_scan.address < vma->vm_start)
>  			ksm_scan.address = vma->vm_start;
> @@ -2890,7 +2891,7 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
>  {
>  	int err;
>  
> -	if (!(vma->vm_flags & VM_MERGEABLE))
> +	if (!vma_test(vma, VMA_MERGEABLE_BIT))
>  		return 0;
>  
>  	if (vma_has_anon_rmap(vma)) {
> @@ -3027,7 +3028,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
>  
>  	switch (advice) {
>  	case MADV_MERGEABLE:
> -		if (vma->vm_flags & VM_MERGEABLE)
> +		if (vma_test(vma, VMA_MERGEABLE_BIT))
>  			return 0;
>  		if (!vma_ksm_compatible(vma))
>  			return 0;
> @@ -3484,7 +3485,7 @@ bool ksm_process_mergeable(struct mm_struct *mm)
>  	mmap_assert_locked(mm);
>  	VMA_ITERATOR(vmi, mm, 0);
>  	for_each_vma(vmi, vma)
> -		if (vma->vm_flags & VM_MERGEABLE)
> +		if (vma_test(vma, VMA_MERGEABLE_BIT))
>  			return true;
>  
>  	return false;
> 
> -- 
> 2.56.0
> 

