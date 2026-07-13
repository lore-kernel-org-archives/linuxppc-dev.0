Return-Path: <linuxppc-dev+bounces-24116-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD62C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 13:47:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzNzR0YM6z2xwN;
	Mon, 13 Jul 2026 23:47:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783950450;
	cv=none; b=ON5Z7w5ZAhNQYfehJuCZ7H8Gamn48n3oLchZDcotPE7Pst95FmqBAPFclYduJ40DYG6mPyo6LBvPftpZxzvuEyQ/Vicdjh83iYOn77PMp7kh4GKhbd6K2IEYFW88UnTWSL9fg8EFnnKYgDBtekRuQpKgSJqZLhItYPCHNLIXQ4dGZOK4NUwASD90iSS0qcnyZ58U6IJSnkB0MO3fjNU38Ejb0F2JZ7EhyWo5j5eQB/HdEMnijCYSfXd4HvxO4tpIxq8OBvuBt1g9+CTnjiW2IFvNPe71OcmEMKJGh+RSc6gaPflcgESklaKerezXzFEGOCDH5sJXt/1G/+hJ4Xk90w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783950450; c=relaxed/relaxed;
	bh=DidKVYu0F2Emj2o37zWQ67YKMQ/cqUiWa4PnHuuYDj4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=EN/k2LymSO+fUuVxOCQqKXYGmuw/C/zkTa1qS4prP8/026WrprRbbbnX0/SnNOmWeSpS+XJ7bHyH0rlwyh9AoOMdMWHebBIh30Q4+F8DwIEMQBTmSStCYT75owUrNYQY7AJKvOyJdglVqyHlbesMXLUPfo7fcR6cTW+5VtO3IhVvxD5m8mpRrjoCqkKqstXm9+NbESAoCxPChPV7XN3VGtc9khKPDq8vQzaQCbbjJeMHLQGb7inkEMYRLQWJdpFFnBokz+Y1TWeZoRc6gKGMvXk/bgs3xLwf/3PzLOsVjYnYcQ6R1DH3uD1tEg7y5BhyQh1hawjcG5a0r/WmNSv3Ww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MgzOsbVx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MgzOsbVx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzNzP45TWz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 23:47:28 +1000 (AEST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-ca957432c7fso2175885a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 06:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783950446; x=1784555246; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DidKVYu0F2Emj2o37zWQ67YKMQ/cqUiWa4PnHuuYDj4=;
        b=MgzOsbVxJgc/i6AN9Z8lzBX7NJU088XzW4TgHqEwgk5s4p4TXuf4bnZF5cbWwiQlC1
         HE4rK2LySuHnWMM72qaiatI4BhXnModz8mY/wdkc2repKnemvLNPAC/VITBWEzIl+vcN
         dI3hm/sz7kOSkuOVcZfy09sGS7KitZsVOhzrSV6eRyEm3SSQ1BUl4MR2D+jkfbC4zciw
         sCNcdEi9NYZiO3FscLRIvTCHziOV0aqVUN9Wxn55p8A+ytqsig6bvWh1j9d1bucNOX6s
         6wyJq0hbdMY/L2OXtoLEZ7C9qIgbP3Yq8Jq0QDhwqsWar0Yu0t4xBZBtbHzTFLRTx/MW
         bfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783950446; x=1784555246;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DidKVYu0F2Emj2o37zWQ67YKMQ/cqUiWa4PnHuuYDj4=;
        b=HqjliD0UyDgFZIksdt5jT4NU1L7PZPMaUsIaxD4IgwLdUrwBje0gK58UhFg/sWTDW2
         ErSCC/rYrKOXBDDx/G37E+5PI9b5xu5Cxv8p97lZ1oedNffQQplmdiNZB489f+YZTU2m
         /PimfaZ6dk9L5tmw+Bylq+01DzU6xuLHDeyBr++XDvn8hC0zYFfzWfq2j1k5o7eSqLJe
         veRHJAJpMNz/DvUKKv467VgDZak0qbniGjvoRS8RF+TIPX9JOlulSGjEtC4wEPGolSRU
         X7qXZWbPBK4cS/1vPUlAtV30MQV8JJf8IZ5/DtNVQ02rYfZlY8KO/HVD3xVN4lEBGtPf
         /BXA==
X-Forwarded-Encrypted: i=1; AHgh+RqS1Tk9DV37PoNjVMh+nCwZuNk9XyplQWfRjjyJi9UGcyqv3vdxw0J2uGHDHNUCqbFK9mF5RRjv3+RDOjk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxi/8/DydNzTgc76RO75yomo5VZHEtQuts3yMUddKKrj/uA9P2P
	P6qvtTTPvNvq58HcnuOLeB72V0kw04/qniSRRREUZxzeenb3dmz3x5PP
X-Gm-Gg: AfdE7ckYtZr5JxxruPDr6ezjdvAC9PZYwh64ErQ6eiScNT+9MPDkNQu+I+wuuWmG63V
	rB3VDGC65qyi/lsbWS4niNU5ChrkORpnQqm89MfjByCJxumzTnwIw9U1aRTwQJsb/SZtSuQjg6f
	CBz4gR69cSjdgfvl20NgEzyf3NwHFpHaAz2FV6Z/c9LbVsxCUWjywbX/SKkrbqOy/ocrLWqYSE4
	0JWnEZqYHxs5jhrBuDqfq4PGsvwxbpFU0Dj5Umd/Pr21aACCDjOD8bvJGmnDaY6bqqeQ1OJ2vPv
	xGYxSOXoskuukE9GP8ESX6MvIiSuVfAh/l3hMEr5yxN7ABaKX1UNKR8A8POHICXC4Gg56MmQ8LM
	g1yc63e3SAOsEBy4lDmFC9Xk0P8EKAetuyHSbWGCB1vA4JhdGDqG/KkM/OoRGaJ/+r88Drfgzb5
	hYAN65/fWz5aM=
X-Received: by 2002:a05:6a21:3383:b0:3bd:229c:dcab with SMTP id adf61e73a8af0-3c1108b490emr11781651637.17.1783950446099;
        Mon, 13 Jul 2026 06:47:26 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174839f89sm71169157eec.10.2026.07.13.06.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:47:25 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>, Geoff Levand <geoff@infradead.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Paul Mackerras <paulus@ozlabs.org>, MOKUNO Masakazu <mokuno@sm.sony.co.jp>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, stable@vger.kernel.org, Geoff Levand <geoffrey.levand@am.sony.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Fix map failure path in dma_ioc0_map_pages()
In-Reply-To: <20260711130931.740719-3-thorsten.blum@linux.dev>
Date: Mon, 13 Jul 2026 18:08:56 +0530
Message-ID: <ik6jukrj.ritesh.list@gmail.com>
References: <20260711130931.740719-3-thorsten.blum@linux.dev>
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

Thorsten Blum <thorsten.blum@linux.dev> writes:

> If lv1_put_iopte() fails in dma_ioc0_map_pages(), the error path
> decrements iopage but keeps using the failed mapping's offset. As a
> result, it repeatedly tries to invalidate the failed IOPTE slot and
> leaves the already installed IOPTEs valid.
>
> Recompute offset and invalidate the installed IOPTEs instead.
>

Nice catch! I wonder how did you catch this?
Do you have ps3 console where you somehow ran into this ;)
Or was it a manual inspection?
I wonder whether PS3 consoles are still being used?

> Fixes: 6bb5cf102541 ("[POWERPC] PS3: System-bus rework")

Looks like this was from 2007.

However, the change looks good to me. So:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/powerpc/platforms/ps3/mm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
> index 20fc5b68faee..315a32fd75b1 100644
> --- a/arch/powerpc/platforms/ps3/mm.c
> +++ b/arch/powerpc/platforms/ps3/mm.c
> @@ -615,6 +615,7 @@ static int dma_ioc0_map_pages(struct ps3_dma_region *r, unsigned long phys_addr,
>  
>  fail_map:
>  	for (iopage--; 0 <= iopage; iopage--) {
> +		offset = (1 << r->page_size) * iopage;
>  		lv1_put_iopte(0,
>  			      c->bus_addr + offset,
>  			      c->lpar_addr + offset,

