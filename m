Return-Path: <SRS0=ax18=7C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69466C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 20:52:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B4C20756
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 20:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B4C20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49S4gf0FfWzDqXJ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2020 06:52:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.166.65; helo=mail-io1-f65.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
 [209.85.166.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49S4dX4lZ7zDqBb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2020 06:50:22 +1000 (AEST)
Received: by mail-io1-f65.google.com with SMTP id k18so4950621ion.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2020 13:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mRSMjgkGeWGBh2qwJHfwL3yydGjx13+/dKpUDO1iMb0=;
 b=g58mE/KBVO0nW6ooD47ETa3WwD6GZelr1vEptpOKZ9qKtFI1MVHMn43+W5NzKyUQPv
 UB4DeBYRsISAdcMS8l3YAn88SvYUVhaoCR5H/Cpa/U5d0tGNKiEGFu/sHo/f9LSAl/VU
 DJ1wL6KjO7biWNh36FzGCPXUmyO7w4l0D6fmsnsORHlFYemQJiB9EdWTv4wVLM9HpKvq
 v0+8V0+rXZVGPeTFeTNK9J1iIFFadJ5qxmlvj3ISVfnU2H7+tURMZuiISQFZQ3SQRcRb
 uGHAQD1cZhDhfmrmws7YFELtuzonfv98X4k4+T0vWDsJtAReiagL10bynkqfyO7eAqRC
 V8UA==
X-Gm-Message-State: AOAM530kdtXAXRWDVjcNTLtyDb2BzuvwYxxOdjAPj1PDsRsZ2GhLcJjO
 9G33bkgwqfT7Lkn9WlkNrw==
X-Google-Smtp-Source: ABdhPJwnwe9ybgq0b3s7dUXq6qN9mChjHs0K0Gg3PfPIRRW3vwKfrh4ExYIFqiRNvifXUYk2fDGxXA==
X-Received: by 2002:a6b:b38a:: with SMTP id c132mr5082996iof.54.1590007819658; 
 Wed, 20 May 2020 13:50:19 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id n22sm748494ioh.46.2020.05.20.13.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 13:50:19 -0700 (PDT)
Received: (nullmailer pid 546373 invoked by uid 1000);
 Wed, 20 May 2020 20:50:17 -0000
Date: Wed, 20 May 2020 14:50:17 -0600
From: Rob Herring <robh@kernel.org>
To: Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCH v6 09/11] PCI: layerscape: Add EP mode support for
 ls1088a and ls2088a
Message-ID: <20200520205017.GA546312@bogus>
References: <20200314033038.24844-1-xiaowei.bao@nxp.com>
 <20200314033038.24844-10-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314033038.24844-10-xiaowei.bao@nxp.com>
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
Cc: devicetree@vger.kernel.org, andrew.murray@arm.com,
 lorenzo.pieralisi@arm.com, jingoohan1@gmail.com, linux-pci@vger.kernel.org,
 Zhiqiang.Hou@nxp.com, linux-kernel@vger.kernel.org, kishon@ti.com,
 Minghuan.Lian@nxp.com, robh+dt@kernel.org, mingkai.hu@nxp.com,
 gustavo.pimentel@synopsys.com, bhelgaas@google.com, shawnguo@kernel.org,
 roy.zang@nxp.com, linuxppc-dev@lists.ozlabs.org, leoyang.li@nxp.com,
 linux-arm-kernel@lists.infradead.org, amurray@thegoodpenguin.co.uk
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 14 Mar 2020 11:30:36 +0800, Xiaowei Bao wrote:
> Add PCIe EP mode support for ls1088a and ls2088a, there are some
> difference between LS1 and LS2 platform, so refactor the code of
> the EP driver.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
> v2:
>  - This is a new patch for supporting the ls1088a and ls2088a platform.
> v3:
>  - Adjust the some struct assignment order in probe function.
> v4:
>  - No change.
> v5:
>  - No change.
> v6:
>  - No change.
> 
>  drivers/pci/controller/dwc/pci-layerscape-ep.c | 72 +++++++++++++++++++-------
>  1 file changed, 53 insertions(+), 19 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
