Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0D3C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 08:03:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46DEE2084B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 08:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/7qEPYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DEE2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fGql0XypzDqPK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 18:03:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="N/7qEPYO"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fGnF0t4KzDqCl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 18:01:04 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id 9so944928pfj.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 01:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Ta4Wu3UC8ObTScCaV87qmwGZbUVHBBABSzYwcPQ2d6E=;
 b=N/7qEPYOjpyXq7xk1dn3V2dwqL88wCJTX8Cm5MorF661xw2Md4XxkWn5eTjO5PKQdk
 HBOWD9jDjJnI/Vi+iGbV9+oQmPrxX0BfCrWqPmzYprUQusTD4eUAgbsIBJWr1Eb4CYLj
 AJVRCDD9XIHwgJCa1e6opwMJHOKcedhjmy/3EZb43DbsL3CfkCyXyerazwTubLqAGq7y
 RO9aJeHbKmw5/HMHw4AbzNK2RccdDylT6rajhU40DykQmtD9EcRVJB37kq4jNETVNe3D
 aLzfNjqyRVcMUxmJAx9FbeoHh1p543vU/z00HI0FJJKNdvgWDfbr3w1hHuNN9UC5ockN
 6kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Ta4Wu3UC8ObTScCaV87qmwGZbUVHBBABSzYwcPQ2d6E=;
 b=iGnLhp7NEAK7c5O12rMfCmJV7MANweS64Jj7FzBKDgP5PsS2vRtHtQE/rnf5ol70vO
 wymCjuFj3zKqB+Fbuz7AccixKcHKgnrtywpefsISIcjhWos7gPImI0ZWryfOmJnlPcFc
 fOgg9WJ+Ymiz6R9OwMRqZR7b84cI0OVxlBYxqmQJP9s8WlOtWU1cyAH3GYw2K+RUVvW1
 +oWJSpql7d/BjQgK59yBojdBF1WVRVFsG46+KcjXNpBWTTXC9GYpdEYN9zf4uZo6GEua
 tOmQfVymIs4OGpCZj+R2wlMJzP186edD5/hSiCUiwBy75ckwAz25lbXb8PPJ7UJ/PaoD
 j1vg==
X-Gm-Message-State: APjAAAXJgjWtMTkf2S3/wLbx4jJwuBVn8lZJJnuOzjqFw3e6xkrTVxc1
 wD6lV72jBIPgQ/nxBg2V7lc=
X-Google-Smtp-Source: APXvYqytntCGhmAstAdrTvkBZSLQ18i2cYGIGOUkaWPPGf6BS1N/JI4qxhy/FPpQX80yel2ZB4EMAw==
X-Received: by 2002:a62:ee0a:: with SMTP id e10mr41844726pfi.6.1554883260766; 
 Wed, 10 Apr 2019 01:01:00 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 v19sm47062737pfn.62.2019.04.10.01.00.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Apr 2019 01:01:00 -0700 (PDT)
Date: Wed, 10 Apr 2019 01:00:53 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [EXT] Re: [PATCH] ASoC: fsl_asrc: replace the process_option
 table with function
Message-ID: <20190410080052.GA5180@Asurada>
References: <1554866131-12088-1-git-send-email-shengjiu.wang@nxp.com>
 <20190410042638.GB3032@Asurada>
 <VE1PR04MB64798A5ADF025047AF5B9076E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB64798A5ADF025047AF5B9076E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
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

On Wed, Apr 10, 2019 at 07:22:31AM +0000, S.j. Wang wrote:
> > The table was copied directly from the Reference Manual. We also have
> > listed all supported input and output sample rates just right behind that table.
> > If there're missing rates, we probably should update those two lists also?
> > Otherwise, how could we have a driver limiting both I/O sample rates while
> > we still see something not in the table?
> > 
> 
> Yes,  I plan to send another patch to update the in/out rate list.  Do I need
> To merge that to this commit?  Actually we want to support 12k and 24KHz

Please send separate patches but in one series. And a question:

Is it possible to update the table? It'd be way quicker to use
lookup table than real-time calculation all the time. I believe
you can simply calculate all the values out for 12KHz and 24KHz
since you have the function. If there are certain combinations
of these two not being supported, then we could mark it with a
special value and add an if-check to error out.

> > > +static int proc_autosel(int Fsin, int Fsout, int *pre_proc, int
> > > +*post_proc)
> > 
> > Please add some comments to this function to explain what it does, and how
> > it works. And better to rename it to something like "fsl_asrc_sel_proc".
> > 
> Yes, some comments should be added, but not so detail, because this function

As much comments as possible.

> Is get from the design team, but the owner has left.

OK...that's sad...

> > Another thing confuses me: so we could have supported sample rates in the
> > list but the hardware might not support some of them because we couldn't
> > calculate their processing options?
> 
> No, just want to support 12k, 24KHz, or others as customer like.

I was confused because the I/O rate lists not getting updated.
It makes sense now if you are abort to update them.
