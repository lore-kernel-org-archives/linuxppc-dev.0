Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C4BC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 09:33:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 579FC223CB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 09:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xM8fL24m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579FC223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wbkw2JBrzF3Dj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 20:33:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xM8fL24m";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=baylibre.com
 (client-ip=2a00:1450:4864:20::343; helo=mail-wm1-x343.google.com;
 envelope-from=clabbe@baylibre.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="xM8fL24m"; 
 dkim-atps=neutral
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wbh16LYgzF3Wx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 20:30:41 +1100 (AEDT)
Received: by mail-wm1-x343.google.com with SMTP id t15-v6so17332268wmt.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 01:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=uNm7UG+p0cFTwhhywuPjSiHbxGrq0ABTHOWshR9EV/A=;
 b=xM8fL24mbu8ShG59YrloBNmRt+vznWfrG838jmPFzsWP0hhsmG22dcUez88i+EdhLY
 07DQ+/S/nh/efYc1uiLipUoAfHUAHk/Q62zYklE5V09p/Lw97KccOPflASARTZZrg5pz
 Cdeppy/EkxMME/46hJ3i/dITcE7VgTnZogTvNuwCwni49Lo9PyBXqKMk0TCSsVbKmozZ
 hH9sVdmJmOsgHfJMAfuhVWBURCloyyFMHn+nTrl66jDciWz06P39yg3jyx1TSo9ZCKNY
 ncaaJFKj2lA7v2eVQ22jiMM29tW5aETJ4T/vdU+PW447I6RBIUSjjw2acill89qtlNTX
 5bfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uNm7UG+p0cFTwhhywuPjSiHbxGrq0ABTHOWshR9EV/A=;
 b=udsPct33yI+SF8ZsQypUz/QfOhV7xrUjADJMT+73Yl+6lUW7SX/ygmkI3qZQax8Ubj
 DoxI06HUumHXuWub8pDvwuuhxytB3GQRp5ULwCo14ahyHsb0OKA/7GeeDY5cXwAPfA82
 gtbKr3JSWKbufJr15pplvFtBiC4LnytF8fvt7hoDFnip2K46Lo+yer6m+AUMdz2LnIVK
 QdAyKXTj+yJkcU1wZ9dH9S5LDoidD49DoaYcXbkBTkXxpv+rZqGeC8jf82y0kJvDMT0O
 ZiJjOIxNu4ffA8tLmCBkFGBZUdYXqiCOSiFGklzq64ByEXiZvneHGpY1K4uaFYupK/dt
 6Zhw==
X-Gm-Message-State: AGRZ1gJFUKnHQB4teqDAhEdaV7sgA3DvCNwZijKUX6J3PzL4o8do7wEm
 SwyKJvTwJfUlyID7eSnc/pUD8A==
X-Google-Smtp-Source: AJdET5cnrvLUvsGLwqpKv6hpw+aiGJuSE24NGSxBtuQkp9Lzqm640R9T3+AI0eIZkQlnMNJZ0D3L3A==
X-Received: by 2002:a1c:7c0b:: with SMTP id x11mr754185wmc.20.1542274238235;
 Thu, 15 Nov 2018 01:30:38 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
 by smtp.googlemail.com with ESMTPSA id
 f12-v6sm12950033wru.63.2018.11.15.01.30.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 15 Nov 2018 01:30:37 -0800 (PST)
Date: Thu, 15 Nov 2018 10:30:34 +0100
From: LABBE Corentin <clabbe@baylibre.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 0/7] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64
Message-ID: <20181115093034.GB23965@Red>
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
 <20181024085700.GR30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024085700.GR30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Gilles.Muller@lip6.fr, maxime.ripard@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
 linux-sunxi@googlegroups.com, paulus@samba.org,
 linux-amlogic@lists.infradead.org, cocci@systeme.lip6.fr,
 narmstrong@baylibre.com, airlied@linux.ie, wens@csie.org, joabreu@synopsys.com,
 agust@denx.de, alexandre.torgue@st.com, alistair@popple.id.au,
 nicolas.palix@imag.fr, oss@buserror.net, Julia.Lawall@lip6.fr,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 peppe.cavallaro@st.com, linux-arm-kernel@lists.infradead.org,
 michal.lkml@markovi.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 khilman@baylibre.com, carlo@caione.org, tj@kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 24, 2018 at 09:57:00AM +0100, Russell King - ARM Linux wrote:
> On Wed, Oct 24, 2018 at 07:35:46AM +0000, Corentin Labbe wrote:
> > This patchset adds a new set of functions which are open-coded in lot of
> > place.
> > Basicly the pattern is always the same, "read, modify a bit, write"
> > some driver and the powerpc arch already have thoses pattern them as functions. (like ahci_sunxi.c or dwmac-meson8b)
> 
> The advantage of them being open-coded is that it's _obvious_ to the
> reviewer that there is a read-modify-write going on which, in a multi-
> threaded environment, may need some locking (so it should trigger a
> review of the locking around that code.)
> 
> With it hidden inside a helper which has no locking itself, it becomes
> much easier to pass over in review, which means that races are much
> more likely to go unspotted - and that is bad news.
> 

Hello

I understand your fear, but I think the benefit overhaul thoses.
Furthermore, drivers which I have converted does not need such locking.

If you want I can rename the header to linux/setbits-non-atomic.h for making obvious the lack of locking.

Regards
