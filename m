Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEA6C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 22:29:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DEEB2082F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 22:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DEEB2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DHn41PNbzDqhD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 09:29:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.51; helo=mail-ot1-f51.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DHkg2jY3zDqgX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 09:27:23 +1100 (AEDT)
Received: by mail-ot1-f51.google.com with SMTP id t5so12122946otk.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 14:27:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NvRhIVVhr/cozyJX9RAjS/CB+7fBgUA/l3WWhv0euSk=;
 b=dEQGJG1KRswSl/P6oLU2T4mrH7otEFHQthhFZE6r64kH4zU7/PdHEXa5PjuF5d+FWo
 DJE9CCYykAizcBJKf8AoSPqgHOXPTfPJJtcs7V07MejTAxvALEZYdK8GY3mHB9xmmuMD
 mWPt2ya+fLNvZt4k/N4R8usSYaFcJ+QWmYpL+8VmP6iSWz+BPMzXRm2Dlho/3WMBF5na
 9bejwCz8uDkJyo3OdURQSYyntmhE215rLLAjxl8qct2IwEGuYWS+cmCmO6NTct1L8/0k
 3p87RtgKaFQco0lmiNuWc4OfneVo8/xbPQctKBbch+qXJZprRVuA8r7gdS5Q51gUaHlH
 gNxQ==
X-Gm-Message-State: AA+aEWaR/OXNUiQD8xxG5tUDi3rIAiIOSxbvuAVrj/76WNc5im90/dZO
 /AVfbQZL0N8i67DAXlhdKA==
X-Google-Smtp-Source: AFSGD/UddJoUUe90aa225QLWVvx6jXXsrkNO0JvtpOE/jl2a4WMPME28Jfk11g9sdE5mSwnpMhleLA==
X-Received: by 2002:a9d:3208:: with SMTP id t8mr9630444otc.312.1544480841066; 
 Mon, 10 Dec 2018 14:27:21 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id s66sm9097817oia.55.2018.12.10.14.27.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 14:27:20 -0800 (PST)
Date: Mon, 10 Dec 2018 16:27:19 -0600
From: Rob Herring <robh@kernel.org>
To: Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv3 1/4] dt-bindings: add DT binding for the layerscape
 PCIe controller with EP mode
Message-ID: <20181210222719.GA6506@bogus>
References: <20181203103505.46885-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203103505.46885-1-xiaowei.bao@nxp.com>
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

On Mon,  3 Dec 2018 18:35:02 +0800, Xiaowei Bao wrote:
> Add the documentation for the Device Tree binding for the layerscape PCIe
> controller with EP mode.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
> v2:
>  - Add the SoC specific compatibles.
> v3:
>  - modify the commit message.
> 
>  .../devicetree/bindings/pci/layerscape-pci.txt     |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
