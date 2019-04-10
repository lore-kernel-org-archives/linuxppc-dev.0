Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DA4C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:53:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56572063F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZ4AnJwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56572063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fWx06FLTzDqMh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:53:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="lZ4AnJwP"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fWvC5HxbzDqG9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 03:52:06 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id f36so1881215plb.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 10:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=q6vMYeKcOVpG8+cf+myp9kRl+55Hdk3n7iRz3oEomxg=;
 b=lZ4AnJwPqrYpOXLlwsXmye9Kjw/QTaGGTQ/SWt2WSeIvfUQDZb/Q8CDjLQT5u3TdHN
 gaFzj7fu35Ey5SRWMyNjhDcBoSx4i6Df5SWSxKtN3VdETKeXD2V4eNpQqT8dqGAnuTA/
 Tj0bX62zHSlnJqSHzoL6HCIdTjNkwSQXKPInwT6MjwbXdNnwrLs68KOjiFOJSkX9mt8B
 ORZOOXyBN7LJug/nFbKYGEzLDO/yumS1IvZR7tm+Ei4sFd3OsRGnbrYsez5tYehDbDS9
 2mUrt4l0eOHv/BHQRu/blXBG8+XDBk5aow7ehJhYcl4stAPbgamnWRbmZsyWUQnEClvc
 9eBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=q6vMYeKcOVpG8+cf+myp9kRl+55Hdk3n7iRz3oEomxg=;
 b=Ubrx8+brsNjIB/brhcVe7f23+7xSRFrN4bqaqXBNaTdybZtaYRKLMTsAyEvxrH52TT
 GFWVPgeEHuU70njVpdmGwWO1hGjsM4w6nL/nELeqqXrnY1FK5ozWNaBOmb589h3UHrRX
 JlN8mGWTgCkcqp4frpM7Tni6o93GpwZQG7E01wspyqMrS/eqNi8rspCbNzAksmlV7Nbs
 2QFt44wDgOYafKdRKDoDfqdPiH9T4xVFw8Kb3ZP6BaW39uGKQBAHbqhqbvjGY0ZminFt
 NY+xBAMx7NJ4zVpMRrLCuf2QN3VH0bsPu1+HjAOAksrC89nwtUivZrfqQLMzizacLPAL
 KYGA==
X-Gm-Message-State: APjAAAWwYHfcsQ0Kt3fHgHqF6VDnt7xGIbFqKC7IDcifY/OfscEdmvID
 HdfaNSnfDl+BtqDufcWMADk=
X-Google-Smtp-Source: APXvYqyYAr070mCEgCOdEwxn0JzLGuhE+1VYlxcSGQxthBDZLWuUHTQzOcPFDnSLhPxUXDPeeV46/A==
X-Received: by 2002:a17:902:e704:: with SMTP id
 co4mr4527330plb.30.1554918722850; 
 Wed, 10 Apr 2019 10:52:02 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id a12sm41223688pgq.21.2019.04.10.10.52.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 10 Apr 2019 10:52:02 -0700 (PDT)
Date: Wed, 10 Apr 2019 10:51:57 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [EXT] Re: [PATCH v2 1/3] ASoC: fsl_audmix: remove "model"
 attribute
Message-ID: <20190410175156.GA24002@Asurada-Nvidia.nvidia.com>
References: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
 <1554809242-27475-2-git-send-email-viorel.suman@nxp.com>
 <20190410042906.GC3032@Asurada> <1554892497.14997.13.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1554892497.14997.13.camel@nxp.com>
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tiwai@suse.com" <tiwai@suse.com>,
 "viorel.suman@gmail.com" <viorel.suman@gmail.com>,
 "Julia.Lawall@lip6.fr" <Julia.Lawall@lip6.fr>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, "perex@perex.cz" <perex@perex.cz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 10, 2019 at 10:34:57AM +0000, Viorel Suman wrote:
> Hi Nicolin,
> 
> On Ma, 2019-04-09 at 21:29 -0700, Nicolin Chen wrote:
> > WARNING: This email was created outside of NXP. DO NOT CLICK links or
> > attachments unless you recognize the sender and know the content is
> > safe.
> > 
> > 
> > 
> > On Tue, Apr 09, 2019 at 11:27:39AM +0000, Viorel Suman wrote:
> > > 
> > > Use "of_device_id.data" to specify the machine driver
> > > instead of "model" DTS attribute.
> > > 
> > > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > 
> > > 
> > > ---
> > >  sound/soc/fsl/fsl_audmix.c | 43 +++++++++++++++++++++++-----------
> > > ---------
> > >  1 file changed, 23 insertions(+), 20 deletions(-)
> > > 
> > > +     priv->pdev = platform_device_register_data(&pdev->dev, mdrv,
> > > 0, NULL,
> > > +                                                0);
> > Would you please send a separate patch to replace "pdev->dev"?
> 
> Thank you for review. Yes, will send V3.

Ah...when I said that, I was literally saying that you should
send a separate patch individually, not resend the series.

Now I see you sent v3/v4 almost at the same time as "Applied"
mails from Mark. And I am totally confused which version got
applied....

Please rebase your local tree and find out which version got
applied and then send the diff with a separate patch.

Thanks
Nicolin
