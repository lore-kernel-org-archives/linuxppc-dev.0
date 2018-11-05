Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1880C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 22:19:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 694E12085A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 22:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694E12085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pnCV265LzF36V
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 09:19:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.180; helo=mail-oi1-f180.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pn9R3S84zF1gJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 09:17:31 +1100 (AEDT)
Received: by mail-oi1-f180.google.com with SMTP id v198-v6so9013243oif.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 14:17:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6LoVs/lvXd/sw+h/f73B4xZvJb0JTqol5x8Q4JQgo9A=;
 b=cR7uhF3AeJ7E4691YwKDhskrCZwBRvxQ18qJoAOB6qdP7UwBRMfEwNtON1O/0HZojn
 uHrdqxyZn7NqMhaBqdU0tb1d+bjXcbhtUvVOPuvcEihaJdggNIZ2g92/wPudJsSiOg8e
 ImJ4X5pmf/jHEPitptXczycCNEYpXoffCF5yYNvId0Pp3/GaL4BpG5e286yf7Y0rtu/g
 mACB5RNZ8HNoK4ZVid1ryFpqeA8DXajsNGkQjcQWy17p5AbucN9G+dm1Jk5/88gJooRV
 g1meX5N9EMWESM4yu9VCJVDZdjAcfB+K4fP3O+8C67HE1YYCQSnCi5fcEe1VISqVlb53
 NtlQ==
X-Gm-Message-State: AGRZ1gJcFSbiYcYasKjiGEHzN8pG+mqicnwWm2m8A8VEAwMmQ6OtfXfM
 klCjzdxCpNihQ4B4vkNW+g==
X-Google-Smtp-Source: AJdET5db8FgQZa0KQyf96olLWNhAcBxluU4X4EDgVEnvKg9lHa7KT4GmaopMYVws27hM0brwiY64Cg==
X-Received: by 2002:aca:c41:: with SMTP id i1-v6mr5476786oiy.272.1541456248928; 
 Mon, 05 Nov 2018 14:17:28 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id t38sm4809275otf.29.2018.11.05.14.17.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 05 Nov 2018 14:17:28 -0800 (PST)
Date: Mon, 5 Nov 2018 16:17:27 -0600
From: Rob Herring <robh@kernel.org>
To: Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv2 3/6] PCI: layerscape: Add the EP mode support
Message-ID: <20181105221727.GA7729@bogus>
References: <20181105084653.26597-1-xiaowei.bao@nxp.com>
 <20181105084653.26597-3-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105084653.26597-3-xiaowei.bao@nxp.com>
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
Cc: mark.rutland@arm.com, kstewart@linuxfoundation.org,
 linux-pci@vger.kernel.org, shawn.lin@rock-chips.com, minghuan.Lian@nxp.com,
 lorenzo.pieralisi@arm.com, kishon@ti.com, mingkai.hu@nxp.com,
 niklas.cassel@axis.com, devicetree@vger.kernel.org, arnd@arndb.de,
 linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
 cyrille.pitchen@free-electrons.com, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org, roy.zang@nxp.com,
 Xiaowei Bao <xiaowei.bao@nxp.com>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, pombredanne@nexb.com,
 shawnguo@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon,  5 Nov 2018 16:46:50 +0800, Xiaowei Bao wrote:
> Add the EP mode support.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
> v2:
>  - Add the SoC specific compatibles.
> 
>  .../devicetree/bindings/pci/layerscape-pci.txt     |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
