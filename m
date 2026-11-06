Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97533606A33B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bK0a9SGW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLcG35wwjz2xNC;
	Fri, 06 Nov 2026 22:22:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793964123;
	cv=none; b=jvjYqN0h6bclFPzHwwVe8F1fIG+JHU3MvyhLoUnd5fhJKADJKv8tbEPEPXbkrgAHsbfe6X1IVrxSZHZ94CwmvjHSvcJwW2azPfBwzKokxAS6jkh1M0nrS4I1KMVcteqtWGK/dQN6oj8cjX9L0laGRSvfeaHARb1ydIr9k1MlYfk/MpGQ1NFzP/aFyYh4eJmmjNaPvS/yWjDy7fjzVYYRajFrpn6V6uvcp3BVge5Td1+vw9UbTcQf+po1SsCPpNhy33YmRy+T3RMoL19o2YgLMs9dWBZ/7gcVM3wL5AwVJQDLP+0YNRXVDyq1wu1DQQkAJ5jf042oa8DIpf83wMr38Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793964123; c=relaxed/relaxed;
	bh=p+Ok2jd0IVx31NW+VHJJuf+Q+PVcuhS6OrBHlNc0X1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koLuPqlF4nbDID4RrqLCNF4PtsRskHPj7BM4pSnzY1VR5cWWIkvoQQwE9VuUhsyyqNBvXJZUMkLmWlfnyYM9ebWCX5S7KN77JEIuRhQGP/wRBmXKf/DgrR4QAIqZTR3MCh3s6j2XMo+763dZsn685KrGtd4EXMPWm1x+fsp1akc4ow7mubsXINkrzuM0DGlpqYLjKUyKTznULbDibi6CozpTKTr23qFWSJjU7zDRKh27JouXqUX3rc1S1PtNcCRZsUIwD2UG0bV8+RWr6f/rKIL3AgO6aEsb63WssbtZX/ojR/1Sm8JPg5Dn1cXoVZm4v6yKzrRfp6Slv0ikyjtXDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bK0a9SGW; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bK0a9SGW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLcG25jPfz2xDD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 22:22:02 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1C9DB4325B;
	Fri,  6 Nov 2026 11:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F931F0089F;
	Fri,  6 Nov 2026 11:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793964120;
	bh=p+Ok2jd0IVx31NW+VHJJuf+Q+PVcuhS6OrBHlNc0X1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bK0a9SGWX+VyZD0kFIiK4yNIK9A9v+An7WfGjPiMiNKuUGcrfRy/CwNqTxljrBpV0
	 U7m1a/COhNVgako5ExzfFpup8zroemN8PZasns74e+wzdmXNGp9HfFsumePkfHpqUz
	 B54avhJDK4RV1zIBmim6BKz7o7ZgZ9/g1a3ek0DWtoergphiLCDdHz5glMnik8SvAi
	 sjlHg1ttAqkP8985sWOQHptTvB9E/+p4pzQXWHiAvU6YBAJ26cTB4FDz0XEBtsF1a0
	 bgh+paL3EuS+CEi5iRnn4vYJCUV3oXHmFOJ7h5ygJmRsCVDkmI4xEURGnOh8gud8UK
	 jwyBg4yTS3zRQ==
Date: Fri, 6 Nov 2026 11:21:40 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Xu Xin <xu.xin@linux.dev>, 
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
Subject: Re: [PATCH 03/13] mm/rmap: convert remaining VMA flag tests to use
 vma_flags_t
Message-ID: <au2yhvzWy6HID8jM@gremlin>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-3-0d3cd15ab75f@kernel.org>
 <CAGsJ_4wCd_j5or0uHwPLq0PUixcXgiFim=_d7uUhUhAuQf0nTQ@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4wCd_j5or0uHwPLq0PUixcXgiFim=_d7uUhUhAuQf0nTQ@mail.gmail.com>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 11:57:08AM +0800, Barry Song wrote:
> On Fri, Nov 6, 2026 at 5:32 AM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> >
> > Replace the remaining uses of the legacy vm_flags_t flags in the rmap logic
> > with vma_flags_t values.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
>
> LGTM,
>
> Reviewed-by: Barry Song <baohua@kernel.org>
>
> >  mm/rmap.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 1131b76bbbc2..cdc97fec8586 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1196,7 +1196,7 @@ static bool page_mkclean_one(struct folio *folio, struct vm_area_struct *vma,
> >
> >  static bool invalid_mkclean_vma(struct vm_area_struct *vma, void *arg)
> >  {
> > -       if (vma->vm_flags & VM_SHARED)
> > +       if (vma_test(vma, VMA_SHARED_BIT))
> >                 return false;
> >
> >         return true;
> > @@ -1660,7 +1660,8 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
> >          * VM_DROPPABLE mappings don't swap; instead they're just dropped when
> >          * under memory pressure.
> >          */
> > -       if (!folio_test_swapbacked(folio) && !(vma->vm_flags & VM_DROPPABLE))
> > +       if (!folio_test_swapbacked(folio) &&
> > +           !vma_test_single_mask(vma, VMA_DROPPABLE))
>
> Right, VMA_DROPPABLE_BIT is not available on
> 32-bit architectures, so vma_test() cannot be
> used here.

Yeah, it's an annoying wrinkle having to differentiate, but is necessary.

Eventually we will have 32-bit kernels move to the same size vma_flags_t as
64-bit, e.g. something like:

- #define NUM_VMA_FLAG_BITS BITS_PER_LONG
+ #define NUM_VMA_FLAG_BITS 8

But that's down the road :)

Which will solve the 'not in 32-bit-kernels' stuff.

But also this form is also used for stuff that's not defined under certain
configurations, in which case you get something like:

#ifdef CONFIG_FOOBAR
#define VMA_BLAH	mk_vma_flags(VMA_BLAH_BIT)
#else
#define VMA_BLAH	EMPTY_VMA_FLAGS
#endif

And then vma_test_single_mask() is necessary too.

An unfortunate outcome of defining per-bit (so no bit value means
'nothing'), and any kind of invalid bit value solution has worse drawbacks.

In the end all this stuff will be useful as it allows us to no longer be
constrained by either 32-bit vs 64-bit or in only having 64 possible
flags. :)

--
Cheers, Lorenzo

