Return-Path: <SRS0=Si2p=DV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9198EC433E7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2020 20:20:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7591B2222C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2020 20:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7591B2222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CBP0Y4pFKzDqwC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2020 07:19:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.218.68; helo=mail-ej1-f68.google.com;
 envelope-from=k.kozlowski.k@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CBNyr07lbzDqQx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2020 07:18:26 +1100 (AEDT)
Received: by mail-ej1-f68.google.com with SMTP id qp15so366265ejb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2020 13:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0MyUw0Y3gJD9KhX/3YhqYIS6k+1q8f/JNR3G4Oc+mO0=;
 b=Gs3ULYV/XNVwoFHLwo5HnE1eGbahQzl1vCBlXegN4ZkA1VB8idfCvkkR/RuCFXNWvn
 g2WCSfyKvuh3i5Ftn7Woom/f/Zze/6IAny8Kof0bTEV2Vl+GWml90rGtTneoqYU2WIU/
 ZkaB5pWRufR4Qcf7T8LFbeQKNmZHoa1LL4npk5mNZRFv3I1RFdXoFhGrY4hm7exCSgGX
 db4asEvM+U5e30kOcBA7VG0PiyOe1mkc0gFObEhbmsRRlN+RtyDI5UadONLJHex0hJbp
 fwIWKFRUe6WdlchRV/+ZUqOkmP7qi+a3VrmDFK1wV3axNpvl3MtIyYWXDLs7vEeJ0rA8
 BoHQ==
X-Gm-Message-State: AOAM531RdWb1Ti8bm0lbYTAb/JyyxrQBCNAhdIl6ciJ5D78d5ueHgnye
 KRfpcpwh54jI2drmaxLFtFY=
X-Google-Smtp-Source: ABdhPJyD9mvSdzTeswKoJSSkNRNYZJV/A491oP4RLt7gITN4T+XTScFWRX+EpK8W5zlRYXEzJ8uEig==
X-Received: by 2002:a17:906:1e45:: with SMTP id
 i5mr798232ejj.203.1602706702595; 
 Wed, 14 Oct 2020 13:18:22 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
 by smtp.googlemail.com with ESMTPSA id i18sm222556ejr.59.2020.10.14.13.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 13:18:21 -0700 (PDT)
Date: Wed, 14 Oct 2020 22:18:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH 11/20] dt-bindings: usb: dwc3: Add synopsys,dwc3
 compatible string
Message-ID: <20201014201818.GA6926@kozik-lap>
References: <20201014101402.18271-1-Sergey.Semin@baikalelectronics.ru>
 <20201014101402.18271-12-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201014101402.18271-12-Sergey.Semin@baikalelectronics.ru>
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
 Kevin Hilman <khilman@baylibre.com>, Andy Gross <agross@kernel.org>,
 linux-snps-arc@lists.infradead.org, devicetree@vger.kernel.org,
 Mathias Nyman <mathias.nyman@intel.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
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

On Wed, Oct 14, 2020 at 01:13:53PM +0300, Serge Semin wrote:
> The DWC USB3 driver and some DTS files like Exynos 5250, Keystone k2e, etc
> expects the DWC USB3 DT node to have the compatible string with the
> "synopsys" vendor prefix. Let's add the corresponding compatible string to
> the controller DT schema, but mark it as deprecated seeing the Synopsys,
> Inc. is presented with just "snps" vendor prefix.

Instead of adding deprecated schema just correct the DTSes to use snps.
The "synopsys" is not even in vendor prefixes.

Best regards,
Krzysztof
