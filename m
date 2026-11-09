Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA00A606A321
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXe4ayyk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNbfT49SXz2xdX;
	Tue, 10 Nov 2026 04:01:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794243697;
	cv=none; b=YIKg/ZNRUtWckuACttrOCEBXtgr0IXXOTk5HkjjGd2LIoIrCMfZu/eLu8TaIM+bnrI5gPx2R2dNM4HeJR5j5oevnzVsaKGRSgnL4OHsL4WvQOzfsZlqwhQIhmN8AVZ6zRMc7vcqSr6V+W6tD+tndP9exWC5pi0h/iOPsL708bY5D3RqAwe0TX9KDF23OZfzM35aQeIM0jkF9eyzXg5FCxN7DVX+gLzzd1QAUKGCylcJ7OnM+RTeABk6n2XK7WDxD8set8OCNY9pPwZ47r4YI1hZxOhSE9o41V/YdTACznD+0XiXOf6fwdDV9c9MDQa2MxChMSKCfRNhoep02nUf+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794243697; c=relaxed/relaxed;
	bh=IJJA/oulexA9Wi8BzNg299HmiKK85/J/7UwO2YuuFAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gy+T5wnURz4uKdK7eT0mG15pBX3OYVItlrENz1jMUkddPl/n74u5FDg6+unLQAlrk2sGtHztCUprtCgWmrWkgxpalYnQrDrG1Gfc5b0RmIAWE3rRNqfQXEmFGI+Ri8H4rTTB+7fLhOMMTLX7wqZUBkN7Rw8avRD8VF+F3GJMpyQiV+RcIKqoQDCxLDFvW8W4sfAI5RwsODc1x3GGZ6R2uQcpW5f5jaL3ybs3TU0I9kRG8aGxsbFOCDa0wsD2Int/a2x8DcnxpdwEFbmVjALNPuSnZl9AWc6FyOFbs5XjS7tT5hwbZxIWF2hyzNqy0PMGazpFG6kATRvTNkFsfNe9/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXe4ayyk; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXe4ayyk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNbfS5M57z2xRm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 04:01:36 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AE79961918;
	Mon,  9 Nov 2026 17:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE241F008A1;
	Mon,  9 Nov 2026 17:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794243693;
	bh=IJJA/oulexA9Wi8BzNg299HmiKK85/J/7UwO2YuuFAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OXe4ayykX8PUhC/4mrNJvncbfHA3iL/5BrhRULUfvCb//HukvqL4y9L8+ZI2+vW9+
	 doj8jdAoDBms4Y/TX9s9GeRGv6bI1Ltpt/Lu8J5o8F0yXtKHYH960N4EPGuHQUuiS/
	 B22zxkwtnpfjOTfPuxCsPIbzylf0Elc7CEBHgMSoo+UQXgyzRCL+P50xk8E142A+WV
	 j64x0q5W0uSDp/Hk2Xq4WbWA/NCM/42wyA2jcpJB/sy6XhQedT2XBt20lZtmVJqQ2t
	 K4ASDB/NlEAdIJVJoGnNwe0XMIyt/1Qbr/6ykjLENJ/RenFPKeiz7rH3eSvw6S5CQS
	 hlY+XwYPl3T9g==
Date: Mon, 9 Nov 2026 17:01:17 +0000
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
Subject: Re: [PATCH 07/13] mm/madvise: convert madvise_vma_behavior() to use
 vma_flags_t
Message-ID: <avH8PeBwpa2K5vK6@gremlin>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-7-0d3cd15ab75f@kernel.org>
 <65038fdc-f4a1-461d-b7b9-669885f15c3c@kernel.org>
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
In-Reply-To: <65038fdc-f4a1-461d-b7b9-669885f15c3c@kernel.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 03:10:12PM +0100, David Hildenbrand (Arm) wrote:
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -779,7 +779,8 @@ static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
> >  	if (ksm_test_exit(mm))
> >  		return NULL;
> >  	vma = vma_lookup(mm, addr);
> > -	if (!vma || !vma_test(vma, VMA_MERGEABLE_BIT) || !vma_has_anon_rmap(vma))
> > +	if (!vma || !vma_test(vma, VMA_MERGEABLE_BIT) ||
> > +	    !vma_has_anon_rmap(vma))
>
> This change should be dropped form this patch IIUC.
>
> It would have to go into the previous one (that I applied) but it's not actually
> required.
>
> Unless I am missing something :)

Yup I'm not bothered by whitespace-only changes :P Feel free to drop this bit!

--
Cheers, Lorenzo

