Return-Path: <SRS0=n4ep=DX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4BFC433E7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2020 19:01:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8947206ED
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2020 19:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8947206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCb8b2zwPzDqKh
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2020 06:01:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.210.65; helo=mail-ot1-f65.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCZw34BRmzDqLZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2020 05:50:11 +1100 (AEDT)
Received: by mail-ot1-f65.google.com with SMTP id 32so3387156otm.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2020 11:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tsEFGFDEJB33aFAr/ryJhZmR4NK4qeJppeYiZlNUE6k=;
 b=UXEdDn8+3yR4VyqdMJMuATkoVgMMrjT6zaaN5cJNV7dXNEG9eS92zBOFOzoUbg6knl
 7jlQBqGeLR6xOohJj8QlWh7K+IgxRrSV3XUv/lspHPNSi5udHl0IZ6HrzCutXzEDbVQj
 LZhrM/BvF4E/qDwEYtKGUq/VNG/n/o9kCXLEFq7t4eP5mdblqkTwlsvSFE9PhkOS2iw/
 shjxk5LNjrmXC5ySzZhReJLmVgMRgBmqGTFSh6NQhOouxwCR6/lrdfoVN4drgKCEqsi0
 fWKviBX1DgTOX9AqaltPzpQ+18e47jUv8a+DzizZIgphesfQIY6gOjgUZvqdadpwO7bY
 btGg==
X-Gm-Message-State: AOAM533myqjfIwoOdBGFKphFGrYMduFr5r4OSIFJ0pZ9mZWtH50Dv5pY
 3h7dH5zuZLoVZMy8lP6JmA==
X-Google-Smtp-Source: ABdhPJwf1V8jGj40xsK56aM87EAIEjSM8YWRrCdA3QZNoYzUf4866Tswq3wAkcC4d06N05OwEMwF9Q==
X-Received: by 2002:a9d:6c16:: with SMTP id f22mr3379029otq.173.1602874209610; 
 Fri, 16 Oct 2020 11:50:09 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id l138sm1260817oih.32.2020.10.16.11.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 11:50:09 -0700 (PDT)
Received: (nullmailer pid 1733506 invoked by uid 1000);
 Fri, 16 Oct 2020 18:50:07 -0000
Date: Fri, 16 Oct 2020 13:50:07 -0500
From: Rob Herring <robh@kernel.org>
To: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH 08/20] dt-bindings: usb: renesas-xhci: Refer to the
 usb-xhci.yaml file
Message-ID: <20201016185007.GA1733460@bogus>
References: <20201014101402.18271-1-Sergey.Semin@baikalelectronics.ru>
 <20201014101402.18271-9-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014101402.18271-9-Sergey.Semin@baikalelectronics.ru>
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

On Wed, 14 Oct 2020 13:13:50 +0300, Serge Semin wrote:
> With minor peculiarities (like uploading some vendor-specific firmware)
> these are just Generic xHCI controllers fully compatible with its
> properties. Make sure the Renesas USB xHCI DT nodes are also validated
> against the Generic xHCI DT schema.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
