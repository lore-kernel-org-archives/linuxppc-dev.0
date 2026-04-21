Return-Path: <linuxppc-dev+bounces-19871-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4D6F327B5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 07:40:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0DmD2Km6z2ySW;
	Tue, 21 Apr 2026 17:40:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1035" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776757228;
	cv=pass; b=F6TeUAh46SrPTUxqd816lXbdxTN3maz416eyuWP/FKr8EpMjxENK/W7afkTmtRARQGjk8d6m2BrVzu2KuXLOYLFwbag/wQsIYPlD41RWb0Gjl9Yjl6vzkXePo2PnqcD8sbozajbj772kM5skaHx9keq3T9T5JbJO3AHO5QXmcWNj8M4s2ioUfFRXoZeQ5R2HUm0sk6Mmveexrltidngar+OaSeUUkO6tYSY5hEcEqySEq6FRQDr6rdQX7KfbKu8FInqi3p8LJvBt53Gk76FhBzGb3Uq8/6zNP87oigQY2eQJpjftTckbV0yywzjqvJk6hRdPEJn4yZluRlUdKjcFDQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776757228; c=relaxed/relaxed;
	bh=Bh0VOjbMhtH+2V4ttttWsNwgrNIKj1T3RMmt6G5B52U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWjxAAFnsKqRGNw2HTwNH38VXWSjJjzSMVHTgXZGTPhqFrue3l39fZwDbUK/n5Vzx0lTGGDaa6w/ytIDkBXlMuaSX+k++rvQMlFNMxzFxBDc/WRxH/0R1UULR801rZAGs0Jb9uEn1T0OizsMyCvAe4Hpk2Eb32pkSTfiK+CR2y3xTs5yilVV2vO4IxxHZklIDoCFSzfynFDVEGq3rM+Ar18ZXZVmlNqhD/3ZwLHKDbaWI8/Ju09v1+XNnAOEjmiPYqApx5AYrponVV9gxangTa31bd/hjVDUsOGj650Li0l9qNxoYaghNFnnR9Fvxa/sJljrs4J+/qaspwFYraHfVA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HhqP6sBq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HhqP6sBq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0DmC0VMzz2yFl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 17:40:26 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-36146ae9dd4so2940051a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 00:40:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776757224; cv=none;
        d=google.com; s=arc-20240605;
        b=SnJg91r8j1YW+kdXfW7a6Shv0S/D1dmRSUaTJBOfyFObGmg/Txt55rbiFxLST5hzv0
         F0dtJiZrK02sDmFd4KJF1r1IjgaMJB5TYD4cOzLicjybazER9h9LgtQ8rP4BakVkNH+p
         BPBCOGxkRP4y0Pj9xoiH+Jz+AJzUsySZ+ENeB6gDxTijjeO+9Hm8sFQo4lKa7jpzxoex
         Pxo5cAoYDAfKdDcDdLYCrRK9j+PviKk481QNnNAiuVF9KXnnAqaBsa3IOPL/EuYw9h2C
         uSigQibK6sTDyAf4+ZDFWqYSjdhTIwqOszf7Czr0eYr9i6nMjD55txslNXJam6jgvm87
         uG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bh0VOjbMhtH+2V4ttttWsNwgrNIKj1T3RMmt6G5B52U=;
        fh=3MGGbV8ddC3XGfDmmFCRNXsYzZsetqo2C1+8T4Ncqds=;
        b=F01Siwbz3ezDccyL0EkjCiy8nu0C/swt13Mf/SsXJgxje2h0QBI7wMfESXOckxLRX1
         PrD+mAqve0vfIn5kg3jVphynIKHv3mgVzRDQv4Za7H70jvPL5zuFIHGfO07HmJjG3aSa
         4vy4hyJ4eAgjT8Q509I6jg9VsVmorulG7ZAVLlL2q6+AxnOoAxfH7r6NNbysjjoPK1fG
         TDq6cgYFEauxudCCUo1be7wiij3gLuplxX3qZYH/v0cRFYC4uUNnDtCjoIWvBXQU/GDj
         0Q+lmeDamTNFziRrIVEAABeTGmHBeli9IKf7STOZ/sQA6KHKG3/uEcGddWoC97/7DfjR
         i8bQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776757224; x=1777362024; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bh0VOjbMhtH+2V4ttttWsNwgrNIKj1T3RMmt6G5B52U=;
        b=HhqP6sBq6jwnIqeGX+gFsTcNPHjthNa+GaM3ZHa8MCVFarWdFa+BbJsHtnsbA+XAjR
         m+dI7kSNsEdYZsYEocP6PvaVKuZUkVTsnMpBJ8W+tHvvUMV84wGwJIq8HyBjlkNXDFFj
         F5w0s4597QashiFldGpxuUJjc/Oe8RvW1cDcYkvl9qt1uk/g2y5loSsZtyRPBX0CsB8r
         XivYUDwZJVFRZNEv2V1ntPilFq/iJYqXzdr/UOPsNTX6qyJmslssULirP7PzF0QG2Gmb
         GvHmPmpAZ1Zl0XyE2oNRC2OqLtiQuJXXkL2zgEm8VeQDwkgerdgA2tIo+AB4rizpvqyW
         MLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776757224; x=1777362024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bh0VOjbMhtH+2V4ttttWsNwgrNIKj1T3RMmt6G5B52U=;
        b=BP5JZnjeaD6DPuSIyWe6UY/kXlKTHSl6UN97bbhPUWoHuIYYtKPVFPbMt7B1ijs8rN
         roxYA9AHDOyIgZZHarDMoikdHLystugT7lXUCkhMxtC+10+WwL84Ap+0x4JbZ8Ogj3Dz
         kusGYyxpCJI7jftBx56lX8mhkeUaJ4jt4wGa2/Kh2Of/IWkuoLPRpG5RolSUotRR2mAF
         u/GO7fHBwebaNIrR8zAn3Sysl6Qsq5baUGE6xJxOCNqIMOt3C5I0/h+dBVGnnSm+EkEr
         WcJ8TdJ46Zf5qZHTY2hDbJdiY5IINkBAOTX/FnB+l2CkSYDFCYj3zwSS2XDU1WJ/ryKi
         Xl2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+axod/qmt7DK9jQB+6LsKju22wEPjEISJoPZfLFajrL7e8qyCIizIsTYUAe7gwHKtz8qcDKyPWOyiCsPA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyT1E8WNDLHrz/V9LUVJda8Dk7FsC7cZdaHGTwzkV4r/WksSfTr
	8Mv2XSz+Dn39Xi306QX/kTUIhgV8WUGf+EJcnVXLy483lmpSS5RgjoxZhx8kqT0/lCkDXcF7hQb
	Pjyw0DLg9z5BimrURk0KpdHpJmY/o4bs=
X-Gm-Gg: AeBDietbGNNiQjZP8Iaj2HsUoTCc25DTuUwE+1bkPlYpV/NaPVwX7MvTtmR/F6adTXo
	TZNTj9oNWQ4IYPCRZ00dqEtS4hqfvtX9cMEvRsFBNTlJvS4aKbjviDSi6eKiop8qPNT5K4ywHvc
	4avlxnmKO6KTb59mxUsOESDBJ24Yh6rrlEXQs6pbsrFHgEtEr5fWyNd2+O+8yVpgk/DukrRD+/I
	IUbuLHImATOWvUjIW332XzD0cPxQula4UohVm6L+EqPjeH1OauqrNWzVBnCHPw9D5Qfj3eVGvdl
	mPJYXPzIcSBbvyDsBA==
X-Received: by 2002:a17:90b:5288:b0:359:fe72:3559 with SMTP id
 98e67ed59e1d1-3614048b1aemr21085898a91.21.1776757224448; Tue, 21 Apr 2026
 00:40:24 -0700 (PDT)
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
References: <20260420085344.2081805-1-shengjiu.wang@nxp.com> <6c6f94b1-a4fa-418a-b471-8e3c82305233@sirena.org.uk>
In-Reply-To: <6c6f94b1-a4fa-418a-b471-8e3c82305233@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 21 Apr 2026 15:40:12 +0800
X-Gm-Features: AQROBzD1FwWrSiTcb4_TXXYBoiE2Up6O4dADIks7SRo1J0rNtrKh2cWtOkBvP_Y
Message-ID: <CAA+D8AN3kmU-FDHF-kb47=ayXbypka+Q0vO-i2Bpzq1GSABuQQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_micfil: Add DC output remover control
To: Mark Brown <broonie@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 8:50=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Mon, Apr 20, 2026 at 04:53:44PM +0800, Shengjiu Wang wrote:
>
> > +static int micfil_put_dc_out_remover_state(struct snd_kcontrol *kcontr=
ol,
> > +                                        struct snd_ctl_elem_value *uco=
ntrol)
> > +{
>
> > +     if (val < 0 || val > 3)
> > +             return -EINVAL;
> > +
> > +     ret =3D pm_runtime_resume_and_get(comp->dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     micfil->dc_out_remover =3D val;
>
> ...
>
> > +     /* Update DC Remover mode for all channels */
> > +     ret =3D snd_soc_component_update_bits(comp, REG_MICFIL_DC_OUT_CTR=
L,
> > +                                         MICFIL_DC_CTRL_CONFIG, reg_va=
l);
> > +
> > +     pm_runtime_put_autosuspend(comp->dev);
> > +
> > +     return ret;
>
> This will return 0 not 1 when the value changes, meaning event
> generation is missed.  The mixer-test selftest should report this.

snd_soc_component_update_bits() will return 1 if the value is changed.
and the mixer-test pass

ok 120 get_value.micfilaudio.8
# micfilaudio.8 MICFIL DC Out Remover Control
ok 121 name.micfilaudio.8
ok 122 write_default.micfilaudio.8
ok 123 write_valid.micfilaudio.8
ok 124 write_invalid.micfilaudio.8
ok 125 event_missing.micfilaudio.8
ok 126 event_spurious.micfilaudio.8

Is there something I missed here?

Best regards
Shengjiu Wang

