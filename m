Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5614ECDE4B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 15:57:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 602D52077B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 15:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602D52077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rSb63GgbzF3Rj
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 02:57:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=robin.murphy@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42rSXQ0VZ8zF3PR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 02:54:38 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C37D880D;
 Thu,  8 Nov 2018 07:54:36 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 915EA3F5CF;
 Thu,  8 Nov 2018 07:54:33 -0800 (PST)
Subject: Re: [PATCH 13/36] dt-bindings: arm: Convert PMU binding to json-schema
To: Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-14-robh@kernel.org> <20181009115713.GE6248@arm.com>
 <CAL_JsqJh08wZCyGxg7HMbtKjOJTZKMoQcNOB_hPuSfJKQQK8JA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <08738708-1c38-fab7-eb34-694e5f4d4b7e@arm.com>
Date: Thu, 8 Nov 2018 15:54:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJh08wZCyGxg7HMbtKjOJTZKMoQcNOB_hPuSfJKQQK8JA@mail.gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, Tom Rini <trini@konsulko.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Olof Johansson <olof@lixom.net>,
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 01/11/2018 19:32, Rob Herring wrote:
> On Tue, Oct 9, 2018 at 6:57 AM Will Deacon <will.deacon@arm.com> wrote:
>>
>> Hi Rob,
>>
>> On Fri, Oct 05, 2018 at 11:58:25AM -0500, Rob Herring wrote:
>>> Convert ARM PMU binding to DT schema format using json-schema.
>>>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: devicetree@vger.kernel.org
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>>   Documentation/devicetree/bindings/arm/pmu.txt | 70 --------------
>>>   .../devicetree/bindings/arm/pmu.yaml          | 96 +++++++++++++++++++
>>>   2 files changed, 96 insertions(+), 70 deletions(-)
>>>   delete mode 100644 Documentation/devicetree/bindings/arm/pmu.txt
>>>   create mode 100644 Documentation/devicetree/bindings/arm/pmu.yaml
>>
>> [...]
>>
>>> -- interrupts : 1 combined interrupt or 1 per core. If the interrupt is a per-cpu
>>> -               interrupt (PPI) then 1 interrupt should be specified.
>>
>> [...]
>>
>>> +  interrupts:
>>> +    oneOf:
>>> +      - maxItems: 1
>>> +      - minItems: 2
>>> +        maxItems: 8
>>> +        description: 1 interrupt per core.
>>> +
>>> +  interrupts-extended:
>>> +    $ref: '#/properties/interrupts'
>>
>> This seems like a semantic different between the two representations, or am
>> I missing something here? Specifically, both the introduction of
>> interrupts-extended and also dropping any mention of using a single per-cpu
>> interrupt (the single combined case is no longer support by Linux; not sure
>> if you want to keep it in the binding).
> 
> In regards to no support for the single combined interrupt, it looks
> like Marvell Armada SoCs at least (armada-375 is what I'm looking at)
> have only a single interrupt. Though the interrupt gets routed to MPIC
> which then has a GIC PPI. So it isn't supported or happens to work
> still since it is a PPI?

Well, the description of the MPIC in the Armada XP functional spec says:

"Interrupt sources ID0–ID28 are private events per CPU. Thus, each 
processor has a different set of events map interrupts ID0–ID28."

Odd grammar aside, that would seem to imply that <&mpic 3> is a per-cpu 
interrupt itself, thus AFAICS so long as it's cascaded to a GIC PPI and 
not an SPI then there's no issue there.

Robin.
