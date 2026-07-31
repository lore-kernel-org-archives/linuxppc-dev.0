Return-Path: <linuxppc-dev+bounces-25168-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C4EC54F54
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 07:15:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBHQq3TNTz2yhv;
	Fri, 31 Jul 2026 17:15:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785482131;
	cv=none; b=XN9XkNwT0hHZhmDTvBLy/3hB+GrTCZYG+lg9ZDBZKhDeq/j1UZC3AT7cgpJNSSvWEA0zYes/ArhKiyUC/YQ6wftVluo0qKp8S6qXxctd84kcl+7a2V7TC7tGSHN7eGemZ8yv/T9vRsoqigWtVmIPLlXJvr/P5tloerCiFYTlSkVfE0Wsvl6pJ1vq7Natwy2Pw0wyptMaUc95PCJbMp1dVlcO/KA4En9zDCu9XfznCGMHxvqCYBo5cPTAzeLgU3It0YvoGxXTPBf/alRkwyiUwhUC6EY6o4Q50TWeFnc9SCO8YtBKKf615hKABIFMffEKhp70dyU+n0coCV+Qs43MIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785482131; c=relaxed/relaxed;
	bh=d80TQvyaCoLgq/NUMpiAgG2jz5ehxRjgCkZbSmCurf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WbcEYxN9nhYlTFropK7X/yts+hC73nJjkvBnY77kaofR8v25CJ1XorRbyzpLn/e7NXqkRQ0MBSq7jBQSP8xGSLlljA2Dr6hzqvINjwB586FK5nDhkZzBinqmcelYphHHbH6EGtefOBQ1nCxAf1mowAkKWckd7UovPLFdZgrutVapz0PAT7DkBgc2JNR0pWZrBFl4YCQLV2N+YrgPdqbiqYqscxvswjq2pE2MmIx4FKT4mbnTxIMuwy+L3uD3hTYSU5oszh1CY9jI9VL7C2giyZeypU1tDML9EeiT4kiYQsz5fYkxB+7/6diU8PtqAEiQ/p8Zxwu51Tr+Ee2dduTVVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4GE0n5B; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4GE0n5B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBHQp6GTmz2ygh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 17:15:30 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BFBCB43D4D;
	Fri, 31 Jul 2026 07:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B435E1F00A3A;
	Fri, 31 Jul 2026 07:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785482128;
	bh=d80TQvyaCoLgq/NUMpiAgG2jz5ehxRjgCkZbSmCurf0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=G4GE0n5BFfrCSG2t+7cs/UdLcRtEdB3N0o6ATEq2Th+RQcP+GUYWFuJRKkedFOV5V
	 onYFNzFtbEJwFSrFbJFXvS+YHH1P0WWYuZ5k+USzW7pWgfL6PNZYAfksDY7g+HBNuc
	 tPaHY4ctMK+f9LTpFNiP4lVGiu43HYlTF7qjeRqh8YwAu2QzX5obWguyAR53jB8yb1
	 3JYspdM6zCVGe28N1bQrRlzNgAw59jLJy7Gtt55LzgE/ZvcoiIzKpFZM3GaHAaa9a5
	 Rb7/9joURIMqm9FOvUip+GQevyZMNPIZT9mQ0yIA6ZmVo4HTDE5Ljwo4R2zEk4z0c/
	 jXgu7+befLq2Q==
Message-ID: <e899743d-5111-445c-a120-e8dc22202d7d@kernel.org>
Date: Fri, 31 Jul 2026 09:15:24 +0200
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
Subject: Re: [PATCH 2/2] powerpc/pseries: Avoid strlen() in
 do_{remove,update}_property()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Kees Cook <kees@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260721155346.121975-3-thorsten.blum@linux.dev>
 <20260721155346.121975-4-thorsten.blum@linux.dev>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260721155346.121975-4-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 21/07/2026 à 17:53, Thorsten Blum a écrit :
> Check only the first byte instead of scanning the entire string with
> strlen().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/platforms/pseries/reconfig.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
> index 7faebcffc9df..18e3f1a036e3 100644
> --- a/arch/powerpc/platforms/pseries/reconfig.c
> +++ b/arch/powerpc/platforms/pseries/reconfig.c
> @@ -307,7 +307,7 @@ static int do_remove_property(char *buf, size_t bufsize)
>   	if (tmp)
>   		*tmp = '\0';
>   
> -	if (strlen(buf) == 0)
> +	if (*buf == '\0')

Can use !*buf instead.

>   		return -EINVAL;
>   
>   	return of_remove_property(np, of_find_property(np, buf, NULL));
> @@ -330,7 +330,7 @@ static int do_update_property(char *buf, size_t bufsize)
>   	if (!next_prop)
>   		return -EINVAL;
>   
> -	if (!strlen(name))
> +	if (*name == '\0')

Can use !*name instead.

>   		return -ENODEV;
>   
>   	newprop = new_property(name, length, value, NULL);


