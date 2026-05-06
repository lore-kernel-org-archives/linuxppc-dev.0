Return-Path: <linuxppc-dev+bounces-20499-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84471CD3424
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 06:37:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9Qfc4QMfz2xpp;
	Wed, 06 May 2026 16:37:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778049448;
	cv=none; b=MsgL60BW9kbpnIp5dQJCbN9KjIIp+VRThggq3L+t3VMpmiqR2hb/YkTTn86ifPXMSrrd3Pa4pnpc36hz4L9jwnC5+Of6//OU7P2+ghk3YmOGwVhuYavAZ15teAX8rIG+MjK4YBi1/9BrJTVR/ejRU/IZR9ry7zZH/3F2yk7TZcxkSJyfXP8K4uKRq7+IDiW8zvJL70qfHcFR5CUv7gHN21UiCtkG85Z0WroUW+Yxi97HX2YuJZVXaYie6D+p1rIM7bJ1KumdmE1iPaZB4XevuUL+9q1cK0kWpl9eZbnSyRxpVCne7giUUpqPhU9IL6ROUmGQqm9NjriDCjjSijtTyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778049448; c=relaxed/relaxed;
	bh=k9fto3FsFEWyAp5Mx+drFzCGJlFB6eH6NLZB2Ngp5tU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjlgbfQlBqRBG75WEke7/94Iey5TvBy/j1BUAdHGEY1MKZ9Cdbht6GidxiIBmIO5bYT6SF2DgGPf8WWEk3TLwS0e2+UKkC/4B34xNLEy4XOQYC9sh5z1f+PSlyuKuB6+SwwqodOz5G6gjj1mgUk2yCMLgbpychXcBjymPK6EikuFC81FOEFZu6O38eR+AEY2Kqfyg9NcL3x9vVK8VJrEfkELKpff/uOYon60OCSucSfvg67zM0y9z1ZlEQyMOS9Rwz+JdA4RwZsbKfbZTM+mFJ9vpa2S3BsPXIvTo+ms6yE0VbVdhZmGV4tqCNoQ+RzM2KHbLKrR80GJVPJb3yW7qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YJWTpQr3; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YJWTpQr3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9QfZ5T4jz2xFl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 16:37:26 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 57BEB6024D;
	Wed,  6 May 2026 06:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5BDC2BCC4;
	Wed,  6 May 2026 06:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778049443;
	bh=4NVCgsre8Hue6TkSMQx2WGSTptIfhreDDsi2DSmsfK0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YJWTpQr3XRNPLLO7qb7d3dSz+seP5/upwyJK7Lo4XioLYb8N6ja3y6HqYUAsVS1/j
	 AcNEMvYJCDD/Y5PFwSITWMvyiodqXp7MqBF4tQ7Mwytwu8s2DEF7gvp3o2npd0sqpm
	 lMD9ESkVjQKRHTc7D6EXMJr9ZbqHnA3R3heybjYaW1OSlJJ4wJGDk12G8McgwFEvU2
	 VSQm6KHZl8Wn/lCyVjGfmczXyiAG+R+wiX3RfZtaOBv4Q/hi2LTrchWuDg/n4G5PkJ
	 KKCeLqn9h95x/LxYD1z1mbvZSmuUM2uikAZhJ+qMElZbrvV2g+CqfmyhiKdt4pf00I
	 YEAnLdt2xDamw==
Message-ID: <8bb836b5-daeb-491c-8588-5cde81580577@kernel.org>
Date: Wed, 6 May 2026 08:37:19 +0200
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
Subject: Re: [PATCH V2] powerpc/text-patching: simplify the implementation of
 ppc_kallsyms_lookup_name()
To: Xie Yuanbin <xieyuanbin1@huawei.com>, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, andriy.shevchenko@intel.com,
 kees@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 lilinjie8@huawei.com, liaohua4@huawei.com
References: <20260506021143.13797-1-xieyuanbin1@huawei.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260506021143.13797-1-xieyuanbin1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 06/05/2026 à 04:11, Xie Yuanbin a écrit :
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
> In function 'ppc_kallsyms_lookup_name',
>      inlined from 'arch_prepare_optimized_kprobe' at arch/powerpc/kernel/optprobes.c:209:21:
> ./arch/powerpc/include/asm/text-patching.h:232:13: error: 'strnlen' specified bound 512 exceeds source size 19 [-Werror=stringop-overread]
>    232 |         if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function 'ppc_kallsyms_lookup_name',
>      inlined from 'arch_prepare_optimized_kprobe' at arch/powerpc/kernel/optprobes.c:210:22:
> ./arch/powerpc/include/asm/text-patching.h:232:13: error: 'strnlen' specified bound 512 exceeds source size 13 [-Werror=stringop-overread]
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
> Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
> v1->v2: https://lore.kernel.org/20260205100517.292858-2-xieyuanbin1@huawei.com
>    - Not use strlen()
> 
>   arch/powerpc/include/asm/text-patching.h | 50 ++++++++----------------
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


