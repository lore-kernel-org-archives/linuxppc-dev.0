Return-Path: <SRS0=ZLNG=CD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1212CC433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2020 13:29:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23BCF20639
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2020 13:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zvala3I9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23BCF20639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BbVG24MmzzDqW8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2020 23:29:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::343;
 helo=mail-ot1-x343.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Zvala3I9; dkim-atps=neutral
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BbV1d4S27zDqSg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2020 23:18:44 +1000 (AEST)
Received: by mail-ot1-x343.google.com with SMTP id h16so10308400oti.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2020 06:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G0nr2Rnp+JRA+sjbGO6qBW7oW4QCJUBcgVXTMTOZTT0=;
 b=Zvala3I9GALjR8IXJLy6GMX803AkKrYajm9x1/Hk0Uh7qXBpgHqNX01WqAd4KoLwOg
 QQNVgrmf3jZnG4Bb5rohR8EPBtExqsAfN/wu8cYCapesWZDpwrW7oCPxTG1Wtv3SkQuw
 LcuJdUZUtCZN7ox6D3dq5UoWSB7mYvSDM45bvijt0sOCNdSIy+Lvn78n2M3pkF0ocwhI
 4MsDf7ZTmCAQjzkG+k3h7sEtTbLuuLm9u5zZdpm0jv1gQMCSK4LKgEy/6ki+nChBvqYj
 PzRXPXVhr0CcekwnD+9bkDHiOP9Fog3jmubLEnk8+jonTpMhqvPX5s56w2x5ToVR3J6s
 eRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G0nr2Rnp+JRA+sjbGO6qBW7oW4QCJUBcgVXTMTOZTT0=;
 b=HXGOi/Y8S9vgzokd+mvRnNfTMSuE9MxrCEl38s02AupqtbdmYkdT63zsEXSNRZ8bde
 HAOGXmXJtbVqqeIpY3KeO95PCoyoJgHYitGVdy1oynL93kAyXf9vqgGW/UZ3hwKR+PYn
 APCzNkVGiVur4p9T10hZJ4V0Ao8UE0iLn7ntRuwgXL3e1VsLIvPdgAuNfJ1c+H4myBpB
 6A4fEvpB/VB1tSIagPvFfNIaZVqGeUbY/mnKPGGe/kjYnT2t7x4ZJyyZmC7tD8H91Auh
 UWfNjinCjgDw2lsSZq6bmDLm73LY84uNfgBHT2ztX/3z9E2EQWoVGPUwgIk2jy0TwDYf
 YKBA==
X-Gm-Message-State: AOAM530LfyeGhCQst84GNl+O/ZIEQCuE0GoDJTw1YReZuQRROlsSfTJp
 0m45l+jx50Qd1HZyVq37DDlP6b2nvmoQz6XjHi/zHuDNoMA=
X-Google-Smtp-Source: ABdhPJzaH0mEUIkdGw9gBxdO4W3phLP52jbBCR4uJ0dLhCwArlEzNs3bN/kNnUENS307WXv/io+zkZ5jYSjfvYKNLuc=
X-Received: by 2002:a05:6830:1283:: with SMTP id
 z3mr6558318otp.51.1598361518607; 
 Tue, 25 Aug 2020 06:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200825114507.13297-1-jniethe5@gmail.com>
 <20200825124120.GA815@lt-gp.iram.es>
In-Reply-To: <20200825124120.GA815@lt-gp.iram.es>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Tue, 25 Aug 2020 23:18:27 +1000
Message-ID: <CACzsE9pUunmsZJjfkjn=E=1BFiq0OH1h1VDQgxpbBmDFRfKkLA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Update documentation of ISA versions for Power10
To: Gabriel Paubert <paubert@iram.es>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Aug 25, 2020 at 10:41 PM Gabriel Paubert <paubert@iram.es> wrote:
>
> On Tue, Aug 25, 2020 at 09:45:07PM +1000, Jordan Niethe wrote:
> > Update the CPU to ISA Version Mapping document to include Power10 and
> > ISA v3.1.
> >
> > Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
> > ---
> >  Documentation/powerpc/isa-versions.rst | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/powerpc/isa-versions.rst b/Documentation/powerpc/isa-versions.rst
> > index a363d8c1603c..72aff1eaaea1 100644
> > --- a/Documentation/powerpc/isa-versions.rst
> > +++ b/Documentation/powerpc/isa-versions.rst
> > @@ -7,6 +7,7 @@ Mapping of some CPU versions to relevant ISA versions.
> >  ========= ====================================================================
> >  CPU       Architecture version
> >  ========= ====================================================================
> > +Power10   Power ISA v3.1
> >  Power9    Power ISA v3.0B
> >  Power8    Power ISA v2.07
> >  Power7    Power ISA v2.06
> > @@ -32,6 +33,7 @@ Key Features
> >  ========== ==================
> >  CPU        VMX (aka. Altivec)
> >  ========== ==================
> > +Power10    Yes
> >  Power9     Yes
> >  Power8     Yes
> >  Power7     Yes
> > @@ -47,6 +49,7 @@ PPC970     Yes
> >  ========== ====
> >  CPU        VSX
> >  ========== ====
> > +Power10    Yes
> >  Power9     Yes
> >  Power8     Yes
> >  Power7     Yes
> > @@ -62,6 +65,7 @@ PPC970     No
> >  ========== ====================================
> >  CPU        Transactional Memory
> >  ========== ====================================
> > +Power10    Yes
> >  Power9     Yes (* see transactional_memory.txt)
> >  Power8     Yes
> >  Power7     No
>
> Huh?
>
> Transactional memory has been removed from the architecture for Power10.
Yeah you're right, I confused myself looking at CPU_FTRS_POWER10...
#define CPU_FTRS_POWER10 (CPU_FTR_LWSYNC | \
        CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_206 |\
        CPU_FTR_MMCRA | CPU_FTR_SMT | \
        CPU_FTR_COHERENT_ICACHE | \
        CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
        CPU_FTR_DSCR | \
        CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
        CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
        CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_ARCH_207S | \
        CPU_FTR_TM_COMP | CPU_FTR_ARCH_300 | CPU_FTR_ARCH_31 | \
        CPU_FTR_DAWR | CPU_FTR_DAWR1)

CPU_FTR_TM_COMP should not be in there.

>
>         Gabriel
>
>
