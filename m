Return-Path: <linuxppc-dev+bounces-20750-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E83CCD4855
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 07:45:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF7tB43xBz2yb9;
	Tue, 12 May 2026 17:45:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778571922;
	cv=none; b=ghQZArQeSDmEWwhYe9m46dtqn8QBkZjJGxdDixLs7IO8UnCAMrB3ExTRGPEKN0NLO7l82/8/pgeiGYSvvyk+MJfY5TrB0Rjra+zUnUoVx+nCE81GLGrmIRadc2hbq+kALGnlEZZLCMw94VlgvJBsAlTHhHd0mmyMmPo3z9mjsxujAFj9HV6VExS2zwMRBuHCqsF1RuwMAbgntfMTebkQO088SudNvramcYAhU54/9fRoTuHOPJUAtFcBnP73RZK2qldC92Lw5CSh2umWfY84mScE6qVzYk10LifGTQKmvjd28Kk4ULl0plV2ZN7utk5bde/tKT+Usiv7s8Lkt7TePw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778571922; c=relaxed/relaxed;
	bh=YuUpqcwRSMeMl5pOLaTVyc6TdYwqJl65snzBr5xo1y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWQmNv+BPDEHJeVNiD4us8sT+88eiX122NXsPZRpMf9cnLm7+q5D9AddeuNONV+lmg0YG8a7ghwkU2jETw4FBcNZ1YyiyKUkmtbIATO5yN57LaIm182l6QkXTXfLo4mLH+ydB7v1aY2vNcbyNqDmQ3oIde+C1qQ0N0hqQjKoDECuiIAa1GMrdbontiJ9vTgCal6+Cl04pTz+MHCcdg7gGqyKzRQ938j0AU90iRMRQgrcOwyJsTwSJ/59WtyKU9R6DFKemh1wO+rQlPMG7VFRA3rbm7dtcUOYvi+YcxglphtYuPiLjfXpl+i/0tbwn8CUxy1COvy61K/RWmikTccKuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=CgldYc+8; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=mhocko@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=CgldYc+8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=mhocko@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF7t90yy5z2yXj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 17:45:20 +1000 (AEST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-488ba840146so45992535e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 00:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778571916; x=1779176716; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YuUpqcwRSMeMl5pOLaTVyc6TdYwqJl65snzBr5xo1y0=;
        b=CgldYc+82u0iuLWSmVXa9M1uV8rVxZa7syJRQc/HTwoHn6GFr81eeTXvKD7jL4Panq
         uagIGD20UR4tvLbgHorDeHA3QRQruDjNhel4Ocrt2Z8SyViET0O5SKv+Dpn4Cb0WTJ3B
         hK5gWX/chhYx5xkqAE3kK5j45VOCFMQ16hD28/oTXWD6Bfz07JQbYzLuIvniT9ftMZcB
         P/OmRtVPEFZTGrz+bF9u/pecOKKi9G6H6XbU0w6FKyCPrh9MXKJR/2X2nVliS7L/MV5l
         YWRHkynACvdubaxgMMxbsqBbg4zcB1Tp5XsHrmgISgj6K+/BhLCMcPlqkkZxkaDVJhqm
         6Tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571916; x=1779176716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuUpqcwRSMeMl5pOLaTVyc6TdYwqJl65snzBr5xo1y0=;
        b=TLrjV7ylq77Kvp0++OwvYfgUi3hm57pEPFVgIHXXKZo2wQYUZBCO950PFdYo2H8OxH
         LFGTfc6zwgqNf8pWzeQgO1K1Lo8+XDSrdPQ+pEAVfPo+wXOWTH2NulrwCVVDYg4flJgr
         Pgb1fYNZO1/V/TQEwsvnGSo54No6lFBLkurud2A2i7LTKNKOam0sSBTMMGcU7qrJjcrh
         06XK+o4G9UTGYoXTLhNlHmu9ZT6K3A7lcE7TKU4KcOg7tFm/fBIPXj6HxBrrVNdbLU6a
         yxLUYnuaS7RXe5CeKuYm5k6H7y7sVs/TbcZease/UXMv5XZbqbXxPML3ixJKSOojDv8k
         5yEQ==
X-Forwarded-Encrypted: i=1; AFNElJ8JpP1OCXki9w2bpA03iix2bEwpNW6k42LV0WRj7q9MGBtd3ecYcxYiALZ0MyYiyJ2uILVmxTD3HntbXjM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwQ/FAeErZq1VEN9EuFl4aGnsZRPehXfBxfGflsoh+oTay7hszy
	G05s4Z55ARAhikB3JBz3Z+4Z/Hm5uAfzK9Cc7L0lEITOcd5DrC9tSdmfCn0pbUqMPjE=
X-Gm-Gg: Acq92OECqsxTXAl7+qbhHgwDRKr4NALpErZABSaPvwr1mn2DNUlA23dRqwYmrbkFIbF
	8tk+mTDClaLDSFieV3Zs2GZ02HOxf92iAhLtvQ2muLWX7AXbSgGcP+sdXhbJSfpDb6Srg7kO+IK
	tKFVPvioXJqvpPinSjF8agwoKMiDRogYoYibS6VFzoFyb2sVEswMDUqWXu51kefY6p01WKtSAgo
	YPSZYf89pJM10GdFAlfmtzLeCGlWxtsWEIhp97VqC+CW+nd7XgUmCnHLW006ieq7c4iccxeHG52
	JfOEadxjMFjSnI3ibiJgttOK9IcoSkWzXsp/oMpKzv38JJI2nYCwI40aIcaIiw7bcDwgyLA6TBW
	/E+00p6bB8f0EzIUX29jZbDFkstELg3kOqFBa9dOH7KuC98gmPU6LqlkxmJhmEnS81UUbw7PUUE
	cdzmvfEP+M0ptATbi0a7NlquSDEdng+iITnMiN
X-Received: by 2002:a05:600c:c058:b0:489:1aed:1658 with SMTP id 5b1f17b1804b1-48e8fe7b8bemr18623855e9.23.1778571916418;
        Tue, 12 May 2026 00:45:16 -0700 (PDT)
Received: from localhost (109-81-80-123.rct.o2.cz. [109.81.80.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f63beb7sm13428995e9.35.2026.05.12.00.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:45:16 -0700 (PDT)
Date: Tue, 12 May 2026 09:45:15 +0200
From: Michal Hocko <mhocko@suse.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/8] mm/bootmem_info: stop marking the pgdat as NODE_INFO
Message-ID: <agLai5lr0CQRZLBK@tiehlicka>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-5-3fb0be6fc688@kernel.org>
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
In-Reply-To: <20260511-bootmem_info_prep-v1-5-3fb0be6fc688@kernel.org>

On Mon 11-05-26 16:05:33, David Hildenbrand wrote:
> We removed the last user of NODE_INFO in commit 119c31caa59e ("mm/sparse:
> remove !CONFIG_SPARSEMEM_VMEMMAP leftovers for CONFIG_MEMORY_HOTPLUG").
> 
> But it really was never used it besides for safety-checks ever since it was
> introduced in commit 04753278769f ("memory hotplug: register section/node
> id to free"), where we had the comment:
> 
> 	5) The node information like pgdat has similar issues. But, this
> 	   will be able to be solved too by this.
> 	   (Not implemented yet, but, remembering node id in the pages.)
> 
> Of course, that never happened, and we are not planning on freeing the
> node data (pgdat/pglist_data), during memory hotunplug.
> 
> So let's just stop marking the pgdat as NODE_INFO.

With the last user, shouldn't we simply drop NODE_INFO?

> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/bootmem_info.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
> index 74c1116626c8..cce1d560f094 100644
> --- a/mm/bootmem_info.c
> +++ b/mm/bootmem_info.c
> @@ -62,15 +62,8 @@ static void __init register_page_bootmem_info_section(unsigned long start_pfn)
>  
>  void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
>  {
> -	unsigned long i, pfn, end_pfn, nr_pages;
> +	unsigned long pfn, end_pfn;
>  	int node = pgdat->node_id;
> -	struct page *page;
> -
> -	nr_pages = PAGE_ALIGN(sizeof(struct pglist_data)) >> PAGE_SHIFT;
> -	page = virt_to_page(pgdat);
> -
> -	for (i = 0; i < nr_pages; i++, page++)
> -		get_page_bootmem(node, page, NODE_INFO);
>  
>  	pfn = pgdat->node_start_pfn;
>  	end_pfn = pgdat_end_pfn(pgdat);
> 
> -- 
> 2.43.0
> 

-- 
Michal Hocko
SUSE Labs

