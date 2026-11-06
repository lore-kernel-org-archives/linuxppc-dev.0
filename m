Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364EC606A334
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMed2u12
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLLTl6cSCz2xDD;
	Fri, 06 Nov 2026 12:01:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793926875;
	cv=none; b=QgmDOoUkNHCZt9EI5bVGM+YMDSa0zRLKb55BwOk75gW6SuflDXKhZnl8T3GBcb3HG0D7kzwhZHCiugMNGwQhBfw4TUfNFh+O+bBnIDC5O+ZiPTWQ9rRSYosQoCyRfYfUKpUOFqSHcciEYYQX+rtLDaRa4VEZX5d5EsCx5o/TiV0mt8hCknZb0bWWaSpWNvsFDQk0xrceaUfR8XloJcSEE+2MUeVEWqTptTb9TQDg7GtAp/qX++cc3tla9x22yzw9kieoR1m/wSHb3GvnCc8Qdf6eUw6Ib6YMIVUcJj7s/nHzOyw4YyMrP+0iUsNCMX5ILck08WbtGs11cK5qCJnD0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793926875; c=relaxed/relaxed;
	bh=Fy6mIR6EGyX3GNnS9djVNVrLOtUG60iOXxWGxnZZW30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtS7to5bh8B14XSfw7VrvAlkPqnuivAtdUlTgR9B9DbO317RboMhoiH38nybugcF+NGDv32p2JhOh/85/9jvKEqXCbPJcvKOdF9Hi8KlC2lNtExwbI/Wgx4iRVcMhnoo+o5WmYAxZ6CY5dlVsqfOeRlXbi9FvPJLajnJTIWURtAQKyDKvytkk5A3aVRR84mwzsVFuxuWuuZpr1OPOa+fbQarRih4Kbbw8Q7gaQ+2GAzYNKrP8nhQmyfR/IdFZ2wymWxDsUu8Hc2SO/8fbz9Ly7b/lUQMDWzKRmhWrhHKxWS+Z/q4H/R6RgkYUGeUhvYs5pnwJz877DwmTbf/0fIdHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMed2u12; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sj@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMed2u12;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sj@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLLTl0r6Dz2x9c
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 12:01:15 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A37736020F;
	Fri,  6 Nov 2026 01:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8841F0089F;
	Fri,  6 Nov 2026 01:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926871;
	bh=Fy6mIR6EGyX3GNnS9djVNVrLOtUG60iOXxWGxnZZW30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aMed2u127+wL/B/NdfIXyeoxB6u5xmOokzrftZzRxfrzI6qQeKPWKSpVsgX0qJ51K
	 hx2TLIa43xHxqsfLVPrxRVay6PdfrX7mVbGwOXR+GprD2T0ugi0eemDwVQYtftIEAO
	 AqnH5rLl+mfNwIoidLDPL9fz9NteNzXOPqZFmF/+nB0H5OL81nSlzxUQlOqsF6xT+0
	 5QY5GeM2meFlG1UUnXQC/vfBg4rzbC7YhVChXxU6K5rZJtXN1G4Idsj+btrhdV4YuU
	 XQ1ILjd6bCfk2EaJ5OXQ4ZcSqefqhddDJ2l/ZedoICv4cZPOsUrxDdXC7gYP8ju6iJ
	 4EZOWwEnjp8wA==
From: SJ Park <sj@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>,
	Lance Yang <lance.yang@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Leon Romanovsky <leon@kernel.org>,
	Rakie Kim <rakie.kim@sk.com>,
	David Rientjes <rientjes@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Fan Wu <wufan@kernel.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	=?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
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
Subject: Re: [PATCH 08/13] mm: convert miscellaneous VMA flag tests to use vma_flags_t
Date: Thu,  5 Nov 2026 17:01:00 -0800
Message-ID: <20261106010101.95918-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-late-2026-vma-flags-v1-8-0d3cd15ab75f@kernel.org>
References: 
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 05 Nov 2026 21:30:59 +0000 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> remaining straightforward VMA flag tests scattered throughout core mm, HMM
> (and its test module), DAMON and the OOM reaper.
> 
> No functional change intended.

Thank you for this nice cleanup!

> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
[...]
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -240,7 +240,7 @@ static void damon_va_walk_page_range(struct mm_struct *mm, unsigned long start,
>  		goto lock_mmap;
>  	}
>  
> -	if (!(vma->vm_flags & VM_PFNMAP)) {
> +	if (!vma_test(vma, VMA_PFNMAP_BIT)) {
>  		ops->walk_lock = PGWALK_VMA_RDLOCK_VERIFY;
>  		walk_page_range_vma(vma, start, end, ops, private);
>  	}

For DAMON part,

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]

