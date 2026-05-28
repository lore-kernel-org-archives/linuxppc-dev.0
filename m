Return-Path: <linuxppc-dev+bounces-21616-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3A5CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 05:46:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQwTP2231z2xpt;
	Thu, 28 May 2026 15:46:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779947177;
	cv=none; b=LhfMQHiQrSUfKM9rQNRHdU3TUTDFdd0KgXpdZf8K3a9KbfHJVtHZQDH4SD+YLMLsxP3ifDdH3E/0ECZ8t54mR/lKVtRFHk9+DjkfLHoUGwJ/9IlyRtWS9hzDDTLr+JQkXwLBmMjLca/u8oX0ZSNyFONdbLKyEy746UYqfsA04rRIpEwO5rz6HRvYfPJRdekO2D1WsMxbv9Fm2+EEr+48phDtuz7HzL3Kp4DVoGTKzDyV4EmuYLmLmtM87/UZ8K9r8DcZdJc0NrjxlULlsyPtMMdX6V8PQ0lwkPr1mjdwQXfF0iWKWkPSEhnBq/tpTzWsfbhzIVjeoXAykJ5njwrnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779947177; c=relaxed/relaxed;
	bh=95SOoqGn6jyE0UfkDK15/NBpH9CmgAfhjJteJqSZdCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2R+0EnRgf/f/fxbp8d7IFAZWexmOXivs0eiQGOisZRx9Z8wquNb1VaSg0TblNM7OrEEULarpXb5Zwrqu5Rr/qineRBMY0VF6apdKom8HmAqZFy1cBSt6TH3JUnIIfcv+JcGHAJwW76GWERLXHA+vUXUM7yujx+CWpBc4obdtnUHa0dmChGjW0+sW3RDtLVLEAQ2XtsQ9MwVGlXTcnxhJn9inyA5KDrkFlR3lpEWbsWKpGGGw1zBxlh8JZ6QCBJo0a5XydjnydlqU8kkndaAK+JyIBrXKrGunkLIAuEkNUcYHKrXSfw0LmXNX7I2Zb+ppBQ4mjt1bGKeHz8lLElArA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=USTJwMyG; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=USTJwMyG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQwTN21PPz2xSN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 15:46:16 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3794C407A8;
	Thu, 28 May 2026 05:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA4C1F000E9;
	Thu, 28 May 2026 05:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779947174;
	bh=95SOoqGn6jyE0UfkDK15/NBpH9CmgAfhjJteJqSZdCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=USTJwMyGvWXoMbf/S3Hkuw/RAJZlgHz1wf6Rv3/jmc2THf0cyKGDOtGKt9FmAlIO2
	 bEzFbeCt0rnDn/8rlPAlmhLya/lie2fE7s0Ml45wXgkLiE48k3nYrM5tUD//wtZoUe
	 Or1W+w7erYiqub4kaHP0qkQb3RECfdmHprx1Vj3YKxor8X2FJMM9b4kv+OtRUUTLhY
	 dmdFE+f1EYTQmxHd5kFze5j7kVMcZ/PDIzwqvicbpyNpYnweMPLgb8vUH92a7Ecsu/
	 AQ6G7A7Ro/8u63LF4IMK8XJnfB3/MXr6DrdO23eJ8HfBnbe96tH4zBoN13i1Sk2LFH
	 iU1t+RcUX53pg==
Date: Thu, 28 May 2026 08:46:04 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Liz Prucka <lizprucka@google.com>,
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH v6 13/15] sh: cast away constness from the zero page when
 flushing it from the cache
Message-ID: <ahfWnLIwZXJvbvNg@kernel.org>
References: <20260526175846.2694125-17-ardb+git@google.com>
 <20260526175846.2694125-30-ardb+git@google.com>
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
In-Reply-To: <20260526175846.2694125-30-ardb+git@google.com>

On Tue, May 26, 2026 at 07:59:00PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> SH performs cache maintenance on the zero page during boot, presumably
> to ensure that any clearing of BSS that has occurred at startup is
> visible to other CPUs and DMA devices.

It flushes the cache there because before 6215d9f4470f ("arch, mm:
consolidate empty_zero_page") empty_zero_page used was for boot parameters
at the very early boot.

I removed memset(empty_zero_page, 0, PAGE_SIZE) that was a line above but
missed the cache flush. 

This whole "clear zero-page" can be removed IMO.
 
> The __flush_wback_region() function takes a void* argument, which is
> conceptually sound, but given that empty_zero_page[] must never be
> modified, it is being repainted as const, making it incompatible with a
> void* formal parameter.
> 
> Given the above, and the fact that __flush_wback_region() is in fact a
> function pointer variable with multiple implementations, take the easy
> way out, and cast away the constness in this particular invocation.
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/sh/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index 4e40d5e96be9..acbb481cdbfe 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -332,7 +332,7 @@ void __init mem_init(void)
>  	cpu_cache_init();
>  
>  	/* clear the zero-page */
> -	__flush_wback_region(empty_zero_page, PAGE_SIZE);
> +	__flush_wback_region((void *)empty_zero_page, PAGE_SIZE);
>  
>  	vsyscall_init();
>  
> -- 
> 2.54.0.794.g4f17f83d09-goog
> 

-- 
Sincerely yours,
Mike.

