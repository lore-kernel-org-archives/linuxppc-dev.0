Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15662C04EBF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 10:11:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68565206B7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 10:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68565206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438vfB2p1fzDqs1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 21:11:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=will.deacon@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 438vZg4lWBzDqpk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 21:08:41 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4832980D;
 Wed,  5 Dec 2018 02:08:39 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 178B23F575;
 Wed,  5 Dec 2018 02:08:39 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id B870C1AE0BA8; Wed,  5 Dec 2018 10:08:59 +0000 (GMT)
Date: Wed, 5 Dec 2018 10:08:59 +0000
From: Will Deacon <will.deacon@arm.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 08/34] dt-bindings: arm: Convert PMU binding to
 json-schema
Message-ID: <20181205100858.GA14619@arm.com>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-9-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203213223.16986-9-robh@kernel.org>
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
 Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 linux-kernel@vger.kernel.org, Grant Likely <grant.likely@arm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Rob,

On Mon, Dec 03, 2018 at 03:31:57PM -0600, Rob Herring wrote:
> Convert ARM PMU binding to DT schema format using json-schema.

Just a couple of things below.

> diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
> new file mode 100644
> index 000000000000..3ea4abfbf276
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/pmu.yaml
> @@ -0,0 +1,91 @@

[...]

> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - apm,potenza-pmu
> +              - arm,armv8-pmuv3
> +              - arm,cortex-a73-pmu
> +              - arm,cortex-a72-pmu
> +              - arm,cortex-a57-pmu
> +              - arm,cortex-a53-pmu
> +              - arm,cortex-a35-pmu
> +              - arm,cortex-a17-pmu
> +              - arm,cortex-a15-pmu
> +              - arm,cortex-a12-pmu
> +              - arm,cortex-a9-pmu
> +              - arm,cortex-a8-pmu
> +              - arm,cortex-a7-pmu
> +              - arm,cortex-a5-pmu
> +              - arm,arm11mpcore-pmu
> +              - arm,arm1176-pmu
> +              - arm,arm1136-pmu
> +              - brcm,vulcan-pmu
> +              - cavium,thunder-pmu
> +              - qcom,scorpion-pmu
> +              - qcom,scorpion-mp-pmu
> +              - qcom,krait-pmu
> +      - items:
> +          - const: arm,cortex-a7-pmu
> +          - const: arm,cortex-a15-pmu

What do these last two mean?

> +
> +  interrupts:
> +    # Don't know how many CPUs, so no constraints to specify
> +    description: 1 per-cpu interrupt (PPI) or 1 interrupt per core.
> +
> +  interrupt-affinity:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      When using SPIs, specifies a list of phandles to CPU
> +      nodes corresponding directly to the affinity of
> +      the SPIs listed in the interrupts property.
> +
> +      When using a PPI, specifies a list of phandles to CPU
> +      nodes corresponding to the set of CPUs which have
> +      a PMU of this type signalling the PPI listed in the
> +      interrupts property, unless this is already specified
> +      by the PPI interrupt specifier itself (in which case
> +      the interrupt-affinity property shouldn't be present).
> +
> +      This property should be present when there is more than
> +      a single SPI.
> +
> +  qcom,no-pc-write:
> +    type: boolean
> +    description:
> +      Indicates that this PMU doesn't support the 0xc and 0xd events.
> +
> +  secure-reg-access:
> +    type: boolean
> +    description:
> +      Indicates that the ARMv7 Secure Debug Enable Register
> +      (SDER) is accessible. This will cause the driver to do
> +      any setup required that is only possible in ARMv7 secure
> +      state. If not present the ARMv7 SDER will not be touched,
> +      which means the PMU may fail to operate unless external
> +      code (bootloader or security monitor) has performed the
> +      appropriate initialisation. Note that this property is
> +      not valid for non-ARMv7 CPUs or ARMv7 CPUs booting Linux
> +      in Non-secure state.
> +
> +required:
> +  - compatible

I probably said this before, but I do think that it's a shame to lose the
example binding, especially for something like the PMU where you can
pretty much take an example and bang in your own IRQ numbers to get it
up and running.

Will
