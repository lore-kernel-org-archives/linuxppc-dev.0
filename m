Return-Path: <linuxppc-dev+bounces-22959-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A218CDE000
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:25:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gldP01MSCz2yVd;
	Wed, 24 Jun 2026 20:25:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::536" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782296724;
	cv=pass; b=iJfbGIO36SsC3RkRlEt9MV0tnz621LYK3qRMtE6Evajhd5s/A+BnNNceIwMyWHsbwaFPxfgHVCmSHgizypkV54i6bH7n2OFnEjMbc6iRUzbH64jlzsWsbWBymSGeg/h5nwqp11VzyzT3aEM/4yOOqjaDo+orOV81Z+8VzXncKJnWawbmP/OvLNYcM+7211a8/RpT8ZzvuLT2Jahc8nhe4l/Enl3ewM7/d5FnLKQtuiqG+1Rurlmx1a0zMY3so4YUv/kMpTX4VB3ZWwNa2yHC9LrqKTOlAA1jfId+SJfbscNp1bVQdQTHb81b1Va/prlRvyFU764Gd5d4hbmrJgoj3w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782296724; c=relaxed/relaxed;
	bh=Gn2q9W6t0rTfmg+/5vtYu0tyCAk29V2svA4HnR96qP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZTwIDAm4ibJv1xCBUWmV5BQ3QtFRj35lVdxdBaGHcHnFf5vI6kA7bh6seQ6C8BLk+HaA3wL93o0mCoXGMS/qHwhyddTshThUn4tqMyeaK9GYSNOtw59N79l1U2NXn4xfe67NR9TgWg5YXMayod+UBZb9XUy00xy1USjlAG/FOCgQr4iEs8howcX0petIxEhJrNagK2Qb0ezGyXX38ukNrhWIpBRI0a1amxwrDr8vgorLawL+obY19Z4dKuvv9LvHf+GabcsmbUpI+hID5lNvkHSAxfER4C3ZxEIgWKC518F2jM8NBq+SQwFttBrbuob3xwGWW+lVBjuawFZBDRbdA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=InzwLmpG; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=ryncsn@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=InzwLmpG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=ryncsn@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gldNy0gBrz2yRF
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 20:25:21 +1000 (AEST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-693c69b97e7so1467073a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 03:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782296716; cv=none;
        d=google.com; s=arc-20240605;
        b=X3Z5byGSPVbcI5UMzUApYbzET0beepXlwa9d2mG/rThCLWdzwzk7Fj7MhBnwASlm7V
         LMvIVR7ILgyaM/ner7EdmLt8QKtxwuWvYhy40P614iLfioEuT9Z1rCL1RL3Wy1nbLymE
         wpDDyv2qm1XJ8h7pXRcKaGO7vnMdGuHTIk7QUJL1e03qlZe4Qc7DQhBlKFw7ruC+b10r
         6fkAKKq2xtzYLOiAxdcsYb/96+ZzmXfK2IhrV8aH5FaIneo/KGmA7ypWFKWhO6SHQK18
         dhQDYNd6EUqCmo+2ROf7Ej/wL5/FIZ8/GgDbGFZghtfaONszQp42+73R1MXjSMjLPXpz
         Y3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gn2q9W6t0rTfmg+/5vtYu0tyCAk29V2svA4HnR96qP8=;
        fh=Pkngf9ZwBiMnV/ITGUhrJ1zr/CdaTP/IyFouJt/8ljE=;
        b=MFGELkWgqz6wSXZS9L/EdneMKtGhG305JB/d7b2Q2Eb562wSB8BtTYrHSpRTdkd1wk
         jYZatWz02/9vu0cILPjrxBXBLwvKPfj+E5UBFmHXZCm1cq7s+2FV2m17JZF/7SfETz4T
         QnfNxx7VAw5zo+uWa+bE0tC8JAuuadst9RKubWGv4D/x2uVdZfMHy2/3qT3azDTaLzvT
         et1ySdxCAGlTitzfuQkSZv4bH4dgEy6ugPDSa4ZRWYAE2nO0MXosa/PLGGEj+FO9GXVT
         KIJnjntUHtzKTjPAK1GA8bJxrMnoWkrYK4O7mT8nBErAE05KIYT4oq58CXBfhE5H95WR
         SCtA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782296716; x=1782901516; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gn2q9W6t0rTfmg+/5vtYu0tyCAk29V2svA4HnR96qP8=;
        b=InzwLmpGOgQ19CabugxTygxwvCCDxdDfx+zqyFCpjvo5285mqWL9E3G6PRD05CJscV
         Vamcwfz6Nd0M243pIn05zL2KxyB6857Zag+5pMzALNmV4sxYQnSr203GJxPNN37hC/17
         a0BwtJfDlOhiXThY9Cbwxx2DsV6OkdS3cKmQlcW93Pm6jaO4h18mWJDeekwmiYNz3BCQ
         rKrdxHLWgfFt2/Y66+2XMg0akNOVRJx7Aj/jkme2eU9WUfiRpIq7xaPZRW8TkpCGih02
         E7ZvgwRZxvtQmsSc0J0aHTQqAnD3QefWso24XCpm7A0YYzwrmTdiwFFq6wCaUzUEyJ2Y
         mtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782296716; x=1782901516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gn2q9W6t0rTfmg+/5vtYu0tyCAk29V2svA4HnR96qP8=;
        b=P+0HYSJLh5oPXuKpHg2qjwCFguf984q3FVDWj+x71B5RtPaU/x9bsEDRL6fSUMFpDp
         Wxn06x0B4eAx2/IuJcYgcv4vRVFIIbsVcK0kiC8VXoqTtcy5mNEQ+kw7uAURbdG5ifl7
         oKs1qcspO3g73lK6YC6DwodAMlqhE7UB7w2fNqrGKOIPuvQm/uxjz3A9IhEK12jnOfKM
         DTcRnaUyjLwO0wc5hgSg2mV+p888JU0KExkY/PvkS7tRqdJgTi8C9c4mfrFNuQw+uLzS
         A2GQSBZMCeul6i+4CcVU8T2nq1FIin2CPcB6ZvKUtYIzH/r/9sbFuu+rj9BViOQfJv40
         yRYA==
X-Forwarded-Encrypted: i=1; AFNElJ+QlVJLCRmo7Q0DAGmWI5QvlPd5hdHR8kaQnJyhVKPNAbcr48ipscx9CBVzX+Y3e6yz37djnJ8/9qj1xU8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxtHguacP6Vbp6wzvX/l3JuIIvJkDZAJ7xWWDD4GI6023yHbuqh
	1fkt7fxKgToAmgTc0Fd8tUN3BO+zMvQulPP14C3vhTlmKEWHjUqZO58aMnRHzduD1uz1cKegke4
	Qw7RWWIz0zPuLaheZ14ZrHD/l4TQDAoY=
X-Gm-Gg: AfdE7cmg3xDEQ+Ss28TNubqdRy4alCCgjLJ0bpTJlzoMPhF6W3RmSSpxMCHT+yS/X6h
	B2o9wVsI0uDafkR8IJrqockONkQIWsdBf5tXZ1vJcVIG62k59vwh15YM9EBySpf4jPfDOn5DiyW
	kreZD9TJmMzEuORSQ3PbJ7jxnFHvJVeg+McfprH/yvXX+4pyK1FxBciwf2H6PrkAa8tpAnuo4wX
	Sn0X+0rN6qfMoMDz3I/P0vCu+3g3w4+3Wh60i3nCsMN+I85VIEjRfHUK33wAJHqbcQQ4L81frtp
	f6+z3YsB9WcOpHfw9SIiLPyhOt3J3g==
X-Received: by 2002:a17:907:6092:b0:c07:4ce0:b013 with SMTP id
 a640c23a62f3a-c11a041a2f8mr130270766b.51.1782296715710; Wed, 24 Jun 2026
 03:25:15 -0700 (PDT)
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
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 24 Jun 2026 18:24:39 +0800
X-Gm-Features: AVVi8Cf04kmOBC68PWjRBoW-gvUbhJwHG2mcjG9oxoQEM2dr9vS6OCW6qGKPH3k
Message-ID: <CAMgjq7BNMYCBKDYH_O-mHsBdAeSq4Z_ve5oDB6rQTGioHo26GQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm, swap: allow archs to override SWAP_NR_ORDERS
 via ARCH_MAX_PMD_ORDER
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-mm@kvack.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Sayali Patil <sayalip@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 12:42=E2=80=AFPM Ritesh Harjani (IBM)
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
>
> [1]: https://lore.kernel.org/linuxppc-dev/pl1zdksc.ritesh.list@gmail.com/
>
> Suggested-by: YoungJun Park <youngjun.park@lge.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  7 +++++++
>  include/linux/swap.h                         | 12 +++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/=
include/asm/book3s/64/pgtable.h
> index e67e64ac6e8c..7f22d5d5fbdf 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -204,6 +204,13 @@ extern unsigned long __pmd_frag_size_shift;
>  #define MAX_PTRS_PER_PGD       (1 << (H_PGD_INDEX_SIZE > RADIX_PGD_INDEX=
_SIZE ? \
>                                        H_PGD_INDEX_SIZE : RADIX_PGD_INDEX=
_SIZE))
>
> +/*
> + * Compile-time upper bound on PMD_ORDER across hash and radix MMUs.
> + * Used by THP SWAP code. Check include/linux/swap.h
> + */
> +#define ARCH_MAX_PMD_ORDER ((H_PTE_INDEX_SIZE > RADIX_PTE_INDEX_SIZE) ? =
\
> +                               H_PTE_INDEX_SIZE : RADIX_PTE_INDEX_SIZE)

Hi Ritesh

So swap is the only user of this macro? Will there by any other users?

I see that due to the percpu cluster design, it's hard to use a
flexible array here. We will probabaly get rid of the fixed percpu
cluster design in the future. By then should we be able to get rid of
this macro?

I'm OK with this approach though. This current design has no negative
effect on other archs so no reason to block it, just wondering if this
can be made simpler in the future :)

