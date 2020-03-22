Return-Path: <SRS0=TpGY=5H=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0432C54EEB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Mar 2020 10:49:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB40D20663
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Mar 2020 10:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vfJ1Ktbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB40D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48lZ4p53hyzDrTD
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Mar 2020 21:48:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::743;
 helo=mail-qk1-x743.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=vfJ1Ktbe; dkim-atps=neutral
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48lZ3210gHzDrNq
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2020 21:47:25 +1100 (AEDT)
Received: by mail-qk1-x743.google.com with SMTP id c145so12084688qke.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2020 03:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S6yehooPiFA7WFzSiN6iRq3URFGEeFNRubLJGaTKKeg=;
 b=vfJ1KtbeLDw5rFqeb6hIPBm5Sc1u7NaY5cV22O2B6Qr5sj+BUBGQBoxgBnDyG25Uun
 XarmSsEFe+LOGy/CsGvlXp+gB1ey4rj/w4Psk1IdT1KxfgfNvtobd8eTKawz4omDaCAp
 9Q1QqhexZiCi+puZyxpV4LbWTJuBfTBAcqE1JoZWo+/JFNDLXF0lZPnVSo+5jl0996fB
 IGiNJbsb2PBmJIQOaHcEPBaA6RMSFpgUk6E0F6mA/cK5z1KzcLPQfehaIJPM83S3xcQ/
 LjQj/DgPr2S3dv9JTzva8TGWqrNMpWa3T1ybGhe65sBtgGwJoKR509wm+j/05GFrFu65
 EB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S6yehooPiFA7WFzSiN6iRq3URFGEeFNRubLJGaTKKeg=;
 b=srBdnoXnnkUxIDiaVoYoSlwQK5IG3xMzzGNL3e353ZptMkZ0ezIxDi+iFAIa03G6HC
 8krSFjkLp1NcIbKnL9/11TWQgBu+oQqZwFuFFp6NkOl5oeo7tG1lFf3apdKNm2Iei4Ob
 SGlB3rNZsLw5jdkgmmMzXo5jisK+FzYA6DHTxu3JdmoRgFirS2iLWXmdYycaC/Bth5S4
 2gjOFA2tbsStcvI5EBcnyGESYXpaTaE2so9pBCmWPq7kkVbzt7c+xU2vjAVAGOB1NrYp
 3MoOgSG7Dx99xpa+I5+v/yiJ6J3o0cP5r1ECz/z7MTcRkYVPJjU6w6at6FkFAZlbHah4
 H52A==
X-Gm-Message-State: ANhLgQ15/yywoGsa8yMz/QfVZgZL0627hdFmiDnVh40JSwyhtcM4vUSh
 lzx4g6MQJsUWDaFcWSfDS4ekcssLRzC1UJ/v1jI=
X-Google-Smtp-Source: ADFU+vtFlqm8k9nbdJLDkTWAYuVNBzwsd2eGqUIfasY6+bquWnBaxo5guuFzQCC/yubJX5XQ8gab/74PHmKPUs49zC4=
X-Received: by 2002:a37:9683:: with SMTP id
 y125mr16639605qkd.450.1584874041867; 
 Sun, 22 Mar 2020 03:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583725533.git.shengjiu.wang@nxp.com>
 <24f69c50925b93afd7a706bd888ee25d27247c78.1583725533.git.shengjiu.wang@nxp.com>
 <20200309211943.GB11333@Asurada-Nvidia.nvidia.com>
 <20200320173213.GA9093@bogus>
In-Reply-To: <20200320173213.GA9093@bogus>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Sun, 22 Mar 2020 18:47:09 +0800
Message-ID: <CAA+D8APtW+ZRvJufzhNSw8acTdhGRQNphZcyVYnV-ZLUbtTGew@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] ASoC: dt-bindings: fsl_asrc: Add new property fsl,
 asrc-format
To: Rob Herring <robh@kernel.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Mar 21, 2020 at 1:34 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Mar 09, 2020 at 02:19:44PM -0700, Nicolin Chen wrote:
> > On Mon, Mar 09, 2020 at 11:58:28AM +0800, Shengjiu Wang wrote:
> > > In order to support new EASRC and simplify the code structure,
> > > We decide to share the common structure between them. This bring
> > > a problem that EASRC accept format directly from devicetree, but
> > > ASRC accept width from devicetree.
> > >
> > > In order to align with new ESARC, we add new property fsl,asrc-format.
> > > The fsl,asrc-format can replace the fsl,asrc-width, then driver
> > > can accept format from devicetree, don't need to convert it to
> > > format through width.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > > index cb9a25165503..780455cf7f71 100644
> > > --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > > +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > > @@ -51,6 +51,11 @@ Optional properties:
> > >                       will be in use as default. Otherwise, the big endian
> > >                       mode will be in use for all the device registers.
> > >
> > > +   - fsl,asrc-format       : Defines a mutual sample format used by DPCM Back
> > > +                     Ends, which can replace the fsl,asrc-width.
> > > +                     The value is SNDRV_PCM_FORMAT_S16_LE, or
> > > +                     SNDRV_PCM_FORMAT_S24_LE
> >
> > I am still holding the concern at the DT binding of this format,
> > as it uses values from ASoC header file instead of a dt-binding
> > header file -- not sure if we can do this. Let's wait for Rob's
> > comments.
>
> I assume those are an ABI as well, so it's okay to copy them unless we
> already have some format definitions for DT. But it does need to be copy
> in a header under include/dt-bindings/.

Thanks for reviewing. seems it is not a good time to add a new header
file in include/dt-bindings/ in this patch serial. I will drop this change
this time, that still using the "fsl,asrc-width".

best regards
wang shengjiu
