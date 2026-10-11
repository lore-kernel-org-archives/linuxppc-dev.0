Return-Path: <linuxppc-dev+bounces-29193-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3298ECA9EC7
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Oct 2026 13:37:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j2hVD28FWz2yY0;
	Mon, 12 Oct 2026 00:37:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791725844;
	cv=none; b=MxTKqmqggn8b9MrBiqfjo4L8wJ9E7NQkUOLbI0O1TQJGKs9K+5NI+JyHGpxbDUtaV8gZPazs+DDYSvAueh6PX1++ZgHPh4fyu5saVwoTIm0hILGWhvy+Uv99OFXIhBkbPoP/sfTJX9BdNdQ3z74fp/CCyuWuqqt4TTHHiJzfqyliaD3VlcZTopzIFa/NdQIF6gQ66p3fdVGLAZOauxI7h7fQbJsa577vfor29l83mMOy+1t47eYxo5PaVsxJc5OXZbUR/4pvSBv4aCY/SU0djOMxOsN8XtaXhaGa80nlVfmW6/ToYRLgqq8FTDNNqjiJ9bPPcLdA/JgoGbjX4beK0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791725844; c=relaxed/relaxed;
	bh=4X8y55PrXkGOudIsFCasLzIDfqrrSmuwJHtcshJbz80=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZYlvbpRTzsnidX1Rb9pPNINVJCNaYSNHYDtORbje4N5NfJp/IwHWnL8jnmzu18oQbMPR4qgt1ey8/WYXh6rNhdI+15eKWdMHKhlTISkZRAltkiWeDxPI8LETdHs9rQAXotazE5c5hoppid79fQcA94OLyHpkbqQTGBWs1jI7UdTx3wo17b1wcvN609rKsaZS+hYfokar1b9LgVXNrlG0qfo66xp+0jzorMYbP9khHynpbInpFOMlmAFgBgxc/lPBLgoq3yKjGlhg2Yzlk1xSTY8BIMJ4q1xZv5A/XxaWs8hDD1iPGrw57yMnDkjSgmwAe/UB071b1zY25dVh2Aj9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sEuspZEv; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sEuspZEv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j2hVB21KMz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 00:37:20 +1100 (AEDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-c2acc1e170cso190326366b.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2026 06:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791725832; x=1792330632; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4X8y55PrXkGOudIsFCasLzIDfqrrSmuwJHtcshJbz80=;
        b=sEuspZEvZT05OHt+miwadEJxBFfGPlQ6GIt0aoJBlT6/mAPsqa3M4vv4dOYN8Uf5cT
         K8AaOqpAaDt4izZ63wKVh3q6oVweUB+ry0GD7AtvKoomcvKATrgtyoNCgJefopD0KRRZ
         y8c1snzrAoljhAmtmjKT4fpUg4BxLJcnuUL4g0yc6fZlQ0fhpRtf8xmkbGXDENZ+6/lb
         IGTpZuKWmVsdd3gYYS8G/Bbss+osl563FlGV2zfLNW9hj1XAvUnvlKAC2Eh5+YoJ85Wh
         MxTGe1WDzhkI8JpNuz46CLd0eLFjsCdGsoJf7sZ9VYRAei+uvkBGhvoFBrqOWD34dUQh
         pXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791725832; x=1792330632;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4X8y55PrXkGOudIsFCasLzIDfqrrSmuwJHtcshJbz80=;
        b=CXsC6igARrKq/eMrhqh3fqk7m0P3CGHm5QjpBTYgRRaVBk0MkvpVEo648fIDeFItnY
         peNK1A1vfDtwc/ElQhwHO31gEKODi/YVmBq1y+B0BDW42DC7uAVz33pX3r9plzhR0Cjc
         NsS1i5lo9sFDtQp1H8opHMUr4hDeshp6xPtwP1qX71x/zINdYXScKsLdwVrD90nMZFDH
         8r5mTleDcZntEYIUw5uIOdYclO+FXcSfluRsLf/dVel7wXhFCV4KKJW611A0segHLaDi
         7osowbxAdFBxnwWUNLYTr4XqR3czONTZJDyfuVPXI8t126v3OINg7d0eYvrXnHYI29pI
         NhgA==
X-Forwarded-Encrypted: i=1; AKwUvBzrbOVa30riCUs8U5fcUpJXcUHe/qyhvja4pwrFhmChUylTdU5IfxHHwe/xC6qTGJ4HrzJ+7nh5S4vkJ6Q=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIk/RWY/qG7ye5gcUIpD7VNrCYKf+fH1I77Rr78ouD5c6H52zOJ
	M8RpEiut56dQO/6HEUQjwmgNXmQbT1bmQUhjDrlL9z24U4qpgMC8/o9W
X-Gm-Gg: AYBFou3SDlpGn5LSH5IOusiOeEa0V6641Ky6WGt/pS38/6buvj/Y07Zv5DX80/NvWA5
	ZBKvMaXuGVmYh1QmHw2+C2eVeR6tCc7xKijj+PLbEOWteaP1AfFlYXXXgneN95t+2tVFJpebPwc
	WrTO6waXgzAIa+rZC2/TZOUBratgriA0rOsN4kBw10nMOY5cbP06aMg6DYE7bVJRiHg1AWdMdJh
	gMY+jXv6/Q34Ly354MZanaabq42K40807st8sKgpX0PaRAC/78Un5Ej4/9EZl3S6iFhe6LVtZyU
	TGVitNrPyqG0vfUffSQSGN0E2FJx/j6XOMaV7hAk63qFb2WrzYvoq3oEYYB5emf2++qqObn+znz
	dxW0TNHgN7vWOelarNVnQ+BG48HpBkcqnITrmhD6skJdQsDmYNf6t7dcTo4hvHT+pbvRw2ovLSC
	OdeslYmg1QUxqxJSBh6AqVrpRAtEj5F69dEEw=
X-Received: by 2002:a17:907:3f8d:b0:c2c:d06f:cf87 with SMTP id a640c23a62f3a-c31aa0d3106mr668410766b.46.1791725832001;
        Sun, 11 Oct 2026 06:37:12 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a7b976sm361047966b.36.2026.10.11.06.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 06:37:11 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Sun, 11 Oct 2026 15:37:09 +0200
To: Wen Jiang <jiangwenxiaomi@gmail.com>
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org,
	urezki@gmail.com, will@kernel.org, Xueyuan.chen21@gmail.com,
	ajd@linux.ibm.com, anshuman.khandual@arm.com, baohua@kernel.org,
	chleroy@kernel.org, david@kernel.org, dev.jain@arm.com,
	jiangwen6@xiaomi.com, leo.yan@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, rppt@kernel.org,
	ryan.roberts@arm.com
Subject: Re: [PATCH v10 04/10] arm64/hugetlb: drop the init_mm special case
 in clear_flush()
Message-ID: <asuRBRZS9KzC7Y8q@milan>
References: <20261002090947.869220-1-jiangwen6@xiaomi.com>
 <20261002090947.869220-5-jiangwen6@xiaomi.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002090947.869220-5-jiangwen6@xiaomi.com>

On Fri, Oct 02, 2026 at 05:09:41PM +0800, Wen Jiang wrote:
> clear_flush() calls flush_tlb_kernel_range() when mm is &init_mm. This
> was added by commit 06fc959fcff7 ("arm64/mm: Support huge pte-mapped
> pages in vmap") because vmap called set_huge_pte_at(&init_mm, ...).
> 
> Now that vmap uses pte_set_huge()/pte_clear_huge(), mm/vmalloc.c is no
> longer a caller of set_huge_pte_at() on arm64. The only remaining
> callers passing &init_mm are in arch/powerpc, which uses its own
> implementation. Remove the dead branch.
> 
> No functional change.
> 
> Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> Reviewed-by: Barry Song <baohua@kernel.org>
> ---
>  arch/arm64/mm/hugetlbpage.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 8e799c1fe0aa6..ce247b06fe03d 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -206,10 +206,7 @@ static void clear_flush(struct mm_struct *mm,
>  	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
>  		__ptep_get_and_clear_anysz(mm, addr, ptep, pgsize);
>  
> -	if (mm == &init_mm)
> -		flush_tlb_kernel_range(saddr, addr);
> -	else
> -		__flush_hugetlb_tlb_range(&vma, saddr, addr, pgsize, TLBF_NOWALKCACHE);
> +	__flush_hugetlb_tlb_range(&vma, saddr, addr, pgsize, TLBF_NOWALKCACHE);
>  }
>  
>  void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
> -- 
> 2.34.1
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

