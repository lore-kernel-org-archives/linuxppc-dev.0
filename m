Return-Path: <linuxppc-dev+bounces-20840-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2F2CD37B6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 08:40:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFn344l3vz2xpt;
	Wed, 13 May 2026 18:40:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778661616;
	cv=none; b=XhFtZe6/yfUHJ00k9m2WTww2D2xiOSl0VnftqI5WwDFihOumkTGWgShoWO/hy/cwFb1hCr2A5EBQB2Ks1v3HqR6sI5HDNDOKyBOUazrbc0/1ZZ+dC79+vUw8r4Y3hyN2CrRkD3EshYQnJTjzPfBSLuWcid4hbc7a0MBdvCAen7bWmst76MW3F1X0oamOZ3l8eNnBvzAR+8/bG48NzHI5lsqAbgfiu4lgEx8lWOodQyWb+Bg4nbylahIbmZ1eoanudHBeZ6B339p9iPhTRSux2B4WvM/sHEyd09SJR9ql7Cy8gLs5PnoSE6kbJdYEQ9ZWWhq/sqJRfKgFPtzcYOpDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778661616; c=relaxed/relaxed;
	bh=Dd2jCgA0g+9Jt1cNOGSEycG7aM/VX2m51LI+39kcn5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZFk93BmIE1V0gSs91iXgjJmjILg0H5MmXahVQTBwbKtbzHhUKlnEKrj+5rYzISLnJmzV7E7CmQdwdFjQTbcWHNCOir3TbS2ie/hF42Pi8fN41ekCSJWtX/pK/BmzjIy/9qiy39Wh5dhihoLhRwFUjVabLoTUEL3uOfKDQcPkWi6AE5nQ/tgFMZFPqPhKCAf7ZKgk2q/GALNw12Y2xwlDlC5B/kPIYEOGOe7OpokgwirsZbxNUD/yG7gE4MJ5onfS0FmbZ7e7Fk4RZ+Jni1cg14/oKLXXZt9waw0gGvhfHYeTD6gdWeUQgHR4nZPFLEmhhS98G6E4/IdztUAHH8glw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=On2kQD50; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=On2kQD50;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFn340MRbz2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 18:40:16 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E5A7160121;
	Wed, 13 May 2026 08:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7544FC2BCB7;
	Wed, 13 May 2026 08:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778661613;
	bh=13LRFe622XguU1NLsfV3Ba6p09OZjDFhjXPDUplgOU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=On2kQD50c1CeSLA0BlAVe3bh+GUVj4uncC/7cgHnMtbaOrrRDniULBC94dy6eSjz2
	 djLv6fWwvUdR+m85+VyTYLWyGPW1cp8lOngxujuunUkkTHFyvqi6iNQBMTMFHe3e6e
	 aTW03Op5p/T7d3KxJPF7AWzIDANS5U/x/W0pGNgFoLoBKlXL0DCvdQV1zf+aJFPPPx
	 FKUdczC4Y9UTrOVd25yGVEHsu+VFR/azqim6i572JU8Zum2z/G6jyDn/S29zSadSe0
	 kpwGcrcVJtwxyGRByZ9+vq6E2Wjjp/cxfoii/8CSxdmfaY3/tsBi/UVVNcU+Dymb+H
	 JRQtv3sKRxUKA==
Date: Wed, 13 May 2026 11:40:03 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
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
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 7/8] s390/mm: use free_reserved_page() in
 vmem_free_pages()
Message-ID: <agQ44zJDVpJXCfYJ@kernel.org>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-7-3fb0be6fc688@kernel.org>
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
In-Reply-To: <20260511-bootmem_info_prep-v1-7-3fb0be6fc688@kernel.org>

On Mon, May 11, 2026 at 04:05:35PM +0200, David Hildenbrand (Arm) wrote:
> We never select CONFIG_HAVE_BOOTMEM_INFO_NODE on s390. Therefore,
> free_bootmem_page() nowadays always translates to free_reserved_page().
> 
> Let's use free_reserved_page() to replace the free_bootmem_page() loop.
> We can stop including bootmem_info.h.
> 
> Likely, vmemmap freeing code could be factored out into the core in the
> future.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  arch/s390/mm/vmem.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index eeadff45e0e1..d8b2a60e0c33 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -4,7 +4,6 @@
>   */
>  
>  #include <linux/memory_hotplug.h>
> -#include <linux/bootmem_info.h>
>  #include <linux/cpufeature.h>
>  #include <linux/memblock.h>
>  #include <linux/pfn.h>
> @@ -51,7 +50,7 @@ static void vmem_free_pages(unsigned long addr, int order, struct vmem_altmap *a
>  	if (PageReserved(page)) {
>  		/* allocated from memblock */
>  		while (nr_pages--)
> -			free_bootmem_page(page++);
> +			free_reserved_page(page++);
>  	} else {
>  		free_pages(addr, order);
>  	}
> 
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

