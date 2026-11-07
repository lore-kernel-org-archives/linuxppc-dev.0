Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECCB606EEA3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLeOYJRj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMRx824l4z2xrC;
	Sun, 08 Nov 2026 07:10:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794082220;
	cv=none; b=Z7WJDRMetep9jwoneq+gQh5TvWaSQKWz+diia5DKPy+58ZHcklac6H3NQGKL8KO+imWjfn9ipVeaiZLVXScyFVG4xzzHmHXFhr+XaD74EoK63zFXXFb+jYejy5iaaDNhycaixUUvJCvLUeGpKY8MVzyGR/ffold+zB7n2brTzCrKRUBmvxf7o+n66fd8SzrRDTaHmVm8p+YSpQ67tKSiR44dv1tATigScOuJmdEjyA2ehPt+7PS5dwubYllq+kjgZzTisHqpXj7YHGFixA/qDGs5FIHhOYmyEuH7wXwBVufozTgebQgp7pUdNa+zY4zXTP6k9dKruENYOcknmgnZqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794082220; c=relaxed/relaxed;
	bh=CMFxkbGnr/NpLAXZXk8rbwy5EGs+66IVJk9lKIVoNp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdoltZvgHu6ikYEET9HjS5KvbeGaUHZyaj1RXy/y/D5EJ//boPV7WqDnjY2LYgXRcnTgGCPjCVPQ5EeQpU9MQggTkiYvwP+YC9hUYqaUn/CXvQCz/18hI5pggonXulYg9OkTzQORW6JgZ+HnIywbjY8PoIFyro6k5YVKQi6JMnWvb7IghbfrYoW61dJFKFkdtCaeasmEHi2+sWlVCDL9NwPFIEQRp2YlWoRMRum2wHFFENBTl47KF/tHoZQijb1ZlTlKh731tsCXjNBYTU4T04JVFkI4FdioVfTT1EFZQDRUObcCAmC5z4ksmzWhnbVaTu05knEVtvFjASZRh1cYLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLeOYJRj; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLeOYJRj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMRx70T7Xz2xRm
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 07:10:18 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A843261189;
	Sat,  7 Nov 2026 20:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D661F008A3;
	Sat,  7 Nov 2026 20:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082215;
	bh=CMFxkbGnr/NpLAXZXk8rbwy5EGs+66IVJk9lKIVoNp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iLeOYJRjjnhZl3LWMSGaUd1S27vEBJh9NrDzelAqlZmg4R2RciRfWoeIsojODwzqH
	 AmV3EGrrSvx70iXnLVmV7/bs2dBDE1x/r3nyPcxADmxBtch4xZP+oTaqLUfx+eYAuG
	 SGRWdAxli2sYIZwe/Tbuw0udh+c0QNfiwmJOXLSfQKYp1etxVNRgoDq0IPlAd0lt9t
	 yDMA0BPoIWju9BFMAW7mO+dutMm2GHuzj6pjWBP8PMNdT9kLO2lCpBJij+NhIf7LIF
	 N/2SXcwPj4meyprPc8KlcX/gZ5yZ2cdhj422kyiEPIrnEjIKnHoNmFfhk++nuATcLn
	 UZoP1hyr/4Jww==
Date: Sat, 7 Nov 2026 20:09:55 +0000
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
Message-ID: <au-DXpEi4wHwsz0r@gremlin>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <d0ea7929-7c12-4245-ba3f-6dd5c0269e6b@kernel.org>
 <au3r0-geuwtRYPiC@gremlin>
 <1c0b1368-a381-4b25-bba9-7a4f8e92b764@kernel.org>
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
In-Reply-To: <1c0b1368-a381-4b25-bba9-7a4f8e92b764@kernel.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I think we're slightly talking across purposes, so to be clear - I am totally
fine with you taking any of this through your tree or whatever works for you and
Andrew to avoid merge pain :)

I was just talking more generally about how to merge series that touch a lot of
subsystems and maintainers-who-may-never-reply, etc.

These are the edge cases that make things... fun :)

Anyway, I guess easiest resolution here is for you to take the bits that belong
to your trees and Andrew takes the bits that belong elsewhere?

I don't think anything here has an inter-dependency.


On Sat, Nov 07, 2026 at 08:26:29PM +0100, David Hildenbrand (Arm) wrote:
[ ... ]
>
> Because of [PATCH 05/13] mm: convert THP VMA flag tests to use vma_flags_t which
> is THP-only, and feels like it could go straight through one of my trees,
> avoiding conflicts with Andrew's tree. But maybe there is more to it that I am
> missing.

Sorry about that! Please take that through your tree.

>
> I assume stable topic branches would fix that, but they are currently
> unfortunately not on the table ... :)

I guess we need everybody-on-git for this!

I guess when Liam and & I have the VMA tree we can do that at least for stuff
that goes there :)

>
> >
> >>
> >> Ideally, patches really only touch one component.
> >
> > Right, but sometimes functions are declared in one place and called in
> > others. It is impossible to change the signature of one without also touching
> > the others.
>
> Yes. Something like that is unavoidable. Or if you need new APIs/

Yes.

>
> >
> >>
> >> [PATCH 07/13] mm/madvise: convert madvise_vma_behavior() to use vma_flags_t
> >>
> >> is all over the place :)
> >
> > It's not really all over the place, it's converting vm_flags_t to
> > vma_flags_t across madvise.c, which involves changing a few function
> > signatures, whose callers must be updated.
>
> Ah, yeah. What on earth does arch/powerpc/kvm/book3s_hv_uvmem.c do with madvise :(

Yeah it's quite worrying that... :)

>
> >
> > I could split it up into 3 patches where 1 does internal-only, one changes 1
> > function, and the next changes another, if that works?
>
> No, these things really have to go in as one unit, no need to split that up.

Thanks, yeah, it's a pain I know but eventually 'one fine day' (probably in
2028) everything will be converted to vma_flags_t/mmap_prepare and we won't have
to think about this :P

--
Cheers, Lorenzo

