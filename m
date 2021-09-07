Return-Path: <SRS0=mwa9=N5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAC4C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Sep 2021 02:44:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7807A60E76
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Sep 2021 02:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7807A60E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H3V376Sqvz2yJy
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Sep 2021 12:44:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Pmo+uYbb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f32;
 helo=mail-qv1-xf32.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=Pmo+uYbb; dkim-atps=neutral
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H3V2P02cMz2xYv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Sep 2021 12:43:40 +1000 (AEST)
Received: by mail-qv1-xf32.google.com with SMTP id e18so4986513qvo.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Sep 2021 19:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q8EAvjumu/OJAeJcXbA7H2hzcYUuPTK9t0l5alooUiY=;
 b=Pmo+uYbbkBqdBVNpqse5shcoez2d/H1Qcdv6h/Vy8RLiSqPrt8ejRjpujP6T4rMWVF
 nEHi0dy/D8Lh6jma63/OfIqutDyThbpRrGfGBDeYn2EziRF76UZ0vJwEtdvXsFaIedOU
 5/7HSqX1DusB+O1PybFEHlRET0OpfZqdnUjZRSXKbOaHTl71kmakb0Db4Xk3Ag/uotCK
 EsieL1LsCU4XtvjH/axVR/XfGyr68lBQ+SyJR0Ibp3l+odmIUi4leYeW5V6R0+nTTRhm
 tuP220jYFGk/ksKx0KA8KsvNZbO3lLUNu5bLE4wcIQ2HNA3NlXQhG4f1SRYueNRTagEh
 IE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q8EAvjumu/OJAeJcXbA7H2hzcYUuPTK9t0l5alooUiY=;
 b=S7J8Ql6X5+ve/UBxuRzPzVOVPyW+esU1Sk/IHivCBW9Ph9a5Xu22FhMHhwdz/JA2gL
 UbCSWq6s5ax2wTDmI+uZoWNcihnWWvhyKSB1aHGu9EcvgnWIa1AlXKb7FTIXjsYnieWv
 ZB98a3dI7g5STvpim3AKZMnlyCNVvWK5+DXKhLU8GcqlM3GXuPoCEBgbSw40PA8kHzoh
 YB/jefPgOFYmtB09fg9sFkGg9kqQk7w34xCtj1gSl2jYD+5fquLzGbK10x6c6WfDvZAx
 HHgllRLtMDSfWRr32PNaLzf2Bgcpcsvd6y/02Bv4pO7eNKe74TGPzJ+1MjM48dTzAJFx
 FIiQ==
X-Gm-Message-State: AOAM5333QKkAXxt/4h7TRRgHAtbsLdHjcEIb7Whs4exdi9eZmCQ5SEqj
 1VcaRvsR4j/dv0fhhjG6+O71nH+it6rlpOM0f3g=
X-Google-Smtp-Source: ABdhPJyjPbrX3ue83Z7GFZ6Rrf6Te85hNnUz2Ud9JAzgWqPZ2jaz9QxhFZQk5FOxkPsinhqn+KuRgte7q2aYk1iO95g=
X-Received: by 2002:a05:6214:11e5:: with SMTP id
 e5mr1131874qvu.55.1630982616853; 
 Mon, 06 Sep 2021 19:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <1630665006-31437-1-git-send-email-shengjiu.wang@nxp.com>
 <20210906114701.GC4309@sirena.org.uk>
In-Reply-To: <20210906114701.GC4309@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 7 Sep 2021 10:43:26 +0800
Message-ID: <CAA+D8APjyq74FECmH6ZzyVKHOz6MEV0bt+D4-Xkfc-6C5n9hZg@mail.gmail.com>
Subject: Re: [PATCH for-5.15 0/5] ASoC: fsl: register platform component
 before registering cpu dai
To: Mark Brown <broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Mark

On Mon, Sep 6, 2021 at 7:48 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Sep 03, 2021 at 06:30:01PM +0800, Shengjiu Wang wrote:
>
> > There is no defer probe when adding platform component to
> > snd_soc_pcm_runtime(rtd), the code is in snd_soc_add_pcm_runtime()
>
> ...
>
> > So if the platform component is not ready at that time, then the
> > sound card still registered successfully, but platform component
> > is empty, the sound card can't be used.
>
> This sounds like a bug which should be fixed there?

It is hard.

In cpu dai driver we always register two components, one is for
cpu dai, another is for platform, so for sound card platform and
cpu share the same node.

        /* Find PLATFORM from registered PLATFORMs */
        for_each_link_platforms(dai_link, i, platform) {
                for_each_component(component) {
                        if (!snd_soc_is_matching_component(platform, component))
                                continue;

                        snd_soc_rtd_add_component(rtd, component);
                }
        }

Above code in snd_soc_add_pcm_runtime() checks components
for the platform,  because there are two components for the node,
the first one is the component of cpu dai, which is added by
registering dai, it is already added in the beginning,  so it is
duplicated,  but the second one (which is for platform) is not ready,
then issue happens.

It is hard to add conditions here for defer probe.  And maybe
some drivers need the same components for cpu and platform.
Do you have any suggestions?

(The easy way is to fix in each drivers:))

Best Regards
Wang Shengjiu
