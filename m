Return-Path: <linuxppc-dev+bounces-19299-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD125E88D72
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 01:00:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnch52stvz2yqW;
	Sat, 04 Apr 2026 12:00:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775264405;
	cv=none; b=TAy9enG4XZ8PrTnK9EP5CJGSZq391nMYhdQhwtXN8dcVJSbq2IH0JpYMhgGZPvJZJtAk8AeAAOrDqJxRt5FLWh7rp9ZvHApyAHOGqRKlBErvGafWaRmIShvn8Ri+An/e8MbCQTY7dX0rxgLtNk9Ln31FTcIGyk9uihsTekU9JSo3KCelG2BuqniORE+2VQ4KOp6VXsjqhyfoJz9vUimNxXwZ+rfyFeV/lwRYHA3qsW2FD6RX13U8v0r5hVo+aG9BeN9J94N0HCRBff/ZeNKjX7qv7IEE9mkpoP7YvAKUu64Ew8Burq22aSThqPX23IDGqiCLLq9Z6AASHoUnecOV3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775264405; c=relaxed/relaxed;
	bh=Jx9VRA+YvXOG2ZpAp8I5XEFcEAu07TeiFK4l7PTiyc4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=bI64vM703xw/qlGYZea4Ot74naFad/tBJzFYjX89bS36wjRa3J2STVQ5hQneTeuwLsuENYDTmW4ebZRBAsmi+z2ux+OVN1Q8/4o5gAEAjf1oTF+zyhbBgVWeHggBp5/pp3qFSbHkzw9wg2H3ZQ00nq1bHLntQ2JqFTl+pvBZMisEyw8S+v3SYFSwSXAzjLcT4w3Sc4eGQvXIpkA/34O26A13/kT6pm3UwKAwLhWSKJ6cJu6UCRHGo6vmxrE9+hFcTRX9QfwOTySMNZR1VYbFg55613B1f3eYCtqn6BtmlQzBxv4aTH+KoeSe0SwJmZjClecSfm7JPoYgvYwclTzIsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B+0Dwtfg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B+0Dwtfg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnch36KSGz2yl2
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 12:00:03 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2ab39b111b9so10023575ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 18:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775264400; x=1775869200; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jx9VRA+YvXOG2ZpAp8I5XEFcEAu07TeiFK4l7PTiyc4=;
        b=B+0DwtfgaBRPx6aUdfVrZSalYoFB6uKNDWd9r7KIF6DaANMsoKe7fGzfngdEfrd2rl
         PeOIXfnudGLQS+6bzIhkoROg0osYV2Uquvhqbw3Wee94IXpNMxwpLPoamnkyOzGv5B1f
         eXXpVHvc2J4gQuaN/GrvDOPjTVU+5mjqBudIWLhqsLHV762n38dEDGzg6aC6X8wG5exZ
         ZADiTRpjFnbyV3mkgMPQdd47N0a68HbUWB+FlXWxvOjOm6dKOhwZap3qPKUuJv8qLkq7
         mfiV9KVl2uK64KdzjQ+eSE+HIWB9eLJbR6bkDlUxEQoeV/4lMwLOGkdDeTrnioPzRsic
         TbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775264400; x=1775869200;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jx9VRA+YvXOG2ZpAp8I5XEFcEAu07TeiFK4l7PTiyc4=;
        b=LmX0UvrK/LHCIZoh3Hj3fRz9LEkzRAvxayDhonaOlpWMtrOuMMPXK2fnJenJdP1VcF
         PvrrLkizlctMgRNnZlYdWX3OTN+ZQEQDRhzNIap7r6RcTnrWyfH99i/0eGMh2zVztjzE
         vOiuPDz2EaaFcg9j0zwgUFyj2t/q0yqF2npA0uq1WBF9Hp7MLn1A6ZjfrGY/0qRyz9BJ
         NwplFX2/yhJtCz0nrKwOrAAPJWyLhC+nys68wa7XSwmUZUsRfhMZFedZ2bZjyezBf/F+
         XvMMHfkO0/YrzfcdG7KcQYTrlvwgHELKL4MeJapVPxtNwHg6p7DAh0QmPOHruTWKB6+D
         J7Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUFIK2nHRBu+vyXCtPooVOtkapEqiU1xuuqwX2B0F7i6uPCS2fUEcGanOHk6OD2dxwlxJoU+LqODgq7Co0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx3CnRwV30grO4Zt8t3Y/GbuH3x10bNHT2UuIViG2ye8CsseCcH
	lzItRWoL1984GccqB5UfIyuGmWtIfIrbg70rUNZ+yxa2B5TTwMDZ3pjy
X-Gm-Gg: AeBDiev3dGkL+JESi+7cFZ21eq11aDx9FVCZgxSYFrJ9XySuGoGBVzplXRpc2PQqGZT
	GXjZSWWdOHeURIXAZlF+ZUW3SfFHGLkuSNbHpy+6Pel06WS3+tj6Ed0RzH+UBi3s3/ggKE6lyZI
	+Gsfq6QJL2sjFbAyak/UzfzJoDxtVhc/M/2MfRm/Ne+Gku3ji7lFeyXo4KDttGSpEIXpKolbhCv
	ViadGNnTTjQNUvq2ycOgyye7tbsqdmMkX7yrNnJBi/3bx68eN8Po/vRcie51BzjeVKMiXV0RA3+
	ppdfi6ON/TiA79/iUZz0a0i8UtF6r//D61bW4HzLsS7ys9IRjM77FArP3it0/YvsFNBBhR5Tyst
	UrMFjBsntR5eUht8R69mrEZRfzUYdO5sph00wkThGKQ9J50YVgw8IiofFi1HUhxLGe/qPVVkooh
	hk4sBve/eJ/uZyZCp3FMDDGTeKkch+efl+
X-Received: by 2002:a17:902:ea08:b0:2b0:68d1:2537 with SMTP id d9443c01a7336-2b2817c69a1mr49454885ad.42.1775264400166;
        Fri, 03 Apr 2026 18:00:00 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a3af9sm64656365ad.63.2026.04.03.17.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 17:59:59 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Aboorva Devarajan <aboorvad@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>, Hari Bathini <hbathini@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Shivang Upadhyay <shivangu@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] powerpc/kdump: fix KASAN sanitization flag for core_$(BITS).o
In-Reply-To: <20260403190123.1383198-1-sourabhjain@linux.ibm.com>
Date: Sat, 04 Apr 2026 06:27:55 +0530
Message-ID: <eckvmtik.ritesh.list@gmail.com>
References: <20260403190123.1383198-1-sourabhjain@linux.ibm.com>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> KASAN instrumentation is intended to be disabled for the kexec core
> code, but the existing Makefile entry misses the object suffix. As a
> result, the flag is not applied correctly to core_$(BITS).o.
>
> So when KASAN is enabled, kexec_copy_flush and copy_segments in
> kexec/core_64.c are instrumented, which can result in accesses to
> shadow memory via normal address translation paths. Since these run
> with the MMU disabled, such accesses may trigger page faults
> (bad_page_fault) that cannot be handled in the kdump path, ultimately
> causing a hang and preventing the kdump kernel from booting. The same
> is true for kexec as well, since the same functions are used there.
>
> Update the entry to include the “.o” suffix so that KASAN
> instrumentation is properly disabled for this object file.
>
> Fixes: 2ab2d5794f14 ("powerpc/kasan: Disable address sanitization in kexec paths")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/1dee8891-8bcc-46b4-93f3-fc3a774abd5b@linux.ibm.com/
> Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Daniel Axtens <dja@axtens.net>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>

I guess you missed adding:
Cc: stable@vger.kernel.org

> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Acked-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
> Changelog:
>
> v2:
> - Add Reviewed-by, Acked-by and Tested-by tags
> - No functional changes
>  
>  v1:
>  https://lore.kernel.org/all/20260321053121.614022-1-sourabhjain@linux.ibm.com/
> ---
>  arch/powerpc/kexec/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
> index 470eb0453e17..ec7a0eed75dc 100644
> --- a/arch/powerpc/kexec/Makefile
> +++ b/arch/powerpc/kexec/Makefile
> @@ -16,4 +16,4 @@ GCOV_PROFILE_core_$(BITS).o := n
>  KCOV_INSTRUMENT_core_$(BITS).o := n
>  UBSAN_SANITIZE_core_$(BITS).o := n
>  KASAN_SANITIZE_core.o := n
> -KASAN_SANITIZE_core_$(BITS) := n
> +KASAN_SANITIZE_core_$(BITS).o := n
> -- 
> 2.52.0

