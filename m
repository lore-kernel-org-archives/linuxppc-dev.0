Return-Path: <linuxppc-dev+bounces-25031-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC23BC53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 16:47:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9JD51SbZz2yll;
	Thu, 30 Jul 2026 02:47:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785343669;
	cv=none; b=hNasJJtG8PKiKR0JcBOPZqaXuo95U7eQ6rySEl1qBdfDffbJnK+DRUQmE2vY9dr1yp7DaAkTIGi5aaHh49+VcqibS1PO6vvHUget6MTyfQRDS5GlhEyMrw/ZzKJ1+UGvYd9NJmrY05MkzDkBcT76A5y/+jrTbzKwK45R1uSOg3/TYe4jb8CPne+tfDO+LLaklRRRTAFA0y6GVUF57t7/FXmCHV1BkrpIs4q80GVVk3N2P8UQ5Sgtyk1CnqCCX/XI4qySd88uhzCjgR8xSP0RhjcBqcEjiVezQzdYKCbMkglpE+rploVIigdsVFQGotkpf1aLI6hL+JsmwM/FjuzCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785343669; c=relaxed/relaxed;
	bh=1x52n613VKbmdCa3l3+9JQ1D1GSvg5VYUOg4eS7nzXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JT+B3xWq7VXwnDMyXg/WY4KVefbsDDtYlfvodHUJ/mG1BcmSaUy6mV1w5QTDoPt0by2axL2KG/oKZ/+wWYnHx+TqN8hCJti+RrcEEIurHcTpwb1uWSn1qO6Ueq7jKr0TGKfO6f22UHg03hOPt5e/tuFfNGE8sZncWlnQiWul1DXnoTheZfwwBmrwgc1aLcZOlsYOmXEaC9Vtgx4bG2yI9v3WWOAXIFEKXHNae+Hnjjq9ipBhBC2VF1ci1M3jopKBwp4SrH/P5KCl54MGp4Cb5F5yizZxYwr5ipkUrAEgS2BngsTZMAkaWUR93BG487vRTWTlBRGzh3L4qinjAaaoIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=my5WJAlQ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=my5WJAlQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9JD4445Tz2yjs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 02:47:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A7BA643F7E;
	Wed, 29 Jul 2026 16:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C301F00A3A;
	Wed, 29 Jul 2026 16:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785343665;
	bh=1x52n613VKbmdCa3l3+9JQ1D1GSvg5VYUOg4eS7nzXs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=my5WJAlQYMu6y+17P7dwYF+UM5lwUryOvSPeWS2C59IcxPuiwF+ZpmJnaC0rbJ2Um
	 tAHYUTgBMp1FBzB2usTCDnBN7wZSELiPyIfGirE5IRKfARf62SSTq+EI+FatX7TOvU
	 /x9Zbml7UoQPpW2EJQs4z1WR1tv3tkusKt7fnzsz6wG99utpRI9uhBIAouv616c9Z2
	 GIhUUERl3E0j/lcaRSl4/ZrshaPOVU2sEXFHEDDQOyFcpzbMZCxadjs6X7WogMmytJ
	 KqYpQxDO5miT5vko4MlPF2E035EvGTh4wsU1r2aRWUskSHAwv+N0MDman0qwN1Rhwu
	 cz7VHvrg3FpUQ==
Message-ID: <2960c10e-17da-41c9-8a36-fabf6b2e56f5@kernel.org>
Date: Wed, 29 Jul 2026 18:47:39 +0200
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
Subject: Re: [PATCH 2/2] powerpc64/bpf: Fix build break for
 arch_bpf_timed_may_goto
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, hbathini@linux.ibm.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com
References: <cover.1785339155.git.skb99@linux.ibm.com>
 <c57271230ed1c33fffe0704de86d2ee8a557a553.1785339155.git.skb99@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <c57271230ed1c33fffe0704de86d2ee8a557a553.1785339155.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/07/2026 à 18:03, Saket Kumar Bhaskar a écrit :
> With CONFIG_PPC_KERNEL_PCREL enabled, calling bpf_check_timed_may_goto()
> using a bl instruction results in a link-time failure:
> 
> arch/powerpc/net/bpf_timed_may_goto.o: in function `arch_bpf_timed_may_goto':
> (.text+0x28): call to `bpf_check_timed_may_goto' lacks nop, can't restore toc
> 
> Use CFUNC() macro instead of direct 'bl' to properly annotate the call
> to bpf_check_timed_may_goto(). On PCREL builds, CFUNC() expands to
> 'bl name@notoc', informing the linker that TOC restoration is not
> needed, avoiding the "lacks nop, can't restore toc" linker error.
> 
> Fixes: b55b6b9ad76c ("powerpc64/bpf: Add powerpc64 JIT support for timed may_goto")
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/net/bpf_timed_may_goto.S | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/net/bpf_timed_may_goto.S b/arch/powerpc/net/bpf_timed_may_goto.S
> index 6fd8b1c9f4ac..84ecf6fa7f5d 100644
> --- a/arch/powerpc/net/bpf_timed_may_goto.S
> +++ b/arch/powerpc/net/bpf_timed_may_goto.S
> @@ -36,7 +36,7 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
>   	 * BPF_REG_FP is r31; BPF_REG_AX is r12 (stack offset in bytes).
>   	 */
>   	add     r3, r31, r12
> -	bl      bpf_check_timed_may_goto
> +	bl      CFUNC(bpf_check_timed_may_goto)
>   
>   	/* Put return value back into AX */
>   	mr      r12, r3


