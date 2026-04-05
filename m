Return-Path: <linuxppc-dev+bounces-19383-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3733E9D828
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2026 23:35:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fppj70DTLz2yT0;
	Mon, 06 Apr 2026 09:35:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b130"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775432106;
	cv=none; b=RMp5NiA1wuT0Vo2MUfQx8VrDjsFd+ztHxp9cyJhk2nuLBoQLbftqYE595u1EYn32ksyeJmmhp4KZRHdU93wJCQKHMdGP8V9AosRDH3VwuQvSGjSRo+uO4kbq5xqT8or7pX1GgQ5k3HekUGa7nW2fXJQC0TS53oEpbWJZsl+x9DOc4dfuRZJkW3qIdUOXBneOLumsEeQJiXMCXThdkRwt5+UvYVHgJD9/AWOht6QgQZWRFCP1gr0mTA3OoMfGjEfTc6+wGdOZTAo7nhLqRMaRJG/inIPZI75A6rzXRADCGsRixUglNCo1JdGtbtumCDiZb+gjnMogtMDs6iJxb7OLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775432106; c=relaxed/relaxed;
	bh=Lzm3/9j9sm7zHb61fOGxB4CuuzgAL6dQcGBwWJvxxMk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AMczI1DsyDqk2mKBon7kUnucTf5wxC0XlW+ZQa0fcbuX9cV6FxCtj6e68MaOmZvgZdCMDTT1gV4Gg6vFiK41m4igdgeEfDcaiPqv08Itbe1J3u1PXMpt4nND6Oht7GHi21ZEuIrlt3WPVT5bCC66hvDoxq7S57nSiKyQVi358Y5Jwg97UqF7DI2yRE6mJnDeb935lXPubi9kBWti6TW62zO87cBRlqoW6KH8BV63+neB3uM3LjVGyEybBikTYo75Flt0ZDMg3gah4V0LwauNDVQVLX8TswR9wM2MxBjtEaY4v6kOYPppHsKtvAvM786NjY/Q32g45Qnj8uz1GRYwUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VZ7Zr7Ou; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b130; helo=mail-yx1-xb130.google.com; envelope-from=hughd@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VZ7Zr7Ou;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::b130; helo=mail-yx1-xb130.google.com; envelope-from=hughd@google.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com [IPv6:2607:f8b0:4864:20::b130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fppj51S1Jz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 09:35:04 +1000 (AEST)
Received: by mail-yx1-xb130.google.com with SMTP id 956f58d0204a3-650182d19e0so3843158d50.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 16:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775432102; x=1776036902; darn=lists.ozlabs.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lzm3/9j9sm7zHb61fOGxB4CuuzgAL6dQcGBwWJvxxMk=;
        b=VZ7Zr7OuZ/ixOcapiQd1z4CspKtyrthWpZ/1T7nfdDGW8pqIyn0yTh1tAQDp0+25uF
         dPX+QprYlouPoCdWqifPB4/7bpAvfK27C4TTF8kfz7DxuYq35G+f7+yl+rUKH1sEI3d2
         UOznwXOBNxpkrQmHMaXbyfIREd1luvVpqX2YmnxuGxC9Cxq5W6RVG09RtdW5bq1XrpVD
         FeFLHgCfl8tu2HuNHWXwoWpge4xBcxWZEWKCq2lFjqZT1mT9gid3MBOno134k6TvKuQW
         qiwXrH1HP5d18GOKMIcrz2eN6FHN1iCglU4FU0L7rwJdhjBOIyqaRdGmcD4VpqN/g9Te
         BLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775432102; x=1776036902;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lzm3/9j9sm7zHb61fOGxB4CuuzgAL6dQcGBwWJvxxMk=;
        b=iV5T0NClMww6DsDwQbMEqZtT6sNL/aUPtpNJk4BZ2EUmBXPHuwfWBhKCEvxfjNNgQf
         OHrsKnCnVg9THfYjTWIJdzfqXQhC6dx+w6MXx4fQtHdwRQ9Yd7TZBlgnV4p4gVbBKu7c
         71a8WnkHDRsX+6zwaBg5myJzpDYUtUsuJNWqppNlwdi9dZAjR+TunI0auzvkmzZF8pmR
         58Bc1TtyoX20MuDW1fmOaLbtk0AfSqKztuRcWX1VUwUTJ5h13zSh1VSt5osiX5z+KmQf
         stpqq6TKDhdYalsmUKCUN33sRbi8su9S+dks74rM7LHphptrmRfXBnGFlXMP2kMcUsmF
         RmSA==
X-Forwarded-Encrypted: i=1; AJvYcCU5HOV9GjzOgMxLwr3OXqEVkyXQ+hQilROhDqNgx2iAzbONLf2FLIwsshxtF0QQsVPfYjBHUFZ7H3tRQTo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yytj6sf0OufUUE2iiBNT8Gs3DrdMio07FpFSl7V1Slxxx2N+GLZ
	fr+Ji4GTprdTvIAzXLA3+1dRvQjhmaLiTOAdAK4wJyXwshmknlj5pE6kU1So/P0m2A==
X-Gm-Gg: AeBDietg4iZYogJvs218Nc/j7f4NniEboX+jZkFDCyNZNPMxcwBVlpxd3y2ABzC2vK+
	1rxeVga/d39xVEngJWpf6aN1qfa1LotABflc2QxNj8Wi9ZlXsze6wZiwHReszht0ft/U6woTgOq
	TDOb/4SpUS9AYaux9+caHU3UWL+2VvFdmzxW6sWwy8CDuGAO6+jhtcsJdGyjUim92SriLThpICg
	/Oazddfrxu10rdaKeerrRkxUKZwdzUBtOkWLB4+6xXz3zIFqOFPhXoQH9MIwyKwo3G5019BKgi0
	Ple4y7S8I/2UyTuc6XME5g6E2wHkfP2xGlOHnyXNvMw0fwaujWH1KI6QY0FHuN6eKkyHnPKhVEc
	1vWwhEhpJSp1WfKB/LJsQ7ptn/wjavQC2ABLfTvZi0To3ui48pXtr2m3p0i/2xaWM2zOgOzMC5l
	+wtrxXRg9ucclEV1IBFDVpjfwyRrDnvScAOPWhYKw904fJ0JN1CxrVxcgQUKy2Brbx1WaVj6hZP
	2u5h8eUCg4=
X-Received: by 2002:a53:b009:0:b0:63e:2715:5ac6 with SMTP id 956f58d0204a3-65048828b7fmr7933343d50.35.1775432101086;
        Sun, 05 Apr 2026 16:35:01 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a83adc3sm5317274d50.5.2026.04.05.16.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 16:35:00 -0700 (PDT)
Date: Sun, 5 Apr 2026 16:34:46 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Usama Arif <usama.arif@linux.dev>
cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, 
    Lorenzo Stoakes <ljs@kernel.org>, willy@infradead.org, linux-mm@kvack.org, 
    fvdl@google.com, hannes@cmpxchg.org, riel@surriel.com, 
    shakeel.butt@linux.dev, kas@kernel.org, baohua@kernel.org, 
    dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com, 
    Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
    Vlastimil Babka <vbabka@kernel.org>, lance.yang@linux.dev, 
    linux-kernel@vger.kernel.org, kernel-team@meta.com, maddy@linux.ibm.com, 
    mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, hca@linux.ibm.com, 
    gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
    svens@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [v3 00/24] mm: thp: lazy PTE page table allocation at PMD split
 time
In-Reply-To: <20260327021403.214713-1-usama.arif@linux.dev>
Message-ID: <6869b7f0-84e1-fb93-03f1-9442cdfe476b@google.com>
References: <20260327021403.214713-1-usama.arif@linux.dev>
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
Content-Type: multipart/mixed; boundary="-1463770367-802286629-1775432100=:17421"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-802286629-1775432100=:17421
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 26 Mar 2026, Usama Arif wrote:

> When the kernel creates a PMD-level THP mapping for anonymous pages, it
> pre-allocates a PTE page table via pgtable_trans_huge_deposit(). This
> page table sits unused in a deposit list for the lifetime of the THP
> mapping, only to be withdrawn when the PMD is split or zapped. Every
> anonymous THP therefore wastes 4KB of memory unconditionally. On large
> servers where hundreds of gigabytes of memory are mapped as THPs, this
> adds up: roughly 200MB wasted per 100GB of THP memory. This memory
> could otherwise satisfy other allocations, including the very PTE page
> table allocations needed when splits eventually occur.
>=20
> This series removes the pre-deposit and allocates the PTE page table
> lazily =E2=80=94 only when a PMD split actually happens. Since a large nu=
mber
> of THPs are never split (they are zapped wholesale when processes exit or
> munmap the full range), the allocation is avoided entirely in the common
> case.
>=20
> The pre-deposit pattern exists because split_huge_pmd was designed as an
> operation that must never fail: if the kernel decides to split, it needs
> a PTE page table, so one is deposited in advance. But "must never fail"
> is an unnecessarily strong requirement. A PMD split is typically triggere=
d
> by a partial operation on a sub-PMD range =E2=80=94 partial munmap, parti=
al
> mprotect, COW on a pinned folio, GUP with FOLL_SPLIT_PMD, and similar.
> All of these operations already have well-defined error handling for
> allocation failures (e.g., -ENOMEM, VM_FAULT_OOM). Allowing split to
> fail and propagating the error through these existing paths is the natura=
l
> thing to do. Furthermore, if the system cannot satisfy a single order-0
> allocation for a page table, it is under extreme memory pressure and
> failing the operation is the correct response.
>=20
> Designing functions like split_huge_pmd as operations that cannot fail
> has a subtle but real cost to code quality. It forces a pre-allocation
> pattern - every THP creation path must deposit a page table, and every
> split or zap path must withdraw one, creating a hidden coupling between
> widely separated code paths.
>=20
> This also serves as a code cleanup. On every architecture except powerpc
> with hash MMU, the deposit/withdraw machinery becomes dead code. The
> series removes the generic implementations in pgtable-generic.c and the
> s390/sparc overrides, replacing them with no-op stubs guarded by
> arch_needs_pgtable_deposit(), which evaluates to false at compile time
> on all non-powerpc architectures.

I see no mention of the big problem,
which has stopped us all from trying this before.

Reclaim: the split_folio_to_list() in shrink_folio_list().

Imagine a process which has forked a thousand times, containing
anon THPs, which should now be swapped out and reclaimed.

To swap out one of those THPs, it will have to allocate a
thousand page tables, all with PF_MEMALLOC set (to give some
access to reserves, while preventing recursion into reclaim).

Elsewhere, we go to great lengths (e.g. mempools) to give
guaranteed access to the memory needed when freeing memory.
In the case of an anon THP, the guaranteed pool has been the
deposited page table. Now what?

And the worst is that when the 501st attempt to allocate a page
table fails, it has allocated and is using 500 pages from reserve,
without reaching the point of freeing any memory at all.

Maybe watermark boosting (I barely know whereof I speak) can help
a bit nowadays.  Has anything else changed to solve the problem?

What would help a lot would be the implementation of swap entries
at the PMD level.  Whether that would help enough, I'm sceptical:
I do think it's foolish to depend upon the availability of huge
contiguous swap extents, whatever the recent improvements there;
but it would at least be an arguable justification.

Shared page tables?  Generally I run away, but perhaps
manageable in this limited context (a store of not-present
swap entries, to be copied on fault).

Hugh
---1463770367-802286629-1775432100=:17421--

