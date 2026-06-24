Return-Path: <linuxppc-dev+bounces-22960-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B60FCDB47F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2026 11:51:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glgHs2kNhz2yVv;
	Wed, 24 Jun 2026 21:51:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782301865;
	cv=none; b=cVbeQdkao/95J5QQ7bnexfGLPm9oiKU1FGZ34119spGZNldiBGPE4r3DQP742JnFZxYktUxMfHHkZl89reUhgZY5ZswS6HZ6wlKm9r4D6LryDdlIdvxvmdHZNRttmIVDwTmBJlpOh2IPLTrcZN6/112EFEdJn3066uOdJX3o8adH/7NMAYRDvsrsjRDkcnMzMw8u4VUIgtKk4aR4vdGOd1qx7lmy4BIwM/njL1Kc+5AJHVqMNNzrvb55x4CSuXgBFK203gVRxDui9MAb2mQTe/KowANMJDcNcuO6jTAIDbVIvgzgGorL5OEzOPw8+Evmmrx4ZhKC6V5+1BayYnKVpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782301865; c=relaxed/relaxed;
	bh=XLYGI+jGGD5SSrEhLKeuITqC8EDy62Dm21Ns6LCR8Mk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=imXiSAecttmsnYRU7Wj2w5Mm1ikD4ctsonK2MY6lf/7WBsPRCnsFYYQf7yseiFgep70JGUYPthyStBZISA7RG/auriN7nhHRiw72qdz7PAjYlP64gTm+FWD5TIdbdwXplZOvEtylSixk9QsLMEq0pMGFQI8TDWt/tRGuisPtxQ49LH0cf3obVF6Ow4cQVq38OVUKVS78EjIHnZIWM5tIXOiyRXtvty+3w2LiiWe0iw+smIiUW0vA4mlpWGa1JNxd6BCSyjjD2q9dqL/tINTRYiGhT4WMnkJ4o1J6R72Gd3eFFgqzdTMeHVqpd6787oVOKlSXuNzcfMuddhKzNGEqPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kw52+g9w; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kw52+g9w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glgHq1Kf7z2ySg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 21:51:01 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-84592b55832so594056b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 04:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782301859; x=1782906659; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLYGI+jGGD5SSrEhLKeuITqC8EDy62Dm21Ns6LCR8Mk=;
        b=Kw52+g9wiUISZ18+7YieVYOGm5o4GWPLgC0w3KgowkajhjFhQq9Tzq7Khl2cYuqxYL
         X5E7jiSN3lkFioD7kQIZjbLnm4P+503AfencgsvTuc/oxYchAWrhGACSTSVeKtEVYmj+
         Jpj9y7AdX+8mPDk/rF/1ojglLC+pPgha1i2MFwvr4YavevUv9IJS7dYVOnuL+K9ZkwRJ
         Hz6eLgCaV/mPd8jf8gZzf5T9tUGUYJoYEGOrzGeBVjGmJsJVnpz72BLq5xvhWAm/JLSe
         KUk+W3GEU2PiGvxL5+0uPAvjr7J1NzhPtC4VpLYy271EkM7BuI2V+5sAabWx+rzrw+0j
         X2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782301859; x=1782906659;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XLYGI+jGGD5SSrEhLKeuITqC8EDy62Dm21Ns6LCR8Mk=;
        b=slU6t5nyLbOcsdg+tiHZe+51t9A1vpzdolWPwnSHeY/19N9HW95+gtI+F/Uq+aCKnX
         FI+31oGziT6haICBJLM8HaQZCvAPw1I6pfH3Uo8ENAypaOw5r98iszuyULmxFne/iLj1
         PPJa8u8LjUMMW+8ayf7OLBGoWRA7aHVYQp4r/dH2IpMwAWdW2N+0O3Fiu9XUJhk3Yt2n
         5ML0Bt3Xj0ARQm8O2yg29KpP/9mZkZ1O+ueCT6GRrDkvkJqmlPdBsVFz9MSC8/KhqQjT
         hX5uLKIXWODx2WYHOUe8bl7O6lSEiftEE0uMyROClvwBGqFZZN/edRNSsYqU9F31CeiZ
         9LcA==
X-Forwarded-Encrypted: i=1; AFNElJ+ult5yxVtovLp6ZWQ8PfyDq34RAmdus7LS+a/FWYLFGpksRa0gF61GKCAFXGX4+2hy3Zrta+IFcq9nbtY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyKaPwrxDsio5rYy0G6+ttGSBq4wjOzmvAKpkktZbfFZ1wf662a
	76JIAA4JcvGwF/YxUmtN1qG4Mj+Bl50vuTOlPFQnU/AkOBvUC5a9Esza
X-Gm-Gg: AfdE7cnzRLXVCvLTVPrbPLYOpuuRG+z9GM3bHwvD5BC08Lv5i17HVZCxPeyuxjTQS+S
	uMpvXWB9+4xFvye5KTWE6cgFJDLuelOYeoaHgPZoWnU+CmTNzUelSuM9Y0DjzSf3qDDxIYkajaM
	uqt6GyH/Vbd3T0iRSWHCBlizu0mkhBEmiwgQOx4KTKzj8O9zXxj2Djz76dKE6V0r+idpoz8LEc3
	rEzcXHxMc3n/mlAGySjDfu0QGWhjCwc51sKioMMj4azLhDFUSePmOCbwZteIBQQaDo4lpt/xI93
	jUP9mQ8DvuC+UmHQ08ID6ii9rbi3ayWEREA02YhWy/9yz5DAq8Ts2BDCQ6PT+KAuR+aKwebyBHo
	sGZgbBaUsrtifNs0023ihgBrxFZD1BrxKbsQWHZS/Q+DvxOH96uU5g2ee+H7J5xcYVkJb/PzFZu
	zuQGKkc0qZbMcJISpB2jWEQ+xjOQ==
X-Received: by 2002:a05:6a00:2305:b0:842:7f81:8079 with SMTP id d2e1a72fcca58-84595326988mr8140571b3a.37.1782301858737;
        Wed, 24 Jun 2026 04:50:58 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a413d2aasm2435598b3a.59.2026.06.24.04.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 04:50:56 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Sayali Patil <sayalip@linux.ibm.com>
Subject: Re: [PATCH v4 2/3] mm, swap: allow archs to override SWAP_NR_ORDERS via ARCH_MAX_PMD_ORDER
In-Reply-To: <CAMgjq7BNMYCBKDYH_O-mHsBdAeSq4Z_ve5oDB6rQTGioHo26GQ@mail.gmail.com>
Date: Wed, 24 Jun 2026 16:45:21 +0530
Message-ID: <pl1gw5o6.ritesh.list@gmail.com>
References: <cover.1781843449.git.ritesh.list@gmail.com> <eda4e51ee9f1270582fbb2823ec5873e769de089.1781843449.git.ritesh.list@gmail.com> <CAMgjq7BNMYCBKDYH_O-mHsBdAeSq4Z_ve5oDB6rQTGioHo26GQ@mail.gmail.com>
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

Kairui Song <ryncsn@gmail.com> writes:

> On Fri, Jun 19, 2026 at 12:42 PM Ritesh Harjani (IBM)
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
>>
>> [1]: https://lore.kernel.org/linuxppc-dev/pl1zdksc.ritesh.list@gmail.com/
>>
>> Suggested-by: YoungJun Park <youngjun.park@lge.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  arch/powerpc/include/asm/book3s/64/pgtable.h |  7 +++++++
>>  include/linux/swap.h                         | 12 +++++++++++-
>>  2 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> index e67e64ac6e8c..7f22d5d5fbdf 100644
>> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> @@ -204,6 +204,13 @@ extern unsigned long __pmd_frag_size_shift;
>>  #define MAX_PTRS_PER_PGD       (1 << (H_PGD_INDEX_SIZE > RADIX_PGD_INDEX_SIZE ? \
>>                                        H_PGD_INDEX_SIZE : RADIX_PGD_INDEX_SIZE))
>>
>> +/*
>> + * Compile-time upper bound on PMD_ORDER across hash and radix MMUs.
>> + * Used by THP SWAP code. Check include/linux/swap.h
>> + */
>> +#define ARCH_MAX_PMD_ORDER ((H_PTE_INDEX_SIZE > RADIX_PTE_INDEX_SIZE) ? \
>> +                               H_PTE_INDEX_SIZE : RADIX_PTE_INDEX_SIZE)
>
> Hi Ritesh
>
> So swap is the only user of this macro? Will there by any other users?
>

No other users so far other than swap.

> I see that due to the percpu cluster design, it's hard to use a
> flexible array here. We will probabaly get rid of the fixed percpu
> cluster design in the future. By then should we be able to get rid of
> this macro?
>

Earlier in RFC version [1] it was runtime though, but as stated in the
commit msg, it adds unncessary complexity and yes, the per-cpu usage
there, made me re-think this whole thing (as Youngjun also suggested).
Since the allocation of si/offset of percpu_swap_cluster in fastpath
means, we also loose on the cacheline benefits that it otherwise had.

[1]: https://lore.kernel.org/linux-mm/19688ab5ab8017467749e003cf630c76a4b2b198.1781000840.git.ritesh.list@gmail.com/

Sure - I am not well aware of the plans on how to avoid the fixed
per-cpu cluster design here. Maybe if you can share some details, that
will be helpful.

But essentially yes, per-cpu swap cluster was the major reason why we
looked at adding ARCH_MAX_PMD_ORDER for PowerPC. Also note that this
does not cost any additional memory overhead compared to the runtime
solution, since kmalloc allocations of these structures were anyway
adding some bit of padding.


> I'm OK with this approach though. This current design has no negative
> effect on other archs so no reason to block it,

Sure. Thanks!

> just wondering if this can be made simpler in the future :)

Well it's relative. I felt this is a simpler design compared to the RFC
version we had earlier [1]. But still - can you share some additional
details of your concerns please.

Having said that - sure if in future we get rid of the fixed percpu
design, then I am happy to revisit this to see if this macro can be
killed - by maybe adopting to runtime allocations.

Thanks for looking into this!

-ritesh


