Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACF3C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:47:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C2F208E7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C2F208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RdzL0TnLzF3fL
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 04:47:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=bootlin.com
 (client-ip=62.4.15.54; helo=mail.bootlin.com;
 envelope-from=alexandre.belloni@bootlin.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=bootlin.com
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 42Rd5G5rxzzF3fq
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 04:07:29 +1000 (AEST)
Received: by mail.bootlin.com (Postfix, from userid 110)
 id D3BD120731; Fri,  5 Oct 2018 20:07:24 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
 by mail.bootlin.com (Postfix) with ESMTPSA id A05F820719;
 Fri,  5 Oct 2018 20:07:24 +0200 (CEST)
Date: Fri, 5 Oct 2018 20:07:25 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 19/36] dt-bindings: arm: Convert Atmel board/soc bindings
 to json-schema
Message-ID: <20181005180725.GH5626@piout.net>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-20-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005165848.3474-20-robh@kernel.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, Tom Rini <trini@konsulko.com>,
 Frank Rowand <frowand.list@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Jonathan Cameron <jic23@kernel.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

On 05/10/2018 11:58:31-0500, Rob Herring wrote:
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> new file mode 100644
> index 000000000000..f788315b94fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> @@ -0,0 +1,132 @@
> +# SPDX-License-Identifier: None
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/arm/atmel-at91.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel AT91 device tree bindings.
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@free-electrons.com>
> +  - Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Jean-Christophe has not been active for years, I'd mention Ludovic
instead.

> +description: |
> +  Boards with a SoC of the Atmel AT91 or SMART family shall have the following
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: atmel,at91rm9200
> +      - items:
> +          - enum:
> +              - olimex,sam9-l9260
> +          - enum:
> +              - atmel,at91sam9260
> +              - atmel,at91sam9261
> +              - atmel,at91sam9263
> +              - atmel,at91sam9g20
> +              - atmel,at91sam9g45
> +              - atmel,at91sam9n12
> +              - atmel,at91sam9rl
> +              - atmel,at91sam9xe
> +          - const: atmel,at91sam9
> +
> +      - items:
> +          - enum:
> +              - atmel,at91sam9g15
> +              - atmel,at91sam9g25
> +              - atmel,at91sam9g35
> +              - atmel,at91sam9x25
> +              - atmel,at91sam9x35
> +          - const: atmel,at91sam9x5
> +          - const: atmel,at91sam9
> +
> +      - items:
> +          - const: atmel,sama5d27
> +          - const: atmel,sama5d2
> +          - const: atmel,sama5
> +
> +      - description: Nattis v2 board with Natte v2 power board
> +        items:
> +          - const: axentia,nattis-2
> +          - const: axentia,natte-2
> +          - const: axentia,linea

Shouldn't we have the board specific compatibles in a separate file to
avoid mixing everything with the SoC compatibles?


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
