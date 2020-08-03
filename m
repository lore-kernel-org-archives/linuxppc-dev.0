Return-Path: <SRS0=LND+=BN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906B6C433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 08:06:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E2C220678
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 08:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxdsHDR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2C220678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BKr7h1VXZzDq7k
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 18:06:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::741;
 helo=mail-qk1-x741.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=SxdsHDR/; dkim-atps=neutral
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BKr5L2tYczDqSn
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2020 18:04:37 +1000 (AEST)
Received: by mail-qk1-x741.google.com with SMTP id b79so34348027qkg.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2020 01:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SbxuUNCCa6ME9VA4qtvs1h8FPSgrKaIDkh4zhn6OcKk=;
 b=SxdsHDR/CMqtwMOGCpm+P3ZmX6jQtEE+sdvUP0ggRkCVAptrad6mAJnDn3R9LTlRLT
 RdkJUW0hPtegQ59VFDJxSiqHIyon86tf1OoH6ZO38apbVYGl7Hzl5WE+87btTZ+OkzIJ
 Dy+DcRBoGFUeKXDLw42f2HuNjfHlTHYRzh0GG/g0wLYMZxcsXf5PSo1KI2Hh0b9Oq4gI
 WfE97iOgJjWT0bQ88xWSWT4K5jztgCrJIdFWbhqb77hdt6/GQzarAaNZCH5XcRrzklYF
 k9Mvpyn740h8Ud+tK1xo/yCUrJCKFSFXnTEqu7CL89APAIcYoLuDSFIda0KmwjYN4sWG
 JMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SbxuUNCCa6ME9VA4qtvs1h8FPSgrKaIDkh4zhn6OcKk=;
 b=ZvdEhFjJIlkIxVR9GhtKiGSouWeV9wN35wJmSIL2QLaArXWsMDEIudGmi8K8QGbFxY
 /sPtpX+XK5meTVyONCPwZy+rnUQP+3C+BRFCpYtr+plPPWcLZ5gzwOO50yjGgWxZMv3O
 NrD6y4NuoDIuvRnXhpFpoX04XTgocnlZO7ehDCnwSgmkwk0iFA9OneSxwQHJZ0NDJgzn
 e9vSbGDaOUd1j06z+yALoluI3yhbBMSOW6GNE0N1sQX2EFCAtgfqO6+zlW6L34HU0/l6
 S3onRGKuRMe4YnKuCImuOyaFVZ9e3tS8WZrSQcfBDKy29glYM1KFKjv008qOO1f6NQYZ
 lsaw==
X-Gm-Message-State: AOAM530aMEQTfjiNYsNP4L7GdL8AjEN148bbDPNq6Cwa7GwZHZbxKQe6
 2ump0RKPdxKypwpnZrTBgC+LQlX1Uzbu0KmcFVc=
X-Google-Smtp-Source: ABdhPJzByIPDL7NYWq8UK3KcJM4lmBsSInj2L7u+lqt9skSqwBP62kAhaIYGIfs2yPZrY2LMIq7cqfATqyDENfdDx18=
X-Received: by 2002:a05:620a:b8d:: with SMTP id
 k13mr15300055qkh.450.1596441874047; 
 Mon, 03 Aug 2020 01:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <1596424674-32127-1-git-send-email-shengjiu.wang@nxp.com>
 <20200803054037.GA1056@Asurada-Nvidia>
In-Reply-To: <20200803054037.GA1056@Asurada-Nvidia>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 3 Aug 2020 16:04:23 +0800
Message-ID: <CAA+D8AOGF44UUq=P1S-M5TUwDUaOnqVmHJKPDBM9DAzt1nVzmQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Clean code for synchronize mode
To: Nicolin Chen <nicoleotsuka@gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 3, 2020 at 1:42 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Mon, Aug 03, 2020 at 11:17:54AM +0800, Shengjiu Wang wrote:
> > TX synchronous with RX: The RMR is no need to be changed when
> > Tx is enabled, the other configuration in hw_params() is enough for
>
> Probably you should explain why RMR can be removed, like what
> it really does so as to make it clear that there's no such a
> relationship between RMR and clock generating.
>
> Anyway, this is against the warning comments in the driver:
>         /*
>          * For SAI master mode, when Tx(Rx) sync with Rx(Tx) clock, Rx(Tx) will
>          * generate bclk and frame clock for Tx(Rx), we should set RCR4(TCR4),
>          * RCR5(TCR5) and RMR(TMR) for playback(capture), or there will be sync
>          * error.
>          */
>
> So would need to update it.
>
> > clock generation. The TCSR.TE is no need to enabled when only RX
> > is enabled.
>
> You are correct if there's only RX running without TX joining.
> However, that's something we can't guarantee. Then we'd enable
> TE after RE is enabled, which is against what RM recommends:
>
> # From 54.3.3.1 Synchronous mode in IMX6SXRM
> # If the receiver bit clock and frame sync are to be used by
> # both the transmitter and receiver, it is recommended that
> # the receiver is the last enabled and the first disabled.
>
> I remember I did this "ugly" design by strictly following what
> RM says. If hardware team has updated the RM or removed this
> limitation, please quote in the commit logs.

There is no change in RM and same recommandation.

My change does not violate the RM. The direction which generates
the clock is still last enabled.

>
> > +             if (!sai->synchronous[TX] && sai->synchronous[RX] && !tx) {
> > +                     regmap_update_bits(sai->regmap, FSL_SAI_xCSR((!tx), ofs),
> > +                                        FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
> > +             } else if (!sai->synchronous[RX] && sai->synchronous[TX] && tx) {
> > +                     regmap_update_bits(sai->regmap, FSL_SAI_xCSR((!tx), ofs),
> > +                                        FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
>
> Two identical regmap_update_bits calls -- both on !tx (RX?)
The content for regmap_update_bits is the same, but the precondition
is different.
The first one is for tx=false and enable TCSR.TE. (TX generate clock)
The second one is for tx=true and enable RSCR.RE (RX generate clock)

best regards
wang shengjiu
