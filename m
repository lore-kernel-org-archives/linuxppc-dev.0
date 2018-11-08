Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36F7ECDE47
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 16:12:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A4220818
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 16:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A4220818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rSxH0FlMzF3RG
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 03:12:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=robin.murphy@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42rStg582TzF3RD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 03:10:34 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA14180D;
 Thu,  8 Nov 2018 08:10:32 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD8CE3F5CF;
 Thu,  8 Nov 2018 08:10:29 -0800 (PST)
Subject: Re: [PATCH 13/36] dt-bindings: arm: Convert PMU binding to json-schema
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-14-robh@kernel.org> <20181009115713.GE6248@arm.com>
 <CAL_JsqJh08wZCyGxg7HMbtKjOJTZKMoQcNOB_hPuSfJKQQK8JA@mail.gmail.com>
 <08738708-1c38-fab7-eb34-694e5f4d4b7e@arm.com>
 <20181108165940.64ad52f1@windsurf>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <8eb3b6e5-6dc4-491f-5988-d9cb2031054d@arm.com>
Date: Thu, 8 Nov 2018 16:10:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108165940.64ad52f1@windsurf>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Olof Johansson <olof@lixom.net>,
 Frank Rowand <frowand.list@gmail.com>, Tom Rini <trini@konsulko.com>,
 Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 08/11/2018 15:59, Thomas Petazzoni wrote:
> Hello,
> 
> I'm jumping into the discussion, but I clearly don't have all the
> context of the discussion.
> 
> On Thu, 8 Nov 2018 15:54:31 +0000, Robin Murphy wrote:
> 
>>>> This seems like a semantic different between the two representations, or am
>>>> I missing something here? Specifically, both the introduction of
>>>> interrupts-extended and also dropping any mention of using a single per-cpu
>>>> interrupt (the single combined case is no longer support by Linux; not sure
>>>> if you want to keep it in the binding).
>>>
>>> In regards to no support for the single combined interrupt, it looks
>>> like Marvell Armada SoCs at least (armada-375 is what I'm looking at)
>>> have only a single interrupt. Though the interrupt gets routed to MPIC
>>> which then has a GIC PPI. So it isn't supported or happens to work
>>> still since it is a PPI?
>>
>> Well, the description of the MPIC in the Armada XP functional spec says:
>>
>> "Interrupt sources ID0–ID28 are private events per CPU. Thus, each
>> processor has a different set of events map interrupts ID0–ID28."
>>
>> Odd grammar aside, that would seem to imply that <&mpic 3> is a per-cpu
>> interrupt itself, thus AFAICS so long as it's cascaded to a GIC PPI and
>> not an SPI then there's no issue there.
> 
> The Armada XP does not have a GIC at all, but only a MPIC as the
> primary interrupt controller.
> 
> However the Armada 38x has both a GIC and a MPIC, and indeed the parent
> interrupts of the MPIC towards the GIC is:
> 
> 	interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;

Yeah, perhaps I should have clarified that the XP manual was the only 
publicly-available one I could find, but I'm inferring from the binding 
and driver that the MPIC in 375/38x still behaves the same.

Robin.
