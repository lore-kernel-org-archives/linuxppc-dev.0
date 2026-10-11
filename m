Return-Path: <linuxppc-dev+bounces-29189-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8597CA9EBD
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Oct 2026 09:45:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j2bLb4m0rz2yPR;
	Sun, 11 Oct 2026 20:45:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791711927;
	cv=none; b=imqWSfi8uhsM+w1IZPCtsGsgjqX0Tbikto3UxDhcYxbweZAHkd6FwA5VeRUx4ZsIfIfYcYEz/n2qssIl/5QvicK18bWEO7M7xBCDfCVVbh+z7SXbI5HkYOYaT0fAZp//7vF7hMuGKizzcqqK/LgFqUwdpq7kREpZQ/7nXFH1ySI/5oPAmHJtCn2AUglti/t4YPJfMb71zuAvsfnQFoe2z4P4V+L/zrE5ophG+h36AtOZ4lcp67FnICdYecApg8I0F2fSUQVXYsrdr5F6rePW3oLHBy2FtUbFpMIVUTE4VTLftZaWft9tE1JWz/4n4/Mh/xTYOYVodq7PrKPZ3stxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791711927; c=relaxed/relaxed;
	bh=kMWKtk6aRSbfvQLUR3KyOPOC0cuhIr7sFz+mSYCpkyE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dmwvz6XqPeb1tLi3mmnWOZ2SL4pSojt0LLYiDK/7rcBfEzc5XnA1y2m3AONQA3pdGyaxKDdXkqfYpnZ9oVkAQG+C9WW8Bi/6my4IywLV0x21GVr7iI3jhSyNWSnFmYxnuusuhgCI8lyFEuJtVQ3eQhc0Jk2tQ8N6zimNrnwKy7dpWp6a5U9kOs6JyBh3joNvdq0aPw4QGzZ9iVjXkwBNw7kMpKTk/MQgUHdL8/CVW333LUbjSot5iCMLmv6gSWpOpkPuSBvkBFn87INlI1F6IAzLRAO06ZUkAfJRwivHWLljeize9oNrsIEFXEjdKRhYeEX7GX6NsKbYKP70smjZ2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iZnjgZEW; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iZnjgZEW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j2bLY4gsrz2yDm
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2026 20:45:24 +1100 (AEDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-6ab006eb282so1289556a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2026 02:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791711920; x=1792316720; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kMWKtk6aRSbfvQLUR3KyOPOC0cuhIr7sFz+mSYCpkyE=;
        b=iZnjgZEWYCYssPSlH425ZA5h+k7C1XsnWOgIWC8WuKiTLfPVXPCfXI1nawHT2PY8eY
         dXtzq3cqBx7xYxGiBaU4R0LjCahvd7Ti9Bp3x2YV0QyeuI+2dJtzaVmYKbAOWVlViPCS
         +2CFUDN6PaAQQI00qFIImafQdViAMkmCf1WjE0UZckKaQZR2BBlh7l5btC5BChgiAbqy
         rBlVifi84M5JoxQ3ADj8Rjd0EbsTmc3bvx59XGQ9T4Lh8rny1HHPTvq2uUxMGJ+YzGkz
         9A7PNZsxB4lDzHLzitqA8tXYPaokbae3BoYBp3zLKEi8fBzkBfpOxBVaH4FjxmK3yAyD
         R4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791711920; x=1792316720;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kMWKtk6aRSbfvQLUR3KyOPOC0cuhIr7sFz+mSYCpkyE=;
        b=IhxJlobUVAG83jPd2y7+DhKfLrUFNCxbHk+cYW6C9qfd6H83yGb+TDuQ/aZVpwLmqc
         lTgFp7E5mTUIfYyyi1PIKiXEnonLhcfAHOZLpt9TPtk7rDtsSN531ptdFndFKlTJM708
         aEUvqfvP2K5fvsVQrlrReu/k9C1jTDWcr8L2m3U4TriH2+9Q4hNtOAOE3/J5sTFh/MYs
         p5VgmT4QCvpRXd5+m/td64k+R3HNJ7jUWVvH+wJ1E1EXxwZaij6sEfzrMwXyVBut2+qv
         E24/AZuWf2A94vU9gQ2HPWWaEg+xknzpbDEfwgTqA/Tz8Vw/n8KJi7lPs3QMxVOKzsdA
         Y8yg==
X-Forwarded-Encrypted: i=1; AKwUvBxFKxQBuNZQuEkXrPa57flLdfRaxPMIXEnWQf5cbN1s836rfHFdGa0+lWsqg1S8O3Z2qIpRBxm7C58qZH0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIkeSR28pUDTryYidT6PztRdz5FksPmOWkGZP+B5fK1NO0rikjl
	v9rj+xCHuqn6xhkw08fOGTZ/DLlCefbp/sF3IwGD/IPT0m8OM6zThZUu
X-Gm-Gg: AYBFou2CAohkluM4+pUrtrjMUFjsiZw2CAyFYV3f/JbKYzpCTZFysk3qTuQ3kXO9fF+
	RzNSjgPgF6UCamqqMF0nVaNur0BLsP4vssc8zUXzUI0i/yZ7nWuuYlSEWS3SyBtby5n/CEK2aX6
	KkVSu2UKDlMfGQm5CG1EjuIm1vAtBfENA4SlVCOcvATz+CfnPviYr0/dh7ksTfDnfVwovmdA/Hy
	RRsZv03NM0+0Q3MFx5DNKAJ6MQ5VPbGaMi+Xrroxv38lYmMY/dYdNAJLgEBPp4No0oF2hBltKWt
	Q1Ht83buXIt0JhGMOq7aAnbLzK9A056SM9ROgZQgRAwjKP5sm1nD8ZwKXBB2STJVMKAJzlSb9rU
	wLYHI7GnirADX18EAu17UzpKoLdVqyc5fiNpNf7iDF51FXoJ5BJlJrcNFfsGGkjFoPcMIRmK7ao
	cebNq1kTsONr1z9VgCd87+ez44QZxXhUYE1UH5/cX0qSMMpg==
X-Received: by 2002:a17:907:8687:b0:c16:4e5:944a with SMTP id a640c23a62f3a-c31aa02a1ebmr650442866b.21.1791711919938;
        Sun, 11 Oct 2026 02:45:19 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9ad0ad1sm347200666b.77.2026.10.11.02.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 02:45:19 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Sun, 11 Oct 2026 11:45:16 +0200
To: ryan.roberts@arm.com, dev.jain@arm.com
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org,
	urezki@gmail.com, will@kernel.org, Xueyuan.chen21@gmail.com,
	ajd@linux.ibm.com, anshuman.khandual@arm.com, baohua@kernel.org,
	chleroy@kernel.org, david@kernel.org, dev.jain@arm.com,
	jiangwen6@xiaomi.com, leo.yan@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, rppt@kernel.org,
	ryan.roberts@arm.com
Subject: Re: [PATCH v10 05/10] arm64/vmalloc: allow
 arch_vmap_pte_range_map_size() to batch multiple CONT_PTE
Message-ID: <astarANeoldvqBxc@milan>
References: <20261002090947.869220-1-jiangwen6@xiaomi.com>
 <20261002090947.869220-6-jiangwen6@xiaomi.com>
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
In-Reply-To: <20261002090947.869220-6-jiangwen6@xiaomi.com>

On Fri, Oct 02, 2026 at 05:09:42PM +0800, Wen Jiang wrote:
> From: "Barry Song (Xiaomi)" <baohua@kernel.org>
> 
> Allow arch_vmap_pte_range_map_size to batch across multiple CONT_PTE
> blocks, reducing both PTE setup and TLB flush iterations.
> 
> Previously the function returned a single CONT_PTE_SIZE for an aligned
> range, so the caller mapped one CONT_PTE block per iteration. Now, for a
> CONT_PTE_SIZE-aligned range, it returns the largest CONT_PTE-aligned size
> that fits within both the remaining range and the caller's max_page_shift,
> so a single pte_set_huge() call installs several CONT_PTE blocks at once.
> 
> Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
> Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> ---
>  arch/arm64/include/asm/vmalloc.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
> index 4ec1acd3c1b34..c29704a19e276 100644
> --- a/arch/arm64/include/asm/vmalloc.h
> +++ b/arch/arm64/include/asm/vmalloc.h
> @@ -23,10 +23,12 @@ static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
>  						unsigned long end, u64 pfn,
>  						unsigned int max_page_shift)
>  {
> +	unsigned long size;
> +
>  	/*
> -	 * If the block is at least CONT_PTE_SIZE in size, and is naturally
> -	 * aligned in both virtual and physical space, then we can pte-map the
> -	 * block using the PTE_CONT bit for more efficient use of the TLB.
> +	 * If the range is at least CONT_PTE_SIZE and naturally aligned in both
> +	 * virtual and physical space, return the largest CONT_PTE-aligned size
> +	 * that fits, for more efficient use of the TLB.
>  	 */
>  	if (max_page_shift < CONT_PTE_SHIFT)
>  		return PAGE_SIZE;
> @@ -40,7 +42,9 @@ static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
>  	if (!IS_ALIGNED(PFN_PHYS(pfn), CONT_PTE_SIZE))
>  		return PAGE_SIZE;
>  
> -	return CONT_PTE_SIZE;
> +	size = min(end - addr, 1UL << max_page_shift);
> +	size = round_down(size, CONT_PTE_SIZE);
> +	return size;
>  }
>  
>  #define arch_vmap_pte_range_unmap_size arch_vmap_pte_range_unmap_size
> -- 
> 2.34.1
> 
This is arch/arm64 code. Can you, Jain or Ryan from ARM folk review this change?

Thank you!

--
Uladzislau Rezki

