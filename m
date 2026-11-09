Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAC0606A337
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WkYzP4rt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNTZ73R4hz2xjv;
	Mon, 09 Nov 2026 23:27:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794227247;
	cv=none; b=HpDUPg3jGECIdVUJW2IdSIKqfYB6ogc+PMymik7QXxWT52wNSgtzc+Tt0+6KPOh/v9L8PQu7szaNFQTzr6a/fTWQRm+Ax1g+hDzWL4lrD17wGTEEbOYVX6nyWUqZaew9B6+803sFUTnCC20xnfTKiZXzuhJKmc3X4NtDf2sVfRTTqVmC6Uo/1fFCunz0EA1MSDk/yjMWfja/Nw9HmkS3smJ2XB2OPVTbFAmDQjeydKr+pZ1Bl6B3TAFgH3fOpmtrPyAPsAMzBYROmx7aEg6XafDYjcAMZylav0ZkA6kRQhbgHf+BDWDCkOPY1fhFY4AlnsOZoU2Qh1W4E9T4l879kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794227247; c=relaxed/relaxed;
	bh=RYIcWcYzIUZ35LbYpg6XHYKMwvcMU7zN300uv/7AjsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYzuZpOVEPURkAUolPK+wZ03iDug042QsmOMOZPCjuxEw0FYRsCORIpedFpyByxyeUFjmMmaSvB7LZ/67XbMVZ3JcBPq68Ct9+4XTThLiOCXHYSqbMvCLFiPOiTZBJVv/Qf9YZxJ3CIXNPkz7OEOF2eRhpwlMomlIWcH7anbJieJYp5wJRT/lqky5omedbsx6W+I/ML+idoOSR82jnYLzX0YjhPztds8xyFJkCzlZdOTmTXhRrlC8Ijsj6XYxHpm1Nk2dF8JLRezaJoP0+h8T8Vaovoy35JxC8p0l471hBzVWSRBuGv82ij/P6ksjzmASga346DqW8OMWJzL4J3x1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WkYzP4rt; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WkYzP4rt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNTZ644pxz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 23:27:26 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BD78F62CCE;
	Mon,  9 Nov 2026 12:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0D91F0089F;
	Mon,  9 Nov 2026 12:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794227243;
	bh=RYIcWcYzIUZ35LbYpg6XHYKMwvcMU7zN300uv/7AjsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WkYzP4rt/AxJflSDY4QvHlo3QQtj+85opjVNNjFvMZqJZn+bBCQKsOR1Vc56wCsWw
	 FHwDkIcJj0dA8rBrIwiablgEvMq9q7ucu+JfX5ZN/0yOM8xaxvKN1o/8G1XCL0eIBJ
	 b0Cv7HUFzyyS7CUgxu7a5sjYbh8AKtzd//4hZ8f+wOi407hdVAolsL1UEeBF+yDk3z
	 Cz0noIGTuP+nGcjHMqce1MVu5INeoK3aRdrWAaXkeN9Rfm7WjlKS4/wg/Th3S/XzAR
	 k2GkQM8y0M0SzQ1l9cxFRP1xd1zIG5cLpSzvpH/O1BlNyrFDSrS7beg0mpHerpJWoL
	 FtSvpRHC0A2SA==
Date: Mon, 9 Nov 2026 12:27:00 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, SJ Park <sj@kernel.org>, 
	Rakie Kim <rakie.kim@sk.com>, David Rientjes <rientjes@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	John Johansen <john.johansen@canonical.com>, Georgia Garcia <georgia.garcia@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, damon@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 05/13] mm: convert THP VMA flag tests to use vma_flags_t
Message-ID: <avG7_rb_PtU1jsbH@gremlin>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-5-0d3cd15ab75f@kernel.org>
 <631047fa-8a19-44b8-9fed-6607ec79a1c1@kernel.org>
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
In-Reply-To: <631047fa-8a19-44b8-9fed-6607ec79a1c1@kernel.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 03:36:55PM +0100, David Hildenbrand (Arm) wrote:
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 0d3bd9e23613..a2c7c6a0768d 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -640,7 +640,8 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
> >  		 * If the vma has the VM_DROPPABLE flag, the collapse will
> >  		 * preserve the lazyfree property without needing to skip.
> >  		 */
> > -		if (cc->policy.anon_skip_lazyfree && !(vma->vm_flags & VM_DROPPABLE) &&
> > +		if (cc->policy.anon_skip_lazyfree &&
> > +		    !vma_test_single_mask(vma, VMA_DROPPABLE) &&
> >  		    folio_test_lazyfree(folio) && !pte_dirty(pteval)) {
> >  			result = SCAN_PAGE_LAZYFREE;
> >  			goto out;
> > @@ -1683,7 +1684,8 @@ static enum scan_result collapse_scan_anon(struct vm_area_struct *vma,
> >  		 * If the vma has the VM_DROPPABLE flag, the collapse will
> >  		 * preserve the lazyfree property without needing to skip.
> >  		 */
> > -		if (cc->policy.anon_skip_lazyfree && !(vma->vm_flags & VM_DROPPABLE) &&
> > +		if (cc->policy.anon_skip_lazyfree &&
> > +		    !vma_test_single_mask(vma, VMA_DROPPABLE) &&
> >  		    folio_test_lazyfree(folio) && !pte_dirty(pteval)) {
> >  			result = SCAN_PAGE_LAZYFREE;
> >  			failed_pfn = folio_pfn(folio);
> > @@ -1948,7 +1950,7 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
> >  	 * So page lock of folio does not protect from it, so we must not drop
> >  	 * ptl before pgt_pmd is removed, so uffd private needs pml taken now.
> >  	 */
> > -	if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
> > +	if (userfaultfd_armed(vma) && !vma_test(vma, VMA_SHARED_BIT))
> >  		pml = pmd_lock(mm, pmd);
>
> A patch in mm/core.git will remove that entirely.
>
> Right now it results in a conflict between mm-new and mm/core.git.
>
> Beat to drop this here entirely. (I can also drop it when applying)

Sorry I missed this, feel free to apply with this bit removed!

--
Cheers, Lorenzo

