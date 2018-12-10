Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AF2C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 17:49:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A9D2082F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 17:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ed5+2KRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A9D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43D9Yp4ckJzDqNB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 04:49:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ed5+2KRT";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::b41; helo=mail-yb1-xb41.google.com;
 envelope-from=keescook@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ed5+2KRT";
 dkim-atps=neutral
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com
 [IPv6:2607:f8b0:4864:20::b41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43D9W15xN0zDrBw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 04:46:52 +1100 (AEDT)
Received: by mail-yb1-xb41.google.com with SMTP id f125so5577150ybc.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 09:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b2BEvgAB5tLKe2Jkh8uFQEGm89nJIznxDfmpwN13nSQ=;
 b=Ed5+2KRTSVSDtL10OQqbAy7tkXxqY+L+ejJmN9mLWx99XXLQ1BENnexZZOpiaWYYak
 1J8gj6XA1Z5St57yHr8femJnLeCVsFL2RCbH5035SGZ4H1LotPMWXbh+4xwCcVI8PPEl
 UWeJFOaaX1Ngp6+RlavDa9V6ERhRNyMOjTTlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b2BEvgAB5tLKe2Jkh8uFQEGm89nJIznxDfmpwN13nSQ=;
 b=NtRvhPkilnml6EfFBbRFHx77g0cfxFBmndc4hRLngYel2uXTfQjOGxtGl+BWXSTYuy
 JIDEK+8p4FXbV9dMk6VeUsiYOdZJqIMaGKjvNXD0t9isD/OgX/Ff3cnvT9Zve6WDx+Ir
 4ffcfQmhk/zuPXsh38vUN4ou7D+HqKWMG0T1xi2jca5CpWot3KIyIORjGLClxxJYgY9G
 +tSM3H0VvK7BJuR2pQJVGz+J852vOCOsADbwcZQ/7/2KceKb4p7uZlwficJafOjd9wrm
 glaUGPXjSCk+nsA4+XDAAkzwZmNaXvsvEZm9vRKqBA/lOS76KGGWmknJWEbELIKQf58p
 RlXA==
X-Gm-Message-State: AA+aEWbGrfWRsJi2l8Bg1owgviuk3IPd+c6YNVAy1Y0ZUdGWub9FJbVb
 0W55OfRerfEhjp9G5gfN3TuVfnxG/9o=
X-Google-Smtp-Source: AFSGD/W5dgU8ZkBk4VV6iUc9XmXW+Bfw6IceXLIh4JHk0SzDZI7TXy8nnCdCyH3AUDc25/QTUmbokQ==
X-Received: by 2002:a25:c706:: with SMTP id w6mr7403192ybe.136.1544464010272; 
 Mon, 10 Dec 2018 09:46:50 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com.
 [209.85.219.177])
 by smtp.gmail.com with ESMTPSA id 137sm4018812ywv.108.2018.12.10.09.46.49
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 09:46:49 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id k136so1893899ybk.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 09:46:49 -0800 (PST)
X-Received: by 2002:a25:2347:: with SMTP id j68mr12922476ybj.137.1544464008816; 
 Mon, 10 Dec 2018 09:46:48 -0800 (PST)
MIME-Version: 1.0
References: <40d63adb6058b1fbb4082ca6f15225cb6e76bd62.1544429175.git.christophe.leroy@c-s.fr>
In-Reply-To: <40d63adb6058b1fbb4082ca6f15225cb6e76bd62.1544429175.git.christophe.leroy@c-s.fr>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 10 Dec 2018 09:46:37 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLfNf8NDyZS3jQB=XU9ihs_xg-UBZzFAB7fZaMSaMSPXQ@mail.gmail.com>
Message-ID: <CAGXu5jLfNf8NDyZS3jQB=XU9ihs_xg-UBZzFAB7fZaMSaMSPXQ@mail.gmail.com>
Subject: Re: [PATCH] lib: fix build failure in CONFIG_DEBUG_VIRTUAL test
To: Christophe Leroy <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Colin King <colin.king@canonical.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Dec 10, 2018 at 12:08 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> On several arches, virt_to_phys() is in io.h
>
> Build fails without it:
>
>   CC      lib/test_debug_virtual.o
> lib/test_debug_virtual.c: In function 'test_debug_virtual_init':
> lib/test_debug_virtual.c:26:7: error: implicit declaration of function 'virt_to_phys' [-Werror=implicit-function-declaration]
>   pa = virt_to_phys(va);
>        ^
>
> Fixes: e4dace361552 ("lib: add test module for CONFIG_DEBUG_VIRTUAL")
> CC: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  lib/test_debug_virtual.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/test_debug_virtual.c b/lib/test_debug_virtual.c
> index d5a06addeb27..bf864c73e462 100644
> --- a/lib/test_debug_virtual.c
> +++ b/lib/test_debug_virtual.c
> @@ -5,6 +5,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/slab.h>
>  #include <linux/sizes.h>
> +#include <linux/io.h>
>
>  #include <asm/page.h>
>  #ifdef CONFIG_MIPS
> --
> 2.13.3
>


-- 
Kees Cook
