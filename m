Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6172DC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 12:44:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A404320850
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 12:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A404320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437l6l3tBBzDqGT
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 23:43:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=will.deacon@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 437l2q64kSzDqRd
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Dec 2018 23:40:34 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B4231688;
 Mon,  3 Dec 2018 04:40:32 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 655A03F614;
 Mon,  3 Dec 2018 04:40:32 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 538511AE1062; Mon,  3 Dec 2018 12:40:52 +0000 (GMT)
Date: Mon, 3 Dec 2018 12:40:52 +0000
From: Will Deacon <will.deacon@arm.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 12/36] dt-bindings: arm: Convert cpu binding to json-schema
Message-ID: <20181203124039.GA25097@arm.com>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-13-robh@kernel.org>
 <035ae23f-3c92-ffd9-0753-abbd604c5c02@xilinx.com>
 <CAL_JsqJJkcbxvfbVVOTPb5gavPgypO-Cd05C6qpvbvPMd1G81g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJJkcbxvfbVVOTPb5gavPgypO-Cd05C6qpvbvPMd1G81g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, Tom Rini <trini@konsulko.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michal Simek <michal.simek@xilinx.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jonathan Cameron <jic23@kernel.org>,
 Olof Johansson <olof@lixom.net>, linux-mediatek@lists.infradead.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 30, 2018 at 12:00:05PM -0600, Rob Herring wrote:
> On Thu, Nov 8, 2018 at 2:49 AM Michal Simek <michal.simek@xilinx.com> wrote:
> >
> > Hi Rob,
> >
> > On 05. 10. 18 18:58, Rob Herring wrote:
> > > Convert ARM CPU binding to DT schema format using json-schema.
> > >
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-mediatek@lists.infradead.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../devicetree/bindings/arm/cpus.txt          | 490 -----------------
> > >  .../devicetree/bindings/arm/cpus.yaml         | 503 ++++++++++++++++++
> > >  2 files changed, 503 insertions(+), 490 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/arm/cpus.txt
> > >  create mode 100644 Documentation/devicetree/bindings/arm/cpus.yaml
> 
> [...]
> 
> > I have take a look at xilinx part of this and try to build it for arm64
> > platforms and I see errors coming from this cpu description.
> > /root/linux/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml:
> > cpu@0:compatible: ['arm,cortex-a53', 'arm,armv8'] is too long
> > /root/linux/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml:
> > cpu@0:compatible: Additional items are not allowed ('arm,armv8' was
> > unexpected)
> 
> Thanks for actually giving this a spin!
> 
> > Based on grep this is used in a lot of places
> > compatible = "arm,cortex-a53", "arm,armv8";
> >
> > Should this be moved to just simple?
> > compatible = "arm,cortex-a53";
> 
> I'd normally go with the majority which would be to keep it. However,
> 'arm,armv8' is of questionable value, isn't actually documented, and
> doesn't exist for any other version of the architecture. So we should
> kill it IMO.

I'd prefer to keep it around, since that's what's used to describe the CPUs
on the fastmodel iirc.

Will
