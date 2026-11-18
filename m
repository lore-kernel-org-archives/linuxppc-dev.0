Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B695606A912
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yiusystl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVBYD209Pz2xdX;
	Thu, 19 Nov 2026 06:31:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795030288;
	cv=none; b=eW5ZPUuZnpXNcysiPPtQiwOUkEgEQBHAMkgJEpr6vKALt6f3N9NGNDixsgm7vEoxhOxWBCYreH9jht144CoMNfsZOXDLF/FbC8QLh2VvHGUPDekwn1DE3Vuatty0W65kjbzEVtOISpbvlnTYRWiOe2GF2dfaj/nJFVGrRnBSAsgkRXki5pW/oWdOzav02I031BPfSvR16Vz1nldFVnDqVbihZyMfUl3cm8JpQ3eqKF+Y8/7Ao8W6fX2ivSo/KPNoJ/CerGqM72lH81NyAcbGQckhESsTb3GrmIoAMIV+Zi5yVpSu4n6cmcS3fv1fxZctrJYI1QuSz9RrA2W/iBFksw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795030288; c=relaxed/relaxed;
	bh=DyoNOi8SqxQRtdWNaiooYSD8hFAkDD28ur39JiQbgr8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZij2OiFnhjKQHrtc4OhsFRMFV+9m9LT/gX6SkGbUMDZwu6NGAuySNq8+8rqvv+ATIY+jjkxKCMPCj9YHFKPYJiL4osaD2zNeEFjpS298psKnHBXkgho0RowpXW7edh5dHe6IMPNGhRlX0eEo2zAfK5DmpzJ2Ln7VBKrGQFgSyaT6EXWhoqdd9AiIPdyLpSV0J6C1QBGJHMqREWpvM5a+YubNmbGHeOivR1I/2IG3fEqDO4r22bTm/OIyWTff6j2c6jDOnzSmLPjGylT/w6NOFAdB7q3ryDLQiaR+zQ5keY+lMCYufstidX3/8xBUpSUtjw9rzx0di03MkDJKj7Kyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yiusystl; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yiusystl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVBYB5jyxz2xSl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 06:31:26 +1100 (AEDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-c511c0e2826so106477366b.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 11:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795030282; x=1795635082; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DyoNOi8SqxQRtdWNaiooYSD8hFAkDD28ur39JiQbgr8=;
        b=yiusystlGReTEYxDd0fS+i7i5sbZzxwvoONc0UEZpqTg1/82jHbfKTgb3ixarpnMYr
         zloaJL9kXA50+qrkWMIwitBxthZPB+krflW/HYO6eD7DFhtjjQ60ZtlmzbNapDgQjnIw
         22VRoIOF/OhA6HWwAieYFd0V/eKMqSiZvDk91Gi1v4EOtvW2yV1mDtjjDeoIBteRNMfg
         eAFtPj13v1S6go/ECIzoVTyJz2+tY2R5sRUln+KdRny/Z43SUBLOCUhK4Z8t5gj/CmXH
         tcn6g1BiGX5ffxJ2DMwoTMIVF7/z3OLP0ShclUmhWzAoWPJFaYkkUtMjoCCFr42FDnWU
         Qu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795030282; x=1795635082;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DyoNOi8SqxQRtdWNaiooYSD8hFAkDD28ur39JiQbgr8=;
        b=sfSvBepgIEMx6LFf/vROQM6KOriFP8UzYfbtxpkPaO6G9FZ0EJzmJV/Gcy9JIg/63D
         Q76FlJpp6xdws+XzH0klhXHiNAXRfhwH4ah5ddexUOnCr7sFPy6BouaGLHvf3nyaNh5J
         f1ensrnTbCppsD99CBq2qRgswbP0VFj3fSiZ89CKpeNTLzgujrevaKfpvWCynvC0vsjU
         N802AV/xMQI/NM0wTFWJZE48kTobek2eBJjOF7FYEceMitfSd1rVVQM6ISgXdTYtkgOu
         1qZFJOMEXZ0p83ryecGxPs2wCq1khz5EODv86vUmK6+eWmwYIwAJpiwGSNU0WF+oL6/q
         ZNHg==
X-Forwarded-Encrypted: i=1; AL+hErFqRa68/UBtRI2L8/B3m9ivEj4zewFps7I8QPRqmcAMRvj0pl0PYp5O/QYBUJVn9P4/d0sUVfX/PwatpUU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/I5QYeuduWQ3JOhPlHtZRxipZqeiTF0IQOyUm8pheSZzGs1HBg
	xTQmALV3rkndTzjmITHICu7lZHaXWisZ4UWfd3ZqBsD1iUfPuewy9hk1
X-Gm-Gg: AYBFou2MAQmBjY+K6ccXKrDBuW0hIJL0WQFXqnsEuHnf0M1jMRAVmP+mesEPtlvXRN7
	8nPN1ktIbaQCm8qa1Hh16pKD5+fIIcLb1GO/oUS1plKH8Fkzp9tRLrrNMKcCLUL/ymqEttkTIGQ
	mzynBPq4moCjK88+PMFUZ8MxSJiTbdjSKh7mCBxyHHdbTXR4b0B2lZG7Xmwh+uCeY0EzewS038N
	wzG4kQi6hf9y5lLSn/d1V/imYx/gtvdQgknsIfQIM+qLg2YA905DEEczPL0KPj5KLW1dYt2ssZW
	we4eNvtyYY8xDqJt+82EX+7e68gcRseMWUmsJM4R9IWckckoxd3QfX5m3mw5D5hTtn9NB8AhA6S
	/tg1FXoeliCfFyt/RRpSLhiqS8eefSTWxdprZI8vrCPUNtqkpJce3C+1WpqTdN/aNgweyiRLAvV
	cEj6lttL5oqjdKh3dQGHlpmmxZVykyc81E4wuWXvzG4Wo0I8+M45Yt9Y+7SL03m5326w4sxBkLF
	1RDkEqzyriCf99YL73ib1YLhcna/NsVHhgO60YnoVaUkHqQ73tdO6qN8q6y6elVY4zjEQ==
X-Received: by 2002:a17:907:3f93:b0:c2e:61e:f4fd with SMTP id a640c23a62f3a-c510debe470mr322367566b.5.1795030282513;
        Wed, 18 Nov 2026 11:31:22 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c512351bc7fsm29492666b.86.2026.11.18.11.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:31:22 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 18 Nov 2026 20:31:18 +0100
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
	linux-mm@kvack.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v5 05/11] mm/vmalloc: only flush the cache after the vmap
 succeeded
Message-ID: <av39BuCsq-dRFiMM@milan>
References: <20261116071325.263682-1-hao.ge@linux.dev>
 <20261116071325.263682-6-hao.ge@linux.dev>
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
In-Reply-To: <20261116071325.263682-6-hao.ge@linux.dev>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 03:13:19PM +0800, Hao Ge wrote:
> vmap_page_range(), __vmap_pages_range() and vmap_pages_range_batched()
> call flush_cache_vmap() before they even look at the error code. A
> failed mapping is never used, so the flush is pointless at best.
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
> Closes: https://lore.kernel.org/all/sashiko-outbox-178439@kernel.org/
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/vmalloc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index e2b63cb1592b..d99d7710e1ba 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -371,10 +371,12 @@ int vmap_page_range(unsigned long addr, unsigned long end,
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
This is incomplete. Maybe merge with 6.

--
Uladzislau Rezki

