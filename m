Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395F5C282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 18:37:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505E520693
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 18:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8IF9zoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505E520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44krYp6gbqzDqPl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 04:37:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="L8IF9zoV"; 
 dkim-atps=neutral
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44krX02nnSzDqP1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 04:35:28 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id g8so12409168pgf.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 11:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=nUEsRDGIX/MnBzMpthI1XaQPhS2DtMo0O3QUz3uE4lE=;
 b=L8IF9zoV9/4r9tJf5kZ1rIbB7qqRZmM3tAMTbVfeAzpgXDU+i+b2wMSNwUrzkqJgyf
 s4U2Y8ODPjKBHbKq8NPy70StqAuP7k0aphRVECU7VGOtLL6NQIFWvyJJkxAmnpvrjKaF
 mc5B3pum0z4WTFSgHe2H/ZgdYt1jyzdyFboODEZYpzUVf/Id0X+9whSWK/dOt6jik8er
 +oyM8bSiSGViIckz6zPagXeTj8EHbBPtdChS5g0lGHXIAYgaK3sNyy1TNZZf/q9O4hIf
 31e3xxBlliL0KHMUcSmoS9ML8KCmIXhoT6K4FqIbX+rR3zhLPXJmY3esAHyjJiZRBCV4
 HpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nUEsRDGIX/MnBzMpthI1XaQPhS2DtMo0O3QUz3uE4lE=;
 b=hxUkyv2d7mux2N6eg1U7HRw/GaK1nJTkhue7hCVDMXWRTQPGvI22rIvhxtqlMFltXF
 bPZ+djsTvPc38oTslb3ESnn5hy5a1/dmNNsYrDmjGa9gEGGpshuDelMyfY5A/f5LKGVa
 GK71vujN8/NN3SKjEOOjFCfckwcFbEt39VWTMYtbTxpra0froiFQFh7KykVo89qqKFoU
 PLt1tEhwUhsNcpQcl58CJz4IfOIETZzKJrjCwowD9S6F5D3OlPZocZUj7irrh2VvuQHB
 ODyCzkGRKf/jAYwVz7f1kUnkWkrwbN/uaAV2BZxDGMcbimlRvoJ/aoWRKyd1dzJuZWW9
 +sag==
X-Gm-Message-State: APjAAAV+w9Ec08HYhxZIJh5/0xmtPPlYxrS934b7mU+mKkbPDzf0d6sC
 pQJC8lM4k7xAYYFdWK67C+M=
X-Google-Smtp-Source: APXvYqwoBOIUFT3PPkYHkaJ893V7mgsjdr+l2Tc5sMkTepau78sRjs7Hy5CspJnDT/EAoWZ8/HVD3w==
X-Received: by 2002:a63:2157:: with SMTP id s23mr1241028pgm.436.1555526124703; 
 Wed, 17 Apr 2019 11:35:24 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id b16sm75671630pfo.168.2019.04.17.11.35.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 17 Apr 2019 11:35:24 -0700 (PDT)
Date: Wed, 17 Apr 2019 11:35:19 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Daniel Baluta <daniel.baluta@gmail.com>,
 Cosmin-Gabriel Samoila <gabrielcsmo@gmail.com>
Subject: Re: [PATCH -next] ASoC: fsl_micfil: Remove set but not used variable
 'osr'
Message-ID: <20190417183518.GA5073@Asurada-Nvidia.nvidia.com>
References: <20190417150915.37968-1-yuehaibing@huawei.com>
 <CAEnQRZAug2kQoFTN6W47URBKwHcU5Zmmy=04smOtMomuzz6_TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZAug2kQoFTN6W47URBKwHcU5Zmmy=04smOtMomuzz6_TA@mail.gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, linuxppc-dev@lists.ozlabs.org,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Yue Haibing <yuehaibing@huawei.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 17, 2019 at 06:25:11PM +0300, Daniel Baluta wrote:

> Looks good to me. Just one question for Cosmin:

> > diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
> > index 40c07e7..f7f2d29 100644
> > --- a/sound/soc/fsl/fsl_micfil.c
> > +++ b/sound/soc/fsl/fsl_micfil.c
> > @@ -151,12 +151,9 @@ static inline int get_clk_div(struct fsl_micfil *micfil,
> >  {
> >         u32 ctrl2_reg;
> >         long mclk_rate;
> > -       int osr;
> >         int clk_div;
> >
> >         regmap_read(micfil->regmap, REG_MICFIL_CTRL2, &ctrl2_reg);
> 
> I noticed now that we also read ctrl2_reg without using it. Is this as intended?

For Cosmin,

Same question here.

Btw, I just noticed that the initial patch of adding this driver
did not seemly include most of FSL maintainers/reviewers. Please
run get_maintainer.pl to add all listed reviewers when sending a
change to the maillist.

Thanks
Nicolin
