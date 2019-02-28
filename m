Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ADCC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 19:49:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE54218AE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 19:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE54218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449NRl5HXZzDqNH
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 06:49:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.196; helo=mail-oi1-f196.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449NPT2mWMzDqN6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 06:47:40 +1100 (AEDT)
Received: by mail-oi1-f196.google.com with SMTP id b4so17522911oif.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 11:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4zLpkg9lasy0oknFW0BAb173RlRaDWUARDEXV2KYlVQ=;
 b=fLs2MutSXrDqXWSTEQKbhuE1p+F4G7KPu461U0Yy66L7cLuC1SxfAqECgMKL/j+Mv8
 Nm0KdgWJiG4b9unlpFNo9QaebSGrgza8jrZg9hHrahcC5X/sMEAJAEqJeQ7ASUeqaoLd
 XQqcq0HccjkEPoaXaKaszHF3YzR+bjFKrzsBRBtcODbCLkcB38H6KMVYUOZ86o4K6m0W
 2dl/QchCEZuR6TWwZ2m+4CXK1CKYjBW3+EqA8CT6M5JWB+UTYi8zKmSkfNSzGSO8+dYG
 tBscHZz5cdrhX2DaU4jFfCkPmf5prJWiPaqh4ESco8qfx9WyYoZTw6/Pc6wvoJxQFPAr
 2ypg==
X-Gm-Message-State: APjAAAXHK5p0MnWWqYWG2NxOF7ZrTk6jTnwWIEMxO4ANXLJl6xNgGy1a
 AMSo49IxrMUEJdEDYYA3Eg==
X-Google-Smtp-Source: AHgI3IZcVaVIt3JIXFrJEaqwgrZfby2Bq9Ok7clcX8jSWYhPXacngMqyeXKcxOKyylxGRBhN6jT2vw==
X-Received: by 2002:aca:fc09:: with SMTP id a9mr874570oii.106.1551383258425;
 Thu, 28 Feb 2019 11:47:38 -0800 (PST)
Received: from localhost ([2607:fb90:20de:307f:59ce:35b2:628:2365])
 by smtp.gmail.com with ESMTPSA id a15sm7951821otq.35.2019.02.28.11.47.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 28 Feb 2019 11:47:37 -0800 (PST)
Date: Thu, 28 Feb 2019 13:47:36 -0600
From: Rob Herring <robh@kernel.org>
To: Patrick Havelange <patrick.havelange@essensium.com>
Subject: Re: [PATCH 7/8] dt-bindings: iio/counter: ftm-quaddec: add
 poll-interval parameter
Message-ID: <20190228194736.GA6079@bogus>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
 <20190218140321.19166-7-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218140321.19166-7-patrick.havelange@essensium.com>
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
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>,
 Patrick Havelange <patrick.havelange@essensium.com>, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 William Breathitt Gray <vilhelm.gray@gmail.com>, Li Yang <leoyang.li@nxp.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Esben Haabendal <esben@haabendal.dk>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 18 Feb 2019 15:03:20 +0100, Patrick Havelange wrote:
> New optional parameter supported by updated driver.
> 
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> ---
>  .../devicetree/bindings/iio/counter/ftm-quaddec.txt       | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
