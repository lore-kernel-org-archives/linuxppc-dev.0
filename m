Return-Path: <linuxppc-dev+bounces-19210-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E411BCC6B33
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 09:05:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmbYF3tl3z2ySk;
	Thu, 02 Apr 2026 20:05:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775120737;
	cv=none; b=RGLyEWa2CjYN+3cmH2J6WgO7YuBVq7K/PAmFewp/tTYZ39hfcd2Gt3ny1SnDJvL2Ejw4XJIR+0vQN71tRmBRUYYKQ1JjQpIUODCXFX7sQwvEnw91tr/jgE6JEA35odpEjAhvOMbxUmeAoQ+TjFka+x72bCmJiWz1s1N1hXuGJ4/JFPBpwa7dBhRayAZ3ZGJyFySowxIXKzOLs13+CFJ2ZleS2GZL8iQYh6oguuJlN4ctxHUhflPUbKx2oPFNc/r9BxBn3KxgNaEy54vXm4pk0hMVKPe67i3SjmeZ952RSXxuFHbNj9RgyPGon2J/jW8sA2rgBcfB76pPPlVIzf4iYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775120737; c=relaxed/relaxed;
	bh=yfHUvvgXQutH0PejSYAx1kYrHzNDD4c4DofRBzeLTh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxvLDfKZ/GXsOmEu2633SNwdJdSjcmEnCBO/knbmkO3YnnU8UAc6POpUtATpijU9F4HTkaU45KQQM8rjuQEIAY5hIR0sJGlt5+iWmCiB6kwzx72zZ3rAP4nWhrKoU5UfwBSuq5SP+r4+U4tlkuYQBgYQOro3gezGklwaeqOnuVi7ngcRhpliNu0jCvPOP2SNkY9z0e8euG8FkPY4mGSDJ22ARW2L3qzP7bw4oVdXQFACyyn5cSQypj/cU7wKM0Q7C5QWMTIwjSZ1qJeC83iKggD63DCijXi5NugKbgh+EULJcmVR9hUA0dUTW2BIhbrdxX4b89zPmXNnVafjbo3c8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=efM43sZ2; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=efM43sZ2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmbYD4Hx5z2xls
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 20:05:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A35EA61862;
	Thu,  2 Apr 2026 09:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24E7C19423;
	Thu,  2 Apr 2026 09:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775120733;
	bh=yfHUvvgXQutH0PejSYAx1kYrHzNDD4c4DofRBzeLTh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efM43sZ2A/ZfqyTCE6QyXcUhTSqKNHMGoc0DNLI6pUPvzYoAPSciVsLz8B77AduZp
	 w+XxRaaVCxnlnepcfCZi93QgTadPznyIAojrLQDjc0NEs094/tdyiDFHLPVIluVQLN
	 dipx3TePpmSg2cPvw4jD+xaSFkoCNdM3v17oS7thDGheJQdmQohtZGWj51KOJ2wD/6
	 TnyzywN1U9/A1hrwLZqWF4gymmrNJb78av1IMn1MO+0ayyq6AaX/MnvziDjvFty/b8
	 N0oBHp4YsZYN9qenBb1q0IlcfJUAdtCvlC5pzag7GOrwMpa029pRCbadCwq0cnIC11
	 25jESRIAdN9bg==
Date: Thu, 2 Apr 2026 10:05:27 +0100
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Sayali Patil <sayalip@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Dev Jain <dev.jain@arm.com>, Liam.Howlett@oracle.com, linuxppc-dev@lists.ozlabs.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH v3 08/13] selftests/mm: ensure destination is
 hugetlb-backed in hugepage-mremap
Message-ID: <0a1befae-1037-4bbe-b976-352ef4607d2a@lucifer.local>
References: <cover.1774591179.git.sayalip@linux.ibm.com>
 <3b6ffba238a4b59de891acf896fa25d7d3193228.1774591179.git.sayalip@linux.ibm.com>
 <ee15d52f-45df-415b-b0d9-3d267d147e5c@kernel.org>
 <b590a17c-13ed-45f4-9f51-ac662d00e7bf@lucifer.local>
 <066a146b-7dbb-408e-bbc0-542bdcdd6681@linux.ibm.com>
 <86889304-c450-491c-8c06-48ca9c973531@kernel.org>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86889304-c450-491c-8c06-48ca9c973531@kernel.org>

On Thu, Apr 02, 2026 at 09:33:29AM +0200, David Hildenbrand (Arm) wrote:
> On 4/1/26 22:39, Sayali Patil wrote:
> >
> >
> > On 01/04/26 20:10, Lorenzo Stoakes (Oracle) wrote:
> >> On Wed, Apr 01, 2026 at 04:21:55PM +0200, David Hildenbrand (Arm) wrote:
> >>
> >> OK so digging in:
> >>
> >> mremap -> ... -> vrm_set_new_addr() -> get_unmapped_area() -> ... (in
> >> ppc arch
> >> code) -> slice_get_unmapped_area():
> >>
> >> unsigned long slice_get_unmapped_area(unsigned long addr, unsigned
> >> long len,
> >>                       unsigned long flags, unsigned int psize,
> >>                       int topdown)
> >> {
> >>     ...
> >>     /* bunch of checks */
> >>
> >>     /* If we have MAP_FIXED and failed the above steps, then error out */
> >>     if (fixed)
> >>         return -EBUSY;
> >>
> >>     ...
> >> }
> >>
> >> Is presumably where we hit the issue.
> >>
> >>>
> >>> That is weird. An mremap(MREMAP_FIXED) is really just an munmap() +
> >>> move.
> >>
> >> Yeah the weird bit I guess is that we _still_ invoke
> >> get_unmapped_area() but
> >> with MAP_FIXED set to indicate that we want the specific address, so it's
> >> subject to the above checks.
> >>
> >>>
> >>> Are we sure this is not some actual problem in the hugetlb
> >>> implementation?
> >>
> >> It seems the 'slices' check sees if the _target address_ has an
> >> equivalent page
> >> size, presumably hugetlb-mandated, and fails if they're not
> >> equivalent, so this
> >> change is just accounting for that.
> >>
> > Yes, this change accounts for that by ensuring the destination is
> > created with MAP_HUGETLB so it has the same page size as the source.
>
> Okay, weird, so it's the right thing to do to cover all odd arch behavior.
>
> >>
> >>>
> >>>
> >>> But then the test suddenly requires more hugetlb pages, no? I don't see
> >>> a good reason for the MAP_POPULATE, really. It will be discarded
> >>> either way.
> >>
> >> Yeah I'm not sure about the MAP_POPULATE being all that important here.
> >>
> > As far as I understand, without MAP_POPULATE, memory accesses would
> > trigger userfaults, and since the test is single-threaded and has no
> > background handler for the uffd, it would deadlock. MAP_POPULATE ensures
> > the test runs correctly by prefaulting all pages, but please let me know
> > if I’m mistaken.
>
> So you are saying the test would deadlock if you are not adding
> MAP_POPULATE? If so, please double check if that is actually the case.
>
> And if it's actually the case, please carefully document that in the
> patch description, and probably as a comment above the MAP_POPULATE usage.

Do keep in mind MAP_POPULATE is not _guaranteed_ to work :)

For guaranteed populate you need madvise(..., MADV_POPULATE_[READ/WRITE]) or to
directly fault in.

>
> --
> Cheers,
>
> David

Cheers, Lorenzo

