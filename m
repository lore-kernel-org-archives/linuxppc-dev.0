Return-Path: <linuxppc-dev+bounces-21220-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD11CCD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 09:00:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL59R2pX3z2xqv;
	Wed, 20 May 2026 19:00:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779267643;
	cv=none; b=LmhUJ/XvV9dzkcv81L8UzqzvwBj945V5eD2UEET3SzElRU1POOCzuzANHlSnSefAoMO0QJWth/K9LCS90FymR1vSmbL23Nc6+1RpSX8Arh12xegjW/q4/9BIuKMywtuD7s++Ckl8Kw2ECADlk1dyzmThy4hHCZg4IR7a22sUQca8WsNwT7IEdd71ApHZ9I9TMb6okbRIIlOke8HfRbsOVxmZVMnjIAgQGGBoG932nsszwIxab/eiivYGCjcYQl1etWFsuGd5IC8WKdJWiOEL0HgxBJRuCG69aXkQOVnbfV7dgy7BNLULFPwHt65tKN1dR7h7gUAJ2Fn+avBBEMDTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779267643; c=relaxed/relaxed;
	bh=3r35QlQQ7TVEOX/HVqaknByeqpHK8Sp/8ygLvIHXW40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjaMSIPq50ombeThny1AG0ZpnrYaSzP5tuuNMBu3YQRARrx7MxjGwXni3JFT60Tw9p2ZMQXUbncsCW7pg2yz0c4eV/Z+q/FxdUZZVmxL1vrZjKBfoU+RCksaDK3x74rMT4EQKsiBYV7RhBEIVDZgWr8RiapYgpuF3Ngtx6SPX00ndt+oBoYSOIm0z5dMmfBM8aDN8esOpx2zNfrR8kZ8MOfhee8ccUG6yoS8W8u+xRU/GoMExzIyJatu8gaGcgL5AdJqFpVuqxvQJRL4Uc4gqdauA9gyXyoCPnkqIEicho8Nd+hKWmugGkbafVNJt1TpJmqymijbQSO3GEaCOMgtxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zxvd0ZXX; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zxvd0ZXX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL59Q3nZBz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 19:00:42 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 89AA8405B9;
	Wed, 20 May 2026 09:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EA21F000E9;
	Wed, 20 May 2026 09:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779267639;
	bh=3r35QlQQ7TVEOX/HVqaknByeqpHK8Sp/8ygLvIHXW40=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Zxvd0ZXXHWPrUMd5OxQIuQiPjuKEni06e9W8mRbiKmKS+8/nbO8T6FJPgq40Ae+4k
	 z5E197CXleBwiC0hakD0mGymc68UyZDEQ8klbeGEwX+wFVhs969H//t1iSHmlvnMD4
	 L9y0aR69J4xNbEnULij+cJGsOfCU3bhxoVxmUbJumIO755gpntqCd3m5HadNuV4eF5
	 hOJ6qZaTQ9NY9ZJuzejnxs5cyMiefQCPLB3KG3GhZAzIQ+EK1iATYuvaWYKnf5T2WN
	 QkdIJ9I8uvV2KCErOXqbU+iMK0EWod2dB7j7glr5+BxmcdFWMVhG+dgbs/7tXH5k/P
	 eUorffZ3mjjxg==
Message-ID: <d68d87ab-9149-4fb9-98a6-39b2e7ed2efa@kernel.org>
Date: Wed, 20 May 2026 11:00:35 +0200
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
Subject: Re: [PATCH] powerpc/fadump: fix integer overflow in MIN_RMA size
 check
To: Sayali Patil <sayalip@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com, Michael Ellerman <mpe@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
 Mahesh Salgaonkar <mahesh@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>
References: <00e9b516b13316f7ce81b651957dad0441e56006.1779255851.git.sayalip@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <00e9b516b13316f7ce81b651957dad0441e56006.1779255851.git.sayalip@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 20/05/2026 à 07:53, Sayali Patil a écrit :
> The MIN_RMA size checks in fadump_setup_param_area() use
> (MIN_RMA * 1024 * 1024), which is evaluated in int and can
> overflow when MIN_RMA is 2048 or larger. This triggers compiler
> warnings such as:
> 
> warning: integer overflow in expression of type 'int'
> results in '0' [-Woverflow]
> 
> Promote MIN_RMA to u64 before the multiplication so the expression
> is evaluated in 64-bit and matches the surrounding physical address
> and memory size calculations.
> 
> This fixes both the comparison against ppc64_rma_size and the
> assignment to range_start.

How do you create that problem ? MIN_RMA has a fixed value of 768 which 
is defined in asm/prom.h

> 
> Fixes: b7bb46062457 ("powerpc/fadump: fix additional param memory reservation for HASH MMU")
> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
> ---
>   arch/powerpc/kernel/fadump.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 501d43bf18f3..dea7f7105e42 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -1759,10 +1759,10 @@ void __init fadump_setup_param_area(void)
>   		 * 2. The range should be between MIN_RMA and RMA size (ppc64_rma_size)
>   		 * 3. It must not overlap with the fadump reserved area.
>   		 */
> -		if (ppc64_rma_size < MIN_RMA*1024*1024)
> +		if (ppc64_rma_size < (u64)MIN_RMA * 1024 * 1024)

As you are modifying that line, please use SZ_1M instead of keeping 
opencoded 1024 * 1024.

>   			return;
>   
> -		range_start = MIN_RMA * 1024 * 1024;
> +		range_start = (u64)MIN_RMA * 1024 * 1024;

Same.

>   		range_end = min(ppc64_rma_size, fw_dump.boot_mem_top);
>   	}
>   

Maybe the best would be to define MIN_RMA as a bytes value in asm/prom.h 
and to divide the value by SZ_1M in kernel/prom_init.c when initialising 
ibm_architecture_vec_template.

That way you could just define it as SZ_2G instead of the problematic 
2048 you mention.



