Return-Path: <SRS0=n4ep=DX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2EFC433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2020 19:12:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF79E207C4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2020 19:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF79E207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCbPC0Z6pzDqVP
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2020 06:11:59 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCb0q4ZdqzDqMg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2020 05:54:19 +1100 (AEDT)
Received: by mail-oo1-f68.google.com with SMTP id v123so857258ooa.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2020 11:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rJzbPAxzg6ilw2UkQ6tAV4yqkzoyoHPXjWkUniuz3xs=;
 b=jVhf28BUwRCsHBkPI4K7JYu8OY2ODSAugSIDFOs05rgnRxTVoR3I+tw9qfnTR4S0WC
 RqEFLbCeVSLzDr2UO27E/PsDaoXzC/orpDvbtOwrVVYj6mBvcEb6rfPDvklFivV+l6iB
 aKq48Shq3Utpcvhzq2xiO4z0qU2zHTk76WBl+SbWAprN6eh/RHSWW+LxCNwBWNejGUXI
 mO+LsgtzPdmwn79OVK2eXao1B5R91cOtT82dMRsqx6m5Cnas5dYtX3qM13Vft8SeHLw7
 XzEl3dS1E3DOtsoE0ujfLN9HoO/LyByxN2SsZYkXei7tDRaF+5rqYl820BJC0SRnmAyP
 JU2w==
X-Gm-Message-State: AOAM532umpYWpBKc2om/LDSp0NxjJZHuOJl/MytIjEHx7awLW/mCQqAg
 mcDD1R2vJuzP33d1f0sUAA==
X-Google-Smtp-Source: ABdhPJxHQw8SwIo5pxcTDGGAB6KVAXfb74xhoP1dlxCV0EYXTwri1nV7bGwspN7IGCzr6tBvWECjQQ==
X-Received: by 2002:a4a:be14:: with SMTP id l20mr3781868oop.27.1602874457029; 
 Fri, 16 Oct 2020 11:54:17 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 15sm1393723ooy.36.2020.10.16.11.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 11:54:16 -0700 (PDT)
Received: (nullmailer pid 1739428 invoked by uid 1000);
 Fri, 16 Oct 2020 18:54:15 -0000
Date: Fri, 16 Oct 2020 13:54:15 -0500
From: Rob Herring <robh@kernel.org>
To: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH 13/20] dt-bindings: usb: dwc3: Add Frame Length Adj
 restrictions
Message-ID: <20201016185415.GA1739379@bogus>
References: <20201014101402.18271-1-Sergey.Semin@baikalelectronics.ru>
 <20201014101402.18271-14-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014101402.18271-14-Sergey.Semin@baikalelectronics.ru>
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
Cc: Neil Armstrong <narmstrong@baylibre.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
 Kevin Hilman <khilman@baylibre.com>, Andy Gross <agross@kernel.org>,
 linux-snps-arc@lists.infradead.org, devicetree@vger.kernel.org,
 Mathias Nyman <mathias.nyman@intel.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
 Serge Semin <fancer.lancer@gmail.com>, linux-kernel@vger.kernel.org,
 Manu Gautam <mgautam@codeaurora.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 14 Oct 2020 13:13:55 +0300, Serge Semin wrote:
> In accordance with the IP core databook the
> snps,quirk-frame-length-adjustment property can be set within [0, 0x3F].
> Let's make sure the DT schema applies a correct restriction on the
> property.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
