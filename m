Return-Path: <linuxppc-dev+bounces-16696-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B03DEE6B49
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 18:26:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f72cC1P15z30FP;
	Sat, 07 Feb 2026 05:26:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770402411;
	cv=none; b=DKdk0Bz7dkB8WGm1gSUb1OADjmO8Kik7sV2fnjoMdBxhmmZAEhWAmMP+hCM+/YxUYHX4tKuMcRbE8fF7QjvvEnP79h4ZQBcQWfzSCwaWKdVETZz38Ax1V351k9aiDrXAMilXzPckO/eOIeH3kgUYjbjpxDACH2C4rJjfdLDL4XLdGB/KIPTga6LYuuCN4cmHo97JAftnVqzEqk/ZMwu3NDQhfYic7CdmgIJlloZ+ZGtl+WqaOYFk5LsXUf/4ShaL7n7TVHdaiiNOO29JD8xIfM4cbcbhrpuksVqrmO4n5guwQmW5qz3KKIZdNXlRyATpyLf31k1ynMB3vIeF06R6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770402411; c=relaxed/relaxed;
	bh=3SNo7xjuwB/8+PNoL+ATbF1z7Uuj4I0+NkBoS4ni4LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEO6ytYS+vsBztLYD1sb0Y62Gj/VR6iYKNxTMMvxvnJ+1kR61jYi781Q5UZU1KtTeJzqs/+efTqgz34ofZUsChPtTSkUBuUWNU5nI3kKmaXXYLRj/ktpmsalzjbxRcuB7QdhH5STlZfn50ieiFBgxgNJXjyzqWgjZO2VhWdUCKuiiwGTz4HGzsw2O0y4iE2BD7HEeOxLpRaw9Qmu7hQPrLLmleHAVm0Bau/+DtZjeHbUGNwELPyc+DFpfhTVhqilDdS+5OLvej5Lw8e7cf/crXniukNob1C24tYQZpd+AlZKodHD0V6D5oSW5OiI/VPy59/mClWvsz70XBuxLO+5fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=W65k6HRJ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=W65k6HRJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f72cB1jksz2xqk
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Feb 2026 05:26:50 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C541E44343;
	Fri,  6 Feb 2026 18:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB5DC116C6;
	Fri,  6 Feb 2026 18:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770402407;
	bh=Q+y/6ZarY1Moq1E+Yvp9Oap15mVq6+C3qIQbLI2ly+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W65k6HRJ5Hi1rr+kg5RtfkerZQBkRCJ8TcvstECu7FPkajAYwhwi325wNSexLzmQw
	 XciX/I2jujNbUiK91fHjF//z3BzRmzIRJMUP+Ca/3w5h2j63QA+94PMsYnGzLH+PfC
	 3NVQ8l/2v25rETLwSeB3lC6ge2tL84XYdxzbscwcA/4xmfCtbJEeNbMC5UQQrHm1ww
	 zdS8KXyHH0GwYKqwHFdwssGJFbmskaIKUIVOp4a2PCKldqBIS5Okyy0vejD72O41sV
	 YdgfOlDT689kXg9l6R9a7UzyrdJIz0QTZIvty9v2EyGNHupaUs20pumzX4gm1yfiLk
	 RXVdkqgSQLEOg==
Date: Fri, 6 Feb 2026 10:26:47 -0800
From: Kees Cook <kees@kernel.org>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, andy@kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	lilinjie8@huawei.com, liaohua4@huawei.com
Subject: Re: [PATCH 2/2] powerpc/text-patching: Fix possible
 stringop-overread compilation error
Message-ID: <202602061024.111ED487@keescook>
References: <20260205100517.292858-1-xieyuanbin1@huawei.com>
 <20260205100517.292858-2-xieyuanbin1@huawei.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260205100517.292858-2-xieyuanbin1@huawei.com>

On Thu, Feb 05, 2026 at 06:05:17PM +0800, Xie Yuanbin wrote:
> For strnlen(), if the compiler detects that the maxlen argument exceeds
> the valid memory size of the input string object, a compilation error may
> occur.
> 
> For lastest linux-next source, changing ppc_kallsyms_lookup_name() to
> __always_inline, using default ppc64_defconfig, and setting
> CONFIG_EXPERT=y, CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2=n,
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y. Then, when using gcc-15 for compilation,
> the following error will be triggered:
> ```log
>   CC      arch/powerpc/kernel/optprobes.o
> In file included from ./arch/powerpc/include/asm/kprobes.h:24,
>                  from ./include/linux/kprobes.h:31,
>                  from arch/powerpc/kernel/optprobes.c:8:
> In function ‘ppc_kallsyms_lookup_name’,
>     inlined from ‘arch_prepare_optimized_kprobe’ at arch/powerpc/kernel/optprobes.c:209:21:
> ./arch/powerpc/include/asm/text-patching.h:232:13: error: ‘strnlen’ specified bound 512 exceeds source size 19 [-Werror=stringop-overread]
>   232 |         if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function ‘ppc_kallsyms_lookup_name’,
>     inlined from ‘arch_prepare_optimized_kprobe’ at arch/powerpc/kernel/optprobes.c:210:22:
> ./arch/powerpc/include/asm/text-patching.h:232:13: error: ‘strnlen’ specified bound 512 exceeds source size 13 [-Werror=stringop-overread]
>   232 |         if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> ```
> 
> Refer to the implementation of fortify's strnlen(). If the string length
> is a compile-time constant, do not call the strnlen() function.
> 
> Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
> ---
>  arch/powerpc/include/asm/text-patching.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/text-patching.h b/arch/powerpc/include/asm/text-patching.h
> index e7f14720f630..ce1b2131980a 100644
> --- a/arch/powerpc/include/asm/text-patching.h
> +++ b/arch/powerpc/include/asm/text-patching.h
> @@ -228,8 +228,13 @@ static inline unsigned long ppc_kallsyms_lookup_name(const char *name)
>  	/* check for dot variant */
>  	char dot_name[1 + KSYM_NAME_LEN];
>  	bool dot_appended = false;
> +	size_t n_len = __compiletime_strlen(name);
> +	const size_t n_size = __member_size(name);
>  
> -	if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
> +	if (n_len == SIZE_MAX || KSYM_NAME_LEN < n_size)
> +		n_len = strnlen(name, KSYM_NAME_LEN);
> +	
> +	if (n_len >= KSYM_NAME_LEN)
>  		return 0;

Isn't it possible to do this and not need __compiletime_strlen at all?

	n_len = strnlen(name, min(__member_size(name), KSYM_NAME_LEN));

?

>  
>  	if (name[0] != '.') {
> -- 
> 2.51.0
> 

-- 
Kees Cook

