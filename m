Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71080C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:56:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B242063F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4jzN5Pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B242063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fX0100gbzDqGM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:56:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="F4jzN5Pi"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fWxz5P5vzDqG9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 03:54:31 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id 85so2008793pgc.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 10:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=1QdfVxlBgXm8H89yKKWn2jflfkFM3p0u2BmhSw9h5MU=;
 b=F4jzN5Piuqaqy1futXqxnvgMcUbs190PKEGqzk9347APOqW5W0YnnmtMVEhL9L6v72
 OMY5tl1Cq9k9blhvlC9vi8cmEmDXzmlXhkcro7a0PQqjbJGWlRU4gY29/nya1++crAGv
 fm7nNuI3l0fU7FwhXcnhjKOMV+e09qxfoGRd+xayGutP0SSikKevOq8x7r3UeiQyf0Nt
 s15GQjiWtf1hA8m//AJWzwU7WgHhZw4U2d6nJB5QMQWkQQLMsG+qbvg2e67rAtm14tCQ
 k1mWdRyViphEeswT6DUo5VSWyMSeK2lMaeLW6mIeQtxCWDz7iWiimD0RU5mIy933Ct5P
 psLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=1QdfVxlBgXm8H89yKKWn2jflfkFM3p0u2BmhSw9h5MU=;
 b=BZCP7YGDZh2txc+CQxICFKqx3mCeONrmVv0Q1UEeStdg6qh2i+/o/lRQmUxxfy80Ir
 a3L5p2XG/RU6aC9uYMuui/L3x5kvrIGWOCO1SI+4G7T4YmQXhA/FjNrwUZo3ltnBWUwx
 hE+8CC1o+mFsnaHeHAiKAwHbjSft5Bodx/cWoJO/p5vKagh5qKjtJJGrsLtLzYVrS3Da
 dYgLgOOCR5O7wj2LBAT8XTGTdyynnsR4z6v9v5UyCNUrOOd0dXupD4iL09yjgeMBIb+3
 qXZ2GxzBqk/cERoqQjCW7voV8ik/Rhty3QzieiMqTbQPk6EL8CZXy48DK5qXkGMqPBOu
 cZtw==
X-Gm-Message-State: APjAAAUNTbx21bvZukElpUB8uBRekOB3wVMgrCpVXFvLKcun8/mb94wT
 0SK9nNJ0sggOlF2C2Odjx/I=
X-Google-Smtp-Source: APXvYqxph16qHxwRljw8laqu3qoiI39K1dxpV1UQMhSUf2Ay9y6cVgJmLQptSQN/msphVqYgZ1+KBw==
X-Received: by 2002:a63:79c3:: with SMTP id u186mr41056388pgc.20.1554918867228; 
 Wed, 10 Apr 2019 10:54:27 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id c17sm53932266pfd.76.2019.04.10.10.54.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 10 Apr 2019 10:54:27 -0700 (PDT)
Date: Wed, 10 Apr 2019 10:54:24 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [EXT] Re: [PATCH] ASoC: fsl_asrc: replace the process_option
 table with function
Message-ID: <20190410175424.GB24002@Asurada-Nvidia.nvidia.com>
References: <1554866131-12088-1-git-send-email-shengjiu.wang@nxp.com>
 <20190410042638.GB3032@Asurada>
 <VE1PR04MB64798A5ADF025047AF5B9076E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <20190410080052.GA5180@Asurada>
 <VE1PR04MB6479C577E9C2C58E624C5611E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <20190410095129.GA3468@Asurada>
 <VE1PR04MB6479A2AA38FB6A27E120A441E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VE1PR04MB6479A2AA38FB6A27E120A441E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 10, 2019 at 10:34:05AM +0000, S.j. Wang wrote:
> > On Wed, Apr 10, 2019 at 08:26:59AM +0000, S.j. Wang wrote:
> > > > Is it possible to update the table? It'd be way quicker to use
> > > > lookup table than real-time calculation all the time. I believe you
> > > > can simply calculate all the values out for 12KHz and 24KHz since
> > > > you have the function. If there are certain combinations of these
> > > > two not being supported, then we could mark it with a special value and
> > add an if-check to error out.
> > > >
> > >
> > > Yes,  but I think the function should be more flexible, if someday we
> > > need to support Other sample rate, only need to update the list.
> > 
> > Given the fact that the owner of the function cannot give more comments, I
> > feel the function wouldn't be very maintainable as none of us understands it
> > well. On the other hand, you'll need to update the supported I/O rate lists
> > anyway, so why not just update the table as well? The supported sample
> > rates from ALSA are limited too. Overall, I think that continue using a lookup
> > table wins.
> 
> Alsa support SNDRV_PCM_RATE_KNOT, we can define the rate that we want
> To support,  and use function is more flexible, and we have use the function
> Internally for long time, it is stable😊

OK. I will try to indulge it. Let's see your next version first.
