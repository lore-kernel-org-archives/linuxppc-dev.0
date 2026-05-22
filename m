Return-Path: <linuxppc-dev+bounces-21369-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D034CD5BAF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 04:44:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMCP82853z2yS4;
	Fri, 22 May 2026 14:44:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::834" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779425084;
	cv=pass; b=dG4M+ooBpdBa8mdQX4321F0fJI9cX9oWK3u8cFuL0oWLyepJroUHwEaCl+yeXOvOoU70DWon6qn4eP7ZrSYMH1iynkCAoAalvZ8xTY8IRwAX3aQI0uEsUvaDCk8JwF28pW9NvA/KIhyi3sr3K9DRSuDF8eDU82yi3x1V8rVvQWpOUo3o9WQ6iSTLW+TWY3vmjFgYgUw1XVmiL+uFSsdKzssTp3XoXs8UzJaL+5HxGJD3ddv+cB9vsmtGchenX6ut2bhLvaavhBU7nsVv29aHDF9BudXVyvRzjHIsI4ZH4FwAc7mNGRVC2ekaHshtF8M5cQrItaI/dyqu9yrN8yCfiQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779425084; c=relaxed/relaxed;
	bh=QVnZFPmewmp25pRUj35a1bi5TPiOKs8MnkxmM2ghIIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWY5+IYKN8dxerjqMh9IIaiVzxLYIv16maGkfwS6qCKnd+gE4RX1EeKLRbtvQrerBEw7204epH56H0fHg38RYnrq+YFcGmfxVwudSGXC1Hs5whUbTxv14kSzmbJ5DFvjnHWigFyDFaZtyKvlV8BbvOHsVEmX8n3SboMowOxoAskxIeuKv6M/wxLTf0Keips8MIb5Dgp9+ajK8kL37cfshU9KxFCnwW3l8ti4NKy+rUPd55oj1tK2woDjVcSUAeLUC370tYKWil90o8pCYmTpC9NIk1ubozTYNmL7u+dr7DhgUTDwLeTfs+k3ErUosfJonld3ojLsQv/dE37/hWYhkw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BfoHLr43; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com; envelope-from=edumazet@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BfoHLr43;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com; envelope-from=edumazet@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMCP65T0mz2yS0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 14:44:42 +1000 (AEST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-516cc5471bdso17269631cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 21:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779425080; cv=none;
        d=google.com; s=arc-20240605;
        b=IiTR29FKZQ1Lbzn2x7g0KUTuX2/oV+Yo82/OMMCwaoi9wxcfX24OpYM+RhWayGoOWQ
         2LU5yD837GG9mrFNhnIcc9ESdLqOGIE78msBWxtDPDKxnwqQ34hAhQUzORX4qI6z4LOH
         uM5l4XiwOoB2xDHvhXXTUPZ9eqvHMgEzJ6Dn+abCNO19ZlwdFcuJdWE28KVHr63HudQz
         zNMMy0r+Vu6Ixf2xEIGY00YKhkhKOsjq06z1wox++b9yUrlDM6zKyoEgdVPbeKRv0woW
         2ggxUrp/qTrxdlvnlV8F6uxHhVp/lxtqJOtDqcmHx0uRibLCccXtqneXNp9K2q9owkRD
         dY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QVnZFPmewmp25pRUj35a1bi5TPiOKs8MnkxmM2ghIIs=;
        fh=6MhHgscsjLxngyXHAKbX8465mtyl4JABAFAxqJ5eTAY=;
        b=D7cfm5T7HDIErPHUxED1Gun01Q/I7jTVDUReNiBtv0z/TirCtCWmO+tr3XFVm4q2Y8
         kjotSxBojgxXW7r/ZaKh60LDPVeBbaZlnHU1dN4hQStTsrYAS5E4/elm0tws4fFVgZ7L
         I5q7OTtoTsqVlbXED6uyvfCN0IzP775qaCxBHWAcW13wusCsQPbTvtsozMPzVfCU0XGA
         lYZbnc16T74TWdgPEvgXRRE76UfZJStD0ZsAPHymLe12Ivl9aNSzDGWw+pVfRmPp0I1u
         MCm+vW3usleHOESTPzrjqqum/inHMqGjYvh59HdMAjMd9faL4w6uizTxl0nseuxFpdBS
         SHUw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779425080; x=1780029880; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVnZFPmewmp25pRUj35a1bi5TPiOKs8MnkxmM2ghIIs=;
        b=BfoHLr43lDVzgUj4F/lnZOx/ZDw+49ue2e35i9YpF6hAFsfY9/wyTPCsItqktcCiYX
         9GB1bTRVdxIF1jG7oj/7f7EQH1+/Y0GzisDzC47sy+jHDbtAjjmO05xTy9mUH0bEQykt
         cdv5XGUDX4pJ6jpq8DhOrrLnAWQwuE9mCZPj1ziFUvEjrhTYUgMXR/5G+/++iZwvGazY
         WkLeeQX/zUz8Lr0Z1IHe3Z7qj9KkYP4Ch8rSHIpEA9N7M3RIWKkxg6gdgXP0HMgMnWmA
         WZReuvAlL7zcXwqPJIJ2vxbQZKVGeuzgzk6cWyMZyJZdOSrVksHvffOEfsSls6SSgx+8
         QkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779425080; x=1780029880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QVnZFPmewmp25pRUj35a1bi5TPiOKs8MnkxmM2ghIIs=;
        b=V5zotbBDWKNMAXdhR11pO8muh1MOGtpjaVLLTN1Z8Yjc6eyDVS+5Nuh5NdMQl0TZWx
         jHLubBavEeG1dr9w7/GFVnYsLMCthVPrYioJk/3H+spstjXH8pcb9cYkA7ZHDbXbG73Q
         7IoIxo0qhC56vzqZYC1f7cd7YtLVdOld/j7FCLRcUJV9cOlgMeAJ9QEq/s2L8rUBqTAq
         W5LMbl3O2egjQLzxPocXYy8ZEfuIMQ5qLBlQCBR0h9Rduo4jB43GRw4MtTzGZQC+/kg8
         X3ht9KZCfWeJCwLzLNYuVN2NmEOThxURMtgo0U7QPaQ74S4Bcg9bNTVt71K8xzJhYRfT
         PKxg==
X-Forwarded-Encrypted: i=1; AFNElJ/mlDjK3d8dnjZFgCJ/CtjxUEu+WALRo92LOsQ+8KmmoxpojZpZbr7lU/3qLApRbu5MDKJ9ck00UKxKQQg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzfYOIav8rBE08o+I/xNRN3RN5zQGgt9nLiToPMMOZVamguNkuC
	5QuZrrQ2ghJqD+VhnVa8NIsKPFLhPjb4BTgnZLXwhpWM5ZTkg7B+D/8v0NyaE6L585O/E+f7lKA
	De+9zWIE6z3048H/pJkO54LlxaPjJy5+Y+C93OmV0
X-Gm-Gg: Acq92OGpP6KX86NErcnl5ZkKcH/YkSQKIhLHOwAs94RfTl+xeBdqFzCYkr+EYiIxRwc
	dEr8vhoGB/HorLTKcRV9KM/IxwVunGhURUeIR6lgyFCnVy2CMC7dug+mdfCT6agzYk51UjELWmf
	XyD5LF3QDZ8/7bOPFXzcs5/LY+C1CdvxkWINWzff6FCGR8pJYnYyH7/DLsUKn9tFN+7d0A+GeLw
	bHUXAwHthD/Qcsd8Zx+zz+4TqBoE/Jc6+35Xe4E/dxPiQgU5/S4Av8lC2lX9yjVUEYCj9RZef7F
	wLHya59NduJ6b2HwDTd0rJWhO19Vhv/2jHeOzNUZq0/DlEWDQTRvGfgV5PbwK2LzPj4u1d+16v9
	J6HyAclel0anwDQwViZtYZYUnPw4ZJ8GFV1IdApuzGkt4qPZB3glUusL1J7CrJGFk
X-Received: by 2002:a05:622a:19a3:b0:50f:b904:454 with SMTP id
 d75a77b69052e-516d429ace6mr35034201cf.11.1779425079512; Thu, 21 May 2026
 21:44:39 -0700 (PDT)
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
References: <20260517192856.3925-1-rosenp@gmail.com> <20260520165746.7ed10c7b@kernel.org>
 <CAKxU2N_vHyqZK8tBbYLo49iOUJSO56rgqbSdw3CnCUZjbs1qNw@mail.gmail.com>
 <CANn89iK7i4u5nWxQCuURmSCJt8Sn+Q9x_ME8X+J0pF2_4OGuZg@mail.gmail.com> <CAKxU2N_63D7SFPkr9H9UYWif2DRW_qnV0SzZoRHWcRZtC_HTWg@mail.gmail.com>
In-Reply-To: <CAKxU2N_63D7SFPkr9H9UYWif2DRW_qnV0SzZoRHWcRZtC_HTWg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 May 2026 21:44:28 -0700
X-Gm-Features: AVHnY4IwHXQN7oTjZfKPdY-BOjCmCpO8SOOCKwqxNusbTrpv-CvTAEc7R2CudbM
Message-ID: <CANn89iL1fC1UB=wE23Q7rAkQfFNE-XEZaj7bGybbZMNKkfUEHA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ucc_geth: Batch RX packets before stack handoff
To: Rosen Penev <rosenp@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 4:29=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> On Thu, May 21, 2026 at 6:41=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, May 20, 2026 at 5:39=E2=80=AFPM Rosen Penev <rosenp@gmail.com> =
wrote:
> > >
> > > On Wed, May 20, 2026 at 4:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> > > >
> > > > On Sun, 17 May 2026 12:28:56 -0700 Rosen Penev wrote:
> > > > > Collect received skbs on a local list during RX polling and pass =
the
> > > > > completed batch to netif_receive_skb_list(). This lets the networ=
king
> > > > > stack process packets from a poll cycle in bulk instead of handin=
g each
> > > > > skb up individually.
> > > >
> > > > GRO should be even better.
> > > GRO will result in slower routing performance because there is no
> > > hardware checksum.
> >
> > Then provide a knob or something, instead of trying to avoid GRO.
> >
> > For end hosts (forwarding not enabled), checksum will need to be
> > computed anyway.
> > GRO should be faster for them.
> >
> > Note that GRO also uses netif_receive_skb_list_internal()
> so you recommend switching to napi_gro_receive even though there's no
> RX hardware checksum?

Certainly.

There is a reason we added support for sw checksum in GRO years ago.

Most linux hosts on this planet do not forward packets.
And if they do, there is a big chance the egress device supports TSO
or tx checksum offload.

