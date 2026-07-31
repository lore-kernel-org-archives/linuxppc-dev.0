Return-Path: <linuxppc-dev+bounces-25172-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF58C55167
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 07:34:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBHrq5G3Wz2yhv;
	Fri, 31 Jul 2026 17:34:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785483275;
	cv=none; b=X6+XxGCVIGeESM7wnCO8xzNI+TfEMBHLhWam8uQLYkttxDLFzPxXCdpmXVre03bSIK1R7ULFoA7MuSDM6bGkEjhXoyO8VPLASDnUgbfRGKPnVl1KVvhs7at0OFFC3S6/XGeOBdIw76m7dlUOHJ77E7Sw9tBuhGx9+d6A22TxXWflbRAW9EgFHCz6kmne4xvrsvl2Eoq3ZIawXeVlbSY9cvMx+0ijuHgjiHztY+hlbOd81YljhNFCkuAJfzKdhWgVogyazxI6P9nDMbbkLD5p8GVBSic7sWSVp/gg73Wn2otWgSy6OLWyxKPrfE1VVOIntJGJ36VFg+KQwrywORNTuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785483275; c=relaxed/relaxed;
	bh=MyKJJuUwMNNDK+7BAt01g+E4SJ/puql/PuU35u2uXCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCuqsrfzTpXQdRTlrKmRntDlp3lvaGkSTG87ouR6s8E0PXSZ2DMkyRhJzu6lq2xP74jjjh1EVhrO0x/joAgBrmNDQCb9gqAfdPIPdkdFOkMp0RzMQnckN7pBzyjufbWVKN9aqiI2fAF/LcA5GnxNxRUvmux14RppV7kzRETYuoiHFuvFm9658tqR6xRl+FC4/Pdy48Zk9p4+jWWafRF/N2rQN7Y+M8RVjLBExGujFetO/Wjp8Ob3ucJgl2PHy6MAxzDr8r+i+kXjftEXaVzH6SkF80ozw6/hPFmAwCOFZt11hu/KqMxcMoeKNI7j0w3e5I6QonayfCb+h+yIF5RB1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+DQMeRU; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+DQMeRU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBHrp6d56z2ygh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 17:34:34 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2EF5840B81;
	Fri, 31 Jul 2026 07:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2AB1F000E9;
	Fri, 31 Jul 2026 07:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785483273;
	bh=MyKJJuUwMNNDK+7BAt01g+E4SJ/puql/PuU35u2uXCY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=B+DQMeRUqP9H9atv572awP1Rm0bkPUF3mUi/0apsBW9ZHU7bx+A0GClo6oq0fGSkF
	 A9pHXDN5YEK1X4njOl6KXzoudgDFph+x+ilOh0svRbyOi+ASDFOafmaxlpzYZMLy7t
	 wDMyXBeGvA/8BqS+togmCrNbkbS8okuMaWVfsOvOPOO0NB9v/9Ycx9XI3F4/CAIYli
	 hUmwdcQ2YaH0fZP3EH4qVSNzwN9sSSLgjN+lHt7NOqoUuWb6RF67i2Lh8CDfRfFQVT
	 pxF7RVMYEwosXVsLs4VEeM3ybLzewcYYziOI2YbwYDZy1LxoLDp7ME7/6EqEVZ/JL0
	 dVjkh9NzvbDZA==
Message-ID: <6be33030-781f-4480-8ccd-81c5b1df220a@kernel.org>
Date: Fri, 31 Jul 2026 09:34:28 +0200
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
Subject: Re: [PATCH] powerpc/ps3: Fix repository.c build failure
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Geoff Levand <geoff@infradead.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Justin Stitt <justinstitt@google.com>,
 Kees Cook <kees@kernel.org>
Cc: stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260703165834.137242-2-thorsten.blum@linux.dev>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260703165834.137242-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/07/2026 à 18:58, Thorsten Blum a écrit :
> GCC fails to build ps3_defconfig with the following errors:
> 
>    arch/powerpc/platforms/ps3/repository.c: In function ‘make_first_field.constprop’:
>    arch/powerpc/platforms/ps3/repository.c:78:9: error: ‘strnlen’ specified bound 8 exceeds source size 3 [-Werror=stringop-overread]
>       78 |         memcpy((char *)&n, text, strnlen(text, sizeof(n)));
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/platforms/ps3/repository.c: In function ‘make_first_field.constprop’:
>    arch/powerpc/platforms/ps3/repository.c:78:9: error: ‘strnlen’ specified bound 8 exceeds source size 4 [-Werror=stringop-overread]
>       78 |         memcpy((char *)&n, text, strnlen(text, sizeof(n)));
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The current use of strnlen(text, sizeof(n)) triggers -Wstringop-overread
> when text is a short string literal that is smaller than sizeof(n), such
> as "bi" or "bus". Use strlen(text) instead and clamp the copy length to
> sizeof(n) before memcpy().
> 
> Drop the redundant char * cast while at it.
> 
> Fixes: f94a84a09148 ("powerpc/ps3: refactor strncpy usage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   arch/powerpc/platforms/ps3/repository.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
> index b8c030eab138..0cc755ac3e7f 100644
> --- a/arch/powerpc/platforms/ps3/repository.c
> +++ b/arch/powerpc/platforms/ps3/repository.c
> @@ -6,6 +6,8 @@
>    *  Copyright 2006 Sony Corp.
>    */
>   
> +#include <linux/minmax.h>
> +
>   #include <asm/lv1call.h>
>   
>   #include "platform.h"
> @@ -74,8 +76,9 @@ static void _dump_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,
>   static u64 make_first_field(const char *text, u64 index)
>   {
>   	u64 n = 0;
> +	size_t len = min(strlen(text), sizeof(n));
>   
> -	memcpy((char *)&n, text, strnlen(text, sizeof(n)));
> +	memcpy(&n, text, len);
>   	return PS3_VENDOR_ID_NONE + (n >> 32) + index;
>   }
>   

Maybe change to u32 and remove the n >> 32.

Shouldn't the same fix be done in make_field() ?

Christophe

