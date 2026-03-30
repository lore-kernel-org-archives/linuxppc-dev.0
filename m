Return-Path: <linuxppc-dev+bounces-18996-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113B3FF494B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 06:49:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkhh25RGxz2xpt;
	Mon, 30 Mar 2026 17:49:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774853394;
	cv=none; b=kWCHa/Uqo6atRPDtU1DiZggkwCh/qGW2HQBsmY+o3AyvenNlEqDLB5yVO0bdVsmagTaipS31BQXqSbbKYv7VO7sN0C8USZmr2lFgX5vaf7crnV5PzzAiGhLukWP6/V9Q3ZwkCH8MfX7jLkZkhghPJ1hPLqmJEqkxcCObh0LNmnEebAdgVcjFFOKbQwxgxvmNjW3w8m9xBhoaDy8jHPXjymNU1/e7b+4x5by40rSWpA5pZJhO3fada7iPXbpWeWi3bx45YHLIFUYGBRqMAlkq5tbyxD/jIGtn0Gnidk5sbvo9e+Qpd6spPBZ416M0CEwC3YfJ2oFkUIRvYjfclvvyKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774853394; c=relaxed/relaxed;
	bh=tulUJSN7MABRwEgvUtQdM4fFuvpVGNODzZ+gwA9Y1b8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=BWiSbmVF4pr82jOYaJ22pn4Kb8Lf4yLXy+l/fcHov2lc/b0tQHzoyuw/NzgYKV9ssYhiXKGwKgSvl09BCzSC/XjvfoY78B/RZYuagmLSrKW6y070bGxAVDNYPVb27XZL7Vo3sxVycjK1BQ3x5McIm4/E+sLShjwUvueKDmRT6g69Qb4aq9upUNwonx8nMGdSdGpAtOnDQtwUJjFNjiTLb959DxlvSYDvctVrU1CPmkb7ZyDFKT5grrMVaASql4B9X7DzV2+6ZQmRlT5To8GLwwzv1U1rAVxXe7+2Nk0t3v3QiU3n7K9qY2zjQzmvlIYirC0WnF6bkZ3Ml2pB2uuouw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YrUWR0k0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YrUWR0k0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkhh15mPMz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 17:49:53 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-35d932cc948so1070534a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2026 23:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774853391; x=1775458191; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tulUJSN7MABRwEgvUtQdM4fFuvpVGNODzZ+gwA9Y1b8=;
        b=YrUWR0k0Pzoqk9j/Gs3wnI30mtbsqHVeyDuCyuLErWxwHptaGPyoKzaIP/i0J+T0wS
         nX0RhkxLtoU6VZJeWRx/ESihPNkZo7zu8e2Wb9t5FW0Jq9TpgUuWUn1NvOjzlLvR9UFm
         tcz5WtT/kf7b+K/SV5+fmJfMlNI0W7bN380wMTdfHvvJV82Iu1UUI3l293lDWcOCmbJG
         +7mmB71C6pIL+MHS8yLyrgAQwZ7za1p0TcvlAmzzp8PoUr9/A2YcjLeTdq2U94Rj2luR
         9bSkgKIIRDjSn9vGL5szH4AxRNQiWC/klUx/GInUJ0oUTD41kCrLHFP73/GWnZ3sRBf4
         pSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774853391; x=1775458191;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tulUJSN7MABRwEgvUtQdM4fFuvpVGNODzZ+gwA9Y1b8=;
        b=SzB5/m08t8LgIBIKjm9IFyuf4vwuu9AYJSrvZxzZHAAfvVwo2BfadsCHTEy9d8LcnG
         tCoL7DqBSs326TP2yg/vLNSqfO6SElv1oY0toHJpa8e7M7Hle1jcKos8NtFYYUI7goZ1
         xBshz37TN2ZeXRAvtvhp3pQ4DCSVW+/pCjD9syJYe2CD3ZyF/FwehkFpV34AXX1UqwTh
         IE5O8YknC4w0TZD+vcQjr+WqZ72Qnf3vin/kdhMiSqmDeJUX1yqHUZRFAGRGUBqimzjn
         HwirohPWAfzDoy6ris7J6kr1I7XdyhvWp3ALUMoVts4YQ7qJsJrVqMtlk0Gnd0BSwBDn
         M6Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVKGXwGejaq7A6d3Xxi49ghBwuYQSvnn8Vw6gW5dLxZ6PaezInO+VSbXINAedvb9CboCKVCoGHvTgniFls=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YypKMHgztXKk9flGYXN7a4WeWNH4tb8AseC60FR7CBF6qMGsA3t
	Y4zT/fsNE6uzR1JnFZwjzQ/ObRyl1cv6wO3Df5evw/jX8gLtI/m8AT0F
X-Gm-Gg: ATEYQzy8niG+icWkQIWsnclgx9d96LQ+G6lA3W+2Jv4yr9j18+cISn3jEZjI9ijgYxw
	r4KvQ9Y0GNT9iZeobBeaIV1yS4lFwDKpdl6FxkUIegbRuoAoVIlAgXzNRoDK9BGMTM81wFjOYEH
	UAMAJ6zjLNstXBcrodGfzrwTQPuHJizoSLe71K/01ebbVDIkCiTHaa5G9aRsW2an197Mz8gpoEz
	Pl/MZpvSyutvBBzPMF3NsLy2JxpKScXkjn+QZu7XXccNsbeOuJGlV8ayt51II73l8YmZD+EWWgL
	R71+Pj050iAI3v1bn7uCj0y2s+qL6BV/BL1EaPxXPCF12xcoVKbu9Tl1x2ddS6zFCpw/JpkSgcG
	2TfeNndL7MzXnGJcCo/LKmCyLkc+R9ikYxoIIXWwYdhEBom2k7t6KKKxyKBNjgZ8EUB+HlPnOsp
	0a7CjQykGN+GEP3CZWl05Fpw==
X-Received: by 2002:a17:90b:35cc:b0:35c:29ba:bf92 with SMTP id 98e67ed59e1d1-35c2ffa8af9mr10929498a91.5.1774853390700;
        Sun, 29 Mar 2026 23:49:50 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22d8c500sm11522842a91.10.2026.03.29.23.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 23:49:50 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, arnd@arndb.de, chleroy@kernel.org, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH v3] char: nvram: Remove unused nvram_mutex to fix -Wunused-variable warning
In-Reply-To: <20260330062201.2581-1-venkat88@linux.ibm.com>
Date: Mon, 30 Mar 2026 12:12:28 +0530
Message-ID: <se9hn7hn.ritesh.list@gmail.com>
References: <20260330062201.2581-1-venkat88@linux.ibm.com>
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

Venkat Rao Bagalkote <venkat88@linux.ibm.com> writes:

> drivers/char/nvram.c defines a static mutex 'nvram_mutex' which is never
> used. This results in a compiler warning on linux-next builds:
>
>   warning: 'nvram_mutex' defined but not used [-Wunused-variable]
>
> Remove the unused definition to avoid the warning.
>

That is not the only reason for removing the nvram_mutex. I think we
discussed in detail, why we think this can be removed here [1].
We should add those details in commit msg too. 

> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> ---
> v3:
>  - Removed global nvram_mutex entirely

We only removed the mutex definition and not the usage right. This does
not look correct. Maybe you can check sashiko review comments for
details -

https://sashiko.dev/#/patchset/20260330062201.2581-1-venkat88%40linux.ibm.com

-ritesh

>
>  drivers/char/nvram.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
> index 9eff426a9286..9ab2744cd375 100644
> --- a/drivers/char/nvram.c
> +++ b/drivers/char/nvram.c
> @@ -53,7 +53,6 @@
>  #include <asm/nvram.h>
>  #endif
>  
> -static DEFINE_MUTEX(nvram_mutex);
>  static DEFINE_SPINLOCK(nvram_state_lock);
>  static int nvram_open_cnt;	/* #times opened */
>  static int nvram_open_mode;	/* special open modes */
> -- 
> 2.45.2

