Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B6B606A321
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qg9Ok6gZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQKBf4tMRz2ynW;
	Thu, 12 Nov 2026 23:16:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794485818;
	cv=none; b=kvZsfMTEpNl4iUbMX1J5SmtO+7mZN1B+jKQBl/8Dm2tRsXZIbCCbfUaGThMDQWK0aX2DyfzjSi0Ylt3c8mRvt5e7h8i6Bc582A1zIffgE40/yP6xdvw58+P++NIwy3WMr5RafFOr4kWCOls+tNfrIqReko8wqonD+Z4AlxObG6I+vKStwchPiak5L30g/J1oiI4rntUIkIqBesxh6Ugg9F/Pk8wBYOu+xp+7da2EXhBkXhVfR/pNOhe0WxOAYgLq1uobZUi5zNZ3aE3PHcH3wqjQLnp5vAVSdfjg8j82+9gind83MlbwT3Hnffy0/LB/yL+5DiZclQuu2BcU1552lA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794485818; c=relaxed/relaxed;
	bh=fkghkLc+UM+Ih/ovzmI/ipH5f/tVvmlQK1TTNKFCOPA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1Ev+b2gA3AT0PWx3hRvQot2XrLCqLD1SGbDw5D43SkCuU3sroTJhO8aCCJ9EeX/TMtXShNhLV8qRnmiZ2s9TVaKpoeRphyPFhp/okETvZM9bCvC71xRP9hXJieNCjxYr0/FS1B1iwtH42hEdSu5W2NFanTU7+k8FLizosQmGeV0EqPRLrT8/qk2kPOmhMVXNTvd/xUKayAa+ZKZWEKUYxvJ0zGs7CwrbaM3hRCJQ8U7HzSTadnd5yvFMofcNofgsFvSromJ2BjGIW2zqaes7w8kM0c0ndEIHDeA++2u6Q6jZxGqinUlgDQ5hu3Fhqksn8NgfqXvPRbpsHd+5x8fKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qg9Ok6gZ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qg9Ok6gZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQKBd5GcCz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 23:16:57 +1100 (AEDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-c4682977f9aso546787866b.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 04:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794485814; x=1795090614; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fkghkLc+UM+Ih/ovzmI/ipH5f/tVvmlQK1TTNKFCOPA=;
        b=Qg9Ok6gZ3CFkh1+ZRpgCqTYw2FSkgg711hRtzNxOnhOGQA1P9sPTD+3Dnm2KoGX8SU
         vi6R2q9osyqssu9K4dC9V4gIFLupZtbPbetg1kvEehXTEAq5EflAw+UzBGiPA0/c4bWW
         W9ASe5KIeMRCLMru7C79Z5sb7FoYhqshsHHv3af3zx7GuLpXuhqaIzkdPu82QXnXW432
         nCiccn/1eHMRvq471144MsRbwZFe46yZox81XnNpQ5qXWPbiqEOlwqIhmdD+pWx336ri
         rXGmVK8KjsT/r7Xkv72NFXLrZSIKKXsTYu2j1ueimtwrD4PUk8HLpnOTGKyrhsq+NotX
         EUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794485814; x=1795090614;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fkghkLc+UM+Ih/ovzmI/ipH5f/tVvmlQK1TTNKFCOPA=;
        b=w3veRjjPH1ROjFtaiYSxc8ki48aljV/gjNfw/4cRi3V65rDKIiQLvDHuq/Qyvi5Ub7
         sta5+4zv8Wc+7dBX57aAAs8zdYvHrrfsh0WlbFm9q7W/MMmOVYHe5Jpn40hG9P6isSeV
         h3qe/abSZBBM2tSZbMuUUMcYltqo9UZPtfhqSse9ycUN3VQhIfaO16VBfepFOoHfXHcY
         /AqFgi9qtF1CZheqo5+GRwskBBpIFwVMd/yOUiZWUk7I85uSD6okSOFM5gCv81DRFF35
         XZKmQEvlyqMri3bgYFV0wYsVkpPjmHhS5JwSaYNhjAqK+3TRBfdKqkV2X+YTOQ61qBPD
         V7oA==
X-Forwarded-Encrypted: i=1; AL+hErFx5ivzMmtOByo+VgyoewluB8hzH+wF1NE2R4mVoMrQldCCsUeNKk8PlB+WBTm38JXpzOVBYZmNSPwVbwY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9EpJMVfMQd438EHOWgzUDlLnFWi2hdFd3HEopAbj4qIZk9Iycs
	ckpZx7846LRdomemx5Luh1RfdpPidFKjw2h03rW60KP1qZxulpLzPHFN
X-Gm-Gg: AYBFou2QZHejhLnOAnalcwUroJWxNePLdHyv22smtglUjx2BJlqy9vxrNK8Xn2TcDt4
	TVB1i/qPtAItlsx0IdFuzUeJUAwvWWC4UEKD7Uw5gtDhgHvpA02pghQhEYy/7GucHr3K67ueXAX
	cL9Jvb7mGoyFB4+BRgdhSoW11Z+Jh+nupjecg1otou43Wi4uGe1TA3+3/Nmd5hRdjTJC3Cm4bwF
	iRxRRIQ3cZ+Mdj5rRmePV35tyLlqdwkulGjyslq42IPPJtnZa1lWZHu50OHJJUaQ7Qfy8P/EPkV
	MYWk5RLVNVI6jJIludohJGw+uXkKFRwhDPvUIpUxBBDnsDcpGTP3qXONOAUyOn2SLMaQHqOzD0Z
	LNNvjcDSq/evgMiDWElhlncrXPTLTXok+bYO+6nu6HGsjZl4VTz2j7K88q6i33XBVIyJFRKbxJN
	Xu63XdxRYBwsUxroQ798eZgCRPsEkhQ4I0LAS8bjQBXsjToWq9vgKcP30dem2F2zGGyDz1f2916
	n7cfQDasxnEk9UkjExQLW993R2xYcITHb/5TX3ZKDOPg93zTzpzkglLZuzEb/xzw6ZNpQ==
X-Received: by 2002:a17:907:3d0a:b0:c42:4750:8d33 with SMTP id a640c23a62f3a-c5066b46008mr455415066b.28.1794485814178;
        Thu, 12 Nov 2026 04:16:54 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a618abesm330293966b.50.2026.11.12.04.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:16:53 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 12 Nov 2026 13:16:50 +0100
To: Hao Ge <hao.ge@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
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
	linux-mm@kvack.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v4 6/9] mm/vmalloc: only flush the cache after the vmap
 succeeded
Message-ID: <avWuMhLKno4LXNe-@milan>
References: <20261110112546.261415-1-hao.ge@linux.dev>
 <20261110112546.261415-7-hao.ge@linux.dev>
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
In-Reply-To: <20261110112546.261415-7-hao.ge@linux.dev>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 07:25:43PM +0800, Hao Ge wrote:
> vmap_page_range() and __vmap_pages_range() call flush_cache_vmap()
> before they even look at the error code. A failed mapping is never
> used, so the flush is pointless at best.
> 
> According to the Sashiko review it is worse than pointless on UML:
> flush_cache_vmap() there is flush_tlb_kernel_range(), which syncs the
> PTEs into the host OS. Flushing a half-installed mapping therefore
> leaves host mappings behind for a range that was just freed again.
> 
> Only flush when the mapping, and for vmap_page_range() also the KMSAN
> metadata, is fully set up.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/vmalloc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 0565cbfe325c..3f98056f8c7e 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -369,10 +369,12 @@ int vmap_page_range(unsigned long addr, unsigned long end,
>  
>  	err = vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
>  				 ioremap_max_page_shift);
> -	flush_cache_vmap(addr, end);
>  	if (!err)
>  		err = kmsan_ioremap_page_range(addr, end, phys_addr, prot,
>  					       ioremap_max_page_shift);
> +	if (!err)
> +		flush_cache_vmap(addr, end);
> +
>  	return err;
>  }
>  
> @@ -758,7 +760,9 @@ static int __vmap_pages_range(unsigned long addr, unsigned long end,
>  	int err;
>  
>  	err = vmap_pages_range_noflush(addr, end, prot, pages, page_shift, gfp_mask);
> -	flush_cache_vmap(addr, end);
> +	if (!err)
> +		flush_cache_vmap(addr, end);
> +
>  	return err;
>  }
>  
> -- 
> 2.25.1
> 
Like Suren noted, vmap_pages_range_batched() should be fixed also.

--
Uladzislau Rezki

