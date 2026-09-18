Return-Path: <linuxppc-dev+bounces-27683-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BDAC982D7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 08:20:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmQYS5Q4Gz2y2W;
	Fri, 18 Sep 2026 18:20:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:31::10" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789719644;
	cv=pass; b=IEPb9/Lw/LDb+A75FEigKI2xFapylqBboXBbx09vsioyTMGYsyf9KLlFCD4+T6h+V3RCIbINpMNMRsuFEjAfOw3+xn05EEXU9qJURr0GcXJAdclzNFzVbXr9S9xqAsA+RX/i9NJzKmYLiblky+ssmz+VqsefneQPSpRiX9P+0LCY4bGlf+wjsA0SdBRIqSKVyakWbaO5MgFHHx6/Z4iGKCI3Miz+J853urpHRgUkXtnYJQr3u5uctJ1tdd6gnkpJO1OECTEtZeAijtu47zkX0nrpXhGcbm34mVJgXg4Ucbq6zQRV5qfHXmTMzZmcEKh9ZlvIfJtC00ixO5k84egKKQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789719644; c=relaxed/relaxed;
	bh=S/0xeeqml62b4hzIs2sGIOyHX0Y352/7mh8gz6dinRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjP/sYIWgSNz1MD3kKcGDFRUyCWEzr0Sa4afw8v2nR5kOMSTnuiQF2v0jMngqqtqMxuw+5MBpcQeK2pb5PuoK6lotgDYUrzwd4cHSaLhKK++e9Rmkazs7JVI/7p+6XhvzvV73h61wCywf14P6mF2Ara4KTBn53ywmBDXWBj48ZP1xtGEzuv5ToicrWVfwullsshmCPouqp6Gzf+uVhSlMiRAIAdoh1vKH95I9JwqbjeBu6tS+zplnwuPMf4AxQXi1/ljvHYD/TkRIn9baGs9Thvg1tz8hBxwnq7GgN1+s3nxAvG71BTTKUrfHneRGnc3zR8nEEx8EEMMGwrT7m0x2g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U3G5ZEsy; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U3G5ZEsy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com [IPv6:2a00:1450:4864:31::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmQYR3pDRz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 18:20:42 +1000 (AEST)
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-49b912e64ccso3729275e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 01:20:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789719639; cv=none;
        d=google.com; s=arc-20260327;
        b=alTNMCBCbhN7nSog4JgH8yczTJFb4aGzdCzJevAUgCLyRQZgRgoBGzv0wwscIAYwjP
         G9U1MnbPtwaXdtKTU4hCKuJL0BldMZN0AO7OOK1mjLVZw8eu/5jOthbv5ObW2CTSXCCd
         CVgSaej2xLRvTlAjAc545cd6B40piqUelN3JqltALy9m3gNOrwRANli/twAbM3rasaAp
         Umt+J9jL1cJswbrwa+jOV7OIbypM8mBqj2ioFWT6l3Coias7Eq2+VhFjpjcPXU17MEs+
         pDJy2FV+L80NBSFNU6kNuS+m3XNoVB36BiJSxi/b6iVW3nMKS86yrqsOoZhTDoRRqtki
         w4Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S/0xeeqml62b4hzIs2sGIOyHX0Y352/7mh8gz6dinRs=;
        fh=Wp+IGe9q+xBVN3FMIizbGdUd5iGaWaw9ZMkibs/aTHY=;
        b=bDRCk8pmfe2+iQkqkmHHTs3MyU3X3OdV4qvT524zV/o2aeBk8b+OJ3nfW+lVxtbWbH
         WW2sru89XJ3WDOhVFMYDRBcbBsgEqeCMCVMf1p85Zn70GrehN8M/9x6nEjsSFHlp6Q70
         fBu3nWEIdWFm7RagtFfrMh4TqYBCANqOCT319H6+yBRVWyM3H3CSSzvmlDTZdw0vdD/M
         lVG8IKZBmIv9sIUxwB7dHRQXTDWADOQvlhuoqV7sYfyxIl3tPStDSpvZ7BHYrmTGm+lD
         bXD0TpVyNZ+HsPOriV+paKOLLu4D7w4sEIWehWeZ3S0FakMVA//7UETXMY9wDH1i9rca
         gtlg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789719639; x=1790324439; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S/0xeeqml62b4hzIs2sGIOyHX0Y352/7mh8gz6dinRs=;
        b=U3G5ZEsyr5krg2+3S2/fn/nHihSc+HJfloj64M1dx9OWRKNZEapqpiH1r6ERBFw6YP
         rF4KsYA8UxgspEG6aDxRXsC+Le6EfFI7KDKbNGkf4xkRqNB286yHkanT1r+EBqmtCROY
         FhRtdFIQDiFaG1ITAnIMCw2rMm8jU1V5bl/GYLFNywaSBD0BCVr+IvYO3esG1AzETTU7
         Lt4E642fnomWR+xvlPGsuXa2HTqxIxCTZZN6Lm7+jQvyR2ZlaX3FkC0PUqtbegU+hRbv
         m8L9t9lg4Pa01yknuulnshM/lPoCZsp7M3f4UyN12VfhJ/LkJSDsSEYsKMdnU2QuWfN0
         paXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789719639; x=1790324439;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S/0xeeqml62b4hzIs2sGIOyHX0Y352/7mh8gz6dinRs=;
        b=nafy/9yB8GSSaKiJOO1v8G5QO80hy8e6v26AWDjO2q7uP9FCUVeH70WpwdlUyUejNm
         af51ONlGEw8RLit84wd2fMCkpZ86TjsN3Ac2OmZmpu3Zk5mFeFREupdzgCI4pL56mqZ9
         tNYsdIpHefaOzBVeS1Zwq2E2hSiZYLKqYZoUSf6riGigbFxfomHxcpQ+qdRSkuiOO2HF
         4ic17yes+KwmlwEdWi2JmDMdGlXEYHXw4NRPjb5On4Ib0WRvNgpX2xCq+2QyD6K2wn/s
         qrt6MvkeKu8OER8DLzy7jrJmy4Y8l0yW2bB1zv7K6FxUhWlIBY97tLNeXClsEvAqXwqZ
         ZnzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxASdKIn9NTuKnITZ78CjA68fnegAnq1AqiBLkZUSUZzGIHRN9b3YC313mFpmalscT/hVY6XNDa5dfpVFY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mO5gPWYx4V61yhu9Dk+eCk0OXgdQlNwF4i2rR1r38CqUA6VB4D
	xJ+etkTn1tsBXwkWXQsZQLCq2cShn0YgJ4XZt9Vfw42FGkEHVTWiCin9yCntr/CssuKRaWk+kRc
	PlB7/10Y1MZTmJKt3BE5UjcO+yeZCavg=
X-Gm-Gg: AYBFou25wJE0ZyMi5kCwHUb1o0eMV0ncwcWSAuZeIjCJ8VfZ1wAnER9j9cYmg2vLGVf
	CxKXpLRaUuuezataQCUqJyiWC3pfTmiSlu3EAfywMzhoDUPeqIrvNfdOQ+w2TTmxpEg98/xYJ7+
	MHDSXen9wB1Bja+zpROJjsl1oLT9atPfa3IJFbsbnud9Glaq0KXVt6vE6Qcn3woJwb9FWC10bvu
	KymI/7bvx4P/wd176F7w84Km+7YNTfLgdiee7xh/rlaFty+jD3OuCahm7f4nEJd6tKe4ZHTPAnL
	/mHQMszdlWziCtNw+rVEG+nQf7CFz77WHG6SlQaqxxWdpxIonNCZvGdg
X-Received: by 2002:a05:600c:3493:b0:49f:bd3c:bc21 with SMTP id
 5b1f17b1804b1-49fc573b55emr19996295e9.28.1789719638568; Fri, 18 Sep 2026
 01:20:38 -0700 (PDT)
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
References: <20260917052933.188679-1-jiangwenxiaomi@gmail.com>
 <20260917052933.188679-3-jiangwenxiaomi@gmail.com> <CAGsJ_4wDbDLv5mxfNiyraOS6tKCSV+g8xL5+SsRCyqLnN2ON7A@mail.gmail.com>
In-Reply-To: <CAGsJ_4wDbDLv5mxfNiyraOS6tKCSV+g8xL5+SsRCyqLnN2ON7A@mail.gmail.com>
From: Wen Jiang <jiangwenxiaomi@gmail.com>
Date: Fri, 18 Sep 2026 16:20:26 +0800
X-Gm-Features: AcwNN1UdGEZgXXaGyHc-WLWsn9JkWUJTL9ur_osaBhDBGn4esHyfsGM8b6arOrw
Message-ID: <CAHKocdFCuFR-gYCrY-c0iRKZ2GRZJCnTJjHGe_TvMoYkjnb7aw@mail.gmail.com>
Subject: Re: [PATCH v8 02/10] powerpc/8xx: add pte_set_huge()
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org, 
	urezki@gmail.com, will@kernel.org, Xueyuan.chen21@gmail.com, 
	ajd@linux.ibm.com, anshuman.khandual@arm.com, chleroy@kernel.org, 
	david@kernel.org, dev.jain@arm.com, jiangwen6@xiaomi.com, leo.yan@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, rppt@kernel.org, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Sept 2026 at 07:28, Barry Song <baohua@kernel.org> wrote:
>
> On Thu, Sep 17, 2026 at 1:30=E2=80=AFPM Wen Jiang <jiangwenxiaomi@gmail.c=
om> wrote:
> >
> > From: Wen Jiang <jiangwen6@xiaomi.com>
> >
> > vmap installs PTE-level block mappings (SZ_16K/SZ_512K on powerpc/8xx)
> > by reusing set_huge_pte_at(), a HugeTLB helper gated by
> > CONFIG_HUGETLB_PAGE. This makes the feature silently unavailable on
> > CONFIG_HUGETLB_PAGE=3Dn kernels and couples mm/vmalloc.c to HugeTLB
> > internals it does not otherwise need.
> >
> > Add pte_set_huge() to powerpc/8xx, next to the existing
> > pmd_clear_huge()/pud_clear_huge() in mm/nohash/8xx.c. It builds the hug=
e
> > PTE and writes it into the backing cells directly, without going throug=
h
> > set_huge_pte_at(), so it does not depend on CONFIG_HUGETLB_PAGE.
> >
> > No pte_clear_huge() is needed: 8xx does not implement
> > arch_vmap_pte_range_unmap_size(), so the vmap unmap path never takes th=
e
> > block-mapping branch.
>
> I assume you mean the block-unmapping (or PTE-clearing) branch.
> Please make this clear in the changelog.
>

Sure. Will fix it.

Thanks,
Wen

> >
> > In practice PPC_8xx selects HUGETLBFS unconditionally, so
> > CONFIG_HUGETLB_PAGE=3Dn does not occur there today; this is a decouplin=
g
> > cleanup rather than a new configuration.
> >
> > There is no caller yet: mm/vmalloc.c is converted later in this series,
> > once the generic fallbacks are in place.
> >
> > Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> > ---
>
> BTW, this patch applies cleanly to the mm-new branch.
>
> Best Regards
> Barry

