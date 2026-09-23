Return-Path: <linuxppc-dev+bounces-27958-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DCEC98302
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 05:54:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqR3r1Ds0z2xs1;
	Wed, 23 Sep 2026 15:54:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=35.89.44.33
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790142840;
	cv=none; b=Lcjswot8IXuIQP8RP3KzNgUJok0G/Dr1awbd1Lcr6G1LEygGvgFpbj+1ZZjQp7ZVt6adIBRHfiTpZve4PBQxkquWd3cyOc19dXoD94fCbb9GEz446rpiHju2QEh1lV/kKbuMCuVKqR7Wnrn6jAtzsvbq6BEhZwvXTXXlscd3l1CAXYgh2BHo1qOT3EayT0n6u2itiZYZiTwBneMsIZ4QXUtC7niVINYUnXBE9rW0u4Sx6vhvr9CefMlZJH5oVD+u3k5/5Ka+BzszEAQEHx56c5qTgxH8ov/5OcJU1fJ+btScRecdtvdkD0vIHi1nbW+5Whjg2N+/qEOJlw/DwUN6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790142840; c=relaxed/relaxed;
	bh=OTwx4w9402ve7XEVGULW94SFMv5Tl4N0r/phY59l/8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g76KJ41xljIKBBhSLgl20YHQyUsIKV6BUrO2Q+vXcXIgJV66SbiL9eg+TdE2dBWHdNw+kNjwHOALDezHGar0PMnxSOJ+gFNm9TVnInuRJHmuYIb2+afHMWpdWyOJd04PatxYFP6hRx3i8yZggUJ2gDXLzehphUuTCkPTtZ0ugOFaquF4A28hDWhH4PfxZwIwB9g0rJqFmKN65amanw/Ks67bmoCohmlZlY6Nckj1MjKfZOpTNNKxTXfDTg/tGZg8K6w2GCDjedjl8CIGt1U7+BYk6927TCRgDZ/frqPKr7ZeWE7UJwrKSx+6gCFDoYV1Y1TABanUa7W4kTFuT+PWoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; dkim=pass (2048-bit key; unprotected) header.d=embeddedor.com header.i=@embeddedor.com header.a=rsa-sha256 header.s=default header.b=UEfECF5T; dkim-atps=neutral; spf=pass (client-ip=35.89.44.33; helo=omta34.uswest2.a.cloudfilter.net; envelope-from=gustavo@embeddedor.com; receiver=lists.ozlabs.org) smtp.mailfrom=embeddedor.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=embeddedor.com header.i=@embeddedor.com header.a=rsa-sha256 header.s=default header.b=UEfECF5T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=embeddedor.com (client-ip=35.89.44.33; helo=omta34.uswest2.a.cloudfilter.net; envelope-from=gustavo@embeddedor.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 339 seconds by postgrey-1.37 at boromir; Wed, 23 Sep 2026 15:53:56 AEST
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqR3m1Vtwz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 15:53:55 +1000 (AEST)
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id 8vQ4xUKWMaC0U9FoXx8mr5; Wed, 23 Sep 2026 05:46:42 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id 9FoWxGrudkH8b9FoXxuSiU; Wed, 23 Sep 2026 05:46:41 +0000
X-Authority-Analysis: v=2.4 cv=d6X1yQjE c=1 sm=1 tr=0 ts=6ab367c1
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7T7KSl7uo7wA:10 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=GayhebFrRX0EwB9RMoAA:9 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=OTwx4w9402ve7XEVGULW94SFMv5Tl4N0r/phY59l/8k=; b=UEfECF5TgEW3
	KGIj5aT/C29st5hACjcHuxVLxBSR5tOuRMT/rmWCDjiSiI+BzQMiTkM0qDAMxbHWK0jWLqRxQEoAr
	ro+Og+0qw7/KJY6TDfCr4pB3RfKZ8OPRmY157FqncfrM24JAx8Vq1qu9OrVkMYXgVi9TNeOphlT6a
	4XmHPaMDFoirjhxsqZ4uTut9sorVP017tpwM+iI1+6BS5oO2mfQIrBgWaYEYcjTbj0xYX4QGH9Zpd
	5J3/hzOu3YEydLLXFA7/I/gyV41+wvDJxLQiZwGHasg9hWiT3sD7NJRft+6+8i0pYdAUSndXnjvkA
	87RFK8+svAIE2Wy1cUW05w==;
Received: from flh4-125-195-69-90.tky.mesh.ad.jp ([125.195.69.90]:43316 helo=[10.203.100.34])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100)
	(envelope-from <gustavo@embeddedor.com>)
	id 1x9FoW-0000000204S-0DM9;
	Wed, 23 Sep 2026 00:46:40 -0500
Message-ID: <3e9d09ef-5766-4f19-aa8c-641e15572950@embeddedor.com>
Date: Wed, 23 Sep 2026 14:46:35 +0900
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
Subject: Re: [PATCH] bus: fsl-mc: Annotate fsl_mc_io.portal_virt_addr with
 __counted_by_ptr
To: Bill Wendling <morbo@google.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Justin Stitt <justinstitt@google.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
 codemender-patching+linux@google.com
References: <20260922223538.2287676-1-morbo@google.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260922223538.2287676-1-morbo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.ozlabs.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 125.195.69.90
X-Source-L: No
X-Exim-ID: 1x9FoW-0000000204S-0DM9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: flh4-125-195-69-90.tky.mesh.ad.jp ([10.203.100.34]) [125.195.69.90]:43316
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 56
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFrJG8rUJjEORZN4ZZkzNbEZygQymQBRmP7VzFBfX7PlytdgDf+N1iZ+rYrLNjuRVAs03vClPXWP/E5vp9PN71ve4/0rDJdidXDzrTqvTIMhwhRg+DlR
 8OPqL0Kl6+ueNcXfxrglnvKHuZc1AoHcT2yxYpGajZDjqRu+ual06RLSgYdLvPc46BOGimO3FneTk4O/COWu2nlhjUQrC4H3FxHbHmgXGyIpwiw6SAQyKOVq



On 9/23/26 07:35, Bill Wendling wrote:
> The GCC and Clang compilers provide the __counted_by_ptr attribute,
> which is used by KASAN and compiler bounds-checking to detect
> out-of-bounds accesses to pointer fields.
> 
> In "struct fsl_mc_io", the "portal_virt_addr" pointer points to the MC
> command portal virtual address. The size of this allocated portal in
> bytes is tracked by the "portal_size" field within the same structure.
> 
> Annotate the "portal_virt_addr" pointer field with
> "__counted_by_ptr(portal_size)" to enable compiler bounds-checking and
> harden against potential out-of-bounds accesses.
> 
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
>   include/linux/fsl/mc.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
> index c25f0f7e6dd4..0b2c0eb9b605 100644
> --- a/include/linux/fsl/mc.h
> +++ b/include/linux/fsl/mc.h
> @@ -336,7 +336,7 @@ struct fsl_mc_io {
>   	u16 flags;
>   	u32 portal_size;
>   	phys_addr_t portal_phys_addr;
> -	void __iomem *portal_virt_addr;
> +	void __iomem *portal_virt_addr __counted_by_ptr(portal_size);
>   	struct fsl_mc_device *dpmcp_dev;
>   	union {
>   		/*


