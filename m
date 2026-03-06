Return-Path: <linuxppc-dev+bounces-17808-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2595DF01832
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2026 12:22:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fS5C13y1Cz3bnJ;
	Fri, 06 Mar 2026 23:22:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772795551;
	cv=none; b=iuioZ4XVv3t3a6bQg753h+H2nMoYT+W5ZZjpe8QvcWfOgB/zfsKEKuiJ4eTBI/a14BiCI720ZMF/bbe/t4Odn07VsA1+ZyDhhpf/pgQvOTqIXmL7tjd1fQ+NuiLITqfMtwCXI+ZmEJHPzyPW4NsZPeo4dDXpfB85fHNtp/B7m85AhAiDz49HZPFMOrqAki3e5gevxAOu7N8uKOUxq/6Xh1cEsiVSULiJlNh1thQKyTc4K85xHgAWa3XKEjEMT42StR3hY02EqqqvihAsdqTqXfWqR9N3jesX4VaRYjq8uBVl2FzKJcK/VufTkROicTKBte5/qf3Gc0NooMt96Yh1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772795551; c=relaxed/relaxed;
	bh=nVHR+ctvMJLIt7XjpskcNJsliA9Ir3/a+o9mlmeey4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3nF7g8tICcbK+tO7KJXRESm+0jttS+R3p3b4rj/XHf332Qfset8D00D+7xTYoXezt2rO10C2b4HQPwBor//cWMZv+1JQk6C3f5cIGi5S183xh0KZQ+wKXzW/rzR8F22aPKyvIEO+uuqbzuTwMwUSXTDQ1aAIT/A2IUKbzHrGmTEHzvut/NqAM77vx0RAZKopNDRMLQWEqzY5voieR6/nF3ZwiIBhIN+84F3j2q2LbYdwSc8QSLEVX4L0SWuB0owefJ9Gry62GOBucSm0uoojFv5Hb8n1HYjmlMUiqTDtlDkUntJ+6uD/6NHS58BjNhxqQTZK+goaqNr8IRsVKwb1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jEvdu6gn; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jEvdu6gn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fS3f70hXmz30T9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Mar 2026 22:12:31 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4C1D2438A8;
	Fri,  6 Mar 2026 11:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3080C4CEF7;
	Fri,  6 Mar 2026 11:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772795549;
	bh=0Ke5eZ//15clBpSAjnQRnmOa0hryc2fy44XRrBa5OZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jEvdu6gnFrMR/jaM1eC2XOup9hwsvDUiBF11qNOw09xdkEyBBO9FAE9ams+odLwvd
	 33sBKFnJaUA+PNxEDQfpwSqHvWcGNBc4/7WW379CL92582oYijNtnOOELNIR6MKgyw
	 WP09l3vJL1R65yPpsXkejCBvIOx5CypvyWMn4ywh8jJKvKdQXERPnkBu5Fey7G/0J9
	 H7CGTyaXAEQcbhiBzD9f3vJCyhgVzdz3tDU/OErQ80gE4HJXgLniNvA4X8G6Sby6d8
	 cKW4Ximsknhlr+thYxHOXKZACMFOoz8Yw6/gYqkEXcSy9XnOMWPMmnb/hSRgpczViu
	 XJcuAdCXwXIcQ==
Date: Fri, 6 Mar 2026 11:12:26 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Subject: Re: [PATCH v1 4/4] KVM: PPC: remove hugetlb.h inclusion
Message-ID: <7d708a94-d25a-45cf-a49c-a86a6d1be753@lucifer.local>
References: <20260306101600.57355-1-david@kernel.org>
 <20260306101600.57355-5-david@kernel.org>
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
In-Reply-To: <20260306101600.57355-5-david@kernel.org>

On Fri, Mar 06, 2026 at 11:16:00AM +0100, David Hildenbrand (Arm) wrote:
> hugetlb.h is no longer required now that we moved vma_kernel_pagesize()
> to mm.h.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

You've gone mega cute on this one too! <3

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  arch/powerpc/kvm/book3s_hv.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 08e5816fdd61..61dbeea317f3 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -36,7 +36,6 @@
>  #include <linux/gfp.h>
>  #include <linux/vmalloc.h>
>  #include <linux/highmem.h>
> -#include <linux/hugetlb.h>
>  #include <linux/kvm_irqfd.h>
>  #include <linux/irqbypass.h>
>  #include <linux/module.h>
> --
> 2.43.0
>

Cheers, Lorenzo

