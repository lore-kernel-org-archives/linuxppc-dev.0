Return-Path: <SRS0=wZlq=MS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15A1C64EB8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 10:43:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE7C213A2
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 10:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE7C213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42S39z68cqzF3d4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 20:43:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=afaerber@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42S37c3K0DzF3c5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 20:40:59 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A4E0BACD1;
 Sat,  6 Oct 2018 10:40:54 +0000 (UTC)
Subject: Re: [PATCH 15/36] dt-bindings: arm: Convert Actions Semi bindings to
 jsonschema
To: Rob Herring <robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-16-robh@kernel.org>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <c4909f78-bfa1-9253-e436-1159392b45a9@suse.de>
Date: Sat, 6 Oct 2018 12:40:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181005165848.3474-16-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
 Frank Rowand <frowand.list@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Jonathan Cameron <jic23@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Rob,

Am 05.10.18 um 18:58 schrieb Rob Herring:
> Convert Actions Semi SoC bindings to DT schema format using json-schema.

This sounds like the next Yanny vs. Laurel... I fail to see any json. ;)

Also, it may help my understanding to be CC'ed on the cover letter, too?

> 
> Cc: "Andreas Färber" <afaerber@suse.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/actions.txt       | 56 -------------------
>  .../devicetree/bindings/arm/actions.yaml      | 34 +++++++++++
>  2 files changed, 34 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/actions.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/actions.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/actions.txt b/Documentation/devicetree/bindings/arm/actions.txt
> deleted file mode 100644
> index d54f33c4e0da..000000000000
> --- a/Documentation/devicetree/bindings/arm/actions.txt
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -Actions Semi platforms device tree bindings
> --------------------------------------------
> -
> -
> -S500 SoC
> -========
> -
> -Required root node properties:
> -
> - - compatible :  must contain "actions,s500"
> -
> -
> -Modules:
> -
> -Root node property compatible must contain, depending on module:
> -
> - - LeMaker Guitar: "lemaker,guitar"
> -
> -
> -Boards:
> -
> -Root node property compatible must contain, depending on board:
> -
> - - Allo.com Sparky: "allo,sparky"
> - - Cubietech CubieBoard6: "cubietech,cubieboard6"
> - - LeMaker Guitar Base Board rev. B: "lemaker,guitar-bb-rev-b", "lemaker,guitar"
> -
> -
> -S700 SoC
> -========
> -
> -Required root node properties:
> -
> -- compatible :  must contain "actions,s700"
> -
> -
> -Boards:
> -
> -Root node property compatible must contain, depending on board:
> -
> - - Cubietech CubieBoard7: "cubietech,cubieboard7"
> -
> -
> -S900 SoC
> -========
> -
> -Required root node properties:
> -
> -- compatible :  must contain "actions,s900"
> -
> -
> -Boards:
> -
> -Root node property compatible must contain, depending on board:
> -
> - - uCRobotics Bubblegum-96: "ucrobotics,bubblegum-96"
> diff --git a/Documentation/devicetree/bindings/arm/actions.yaml b/Documentation/devicetree/bindings/arm/actions.yaml
> new file mode 100644
> index 000000000000..af9345a228b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/actions.yaml
> @@ -0,0 +1,34 @@
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/arm/actions.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#

404 for the schema. Where does one find an explanation?

> +
> +title: Actions Semi platforms device tree bindings
> +
> +maintainers:
> +  - Andreas Färber <afaerber@suse.de>

Mani is now officially reviewer and the closest I have to a
co-maintainer. I suggest we add him here in some form. I assume this is
independent of MAINTAINERS patterns though, or will get_maintainers.pl
parse this, too?

> +
> +description: |

Does the | have any meaning, or a stray typo?

> +  The Actions Semi S500 is a quad-core ARM Cortex-A9 SoC. The Actions Semi
> +  S900 is a quad-core ARM Cortex-A53 SoC.

You forgot the S700 as another quad-core Cortex-A53 SoC.
Also, arm or Arm rather than ARM these days?

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - lemaker,guitar-bb-rev-b
> +          - enum:
> +              - lemaker,guitar
> +              - allo,sparky
> +              - cubietech,cubieboard6
> +          - const: actions,s500
> +        minItems: 2
> +        maxItems: 3
> +        additionalItems: false

Objection. You've managed to turn a perfectly human-comprehensible text
into a machine-parseable representation incomprehensible for humans.

First, there should remain some free-text explanation of the values
defined here. Are comments allowed after the value or indented maybe?
Alternatively we could have a per-vendor file à la vendor-prefixes.txt,
but that would seem inefficient.

Next, the above items construct is horrible. What about nested oneOf:

+      - items:
+          - oneOf:
+              - items:
+                  - enum:
+                      - lemaker,guitar-bb-rev-b
+                  - const: lemaker,guitar
+              - items:
+                  - enum:
+                      - allo,sparky
+                      - cubietech,cubieboard6
+          - const: actions,s500

This grouping is much clearer to me and hopefully to anyone adding
further base boards for the module.
We will have the same issue for the BPi-S64 module with S700 below.

> +      - items:
> +          - const: cubietech,cubieboard7
> +          - const: actions,s700
> +      - items:
> +          - const: ucrobotics,bubblegum-96
> +          - const: actions,s900

Please make the board compatible an enum, even if only one is listed
today. That makes it clearer where/how (and easier) to add new boards.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
