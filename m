Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BE5C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 16:54:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4879C2087D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 16:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4879C2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VgDK0B82zF1PT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 03:54:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=will.deacon@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42Vg8Y5GJfzF2Dv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 03:50:53 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 944C9ED1;
 Wed, 10 Oct 2018 09:50:49 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6540E3F5B3;
 Wed, 10 Oct 2018 09:50:49 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 2685E1AE088A; Wed, 10 Oct 2018 17:50:49 +0100 (BST)
Date: Wed, 10 Oct 2018 17:50:49 +0100
From: Will Deacon <will.deacon@arm.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 13/36] dt-bindings: arm: Convert PMU binding to json-schema
Message-ID: <20181010165048.GB16512@arm.com>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-14-robh@kernel.org>
 <20181009115713.GE6248@arm.com>
 <CAL_JsqLeG3WUa2peOWFGUoMuonWaWJoU-7A6d8cqXp-_e3B3XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLeG3WUa2peOWFGUoMuonWaWJoU-7A6d8cqXp-_e3B3XA@mail.gmail.com>
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
 Frank Rowand <frowand.list@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jonathan Cameron <jic23@kernel.org>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 09, 2018 at 01:14:02PM -0500, Rob Herring wrote:
> On Tue, Oct 9, 2018 at 6:57 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > Hi Rob,
> >
> > On Fri, Oct 05, 2018 at 11:58:25AM -0500, Rob Herring wrote:
> > > Convert ARM PMU binding to DT schema format using json-schema.
> > >
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/arm/pmu.txt | 70 --------------
> > >  .../devicetree/bindings/arm/pmu.yaml          | 96 +++++++++++++++++++
> > >  2 files changed, 96 insertions(+), 70 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/arm/pmu.txt
> > >  create mode 100644 Documentation/devicetree/bindings/arm/pmu.yaml
> >
> > [...]
> >
> > > -- interrupts : 1 combined interrupt or 1 per core. If the interrupt is a per-cpu
> > > -               interrupt (PPI) then 1 interrupt should be specified.
> >
> > [...]
> >
> > > +  interrupts:
> > > +    oneOf:
> > > +      - maxItems: 1
> > > +      - minItems: 2
> > > +        maxItems: 8
> > > +        description: 1 interrupt per core.
> > > +
> > > +  interrupts-extended:
> > > +    $ref: '#/properties/interrupts'
> >
> > This seems like a semantic different between the two representations, or am
> > I missing something here? Specifically, both the introduction of
> > interrupts-extended and also dropping any mention of using a single per-cpu
> > interrupt (the single combined case is no longer support by Linux; not sure
> > if you want to keep it in the binding).
> 
> 'interrupts-extended' was implied before as it is always supported and
> outside the scope of the binding. But now it is needed to validate
> bindings. There must be some use of it and that's why I added it.
> However, thinking some more about this, I think it may be better to
> have the tools add this in automatically whenever we have an
> interrupts property.

To be honest, if you'd included that in the commit message I'd have been
happy :)

> I guess the single interrupt case is less obvious now with no
> description (it's the first list item of 'oneOf'). The schema If the
> single interrupt is not supported, then we can drop it here.

Well the description says "1 interrupt per core" which is incorrect. I also
don't understand why maxItems is 8.

Will
