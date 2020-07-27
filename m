Return-Path: <SRS0=BXao=BG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11069C433EB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2020 08:01:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E2F20738
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2020 08:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cqmot9h6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E2F20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BFXLw3mtNzDr3T
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2020 18:01:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1041;
 helo=mail-pj1-x1041.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Cqmot9h6; dkim-atps=neutral
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BFWbz1QwnzDqq0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2020 17:27:42 +1000 (AEST)
Received: by mail-pj1-x1041.google.com with SMTP id mt12so1328310pjb.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2020 00:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=2+yXBFkFF1Q2hs9eJ61ZmtSb7ia2MRn3KxqycD73Flw=;
 b=Cqmot9h6sPwuj2faph4jOKs5weve7eUvzLaNx9IhHsELXyEoGYyUza9Ardp+smS119
 TGfMgjCb+Q7A7eMlTsKK1TArG0L4+p6Yh5Hitl9TxMzHIgngQbZVbvG96NyRIghMd4GZ
 PSQhOpZYac/IkW1TddyHCGy0l1+sGFE81BAyo2Hb5QjOOcz26H384tpdAi1lBSX3uiAT
 /Fot+ATlEjMnzh3JJdOAz9bKQICojC/8+16x4lno+1tGL0LHnT06tvaHkiv5jK2COAjS
 Y5WBOGm3KMcL9mujuHQ+2frzPL0jk3yHfeDvv9sz4bvVgOxWnCyTONCx+MkvocuDhwAh
 xXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2+yXBFkFF1Q2hs9eJ61ZmtSb7ia2MRn3KxqycD73Flw=;
 b=mo0y2jPzdaAkh+lsw+jy1kBjqAIBqAxOap0Vvwmz8oA22SYfwRJeBdvSzwBg9SlJ0w
 CiH3Gl5MshDtvIqBuLlTv4DgmEUHzQT0rve+fvk2pX5tRKzFXlI6KcF1f1Bjgz6COOhn
 XfR/SpH6W7gFYzqAwLl8d0zPkvCY0UjLpNFy6EVQ0SZTIX2/PfZeUL2DTwJZxjGWWyS5
 0hgyD7bdEn98hEMEaAE3Mie20g1x5P9GYCXQ16/eXJzqRDnp+3Wj7iK/N2go3LeFFvBa
 upHOdSq5Hxj8DNPEER/1J6kDMMDMNDoWm3paPMGqffAJyNjAv1vlcOBNGFGJgFzo7ccj
 hhCw==
X-Gm-Message-State: AOAM531McM9mx9xKzq3vImwPMBxy9ASJ3gmYnRLOipjDMeb9W/pv66tL
 o/LBWBS0062v0AbN3cM41MA=
X-Google-Smtp-Source: ABdhPJzONbuJenpMzjphtdEOeUlAPu08ifyLaXxU1TZh2ESyDjSyATv/zYZBeXghWq9As+UF665jdA==
X-Received: by 2002:a17:90a:db8a:: with SMTP id
 h10mr17706557pjv.58.1595834860479; 
 Mon, 27 Jul 2020 00:27:40 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id s10sm52384649pjf.3.2020.07.27.00.27.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 27 Jul 2020 00:27:39 -0700 (PDT)
Date: Mon, 27 Jul 2020 00:26:59 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Remove fsl_asoc_card_set_bias_level
 function
Message-ID: <20200727072658.GA16513@Asurada-Nvidia>
References: <1595762417-2190-1-git-send-email-shengjiu.wang@nxp.com>
 <20200727005558.GA30124@Asurada-Nvidia>
 <CAA+D8AOfh1gDec=0BPk6SUutqtY_gL1Rm1-Uc4Dv4s-86LAwPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8AOfh1gDec=0BPk6SUutqtY_gL1Rm1-Uc4Dv4s-86LAwPA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

On Mon, Jul 27, 2020 at 02:33:18PM +0800, Shengjiu Wang wrote:
> > >  static int fsl_asoc_card_audmux_init(struct device_node *np,
> > >                                    struct fsl_asoc_card_priv *priv)
> > >  {
> > > @@ -611,7 +600,6 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
> > >       /* Diversify the card configurations */
> > >       if (of_device_is_compatible(np, "fsl,imx-audio-cs42888")) {
> > >               codec_dai_name = "cs42888";
> > > -             priv->card.set_bias_level = NULL;
> >
> > Can check if set_bias_level is still being used with this change.
> 
> Do you mean to keep this line:
> priv->card.set_bias_level = NULL; ?

Sorry. You can just ignore this part -- just double checked the
code, and I think I misread something :-/
