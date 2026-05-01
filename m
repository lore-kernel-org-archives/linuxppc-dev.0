Return-Path: <linuxppc-dev+bounces-20374-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFFCCD3423
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 17:59:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6f1r1S2Rz30Ng;
	Sat, 02 May 2026 03:59:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777658368;
	cv=none; b=S0ru4zNgVKGp/CicfQue6cwqupfl/1HHNR3tSefApcrviVo53Gdz+MYekMsDfkETUL/3/7nOjEpVbqqTcfHplUZD8VU04+GOIx7VLEH0atRa4HluWdTRpPZQgXjAcvFcWfN81jcjmDckJqVWOUmU39/j8Ow58cS97fp6+BMY4Mxf/eGccYE8PLx+jDkQDu88sYeh6wZhR/U6J6NT2o1jaCzx8t3krTjLpe3fZ2SPIz5pDf00piksr7P0Uz2JSc6xIT8+VheaEjtYh+OpJyHw/c6dUX02DvLQVVnaR4I3lwLozu9o0RqUAbVzhLR/v4/aEh5aT42L2S36kBPEXWyyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777658368; c=relaxed/relaxed;
	bh=5+/e7dJt2MU31Z+SqBYGMwjuUbd0OotWBmXxOfFOWyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qs8zzeDT7z/UjvDAKeh0tvckCgfEKOcR9DKmp7oirmijf45ZZrwui9TXajkIpE62ZnCt3DFPgVVAJoa+omCMJobxJGFXAVNAc2qhTUA1Acqlu5oHMWTcvdA0LiCMaHMrJTmrYHzebpLtVVH/c+6TtLjaOVAW/X8QiSESAnLEWsScQdW6pxjeoIz3PNMs9yJoPfRgglt+i6Rk2GftuQrdh3AUIO1Ij4KDS/TJKbVbzFnPvo1tlC+F19o10ydaYf//cKOseF6PJqJ5He+2GRnbM/5lf9kKevFSkblBL/9c/W0lQ2/bNQRSN/Ls2Nnbq2iEsxxDvXiLtnQ+fbhQuRwazw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JbTv8Nf1; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JbTv8Nf1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6f1q2tt9z30Lw
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 May 2026 03:59:27 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B6B7444548
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2026 17:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B615C2BCFA
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2026 17:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777658365;
	bh=q/vvVmaTofrvdifxLcOjX8owb4zQpccO2C7Xr55syLA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JbTv8Nf1y3JWuLvIXZgUs1p4s5+B1GUlld0WRZbXF6rHJnF7FXG1rC3Vd4wOH+FWf
	 /lu8+oad1AE755FSug1ZcbNt0IQc1USHsGef5ccGfcxzq95KtuLoC1nLMlrSQKzgi+
	 tTiQMMhrfbld8ymAgyQwEiY7I8BtqZz3pZGkD9sFmJ46nTjfdLk01RnECNuTHbUx0N
	 /o9MUrK9GRGCK4V7AJo9DxsUNN94FU6bSe/lBLB3HEZbgoDtdPCtJ4BLITTZoIcrFs
	 HYAyPtyGq9f56cLDbdFj9zzu20514g+BkK1RgtuqirVOywKHAzhsojpDQjUdjBms4R
	 0K/BQ+D5iTcCQ==
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso29857736d6.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2026 10:59:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/OzhU+laW91dWXOMXfSkbjKgwoPiyEE2OdYXIIGC5Q15yv4jB1xZoYI6420ZbD6tih4JQu6lnl0KgYkrA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwSFyAFXRvcWIitSoDVAmm7H+yw/aOxlt9Kq5O6XKdEBrNa/YTz
	b4hKwtfmfNPgO8WdMK91qTGMtk5ymkoDEAnPZdwbnujMx6rlvcfI92yemPn4WJHMBsBpL3NiyYC
	nysGihKMRIJWq49kecTKmWBHP3zExTg4=
X-Received: by 2002:a05:6214:3113:b0:89c:7bf8:c564 with SMTP id
 6a1803df08f44-8b4000bc68amr106932516d6.27.1777658364833; Fri, 01 May 2026
 10:59:24 -0700 (PDT)
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
References: <20260430040427.4672-1-baohua@kernel.org> <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <afTKsSj0i-ZkRZN5@lucifer>
In-Reply-To: <afTKsSj0i-ZkRZN5@lucifer>
From: Barry Song <baohua@kernel.org>
Date: Sat, 2 May 2026 01:59:13 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4w4jyQTzvPSzGtv1r5G35kARHrf4WgDvEiOAw8k5AAABg@mail.gmail.com>
X-Gm-Features: AVHnY4IozGRsOfIFCBuTWYpA9lpafQxUB9l3oBl_1mgfquoOdt6gfYLqIWFbDj8
Message-ID: <CAGsJ_4w4jyQTzvPSzGtv1r5G35kARHrf4WgDvEiOAw8k5AAABg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	david@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, jack@suse.cz, pfalcato@suse.de, 
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, 
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 11:52=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.org> wr=
ote:
>
> On Thu, Apr 30, 2026 at 01:37:14PM +0100, Matthew Wilcox wrote:
> > On Thu, Apr 30, 2026 at 12:04:22PM +0800, Barry Song (Xiaomi) wrote:
> > > (1) If we need to wait for I/O completion, we still drop the per-VMA =
lock, as
> > > current page fault handling already does. Holding it for too long may=
 introduce
> > > various priority inversion issues on mobile devices. After I/O comple=
tes, we
> > > retry the page fault with the per-VMA lock, rather than falling back =
to
> > > mmap_lock.
> >
> > You're going to have to do better than that.  You know I hate the
> > additional complexity you're adding.  You need to explain why my idea o=
f
> > ripping out all the complexity now that we have per-VMA locks doesn't
> > work.
>
> After a brief eyeball I share Matthew's assessment, I really don't like t=
his
> series, it's piling on complexity for what seem like niche cases.

I=E2=80=99d really appreciate it if you could point out the specific parts =
you
dislike, rather than the whole series=E2=80=94I don=E2=80=99t think that=E2=
=80=99s a fair
assessment.

I=E2=80=99m not sure what you mean by =E2=80=9Cniche cases.=E2=80=9D Do you=
 mean avoiding taking
mmap_lock for major page faults, or releasing the per-VMA lock and retrying
the page fault?

Right now, major page faults always fall back to mmap_lock, which is a
significant source of lock contention. I assume we agree that this fallback
should be eliminated. Or is there still no agreement on this point either?

Where we may differ is whether to hold the per-VMA lock and
avoid retrying the page fault, or to rely on retrying the
fault while using the per-VMA lock (with the current
mainline approach using mmap_lock instead) ?

>
> We already have enough weirdness in fault code honestly.
>
> Let's maybe discuss at LSF if you're attending?

Sure :-)

>
> I will try to have a more thorough look through when I get a chance.

Thank you, much appreciated.

Best Regards
Barry

