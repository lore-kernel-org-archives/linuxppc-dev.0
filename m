Return-Path: <linuxppc-dev+bounces-24100-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB231C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 07:22:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzDQw40Wxz2xMW;
	Mon, 13 Jul 2026 17:22:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783927336;
	cv=none; b=nzVB1tKiwfCO7pP7wPpO8TXwZ+6RSsSLNN+T05Y54WBfU9Xc0I6qlPQwOenIQmh1v6PrkFXKeBWVa0P1SohI1UKJ2K8O/F/Wmtno9C7nyCS9VSgH23Q8aw/D2nObDU22tZ3S4PRPEuvCWoqOohsNm76ZlY1lfTKutVp4hmrQaIMVEvCwMY55K5ZiLNX5Y1M6JA0kXsszwFK/i9r5u7lxHR/GpPnAghi8no8hyMcFeotgvH8Or43jwJhaY4+UfY/LY25NmVRzjppZw9saxHVIRLstlXqlX6BmS/RGQKBDDMC5omC7xyX2D1wFIPoz68EN6gyIqNdNnOeX102ZfITbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783927336; c=relaxed/relaxed;
	bh=k9efCbe+5Y6ahQNJH2dxKPZ1FaQevv/SuYysWDsVR8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLLB4SWRqw25vwk1CIzwM9MH38MYU5kEGqoUxVL1Hr2tWGntK/qRnMYb+uTXVI6zuVSafCukvLpcJ7fcik79BlGS6ssua7BkJGmswYNvg7OokQMzCyeVG3OJfI7m9jlVEVBU7M0kIUKKjJ69mIhDnSZo0dShibKUMpplLwCaHCm/ECFSULyHpzHzMlSE2xMxUmEMKQ4I7Gbq9kGWx2ycrDRGZbRh8ilFeu12XWj/R5uS0HS06zhbUfXNNhOS9HehB3D1nwosrIsjmZVd3gUCupQZZ8p4rCeUdRXPe5N1ggA9v6IlZo8DZv6/+hAuq//PfmA23IKC9uDUkxrtQx8BXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.221.171; helo=mail-vk1-f171.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.171; helo=mail-vk1-f171.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzDQv0BFZz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 17:22:14 +1000 (AEST)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bf95ade656so1216134e0c.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 00:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927331; x=1784532131;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k9efCbe+5Y6ahQNJH2dxKPZ1FaQevv/SuYysWDsVR8s=;
        b=IfhZPR0OSyr12uTEHQNTBazhjtIeCZ/3FEF+0WEYDiXBoxCOLoOcDeUBCITp2gBq63
         a79RRyUc3Tc4D82Qw+KjPfUgvqamgoDkdjz1w8cs+19Oh4wsE5QQSLyxkVTnVBqbSeFb
         2aTouL6AJ5s/S50H3Mmysi3vAq6cXdXcsZnzB5XbYAiODx7Y32Iy7scZntfI99nTxqLO
         JHwXMHmX69vNvfR60t4wbgo434vCq2JqgjLUdsiYWdlLsI0NJgYF6vOPS/D+ZjG5HayV
         Cz8tYmV7GpXMRobr5m1+D8ubryWgRpirJDI2DXSXxdaHtd5kJEkMjD2NI+7mlu1CiMAs
         hEoQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr6pok5+ouFI2GPEO/TI/oh5qlt3nPaWAmb+Aa7xifffSQVzsgdv6nQxxHCrKhmyLh7U7FW0+lhi5hYVAY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwNtwndPMxJDHLQ/Uv9NpsFpm4vbXOMpE5MIJ0rlWqNAFz2LcYl
	vjmkaQieNPiFn6tWi4BPsfN6H4zZ5kET1/ovfYFTRvXaV2/f/A2+Ew3EymW4eWBA
X-Gm-Gg: AfdE7cn58Zn4dHYSqwZdchhUcdXpV+GE+/OityxhmtWUW/FjXq5BFpmbGIWbtPJu5oo
	MLFfeKgW6pYVsJBQMLg6R0hTx84bTwOIFAHdTf3nKfLEnKtP6N45fZM1MY5vkZZq87zq7e1SdHg
	wxpPdybpjSjijERTXjAWptaUUxsg0BF0lNB/v7AYoNwwIRAJMR/1SI3L0mkyu8fiLgTYqVr3ib2
	26P+31kVc9zPs/0PhKit8lByKIxdD4vi+jWkgCoxWtD7A4t9gwdkf1sq4S4801ZjqRJNwYe/LOm
	Hr7XLo5fdrFYacZDncyZpF6FJY5AYYz717DXD5pCFTZ66gNlVEnNFHLLFd9eUNXWO+h6SZbWsFX
	KgYBZMAk0BhWwpDR7QJaM8/MF6X334QbgdZ26VLRhCTA5zLRsjLc/VOImZuLxRWxN6vEo1FyhgD
	Me5HVT0SxX/JILCV2CpDVnG06ZTbWHKupWIw+rqheVsvKGo1fHOg==
X-Received: by 2002:a05:6122:459d:b0:56d:b639:5c0d with SMTP id 71dfb90a1353d-5bfbf41eb67mr4444838e0c.13.1783927331218;
        Mon, 13 Jul 2026 00:22:11 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bfba710bd9sm4302204e0c.12.2026.07.13.00.22.09
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 00:22:09 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-963f63fe025so709761241.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 00:22:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoUkhKbadqLv9WlUrrWYprlZOkxCMUWgR9WgDvC0ncB2LHGVAFlU5ZTq+jTT5mI+ueBdfA3LmyQTZkWI7Q=@lists.ozlabs.org
X-Received: by 2002:a05:6102:26d4:b0:737:783d:1900 with SMTP id
 ada2fe7eead31-74533bddb5fmr4721253137.9.1783927329441; Mon, 13 Jul 2026
 00:22:09 -0700 (PDT)
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
References: <20260711130931.740719-3-thorsten.blum@linux.dev>
In-Reply-To: <20260711130931.740719-3-thorsten.blum@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jul 2026 09:21:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUK9a+1EwCGFw7dS8tvU=N438Bd2Z=EY0xuaQYPDy2hug@mail.gmail.com>
X-Gm-Features: AUfX_mx-KZ6ym34u_XnSAl1rHvfZCpzLD6QFC2QtuW07Z8oE-TV1vNB_HazP5kM
Message-ID: <CAMuHMdUK9a+1EwCGFw7dS8tvU=N438Bd2Z=EY0xuaQYPDy2hug@mail.gmail.com>
Subject: Re: [PATCH] powerpc/ps3: Fix map failure path in dma_ioc0_map_pages()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Geoff Levand <geoff@infradead.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, 
	MOKUNO Masakazu <mokuno@sm.sony.co.jp>, stable@vger.kernel.org, 
	Geoff Levand <geoffrey.levand@am.sony.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Jul 2026 at 15:10, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> If lv1_put_iopte() fails in dma_ioc0_map_pages(), the error path
> decrements iopage but keeps using the failed mapping's offset. As a
> result, it repeatedly tries to invalidate the failed IOPTE slot and
> leaves the already installed IOPTEs valid.
>
> Recompute offset and invalidate the installed IOPTEs instead.
>
> Fixes: 6bb5cf102541 ("[POWERPC] PS3: System-bus rework")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

