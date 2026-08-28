Return-Path: <linuxppc-dev+bounces-26170-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACCCC61DB9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Aug 2026 11:39:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hWbyS6R4gz2y8F;
	Fri, 28 Aug 2026 21:39:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::e0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787917168;
	cv=none; b=mAhwNNeUaE35a7pL/lC9wKSwpIXHH7sdoKZa6yGQ6qtUyMqxKV7QD3/jyGGLgo6iDKaGYGYiKegXs0A46KcMF/EeNoWHt69lT24SaSdtDzMiuFY4ATE8fDpQj2NGqzkhF69vH1bxRARmAT/BVXAJhF5DQVriFB3LlPFJs9RSe+z7tMMfn1hpP9fvZ4LKWRqJUuSIF5IOrbu3KL9JqUi6ZtQdSGVXrW70UUTJydxd6cYPs5YbYHSMUkRek77295MmBZscfHVpdNw0PyQFfVN1IhNG6I6Cu2KlYIQWP9tIC8Gp9oIKGHPhjiBHhwjeVxF5F6xtqgQiHNOKcydRz9DRhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787917168; c=relaxed/relaxed;
	bh=yJQ94Cs+Ojk9Jx1Fz/omGe9qYJlPc0aNB7uszTUQkhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2ciM98/vWAouIhG27I8G9Yfrp1PxX5HjfMtB7hD53TwV5z4jyEK9iSmoPv2q9gTSxGEbSXyDpX03r61wYt0WEcpE9UE8nJRJDe8xsY5bP81q5ra90JZZLidEY6X4H0bneMK3KSF3SzHx3NnLq0Rtz8MXSOVaanNtbPGQVwu+TV47UyBjJolCUsyEtrfOtRqxoOkZq3MciDAAdUSxAHaJwGzzF3G02VErajqOIjTz4dut3wbhiN40wVVkzcHM7xlEFKonh0ypF0YddWtHZAYzgXjUK+oGBzvMX87bf7GL+eLbv26mR+M3Zymg7ReRWqI2f9O5TSOk57WSZ2zG5JaOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=c50g6GpT; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::e0; helo=mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=c50g6GpT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::e0; helo=mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-224.mta1.migadu.com [IPv6:2001:41d0:203:375::e0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hWbyN6xFKz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 21:39:22 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=NdjwIHjLMtwULySAl01jbxlCbe76DSmtR6VHa3IT7SQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787917139; v=1; x=1788521939;
 b=c50g6GpTINKgaAAbDKTwuL+c2Jn3CMl5UwUVA3SylvE64I3UuHumDS9hBVrS7eA8qwAyD9SQ
 Eu5tlTDh3oU9VJznxgVEVhSaktmC2uot8AF0/6STwB3HJGXuMvCaNbHIwTJemDRNvpOmO1sXz4+
 Uy5hMvbxNuO4bGUqgLGbysRc=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta11.migadu.com with ESMTPS id 83ddab0aff98e2c5;
	Fri, 28 Aug 2026 11:38:59 +0000
X-Mizu-Trace-ID: 83ddab0aff98e2c5
X-Migadu-Flow: FLOW_OUT
Date: Fri, 28 Aug 2026 13:38:53 +0200
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
Message-ID: <apFzTdakRxQMLJ2n@linux.dev>
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

Gentle ping - it's been a few weeks and the build failure is still
present. Is the approach here ok or would you prefer something else?

Thanks,
Thorsten

