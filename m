Return-Path: <SRS0=TkHQ=65=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E49C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2020 10:03:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFAE42065C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2020 10:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8YCpftd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFAE42065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49NkWr2cL1zDqty
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2020 20:03:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::844;
 helo=mail-qt1-x844.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=r8YCpftd; dkim-atps=neutral
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49NkV008ShzDqjh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2020 20:02:15 +1000 (AEST)
Received: by mail-qt1-x844.google.com with SMTP id o19so1398037qtr.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2020 03:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IcUXaEpbXUpVL01oFB6hRlgR7PeeYt7QBRNoruvyCbY=;
 b=r8YCpftd/P5xTvlYz3ynLdKuAbb+OBjgoQ+380Hvgp8upI9U0p29w3r2M23HNeCgny
 McaR//XORw7nRXahwn89WFF8xUs69HoY61LqdifB+ntJhZBcgCEhRowcUg3hY3cYjKZ0
 6F59Y/UK6GcZ4mbkdZLbEumgJq5MUdfRZhRLqfiwOq51Dbl3T7F8lYTDBhMspj1vAuvq
 nJydlHTEGiCKCqeftb0h7NchqDXRkBxaHSPSCfSS0nO5gwg6en13tc786ZnofttzAwsx
 pTizqaZb2nXkk1NFaVceiuZLCPW0zb3K6jE3itFdgovcgWjul7Fb0avWf1RtyBzW0gE8
 lonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IcUXaEpbXUpVL01oFB6hRlgR7PeeYt7QBRNoruvyCbY=;
 b=LmHhNrlkvOs7dvh8Lqzx/D1SxrpSkzMAHFxmk0gDHjHvfNPcmJcvRQrEdz/DHr6KJ0
 GaARkmff5emrk1ak3xToAt7UwJl03dPWwi2YEF/2tmoLG29XZ2JwWzQsB/hWc/kSg2cq
 /Au6lWfntR0AKM5OIg2ndbNnMJmfuvwjwEpvZDHjQqysKjppvQecSYr8rGdHvB9tb9E8
 rSTPZCZBhaQiwazLAHDzKR0iagMnrCnajMoBHkYsJYSNTCs9cQa5N76l4PCqMa/GzMYo
 uZmN1nM9bM1RAT4MUtzxqWr1PiFnC1gj3UDnZJXEkutTW4LUBNtc5TR2pargeYKLX3n9
 8kLA==
X-Gm-Message-State: AOAM532ApeUnNOY9VkvUXx1eVvyVhYLp1tr6M6AJHBk772spNZJ0C15s
 ldIsoxZUn/H8EQh3kP/aVzJEY0C8D4xpbiXXF+8=
X-Google-Smtp-Source: ABdhPJyznFMUdqKh5MEAtGN+Z5aVH5R/r5Mj4195QZGvA37EfsjjNUwLr+rQki1u4TDjULiTD0B2I6/8TxiO06OU3cA=
X-Received: by 2002:ac8:302f:: with SMTP id f44mr2485555qte.121.1589536931527; 
 Fri, 15 May 2020 03:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588320655.git.shengjiu.wang@nxp.com>
 <a933bafd2d6a60a69f840d9d4b613337efcf2816.1588320656.git.shengjiu.wang@nxp.com>
 <20200501102158.GA5276@sirena.org.uk>
 <CAA+D8ANDHHejFD1rYmFOG24yivpEJa+xO-WpVr=Vzfz9yW9H7g@mail.gmail.com>
 <CAA+D8ANK+Sd=nPeDZpd_=fQRFOdLtKgvsCmfQ_fRU3RCjMY+rQ@mail.gmail.com>
 <20200512123801.GG5110@sirena.org.uk>
In-Reply-To: <20200512123801.GG5110@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 15 May 2020 18:01:57 +0800
Message-ID: <CAA+D8ANTv3R-vDki3No0rG++u4OKrNFGh_Eq3DNLSAQ4f=mLwQ@mail.gmail.com>
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

On Tue, May 12, 2020 at 8:38 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, May 12, 2020 at 10:48:41AM +0800, Shengjiu Wang wrote:
> > On Wed, May 6, 2020 at 10:33 AM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:
> > > On Fri, May 1, 2020 at 6:23 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > > > EDMA requires the period size to be multiple of maxburst. Otherwise
> > > > > the remaining bytes are not transferred and thus noise is produced.
>
> > > > If this constraint comes from the DMA controller then normally you'd
> > > > expect the DMA controller integration to be enforcing this - is there no
> > > > information in the DMA API that lets us know that this constraint is
> > > > there?
>
> > > No, I can't find one API for this.
> > > Do you have a recommendation?
>
> > could you please recommend which DMA API can I use?
>
> Not off-hand, you'd probably need to extend the API to export the
> information.

Thanks.  I will think about if I can find a better solution.
And I will drop this change and send v2 of this patch-set.
