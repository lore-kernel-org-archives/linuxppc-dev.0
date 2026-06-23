Return-Path: <linuxppc-dev+bounces-22917-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B85CDB470
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 07:05:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkx0m3wjpz2y71;
	Tue, 23 Jun 2026 17:05:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782198328;
	cv=none; b=IKhBv1IEvzI/T0OzjPRCkv3VLy/G/aWEFq1QCWZ6h7p2Cu2+r86MIgnhXuKiSxHWQgK+IlZnIyqDTNNHQLAKCmJ6JGe4/zeQusqBYrLNJb+DJwl2Ai2quZqjjJqsjAaVSGXVY3tAg1ozvhhxXY/jS1Pt0hoYH0D0TNw4OYKIcoqQnGS7u1L4yoQwQwtRF9oHVTTRBhLHP0fyvjXChpFJB/T7t0AI4Ghymp6CJ8T2GCaKYric9m97ZH1dNwIWvsysLiIT4FJOMWMEDkv5DYPjGf1nNJ3Glmkv8EdRUbrEIdgMwHCC+ff40mpYJCIvGS8XRTrgWCuA1pD2+iTsSy0xkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782198328; c=relaxed/relaxed;
	bh=2edlHoTARK4XOwJQhEgs4zRuOW2bg9kGCtX6ZMXliKU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=DAHFeW4kx8T1GnGgALtDxhmlX7Ej9mtDvmVQRazGvapXRUERDqbKJY53z0RbChEkDn+i6jT13m1ktC2zu8MMc4MRXOXyZdFXmIRo1oe4DDxayy+5o0ujloGA1uGH6nQ5dojfQgmmjOUXekwWyBPs+jFk6/ee0CulGyIR1PS1frBqd6kgxLR2N4TTTomGRyPHM8Gbf7muWyLDyx8quqdJg5M/PjwClJ3nb9bCLBGNH038TDjS9pZWh7pjObGRAkTgMQ6+YqGj/5e0W03/nt3lKEEp5WReTRcrZ+0izwgshLWnzeE+9Ms3X5L799NRUq2YjaffJikIEBvuiSNP0QR4uA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gs8Msw/C; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gs8Msw/C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkx0k4Sswz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 17:05:25 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-845369f60faso3133771b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 00:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782198323; x=1782803123; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2edlHoTARK4XOwJQhEgs4zRuOW2bg9kGCtX6ZMXliKU=;
        b=gs8Msw/CIcDDslc/5bO0vGhY/oO5e2mjRIJgXCJT3bk7clDSWDX5irlcF+vlCo9XKj
         YsJyRfhaX/H7zsUeTFJfVHvdvxaKhFdOS/7fnb9MVqEGVLwq/+oQMweMb4ydm3HXgcvV
         qyULH9OEFHTGQ0ma4b4rqnu8Njbh1T23Y3b3QFpP752k1R/yOe/6IK7Kk9slzOJaoE4m
         A8m71yP4rxZsVcHww83zcth2+vja+HPT2XS6Ujc+aoKZrxdEQC5E60GwQ5MpXeJ9o4iQ
         jSJE555QdJ1TvxCU6gJ6jR2+ZvNHxgaphIh3rAVR65uKBlf4qOJctSkh5vkEVDKihr6l
         nyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782198323; x=1782803123;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2edlHoTARK4XOwJQhEgs4zRuOW2bg9kGCtX6ZMXliKU=;
        b=ETkrGZw/1WfAaJ/o4SURHI6tZnsjgrOPVyzGaRH4s58YULsXgagaBXsjTG1Pr5NXRd
         yyPhnIBLIaNNGe1lZg3ApiPoJSIuvQnxRTPx9ZZAT9MZgueLgtr1rVIAHHjTTqg1JIw+
         KVt664Yv/jQcicwovLhaHOnnxE/uko0EBkq6fccjyVUOq7N3Lm2mP3z9MgyYY+ChLgix
         vLwhzIbhZ0kkVojXqJqM12V9ORIr51W4KRVVSIttUDM0W5SgGGR7tBipH6Rm29+I8g8Z
         6CNQnEJl60t052eCup4p+F5K+VWEOxFM35OeCBi0JUpA9ztpz20ANfS+FpwJ9o38L4Jk
         JVVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Q8hjI/DtDXHzwQaEBo622wIS3ojlZkxFpF1i79Dbm9ickYV3VZYHGzyeLnVVub0eE0b8QpXX4RtRnLMw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxp2QOMNpwp0OvEfe8xfmDI1JsSjVIl+XGtZNYI+BPv1haKAHU5
	8oOCMLisKVAkujxjuZc/jA4DIkJCsD+t9rgFCWmzvt9fhMpfES3RdYls
X-Gm-Gg: AfdE7cn+Jy+AmYy9oGB33GAb5aY1I7rktCMC5KGiJa3jyk4pQMhDXq2fdf4pC9DjkxT
	R87zgHwg7JZLow9xGCKFK9Xf3mkAiDj0SitpTyWbh8Mhcgcf4MlRhyNKFAMnMkAf3O4yNrtTdfg
	p3cyQRVVgtqFdQrf166svxeGKmDjiwFjHk3Ay6GazIID/Uvss5c2eXJN1jL24fmXPbIogg74OU4
	geeRBfeimkgfPeQoq9UoqB+Q+XLGHWDJ3UrqNNVUS/IqEOno8yxHAk9lIsOOedA17zVOAKFeXHz
	kO/kW835cTGqjY6+1PlEw57qj6VegxE4qfo4T8Cr3pmiZRQ5/HjaCkmRteIrxcsY470fBegc2G0
	vnr8YlY/NjQ8/0ld37tkybnfNmh0p7T6bH7UCIS1SWEL3jxbaohSrYfkiR37Vcu9O9SHJdL34Ru
	U6G9rlQ2c7R4Y5dGRKTkrBCF2kDA==
X-Received: by 2002:a05:6a00:3492:b0:82c:d7c4:4c5c with SMTP id d2e1a72fcca58-845507edeb3mr18744789b3a.20.1782198322868;
        Tue, 23 Jun 2026 00:05:22 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d8f1a1sm10912023b3a.18.2026.06.23.00.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 00:05:22 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Barry Song <baohua@kernel.org>
Cc: linux-mm@kvack.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Sayali Patil <sayalip@linux.ibm.com>
Subject: Re: [PATCH v4 2/3] mm, swap: allow archs to override SWAP_NR_ORDERS via ARCH_MAX_PMD_ORDER
In-Reply-To: <CAGsJ_4yTY8g3M7qmpM7HeUq=E05e7v_QFTzk=2D5Mv3Vj3Usqg@mail.gmail.com>
Date: Tue, 23 Jun 2026 12:07:01 +0530
Message-ID: <33ydyd82.ritesh.list@gmail.com>
References: <cover.1781843449.git.ritesh.list@gmail.com> <eda4e51ee9f1270582fbb2823ec5873e769de089.1781843449.git.ritesh.list@gmail.com> <CAGsJ_4yTY8g3M7qmpM7HeUq=E05e7v_QFTzk=2D5Mv3Vj3Usqg@mail.gmail.com>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Barry Song <baohua@kernel.org> writes:

> On Fri, Jun 19, 2026 at 12:41 PM Ritesh Harjani (IBM)
> <ritesh.list@gmail.com> wrote:
>>
>> SWAP_NR_ORDERS sizes a few small bounded arrays inside THP swap
>> allocator code (nofull/frag cluster lists, percpu_swap_cluster's
>> si/offset arrays, next array for rotational device). This currently
>> expands to PMD_ORDER+1, which only works when PMD_ORDER is a compile
>> time constant.
>>
>> However on architecture like PowerPC Book3S64, PMD_ORDER is a runtime
>> variable which depends upon which MMU is selected (Radix / Hash), so in
>> that case, PMD_ORDER cannot be used to size the static arrays.
>>
>> This patch provides an optional ARCH_MAX_PMD_ORDER (upper-bound)
>> override for such architectures. The memory overhead on enabling this
>> override is negligible. Even if we make SWAP_NR_ORDERS runtime alloc,
>> default slab padding could cause some memory waste. Also we lose the
>> per-cpu cacheline benefits (for percpu_swap_cluster) because it might
>> cost an extra cacheline indirection overhead in swap_alloc_fast() for
>> fetching si[order]/offset[order]. Note that a fully runtime
>> SWAP_NR_ORDERS was considered in previous version but was dropped for
>> this reason [1]
>
> Do we know the maximum PMD size?

ARCH_MAX_PMD_ORDER will be 8 on PowerPC book3s64 with 64K pagesize.
PowerPC Hash MMU with 64K default pagesize supports PMD size of 16MB.

> On arm64 with a 64 KB base page,
> a PMD can be as large as 512 MB:
> https://docs.kernel.org/arch/arm64/hugetlbpage.html
>
> One concern we have is that performing I/O on such a large folio could
> incur significant latency before reclaiming any memory. For this
> reason, on arm64 we initially enabled THP_SWAPOUT only for 4 KB base
> pages:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d0637c505f
>

That's not the case on PowerPC. Max PMD size for Hash will be 16MB.
Also we still need this patch since we can at runtime choose Hash or
Radix MMU. So, the main problem this patch is trying to solve on PowerPC
Book3s64 is enabling this feature w/o impacting any other architecture.
W/O this patch series, we can't enable it, since it gives build errors.

>>
>> [1]: https://lore.kernel.org/linuxppc-dev/pl1zdksc.ritesh.list@gmail.com/
>>
>
> Best Regards
> Barry

Thanks for the review!

-ritesh

