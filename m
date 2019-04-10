Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1A1C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 09:53:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64FCD20820
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 09:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ97Z/I/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FCD20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fKGn3sjZzDqLp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 19:53:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="IJ97Z/I/"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fKDw2LhtzDqCV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 19:51:42 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id h5so1170329pfo.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 02:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WT9N5j7vhtFtm4YoZl9MOD+tbefbaHv04AfaXnWMZ3w=;
 b=IJ97Z/I//312Pu6PjAKiKsyUqP/Nzo8BsVlkftc1trWAVfxBWNKRFAbr1z4UGBMwNA
 zxRbZaggoqtoTGRSlGegETs5sQgU8ftbboQOvwoTgFgSBBSkhAYotIb3ek7p9UCyqAXg
 /3XweuBm8YGxms0i/qqUGinMXsQiSpf9mB27SXGA/EMK/LW9+tTEm6pJDUhAwqtGilQT
 +IDLXwhF649wFZYDOFT8++t4iGdpzt2A5+wzxOQWyYl2mqKRCCFfyWGEZzXSESBDwz+W
 5SOfsAKHJOAyDiIrlTYTQn3jZUkqkvq6siPuIFYPiIQCWVYL11H4zaXu8N4STjXw4hOu
 nGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WT9N5j7vhtFtm4YoZl9MOD+tbefbaHv04AfaXnWMZ3w=;
 b=FlVkA/VLQg82mEOamhsXsKNHzaR615Nn5twZa+kwAogzTolUOSE/ECd/Llu/aqFZx5
 f9614SdxJkDbJogCRgsv6Ar6D2qL5eoRYxCs/FLPCjNhxFZqp4lAaf3nxQvxvh8SFwMG
 giZIIGxYBJGmK56OF9dOoH90A5eGhNemB2BsVLTP1ZZY9R93jLXGf9NFINmVPwiLOvYH
 3AkEJ7Ddba7e+ruA5rmH4maOpTjQ/YDQGossv5xvJUH717mgK3eE3FMy7bLQKlL/xsNg
 tb9nk9AkxnbYz2QtOPePP5lrPyctgWBdNgnvBsqWabxviICS/mWDaI04BlNA/P248Hmp
 8ViA==
X-Gm-Message-State: APjAAAXSln2MHCmwmXgnQbs9xFm/akS8YVJpkomIDtxpkH+EmyRZnaSy
 SgC/i8HrnPBVrHe0KbEVCqc=
X-Google-Smtp-Source: APXvYqy+BqgQqRhki66giSHwiCKyumhO1yhlkLFX8gPCEp7Lz2jrVL5r+SUx9Vi0L2ASWXqyWT4SDA==
X-Received: by 2002:a62:6402:: with SMTP id y2mr41461153pfb.194.1554889896545; 
 Wed, 10 Apr 2019 02:51:36 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 i3sm51703862pfa.90.2019.04.10.02.51.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Apr 2019 02:51:36 -0700 (PDT)
Date: Wed, 10 Apr 2019 02:51:30 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [EXT] Re: [PATCH] ASoC: fsl_asrc: replace the process_option
 table with function
Message-ID: <20190410095129.GA3468@Asurada>
References: <1554866131-12088-1-git-send-email-shengjiu.wang@nxp.com>
 <20190410042638.GB3032@Asurada>
 <VE1PR04MB64798A5ADF025047AF5B9076E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <20190410080052.GA5180@Asurada>
 <VE1PR04MB6479C577E9C2C58E624C5611E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479C577E9C2C58E624C5611E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
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

On Wed, Apr 10, 2019 at 08:26:59AM +0000, S.j. Wang wrote:
> > Is it possible to update the table? It'd be way quicker to use lookup table
> > than real-time calculation all the time. I believe you can simply calculate all
> > the values out for 12KHz and 24KHz since you have the function. If there are
> > certain combinations of these two not being supported, then we could mark
> > it with a special value and add an if-check to error out.
> > 
> 
> Yes,  but I think the function should be more flexible, if someday we need to support
> Other sample rate, only need to update the list.

Given the fact that the owner of the function cannot give more
comments, I feel the function wouldn't be very maintainable as
none of us understands it well. On the other hand, you'll need
to update the supported I/O rate lists anyway, so why not just
update the table as well? The supported sample rates from ALSA
are limited too. Overall, I think that continue using a lookup
table wins.
