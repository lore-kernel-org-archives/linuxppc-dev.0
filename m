Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D07EC46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 21:54:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F1120834
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 21:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F1120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42h1BD6PhXzF3CN
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 08:54:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.195; helo=mail-oi1-f195.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42h1822Q0vzF3Cm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 08:52:50 +1100 (AEDT)
Received: by mail-oi1-f195.google.com with SMTP id p125-v6so8060677oic.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 14:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=iqbQl5ihR/SM/+0e/deIgeI7mi+Rh+Z/cWXJhlKJTSk=;
 b=kFkimEcN9UAOuXoSK3FLK54VK1h42HoeQmHpVduCYGMqQ+oIpX5w462S3gfoUFqq2z
 2Edk/5zT+HgLlj5qlgBeKv7eSHy5jh756k4GYQrOHNWE9YDioaZ0WEA4IAmZwZj2ucTJ
 7J5m6KSOL5Tf5s76BJGp9AdLhDo4zJdGdOz+AyEOEf4J5XCgNmMCQRt656hbJ7uM5nRS
 faqMISzB1twb7sdKsTxcmoNMiQG6QKGp8XTjcIP9dEe7Wc1roR26BxqPh0bY9TJVim63
 AXyytly3QZrC1pFYtVpJJznFsTZMoD2PwVFYgA2uQnvLk+vJqlti/Y92orTmIjfVQh0D
 SHaA==
X-Gm-Message-State: AGRZ1gLnsrsasVBq2mHLuhWaZb+TojN+tFoMm4j1mlP69MjMiZVoOgoE
 ElqqyB49ptnT/9JjShBdwQ==
X-Google-Smtp-Source: AJdET5e/v/ewadxX7/s7dgp0flO1DICwZqrullxD2vkDwAhBG75EfP6NMelbZSwQqcD9Ihicu10SvQ==
X-Received: by 2002:aca:a6d1:: with SMTP id
 t78-v6mr598067oij.341.1540504367881; 
 Thu, 25 Oct 2018 14:52:47 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id n63-v6sm2822805oia.52.2018.10.25.14.52.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 25 Oct 2018 14:52:47 -0700 (PDT)
Date: Thu, 25 Oct 2018 16:52:46 -0500
From: Rob Herring <robh@kernel.org>
To: Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCH 3/6] PCI: layerscape: Add the EP mode support
Message-ID: <20181025215246.GA14861@bogus>
References: <20181025110901.5680-1-xiaowei.bao@nxp.com>
 <20181025110901.5680-3-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025110901.5680-3-xiaowei.bao@nxp.com>
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
Cc: mark.rutland@arm.com, roy.zang@nxp.com, lorenzo.pieralisi@arm.com,
 arnd@arndb.de, devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 kstewart@linuxfoundation.org, niklas.cassel@axis.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com,
 minghuan.Lian@nxp.com, cyrille.pitchen@free-electrons.com,
 linux-arm-kernel@lists.infradead.org, pombredanne@nexb.com,
 bhelgaas@google.com, leoyang.li@nxp.com, shawnguo@kernel.org,
 shawn.lin@rock-chips.com, mingkai.hu@nxp.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 25, 2018 at 07:08:58PM +0800, Xiaowei Bao wrote:
> Add the EP mode support.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
>  .../devicetree/bindings/pci/layerscape-pci.txt     |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index 66df1e8..d3d7be1 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -13,12 +13,15 @@ information.
>  
>  Required properties:
>  - compatible: should contain the platform identifier such as:
> +  RC mode:
>          "fsl,ls1021a-pcie", "snps,dw-pcie"
>          "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
>          "fsl,ls2088a-pcie"
>          "fsl,ls1088a-pcie"
>          "fsl,ls1046a-pcie"
>          "fsl,ls1012a-pcie"
> +  EP mode:
> +        "fsl,ls-pcie-ep"

You need SoC specific compatibles for the same reasons as the RC.

Rob
