Return-Path: <linuxppc-dev+bounces-17807-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6624FF01832
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2026 12:21:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fS5B95bhzz3bnJ;
	Fri, 06 Mar 2026 23:21:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772795525;
	cv=none; b=jzRwkK8ASDA7U1nGxKaOA1dZ5znXlhRRJkSo8Je/f++NWIeVV+rtjlrmCtcrb4O9OJdzugMrbzOogqNJib8+rGkpfvAjYfQ99wumpyAr2JCvZS+VYFTdwS08CPBEpyov9huOAKjat/4RjR+pvWroe+ZhIne6SlNhG35IDBBGe0d3wvLYYrOWdi9fTWi499WQDifoiffKdgn2qQZEXYC1cr3KsPTL5BWbEaI6N7PP+5eIZXVNoHZkfEVPfP6sPloqKLN9RbS8bO+kczviDarTukKO67yDlKCX+jf7JyqZYjkG3iIYVpoJ1vATEooI3ZVZWjkA9rn2EN6ua8vl7ZrJPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772795525; c=relaxed/relaxed;
	bh=wl2tJoX9jibHX/UMVQo+WSBvQlBet4fwxgPPN7jHsIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYP7NDYZPtpgN0fc4gHc8AGDeq54Jzr6BmUJjq1bDZ/c8GSu+It7GwxCyF369R9i++QBUFIjyjyyyhYH90Nqe99Eyf2HiexecBTPZcbr8lxnhSVnpH2ngMgNKDDg+2ar1wQhaAbtWEdbrxbZjHe3jKtV/dQUe8/RSVhUEl+Us3lcoUO5EpTH7VQne+oiNlso0hfSZvCZCywD9ysnmypoFGR6yqZGxo7s2QeAjilzTpPtHnMuYjjDRguz2x4eZYHO7FvdlJaS4l4dPyz59CO0nqgcnQaHUGqmoSDfLYXmzGVITSYuE/ELTyUyqUXNhYuWsGXjbkpP/Hu5xeRkx4qgkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L1xVmcrj; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L1xVmcrj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fS3dd0f3Wz30T9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Mar 2026 22:12:05 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DDC6C6012A;
	Fri,  6 Mar 2026 11:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B95C4CEF7;
	Fri,  6 Mar 2026 11:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772795522;
	bh=bGQPv3hoIx+/WP2tckqxP1wfRPx3+N82EsJdtp7ro1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L1xVmcrjSvLrgHkDWnFdpLhM5EkUuQo+JVlT0s5xnLp0DAhNsaITOZnaG4LxedWQr
	 fCKye6WWvwjQVW5XxY+wXSRq71hWJ4Oa3nCqtZeOj3UhoHL9vVHdGltdaXAYIQ1gv0
	 nA3yeBt7hhdB5fBjhdof3Z89/pRwfjrW90qye5BkLJsXf64Clz7q85jQLUcgK1yFSJ
	 pZ+vLH5YL3wNFQq41/bYDmXr6vRVp4nErnsgvEtbJE2EIXYb/Xa667KN40IUeuNTOP
	 651FUjIHAXOlu6nk/elNWoGXSeoXUFvEC8dSMcL0jWA2bxXhZCOZA51MVNvylkSvRe
	 MnglMHCg34Nwg==
Date: Fri, 6 Mar 2026 11:11:59 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Subject: Re: [PATCH v1 3/4] KVM: remove hugetlb.h inclusion
Message-ID: <305a98f5-0a28-4eb9-a647-a30716e61cb4@lucifer.local>
References: <20260306101600.57355-1-david@kernel.org>
 <20260306101600.57355-4-david@kernel.org>
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
In-Reply-To: <20260306101600.57355-4-david@kernel.org>

On Fri, Mar 06, 2026 at 11:15:59AM +0100, David Hildenbrand (Arm) wrote:
> hugetlb.h is no longer required now that we moved vma_kernel_pagesize()
> to mm.h.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Aww this is the tiniest cutest patch evah!

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  virt/kvm/kvm_main.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 22f8a672e1fd..58059648b881 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -41,7 +41,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/compat.h>
>  #include <linux/srcu.h>
> -#include <linux/hugetlb.h>
>  #include <linux/slab.h>
>  #include <linux/sort.h>
>  #include <linux/bsearch.h>
> --
> 2.43.0
>

Cheers, Lorenzo

