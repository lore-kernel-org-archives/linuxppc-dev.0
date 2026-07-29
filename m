Return-Path: <linuxppc-dev+bounces-25032-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869B4C53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 16:57:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9JR73FkFz2xnp;
	Thu, 30 Jul 2026 02:57:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785344243;
	cv=none; b=G/+GzKb2KBxHBul3QPb6pmLHZTyXfYTApLyUrbrgs+q8R77Mat/goyzg4TLN/jgpk6Ar+7dZGul8VIK7f9BW8gWUTbYGgSO69oVeFggRiO9n3o4srLyXz6OQljqqpDWMfVlsSREoG973URnKfi8fmoXiPKgvD8QKO+W5LOWdXncTXdmbs50NvGusZ03arzCanGXD7dJhNI3KwC9wo90jnVAHJatMK6Yk/eC0IUH+ooVeZEcyQ+Z2lZ3l0amNkMVipLiYpOOOjeIvjc+htOelyFcq0K3lD17KeBdk+QsBrnLajhIA8x8hBmkbQpnCBRNa6yOHKz+B63Tx7h/pNo7ITA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785344243; c=relaxed/relaxed;
	bh=LDU7beg0fnhcr8nf3vku/Ay0bOzx6vJc/E1w7QNenGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwB8do6tK1wn2zId0z9A/sv7xc7BTLsmGzNaYa192ErsGqLWZ6lqo5/wKjZlPxvfw4JMJyE566sRzRZ0x3evnNZ0Zzza08rC6LREX7Q5BmsGAk5mqGSm647N9NZMfdQU3zU4lr0oI2SoNEoMJJ87UMJ8nfKVJX8QuEUb7lQKNPOgnw9ElJtOy3xOx4cP9lIoy32damNXqj5gRxyurJzVxsiFB/0tMDH9crQPrjLvgMyUeIZ2dyq4g3RlKKsgJGZJ3BK3sglKTUwqNz97235uaCd2apzkigmF19HeBeH+oYfeCAnFN5s9gth0NKJ2iHl/VORvvghUs3yysscP/o/qZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GqHOI/mr; dkim-atps=neutral; spf=pass (client-ip=95.215.58.179; helo=out-179.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GqHOI/mr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.179; helo=out-179.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9JR50NV7z2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 02:57:19 +1000 (AEST)
Date: Wed, 29 Jul 2026 18:56:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785344219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDU7beg0fnhcr8nf3vku/Ay0bOzx6vJc/E1w7QNenGU=;
	b=GqHOI/mrjEDF0/9FnhvLr7V1OE8QeXzb5u7qQvzUVDf6ocCWc1qa/MJ0u/ctAHS7u3MJ5+
	qz1PomNpBKyG8cRJQfeyPp1aVeStzqzZilBdz/u6waOrGyR79rA3/abMmY6gaRPG+vlRG5
	5/Jf4ZEUJekaU5tJ0f/NcQ3dV9gvYRg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>
Cc: stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Fix repository.c build failure
Message-ID: <amowzufwQrIqHVZX@linux.dev>
References: <20260703165834.137242-2-thorsten.blum@linux.dev>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260703165834.137242-2-thorsten.blum@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 03, 2026 at 06:58:35PM +0200, Thorsten Blum wrote:
> GCC fails to build ps3_defconfig with the following errors:
> 
>   arch/powerpc/platforms/ps3/repository.c: In function ‘make_first_field.constprop’:
>   arch/powerpc/platforms/ps3/repository.c:78:9: error: ‘strnlen’ specified bound 8 exceeds source size 3 [-Werror=stringop-overread]
>      78 |         memcpy((char *)&n, text, strnlen(text, sizeof(n)));
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   arch/powerpc/platforms/ps3/repository.c: In function ‘make_first_field.constprop’:
>   arch/powerpc/platforms/ps3/repository.c:78:9: error: ‘strnlen’ specified bound 8 exceeds source size 4 [-Werror=stringop-overread]
>      78 |         memcpy((char *)&n, text, strnlen(text, sizeof(n)));
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
>  arch/powerpc/platforms/ps3/repository.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
> index b8c030eab138..0cc755ac3e7f 100644
> --- a/arch/powerpc/platforms/ps3/repository.c
> +++ b/arch/powerpc/platforms/ps3/repository.c
> @@ -6,6 +6,8 @@
>   *  Copyright 2006 Sony Corp.
>   */
>  
> +#include <linux/minmax.h>
> +
>  #include <asm/lv1call.h>
>  
>  #include "platform.h"
> @@ -74,8 +76,9 @@ static void _dump_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,
>  static u64 make_first_field(const char *text, u64 index)
>  {
>  	u64 n = 0;
> +	size_t len = min(strlen(text), sizeof(n));
>  
> -	memcpy((char *)&n, text, strnlen(text, sizeof(n)));
> +	memcpy(&n, text, len);
>  	return PS3_VENDOR_ID_NONE + (n >> 32) + index;
>  }
>  

Gentle ping.

Thanks,
Thorsten

