Return-Path: <linuxppc-dev+bounces-22958-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55616CDB479
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2026 08:41:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glb4l58FRz2yYq;
	Wed, 24 Jun 2026 18:41:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782290471;
	cv=none; b=Tmje6x8keslEGcqGmoepBjicNmnqwuQNv8kvEReeH6cvG9FB0OH+9MF6XTPM9Z9g5cakSEPys5uNZ0nS+I96wqDZrY2hzHNsqw/xe8cZSR6gDkA0SkswzC3QeUrg+M25ifxfLvLwvKaTeXTqkg49gMiCxXLkYnmThiVaJCOpyk+rKcCyCui0t3xcPuCrRF/EFFGE05i1Wl5bS6Oz8eI7veMR4dRPHNcYSjvIoB4+vtkzo97kMijQLOxj1oT8eiJ6/gDRzsnTkrrpXtKIsKXWkdzhLWkME3GWRFLb+yXcZdF2m6eZitbRfwSyekSJb05LX0O4yOHWUsyshacCNBJWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782290471; c=relaxed/relaxed;
	bh=VqJlPfxoxl5rtqNtkTr/FihC1DlX42JxgeiHnC0SsMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lX77BRz9AcdIAFBmcn3z5jBEB9FtT5sqYR0K3dxO2rdJsp4/JObAm4xxJ2QfHLFWOvxO7ofRBQiZ3i79y6G/jf5J8jwa6h+xu+1xvGaqHvqTe6Tpr7kL/1QB9JzQoHMWg8F0rV6M2Mxy94GKsj2hfWwLU/DSATikaEvs303iUnsp2GFvUSSSe/+7SddHQ8H+JNxp62tEZpw5Ri4fIQxkr9vKiIR0+JsvtQEGPngxkZxXlPrVgVcsfk9GYMHcz0nALV6Bi4yEbeOL/szjBQtG/DrtWOP1ScyjlbLFDCEBpDpiHN6Wwl5FO8pQVIgiIoIFU49Ig0iloUgD06oTy7rnxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VXLRBKC2; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VXLRBKC2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glb4k5b7kz2yRF
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 18:41:10 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 44E6144125;
	Wed, 24 Jun 2026 08:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B264D1F000E9;
	Wed, 24 Jun 2026 08:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782290468;
	bh=VqJlPfxoxl5rtqNtkTr/FihC1DlX42JxgeiHnC0SsMs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VXLRBKC2Vsaaxls3IH9HCMF6Lj9DFy5C3QN4O1sqrQd8YMD/a1OtQmTq52iYNEsMW
	 jamajo6Vt+ae/U5yQWRWU8B0HrVNPHUUMubSUmBE/eTMziXywwff72PP5pWh5pTCl3
	 ZdXrMxvHJ/2bFNsF02O2qelQ2UpXpf8VhUdCu82+PiYnRoyL+dHisz6ODd5asedHBN
	 dodzMtM+NpywG8Ky9vpKUES08dXHbbY6MP5vFeET19p7ueriKbZ+rwYgqh0ET8yK6n
	 74X7RMcEm2k+UVr9Bh9LBliYkw40aHFAEP5KyJpVw/WLXmJ7yRdPhTV6xiAAzq8o9n
	 GEpwL7llXDPyg==
Message-ID: <9145eec2-9124-4c3b-911d-c005b29d2deb@kernel.org>
Date: Wed, 24 Jun 2026 10:41:02 +0200
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
Subject: Re: [PATCH] powerpc/uaccess: Check CONFIG_PPC_E500
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260624081523.88025-1-pengpeng@iscas.ac.cn>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260624081523.88025-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Le 24/06/2026 à 10:15, Pengpeng Hou a écrit :
> The powerpc CPU Kconfig defines `PPC_E500`.  There is no generated
> `CONFIG_E500` symbol for `IS_ENABLED()` to test here.
> 
> `mask_user_address()` therefore checks an impossible symbol before
> choosing the E500-specific masking helper.  Use `CONFIG_PPC_E500`, which
> matches the actual Kconfig provider for this CPU family.

There is already a fix in the queue waiting to be applied:

https://lore.kernel.org/all/20260615233729.29386-1-enelsonmoore@gmail.com/


> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   arch/powerpc/include/asm/uaccess.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -537,7 +537,7 @@ static __always_inline unsigned long mask_user_address(const void __user *ptr)
>   
>   	if (IS_ENABLED(CONFIG_PPC64))
>   		return mask_user_address_simple(ptr);
> -	if (IS_ENABLED(CONFIG_E500))
> +	if (IS_ENABLED(CONFIG_PPC_E500))
>   		return mask_user_address_isel(ptr);
>   	if (TASK_SIZE <= UL(SZ_2G) && border >= UL(SZ_2G))
>   		return mask_user_address_simple(ptr);
> 


