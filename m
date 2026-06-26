Return-Path: <linuxppc-dev+bounces-23036-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371B2C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 19:26:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gn5JT4bpHz2xqJ;
	Sat, 27 Jun 2026 05:26:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::b5"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782501993;
	cv=none; b=aJHfuEUB9gRhnzIiieg20cYN6hKnSLP/vawed+mvkKv7q5tcMpHtwru4t++XVFrLlgjjuzxplKozJj0kU6We/ovMRxE7d0rwOu1tG49dDXHCkog28SyxUaTkC1dccOAeWcKe2vhlWsjd4Zv4X3TL9rIHRjPjGlTG86BUsqpvgAhh9nLDAVxdHjhY7g9K5+A2ZtYv1sV5iy6TzIlmLuAg+CuDLoqe4GFKb4pfMtGpOTsMOtEybfKqHTP8wlIXMp5jR/EeQU5NyjrKlGhAltmAz0ttnnmTPCMiW+rWT062dSHiLp8YE0/IbeoRDLBVG62eU1YPiWi7OyeyGH148YFJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782501993; c=relaxed/relaxed;
	bh=P3GSIxg28qBTx+sEiExtBNcC25BVatGs6EWV34pDMZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDw4R1DUyQOpVFTaVL7G2tcQyFgOsZPnj72nrG/HsmkL1X6WB1GiIGx92MjdtWb+NelPTaV3wo9eG7Tbdtt7i2fswm67gXyx5Lakh05fNRFo5Nj4F+W8QbeSHL9/CQwHPbRWB8IaJX1ROBqtD3HticcCxuVl/P+oX8lgjl6hpzQJPQ+3j5fZ168FTAehCJvp23bOqzcCFLL9+JV6RpjoS30RijWLdUgQGe/az2z1HmTKkuo7xtOiGSWlvfTRabqYUxe7RXUQ8+EeoZ64g0PoxrwuvrXmleF8ZLbutOuFoZpIy5Ro7LGIsbJGalO4U53vVZsN76FhkX+dDJsRuWKbwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tpBodHKL; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::b5; helo=out-181.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tpBodHKL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::b5; helo=out-181.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 29901 seconds by postgrey-1.37 at boromir; Sat, 27 Jun 2026 05:26:30 AEST
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [IPv6:2001:41d0:203:375::b5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gn5JQ70C2z2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2026 05:26:29 +1000 (AEST)
Date: Fri, 26 Jun 2026 21:25:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782501970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P3GSIxg28qBTx+sEiExtBNcC25BVatGs6EWV34pDMZM=;
	b=tpBodHKLZlJSwypwSQlX0z4HMwd1UTkj/mNZRFfM9CfiC4L/gi8FxWj+J3kZf3o9bskpB5
	YiH1AzaFLgaINdJ9mnz8ZhRbiPpDfJ6zZ80VKwkKQlESyoliLYLcwzyHkXTvCpiD4auNEL
	f92KJMC1nyb2rdkySJCrQgp4YUyhL/g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc/pseries/ras: Use struct_size() to simplify
 fwnmi_get_errinfo()
Message-ID: <aj7SO0o_EAVc52j5@linux.dev>
References: <20260626184750.166642-3-thorsten.blum@linux.dev>
 <20260626184750.166642-4-thorsten.blum@linux.dev>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626184750.166642-4-thorsten.blum@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 26, 2026 at 08:47:50PM +0200, Thorsten Blum wrote:
> Now that struct rtas_error_log uses a flexible array member for the
> extended log buffer, use struct_size() to calculate the total RTAS error
> log size and avoid using the hard-coded header size of 8 bytes.
> 
> Use memcpy_and_pad() instead of memset() and memcpy() while at it.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/powerpc/platforms/pseries/ras.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> index adafd593d9d3..d54030fd2324 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -7,6 +7,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/of.h>
> +#include <linux/overflow.h>
>  #include <linux/fs.h>
>  #include <linux/reboot.h>
>  #include <linux/irq_work.h>
> @@ -440,6 +441,8 @@ static __be64 *fwnmi_get_savep(struct pt_regs *regs)
>  static struct rtas_error_log *fwnmi_get_errinfo(struct pt_regs *regs)
>  {
>  	struct rtas_error_log *h;
> +	u32 extended_log_length;
> +	size_t len;
>  	__be64 *savep;
>  
>  	savep = fwnmi_get_savep(regs);
> @@ -449,17 +452,11 @@ static struct rtas_error_log *fwnmi_get_errinfo(struct pt_regs *regs)
>  	regs->gpr[3] = be64_to_cpu(savep[0]); /* restore original r3 */
>  
>  	h = (struct rtas_error_log *)&savep[1];
> +	extended_log_length = rtas_error_extended(h) ? rtas_error_extended_log_length(h) : 0;
> +	len = struct_size(h, buffer, extended_log_length);
> +	len = min(len, RTAS_ERROR_LOG_MAX);
>  	/* Use the per cpu buffer from paca to store rtas error log */
> -	memset(local_paca->mce_data_buf, 0, RTAS_ERROR_LOG_MAX);
> -	if (!rtas_error_extended(h)) {
> -		memcpy(local_paca->mce_data_buf, h, sizeof(__u64));
> -	} else {
> -		int len, error_log_length;
> -
> -		error_log_length = 8 + rtas_error_extended_log_length(h);
> -		len = min_t(int, error_log_length, RTAS_ERROR_LOG_MAX);
> -		memcpy(local_paca->mce_data_buf, h, len);
> -	}
> +	memcpy_and_pad(local_paca->mce_data_buf, RTAS_ERROR_LOG_MAX, h, len, 0);

Sashiko found that memcpy_and_pad() isn't safe here because
fwnmi_get_errinfo() is part of a real-mode path:

https://sashiko.dev/#/patchset/20260626184750.166642-3-thorsten.blum%40linux.dev

I'll send a v2 and keep memset() and memcpy() separate.

