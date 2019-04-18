Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D749C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 08:05:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3F820693
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 08:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoU9tiDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3F820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lBW20YXmzDqQy
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 18:05:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="KoU9tiDF"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lBSC0VqJzDqRX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 18:03:22 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id v12so837023pgq.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 01:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=+AcexFMyMV8J9T4qaaiOIbAuRbOHeJ5v2ghunSbBPws=;
 b=KoU9tiDFNy/SfiGvLelvpEoklY4NKmsjJk9yitVcyFbcDCltCLOAXmUtuDvVNteD8G
 +BFVVantAaV1AItQq+6OtHbUb4RoFl6PXdbfP17LXgfWkTdyP/ICNrvwu0vnLdKShHkL
 pU405XnZK+7hY09ALpr9j6HDYSw0xnEgN0lZhfqRI2fInkXOyhcIJS7HJwmO3NjokhbC
 3zm5eWlUbOEME4Mf3MrljVKUAoz3rjlP+MsovqQe/JVoI7yPO0sl2Ki6eKvldtDM11Br
 bsEB/2xJuoeJLl9c/rR1Nb6Habkj3R3FHnjTqV0PkE6O+9FVDEDoPuF/2tX05qKFAwQ5
 L1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+AcexFMyMV8J9T4qaaiOIbAuRbOHeJ5v2ghunSbBPws=;
 b=VY5jjVxuwMgoB82I+MpwDd1gw6mi401XT+0XhzVQH8QQ4SOFeGrAWEFJ8Hlh/d2lmq
 a52Oe5ir6m6FSmHTCtReXxCgYFS0PVvGfVKzRvVJHl2axz9KsBwpxZ8O3MhysmBjGRRe
 ZxAZUhdXKoF43n6L1QIoxWQywZC5QnYqZOxTyRdNFEgmcj3HAhLisQSp+nfdHb9kIwg7
 +dmFx71Hly9okWt70gcRkncnvXSZF+xxXTuUU5Dk7ycebg6GJFms9eOhYnPVBKR9uZ5x
 D1Yp0saKd+rIoDG4LuC3g3mCsvoZR8UMNPxnv/q9wWyAVCqPEo7qqfCl2F1upwOfpch7
 CEmw==
X-Gm-Message-State: APjAAAXKJFcSOR7GEsgpbaQDnL6Hxnad4OquYpagO2B3a5BIejuF5x2T
 g1LzratYOIEhEbGWDase94k=
X-Google-Smtp-Source: APXvYqz4EPUVQrAJd+32ydH3bwKXIzk3V/JYPeiheBWNzOuvGWZapEQK9/munPDxHot4eUPtYunYjw==
X-Received: by 2002:a63:ef4c:: with SMTP id c12mr74651267pgk.43.1555574598950; 
 Thu, 18 Apr 2019 01:03:18 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 d69sm2455676pfg.24.2019.04.18.01.03.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Apr 2019 01:03:18 -0700 (PDT)
Date: Thu, 18 Apr 2019 01:03:10 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Message-ID: <20190418080309.GA9788@Asurada>
References: <AM6PR04MB647093DB49BB13E09B0F181DE3260@AM6PR04MB6470.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB647093DB49BB13E09B0F181DE3260@AM6PR04MB6470.eurprd04.prod.outlook.com>
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 18, 2019 at 02:37:03AM +0000, S.j. Wang wrote:
> > Here:
> > > +     /* Does not support cases: Tsout > 8.125 * Tsin */
> > > +     if (inrate * 8 > 65 * outrate)

Though it might not matter any more (see my last comments),
it should be "inrate > 8.125 * outrate" in the comments.

> > > +             return -EINVAL;
> > And here:
> > > +     ret = fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc);
> > > +     if (ret) {
> > > +             pair_err("No supported pre-processing options\n");
> > > +             return ret;
> > > +     }
> > 
> > Instead of a general message, I was thinking of a more specific one by
> > telling users that the ratio between the two rates isn't supported --
> > something similar to what I suggested previously:
> > 
> >         pair_err("Does not support %d (input) > 8.125 * %d (output)\n",
> >                  outrate, inrate);
> > 

> In fsl_asrc_sel_proc,  we can't call the pair_err for there is no
> struct fsl_asrc_pair *pair in the argument. Do you think we need to
> add this argument?

I's thinking of adding it to the top of fsl_asrc_config_pair()
as a part of inrate-outrate-validation, however, I found that
actually we already have a similar check in the early routine:
	if ((outrate > 8000 && outrate < 30000) &&
	    (outrate/inrate > 24 || inrate/outrate > 8)) {
		pair_err("exceed supported ratio range [1/24, 8] for \
			 inrate/outrate: %d/%d\n", inrate, outrate);
		return -EINVAL;
	}

And this is according to IMX6DQRM:
    Limited support for the case when output sampling rates is
    between 8kHz and 30kHz. The limitation is the supported ratio
    (Fsin/Fsout) range as between 1/24 to 8

This should cover your 8.125 condition already, even if having
an outrate range between [8KHz, 30KHz] check, since an outrate
above 30KHz will not have an inrate bigger than 8.125 times of
it, given the maximum input rate is 192KHz.

So I think that we can just drop that 8.125 condition from your
change and there's no need to error out any more.

However, we do need a patch to fix a potential rounding issue:
-	    (outrate/inrate > 24 || inrate/outrate > 8)) {
+	    (outrate > 24 * inrate || inrate > 8 * outrate)) {

Should fix the missing whitespace also. And it will be needed
to send to stable kernel too. Will you help submit a change?

Thanks
