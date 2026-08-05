Return-Path: <linuxppc-dev+bounces-25418-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A23AC55822
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 09:10:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFPkj1x8fz2xqM;
	Wed, 05 Aug 2026 19:10:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785921005;
	cv=none; b=U1W/gXVdBuSee6Ge5h39PqQ43lWlRmu52jj3qyb5o3q+YOmXR1bfHatPEmPfV+B3U9bo7G2akUJQlO6/GhQzZDeNvzLbcpwCOsgIpKgvTcV5SGg1QYYa3NLI+8vWgbylFp8GY3Ev/ogwzfU/Eh4kixRYVGb4L9fYrk/03E3kqzCu4oJGmAFB/2nDRsZZSuuTasLvB6yCp5xi2ush/Ojq3tsvmqXRKnUo8jTQjVYVeNnYhpY7CA2S0WOuB7T1tl/xe+Cs7BvJGhNcQMl688PEkA2lODEG8U34bGMMO8rgDS3pXkt3kYWRsKTwMP/DEECYzq+Tt01I+Kvz63YoCQAYcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785921005; c=relaxed/relaxed;
	bh=IZMk7vIjYI1+jmCS+K1I7BsKa3PUvNRhA5nUB7+f29c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOsCYBJe0Lg0Qem3kGtdRSuBfHcyREsSllaragFATSGqKGCNMtf+uFUThIQ03sHbmVpHTG8AjqvCQotln1I8EmsKVncOoEwgNsiN7m9F6PoCkgSohJG8iYlRMeJPohOhDM46iNd6wcC5ATTlJlcHchZFO+mVtMlRkV/bxG33rzCjIyrfwRuKQJRxr6FTUkciQjMqgRtUVk5eHl9NGW3dku9qSkUi1REIgytSLKi8XiiDfEdNUysJud8LD1jigGz3yM4yjxMllhcQu0SPCps/9RlWveu2rpsRMY73SI2By0QtIpz/kR3Bla2yvJumY8o2I9Qqhvcy70oDWDXQv6hngw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.221.173; helo=mail-vk1-f173.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.173; helo=mail-vk1-f173.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFPkg3Zhzz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 19:10:02 +1000 (AEST)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5bfd4795097so187168e0c.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 02:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785920999; x=1786525799;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IZMk7vIjYI1+jmCS+K1I7BsKa3PUvNRhA5nUB7+f29c=;
        b=SIMPONQiAJK//+9CWrxvOrSCrTllJrCcbv+/v7H44up/qgJJ8j6yrAqzL/40t6xCkn
         aPR7yvutiq5jWEHTfQ4QiCxnkUflfe0y9dVqPSZRH0RZA59Fd2qMnUCb6WWDv8W0Nb3l
         cSzmk9L9atNuviOM8oHz/nmZvYU6tCN+qeV15oNrn+M4WKQFsKLLchkyy99kdW3L2tEG
         9d8kB/iCREpYt2AN2h9Nulvhm2ytZLi+rLwzdyyErN6AD6ubo5MDfYL5S0vC4Qxjw8l7
         qjapebHuT7NZ+O4boeOkiv5e4FdCU4nFfiaVCDKzb1i+Hui6vmpnrU7R45fZ/83Y7TXw
         NO8w==
X-Forwarded-Encrypted: i=1; AHgh+RoUCA++XzBQFPvvkYfUwXj8H0TLFYj60ZxC6ogkUjOlRcxBvg3fR0aj9rQFKuNlhhYR2XcElYSU+YwHuDo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwlLFXtv0yH2XsAAkFg6WSym0hc83StPyb+pQtyi4VgvT1xw6ON
	439I61S+35qbPfbKcSgobGC8Lt5AV0/o26bLLtsS14YdLmM9lFmNOMpUtorpovPZ
X-Gm-Gg: AR+sD10fA4efL7lKRFLunYUJBoruAypdZ97Pg86hqtx52h7aYEsHBV0X6S6G+SZVqDA
	Dsm1lf3QiEnQXPThFudiRaO7c1ZSzlFxIdTvSwQrBNCYDCc3t/F3ea5RvW2Gq+ogZv/7AZQWS38
	QYAk5Vrl4BU6UJoL1sufNz+K/BT2/j0MQYA1s7JjEt1wf6VRvT1g1dJWokNXNB3Q1LcZ4BLBtLf
	o4Mn3gMchV/7yyL0AqznlKNZtz+A4pyCVZ99IaUL7a0/ElrQZEMIzNvdXEeEsa89KbaU3pS6ltc
	J8vD2O81AoyHAkFhCTSP6S5NcmJmkUV/OrU/8nP3F1gYz7KnyI3xd6owbZoGJJIJqeKrqpNpwge
	E7/mUpUmDddKofbTGA5WF415Qcz1isKdT39R7JsPBSy7LEg9Sx5RHhD3Ic2ikxF1sWZNoFTwo1W
	oLq+Et9rFu5NTxVWJtBHDU+ll5a/5kbQ7bsGUyD5HxtqWgOLM2TekmmUTgq40a4meJ9PESuSqup
	+9b2dVwj5auDRAenPwTczBJak0IoOSnb70fjB9x
X-Received: by 2002:a05:6122:1828:b0:5bf:8955:a8ce with SMTP id 71dfb90a1353d-5c3d907e269mr556923e0c.1.1785920999031;
        Wed, 05 Aug 2026 02:09:59 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d05c594fsm1482537e0c.8.2026.08.05.02.09.58
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 02:09:58 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5bfd4795097so187164e0c.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 02:09:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RplM7wyKo2ADBFBIvLkILmjiCWYrUN9CRoEZETLvOceYxnfZ2mctG6yMuib/Opy0jNLnZE7PhWcCBEGTrQ=@lists.ozlabs.org
X-Received: by 2002:a05:6102:c09:b0:747:5bd0:a2b7 with SMTP id
 ada2fe7eead31-760e6cda4b6mr1138887137.5.1785920997811; Wed, 05 Aug 2026
 02:09:57 -0700 (PDT)
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
References: <20260720231153.116827-2-thorsten.blum@linux.dev>
In-Reply-To: <20260720231153.116827-2-thorsten.blum@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 5 Aug 2026 11:09:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVBjAs_67YdD0mqoBO2yYM2UFZ0=AY4KHJBrz-MmF1txw@mail.gmail.com>
X-Gm-Features: AUfX_mwR8I-sHnR-mob8V3g9S5-pRXulhxc800ceKrgnw7NlAwaqxkR-rqYji5I
Message-ID: <CAMuHMdVBjAs_67YdD0mqoBO2yYM2UFZ0=AY4KHJBrz-MmF1txw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/ps3: Use cpu_relax() in ps3_create_spu()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Geoff Levand <geoff@infradead.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Thorsten,

On Tue, 21 Jul 2026 at 01:12, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> Use cpu_relax() to wait for the execution status SPE_EX_STATE_EXECUTED.
> Drop the comments while at it.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Thanks for your patch!

> --- a/arch/powerpc/platforms/ps3/spu.c
> +++ b/arch/powerpc/platforms/ps3/spu.c
> @@ -13,6 +13,7 @@
>  #include <linux/export.h>
>  #include <linux/io.h>
>  #include <linux/mm.h>
> +#include <linux/processor.h>
>
>  #include <asm/spu.h>
>  #include <asm/spu_priv1.h>
> @@ -363,12 +364,9 @@ static int __init ps3_create_spu(struct spu *spu, void *data)
>         if (result)
>                 goto fail_enable;
>
> -       /* Make sure the spu is in SPE_EX_STATE_EXECUTED. */
> -
> -       /* need something better here!!! */
> -       while (in_be64(&spu_pdata(spu)->shadow->spe_execution_status)
> -               != SPE_EX_STATE_EXECUTED)
> -               (void)0;
> +       while (in_be64(&spu_pdata(spu)->shadow->spe_execution_status) !=
> +              SPE_EX_STATE_EXECUTED)
> +               cpu_relax();

I think we still need something better here, like proper timeout
handling using read_poll_timeout()?

>
>         return result;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

