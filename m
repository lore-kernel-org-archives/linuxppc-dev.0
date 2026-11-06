Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E258B606D817
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0OBt12S
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLjbX2pggz2xJR;
	Sat, 07 Nov 2026 02:22:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793978552;
	cv=none; b=UQO6ACrrqAO5zYiCh0y+OP8gTpvWhtqltNqG4T0bsiFkbX14t2XzLbZUyOJ4hcI/2KNj2AKITGpZiIM5Z1ssSAUk1eJYISEi9JmiTmtE7oZkPqeTlWOsRSFnv8D5OATtnyuxeLPnkiO+rX092DMRffkZXosUx6SFFj8SRdsIjuP4QBNjz/WgrBNk/zkg8TdW4XbM2ZxRtNrSTpFOZFhS+zBEoF8B9+gWV2WpBHv5jiDuQSUavEhbdNA9KNjPusBYfOEvSJET4FJ1ti1/UchhDFeEQTmliztx1qIcIuw98Swksu/p7C3wMPBii/GnfvOUQ6Mp2I1R6cGQjfL7Bu3THA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793978552; c=relaxed/relaxed;
	bh=z3y+DELGAxT9V5PmpfgouMZn+gCc4O45ROBPQSi1BPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSQbOtAnpuThyTxEtuzD40P9eHXr+VoC7GCDPIsQrl0S59+S0emEaHI0F6mgDKFOk5VV8pjVMn3jXhqEsS06Imkrvsjl1v525oFk8wBJebSEBPDuxogQnklloF1EFQWroTsBCPLsqsq9AhdkP2QxGeoLhu7TPqnvqs3819pwryZOc/CJ+QvddsNkdv0UevLWy2AwsJf+shV17hvOkg2oGtq8DtC4gW5Tuqflgm7WtyvTT5Qi1A64hM2G9k5kPnaqWvh5/UEBZjWEvBvi3TmyySbbCDFiygyRMF/J2+JSjGU+S1CvkGgxovtJIgFhYdTmlg9Jzba1VSq9AXDhJl92Cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0OBt12S; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0OBt12S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLjbW25t2z2xDD
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 02:22:31 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E937D601E3;
	Fri,  6 Nov 2026 15:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73F71F0089F;
	Fri,  6 Nov 2026 15:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793978547;
	bh=z3y+DELGAxT9V5PmpfgouMZn+gCc4O45ROBPQSi1BPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D0OBt12S5A0/61ajOHRCOvVj9Y496CxzkIZ539OmP2Egd7lJ1ZTg+93+bz35MlhhQ
	 aEcmgJvs2K1rXKjoPty9afP418nmgDzNbNz3R49xM82YI+IZppcn7JPT2+rOR1oP3E
	 aXPgvNxlojcYTHikG/NcZ6k0ko8+NVlu5A2DjoEJYkhK0Y6iRimNr2X51btaRYAQe4
	 3oYkIoHH1FFpK2QL5UAfs5I6l1ULxHTF3yATZiallmsTHKUql1MDHJSRDkOp7LPZaS
	 WDiRcIhr4R/mT8uJ1TsaVWpbDwDHCB8mxh70Ac0iVGTP+nI77JgCBpwlXJfuSijYjQ
	 cOmEIk2xUD+nw==
Date: Fri, 6 Nov 2026 15:22:08 +0000
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
Subject: Re: [PATCH 00/13] mm: continue vma_flags_t conversion
Message-ID: <au3r0-geuwtRYPiC@gremlin>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <d0ea7929-7c12-4245-ba3f-6dd5c0269e6b@kernel.org>
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
In-Reply-To: <d0ea7929-7c12-4245-ba3f-6dd5c0269e6b@kernel.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 03:35:01PM +0100, David Hildenbrand (Arm) wrote:
> I agree that this should be picked separately. For example, I will pick
> everything that falls into my realm to reduce conflicts.

Hmm, generally tree-wide mechanical changes are the exception to that rule
no?

It's going to make the rest of the VMA flags/mmap_prepare conversion really
quite difficult if I have to chase every single driver maintainer in the
kernel (literally in both cases pretty much :).

And sometimes there are dependencies which mean you really can't split it
across trees unless you establish functionality in one cycle and callers in
another, but that seems a little silly.

I was thinking that once the VMA tree is separate I'd put mechanical
changes like this through it. Is that not the way to go?

>
> Ideally, patches really only touch one component.

Right, but sometimes functions are declared in one place and called in
others. It is impossible to change the signature of one without also touching
the others.

>
> [PATCH 07/13] mm/madvise: convert madvise_vma_behavior() to use vma_flags_t
>
> is all over the place :)

It's not really all over the place, it's converting vm_flags_t to
vma_flags_t across madvise.c, which involves changing a few function
signatures, whose callers must be updated.

I could split it up into 3 patches where 1 does internal-only, one changes 1
function, and the next changes another, if that works?

But there's no way for that change to only touch madvise() given the
function decl/callers.

--
Cheers, Lorenzo

