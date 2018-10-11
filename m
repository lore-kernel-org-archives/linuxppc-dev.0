Return-Path: <SRS0=4kvs=MX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C278FC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 22:11:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165B920841
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 22:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165B920841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42WQCk2VV5zF3HX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 09:11:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.194; helo=mail-oi1-f194.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42WQ8y0WJkzF3HF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 09:08:49 +1100 (AEDT)
Received: by mail-oi1-f194.google.com with SMTP id 22-v6so8370534oiz.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 15:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=m72Rob7hQ1jxDb7gzj9zWe1slNizevBswPot9YrW/+k=;
 b=HwGILYFt7rgwmtgeszfg+d373OtPKKd2imtEPXUPDXTdtiWjeSNJwL+Ge9rRSMs+j5
 N7Nx+bkUfKtqxUpC9jerTgtZ8C8tRswA1BG0Qj5KRaF9CQz6jcfrIX4/G8E4grC7dXyR
 i1yhWxEUSl6RZd0zprifGo+YC2wQ/EiYfoHLMDpZscof9nAMEvDPyx7N5QW/3uLlsH0x
 +KueAHbvyhROyGH7gOvSfI62KJukfGLRROcWtNHIaOLr6lwS4O8ZhQHVlu5qxVs0l/bD
 nHHaUpOmgInn0MiJW9105oIaQ0tX7q2BwwH1YwnvtBbLthYDCXQVmrvx3gF+a2Hevkb7
 xFJA==
X-Gm-Message-State: ABuFfogb54U0aluWwep664wdL6GRebdaZV64oUigZDj9kyliP46BDyLz
 uKwZcYp7U6AOsW4eO+WMaQ==
X-Google-Smtp-Source: ACcGV633kPp3nAmcXYeHZYP+47k0XzXlubmqCeVmA66VWRERcUZF/Nh/osGVG0J7LDCaLJ9nDnX9fQ==
X-Received: by 2002:aca:6c3:: with SMTP id
 186-v6mr1995312oig.158.1539295727146; 
 Thu, 11 Oct 2018 15:08:47 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id x15sm9699437oth.24.2018.10.11.15.08.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 11 Oct 2018 15:08:46 -0700 (PDT)
Date: Thu, 11 Oct 2018 17:08:45 -0500
From: Rob Herring <robh@kernel.org>
To: Peng Ma <peng.ma@nxp.com>
Subject: Re: [PATCH 7/7] dt-bindings: fsl-qdma: Add NXP Layerscpae qDMA
 controller bindings
Message-ID: <20181011220845.GA20860@bogus>
References: <20181011094655.45707-1-peng.ma@nxp.com>
 <20181011094655.45707-7-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011094655.45707-7-peng.ma@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 leoyang.li@nxp.com, zw@zh-kernel.org, vkoul@kernel.org,
 dmaengine@vger.kernel.org, dan.j.williams@intel.com, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 11, 2018 at 05:46:55PM +0800, Peng Ma wrote:
> Document the devicetree bindings for NXP Layerscape qDMA controller
> which could be found on NXP QorIQ Layerscape SoCs.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>

What happened to the version from Wen He that was on v7 and that I 
already gave my Reviewed-by on?

> ---
>  Documentation/devicetree/bindings/dma/fsl-qdma.txt |   53 ++++++++++++++++++++
>  1 files changed, 53 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/fsl-qdma.txt

