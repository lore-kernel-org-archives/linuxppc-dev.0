Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D45606A31D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hM+HQ5HV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGHKG21qdz30Vs;
	Fri, 30 Oct 2026 21:24:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1230"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793355890;
	cv=none; b=i4F/Wda/DEqsh28AuqBIvE1D3fFLyYNmxh8HdSuJ9Ua025V9+OlaVcjFoIB1UUK06eIcPso6WySBJEQ1iQ2sg3J9ECKjZRWNemKWxYGzFcDmKQ86uxOXEkckkjvH5JqvzWIX07c/Hp3xdq1bHCb7K2Q02wgiUaI93mNiPoekNI0w/HclfNNPihimVTBDFQOvyV31RqyuPgsnjRUHN+OFDYwTAUn2pROdG47eoDIbm/6EISmqSPSNTNzjBe5uPV7kb2HJMD2uCHHQi0tBnhpG6pLDRGYwAeDVId3PxNXeh5GNcEusVc8bSMFFI+wXbmq+U+qCMkHJTc1eqi5ZTR7XbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793355890; c=relaxed/relaxed;
	bh=CwWE7UOGE7vvkgiGMpiO2wb6+EIxQ8HXhg/iR90K5xU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=b/8lbq7iwiivh9hX3hfFRp6WYSfZVJpRMzjiK/wnQ+V96ZfehVpqJDp0NuWfQMB6mgGwBjErHM51ZaX3w+s/YhmFVqs21zK0g82GAOdmTG9zIT7ge/h0iVPPxP8Xv/SpIL9e/qttEUHXaMPsMcoDVjYmDMHQiT4EIFTC0PXpwBs2VLKEa1LbPuRG/0xSe2V5YB1aUqedIYKBuUbUETpRBLdSeM3/QnUxmuh97sOhNE8DIwKlV58fR8pX+CKlu1TB0YNfqUhTtvwLBByhoZYgosseZgZIi6rcazB6Mkl4xXhQOOjpdvbDfBtholIySMf87Caae0Av1432EP9+qwcWPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hM+HQ5HV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1230; helo=mail-dl1-x1230.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hM+HQ5HV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1230; helo=mail-dl1-x1230.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1230.google.com (mail-dl1-x1230.google.com [IPv6:2607:f8b0:4864:20::1230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGHKF1bPnz30Vm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 21:24:48 +1100 (AEDT)
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-1931ff67a29so1501553c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 03:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793355887; x=1793960687; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CwWE7UOGE7vvkgiGMpiO2wb6+EIxQ8HXhg/iR90K5xU=;
        b=hM+HQ5HVUcIAnm0+8Y8C0wJjYCwcRmm1yeXDLi6eQfkCYEV/Y7gdWrYktjcOMDp7DA
         GW0E3IDIhCfWCzPHa4RNrbfzE4iST3sQM8/jlW8jwrk6EfyvJ/7KqTbG7lDL80rjXVBL
         Q8CIvCA9wVnplyjwfVmLSK7KcZ3JlLyqKgU+uop8xinYp4gPMSiIKvdLw9m9E62nVwq7
         dlh2pWeYHyY6gt6HZe4fOg+yA8racSwR/GooQGzIWDlBPy9Zs16JTD46iEsxTDtBZM5+
         KWEoZcoUZgTdfSlHwtbAzGmj7+x77YGM+dV4RmfS54CM+yiobIAiPHgGe0VvDscMaB34
         42EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793355887; x=1793960687;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CwWE7UOGE7vvkgiGMpiO2wb6+EIxQ8HXhg/iR90K5xU=;
        b=qVeVAF0f4EpghtqhfWdZ5Kqn4D/auTJ9zofqwtLDxqV1GBaNuNmVcV7Xtnv2DD6vSa
         e/KBK+WRNW1+Rj9Dq8Kh5v+LetGQuQpXYFwGIFOS4EDFN+2sxgxli/8vgGLWK3XgnRZO
         TVPeFgJwNnuE70GMeKfySBe9Nmm6ZaXgud9eQ56CAOyLYf50hBtIIKoM3L2xkeNr9pU2
         5wTA3lxptLTb0cR0R75uuNt3G3hfiNSRqdLnStPFh4x0CLw1bTVDvNdZCsh2Tv9luGyU
         BoqhgVLhB6JlTKeMFO7Y/+52f429Ip+zwCOM0Cr1t3XAQ64cQC/Z3+KI3uacivZl6vka
         Mg2w==
X-Forwarded-Encrypted: i=1; AKwUvBwCMjkOkMgWz0FJ5z9ycIwTTj5H+Ha/u2vbrafMpFDi4lsz0GwJ4AOQh5a5qXadSAbhmU3O6iKqEfz1zIo=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKX/LU4L5hqu2k7yoHKHUt4H3rvAQlH+Ne6ELIeUXfXG+Am9zVI
	wOrOjQSJxA6wsDME2KSqutQLHmmnBZmyoawB7IIzC5n7T8OHwkixfx7O
X-Gm-Gg: AYBFou2XiO+kfs22cDxIorLEm6ctOO5pm4/ZUwuBfDpUYlhXGviRhYEe0TC47KtTuBa
	oMzehEQ8G0Rk36jYlMN1h2g9XS9SGhD1sxGHlawwkW0l59pGqc+r2nMQM1T1QCiYE544KBcYQMk
	FeeOamiYRWVtQJVXi6ZTqjnb7XMrmAdyx2A6RHFdnNmMCIBI5c43CeaENYL2DOnA4W4isOpkBvE
	e1VLQ+nNmIVzDVIXwHddTkze8qwCZnSHr2kN2YvpHkbCtGCjE20ltT+FmliK4J4WTpwQ2yezBV/
	BuddBwZIgqYuMC1mi+ImboURcG0J2GVTUQhHu1WpYUvUHrOwpPDBhDTHH4PaqvoyknSQtoLvJU2
	sI6NRzh6la3lOWAYn/Rl5fo7bb+urvkso8q+Thv1RCHMkHyN/nL3zc0kLNrLCX1EKn+fyGASb70
	3AmL5yCwmtOW9KoidQituNuADT9wEpUNumv7j+mgA8H6Bu7nv3rEwIcfwbCeT1wqlb5ZbpafQmN
	/9dFYvXJyTrowB6Kc8Xur2y14tROFKHOlmzlIP1LO5dLsizroX2FQD3YN4EyVxL3zkI29RVN8Rz
	KthHjJh8AVnFxX7+fX6i+8Bqihg=
X-Received: by 2002:a05:7022:3b87:b0:196:d6e1:108b with SMTP id a92af1059eb24-1ac59fbfd13mr2589413c88.10.1793355886505;
        Fri, 30 Oct 2026 03:24:46 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b0a628bsm5805067c88.22.2026.10.30.03.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:24:45 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Pavithra <pavrampu@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/mm: fix uninitialized ZONE_DEVICE struct pages with PMDs
In-Reply-To: <20FE1232-A48B-4F72-8F18-89EFF70EE0FE@linux.dev>
Date: Fri, 30 Oct 2026 15:50:40 +0530
Message-ID: <bj8bwkuf.ritesh.list@gmail.com>
References: <20261029063601.1961415-1-songmuchun@bytedance.com> <h5i4wlx5.ritesh.list@gmail.com> <20FE1232-A48B-4F72-8F18-89EFF70EE0FE@linux.dev>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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

Muchun Song <muchun.song@linux.dev> writes:

>> On Oct 29, 2026, at 23:45, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
>> 
>> Muchun Song <songmuchun@bytedance.com> writes:
>> 
>> Thanks Muchun,
>> 
>>> PowerPC radix vmemmap population can reuse an existing PMD mapping while
>>> populating a device DAX range whose section is marked as HVO-enabled. The
>>> reused mapping is an ordinary vmemmap mapping: the redundant tail struct
>>> pages are not remapped to the shared tail page.
>>> 
>>> Leaving the section marked as HVO-enabled makes later ZONE_DEVICE
>>> initialization treat the range as optimized and initialize only the struct
>>> pages that would be backed by a real HVO mapping. The remaining tail struct
>>> pages can then be left uninitialized even though they are still used as
>>> metadata for the device DAX compound page.
>>> 
>>> This first triggers a zone mismatch warning in __init_single_page(), then
>>> faults while initializing the pageblock flags:
>>> 
>>>  WARNING: mm/mm_init.c:600 at __init_single_page+0xd0/0xf4
>>>  Call Trace:
>>>    memmap_init_zone_device+0x164/0x430
>>>    memremap_pages+0x43c/0x93c
>>>    devm_memremap_pages+0x3c/0xa4
>>>    dev_dax_probe+0x264/0x3d0
>>>    dax_bus_probe+0x140/0x1c8
>>> 
>>>  BUG: Kernel NULL pointer dereference on read at 0x00001400
>>>    __set_pfnblock_flags_mask.constprop.0+0x34/0x160
>>>    memmap_init_zone_device+0x358/0x430
>>> 
>>> On kernels without these initialization-time diagnostics, the
>>> uninitialized metadata remains latent. When userspace later maps and
>>> accesses the affected device DAX range, the kernel operates on those struct
>>> pages and panics at that point instead of during device initialization.
>>> 
>>> The Fixes target predates the section-based vmemmap optimization
>>> infrastructure, so older kernels do not have section state that can be
>>> marked non-HVO. Backports to such kernels need to handle the PMD-reuse case
>>> in powerpc radix code directly, for example by initializing the tail struct
>>> pages that core ZONE_DEVICE initialization would otherwise skip.
>>> 
>> 
>> Actually that would be totally new code right? It won't be a straight
>> forward backport, correct? ... 
>
> Right. Because it's impossible to backport the whole section-based vmemmap
> optimization infrastructure (48 commits).
>
>> 
>>> Mark the section as non-HVO when reusing an existing PMD mapping, so the
>>> section's HVO state matches the actual vmemmap layout and all required
>>> struct pages are initialized.
>>> 
>>> Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap optimization for radix")
>>> Cc: stable@vger.kernel.org
>> 
>> ... then should we mark Cc: stable here with the above mentioned fixes
>> tag? Because this patch cannot be backported as is to older kernels -
>> for the reasons you mentioned above.
>
> The comment following the trailer is used to guide stable maintainers to
> backport proper prerequisite commits. It's hard to do that. So I choose to
> mention the alternative in the commit message. But with the help of LLM,
> I found the alternative is also not the right solution. The reason is as below.
>
> That pmd_leaf() path only creates or reuses the vmemmap mapping. After it
> returns, sparse_add_section() calls page_init_poison() on the whole memmap,
> which overwrites any page state initialized there.
>
> Therefore, older kernels must pass the PMD-leaf information to
> memmap_init_zone_device() and let it initialize all real tail struct
> page entries. Initializing them immediately in the PowerPC pmd_leaf()
> branch would be too early.
>
> Another solution is making vmemmap_can_optimize() range-aware by passing
> the vmemmap start and end addresses.
>
> On PowerPC, reject the optimization when any part of the range is already
> covered by a PMD leaf. This ensures that an existing PMD mapping is reused
> normally and that all real tail struct page entries are initialized later
> by the core code.
>
> Maybe it should be a separate patch for old kernels? Thoughts?
>

yes, I think we can do a separate patch later for older kernels. I
will look at your suggestions to see what can be done in that case.


>> 
>>> Reported-by: Pavithra <pavrampu@linux.ibm.com>
>>> Closes: https://lore.kernel.org/r/97f85592bb78a273be8519e6897e7f9b9bd31469.1793070429.git.ritesh.list@gmail.com
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>> ---
>>> arch/powerpc/mm/book3s64/radix_pgtable.c | 11 ++++++++++-
>>> 1 file changed, 10 insertions(+), 1 deletion(-)
>>> 
>> 
>> I think, this patch should go via mm tree, due to all the dependencies
>> coming from there, right?
>
> Better. I hope Andrew will pick it up once I send a v2 version with more
> proper commit message changed.
>

I think we can add an explicit comment like this then?

Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap optimization for radix")
Cc: <stable@vger.kernel.org> # see patch description, needs a different fix for <= 7.3

-ritesh


