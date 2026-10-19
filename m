Received: from smtp.lore.kernel.org (ip-10-30-226-214.us-west-2.compute.internal [10.30.226.214])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058A360705DC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dquZ0zsb
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF848CCF2E6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 14:55:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7drv2qGtz2yYK;
	Tue, 20 Oct 2026 01:55:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792421743;
	cv=none; b=ep5+CuWbFb9XHyzJvsMIPb+gNA6gEAhDz1YOLHbC4FUygnEv9JEfRda9Qs2aXXizNVbqNbG/3SJU3NuhBP8AohYwCBI+R9LR2jehzmgyHMtdRKIl/IBkbGbc3bw6xKaspqTUvEhNicYVxBGSKfc5+R/d2jQcFGFYhsGLZZiXKXi8oHBklXt7Gxj++l/YBDdxWAhbI1rIXWn2551RRbaDMjHN7xW29/SBhuL+8vvLB9/Di1+9EZzE+n8Ylk1m7mB64ppaRuvjErgQTQUzFeQKL7ntWeBmJifWkgwyMh7j68sy3KMJDh9ZzMEnwjBhaTubnxhyTDdT3IoVwkun5B2WHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792421743; c=relaxed/relaxed;
	bh=S4hxhJmvPn7AcnQ/ZWKG7QsPda8INusHl4ZJ/PDgaQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpHVzlkeSNIeoVy/QcaeEwpOhgVcmo1MUWebFXXEtFESVQP8ZUgPyCZUbLqMTUvNf9FH3Fk+0oyj586HjvxICJrxEZvBZg3Jvk5uhBwO7VWsRLg38VKpUPYPHcznmwe056gzr8ZDQxaw8Qy9ujuQtgNIwokq36rRhOj3xok6eb7H8zM6eqQkbMPFGrMdt2S3R9IZjV9+chLH2aLXWNpEofFAuxduVMWmFH0fMZvkIqhpQNsuTClyRN9TT53u1jaIQLbO/O1+7Q5thnd0XiTIibUzggzSce9F7acEiiGhzI5tEGEa56tiNFdQpQUkjq3X5c/QY6Ske1FVJrfStKy+iQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dquZ0zsb; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dquZ0zsb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7drr5NB8z2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 01:55:38 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 268E01D34;
	Mon, 19 Oct 2026 07:55:03 -0700 (PDT)
Received: from [10.164.19.55] (unknown [10.164.19.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 637A23F673;
	Mon, 19 Oct 2026 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792421706; bh=JePCMnx8/su8AAS/ZVIThUJhxAH7QCVSw2VlUvAcrQc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dquZ0zsb8TUxQqrVKFHzKecjJPxmFn9BPWmSPeUt4pp2uBPq8APeVyzMisLgssh1v
	 TZU/WEC3H5pP58oL4cP/OjMccLrvXkUY+5HU52USqCNbPlN+hEGwvXf1yR7AkaGpR7
	 gskM7Oy6PccGDnhdnyilm74wYQa3HEvySaszSEwE=
Message-ID: <45c5ebc9-a4d2-44e6-a08f-79676ecb0579@arm.com>
Date: Mon, 19 Oct 2026 20:24:57 +0530
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
Subject: Re: [PATCH v2 1/5] mm/kmsan: undo the shadow mapping when the origin
 mapping fails
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
 kasan-dev@googlegroups.com, linux-mm@kvack.org, stable@vger.kernel.org
References: <20261019054531.87652-1-hao.ge@linux.dev>
 <20261019054531.87652-2-hao.ge@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261019054531.87652-2-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 19/10/26 11:15 am, Hao Ge wrote:
> kmsan_vmap_pages_range_noflush() first maps the shadow pages and then
> the origin pages. If the second mapping fails, the first one is left
> mapped, and the callers do not roll it back. The next vmap of the
> same metadata range hits the stale PTEs again and BUG()s on the huge
> mapping path, or gets -EBUSY with a WARN_ON() on the small page one.
> 
> Undo the shadow mapping on that error path, the same way
> kmsan_ioremap_page_range() cleans up after a partial failure.
> __vunmap_range_noflush() only clears the PTEs; nothing has touched
> the shadow mapping, so no TLB flush is needed.
> 
> Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()")
> Cc: stable@vger.kernel.org
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>


>  mm/kmsan/shadow.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
> index 0c88d89bf0d6..2166086d3dc3 100644
> --- a/mm/kmsan/shadow.c
> +++ b/mm/kmsan/shadow.c
> @@ -258,6 +258,10 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
>  					    o_pages, page_shift);
>  	kmsan_leave_runtime();
>  	if (mapped) {
> +		/* Undo the shadow mapping set up above. */
> +		kmsan_enter_runtime();
> +		__vunmap_range_noflush(shadow_start, shadow_end);
> +		kmsan_leave_runtime();
>  		err = mapped;
>  		goto ret;
>  	}


