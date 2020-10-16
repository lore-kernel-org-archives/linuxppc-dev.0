Return-Path: <SRS0=n4ep=DX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C82EC433E7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2020 19:06:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435EF20709
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2020 19:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435EF20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCbH93nMBzDqHV
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2020 06:06:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.161.68; helo=mail-oo1-f68.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com
 [209.85.161.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCb0C1H05zDqHV
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2020 05:53:45 +1100 (AEDT)
Received: by mail-oo1-f68.google.com with SMTP id w25so853608oos.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2020 11:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/BLMOeuNPLg/1+rmux5PnQpwOXbVITQef6gQqf/xRV4=;
 b=p6Gj1mzl4bMCOuTPaBMYpb4GT4PCnGXPc6wPOTr9StehEGHDw2G7PL2k7VyByZlzG8
 p78BCKwKRCPBpBZgIi5pwicZq8C7WmJ6kCsktt+785FmZRzdhNAU50HbyDOt4X5Q0bq7
 ijzhIvzodTI63UU1RWYqeXZ++9tzJeCppIraAi+mm6e00jP3uvrGkyTsu6F7AhVXj16r
 Es/yT/jx43aAozq+0urQFN9bhCZrwKSzRF73yyUeSSurTBXzDyGAOfV8+PLAHtfkDC72
 PvqiJZvWAoEAEDs9CuiAtYQlgoFEGDlZ9jU+NzFg/itvypLr5QbXTabn4cls78tq0Y8+
 akiQ==
X-Gm-Message-State: AOAM530UeMQaNyoy722+6/wPOGTniGKjTDI8YGRGT3zTg8hNX6EvMSW7
 CI7b6dd+gUGc5AiWpq5Eqv5BsYN1Uw==
X-Google-Smtp-Source: ABdhPJxtoraofuhC22sxyo8Q42rEuTESh7JvVkC+ACDOtuWNWIg2F8VJBGdmwUM7JkujSl0LOdhDaw==
X-Received: by 2002:a4a:e93a:: with SMTP id a26mr3885560ooe.58.1602874422546; 
 Fri, 16 Oct 2020 11:53:42 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 33sm1194275otr.25.2020.10.16.11.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 11:53:41 -0700 (PDT)
Received: (nullmailer pid 1738434 invoked by uid 1000);
 Fri, 16 Oct 2020 18:53:40 -0000
Date: Fri, 16 Oct 2020 13:53:40 -0500
From: Rob Herring <robh@kernel.org>
To: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH 11/20] dt-bindings: usb: dwc3: Add synopsys,dwc3
 compatible string
Message-ID: <20201016185340.GA1734346@bogus>
References: <20201014101402.18271-1-Sergey.Semin@baikalelectronics.ru>
 <20201014101402.18271-12-Sergey.Semin@baikalelectronics.ru>
 <20201014201818.GA6926@kozik-lap>
 <20201014213554.turskjyuntk35syj@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014213554.turskjyuntk35syj@mobilestation>
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
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-kernel@vger.kernel.org,
 Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
 Kevin Hilman <khilman@baylibre.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Andy Gross <agross@kernel.org>, linux-snps-arc@lists.infradead.org,
 devicetree@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>,
 Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
 Serge Semin <fancer.lancer@gmail.com>, Manu Gautam <mgautam@codeaurora.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 15, 2020 at 12:35:54AM +0300, Serge Semin wrote:
> On Wed, Oct 14, 2020 at 10:18:18PM +0200, Krzysztof Kozlowski wrote:
> > On Wed, Oct 14, 2020 at 01:13:53PM +0300, Serge Semin wrote:
> > > The DWC USB3 driver and some DTS files like Exynos 5250, Keystone k2e, etc
> > > expects the DWC USB3 DT node to have the compatible string with the
> > > "synopsys" vendor prefix. Let's add the corresponding compatible string to
> > > the controller DT schema, but mark it as deprecated seeing the Synopsys,
> > > Inc. is presented with just "snps" vendor prefix.
> > 
> 
> > Instead of adding deprecated schema just correct the DTSes to use snps.
> > The "synopsys" is not even in vendor prefixes.
> 
> Yeah, it's not, but the driver and some dts'es use it this way. I am not sure
> that the solution suggested by you is much better than mine. So let's hear the
> Rob'es opinion out in this matter. @Rob, what do you think?

I think we should fix the dts files given there's only 5.

Rob
