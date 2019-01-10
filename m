Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7821DC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 06:44:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B625B214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 06:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEC0+MYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B625B214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZxLj2znSzDqdv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 17:44:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=shawnguo@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="VEC0+MYi"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ZxJw2Kv3zDqR0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 17:43:11 +1100 (AEDT)
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6D3C8214DA;
 Thu, 10 Jan 2019 06:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547102589;
 bh=RVtjTyJLKGFZRuEyHVwDNC25dNgB7DPh3M6yv0AsL0M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VEC0+MYihO2xcOYklPJZ2ZAwMQn9gHz1qI2dN5IOd0aminomj7v2FH99hb7vho2jG
 h4Xz5yD8faC9jCETbZfSQUGFeU47X5slJpmp2VP2GPaVkDUWJE19ohXjEKa3Mu22aF
 Ibw5h3xxK5g2mBet7l395qed6BpaYq3WfkIZ50L0=
Date: Thu, 10 Jan 2019 14:42:57 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 18/34] dt-bindings: arm: Convert FSL board/soc
 bindings to json-schema
Message-ID: <20190110064256.GA25218@dragon>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-19-robh@kernel.org>
 <20181206023140.GZ3987@dragon>
 <CAL_JsqK5nBdk-MiuTPMxr9oXqXnLqeMU3vtZi6AnT9V35_W55A@mail.gmail.com>
 <20181208015835.GM3987@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208015835.GM3987@dragon>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <grant.likely@arm.com>,
 Sean Hudson <darknighte@darknighte.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 ARM-SoC Maintainers <arm@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Dec 08, 2018 at 09:58:37AM +0800, Shawn Guo wrote:
> On Thu, Dec 06, 2018 at 05:33:13PM -0600, Rob Herring wrote:
> > On Wed, Dec 5, 2018 at 8:32 PM Shawn Guo <shawnguo@kernel.org> wrote:
> > >
> > > On Mon, Dec 03, 2018 at 03:32:07PM -0600, Rob Herring wrote:
> > > > Convert Freescale SoC bindings to DT schema format using json-schema.
> > > >
> > > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: devicetree@vger.kernel.org
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  .../devicetree/bindings/arm/armadeus.txt      |   6 -
> > > >  Documentation/devicetree/bindings/arm/bhf.txt |   6 -
> > > >  .../bindings/arm/compulab-boards.txt          |  25 --
> > > >  Documentation/devicetree/bindings/arm/fsl.txt | 229 ------------------
> > > >  .../devicetree/bindings/arm/fsl.yaml          | 214 ++++++++++++++++
> > >
> > > Rob,
> > >
> > > I do have any changes on bindings/arm/fsl.txt queued for 4.21 on my
> > > tree, so please send it via your tree.
> > 
> > What about:
> > 
> > c386f362957b dt-bindings: Add compatible string for LS1028A-QDS
> > 3671cd57de06 dt-bindings: ls1012a: Add FRWY-LS1012A device tree binding
> 
> Ah, sorry, I only checked on imx/dt branch and forgot imx/dt64.  I will
> drop the changes on fsl.txt and update fsl.yaml after it hits mainline.

What happened to this?  It seems the patch did not hit v5.0-rc1.

Shawn
