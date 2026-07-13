Return-Path: <linuxppc-dev+bounces-24101-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A33C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 07:26:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzDWY2gGzz2xlv;
	Mon, 13 Jul 2026 17:26:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783927577;
	cv=none; b=WTUcXlynw70uVMOiemtZTKsHECUqwSuliap/iSbTvGDHlD2ttGOUggT+pWlXmumEkueRbIiJI8eNU5zj3mjliyLjqmgS1AyBEEoaFcwrgRrf7/c+f72cBiu6fRslaFKXNisX5DUgxwHQVfKevEy+l9gPXjLyA3mo77L+kaQbN8iT/gzzlGOFmMfYhrIzozrHWh1ACy66ZmFVAjzEyBmFBRje92xV8ZyjtLCM1tim9EhSHuxnEDeacyVyxWEtnK6Hql5km6wLOL1G3H53Xhxt/rBxUleq/DY3THmFFKO5YyTjmznlT2ejfknbjQBvfc1okecQQ+ZRuXWYNBiG4UKhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783927577; c=relaxed/relaxed;
	bh=pZpRufE+atPJhwUoCXSUsAADL0t9BgJVyz0IvwT2zdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvEgfDFmt3FmdkS/5c0vREL3o2/w/wELwd19fAnJR7Z9bB0y50E+R5eehJ9hQ2F5uJtl2sV+JbJcULtqpI9orvyTmDQDdH8JqEog/oXsDVNL9s5egFBOZdyclE/OUBvSDrN2Qw5LKU8fHxaeDHybPgq4nx8BnU6zjKthY7FDoW3cYaThIs0ZygB1VioLvM3juzTxTTOxQr6TT5jtvr/pTdG+X2cDF3yVtxbrDJS0O7FbK8BSHstHIMllC7nH4KMbOWBvuqBgpfCPmg4pJDtC+X8jG7kPLuYBolC54dQIclv11N/ytD5dk4Nze0AaDnxxJ4gBCeXMP8+prGeqt9vTcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.221.170; helo=mail-vk1-f170.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.170; helo=mail-vk1-f170.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzDWX4YgJz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 17:26:16 +1000 (AEST)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5bdcbb1f3f2so2092808e0c.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 00:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927574; x=1784532374;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pZpRufE+atPJhwUoCXSUsAADL0t9BgJVyz0IvwT2zdM=;
        b=kk4dHphjVj6rslJ0bfZvqIBXrzktbsFQwYqviLKbgY+VziGeq1Gj9YzKshF4hJmr9r
         6TdFYOwl9wogaiuxTDq5lNRu8xUbyc0hXH1fyVOIdqE6FvP2ZYXCz+Dv4C/d6B/mxhxr
         hNT/XI9oLOZCz3VcpwulIKYAtSIq7bT2D2ZYm/xm2+THqwkdE3AyyWoOaGkNsGWbnq7q
         1ziwqmqSff7GPkjOn3JztYEejVtzXdviU6OP2cdc5uIOir7UE06+5VlurOrx4DyNsAMy
         bwXf4/BCTM2dUL//3qCr47UBDd8i44EfIJyXAuGbwzg9AL08SRLfNYoK6Uc3F93UqXb4
         hO+Q==
X-Forwarded-Encrypted: i=1; AHgh+RofKFc1s315kwUzSFFFE7OLhsQaA7DB9sSftUIVh1VbcDswDzmgTZdZpR30b2x/Wgi65Yja+3Iw2fV8HqI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxf7TFpxPA2ruxq2JV60I3+6GvWxlSob3i6BAxjK1Nwcc+aSZLt
	eP4qGzouSZ8DNmw/YVOxCJblkAXUWL054aMFcUJQPSy9alHn9e1Ne7oavvnIxNGw
X-Gm-Gg: AfdE7ck8IkYc2rKs2rYwp3p4q4b0tLy4ryhBUBjDdgmA2R0zv0FbHtldKqK91JnWi3Q
	KoI+iO6x/8Aw+gvo4RbbVVmxCLOODf7QC+D7Lv8BTNVv/vqLopLAE73ZcHeDoaCVFm+eA2GWiGs
	FYuMr10Y+txpx20cR7IdM/XhP6GfSrQJEcY3iAPBdMcbQvSozohx5xz4fM/4zNJjNGa/y5bL0Tl
	fBqKVCJDqGcCR/8c4EKlNZETjL12p42+LAUXDpiTzU01k1aa8AHcXtsdyDkfeqadeswQNAaDbNB
	ldqpdChHIT5sekf5HwQGm5n+D2S8aCjzJkl+sX2sZcBX1eAhflAj9vO+9TntowAoZim0lrpu2yO
	h7rJC88e2YiuH0RbiBSWOgLJDLrMu2iVmF3PwxDImuNHbJ7DGQdvmrK/o1UR/Jdxq707vDbnAKQ
	DAP/Nclptis4mLq79Co8TsDATBiYQMC5sfRnp7oSBtGJI3uWztDA==
X-Received: by 2002:a05:6122:8281:b0:5bf:bc5e:e24 with SMTP id 71dfb90a1353d-5bfbf359221mr5287633e0c.12.1783927573795;
        Mon, 13 Jul 2026 00:26:13 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bfb1aefafcsm4468571e0c.4.2026.07.13.00.26.12
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 00:26:12 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-738a5cc517eso1988233137.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 00:26:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rph1bHPU+DYEAjdX0Ma9pCZ2/U+JfzantKPWe3z4ZHkBj4FlvXlvVe06iOFGpu8TqFDy441TD5v7phsYWk=@lists.ozlabs.org
X-Received: by 2002:a05:6102:c51:b0:737:4cac:52f7 with SMTP id
 ada2fe7eead31-74533dffa89mr5010238137.19.1783927572213; Mon, 13 Jul 2026
 00:26:12 -0700 (PDT)
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
References: <20260712151300.3664-3-thorsten.blum@linux.dev>
In-Reply-To: <20260712151300.3664-3-thorsten.blum@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jul 2026 09:25:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWt7uGk6DtuHhCAt3HHbk-n=5Lpv=TWKJF4S91AjC86Ww@mail.gmail.com>
X-Gm-Features: AUfX_mwXfoutVUJ7Zk91DbuIFbVlr2je9gAzJZpObyMerIEe3kbKDq6R3E2Xfs0
Message-ID: <CAMuHMdWt7uGk6DtuHhCAt3HHbk-n=5Lpv=TWKJF4S91AjC86Ww@mail.gmail.com>
Subject: Re: [PATCH] powerpc/ps3: Remove unused struct table in setup_areas()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Geoff Levand <geoff@infradead.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 12 Jul 2026 at 17:13, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> The local table structure is not used - remove it.
>
> Remove % in the comment while at it.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

