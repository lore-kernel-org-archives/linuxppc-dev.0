Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B8E606A33B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vUmD1jWd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVB585G0Dz2xdX;
	Thu, 19 Nov 2026 06:10:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795029036;
	cv=none; b=bebCCeJszprWBOymxSu13Ufmb4w/TkxGpq3DeTkuFF11c5LuzymwG2AI7adQSj/gDRBuNyi2JyYezZeoqgA5leT1xgWAAVp0s/osuVur4uuQmLg6ZBwe8YYN8I6hoIxDSaxsKTZnvKGTm8d3weAPuVJPPEuaQfeXDgiZJl38uoLiezXbiPgCSrBuS040J5gW1kp2Pjs7bJjsRqg3+6U/LK+qpK9V/nIBr8xwQJkSLc4hx54Od/DP3NJYTTj2u371wXpqpxp+9J2lc7v5IKhqRQcnI31bPYGfT44mi4po+ubaRmKjyrIYajS5ZQZIeWKiikCFno3wgO/5ChwVg/KxKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795029036; c=relaxed/relaxed;
	bh=iVQ48tYQcgbZ0/KEDLqaISGszEZvhwKB3BC0TwvqE4M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2T/FrovoG3ZnIZGXwqysU4kDh6uk9XOZavLQI1HiLaLrewLO8vBdDh80nxt2hq17L1olVOsqHMTGYvxY4f1oT9vDu4WUTdgT77OWvdhaTUa4pQJvHJTm04Cq3t3G/BTOgshLLa+juYDxVWiq9oZz/8tlZWGfOveJxYKuMD3tcqfk0WvpjHWQsKjaYxEZZVWyS+9Rwhcg6akv0/R0u+f+fNyHvCUCzkSGsyHqZKlDd62DJGFX4XoRnnR1ZNYKNNFd0N/0eS/ZIkAGC1IqFmvExRiS628BhKtMAs0Y8atXGI9f87MJfmTIb382lwARogv/AUk8STBkRhnueXl8sTBHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vUmD1jWd; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vUmD1jWd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVB573yb1z2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 06:10:35 +1100 (AEDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-6b8977f2785so1571451a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 11:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029031; x=1795633831; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iVQ48tYQcgbZ0/KEDLqaISGszEZvhwKB3BC0TwvqE4M=;
        b=vUmD1jWdLEgRnfSSrwnJuj2yR8CrSFCa/YuwVqUHTfZQm1OV8FFi62rEI4WazVNiAa
         W3Yv66IAUUHftq5RgGWZLrAmrPKTidk0xh3jZYXH/7whx/au/bCxllIIXBvNyGLbjUgc
         kHAjudGJi2eLZsqB6nOLAmf4PJp00XRsJ/+bW6FJl7TN9IBno591W2SSYwB6/K0L2/zN
         pFULyUG053ioCd44eh8qHqyiBaLDv3LsKXDDU+TkfeVZA/Wh8sldD/+UfsqKcdoZo/GG
         /pG+SmRCQQTnmhz2ZdccELW8Qu2hIDvtMrl2+9DPg3DQ647fje0Inda6rRFZ274a+Fek
         LUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029031; x=1795633831;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iVQ48tYQcgbZ0/KEDLqaISGszEZvhwKB3BC0TwvqE4M=;
        b=CqT4xHtff/KV4FozcxvqCfMHJfpjgT1VoEC1x4bUi6xSftAGwNSf/mpoXVDHLCHtbK
         MjsCpf/2eA9RzlO7FXRJq2cMUaY0JtEW1Yx0zF3cbAJvR1P4liQ6wKHrKYmQGn8Kf8Pk
         QVAgcxJrli5lfhROTBt43aHloisC/C8ZffGVpIt3KrUfKFzMF58FYDoDfWat+sPh0UKk
         5ZoYFbUMvR+K6ptjHM9yVSzhTKZmk5UqtdJO1oVNKTHuaPEwTxqhddWCj5fuRDUmyeYE
         N3SW2dUvthH8QzA1q3UuKYtVoFvx5coA7UjqjAy341yM6/WY66tw4xGuoAaWi5OjbL8S
         fiJw==
X-Forwarded-Encrypted: i=1; AL+hErFp83pFSHmlEFlhqPikZzPY/zqdE5vHV9eR/7FSAr8fkP63FgJhY+zYHH+987Sa96AZqf6RZAST3jx5c5s=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+IMppdTQVvE4HcMhtCm0HTEMG6ZTLG9kW5rAkgE1N0wJzqMRSS
	x84ijtsBjkfKWzTf+17Rg7K7VC/A8hzFEu98k0rjQO0R1Wq7oEfR0EtJ
X-Gm-Gg: AYBFou05J+xUcTu7xq9+v/BQi+oyxFvV95O1oDUr7yxBxMhlLdWKIDdznE3NdwbyD9N
	ty7YFnEPJAt57LJpQ1rxRoiPU5wtw49MTN2SR09AFP0Nazl3lwNfrotOdz9x4Tjgt60PAuIz8Sq
	myvSELhm0EEgsy6P+V+aiUVBHjh1jVKOUdLlCeb85G1l39ieR4KwhzfwHz4whaAKakQgWjfeocz
	iF//pwBDBv6u+mg3R4hyFLNICn+4x8EqZRJug8iON56l9lzDwAXS4iMeNL4/MXKyxicnKsXo/OB
	8Lg7rozgtTPBaaW7b5tp006rymnjfVVckSXD5ENLtfvONtIf8KRRxYWOf0nc9yfy/7czew4LW0m
	6gnahvG5othf1its+P9L6LUN1LGaYi6m5YeUqr93IeevpqmIRwSw4FhoNyFBh/corAJzCuvfZDt
	wlH/yny/QPRG/lsifBp0hawBlUH7ukglx5Iay9odkl/yCFWoA4LXYs9loUb4/r9jGVcTzMV7ED3
	eEXP8rbyGQBVaAX5nhAm3KE0nS9pQNOORSBiE+RPtbwy84N3BhbZAGtFHXMDht0dbjGfA==
X-Received: by 2002:a05:6402:1d4b:b0:6b8:80e3:d58a with SMTP id 4fb4d7f45d1cf-6b887eb1272mr2966644a12.23.1795029031397;
        Wed, 18 Nov 2026 11:10:31 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b888ef9423sm1460511a12.3.2026.11.18.11.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:10:30 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 18 Nov 2026 20:10:28 +0100
To: Hao Ge <hao.ge@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: Re: [PATCH v5 03/11] mm/vmalloc: reject an unaligned range in
 vmap_page_range()
Message-ID: <av34JPIcIOVdF0kL@milan>
References: <20261116071325.263682-1-hao.ge@linux.dev>
 <20261116071325.263682-4-hao.ge@linux.dev>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116071325.263682-4-hao.ge@linux.dev>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 03:13:17PM +0800, Hao Ge wrote:
> commit a739e6b557af ("mm: vmalloc: WARN_ON if mapping size is not
> PAGE_SIZE aligned") put the check in vmap_pte_range(), which is too
> late, because the upper levels may already have installed page tables
> for a range that is rejected anyway.
> 
> The pte loop maps whole pages and stops only when addr lands exactly
> on end. An unaligned end lets addr jump over it and the loop keeps
> mapping past the range. An unaligned start maps the page below the
> range and usually misses end too. Such a range is never a legitimate
> request.
> 
> vmap_range_noflush() has a single caller, vmap_page_range(). Warn on
> addr and end there and bail out with -EINVAL before any page table is
> installed, and drop the check from vmap_pte_range().
> 
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Suggested-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/vmalloc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 3c0d9e69b886..a168f6f20f4f 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -125,9 +125,6 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  	unsigned long size;
>  	unsigned int nr_pages;
>  
> -	if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
> -		return -EINVAL;
> -
>  	pfn = phys_addr >> PAGE_SHIFT;
>  	pte = pte_alloc_kernel_track(pmd, addr, mask);
>  	if (!pte)
> @@ -369,6 +366,9 @@ int vmap_page_range(unsigned long addr, unsigned long end,
>  {
>  	int err;
>  
> +	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end)))
> +		return -EINVAL;
> +
>  	err = vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
>  				 ioremap_max_page_shift);
>  	flush_cache_vmap(addr, end);
> -- 
> 2.25.1
> 
LGTM,

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

