Return-Path: <SRS0=zuPs=OR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273C7C07E85
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 02:01:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3472220868
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 02:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hq+LB5HR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3472220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BXdV0p89zF09T
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 13:01:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hq+LB5HR";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=shawnguo@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="hq+LB5HR"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43BXZg6tr1zDvrJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 12:59:23 +1100 (AEDT)
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 24A4120868;
 Sat,  8 Dec 2018 01:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544234361;
 bh=3ww473EUpiQ8Yk4SLFmXFffC7WSJZKms8gyXDBI3jkM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hq+LB5HRgreQXXjD3feH96P6iHCjOFajJi/mi+isJsKaf0mmF8lsogPERyTW4Pbof
 CRLQsbZY+m47bLTw3cdqwuPmKguNQH3w0Psz4H374kVnpOWADbMAU11UpCwMqpsLeb
 fw0L6qMZHFpZ0E1m87/ICl/4f90MiVA8Dx2PC7Jc=
Date: Sat, 8 Dec 2018 09:58:37 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 18/34] dt-bindings: arm: Convert FSL board/soc
 bindings to json-schema
Message-ID: <20181208015835.GM3987@dragon>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-19-robh@kernel.org>
 <20181206023140.GZ3987@dragon>
 <CAL_JsqK5nBdk-MiuTPMxr9oXqXnLqeMU3vtZi6AnT9V35_W55A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqK5nBdk-MiuTPMxr9oXqXnLqeMU3vtZi6AnT9V35_W55A@mail.gmail.com>
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
 Kumar Gala <kumar.gala@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Grant Likely <grant.likely@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 06, 2018 at 05:33:13PM -0600, Rob Herring wrote:
> On Wed, Dec 5, 2018 at 8:32 PM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Mon, Dec 03, 2018 at 03:32:07PM -0600, Rob Herring wrote:
> > > Convert Freescale SoC bindings to DT schema format using json-schema.
> > >
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../devicetree/bindings/arm/armadeus.txt      |   6 -
> > >  Documentation/devicetree/bindings/arm/bhf.txt |   6 -
> > >  .../bindings/arm/compulab-boards.txt          |  25 --
> > >  Documentation/devicetree/bindings/arm/fsl.txt | 229 ------------------
> > >  .../devicetree/bindings/arm/fsl.yaml          | 214 ++++++++++++++++
> >
> > Rob,
> >
> > I do have any changes on bindings/arm/fsl.txt queued for 4.21 on my
> > tree, so please send it via your tree.
> 
> What about:
> 
> c386f362957b dt-bindings: Add compatible string for LS1028A-QDS
> 3671cd57de06 dt-bindings: ls1012a: Add FRWY-LS1012A device tree binding

Ah, sorry, I only checked on imx/dt branch and forgot imx/dt64.  I will
drop the changes on fsl.txt and update fsl.yaml after it hits mainline.

Shawn
