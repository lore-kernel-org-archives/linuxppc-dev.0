Return-Path: <linuxppc-dev+bounces-20341-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D92FF8875
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 09:42:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5q2H6SQGz2xjk;
	Thu, 30 Apr 2026 19:41:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777542119;
	cv=none; b=HnHvn3bFj4ikRPwSvk82YR4YhcSxhGqqchRwuITqB9/dYbMk/m3GDs7K9dkd1NSY4nEKlELkaRt1OWhi1wuw8jetTQFYvIMT36l8sK4OF2rg0INVLrcJ6hI92M3s2VCWVwzQEtQ8yYqt0BDUIfun+fU2zA98cfZXoPxoab16ODq2g8iUHcivNiw62jg1YzyHnZcc4+jB9Wr+zK+JExciXPisjgyDPwP+CBRpimRke7DXqnUCHRHR5UeH68NpopSESxXJBhtt1FSB1UvJah/s2R2/ZootKF9O/Cw34ItF4zDDUw0BRNdeN552VVt4Ju5FNOj+7OpFstN5c+5AI1FLTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777542119; c=relaxed/relaxed;
	bh=uazoOlOjZ6Bwic4vOwJ+SsVAc08nIFMmgH2X4YlFl6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmLZ7oVucxAqHXP5/XfEElnnUtIyoIB+3btAVO+2510MWFHCaKlD1V65rcAQtMQJ8fTj4rYiE3u9jgBpjWp8JpvpqrAF5/5TLtau4duEdZNfO1fwmwpJmWGD+IAPDqIVX++YbQy0XL7qdSnB57NoXMpgC5m17qH/pcpHkB1sNHrnHTjKr4z7vcw5FA6Gdre9wP7W91dgVUEzYeOU3b2t/3PmSJPkxgrYq5cl1R507wPYIQhJAc1dK50NZqQ0r3PX3ALsRtTvTvQZspbwJt2+pPqVxR1QO67S0eucrUDZp2Bc6nrHwcA9BZdO3mdxKbUFxaile7ndHiwMVWEmdxkV4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s3s0sJkM; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=s3s0sJkM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5q2G5jyDz2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 19:41:58 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7C34740215;
	Thu, 30 Apr 2026 09:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276A1C2BCC6;
	Thu, 30 Apr 2026 09:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777542116;
	bh=OyBu5tnNP4uLFUjReaE5JPX/B70f++bdmkd1kLWqPn0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s3s0sJkMQ3cRJ+QpbRVXFug+mQS/53IZbKzYG0wtujLyLzKgivKx7lNQr+JCfLowP
	 M8kf15e8SHdyd37DIaUvFjIFQtIItxVyKwPgFVWh61wdqUuYtxhi1BUuucAEGKnOG/
	 byikVw2YmDvx363PzwgBLRr+nVtb4R94JATBE5//says1RdvpUObW9zHOItJK5nVnc
	 RbSkw16ySQalxLs/jjcwKXNbzhfi0GmZ8JUHJ4F4KxtWMm5GvtCKhrAlIkDEfUYJuP
	 62eJo9jzX2sFYJL6BJ9H1jz2WrL3MjmY41CaUpQ2JN2d+qLiu6OdGTwBk+ZFl4PvW6
	 9HT/1hE/3C7Ew==
Message-ID: <c755a2d3-6447-4531-aea7-f279eea8f2f8@kernel.org>
Date: Thu, 30 Apr 2026 11:41:49 +0200
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
Subject: Re: [PATCH 2/2] powerpc/text-patching: Fix possible stringop-overread
 compilation error
To: Xie Yuanbin <xieyuanbin1@huawei.com>, andriy.shevchenko@intel.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, kees@kernel.org,
 andy@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, lilinjie8@huawei.com, liaohua4@huawei.com
References: <5cfae419-427a-471b-8bbe-645f56442e2c@kernel.org>
 <20260430072913.62348-1-xieyuanbin1@huawei.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260430072913.62348-1-xieyuanbin1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 30/04/2026 à 09:28, Xie Yuanbin a écrit :
> Hi, Christophe Leroy!
> 
> On Mon, 9 Feb 2026 14:41:51 +0100, Christophe Leroy (CS GROUP) wrote:
>> On 09/02/2026 14:25, Xie Yuanbin wrote:
>>> When CONFIG_PPC64_ELF_ABI_V1=y, it seems that the try of lookupinp
>>> the original non-dot symbol is missing.
>>>
>>> What about this (Only the compilation test is performed):
>>> ```c
>>> static inline unsigned long __ppc_kallsyms_lookup_name(const char *name)
>>> {
>>> 	unsigned long addr = kallsyms_lookup_name(name);
>>>
>>> 	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && addr)
>>> 		addr = ppc_function_entry((void *)addr);
>>>
>>> 	return addr;
>>> }
>>>
>>> #define ppc_kallsyms_lookup_name(x) ({					\
>>> 		unsigned long addr = 0;					\
>>> 		if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1))		\
>>> 			addr = __ppc_kallsyms_lookup_name("." x);	\
>>> 		if (!addr)						\
>>> 			addr = __ppc_kallsyms_lookup_name(x);		\
>>> 		addr;							\
>>> 	})
>>> ```
>>
>> Good point.
>>
>> To avoid duplicating the string I'd suggest:
>>
>> static inline unsigned long __ppc_kallsyms_lookup_name(const char *name)
>> {
>> 	unsigned long addr = kallsyms_lookup_name(name);
>>
>> 	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1) && !addr)
>> 		addr = kallsyms_lookup_name(name + 1);
>> 	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && addr)
>> 		addr = ppc_function_entry((void *)addr);
>>
>> 	return addr;
>> }
>>
>> #ifdef CONFIG_PPC64_ELF_ABI_V1
>> #define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name("." x);
>> #else
>> #define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name(x)
>> #endif
> 
> I would like to submit the modification as a new patch, and include you
> as Co-developer. Do you agree?

Add me as Suggested-by: instead.

Thanks
Christophe

> 
> Full of the patch:
> ```patch
>  From fbf07e5c1a97da7c8572435537f2b92213ede39d Mon Sep 17 00:00:00 2001
> From: Xie Yuanbin <xieyuanbin1@huawei.com>
> Date: Thu, 30 Apr 2026 14:15:26 +0800
> Subject: [PATCH V2] powerpc/text-patching: simplify the implementation of ppc_kallsyms_lookup_name()
> 
> ppc_kallsyms_lookup_name() is called only twice in the kernel code, and
> the parameters are all constant strings. strnlen(name, KSYM_NAME_LEN) is
> called inside ppc_kallsyms_lookup_name(), when the compiler detects that
> KSYM_NAME_LEN is larger then the constant strings,
> the following error will be triggered:
> ```log
>    CC      arch/powerpc/kernel/optprobes.o
> In file included from ./arch/powerpc/include/asm/kprobes.h:24,
>                   from ./include/linux/kprobes.h:31,
>                   from arch/powerpc/kernel/optprobes.c:8:
> In function ‘ppc_kallsyms_lookup_name’,
>      inlined from ‘arch_prepare_optimized_kprobe’ at arch/powerpc/kernel/optprobes.c:209:21:
> ./arch/powerpc/include/asm/text-patching.h:232:13: error: ‘strnlen’ specified bound 512 exceeds source size 19 [-Werror=stringop-overread]
>    232 |         if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function ‘ppc_kallsyms_lookup_name’,
>      inlined from ‘arch_prepare_optimized_kprobe’ at arch/powerpc/kernel/optprobes.c:210:22:
> ./arch/powerpc/include/asm/text-patching.h:232:13: error: ‘strnlen’ specified bound 512 exceeds source size 13 [-Werror=stringop-overread]
>    232 |         if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> ```
> 
> The error can be reproduced in the following ways:
> Use lastest linux-next source, change ppc_kallsyms_lookup_name() to
> __always_inline, use default ppc64_defconfig, set CONFIG_EXPERT=y,
> CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2=n, CONFIG_CC_OPTIMIZE_FOR_SIZE=y,
> and use gcc-14 or a later version for compilation.
> 
> Since ppc_kallsyms_lookup_name() is called only twice in the kernel,
> and the parameters are all constant strins, simplify the implementation
> of ppc_kallsyms_lookup_name() and avoid calling strnlen().
> 
> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
> Cc: Kees Cook <kees@kernel.org>
> Co-developed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
> ---
> v1->v2: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2F20260205100517.292858-2-xieyuanbin1%40huawei.com&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C525ecaba66ea4e3b15f208dea68a3fa1%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639131309913493421%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=aaK9PO2mGdxM3vuJBVP0lcl6VKfqs3VKih5VPcG0IxI%3D&reserved=0
>    - Not use strlen()
> 
>   arch/powerpc/include/asm/text-patching.h | 42 ++++++++----------------
>   1 file changed, 17 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/text-patching.h b/arch/powerpc/include/asm/text-patching.h
> index e7f14720f630..2d3f698cb4f1 100644
> --- a/arch/powerpc/include/asm/text-patching.h
> +++ b/arch/powerpc/include/asm/text-patching.h
> @@ -221,39 +221,23 @@ static inline unsigned long ppc_global_function_entry(void *func)
>    * - For ABIv1, we lookup the dot variant.
>    * - For ABIv2, we return the local entry point.
>    */
> -static inline unsigned long ppc_kallsyms_lookup_name(const char *name)
> -{
> -	unsigned long addr;
> -#ifdef CONFIG_PPC64_ELF_ABI_V1
> -	/* check for dot variant */
> -	char dot_name[1 + KSYM_NAME_LEN];
> -	bool dot_appended = false;
> -
> -	if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
> -		return 0;
> -
> -	if (name[0] != '.') {
> -		dot_name[0] = '.';
> -		dot_name[1] = '\0';
> -		strlcat(dot_name, name, sizeof(dot_name));
> -		dot_appended = true;
> -	} else {
> -		dot_name[0] = '\0';
> -		strlcat(dot_name, name, sizeof(dot_name));
> -	}
> -	addr = kallsyms_lookup_name(dot_name);
> -	if (!addr && dot_appended)
> -		/* Let's try the original non-dot symbol lookup	*/
> -		addr = kallsyms_lookup_name(name);
> -#elif defined(CONFIG_PPC64_ELF_ABI_V2)
> -	addr = kallsyms_lookup_name(name);
> -	if (addr)
> -		addr = ppc_function_entry((void *)addr);
> -#else
> -	addr = kallsyms_lookup_name(name);
> -#endif
> -	return addr;
> -}
> +static inline unsigned long __ppc_kallsyms_lookup_name(const char *name)
> +{
> +	unsigned long addr = kallsyms_lookup_name(name);
> +
> +	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1) && !addr)
> +		addr = kallsyms_lookup_name(name + 1);
> +	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && addr)
> +		addr = ppc_function_entry((void *)addr);
> +
> +	return addr;
> +}
> +
> +#ifdef CONFIG_PPC64_ELF_ABI_V1
> +#define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name("." x)
> +#else
> +#define ppc_kallsyms_lookup_name(x)	__ppc_kallsyms_lookup_name(x)
> +#endif
>   
>   /*
>    * Some instruction encodings commonly used in dynamic ftracing


