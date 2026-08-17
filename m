Return-Path: <linuxppc-dev+bounces-25900-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824DDC5B572
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2026 06:29:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNjbj3tBbz2xrC;
	Mon, 17 Aug 2026 16:29:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786948161;
	cv=none; b=ECrh6D2fF+W7wNBGzf6JzuS4kHa/WlZvOrr7iQSFU/UnSeJO/NdhESD7yR+EJwmTURnoVVEKEBiY5p8BHSMOF6/P+Ba8Eb1WRfexlYckL9b59gFCqHogYhSB4tWK1ZBR0RvKqEWbuK8KCGUVUl3LVlhyIcQdn8HhZ0xCNnCWvq3W2UWdi5z9kbn+G9J8UXNKbSDQdVjdOVoe7Jl1dwI1sNnZ6QTSOkDrjJb8Q1DA7o4ODlodRRFza6kuJPTiml2zsuAaBplfmBhvJfynmo8ZmXG3Cbz4ohbpDENGk4LH63EPt2Es20gsziS/pM/MxcqSIfBX1SPJoUNQc0IPDomMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786948161; c=relaxed/relaxed;
	bh=rGuj0TXK9Gf4jbd/TaHIlwxx+1Y0rd7UNGo7CFHlOds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPCAIOTeRDrwkVyPnM+oqeCkzfJd+Tcw7DKTJshH8qayiPgHFteExcQn5wp97tSIMijRpSvsxIJxmhPSISMFswhZS8sVqlAmE7yxB7rMz30bOpdZB/g/d2ljD55QdsLxDNQP50FKNWZ7AtZ26hcweEOReRb9q6yMPiWRUAuJQk+CqgFbwL7itXSnKowe7BKQRpSLckuEUCClYJCcXz0snRIWM5EH+EnWwgxCwHZHaoH8/ayI2fGsP+lWIzpDfR8/VKTnnY7+y2DHP9lpDuBqi1EyxJ7/moihQZ5Ti2sw/AYX+5Etu//gKYL7VbpwbG9eZDJUUDnD69gQZ7y1MlzX+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NBaxSAM6; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NBaxSAM6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hNjbg4LP1z2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2026 16:29:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 37FDA60120;
	Mon, 17 Aug 2026 06:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08B21F000E9;
	Mon, 17 Aug 2026 06:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786948155;
	bh=rGuj0TXK9Gf4jbd/TaHIlwxx+1Y0rd7UNGo7CFHlOds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NBaxSAM6+kK0DZi4AgsTCW4O+0vUgMKJLfr82V1GQevh/KKAQ3oNzLc4d0DXIDbga
	 tkB+OhMMbdhVT0j/eB34tNPgkhIol+kppyLyW+drC/7n4tp3HO3lKk/yOD9bTelq22
	 3jXsQP1lKfOVpVFJnqLgf7oBHt0FOctRPeNzplWCVYamcuBVjB8Mep70zAURHOmd/x
	 xhJnU57pPsonxSYrMMI7P5790/8SxNfTrW9/AV0SCh6aPpxQ1Qa9+aEg1sNROgI0eg
	 MZj3KXqPGHW48iWEE6BAkpP1sOcc9D9rMlFNrAMXMddVsrlpCAjvHGmEukd39j76Dm
	 iuPVpOYhE0CMA==
Message-ID: <c4d970dd-cb54-4530-9491-01b6d90e4a2b@kernel.org>
Date: Mon, 17 Aug 2026 08:29:06 +0200
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
Subject: Re: [PATCH] powerpc: remove dead 440SP code
To: Julian Braha <julianbraha@gmail.com>, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, Frank.Li@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: linusw@kernel.org, kees@kernel.org, colin.i.king@gmail.com,
 rosenp@gmail.com, joao@joaoff.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20260816125615.985387-1-julianbraha@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260816125615.985387-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 16/08/2026 à 14:56, Julian Braha a écrit :
> The 440SP config option can never be enabled, making all references to it
> dead code.
> 
> Let's remove support for 440SP, since nobody can be using it anyway.
> 
> This dead code was found by kconfirm, a static analysis tool for Kconfig.

It would be good to include history in the commit description:

As far as I can see, users of CONFIG_440SP were commented out by commit 
f65573314e4e ("[POWERPC] Re-organize Kconfig code for 4xx in 
arch/powerpc") and removed by commit ff5f483f3091 ("powerpc: 4xx: remove 
commented out Kconfig entries")


> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>   arch/powerpc/boot/cuboot-katmai.c   |  2 +-
>   arch/powerpc/include/asm/async_tx.h |  2 +-
>   arch/powerpc/include/asm/dcr-regs.h | 10 +++++-----
>   arch/powerpc/kernel/cpu_specs_44x.h | 12 ------------
>   arch/powerpc/platforms/44x/Kconfig  |  3 ---
>   drivers/dma/Kconfig                 |  2 +-
>   drivers/dma/ppc4xx/adma.c           |  9 ---------
>   drivers/dma/ppc4xx/adma.h           |  2 +-
>   drivers/dma/ppc4xx/dma.h            |  9 ---------
>   drivers/net/ethernet/ibm/emac/mal.h |  2 +-
>   10 files changed, 10 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/powerpc/boot/cuboot-katmai.c b/arch/powerpc/boot/cuboot-katmai.c
> index 034a748fde24..fcd71e76309f 100644
> --- a/arch/powerpc/boot/cuboot-katmai.c
> +++ b/arch/powerpc/boot/cuboot-katmai.c
> @@ -31,7 +31,7 @@ static void katmai_fixups(void)
>   {
>   	unsigned long sysclk = 33333000;
>   
> -	/* 440SP Clock logic is all but identical to 440GX
> +	/* 440SPe Clock logic is all but identical to 440GX
>   	 * so we just use that code for now at least
>   	 */
>   	ibm440spe_fixup_clocks(sysclk, 6 * 1843200, 0);
> diff --git a/arch/powerpc/include/asm/async_tx.h b/arch/powerpc/include/asm/async_tx.h
> index a14758426dd5..1ff5b2ca3ed1 100644
> --- a/arch/powerpc/include/asm/async_tx.h
> +++ b/arch/powerpc/include/asm/async_tx.h
> @@ -7,7 +7,7 @@
>   #ifndef _ASM_POWERPC_ASYNC_TX_H_
>   #define _ASM_POWERPC_ASYNC_TX_H_
>   
> -#if defined(CONFIG_440SPe) || defined(CONFIG_440SP)
> +#if defined(CONFIG_440SPe)

Replace by #ifdef CONFIG_440SPe

>   extern struct dma_chan *
>   ppc440spe_async_tx_find_best_channel(enum dma_transaction_type cap,
>   	struct page **dst_lst, int dst_cnt, struct page **src_lst,

