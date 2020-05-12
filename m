Return-Path: <SRS0=zMZh=62=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603EFC47255
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2020 02:50:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C43272070B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2020 02:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uXTFgedf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43272070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Lj3M56BJzDqnp
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2020 12:50:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::841;
 helo=mail-qt1-x841.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=uXTFgedf; dkim-atps=neutral
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Lj1R0t6PzDqjT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2020 12:48:58 +1000 (AEST)
Received: by mail-qt1-x841.google.com with SMTP id 4so9919823qtb.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2020 19:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+p2xh30TEJfAR+w5B4LaXMd3KNNJXJtMQbogkWpFPF8=;
 b=uXTFgedfKAJw/mdH+r2ogZwZQTp/ZTIBRyakuBwLSXaz9PWFl3s45PRztLUO7H5FBP
 TFYtbn1ZzJ8znyq1exL44gJ+IKnPayj/ne3+XdrgqoDlhm+JXc+fHRnDRZSCC1iZcULu
 yhJjq9wd8k0JUQ5xuOSqJk7LCa34c2BTbb+fpES1GQHxSzMKez4IXl6KXXc2J0kHCym9
 ikeiYA+UxdiiLcFWazU/ZZWHH2jqHQh+MyNod6nD4dNcLGcAZqgtnSBzUJkrg0cVhUou
 AEcbyFUk/TIHzd/EwmZjEKhx+oQIh3IVZ/2yfe+rvjvi/yqZqN2j8s7+DeSsAmIJ2JGc
 PA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+p2xh30TEJfAR+w5B4LaXMd3KNNJXJtMQbogkWpFPF8=;
 b=qrvk+VZPAkE2eKSum9pFCEQjuRqkcXdLyuOavQpe04G+riH+0f8oa3/lKuS+Jcs+Rs
 KZyr/yDuasHwvfAbeU4sPLpLuejXzbnUHLSw0hBQz2VGvfxiHhl+0yJjeMEJxFY506g3
 AJmf2vVkKd0y8DyhF49xzVwZHGQHEmu1eJyuaODNFzkrGfUP/+CPqwm5XA8OdVchoylH
 AXeWbjh4I5ehJFHJT6wvOpmUBww8YfhV1bXVDQ70iMZbZIWoQhnZ09hvdTHqu1ovqmN/
 /zcq+uhl/25cZNRIIjIbQukABqnEfQXV3/5gFv7auUWrXxqwoYVo9+ghhjDHTAkRPl8s
 6H/g==
X-Gm-Message-State: AGi0PuYe5a/3TxVOxi+8fDHZvnqTTp75iADtiViwKguLualmnjjg5b4G
 iPFUu0SkyXWEVTCQ4nIw0PhbkZlWKsBjE3Ej7+c=
X-Google-Smtp-Source: APiQypId7oxhT26ItzjC8bMXwsSFBjnYZNmv7Cgv/UndRHY6NfhZPgW4iFgXhDPKhepQCP0rcyNz85IZmAz5rBwh+Hs=
X-Received: by 2002:ac8:4e2c:: with SMTP id d12mr19665595qtw.204.1589251733739; 
 Mon, 11 May 2020 19:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588320655.git.shengjiu.wang@nxp.com>
 <a933bafd2d6a60a69f840d9d4b613337efcf2816.1588320656.git.shengjiu.wang@nxp.com>
 <20200501102158.GA5276@sirena.org.uk>
 <CAA+D8ANDHHejFD1rYmFOG24yivpEJa+xO-WpVr=Vzfz9yW9H7g@mail.gmail.com>
In-Reply-To: <CAA+D8ANDHHejFD1rYmFOG24yivpEJa+xO-WpVr=Vzfz9yW9H7g@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 12 May 2020 10:48:41 +0800
Message-ID: <CAA+D8ANK+Sd=nPeDZpd_=fQRFOdLtKgvsCmfQ_fRU3RCjMY+rQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ASoC: fsl_esai: Add support for imx8qm
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Mark, Nicolin

On Wed, May 6, 2020 at 10:33 AM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:
>
> Hi
>
> On Fri, May 1, 2020 at 6:23 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Fri, May 01, 2020 at 04:12:05PM +0800, Shengjiu Wang wrote:
> > > The difference for esai on imx8qm is that DMA device is EDMA.
> > >
> > > EDMA requires the period size to be multiple of maxburst. Otherwise
> > > the remaining bytes are not transferred and thus noise is produced.
> >
> > If this constraint comes from the DMA controller then normally you'd
> > expect the DMA controller integration to be enforcing this - is there no
> > information in the DMA API that lets us know that this constraint is
> > there?
>
> No, I can't find one API for this.
> Do you have a recommendation?
>
could you please recommend which DMA API can I use?

best regards
wang shengjiu
