Return-Path: <linuxppc-dev+bounces-22921-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E38DCDB470
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 08:43:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkz9H0nk1z2y71;
	Tue, 23 Jun 2026 18:42:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782204179;
	cv=none; b=ZPg5lAvpm99c0/nXDhVJ1BYMn+vThFcm/bWdfMqgrxZqKF3g+BMiLrVrEqlSTwNoiiQ8pDpAgwZdFLzdh741kY4yIXxhE9Ib0ZIK9o4cB5HqrB+monQUGBYGRW0CPUB/xeLEhapMBo9haBigm+EL+N+FHX48SlRCozFSYIewQ2OBHmSh2WC2uyyIazVT0diUEK2PfsNclfJ4epou88yb3SfkArB9PheBxsqt/qRge5w2V06yBn216H4u4W8OCezw7/N70ahy5wzlepAmXjfnfw8sqZ5Hf+7Tn2HKfm5DX/AW+yv3H3gkh9BhuAnObJ46up1VysnaknmGBr9iZJAZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782204179; c=relaxed/relaxed;
	bh=UFt61Kzusvt5l7Yt4iU4ICngyInau9SaQcqREiJkKOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fo9Bs1its+/3dX9g0eHoKaRnfK7ttN2pO/uLXJ8NkSIDg8CF44xIF8cRAFo5uDzjk/BnRV9m5unEJrTHf6lbqzJGk367QEKubOujmF0IblOs/Bgae6zs7+bNawOJC8UGxvjtln/m7cgZIGMfyUaA2po8AuY6Rk6XWfWD5ZRJtUxEU2BY/A9ysr7QKkMbHfmB/j3EQweIbRv2SGa5zDa48EgLkFGTaBNQ5vdNeJDGwf/GVay4DL3FvYVpOrTj6u0tHxt/HxH+JfxOrJ8AmtBawss3EtNs7wXDFLPlDr2+UmxM0TNO5c8jjDE81fS9cA0ByQvKH6OgrJ8d9lhvKo+z5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjnU+52t; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjnU+52t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkz9G2bV2z2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 18:42:58 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B0D2F4372C
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 08:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946141F00ACF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 08:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782204176;
	bh=UFt61Kzusvt5l7Yt4iU4ICngyInau9SaQcqREiJkKOQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mjnU+52tnCf+Xf0ZcXLqFRqjyyuJ4tAn68qH7cJFRCDTylR/xORmKTOULuwVtdGBH
	 FGdoCU505hWRSwKJyuA9nVDj7NY4+UNQU8A5hDMx0rqyQ7xnLP9MhGBffx3Q4Wn1gc
	 boBjWoWc7AlpObFYJZdWfxSgt4dE17IUmT8Jcf0ojRb/ytZh1ebm0ritaSaeqp4vua
	 wBuILWfLfSQyU+LV2gACiRiarhELXFn7j6IGP2+t+Dl3Gc87aG9x+Bk8MGzMz+/As9
	 2x7JCrtl3r+0Ia7SErX4ZIvYeUZ0kNfOVxEBDBIjcV98Ro+xUjUOq4TQN5ebTicXQw
	 DsCx1ai7GdPrQ==
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92542fa7d07so82330285a.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 01:42:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/7lbhxynkcKA3lhWOqk9AVtmjii3qgeGVHbEUtp+KNVoL1jsd+/VZGx5INVwqO0MWpQ5pONoS/zBYU37k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx5GR+HEyg9x51fzRWk07up3puYN0JIpYzNf/qmhUh4meBrdaZ4
	EvEC1sWF3ufIC3+5EXrDTFtvkxVrzNDWe7JpzwmCcZXuCHydc5oGBxWQBpNcSTXP1mFidEieobv
	fEGogHBGMt5LoJLQdhRgqZS6RDPKBtso=
X-Received: by 2002:a05:620a:7208:b0:922:479e:3e4c with SMTP id
 af79cd13be357-92602308e33mr369251385a.26.1782204175998; Tue, 23 Jun 2026
 01:42:55 -0700 (PDT)
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
References: <cover.1781843449.git.ritesh.list@gmail.com> <eda4e51ee9f1270582fbb2823ec5873e769de089.1781843449.git.ritesh.list@gmail.com>
 <CAGsJ_4yTY8g3M7qmpM7HeUq=E05e7v_QFTzk=2D5Mv3Vj3Usqg@mail.gmail.com> <33ydyd82.ritesh.list@gmail.com>
In-Reply-To: <33ydyd82.ritesh.list@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 23 Jun 2026 16:42:44 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zZBf2dGjG2SF8VkwwaYm-oFpmFEJ+Kx5-DuNk0ez7xbg@mail.gmail.com>
X-Gm-Features: AVVi8CfZuCW69WQalFY9UHNfppKh8zYKqZFY_JiowJ3XQDEH5PVphCNkHnGHWP0
Message-ID: <CAGsJ_4zZBf2dGjG2SF8VkwwaYm-oFpmFEJ+Kx5-DuNk0ez7xbg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm, swap: allow archs to override SWAP_NR_ORDERS
 via ARCH_MAX_PMD_ORDER
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linux-mm@kvack.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Sayali Patil <sayalip@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 3:05=E2=80=AFPM Ritesh Harjani <ritesh.list@gmail.c=
om> wrote:
>
> Barry Song <baohua@kernel.org> writes:
>
> > On Fri, Jun 19, 2026 at 12:41=E2=80=AFPM Ritesh Harjani (IBM)
> > <ritesh.list@gmail.com> wrote:
> >>
> >> SWAP_NR_ORDERS sizes a few small bounded arrays inside THP swap
> >> allocator code (nofull/frag cluster lists, percpu_swap_cluster's
> >> si/offset arrays, next array for rotational device). This currently
> >> expands to PMD_ORDER+1, which only works when PMD_ORDER is a compile
> >> time constant.
> >>
> >> However on architecture like PowerPC Book3S64, PMD_ORDER is a runtime
> >> variable which depends upon which MMU is selected (Radix / Hash), so i=
n
> >> that case, PMD_ORDER cannot be used to size the static arrays.
> >>
> >> This patch provides an optional ARCH_MAX_PMD_ORDER (upper-bound)
> >> override for such architectures. The memory overhead on enabling this
> >> override is negligible. Even if we make SWAP_NR_ORDERS runtime alloc,
> >> default slab padding could cause some memory waste. Also we lose the
> >> per-cpu cacheline benefits (for percpu_swap_cluster) because it might
> >> cost an extra cacheline indirection overhead in swap_alloc_fast() for
> >> fetching si[order]/offset[order]. Note that a fully runtime
> >> SWAP_NR_ORDERS was considered in previous version but was dropped for
> >> this reason [1]
> >
> > Do we know the maximum PMD size?
>
> ARCH_MAX_PMD_ORDER will be 8 on PowerPC book3s64 with 64K pagesize.
> PowerPC Hash MMU with 64K default pagesize supports PMD size of 16MB.
>
> > On arm64 with a 64 KB base page,
> > a PMD can be as large as 512 MB:
> > https://docs.kernel.org/arch/arm64/hugetlbpage.html
> >
> > One concern we have is that performing I/O on such a large folio could
> > incur significant latency before reclaiming any memory. For this
> > reason, on arm64 we initially enabled THP_SWAPOUT only for 4 KB base
> > pages:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dd0637c505f
> >
>
> That's not the case on PowerPC. Max PMD size for Hash will be 16MB.

Yep. A 16 MB folio might be fine, although I'm not sure whether
splitting a 16 MB folio into eight 2 MB folios would help much.

For 512 MB PMD-sized pages on arm64, one possible approach might be to
split them into 256 =C3=97 2 MB folios rather than all the way down to 4 KB
pages. That could provide a better balance between I/O latency and swap
performance.

> Also we still need this patch since we can at runtime choose Hash or
> Radix MMU. So, the main problem this patch is trying to solve on PowerPC
> Book3s64 is enabling this feature w/o impacting any other architecture.
> W/O this patch series, we can't enable it, since it gives build errors.

I see. If possible, please mention in the changelog that the maximum
PMD size on your platform is 16 MB. In that case, the I/O latency
concerns I raised may not really apply.

w/ that, please free feel to add:

Reviewed-by: Barry Song <baohua@kernel.org>

