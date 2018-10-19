Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F43ECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 10:37:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043DD214AB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 10:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043DD214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42c2Rj746tzF3Tc
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 21:37:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=will.deacon@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42c2NW6YDhzF3bL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 21:34:50 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B11B180D;
 Fri, 19 Oct 2018 03:34:48 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 805603F71D;
 Fri, 19 Oct 2018 03:34:48 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 8599C1AE06EF; Fri, 19 Oct 2018 11:34:51 +0100 (BST)
Date: Fri, 19 Oct 2018 11:34:51 +0100
From: Will Deacon <will.deacon@arm.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 13/36] dt-bindings: arm: Convert PMU binding to json-schema
Message-ID: <20181019103451.GB14246@arm.com>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-14-robh@kernel.org>
 <20181009115713.GE6248@arm.com>
 <CAL_JsqLeG3WUa2peOWFGUoMuonWaWJoU-7A6d8cqXp-_e3B3XA@mail.gmail.com>
 <20181010165048.GB16512@arm.com>
 <CAL_Jsq+NExxsksmhA6z5_eTutVkm_NFthayvHz-vvq1gkSeXNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+NExxsksmhA6z5_eTutVkm_NFthayvHz-vvq1gkSeXNA@mail.gmail.com>
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

Hi Rob,

On Wed, Oct 10, 2018 at 01:51:24PM -0500, Rob Herring wrote:
> On Wed, Oct 10, 2018 at 11:50 AM Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Oct 09, 2018 at 01:14:02PM -0500, Rob Herring wrote:
> > > I guess the single interrupt case is less obvious now with no
> > > description (it's the first list item of 'oneOf'). The schema If the
> > > single interrupt is not supported, then we can drop it here.
> >
> > Well the description says "1 interrupt per core" which is incorrect.
> 
> You are reading the schema wrong. There are 2 cases supported as
> defined by each '-'. The 2nd case is all the keywords until the
> indentation decreases. So 'description' is just description of the 2nd
> case. The first case is just "maxItems: 1". I probably didn't put a
> description because why write in free form text what the schema says
> (other than of course no one knows json-schema...).

Apologies, I've not read one of these things before and looks like I
completely misread it.

> YAML combines the best of Makefiles and python. You can't have tabs
> and Indentation is significant. :)

Oh wow, I'm in way over my head here!

> > I also
> > don't understand why maxItems is 8.
> 
> Humm, I probably just made that up based on GICv2 limitations. What
> should it be? If there's not any inherit maximum, can we put something
> reasonable? There's not really any way to express that it should match
> the number of cores in the system.

What's the largest number you can think of?

Will
