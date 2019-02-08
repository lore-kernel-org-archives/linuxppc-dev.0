Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05456C169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 13:14:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71CCB2083B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 13:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1rtBAC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CCB2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wwcY4C3nzDqXd
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 00:14:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::143; helo=mail-it1-x143.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="H1rtBAC6"; 
 dkim-atps=neutral
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ww7d3xfmzDqVF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 23:52:29 +1100 (AEDT)
Received: by mail-it1-x143.google.com with SMTP id r6so8615464itk.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Feb 2019 04:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LDK44LZ1k99mOaAc9CKhDYps2G+WpnDTmjYqSSZJIIQ=;
 b=H1rtBAC6CN5mKbwt2OWvkE+8Vf96wiBU4shWlmiwzneKfOYhMGO84CvlxQQQgTVU9u
 shZXWlNIdQu4ixFLfOYGNjGnHpAebqxOXZGQIB9fXF54Vxn6z5EamGcvIH7vzKdJHeMj
 ZiHilmh2A2hvQ06pd02I2zgwngKmx0ME072rOHOdQ8K8AnUCvhYLp521u83U68Qt+pO7
 Ivx6n7SZFPlZSFZE/hxZaLsGBFKuz+TgrpZs1pueYSpdpTGZwX2yYTwHQlehHh8eekCJ
 6YZGByTvc8suZMeBMISd8oKe4OpIrUt7w3g+o61bZ9DgP64/bfYaFrfj/bq2hFPKBKGL
 H1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LDK44LZ1k99mOaAc9CKhDYps2G+WpnDTmjYqSSZJIIQ=;
 b=P2Lu+vc+ieIaos3fNXt3rjdfu0sPOMj8jZVP1b4xbl2FfCc0uznz/OVuEdy6l0Ara4
 vnXpAX8RXWXg/jDCqs7YecvMJx1W7Hy2JW6i3BYreYm5RaV0+QDkK+HzZsdmrBylL6EV
 VVojlYZKbJCRVFcmUvq59O6Q0bD3F56UssA4AYRerwxYsZyA7mABBAI8hRPTTiV4ziaI
 A97yAalUv+79d37x4vMKdS+/efvt4I3qYHt2dwqzLOY98wvFTyV/835nv4OkdYzybdMU
 7iJao6mt7E7o9XBUlxbf+tpdAD4ysYeE5IB3Zg9PUN3aZaxQbSIkt/ePnWiiNM0erKGt
 DxhA==
X-Gm-Message-State: AHQUAub/xRpCa4nTdH4A+Jsqiixg2ivkWArgv8iTYqe6VjUFKXUXQdlG
 Owzc6T4AofAhdpU3Lz0AYcE4W8iCrnmLBDtLFAU=
X-Google-Smtp-Source: AHgI3IaWs10jnsDCwU60HQ1FPAEXmUpDJcXEMRc3QgI5OdMqIsYjlV6uPxTZjWa3BgOwxhxY9Os1u900eu8774lGyoo=
X-Received: by 2002:a6b:ec05:: with SMTP id c5mr571825ioh.279.1549630347398;
 Fri, 08 Feb 2019 04:52:27 -0800 (PST)
MIME-Version: 1.0
References: <20190208030802.10805-1-oohall@gmail.com>
 <20190208030802.10805-6-oohall@gmail.com>
 <87zhr6iotc.fsf@concordia.ellerman.id.au>
In-Reply-To: <87zhr6iotc.fsf@concordia.ellerman.id.au>
From: Oliver <oohall@gmail.com>
Date: Fri, 8 Feb 2019 23:52:15 +1100
Message-ID: <CAOSf1CHUqp72Ry11KLdoh=ukth+_A6WE=GmwfcA2wmWygovjpQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] powerpc/eeh: Allow disabling recovery
To: Michael Ellerman <mpe@ellerman.id.au>
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

On Fri, Feb 8, 2019 at 8:58 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Oliver O'Halloran <oohall@gmail.com> writes:
>
> > diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> > index d1f0bdf41fac..92809b137e39 100644
> > --- a/arch/powerpc/kernel/eeh.c
> > +++ b/arch/powerpc/kernel/eeh.c
> > @@ -1810,7 +1817,11 @@ static int __init eeh_init_proc(void)
> >                                          &eeh_enable_dbgfs_ops);
> >               debugfs_create_u32("eeh_max_freezes", 0600,
> >                               powerpc_debugfs_root, &eeh_max_freezes);
> > +             debugfs_create_bool("eeh_disable_recovery", 0600,
> > +                             powerpc_debugfs_root,
> > +                             &eeh_debugfs_no_recover);
> >               eeh_cache_debugfs_init();
> > +#endif
>
> There's that endif.

Bleh

>
> Whem I'm doing rebasing and think I might have broken bisectability I
> build every commit with:
>
>   https://github.com/mpe/misc-scripts/blob/master/git/for-each-commit

Thanks, I have something similar for skiboot but never got around to
porting it to the kernel.
