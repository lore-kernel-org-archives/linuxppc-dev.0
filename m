Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C613EC282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 22:31:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F413217FA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 22:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uz3AChrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F413217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kxmh2bqlzDqQJ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 08:31:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com;
 envelope-from=gabrielcsmo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="uz3AChrE"; 
 dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ks2w0mmVzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 04:58:44 +1000 (AEST)
Received: by mail-wr1-x442.google.com with SMTP id o12so3896108wrn.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 11:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=FojubWmNMeB2V9f+sYtEMSMYaZHbBpTkgkUdpBzRNAI=;
 b=uz3AChrE6WTGUUS90yK+Jl6V8CvwV571cgcUpAcvjL8EODOPr5nO+1S0V9bKf4QysJ
 0qs8DrL1D3D38eRC7iFbVLkuVgtXNt407glB4C1CLwGO/VhZ7v5WAcCJZAofcpor5AkU
 48TJE1Tqv5x8JxN2iIbbvpp9cK4na/y0Z7OI295Mi7uoOqmQzaNwYrMwACGaa849CGui
 B0w52cKoem0Q7BPpXj3TRryCyxLRON1Smydrrdcr+AJGhngJJO+lCVKjtCUoffXxefjO
 eqM8qGWlkYnEdCZUeCApMXhx5w3KMfZF6L7gxExyR1LcuctUMR8Q4XQ9PBwdEc63jXOV
 ChRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=FojubWmNMeB2V9f+sYtEMSMYaZHbBpTkgkUdpBzRNAI=;
 b=Xj96FZwnGhOphHs8G+EfqcemK6sthaGO2/6p1WxGlWctlFyZMScOtueIVrmCkKTUgh
 c60BWdSMQl2dal+yHwhjWXfdjJMYHGjkFFuJGDqU/h0qtW/gD4UrKYMZ2T45Rgfoo6k2
 ykCizoYyd6P5M/Eu9WWa9Y2lxQmzds+kb0D6TWb4hQPlCV0PO1R9fKgOwn9sVQoVh8yD
 xM/8JzVstUio4dB2XcZWX+GQuBduP+TBPdzYlmVXBCv0rKmNN4sSsktAMV1wyyfhINTB
 /7DUk5v55Oi/U8/LtAlmrGbjn1EoPjOZHkNH9/qvESRpGjuiv7jVtiKDrWG6E5wjhp84
 uliQ==
X-Gm-Message-State: APjAAAXobYZhkCHWauiNL6S7d+AnKfcl6cRuajX4Ra5fqYDDnUh4zXtB
 SQbtOw8DUbCHDpLaSt0o6O4=
X-Google-Smtp-Source: APXvYqxr87NnY9ACQSi5NG7YjfxvsOwxQzuKXUm7IYG4vCKYqXBPorS5UZ2B4AUbatjtaeV7vsL57g==
X-Received: by 2002:adf:f488:: with SMTP id l8mr56198802wro.213.1555527520482; 
 Wed, 17 Apr 2019 11:58:40 -0700 (PDT)
Received: from localhost.localdomain ([86.124.23.100])
 by smtp.gmail.com with ESMTPSA id s21sm36034617wra.45.2019.04.17.11.58.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Apr 2019 11:58:39 -0700 (PDT)
Message-ID: <3228ff50862b0bad95561bd5276cbfcad5d6213c.camel@gmail.com>
Subject: Re: [PATCH -next] ASoC: fsl_micfil: Remove set but not used
 variable 'osr'
From: gabrielcsmo@gmail.com
To: Nicolin Chen <nicoleotsuka@gmail.com>, Daniel Baluta
 <daniel.baluta@gmail.com>
Date: Wed, 17 Apr 2019 21:58:37 +0300
In-Reply-To: <20190417183518.GA5073@Asurada-Nvidia.nvidia.com>
References: <20190417150915.37968-1-yuehaibing@huawei.com>
 <CAEnQRZAug2kQoFTN6W47URBKwHcU5Zmmy=04smOtMomuzz6_TA@mail.gmail.com>
 <20190417183518.GA5073@Asurada-Nvidia.nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 18 Apr 2019 08:30:22 +1000
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

On Wed, 2019-04-17 at 11:35 -0700, Nicolin Chen wrote:
> On Wed, Apr 17, 2019 at 06:25:11PM +0300, Daniel Baluta wrote:
> 
> > Looks good to me. Just one question for Cosmin:
> > > diff --git a/sound/soc/fsl/fsl_micfil.c
> > > b/sound/soc/fsl/fsl_micfil.c
> > > index 40c07e7..f7f2d29 100644
> > > --- a/sound/soc/fsl/fsl_micfil.c
> > > +++ b/sound/soc/fsl/fsl_micfil.c
> > > @@ -151,12 +151,9 @@ static inline int get_clk_div(struct
> > > fsl_micfil *micfil,
> > >  {
> > >         u32 ctrl2_reg;
> > >         long mclk_rate;
> > > -       int osr;
> > >         int clk_div;
> > > 
> > >         regmap_read(micfil->regmap, REG_MICFIL_CTRL2,
> > > &ctrl2_reg);
> > 
> > I noticed now that we also read ctrl2_reg without using it. Is this
> > as intended?
> 
> For Cosmin,
> 
> Same question here.
> 
> Btw, I just noticed that the initial patch of adding this driver
> did not seemly include most of FSL maintainers/reviewers. Please
> run get_maintainer.pl to add all listed reviewers when sending a
> change to the maillist.
> 
> Thanks
> Nicolin

Hello,

The regmap_read is not used anymore in this implementation and I've
forgot to remove it - it can be safetly removed.

Nicolin, I am pretty sure I've ran the get_maintainer.pl script but
I will pay more attention next time... sorry if I forgot to add you.

Best regards,
Cosmin

