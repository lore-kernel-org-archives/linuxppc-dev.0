Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C445FC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 14:35:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 195B52063F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 14:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195B52063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bll26bxqzDr3T
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 01:35:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.175; helo=mail-oi1-f175.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43blfl35yVzDr2w
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2019 01:31:27 +1100 (AEDT)
Received: by mail-oi1-f175.google.com with SMTP id j21so12315415oii.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 06:31:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fVy93fNR+ZKX3Oyx2564C6JZXIF8X9/cPZx9J8v4si4=;
 b=oJatYVY2hLiXxf0TRZINBuWYx/xhyqso473R9MVfAJe0wa4ifBXta7k/mGyoIpM1mT
 +u2TLllNQLzHpfctXQ5a914oyFhEZpgLfe03e0d9vTPdrM0Udoei4W8fZxSfnZvisQYB
 DfvWK5afnrg9e20eqA2mSR/Wp/0AgwWq1odtdDE52F9ueXCnsnmI4p8P9AnTBnis2Tq5
 Mpy9M1KpqyvsNR4tN7R6FQR2v+IGXhE8xdI4hxhPGWAdlTIse3e77qr4S1Ylj2FqnJ1X
 OMnQY2zb/QYXVqvWbrZyEa/j06UBJgAXko1TsRqYbsQVk61w1/NnOC+BccCalH1TprP6
 RluA==
X-Gm-Message-State: AJcUukcjDhyoUB+3PgFQCKYEiw3USDVMoBeVJPyLt7uwVfEBJODWv3Po
 BNehUPtaAieaxfemukkCGA==
X-Google-Smtp-Source: ALg8bN4WsQm0l3CE4srtcBiKuMuAevRTcBgPlfPUqntmq9IuC1T6tqgtGT5vBulJsp2Blm2mGs2dsg==
X-Received: by 2002:aca:bf06:: with SMTP id p6mr8778071oif.269.1547217084941; 
 Fri, 11 Jan 2019 06:31:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id x9sm32990078otq.73.2019.01.11.06.31.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 06:31:24 -0800 (PST)
Date: Fri, 11 Jan 2019 08:31:23 -0600
From: Rob Herring <robh@kernel.org>
To: Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv4 1/4] dt-bindings: add DT binding for the layerscape
 PCIe controller with EP mode
Message-ID: <20190111143123.GA6960@bogus>
References: <20190108030922.24031-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108030922.24031-1-xiaowei.bao@nxp.com>
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

On Tue,  8 Jan 2019 11:09:19 +0800, Xiaowei Bao wrote:
> Add the documentation for the Device Tree binding for the layerscape PCIe
> controller with EP mode.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
> v2:
>  - Add the SoC specific compatibles.
> v3:
>  - modify the commit message.
> v4:
>  - no change.
> 
>  .../devicetree/bindings/pci/layerscape-pci.txt     |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
