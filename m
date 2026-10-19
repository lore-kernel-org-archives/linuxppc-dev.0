Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BB260ACCD2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=a0NLp93G
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7fSy4lrtz2yfD;
	Tue, 20 Oct 2026 02:23:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792423410;
	cv=none; b=f5tWKuZp5tlrcLyIUzfglKNQGP8uDI5h8pNDL0oevsqcKMUVxbU8BsPkyDRAt4cDI+8CO5XEVtypSv9o6J4EbQq8kJrO2RLWerxB02grEOEFIFkG/cDA8aM2fCPz4/0BkO0bkKFNajs7Y9B4qG/swwz9mhnqmE7w99sUSpwUP2DjYDLYRGExq+fSF9Jl7hZGq8OWa9lLaJmrjPm4DVjNr41/bLQ9MbyurT2FFHlwIbv9gAs3pq2Fx7l70tC1/yNSHXyFbOnzwhhPhuleC9b6GSQAhxziMJjX2Ge/TsCng/aO64TsXG1GpZRfMi51Q/wTaTHKiMVAxlD50N3ds3U2PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792423410; c=relaxed/relaxed;
	bh=ES6PScTn//8O/kb4uLeXWJf50MrCERiG7IFUfR8gLMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ke6kTlyKNuYolqpFhwIlXK1Wxx8vu+B4GnUAImUW6q/0XOG7p7e1rGkXTs8pTb4tpI3qvyOylrUwakUYWxuHiiXjWYjmm/KUQBzZVIGku+PKYEjYzi5kFEKXS5iB7stxbkI4JcSYrrI/gRc5spO7l2nEqPaszefafh63OR9x5RnwCotBKAN8+/IQfA6k8A7W2G142TIW+GLhc10nwlrHU6Uwu7xribQ40H54HfiJZoeRq3CSjaNaH6KdL3mnQn/iiVMmti4/8JhNJKKitZaQX/gYLDgUwh+yNhp8yR/FNKiI1l6yBUPNi7afwACbZaaPJiurv423Mf4REDqugoY8SQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=a0NLp93G; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=a0NLp93G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7fSx5KSDz2y8W
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 02:23:28 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B83E1682;
	Mon, 19 Oct 2026 08:22:54 -0700 (PDT)
Received: from [10.164.19.55] (unknown [10.164.19.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7207A3F7D8;
	Mon, 19 Oct 2026 08:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792423377; bh=afNyowLBYnd/bJcBytrONkPV+T5KeD/gmV5hsWmX/oI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a0NLp93G3qNigo9o3p9//UAu6QuGjeI7Wda5F+kjTem5KJy9fD2LHN8hQo3SVJTzp
	 kdsfz0SYrBlst0J3RUOENQkFxluaiflLW4x4rEZeyAje7QbLwdwbuhsMiRvYW8KR9X
	 DaxRC/1RaWLCyOmHY0TvnlublfXFBQ8P31CrE8VM=
Message-ID: <3cbb17e3-e201-4138-a070-0c64289a12bb@arm.com>
Date: Mon, 19 Oct 2026 20:52:48 +0530
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mm/kmsan: skip vunmap_range_noflush when KMSAN is
 disabled
To: Hao Ge <hao.ge@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
 Uladzislau Rezki <urezki@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261019054531.87652-1-hao.ge@linux.dev>
 <20261019054531.87652-3-hao.ge@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261019054531.87652-3-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 19/10/26 11:15 am, Hao Ge wrote:
> kmsan_vmap_pages_range_noflush() returns 0 when kmsan_enabled is
> false.  The unmap side does not, so it still walks the shadow and
> origin page tables even though KMSAN never installed any metadata
> there.
> 
> Add the matching early return.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Cc: stable@vger.kernel.org

Cc stable without fixes?

I guess without the fix nothing is actually wrong, except doing
wasteful work?


> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/kmsan/hooks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> index a706666db097..107f66841274 100644
> --- a/mm/kmsan/hooks.c
> +++ b/mm/kmsan/hooks.c
> @@ -138,6 +138,9 @@ static unsigned long vmalloc_origin(unsigned long addr)
>  
>  void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end)
>  {
> +	if (!kmsan_enabled)
> +		return;
> +
>  	__vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end));
>  	__vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end));
>  	flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));


