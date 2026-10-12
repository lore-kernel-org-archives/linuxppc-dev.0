Return-Path: <linuxppc-dev+bounces-29259-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDD1CA9ED0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 10:28:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3DG66RNRz2xwP;
	Mon, 12 Oct 2026 21:28:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791800926;
	cv=none; b=KmS4DPwJuGaIdsy4eZejy9YzEQvfJCO8t/9viyN1tBq5Kh7nGVyQI6nVJSkp961GRuorKHtTe29IvYw51bZ20PMzq+4G+3a4/sMSqAByvJGEeo/ivVe6csFUXDp+2lgtRBZ25sIjEguTnNh1MGd93mnOuQyLDWE1Vqa36PktPhC1hdzA2MEfD5GsauoRjKD13+ZeMMdXVVbo8yZ6N5Y5kAhU0F/sL0s59F96wxJ7NWtBMgvZWMcBGvLnwYp3FD78tZi+Tj9P6mf96aml24E/WHcp9jEtGN5P5YaeIa/Yvm0L41bCyoF9ljytRLKVSvAVqBsXRBtb/IK1QfTIz1AhAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791800926; c=relaxed/relaxed;
	bh=9SqsLlEeY8Z7JWwzaLCKZ/Afkt3yxtAt34Q/0TSpfLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLZoOpQ9Z8OfVMWlujsp1bLPR0R7O0wZJOM7sIgJdSS219wm3O9U4hERbT60UsEGMwAZO5+Qkh6ULLNVQGeFAeuSypQWb2elJE950+FLvP5iLdxiNXZD3rna2Bb0ugvCjDFMJPY0F7qPUtLQ4Pxmc2KX6swd/Kcu10ITbLE3UNj+yBGgkiYB7xQfa3D+pj7EjEucv7DeUXEsmmsADpC4AtTOWlNfkCm/7bdidD+m4p6XXUwkXEYrGPcX3POegVGAqbEOFIdPZ0wf6porV1vF0ffg0obH5qMI1WFhcQoo3lXCYXkC1VjBhJ2dzApF75hMaD5zZZ1FOD0eC7n6gKVs4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1/3XoFu; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1/3XoFu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3DG5715jz2xwM
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 21:28:45 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B6EF1601FE;
	Mon, 12 Oct 2026 10:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A54D1F0089B;
	Mon, 12 Oct 2026 10:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791800922;
	bh=9SqsLlEeY8Z7JWwzaLCKZ/Afkt3yxtAt34Q/0TSpfLw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K1/3XoFuG4eFCz4OgQUA5uvMw5WFNnU7QPlivAAaTatqVPi3cfWD+k64Z4caemYUQ
	 6iP+1uGhOTfGoAspZ0yAGGysurE2NeOJ5wN6/EHkGksFKdoIM+uwlBCHyYUb4vQl6Z
	 OhASdimiqXso6Xgzsh0CMCMLrSLqqjdSjcJnYJYdeDH1Yelk49tF+ucS16RTNOvZTZ
	 7fpBuvNP3YxfABcb0X+tOBjhQ9+eaKVdyHibNaedLJi5idk6wxyUPKS8nCf1fLcoF0
	 uBY1H99GdHtmZaqphKNxl+QzSIWXXDfgm3VT2qELvVg9XmWjkeVJJtRzqTyryR1qV4
	 P/gDk2LoIF8mQ==
Message-ID: <af5559f0-89f8-42d7-a43b-068bbd183161@kernel.org>
Date: Mon, 12 Oct 2026 12:28:37 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/Kconfig: limit the PPC_85xx DATA_SHIFT range to
 STRICT_KERNEL_RWX
To: Julian Braha <julianbraha@gmail.com>, maddy@linux.ibm.com
Cc: mpe@ellerman.id.au, npiggin@gmail.com, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20261011113108.539470-1-julianbraha@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20261011113108.539470-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 11/10/2026 à 13:31, Julian Braha a écrit :
> On PPC_85xx, enabling DEBUG_PAGEALLOC without STRICT_KERNEL_RWX activates
> the DATA_SHIFT range of 20..24, but since the PAGE_SHIFT default is
> outside the range (12), kconfig adjusts it to 20, causing 1mb alignment
> instead of 4kb. However, the larger alignment is only needed for the
> separate kernel permissions provided by STRICT_KERNEL_RWX.
> 
> Since PPC_85xx uses page poisoning for DEBUG_PAGEALLOC and does not
> support KFENCE, let's restrict this range to STRICT_KERNEL_RWX.
> 
> This out-of-range default was detected by kconfirm, a static analysis tool
> for Kconfig.

Looks like with this change I'm now able to set DATA_SHIFT to any value 
when STRICT_KERNEL_RWX is not set and DEBUG_PAGEALLOC is set.

The range used to protect against that.

 > > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>   arch/powerpc/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index c3b6cd655606..5e2a4799438d 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -896,7 +896,7 @@ config DATA_SHIFT
>   	default 24 if STRICT_KERNEL_RWX && PPC64
>   	range 17 28 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC || KFENCE) && PPC_BOOK3S_32
>   	range 14 23 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC || KFENCE) && PPC_8xx
> -	range 20 24 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC || KFENCE) && PPC_85xx
> +	range 20 24 if STRICT_KERNEL_RWX && PPC_85xx
>   	default 22 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
>   	default 18 if (DEBUG_PAGEALLOC || KFENCE) && PPC_BOOK3S_32
>   	default 23 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC || KFENCE) && PPC_8xx && \


