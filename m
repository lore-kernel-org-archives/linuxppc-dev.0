Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3269C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 11:33:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5BC2086A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 11:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5BC2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Wm1f2DsjzDrCm
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 22:33:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42WlzV6cZ8zF3S4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 22:31:50 +1100 (AEDT)
Received: by mail-ot1-f67.google.com with SMTP id u22so12023911ota.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 04:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=BJrWnIuWqsL0GyRzItQea9ay5SebeXreVPtelM0Lj8s=;
 b=r+vOOXswi8uDqvy/f/9QSga0QgQUSdFcvRvH+SrGCaPgZp6zzn2tEuM16avm4wPDT5
 u11wkbt7UWk7Bx/zoPTI1NGSvdMKmCfvks05/g5vknjfki8kUhkK3soM7TV10L5kuZ2A
 K4ytNPsa5jA+kLY6W9CuUN9XmHTLO2si+SX0AFGnajzuLnD8Un1a5IVUCWvYJW52IZ5o
 0Cf63oZm/vVSu6Xy31mVzEf2wkWRqagAR/C08zlbhyUoxBYP/iMhRFUPWO7wYACXGXnq
 Kj3soBSJdFyeZgT7KgQ/iBSvb0zLAGigNxXcrSUQeNjgzzEfe6MIICLrX7cMLiX13DjC
 lESg==
X-Gm-Message-State: ABuFfoibPzIlcIXDQDq8DsIQF8n8HWYeCQjLYZO9QHitldAKQ40U3lbh
 j8jV+t9ww4xZ6bECU+MYyg==
X-Google-Smtp-Source: ACcGV61F9ih45Wa5Y4LO8+oNwKPFzDcRFkm6v60KZI6dwzG3KBHuMSiKUCCbUtIL7N4NeRBPVSb3+w==
X-Received: by 2002:a9d:155b:: with SMTP id z27mr3619890otz.271.1539343908379; 
 Fri, 12 Oct 2018 04:31:48 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id y135-v6sm201994oie.25.2018.10.12.04.31.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 12 Oct 2018 04:31:47 -0700 (PDT)
Date: Fri, 12 Oct 2018 06:31:46 -0500
From: Rob Herring <robh@kernel.org>
To: Peng Ma <peng.ma@nxp.com>
Subject: Re: [PATCH 7/7] dt-bindings: fsl-qdma: Add NXP Layerscpae qDMA
 controller bindings
Message-ID: <20181012113146.GA11432@bogus>
References: <20181011094655.45707-1-peng.ma@nxp.com>
 <20181011094655.45707-7-peng.ma@nxp.com>
 <20181011220845.GA20860@bogus>
 <VI1PR04MB44310889ACCA73AFB29CAEEFEDE20@VI1PR04MB4431.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR04MB44310889ACCA73AFB29CAEEFEDE20@VI1PR04MB4431.eurprd04.prod.outlook.com>
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "zw@zh-kernel.org" <zw@zh-kernel.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, Jiafei Pan <jiafei.pan@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 12, 2018 at 02:25:25AM +0000, Peng Ma wrote:
> Hi Rob,
> 
> > -----Original Message-----
> > From: Rob Herring [mailto:robh@kernel.org]
> > Sent: 2018年10月12日 6:09
> > To: Peng Ma <peng.ma@nxp.com>
> > Cc: vkoul@kernel.org; Leo Li <leoyang.li@nxp.com>; mark.rutland@arm.com;
> > shawnguo@kernel.org; dan.j.williams@intel.com; zw@zh-kernel.org;
> > dmaengine@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH 7/7] dt-bindings: fsl-qdma: Add NXP Layerscpae qDMA
> > controller bindings
> > 
> > On Thu, Oct 11, 2018 at 05:46:55PM +0800, Peng Ma wrote:
> > > Document the devicetree bindings for NXP Layerscape qDMA controller
> > > which could be found on NXP QorIQ Layerscape SoCs.
> > >
> > > Signed-off-by: Peng Ma <peng.ma@nxp.com>
> > 
> > What happened to the version from Wen He that was on v7 and that I already
> > gave my Reviewed-by on?
> 
> [Peng Ma] the dma owner is changed and qdma driver made some changes, so I need send those patch again to review!

That's no reason to make changes or drop the original author. You should 
also indicate this is v9 and provide revision history.

Rob
