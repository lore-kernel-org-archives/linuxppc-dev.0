Return-Path: <linuxppc-dev+bounces-21981-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46775CD6E57
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 15:09:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVrhG5NC1z2ySJ;
	Thu, 04 Jun 2026 01:09:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780499358;
	cv=none; b=mXo94YMLKPbRtdLCE3QpiqaWCpZjhJKlFF5MqjOGbxU5wossvTQB6EAacU7DJUbZSpVG0pjB7CKuHUByvS0R1wgaggbS3oWU+ieLqJnHYSjme3wj9mSvYnx2ek9CtOySOey3aX+/y8Boh4n1f3KmDG1jujDgtkdbcGM6Eqrtwt64A4xIsK45r/NWvWSl1p98YVX4uM0NYK7O8ZQvJIxx+HmFtdUF5EpZHx+65R0aaPT6qkzmi4hP2ipiS5Qx3uNrXapZc9iyp4RdJe8RNPYNcg0t3KHPH9p7250+ptKPDJG421XZapuBYBepz19UUYKWFD2sFJ+CHa/Nx1obicKA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780499358; c=relaxed/relaxed;
	bh=bndY4Rtt+kF0HA5uw8ulEDrFOIX6yTjDL3dqjriePQQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=WdWtIQjCo6wRf5/tBvxZRT6rd0wWTnvRN57b7lj6PWWW9GdwzdcXv8HWmc5inuEb4jXxN3yN6Bp2fO9cfhB0fRudzyJKoElMGVuq5eYyZogXx8ciyl8IJ5dFJsolMdc9vbW1yTxC2QK8oJUewt2xVDWdBHSQA2qHRqaVsKohaw7lm8Y9ByFVlwLsEA77NLbBDmhjLris1Sn0O0g9fK8BoiaFJ0IXkRgJ9MJ4/V8U/1vaTAm9pC6oW/r4Ohx4sed4sJ0grgLMkYUyRXRmp2w35K7G36hiJ8yyQlJLinXy7vmGLmEnVaj/zTb9s4hB++TZAOp0yXBRQExfVvM556V53g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XCEQ4jud; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XCEQ4jud;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVrhD6zPNz2yQL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 01:09:15 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2c0a5354da1so7183395ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 08:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780499353; x=1781104153; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bndY4Rtt+kF0HA5uw8ulEDrFOIX6yTjDL3dqjriePQQ=;
        b=XCEQ4juduNeX0VhAmh1RWQNRrSZt777j3D3t+px/muqNo0IjhYT6VMm75oCTADcLsO
         Ps/cEn1q8R7DCs8tfIYhOHOSEhbnv2yJBdAK/3A6GHNYkQbU+jnMQsTgu7a3BG+/meFh
         mvCj7gI/B5Tc+IFnNWvGiRs6rnStTsWo/35i0gyjqzAetUZgRIROS4FXL8XCWOWBLV7s
         7mJa2lRfdQBRy5Z6dk82MGGSxFtMCEv4xA/nPxQAhnvOlMhKle73QodBO/iJ140P4AdV
         Ju8wiFP619/j7lwXe2aSeTAKfQT7WQT1km1ErwkXgFBn2/t0IcBn7+M9vyvZH3MUGtSM
         +LQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499353; x=1781104153;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bndY4Rtt+kF0HA5uw8ulEDrFOIX6yTjDL3dqjriePQQ=;
        b=J7Wt7C6CiWeLUaeZ6rjCqESOxDR+CugFpj25JqaHw5AXTvRUd980FUUBD2CHVF3fNC
         zsxvW4NhDBONWkeNYvwZOsWzpRuEoDo+wX5zGagdo/HBSi4zG55ywi5IgpXCUQCryhi1
         622t8zQllnldzbzrX5yvdR+BJSJM5DjHgeHrsFQ5ab0Dum4Z3s43BOu4Yv+edjb+LJBF
         jsTJvjbVxkGeX4W0Y6RRQW8makddnglLu1W/XETJixh8ToFIpPvIdg6LYlDJPkKWjQus
         jxW72+V9dv6TFxg/2WCueUK603H8Ja6vri4J6LAotMPt4DLjyjt+AEYNCcMbXSl58NLx
         /ppQ==
X-Forwarded-Encrypted: i=1; AFNElJ9UWtJHfMJ8EaoO2BfCL1T5PScz3NAJ7jvqYRyVK6kWDwq3uop1hapoHsTVXpHOlhL0WmL182A2FEI1IRg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw68On5BstVbrSHksIbwtENWhaNtoounQUp6Z73+6+E4/t4HRHK
	c+Bxu4x49L8wUtWUV3m5DNFkA5QlgBdQsu/70wR+hfLOpp8s6qWZQdoe
X-Gm-Gg: Acq92OEMVyDfqUbv1XjFHPqtuh6HSTg1a3up63SLX96fTEmo+p2UGwxTALYOXvokdpC
	j82I98aoT4Kl7EEZReMtHyUHXaLAXIwc2vdBje8Y0k3CLAj31EPoxNyWL94LeqhKZ2tNAmrSlWv
	aqi9We19BNALx5RBG5lLQiloTvre3vQ8K278CLEd6tkWl+0oxgvIuC/m0uvTE51zwZJ8mSb4GEk
	wMgMRRIbnjn1z1QM/spW3gjiMFUtHOL06s3FU1nWTmfYLN23B1JuVzZaGzJNfHgMaEnXm46/Jy5
	GQLbNqNMMcAtxqtO5zGoVqZ2HYLzv9H4HiOxYCqZkzk4l8WHHHHgPqtOAL++N241DF6R9YZi2dI
	Sg246aG0YcZa0nZJqonVBH/FsGTwJmoAW1ZMg+xjE9XEpV0AWStg6EjdMftU4kpXKfhdx3HxkQF
	ZsGxTOZxJAHSrWttV6pLLIXRute6HdKGhV
X-Received: by 2002:a17:903:22cc:b0:2c0:af09:f3d4 with SMTP id d9443c01a7336-2c164d5f70emr29441875ad.27.1780499353373;
        Wed, 03 Jun 2026 08:09:13 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d2bbsm29577905ad.1.2026.06.03.08.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:09:12 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Muchun Song <songmuchun@bytedance.com>, Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>, Mike Rapoport <rppt@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v3 03/19] powerpc/mm: Fix wrong addr_pfn tracking in compound vmemmap population
In-Reply-To: <20260602101039.1867613-4-songmuchun@bytedance.com>
Date: Wed, 03 Jun 2026 20:06:35 +0530
Message-ID: <a4tbwv0s.ritesh.list@gmail.com>
References: <20260602101039.1867613-1-songmuchun@bytedance.com> <20260602101039.1867613-4-songmuchun@bytedance.com>
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

Muchun Song <songmuchun@bytedance.com> writes:

> vmemmap_populate_compound_pages() uses addr_pfn to determine the PFN
> offset within a compound page and to decide whether the current
> vmemmap slot should be populated as a head page mapping or should reuse
> a tail page mapping.
>
> However, addr_pfn is advanced manually in parallel with addr.  The loop
> itself progresses in vmemmap address space, so each PAGE_SIZE step in
> addr covers PAGE_SIZE / sizeof(struct page) struct page slots.  Since
> addr_pfn is compared against nr_pages in data-PFN units, it should
> advance by the same number of PFNs.  The existing manual increments do
> not match that and therefore do not reliably track the PFN
> corresponding to the current addr.
>
> As a result, pfn_offset can be computed from the wrong PFN and the code
> can make the head/tail decision for the wrong compound-page position.
>
> Fix this by deriving addr_pfn directly from the current vmemmap address
> instead of carrying it as loop state.
>
> Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap optimization for radix")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Oscar Salvador <osalvador@suse.de>

Thanks for fixing it. I guess this was not caught because section size
on powerpc is 16MB and with 64K pagesize we have 256 pfns to map. The
vmemmap size required for this is 256*sizeof(struct page) = 16KB which
is < 64K (pagesize). So basically we never loop in
vmemmap_populate_compound_page(), because
next = addr+PAGE_SIZE will be > end after the 1st iteration itself.

But I agree this is a bug which needs fixing and it can be easily caught
with 4K pagesize, where we have 4096 pfns to map within a 16MB section.


The change looks good to me. Can we please add stable tag too?
Cc: stable@kernel.org

Also, feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

