Return-Path: <linuxppc-dev+bounces-22517-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB163CD98C7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 19:32:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbt8026TCz3brB;
	Fri, 12 Jun 2026 05:32:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781206336;
	cv=none; b=RfrYVtADBpQAqjWmGSxIaIrqeNki1anwJm2SrNZ0m1MUoi3/UDP8Hy8HZTp034vT+Eh0hydkTW6R08X5DZ/qLRa11gM0sbnO64jNFOkRQoI2Kkd8y+AahQmHO5zMREdEkId2bLBCXeDWZo2nUinJ7z2QonatnXA2hgBgp8foFVBL1sy1nsD+WdTaVqm3PgcHQZZxg4XTHc6dClIBlhTGLJ2NbADnG1wQTA7YSh5Sy/yDwAeezFcTI70wYUJJFJpQiHEwjeJIGR2h3UGPK8MZiXnSqzQCbCh4I/mvhKtR+iBGMzMJ9QfLSUf3zI4PqzSyqyuHFYXDBI+NhZ4Y9as4Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781206336; c=relaxed/relaxed;
	bh=dzHuIpFbYrCgFwipPgG7Z1jCCHIP4pv/lJwgbnEmeHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TVCHazZoNI+cZ6xKk+zwNZP0vIB/4NPl+SPzdATrCdNYcOQbfvqRnTVnEWk1PZkeK4iS6NxR4WCLiaUnHwxB2NIEIfnp04H5tZWcyI2LybFMniqdLFiORctNH7dkZmlH+nfpI8o8KH+1WrrSGswG8vHKFQw+EQ2zSzwXkv9y027BxOopEech5va+QBACFXoCCTj4Fw7hI0fKqb2o3gyXKF+DTeoztYRtTTgCNEWrFSb7nWPsn1lyeSuEgU+U6CNF89mOFRMjuzrzdPHbFqaNr0OCno/6MYNoA8+OBvuFSwdqGIXvVdt12Ou/yl5E4e/rj6sBIvAM3KezSIFE1Gs/7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LNBc0IqM; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LNBc0IqM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbt7t3gdBz2y8h
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 05:32:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=dzHuIpFbYrCgFwipPgG7Z1jCCHIP4pv/lJwgbnEmeHI=; b=LNBc0IqM7rCyEMAI2eK+n7euOK
	EL5tl1qU5tthxVnxNyHYfmyt7uh+YodDHxRY7kb/0zCqPJtfg1SmBxAo5buBIQ6IcPuj+tWmnMr++
	UsU+Ylgt9hBplMU/D6nl3sv3jan3dF1UVtWpZQFSOPttuT/e89rMwcrlZioZ0DLMvDI7ULWRdrL2W
	dkzaDKtT3Lf5UsARBNJGWGckkhuUhNpvsbtSYCeN06t46Qu+XfhIDcZ+9ntdETBR5Y2LZ3vAujiNz
	ibshv6mzE8J6MFQzkNdxvtkrVddEqUPtCKz9s7Uv3JvIIOvkylLANPbrZQQ097sSpO5o+/bNCASnv
	QszFYwZA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXl86-00000009wz2-1JvM;
	Thu, 11 Jun 2026 19:31:54 +0000
Message-ID: <ac98ff55-99df-4c90-8e6b-ab1dde219b5a@infradead.org>
Date: Thu, 11 Jun 2026 12:31:52 -0700
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
Subject: Re: [PATCH] Documentation: arch: fix brackets
To: Manuel Ebner <manuelebner@mailbox.org>, Vineet Gupta <vgupta@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES"
 <linux-samsung-soc@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
References: <20260611183525.153058-2-manuelebner@mailbox.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260611183525.153058-2-manuelebner@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,
A couple of comments but overall this is a nice cleanup.


On 6/11/26 11:35 AM, Manuel Ebner wrote:
> Add missing and remove needless parentheses, brackets and curly braces.
> 
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> ---
>  Documentation/arch/arc/arc.rst                 |  2 +-
>  .../arm/samsung/clksrc-change-registers.awk    |  2 +-
>  Documentation/arch/arm/vlocks.rst              |  4 ++--
>  .../arch/arm64/memory-tagging-extension.rst    |  2 +-
>  Documentation/arch/powerpc/vas-api.rst         |  2 +-
>  Documentation/arch/sparc/oradax/dax-hv-api.txt | 18 +++++++++---------
>  Documentation/arch/sparc/oradax/oracle-dax.rst |  3 ++-
>  7 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/arch/arc/arc.rst b/Documentation/arch/arc/arc.rst
> index 6c4d978f3f4e..553851f43be7 100644
> --- a/Documentation/arch/arc/arc.rst
> +++ b/Documentation/arch/arc/arc.rst
> @@ -36,7 +36,7 @@ Important note on ARC processors configurability
>  
>  ARC processors are highly configurable and several configurable options
>  are supported in Linux. Some options are transparent to software
> -(i.e cache geometries, some can be detected at runtime and configured
> +(i.e cache geometries), some can be detected at runtime and configured

   (i.e., cache geometries),
or even
   (e.g., cache geometries),

>  and used accordingly, while some need to be explicitly selected or configured
>  in the kernel's configuration utility (AKA "make menuconfig").
>  


> diff --git a/Documentation/arch/sparc/oradax/oracle-dax.rst b/Documentation/arch/sparc/oradax/oracle-dax.rst
> index d1e14d572918..67867ea7be40 100644
> --- a/Documentation/arch/sparc/oradax/oracle-dax.rst
> +++ b/Documentation/arch/sparc/oradax/oracle-dax.rst
> @@ -438,7 +438,8 @@ that in user land::
>  The output bitmap is ready for consumption immediately after the
>  completion status indicates success.
>  
> -Excer[t from UltraSPARC Virtual Machine Specification
> +Excer?t from UltraSPARC Virtual Machine Specification

   Excerpt

> +i guess this is wrong, but i don't know what's correct
>  =====================================================
>  
>   .. include:: dax-hv-api.txt

and then you can add
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy

