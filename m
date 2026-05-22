Return-Path: <linuxppc-dev+bounces-21399-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC5BCD5BB5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 13:37:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMRCP4chQz2xc2;
	Fri, 22 May 2026 23:37:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779457025;
	cv=none; b=ftxEL5avIz3ClZL8WHrox703COPxTooBmb4MqcfoWIqkiZtrqYRNF6FlayoiTq7zOlwEplgM+i/2LpmE1Y1iv/S+K27PVeH7Piu0w4V3hVCwpE9ltQkUz1HkIDy2cd8bEz0R1fLyJzAEh9s6L2VjS5p9255IyRBQVzyYciiDY8zub4W6PiHWBWNhAUMFs/ljhZOurwfhfn8bFXgcMsYKTuTsELOznYd/IIYzi1JH7DjfhV/czX0q1IEGoMOi2ulC0K7u5wH5hM8abwlusuun2P17dfo+ztY9VXHrNLDdWeimPWQDWCRlfEgwiqFdTwC8uzDHMqG+AVkcNNtepqlngw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779457025; c=relaxed/relaxed;
	bh=C7jCFBMio8K0Or68UFlDneGQgQYEn3dFY8g5R8vlQ3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVrWVWTcO8M4I8gtZUO6gbOjajEiL8FHlwgBLsIi7KwiLa7LpgLiCvR0FYJzu5ZwWZfEshTv3M4vhnbpi3j+IToRU39l/KAzZUj2MZst2ix4n0iTp63mCmrtfdkwSaxO+dTf4DK+Yp2xA44a0AGIJmkF6nCwWDF9/BGVO9A+kziVGYEiVA+AnQg2DvPnquK+DNCO6tDn9B+rAsac7uU/sD9Gc6qLIz92a7lMBHJWB+N2oFN35DD5mrTx7/8K6HCGv8hLHH1I0vt4EElDJIho6Hm/+qAjg0ksnZQTVORQ3MDZBIPkrdm3PS9LwK+b+J7HVMp6zMEOAGlOl52eii72jQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1Lmx69E; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1Lmx69E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMRCN3QcDz2xFl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 23:37:04 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E2A8A60215
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 13:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950EA1F00A3D
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 13:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779457021;
	bh=C7jCFBMio8K0Or68UFlDneGQgQYEn3dFY8g5R8vlQ3k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=M1Lmx69EaUGXfKI/c4USdBvuLwGQ+/xDCp4Vp2puVY6ZVXRCDmufSHznXa+ntyhXN
	 R03Kuwv1AprVs4yPERWo4NbQ6lZsPmO6iCC/9GUirAMY0+M+mHVmM67vgiOEeQfZjX
	 qH2DVgBBbWmPXsgRifjPILuXvi3SJLcMXcM0wbWNl8qhQGF1QfErk7I7BNcOxwV9vI
	 u01x6beglrUnWbWd7SFgp6j4isuYGa2aNX+AvmEUhYmNcdfuvnZ1//oQzj2LfcTXcS
	 qARUt+2asSCPw+6P5/HdLjtNTDO/B6LGeXnFuulXp+QDrIVZut92w0VUlrkRn2AB2G
	 8trVtwiDj10mg==
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-914b5f85129so71829785a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 06:37:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9fhre1SLUI2/iwterRtEGgfhVD9onAChaxI8W5BbyyGt2XRD3z6CURiUJG7gLWF2YxKBjOTy8OB48Jnqc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzdmxTbHi7mMd2EyHV8qkWCsBXEOn3B+e02BSxBUjNZH+lyHT7B
	TKeoFD4tYdD9MdUvc7X0AsG/bZrFxcU4rrjFBZp8jOxgNrBpSxMnpMKICsyBUyWzr1TEpVL3ef4
	hMbJnpQUpqSe2iRe246pSr7xznHEC5Zk=
X-Received: by 2002:a05:620a:6504:b0:8cd:b2e9:b964 with SMTP id
 af79cd13be357-914b46c93e1mr518488285a.10.1779457020872; Fri, 22 May 2026
 06:37:00 -0700 (PDT)
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
References: <ag4kj84EcKqamdB-@casper.infradead.org> <20260522023305.98223-1-baohua@kernel.org>
 <ahBVh4NM2uoyhPNm@casper.infradead.org>
In-Reply-To: <ahBVh4NM2uoyhPNm@casper.infradead.org>
From: Barry Song <baohua@kernel.org>
Date: Fri, 22 May 2026 21:36:47 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zQuJx1reJxgV387Gh0AqWF0KdoFn9KahQ1BNLPRm57TQ@mail.gmail.com>
X-Gm-Features: AVHnY4LaSBeriPtvEQSWcigqMwNrFp0xeuPJ9HmpgpM3WX7gXW9tFi64IFdXgU8
Message-ID: <CAGsJ_4zQuJx1reJxgV387Gh0AqWF0KdoFn9KahQ1BNLPRm57TQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, bhe@redhat.com, chentao@kylinos.cn, 
	chrisl@kernel.org, david@kernel.org, jack@suse.cz, kasong@tencent.com, 
	kunwu.chan@gmail.com, liam@infradead.org, lianux.mm@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	liyangouwen1@oppo.com, ljs@kernel.org, loongarch@lists.linux.dev, 
	mhocko@suse.com, nphamcs@gmail.com, nzzhao@126.com, pfalcato@suse.de, 
	rppt@kernel.org, shikemeng@huaweicloud.com, surenb@google.com, 
	vbabka@kernel.org, wanglian@kylinos.cn, youngjun.park@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 9:09=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, May 22, 2026 at 10:33:05AM +0800, Barry Song (Xiaomi) wrote:
> > need to touch `filemap.c` at all (probably because you are already
> > maintaining `filemap.c` perfectly):
>
> I'm going to give you one chance to apologise for that.

Apologies if my wording caused any misunderstanding.
That was not my intention at all.

What I meant is that filemap.c already has a very
solid design.

For memory.c, I had to touch several places for the
blacklist; otherwise, the kernel would hang.

But for filemap.c, I basically didn't need to touch
anything, and preliminary testing shows no issues after
moving it from the whitelist to the blacklist. This is
probably because the current filemap.c design is
already handling some aspects really well.

That is all I meant.

