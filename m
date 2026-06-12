Return-Path: <linuxppc-dev+bounces-22556-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B8ACD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 13:28:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcL1Z7270z2ykX;
	Fri, 12 Jun 2026 23:28:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781270898;
	cv=none; b=ML9/z87hIrSBlq66oGQjY/XvIsVkFInon+28p74rzD371+ZBoYYUAnMTwXx9/Yj+vw/IOnccCQGF51nuCOZx7LsCEbPjxUH3boKvFn8h9CK2GNt4LbVTojhm7w7Qoy3bLid+7EvvVJjl9JUX0nyS4BkaKkY6OnRCMT16SLxLOnDzhf95MK2SF73YXngfP+WGdTDqfMrVcRjS3dTU+Xq+drcDtq+TsSCzmoopMgME9PQ5fX+EQUJa9s+WZ8Vc75dEo3hCYHpiOS3UsBc99W/7IDFEd68GwEe8u6k5eULZGi98eez4BXA+89f2pTeyVpJIj7OTPJ4mK7lW1GKFWTJLZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781270898; c=relaxed/relaxed;
	bh=ch+yj1d1xkzfN77vmuNFUc+RE3Ma28b1qL2J7+Wwpio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnRwCAUNN5PzLnXqbjk8FrCysT4td9ZIGKIBK5/lqw5XdGi4x8dyFeSm/UL2Rlp/Q1k/4hR/20DBvMfHjhDLAvtjXls7hDzVaZ0uw3p6LRBy3rnqZvLYXfPozaBt0cPlTeeEK1OM7/trxwt9ivvFucNIEe75XEBMOIHD28MiAyX+bGNaWxHtcy/UByAP6f46uoE9m4nwD+wkjWJFD37+UZao3j+Bo7CnMRLDtTBONSZHEuGB+FpXrUrJmXaGXyF7LuKDu6FPMwggrLTMm7KLjCfkZEPjaA6VVA2k1no+XSRLSDw0Qn42KZRVvoykUAzNA9P8eYUY5i600R3G62paHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwrXLtFZ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwrXLtFZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcL1Y734Hz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 23:28:17 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3C85F438BF;
	Fri, 12 Jun 2026 13:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62EF1F000E9;
	Fri, 12 Jun 2026 13:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781270895;
	bh=ch+yj1d1xkzfN77vmuNFUc+RE3Ma28b1qL2J7+Wwpio=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XwrXLtFZu0cYo0VsvAzGGWQxsiuhprgFN6uuIaAcoT50FCyGnbLkikPtvpaa6L/cw
	 mVbiF85+bI1U/QlZyHoQ9bH8GMYsougELaMNGRU7ydYqK2muhA4SDF8oY6JSgCoRpp
	 INLlVP4JfrpmSJslGc3SRz8LkbGv/NHVDg8GmvGLC8AjlWEA08COsuFFqRoeT5G1rs
	 mr0Iruqh0RPhkfJhJXLtkJlo9IDKaCUlshgcwYI67ZMPT/1XwVFvyfpbjkwqQCBGFl
	 u78f6X/L7enyc5+o/+phLuv0S7cG5/qk3fmA+52i4liKEkgQ2BReLWv65C8ETUIziD
	 nwhkRaqGvTdRw==
Message-ID: <598af26b-0f1d-4015-a3c7-b738a7364ab2@kernel.org>
Date: Fri, 12 Jun 2026 15:28:10 +0200
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
Subject: Re: [PATCH] powerpc/uaccess: correct check for CONFIG_PPC_E500 in
 mask_user_address()
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Sayali Patil <sayalip@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Cc: stable@vger.kernel.org
References: <20260611010914.429574-1-enelsonmoore@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260611010914.429574-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 11/06/2026 à 03:09, Ethan Nelson-Moore a écrit :
> CONFIG_E500 was renamed to CONFIG_PPC_E500 in commit 688de017efaa
> ("powerpc: Change CONFIG_E500 to CONFIG_PPC_E500"), but the check for
> it in mask_user_address() was not updated, causing
> mask_user_address_isel() to no longer be used on E500 hardware. Fix the
> check to use the correct name.
> 
> Fixes: 688de017efaa ("powerpc: Change CONFIG_E500 to CONFIG_PPC_E500")

Correct Fixes tag is:

Fixes: 861574d51bbd ("powerpc/uaccess: Implement masked user access")


> Cc: stable@vger.kernel.org # 6.1+
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/include/asm/uaccess.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index e98c628e3899..619270bb7380 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -511,7 +511,7 @@ static inline void __user *mask_user_address(const void __user *ptr)
>   
>   	if (IS_ENABLED(CONFIG_PPC64))
>   		return mask_user_address_simple(ptr);
> -	if (IS_ENABLED(CONFIG_E500))
> +	if (IS_ENABLED(CONFIG_PPC_E500))
>   		return mask_user_address_isel(ptr);
>   	if (TASK_SIZE <= UL(SZ_2G) && border >= UL(SZ_2G))
>   		return mask_user_address_simple(ptr);


