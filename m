Return-Path: <linuxppc-dev+bounces-22915-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF77CDB470
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 05:11:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gktT25JmSz2y71;
	Tue, 23 Jun 2026 15:11:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782191478;
	cv=none; b=gkwtvXVq0mPdO2QItXmBuTH++qavBMQgaBw8+Ci0l9mOhUjTmVYuVuqiDAGdbwax1U7FnFYcwPys0ZDT1J8Y7Gm+fmRsSzF9xzSMiIYgY5JXdpomk3RUPp7R3d4IhIO/yi+qktrYyySvsoxd/9PtTVU5hW4HfGfwjDA9LyBXX1vHlEuSv5fuYg7iD1WSliARYaciBzB9mqFsuyoxSR+GZLgl9TAY+l3WzhHV26/JMf4ci5eAjlLl8jons/z0HYM9lsbHnahjSJ6bm8nBh1AcVbZI1ogA5MmrbB23eHLbKyYtxI5y5zmLElCd5qhMpz2vlP/igWa2WwrfcXWIO25a4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782191478; c=relaxed/relaxed;
	bh=q5Sf1Z9xRL9LWcd2ZET1VjKqMFRzCniZR0mElMq/Kvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPjZfVSCi2nw5GLd5cQP31F3qE8/t3zy9wyDG0Bx6l6NXU6XODsMne3HMWEW570WwBqdJhHADRRTtb7DX0hnI/pc1jRcaFwU2G/eNsPNZhOpdKnVR1695ctsy8WnHwt5tuMnK2Ypk7PeE3pE/cSHjk3jupXj0Bzt45hPr338lhNUPhkWet8uWZ5JZD7cY+PYmswRPJiQXZ4HY6CrGp+rOgcdF51gu2n+iEdtMNrdNsIF0Fijk8wZIXGr/TYW6KEAaR7yYKCt/tp5BOIjtpVQoS02lnHzj/YHUEU9tc2VpjWnGRPAAh8Ov84gHzTllHeuIZQzqAHeVDkKF9PcCIGVTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+kehgXJ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+kehgXJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gktT11LfDz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 15:11:17 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DB60F444D2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 05:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E851F00ADE
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 05:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782191474;
	bh=q5Sf1Z9xRL9LWcd2ZET1VjKqMFRzCniZR0mElMq/Kvc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=m+kehgXJ7IJ9wyrAyKxGHr8VzJe07qU/W8OBvjpMn/5iEYqb/+5sfphIj3lZS702Y
	 hiGkYLpSsPCndvRe6S8QWWieAf3MLKGo+JvP6M5nIfz1p1BepTYGAptEVwJZ5PxIeP
	 dtHkl8kcPP9tzWpK0FL6XP1p6hMwCsikohm8IWVxrXr6uxzrMqEwOsbDlR81Ef9cLF
	 5BWf8DM7KZs66eDqzxX6aj4QM6+mQq1eR7/Sb+VNDoolkty8odjYiGXmw5fokKorCL
	 k0CWqjXiRcUCWugG8id9MEGY/MoM1Tw8o5TCTKAEtTLQxlBfr2kVHQld8BKG2aY0QV
	 0nM5lDNwTusVA==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9204711e831so448709585a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2026 22:11:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8UgRstwMFZznjkWs9yodBrfcFkhwplwPdh5g8LRfujx65RdQQvzdTx/5OeAOYEHprppVqjSlJSGuEubPY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzbrBASV0DCdOMdz/diFmi4l+1YodN3k8Ed2jrKRkSBCLU8W0k2
	UKtx/hPAC1ssKjp0t9lC1J5dQxl2n684PBtsnABZ/ARa98DFt2wTPHyT+VK8yWVaHCiESbJE7GY
	bRjCNObY97m01iCzPq4ieFuATb3qjXG0=
X-Received: by 2002:a05:620a:261a:b0:911:9a7a:8076 with SMTP id
 af79cd13be357-9266b97e8eamr160228885a.8.1782191474145; Mon, 22 Jun 2026
 22:11:14 -0700 (PDT)
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
In-Reply-To: <eda4e51ee9f1270582fbb2823ec5873e769de089.1781843449.git.ritesh.list@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 23 Jun 2026 13:11:03 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yTY8g3M7qmpM7HeUq=E05e7v_QFTzk=2D5Mv3Vj3Usqg@mail.gmail.com>
X-Gm-Features: AVVi8CebkszW_dJseo4N-w7zaazQK_GJnKVeR7lxEzBiOpulB3NIjYM7MC4L4Kw
Message-ID: <CAGsJ_4yTY8g3M7qmpM7HeUq=E05e7v_QFTzk=2D5Mv3Vj3Usqg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm, swap: allow archs to override SWAP_NR_ORDERS
 via ARCH_MAX_PMD_ORDER
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
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

On Fri, Jun 19, 2026 at 12:41=E2=80=AFPM Ritesh Harjani (IBM)
<ritesh.list@gmail.com> wrote:
>
> SWAP_NR_ORDERS sizes a few small bounded arrays inside THP swap
> allocator code (nofull/frag cluster lists, percpu_swap_cluster's
> si/offset arrays, next array for rotational device). This currently
> expands to PMD_ORDER+1, which only works when PMD_ORDER is a compile
> time constant.
>
> However on architecture like PowerPC Book3S64, PMD_ORDER is a runtime
> variable which depends upon which MMU is selected (Radix / Hash), so in
> that case, PMD_ORDER cannot be used to size the static arrays.
>
> This patch provides an optional ARCH_MAX_PMD_ORDER (upper-bound)
> override for such architectures. The memory overhead on enabling this
> override is negligible. Even if we make SWAP_NR_ORDERS runtime alloc,
> default slab padding could cause some memory waste. Also we lose the
> per-cpu cacheline benefits (for percpu_swap_cluster) because it might
> cost an extra cacheline indirection overhead in swap_alloc_fast() for
> fetching si[order]/offset[order]. Note that a fully runtime
> SWAP_NR_ORDERS was considered in previous version but was dropped for
> this reason [1]

Do we know the maximum PMD size? On arm64 with a 64 KB base page,
a PMD can be as large as 512 MB:
https://docs.kernel.org/arch/arm64/hugetlbpage.html

One concern we have is that performing I/O on such a large folio could
incur significant latency before reclaiming any memory. For this
reason, on arm64 we initially enabled THP_SWAPOUT only for 4 KB base
pages:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dd0637c505f

>
> [1]: https://lore.kernel.org/linuxppc-dev/pl1zdksc.ritesh.list@gmail.com/
>

Best Regards
Barry

