Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B399FC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 08:36:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C5520842
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 08:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPC4HrPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C5520842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444nrV2m3ZzDqBY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 19:36:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=vilhelm.gray@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZPC4HrPd"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444nfJ4lVwzDqDW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 19:27:52 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id u9so6131726pfn.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 00:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=g5gN4Ti0gN+mczLgHhdKVrENWOTE09jCVWnpN/478RY=;
 b=ZPC4HrPdz+WY6AK9hfFZDhcbS7CxkySmfmXhtYXcQUQkKmLIAX2EVxo+MN8tnhNrYs
 H8pwsE6LR931tqfoTltTDeciYj8gMZmnFqHzpapNqLYGZtsqxLEsJG49B4dDFRzAXZAI
 wxfFc6d+QlYwVFgCJY5jvgbyWQTOwPVzSA/3Mb4QWd6TrCafEYiFPbnL6vzD2cxJ+LDi
 n6pTfn2IQTzSakuXkbroS7vy3VeVtWj0C8jFqGj8OMMn0t+BuQQGORqy7lmBXo6ae1wV
 pTPOR2prRD++s9vCn/842lnW2bGWhrohsW6tTp2vtR18jlTInv5qUO1oBuF8mTooMCM9
 W6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=g5gN4Ti0gN+mczLgHhdKVrENWOTE09jCVWnpN/478RY=;
 b=AxsCfusfNQrLzTdltiWJu0HUOeKELSQSnBu/bQKdnVIZt7DPW4f8V8Oxz99AQM9Iww
 udIhKq0Vls6gifq9fsKRS4hvpdInXEaS8wAKMGYVcl8eUzwTd6+9PjFnUmXeoUWeamD1
 le2ySVKNEn3aZIhrCaJOJEMlkeA7tmirA3ZRE33M5tJF0g9QO6BqhG4Jc67xmW+FCeYi
 6YHDKoOw+rFy+SvshBkf61chjgKtV15gA9aMO3RYtaiJiKWKksBd4RODqw1rGRLmF2YS
 c0F2eQyOEeh6rcnU8m4vswb7okHoyQVgiLzVZ0/QW49HgWq7QXqijD0aN66PD/uq/FMU
 GIug==
X-Gm-Message-State: AHQUAuZ/nWo5AFIuyX3FMSVnFdYUUnb4koWO4DF45fAxk0P/cwNw4d+n
 o0FKX6tL19vR3+Z2PWlBA1c=
X-Google-Smtp-Source: AHgI3IZHNJbq9wAWv/DgJ7abDmOyMDM9OF93XsPXA58Q+3Eb1CGKbsQCgm4TJ1+6HhEgw1vRQJEhcA==
X-Received: by 2002:a63:1766:: with SMTP id 38mr33480045pgx.204.1550737670185; 
 Thu, 21 Feb 2019 00:27:50 -0800 (PST)
Received: from icarus ([2001:268:c0a4:888c:c70:4af9:86e2:2])
 by smtp.gmail.com with ESMTPSA id f67sm29158116pff.29.2019.02.21.00.27.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 00:27:48 -0800 (PST)
Date: Thu, 21 Feb 2019 17:28:21 +0900
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Patrick Havelange <patrick.havelange@essensium.com>
Subject: Re: [PATCH 5/8] iio/counter: add FlexTimer Module Quadrature decoder
 counter driver
Message-ID: <20190221082758.GA3380@icarus>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
 <20190218140321.19166-5-patrick.havelange@essensium.com>
 <20190220164154.00547a77@archlinux> <20190221010931.GA3471@icarus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190221010931.GA3471@icarus>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Esben Haabendal <esben@haabendal.dk>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 21, 2019 at 10:09:54AM +0900, William Breathitt Gray wrote:
> On Wed, Feb 20, 2019 at 04:41:54PM +0000, Jonathan Cameron wrote:
> > On Mon, 18 Feb 2019 15:03:18 +0100
> > Patrick Havelange <patrick.havelange@essensium.com> wrote:
> > 
> > > This driver exposes the counter for the quadrature decoder of the
> > > FlexTimer Module, present in the LS1021A soc.
> > > 
> > > Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> > > Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> > Given you cc'd William, I'm guessing you know about the counter
> > subsystem effort.  I would really rather not take any drivers
> > into IIO if we have any hope of getting that upstreamed soon
> > (which I personally think we do and should!).  The reason is
> > we end up having to maintain old ABI just because someone might be using
> > it and it makes the drivers very messy.
> > 
> > I'll review as is though as may be there are some elements that will
> > cross over.
> > 
> > Comments inline.  William: Looks like a straight forward conversion if
> > it makes sense to get this lined up as part of your initial submission?
> > You have quite a few drivers so I wouldn't have said it needs to be there
> > at the start, but good to have it soon after.
> > 
> > Jonathan
> 
> I agree, we should try to merge this as part of Counter subsystem
> introduction rather than as another IIO Counter driver. As we determined
> when adding support for the STM32 timers, the existing IIO Counter API
> is fundamentally unsuitable for representing counter devices. So
> regardless of how a new Counter API is merged, the existing IIO Counter
> API must be deprecated.
> 
> Patrick, I apologize for the confusion this has caused. Would you be
> able to convert this driver to use the proposed Counter subsystem API
> from this patchset that I believe you encountered before:
> https://marc.info/?l=linux-arm-kernel&m=153229982404051
> 
> Although it was last updated in October, I believe you should be able to
> rebase that Counter subsystem introduction patchset cleanly on top of
> the IIO tree (if there are any merge conflicts send me an email). Take a
> look at the generic-counter.rst file under the Documentation/driver-api/
> directory for an overview of the API; the counter drivers under the
> drivers/counter/ directory also make good references.
> 
> If you have any difficulties understanding the API, or any other
> troubles, don't hesitate to ask. Hopefully, I've made the documentation
> clear enough to make the conversion of this driver quick and easy -- and
> if not, then it's something I need to fix, so let me know. :-)
> 
> William Breathitt Gray

Patrick,

It looks like there were some minor conflicts with the v9 patchset, so
I've rebased it on top of the latest iio tree testing branch and
resolved the conflicts in my personal repository. Please pull from my
personal repository at https://gitlab.com/vilhelmgray/iio.git and base
your patches on top of the generic_counter_v10 branch.

William Breathitt Gray
