Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D3A606A31A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ipaHNlnj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFpnm5cmRz30Ng;
	Fri, 30 Oct 2026 02:59:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793289564;
	cv=none; b=Aj9aB+4xXaRYNkBqXHtwHps6Ko/2vVkYBtcwKcOBI4ksWLSz1lk9wA02GeJNmFzgZoXTSbtyGMrZHfKji8H+KvyLc3/lYJ1WuPYrrcWF6HjUSDl2OhYCTRr1we59u/NdmReVc2U3yMVj7C1gI9nCnoPP/jnUUEeVifaz5YTD9THNxYCTBai51oMrP+bwcCpaat5X6rVEwU7mta3WkxQ20gzr549KDMT1J0lxSOTurxyjUKi8XWCoP/Gy34BhnneDlKU4Oj3C8A7s84GQEOycMOtWophrN6a1E4ex6sGnhw/DqXhU7BrafU+7OUrx/iKydCc1RpceNf/tBPNXaNzLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793289564; c=relaxed/relaxed;
	bh=2Iavpt0xD5+NOsPxR52uOxmq8ZYkCHkAdBvsyZeTFxk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=hIVj/7EyXABvW0lsxB+nhnPopti1yMIXPqdHRTfke8Z5e1UnTr4c9sVEZiYvaz3lKTB5SCMtKEMh7UoDRIOj3KKNFDSigFyuRlgZBQnQpPCwYWBpgzs0YpOL0Oj7YCKbba/EU6XSoATEwHq1LHc/48vpm7IjMKHjDUvOSxxDQUKXjOGgvnHnAyqLYry9xFsjcZj+mhloiUtSnT9DmbdBRdD/YjwTwlci700MzAP/TiNZTE+obcU6nAOW6X2xa8SG3A+Qnjacj+aWtKKJBshtAw5QuprmMnrRIzmYqqxcBo4soen500mcVcknRxk0GNpmI67MQYwbNNf21ma8aHxj4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ipaHNlnj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ipaHNlnj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFpnk6YW6z2ySc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 02:59:21 +1100 (AEDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-6ddef424972so1795059eaf.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 08:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793289558; x=1793894358; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2Iavpt0xD5+NOsPxR52uOxmq8ZYkCHkAdBvsyZeTFxk=;
        b=ipaHNlnjGglwm34/UGQK0+w+AJ0Bj5OqfRcMUs4poJASeJuavxHsUeA0ly+6X8IG/j
         NYmXa65HI2oKpgqxqNJyLTh7Vy6I/rBnFqQIHn6Ma2zUvNuDkD3Fjf71b3TwDcaWmBlE
         UohldrmvgmSp3H6TjEzAuRsqXdKjILMHixELvnKYc5MKT9QvXBoPd3KZYz8heTam6DeB
         iwF8LGu4Zbb9NUPhMtTmIlaAlIUY79M7EuY0LFDGT+CuRy2nhYB1T2EICHI8kZ0hXBtI
         FpNxLf4xVBfBV8Er89kARJlgHs3LM98fkIckhYAzcFmH2phTgO1JY9LaFXkkVimwGV1J
         0keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793289558; x=1793894358;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Iavpt0xD5+NOsPxR52uOxmq8ZYkCHkAdBvsyZeTFxk=;
        b=eyt6pvxiwokNHaHJ49hExHkrU3pXsop1nhk4uBDhjVZDw6SCVIGyxt3i+VdvMC8KhH
         yAo20fgPMFFSljs0Oy4MexfDhq12amP0JQnIa96ttApzEcQUdlZ6E30IxiVFoncRCAOG
         97iUI6s5h+3uP9jBKOY+/F6J/h2EFy+bzYjKjYZ4D7ZeR0ozMfNd0+9Y0NwnjL1WlC/A
         wdnxQRHIlmIYwIEzZiYXc6F3vIEe+zE+d6HiTCzYB/Uock2gPX3TKd1lBg/k8aX+AjNu
         tZrGJIENjOYL8KMN1UdYBu0euCWLc3QwpFxJEdBCVLa4J7zG8bZYERk+sXX3hueOsGDK
         YWvw==
X-Forwarded-Encrypted: i=1; AKwUvBxhoIIUrsyNMywdcqT2Cz5vIklpWC8aRpI7LxC2pR8UJq2YW8CJvE316N/VrZ2eL8hAChYBJfNJ4uH0JCw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLw6Iz+jB9dnuHh5MdhaaaUGi3bTh+HlpiaX0QIe/axbMPK85vf
	B9hr4XrYMV5HOWhWF/4n+G4WgWgFYVk8XQCnaxgbCQi22vmvblNmVvf5
X-Gm-Gg: AYBFou3W9m1s+hvCkb1+6WAFO3XxCQjmWm1+ewyk9Ddf1SHTZYv7mgQQkjqSfHzayEf
	pUUGiUUUJeCPAJa9M6TBiEuTmInEwNupFOxjt3izqj6Pwsf6RbvqKb0eS+nMMkYQFdRWXzBX9nU
	vWJ/omE6HFQ8tWv5p8KaQBGOFrhj/LueOo2ZewfXqdsKgKIss2fe1oSUAoebNKmbWv/RR2V7m39
	EnEXjHotw8zBD4BQ/GMlofjCY5zoteCB/nPD704g8x8+UvjLmYUyOI54Txm2WscLwynWqtqsWq3
	JIJ6df0ODgRrWSpo7qFwfYQhfoDdKsi4C/MH7r6uMvrGlbbBwj2kKNRMUbm19ucHPwZXC0iRBBq
	kp+uGO6PKzOIuZNk1rj9Uos7WbRh324y5EcLrDlfBoAWSOVHolZRMrCScZLhCfoijFxA+umVbje
	mgcDeUEBZxGNu9wX/D9oBNQJmcF2rVanjXZ5mvU7jSOJ9ihqI3WT13GRAkP0tLfDqdtTaueaLsg
	Wh7BxEI22piaJP9hShUJpJZ+2Q9ptOTvrgq85u60E4AWvNn4wDwIQZCeC4Vd5NdJjS4kgpYh5Xa
	NcEtNPZRXUr4jqPzD4QMoeu7No8=
X-Received: by 2002:a05:6820:1629:b0:709:529a:478f with SMTP id 006d021491bc7-713ef240bb2mr3244491eaf.60.1793289557756;
        Thu, 29 Oct 2026 08:59:17 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d33f57805sm182778a34.6.2026.10.29.08.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 08:59:16 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Muchun Song <songmuchun@bytedance.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Pavithra <pavrampu@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH] powerpc/mm: fix uninitialized ZONE_DEVICE struct pages with PMDs
In-Reply-To: <20261029063601.1961415-1-songmuchun@bytedance.com>
Date: Thu, 29 Oct 2026 21:15:10 +0530
Message-ID: <h5i4wlx5.ritesh.list@gmail.com>
References: <20261029063601.1961415-1-songmuchun@bytedance.com>
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

Muchun Song <songmuchun@bytedance.com> writes:

Thanks Muchun,

> PowerPC radix vmemmap population can reuse an existing PMD mapping while
> populating a device DAX range whose section is marked as HVO-enabled. The
> reused mapping is an ordinary vmemmap mapping: the redundant tail struct
> pages are not remapped to the shared tail page.
>
> Leaving the section marked as HVO-enabled makes later ZONE_DEVICE
> initialization treat the range as optimized and initialize only the struct
> pages that would be backed by a real HVO mapping. The remaining tail struct
> pages can then be left uninitialized even though they are still used as
> metadata for the device DAX compound page.
>
> This first triggers a zone mismatch warning in __init_single_page(), then
> faults while initializing the pageblock flags:
>
>   WARNING: mm/mm_init.c:600 at __init_single_page+0xd0/0xf4
>   Call Trace:
>     memmap_init_zone_device+0x164/0x430
>     memremap_pages+0x43c/0x93c
>     devm_memremap_pages+0x3c/0xa4
>     dev_dax_probe+0x264/0x3d0
>     dax_bus_probe+0x140/0x1c8
>
>   BUG: Kernel NULL pointer dereference on read at 0x00001400
>     __set_pfnblock_flags_mask.constprop.0+0x34/0x160
>     memmap_init_zone_device+0x358/0x430
>
> On kernels without these initialization-time diagnostics, the
> uninitialized metadata remains latent. When userspace later maps and
> accesses the affected device DAX range, the kernel operates on those struct
> pages and panics at that point instead of during device initialization.
>
> The Fixes target predates the section-based vmemmap optimization
> infrastructure, so older kernels do not have section state that can be
> marked non-HVO. Backports to such kernels need to handle the PMD-reuse case
> in powerpc radix code directly, for example by initializing the tail struct
> pages that core ZONE_DEVICE initialization would otherwise skip.
>

Actually that would be totally new code right? It won't be a straight
forward backport, correct? ... 

> Mark the section as non-HVO when reusing an existing PMD mapping, so the
> section's HVO state matches the actual vmemmap layout and all required
> struct pages are initialized.
>
> Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap optimization for radix")
> Cc: stable@vger.kernel.org

... then should we mark Cc: stable here with the above mentioned fixes
tag? Because this patch cannot be backported as is to older kernels -
for the reasons you mentioned above.

> Reported-by: Pavithra <pavrampu@linux.ibm.com>
> Closes: https://lore.kernel.org/r/97f85592bb78a273be8519e6897e7f9b9bd31469.1793070429.git.ritesh.list@gmail.com
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  arch/powerpc/mm/book3s64/radix_pgtable.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>

I think, this patch should go via mm tree, due to all the dependencies
coming from there, right?

-ritesh


