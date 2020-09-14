Return-Path: <SRS0=ST+l=CX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86081C433E2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2020 13:04:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 860EA22225
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2020 13:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qgm2P8lX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860EA22225
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bqmlp464xzDqSY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2020 23:04:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::642;
 helo=mail-ej1-x642.google.com; envelope-from=matorola@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Qgm2P8lX; dkim-atps=neutral
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BqjC80cRxzDqT7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2020 20:24:13 +1000 (AEST)
Received: by mail-ej1-x642.google.com with SMTP id u21so22456670eja.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2020 03:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jV6D5Ck9gFOE7DCBMEmlAIDMaEEB8asrxDS/Nejj/VY=;
 b=Qgm2P8lXIs/sG42zI4dGYqmeeuImWwBegT9scXex3DjQYg1D+hgZGKMOWRoRqEz7pG
 sKvAKulF8YZPx5MXiU36nO2A3H4ku9B/rhHbVwUfkvSpDM+uI5dcOxb6LayzQNPQYgan
 3tcVCl2wWyb5oi7dKZCXHgEA6/7NUpBPDy4Jqn0xwqgbA89WLx2ZEj3tOqWlW7ZFIHeH
 Xn5Z30tBlNIhPn25AniCkxw14DjW2HuyYnzctb8L3gzPIG5eL7HfKhPIk3ZQzAQnoVaM
 J55P0EW3ru9M5Et00VM31+OUnYbvxshnaLd76jTJvDAFe8XgK4WpedOIPCc8v9hRrqBg
 78QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jV6D5Ck9gFOE7DCBMEmlAIDMaEEB8asrxDS/Nejj/VY=;
 b=T9+cMA7kXYz/FMQXgyWu3acHw6Yt/thzICfGUTf+YRDutH8k26ct4QusnrWOsDZk6L
 09ZLhbjj4baXEk27BBzrUvuTfHL2SSk0B1D9gbLPX1q8MSsfMi/n30wjVctXQB7o/B4P
 dg9zdeJ4W0zgeD4tev9aVhgeKWP0ZgKaiWNlHN5Z7p+TQ4NQerpMxrDkDhf6lmmmfQKU
 grD5v45yBxJd+bny7ri4gBjFf3Q9zAVrdFQJgewn1A98TbdCQRHjZVSVAJOKAQET5CKN
 awzYJxE8PeXdraRPQxnuPVifVkEFaKUmORzBr4sYwY46w2vlygw1AD3vMLT2Yu64i37U
 Yf8g==
X-Gm-Message-State: AOAM531AoHUj8VPSBHlhQYsEuWwgdzjSok4WZqX9qIoegE0GGW4YzV9A
 0GLt2GO4fmBzIDmwOhnpp6OyQkbMGcwIHEva2yo=
X-Google-Smtp-Source: ABdhPJxnBtRjr7WvcpNx4smmkuTpFTtnmeqe15JlsLaG07UR+6yM4//MyNOvunJKChDZKrrrN1vT1OGpv807OJjacRI=
X-Received: by 2002:a17:906:54e:: with SMTP id
 k14mr13918816eja.59.1600079049351; 
 Mon, 14 Sep 2020 03:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200914045219.3736466-1-npiggin@gmail.com>
 <20200914045219.3736466-4-npiggin@gmail.com>
 <1600066040.vnmz9nxhwt.astroid@bobo.none>
In-Reply-To: <1600066040.vnmz9nxhwt.astroid@bobo.none>
From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 14 Sep 2020 13:23:58 +0300
Message-ID: <CADxRZqxkB9tzO+nf56vFfvdYBooo1rqEbst=QGZQJA3jWhKLYw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] sparc64: remove mm_cpumask clearing to fix
 kthread_use_mm race
To: Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 14 Sep 2020 23:01:39 +1000
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-arch@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Linux Kernel list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Sparc kernel list <sparclinux@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Sep 14, 2020 at 10:00 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Excerpts from Nicholas Piggin's message of September 14, 2020 2:52 pm:
>
> [...]
>
> > The basic fix for sparc64 is to remove its mm_cpumask clearing code. The
> > optimisation could be effectively restored by sending IPIs to mm_cpumask
> > members and having them remove themselves from mm_cpumask. This is more
> > tricky so I leave it as an exercise for someone with a sparc64 SMP.
> > powerpc has a (currently similarly broken) example.
>
> So this compiles and boots on qemu, but qemu does not support any
> sparc64 machines with SMP. Attempting some simple hacks doesn't get
> me far because openbios isn't populating an SMP device tree, which
> blows up everywhere.
>
> The patch is _relatively_ simple, hopefully it shouldn't explode, so
> it's probably ready for testing on real SMP hardware, if someone has
> a few cycles.

Nick,

applied this patch to over 'v5.9-rc5' tag , used my test VM (ldom)
with 32 vcpus.
Machine boot, stress-ng test ( run as
"stress-ng --cpu 8 --io 8 --vm 8 --vm-bytes 2G --fork 8 --timeout 15m" )
finishes without errors.
