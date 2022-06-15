Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3242BC433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jun 2022 14:23:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LNSGD2f2Sz3c9P
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jun 2022 00:23:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=T/uAnd4N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=festevam@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=T/uAnd4N;
	dkim-atps=neutral
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LNSFW4CRKz2yn3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2022 00:22:54 +1000 (AEST)
Received: by mail-ej1-x62d.google.com with SMTP id y19so23567651ejq.6
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2022 07:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+cDSM19XhnVItQmXe2GXVbX8IiIZwrvghbIjLeWagA4=;
        b=T/uAnd4NRj5HaHVJL/NGW4xzIHjJ88SjHm1ylY4aca+8D6wfooiNh1pXFcmjxgVI5z
         oxoPES4Ga1RtHrg8cGHFuHkSH2f+OhwSwGTCIdhsCCYLUsxNmdilDkXJBny9cRAXwPZM
         bj8r9HZgGjAb5+5ooOWAC5V7AY+rgW6aZYN3JDn47Ts9R2AcZjZ3lDBwe9qmz0FuX73b
         Jfcp3Lz9OOReArTRl64Lor4pK9Gl2b8EG10faardk619owy9Pnf2EMV3tb3R3xjJeKiM
         R/q+Fh8c24KmtesrDZVl0JNopM0eMSrF15SULsMSyCvI4x6xfOthaOBHNdHq8n4QMJq9
         RjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+cDSM19XhnVItQmXe2GXVbX8IiIZwrvghbIjLeWagA4=;
        b=ukXM7kg8SOR4IvdaraTVkvEw2UdQS8vrDxRQujOpRdn3ZfvD3U0QJns5ZajFXiLlj0
         6V44ROePlj1XiJ0b+iPwKPgkk68qIXmI1YzNSmXc/Q9d4+w5mBb3fDNTpuyxOvKQDJgQ
         WcZdrMBKgoL6Z1ksh02yhLqc/ZrtWPkzcYLT9MBIsU4sOpzFZijlRG1tOKMmvFriMjhW
         O0Sf3ApYPRQUYZgi0kizq00g7Bh6OXy9ZeqpDkpoWzB7WDcHE2r2uAmWZAwZqI/kdLEf
         3e+YSzy4K7vWEgw/GOOE6QwN2vIqi/gUW4Aer1LSC+4qiLlgm+JfHPNF2dOajy1KlnYV
         TRyg==
X-Gm-Message-State: AJIora9lrueO2EMYb8hFjwXlnznp6oOPozvX893c2QUWfFf+k1X5kTrY
	sLsqBGJ8gr6/bZ4IwmemyYhfzNhi5D7hSaftjjw=
X-Google-Smtp-Source: AGRyM1tK+gakBdNkEl/BCl5Wp6p+/qyTwlR5zO3bm+xtxartwOdF0AEvujrW1NR3rivDizKoWarT6AlmcqwpahefijQ=
X-Received: by 2002:a17:907:2d8d:b0:711:d1bd:d738 with SMTP id
 gt13-20020a1709072d8d00b00711d1bdd738mr70128ejc.658.1655302966907; Wed, 15
 Jun 2022 07:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <1655179884-12278-1-git-send-email-shengjiu.wang@nxp.com> <1655179884-12278-6-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1655179884-12278-6-git-send-email-shengjiu.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 15 Jun 2022 11:22:38 -0300
Message-ID: <CAOMZO5BRVBawK2PRvTazkQf-wExOuni9qD76Ha3FYmZZQyPRsg@mail.gmail.com>
Subject: Re: [PATCH 5/7] ASoC: fsl_sai: Move res variable to be global
To: Shengjiu Wang <shengjiu.wang@nxp.com>
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Shengjiu Wang <shengjiu.wang@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Shengjiu,

On Tue, Jun 14, 2022 at 1:25 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> The resource info need to be accessed by hw_params()
> function for multi fifo case, the start address may
> be not the FIFO0. So move it to be global first.

Actually, it is not global. It is being added as a member of struct fsl_sai.

Please rephrase the Subject to:

ASoC: fsl_sai: Make res a member of struct fsl_sai

and then in the commit log:

"So move it to be a member of struct fsl_sai."
