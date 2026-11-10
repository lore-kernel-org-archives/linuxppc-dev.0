Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DFC606A32A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L+mQY1+h
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP0sY4t7wz2xwN;
	Tue, 10 Nov 2026 19:57:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794301057;
	cv=none; b=GKw3g+P7QFcxlgGr0hAN+jY0dLYBG//grO7FHBUzOdAiBfd4gEfcgs7+0i35Ahv87aVKjhI7MYtLTA/rkgJlq4AoTyIwYvjxC6r73emWtnVrfJXHk3JThAeU8NjsT87oRIELengS80KE7nJqR6guo/I06GVu8o6WPmkUw6po2yyqn8WSuEIJJ3DfZhooTIiVgopYnRadV90i2vN6OiSB7myENM3s863bIvHSBap2doy8H9woUZZdGTvCvqPBs34Jnxk+5ndQlVPgB20a9nQwYH93yS1yi3qABe3gKhsgx5luh6Ig3DBWmHixspFVWHi9TtBej7H4VRLvb0m7ZYqdBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794301057; c=relaxed/relaxed;
	bh=N456NnosGaoI7MKxsp6e0Ms9ZTTTgDYa/PkwX0lrx9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HuM416mn7nN4EFn0+wyrYxFsafKFKOBe4kHVpGEBCsEVCqpruFmim3CEak5yNukcZ8Jat1Md9uFwSniui8ZTFqDhm1W/R76wHIITj/HQF/iPdp2yhd4ChHldrIICfuiE4MwkUKQUOKhVo5W1fp5j0GpgzVSDmlEOZnHXVYWAQ/QLf3uaw/RAlKZPowXAml9qaScJ5aRaE72TdFm0RN8uhm7gv2aftckwPh7RvQ0/cHxVlpZ8uVQekfT0mPK2flC8wHIjkdQOrEIGxv2GW+fjtxL2ie6NZGgSWwhw/eHRmQq10MKWtW6d3H6eL3eVRSRG1fvL3p+SucWallkk6LA4+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L+mQY1+h; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L+mQY1+h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP0sX5X60z2xfK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 19:57:36 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3E891407E8;
	Tue, 10 Nov 2026 08:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B2B1F0089F;
	Tue, 10 Nov 2026 08:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794301054;
	bh=N456NnosGaoI7MKxsp6e0Ms9ZTTTgDYa/PkwX0lrx9M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L+mQY1+h6ujuFTABer/civexikaWaPzRJgaRK3DJEY0/SDc7Gomhi8a30x8EK9z9R
	 zhiy9a4iyS4/Bihy3DftUvBhopjAk8TshBg1U+sU62E/izCMSSBuErYNJ2K0fWzxvV
	 jqlAVpIHb7YXYPv+kC2KtDgD+rhVY/+VUvnqlvqf3KQpzUKV6OBJy1VBylrQhBkqjU
	 VYCbFklVfkC0ntksPWfQsO6sLL4MMmoUOpNx48QH7Hp9StufHgicVxoD2ym+J+j6ZM
	 nCnrWYtPFylKVMGLD+ZNQcIPSAHa/vKSOp7CMaH+OC3Tu+xvn2JM4Fms4/8XMCudJx
	 dC5MMhHQaicKw==
Message-ID: <e89ab6eb-2fd3-4638-a3a9-fef406478435@kernel.org>
Date: Tue, 10 Nov 2026 09:57:28 +0100
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc32/modules: Reserve a PLT entry for
 ftrace_regs_caller
To: Bradley Morgan <brads@mainlining.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Ritesh Harjani <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260923175631.235276-1-brads@mainlining.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260923175631.235276-1-brads@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 23/09/2026 à 19:56, Bradley Morgan a écrit :
> Commit 7dfbfb87c243 ("powerpc/ftrace: Activate
> HAVE_DYNAMIC_FTRACE_WITH_REGS on PPC32") made count_relocs()
> undercount the PLT entries the loader
> consumes: module_finalize_ftrace() now creates two trampolines
> (mod->arch.tramp for ftrace_caller() and mod->arch.tramp_regs for
> ftrace_regs_caller()), while count_relocs() reserves only one entry
> for ftrace.
> 
> So the core .plt ends up one ppc_plt_entry (16 bytes) short. The
> walk in do_plt_call() scans for a free slot with
> "while (entry->jump[0])" and has no bound check, so once the last
> reserved slot is used up, the walk steps past the end of the section
> and patch_instruction() writes the 4-instruction trampoline into
> whatever module memory follows the .plt.
> 
> Count the second entry, mirroring what module_64.c does for the same
> pair of stubs.
> 
> Signed-off-by: Bradley Morgan <brads@mainlining.org>

I would have had a preference for something similar to commit 
c12cfe9dee07 ("powerpc/module_64: Convert #ifdef to IS_ENABLED()")

Nevertheless,

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>



> ---
>   arch/powerpc/kernel/module_32.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
> index f930e3395a7f..61152deffc55 100644
> --- a/arch/powerpc/kernel/module_32.c
> +++ b/arch/powerpc/kernel/module_32.c
> @@ -41,6 +41,9 @@ static unsigned int count_relocs(const Elf32_Rela *rela, unsigned int num)
>   
>   #ifdef CONFIG_DYNAMIC_FTRACE
>   	_count_relocs++;	/* add one for ftrace_caller */
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +	_count_relocs++;	/* add one for ftrace_regs_caller */
> +#endif
>   #endif
>   	return _count_relocs;
>   }


