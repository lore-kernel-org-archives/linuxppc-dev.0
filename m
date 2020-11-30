Return-Path: <SRS0=CZBu=FE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68122C63777
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Nov 2020 16:40:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77DB6206F9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Nov 2020 16:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DB6206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cl9vq36cnzDqkT
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Dec 2020 03:40:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.166.67; helo=mail-io1-f67.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
 [209.85.166.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cl9sV2jCvzDqWP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2020 03:38:38 +1100 (AEDT)
Received: by mail-io1-f67.google.com with SMTP id o8so12442559ioh.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2020 08:38:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tFYu+zcPVaijJyMJm5EUKsYsvWv061fpjh0clpgn5vA=;
 b=OXtmhuTUtA9BfOWZ3uU+VTEQNnCLEE4CHDFzvD6lFgzN3jGP7rmV49rllVpyWKiP6Z
 R5jB74b0C02FRtLrbvx4P21cmO+G7VHPpoMja2+WtEKGrJUdWqOcy45C+9KzdTIXs5gH
 nXVzz11EuERqQ1pMmo429tXt7xJwV9Ot9Ia0ZUnKY5Ff9Blblnu3BUAXeqm1DDV95cF8
 mWDTN2IB/votqUkYpXUGLqEb9MniK/d/7GYRLl49SksjYh5s0rE1hI7Gfri1CCkvZrFt
 ViC+XNJh8k6Z4yAHD10v7xwqpEo8C1/wLy9mtkMxgvFOMDIBjv6cuGrZ6fRU7Tc7J0VX
 mIKw==
X-Gm-Message-State: AOAM530QRJB+LMhO9aNaq9cJPe4irZSaukymUmkNpqtXQ8WKXESwkPEs
 O7ILoAhGDr7lk+P3jnZcrA==
X-Google-Smtp-Source: ABdhPJwO8/AKHHQtotzeksDXX1wp3u3t+G5jA46XRQZErHhLBCCcrUV6i188c/xtoojwacdGbzMMXA==
X-Received: by 2002:a6b:b514:: with SMTP id e20mr17078716iof.105.1606754313679; 
 Mon, 30 Nov 2020 08:38:33 -0800 (PST)
Received: from xps15 ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id u11sm8273653iol.51.2020.11.30.08.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 08:38:32 -0800 (PST)
Received: (nullmailer pid 2592217 invoked by uid 1000);
 Mon, 30 Nov 2020 16:38:29 -0000
Date: Mon, 30 Nov 2020 09:38:29 -0700
From: Rob Herring <robh@kernel.org>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH v4] dt-bindings: misc: convert fsl,qoriq-mc from txt to
 YAML
Message-ID: <20201130163829.GA2590579@robh.at.kernel.org>
References: <20201123090035.15734-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123090035.15734-1-laurentiu.tudor@nxp.com>
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
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
 leoyang.li@nxp.com, robh+dt@kernel.org, ioana.ciornei@nxp.com,
 Ionut-robert Aron <ionut-robert.aron@nxp.com>, kuba@kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 23 Nov 2020 11:00:35 +0200, Laurentiu Tudor wrote:
> From: Ionut-robert Aron <ionut-robert.aron@nxp.com>
> 
> Convert fsl,qoriq-mc to YAML in order to automate the verification
> process of dts files. In addition, update MAINTAINERS accordingly
> and, while at it, add some missing files.
> 
> Signed-off-by: Ionut-robert Aron <ionut-robert.aron@nxp.com>
> [laurentiu.tudor@nxp.com: update MINTAINERS, updates & fixes in schema]
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
> Changes in v4:
>  - use $ref to point to fsl,qoriq-mc-dpmac binding
> 
> Changes in v3:
>  - dropped duplicated "fsl,qoriq-mc-dpmac" schema and replaced with
>    reference to it
>  - fixed a dt_binding_check warning
> 
> Changes in v2:
>  - fixed errors reported by yamllint
>  - dropped multiple unnecessary quotes
>  - used schema instead of text in description
>  - added constraints on dpmac reg property
> 
>  .../devicetree/bindings/misc/fsl,qoriq-mc.txt | 196 ------------------
>  .../bindings/misc/fsl,qoriq-mc.yaml           | 186 +++++++++++++++++
>  .../ethernet/freescale/dpaa2/overview.rst     |   5 +-
>  MAINTAINERS                                   |   4 +-
>  4 files changed, 193 insertions(+), 198 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
> 

As there's a dependency on fsl,qoriq-mc-dpmac, this needs to go via 
netdev tree.

Reviewed-by: Rob Herring <robh@kernel.org>
