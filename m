Return-Path: <linuxppc-dev+bounces-25070-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560B0C531D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 06:34:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9fYv6Fszz2xnp;
	Thu, 30 Jul 2026 16:34:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785393267;
	cv=none; b=O0ZzgqE2FB9Q+CMnM56w0S8nFXctgzONZHRiqt1lF2lip98glwfzpKU+e93eJCifuDXjx89bqvB8humv4+liGaFDz4HbJzkjNFAyhQJ0lgTnpMX8adoTUEV/be9fJpG4oD63OIsxXmEDhgbDu2TqUw2/HE8irK/XxF4X9h/MeQTsrifVKsTXyoi5H3FeaQHKDc/cKioIz8aGejHZPZH041f4S1oEhapihWLPKb82xvN71TsMyCCln0lxWnBIOBJuc3O/S2ZQjI/JPS4lfk7X/ElTq4OAWZSv3mijl56qpWaxl5q03ARvllcufPXHxYFoXZTu71ftVHQkGtbzfRLMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785393267; c=relaxed/relaxed;
	bh=psDlRdyOmrfNwg7omEfqBC/UxCLW/3670WhKUDGKsuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpABCXY+JmYqU83LNCeYu7UNUAWnCMwuT6UqVZ8a+FvDzcosjnsH2BpM7qkHk21IQlFrUtoQX/w/CkXarmAh3MdE4itD5SJomZPDRwpdXN99s4pvZPUo1/pZTtQzWxYq4FUSF+drAFQ9Tdqlv5TBe2cJYxQCRSnICTUucxLmw0nbvBGjUhQtYXDYzFCC0ob/vZmvZyBN/Ww0O7W+DzrDb5POT4p+KGDtpOOcRMpitL9/E/qXCW1Fg5fWBElM/EcYWKcEwl1iCvawYgBPrweh3MbwaW1Y7nwoS8283aNwk16SYDXZD1SQrf6QV7bvTBm5jQAQWd3kOazSqcuTUDDrlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqLJHkrR; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqLJHkrR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9fYt6v3Zz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 16:34:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A6A65600C8;
	Thu, 30 Jul 2026 06:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78A71F000E9;
	Thu, 30 Jul 2026 06:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785393264;
	bh=psDlRdyOmrfNwg7omEfqBC/UxCLW/3670WhKUDGKsuI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oqLJHkrRSFANO/Qz9+XGaWsObWeGHyfIhH7thZS+i6UF+z8F1Ti9VTdTz5QVNcSsW
	 n3TmFmSM/SVzIrlFnM3oBXuawMA0uIxl61o4kRBOrZJzIMbLla3n5V1KcUhyasMJPt
	 wIyifG0IN+BOIPQgPq+N9eocVvQAxJJRL6ZTNLPCq7Gp/E40CaMM7C3Jl7bPLTWKwq
	 RxsDTBX1Ua5DioqS3/5vCkHn7PPlZJDBUS7/kKu85KHZ0QMt8M1bQYEJigsTqAQkey
	 8bl1yOLfLBt92SqtT5wjGL+cmetGDWcbOyLQonEPWvXhAs42VmpTjhlPSJZjL5Bbrf
	 C6tRbzFYQxsKg==
Message-ID: <0acfc368-8dd3-47c4-ae31-de3bb8d03776@kernel.org>
Date: Thu, 30 Jul 2026 08:34:20 +0200
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
Subject: Re: [PATCH] powerpc/serial: Use generic BASE_BAUD in asm/serial.h
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260729223807.570178-3-thorsten.blum@linux.dev>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260729223807.570178-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 30/07/2026 à 00:38, Thorsten Blum a écrit :
> Include asm-generic/serial.h and use the generic BASE_BAUD definition
> instead of redefining it.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/include/asm/serial.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/serial.h b/arch/powerpc/include/asm/serial.h
> index cd6c18d0e66e..eca0ef56f874 100644
> --- a/arch/powerpc/include/asm/serial.h
> +++ b/arch/powerpc/include/asm/serial.h
> @@ -9,8 +9,8 @@
>    * through the device tree.
>    */
>   
> -/* Default baud base if not found in device-tree */
> -#define BASE_BAUD ( 1843200 / 16 )
> +/* Provides BASE_BAUD, used as fallback if not found in device tree. */
> +#include <asm-generic/serial.h>
>   
>   #ifdef CONFIG_PPC_UDBG_16550
>   extern void find_legacy_serial_ports(void);


