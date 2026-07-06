Return-Path: <linuxppc-dev+bounces-23593-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B35AC44501
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 08:48:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtygz5DfSz2xpn;
	Mon, 06 Jul 2026 18:48:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783327727;
	cv=none; b=LfyWPXZwsza0sGUvUfvnVU9Bv7PSpAuSSUFzoljOETH4itR70YRWvSJaICzCC1hnnphSI64eLANHtb6aWoq7cBEYvAOS+zW5dZcZgpor7d3JWh1j2ZASVV5NCvRtFVwvPZYn4o0z6B/sOEcO4goPALjV2N4iDf7y7FsGWj/QYahmjUY7vNW1GduKgefQkuHstjEbzfq5vd9/KenDMkCljRQqsrHZaNOQTxUZvNW+cSOY8Eo8xHUVXJM1cfRz2NC/rRJ7OhymSSNaP4nSDgMXw1CjgsWVbpsdr4GBCgZ919LRanLdTriR7ZyZTRrs4OV4tZrLqLlJIQvJRmEoAplrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783327727; c=relaxed/relaxed;
	bh=4G2+USFAeZTDisSq/eM4nDWS0t6QootkKLNwL7GEI6s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WquOZyk8USbvFQn28peCt4vu5mxPLvOBgrjyWoh2d9SCh2klNz2hTm+JgYRP7dgXxAdLU/OZdOvn/1Ikidw23H5KVTxtgrf1WjAJxol244qPKLf6iuE9KUICTK1aGbQ3CDKBHByhQ05cku9KSzFUg9f80pbZle3UVWRR0U1ou73B3UKGGVIsN1O4oN7ghfPCZRHl3P/CnoSsB5bIC3tD2a6dLvvxT99/x3Fo9XmlEYzxlzM+2ggTvgG3k22UafD2uWOCg1S9EnStR/WLGG1Mevn/sw9q56ZZsQzJr4I2/U+k5Xql1ns7v2UJbf30KsW1XXemvCpZS3YYl5k3LUErRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=gW1AZif3; dkim-atps=neutral; spf=pass (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=gW1AZif3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtygx41Fqz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 18:48:43 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 29905C8EC65;
	Mon,  6 Jul 2026 08:48:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 17D68601A2;
	Mon,  6 Jul 2026 08:48:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6922C11BB9D9D;
	Mon,  6 Jul 2026 10:48:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783327717; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4G2+USFAeZTDisSq/eM4nDWS0t6QootkKLNwL7GEI6s=;
	b=gW1AZif3NdWuwJpcaSREpPyyzuzLVd6yQeWN/RWYlglDm0RwfTJdyVqzGj2HaxYgqGb15r
	SI5y5Jtp6apxHnFT3jd5CKjLqUDoukQNNZ6T47eGareIAu+Vj0a+MwOm6j17N2t5v+Itsy
	I6bmUZdZ1Xn4YFbvDRlORuo/quhrnQyqTdRLXtYOMjuuevVQjLX7KR00jqSc/EHkmD812F
	LkIoPE9qnTCZ7hVcb36epMNvJ35G+b4CplTfizscLw+l9t4n6lh6SkRn5Ohq4SROCD5iVb
	iphsKW7hpvYrGOOv2tSBXA6qa3bHMKVscFwAojrisvLbZNZaqPgshagL764ZOw==
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 10:48:32 +0200
Message-Id: <DJRCWXDUGFY8.1AIUFSEBFTG94@bootlin.com>
Cc: "Qiang Zhao" <qiang.zhao@nxp.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Linus Walleij" <linusw@kernel.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>, "Madhavan Srinivasan"
 <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 04/12] dt-bindings: soc: fsl: qe: Add support of IRQ in
 QE GPIO
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Paul Louvel"
 <paul.louvel@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260703-qe-pic-gpios-v1-0-6c3e706e27dc@bootlin.com>
 <20260703-qe-pic-gpios-v1-4-6c3e706e27dc@bootlin.com>
 <20260706-elfish-cornflower-bullfinch-604e0a@quoll>
In-Reply-To: <20260706-elfish-cornflower-bullfinch-604e0a@quoll>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Jul 6, 2026 at 8:52 AM CEST, Krzysztof Kozlowski wrote:
> On Fri, Jul 03, 2026 at 03:30:12PM +0200, Paul Louvel wrote:
>> Some QE GPIO pins have an associated interrupt line in the QE PIC to
>> signal state changes on the pin.  Add the corresponding
>> interrupt-controller / nexus properties to the QE GPIO binding.
>>=20
>> Because the GPIO controller does not perform any interrupt handling
>> itself, a nexus node (interrupt-map) is used to map each GPIO line
>> supporting IRQ to the parent QE PIC interrupt domain.
>>=20
>> As the QE PIC can be configured to generate an interrupt on either a
>> high-to-low transition or any change in signal state, three
>> interrupt-map entries are needed per GPIO pin that can yield an
>> interrupt (falling, both, and the "none" case which defaults to both in
>> QE PIC).  This overhead is necessary because the interrupt-map-pass-thru
>> property is not part of the DT specification.
>>=20
>> The interrupt-map property is optional: it is not required for GPIO
>> banks that have no interrupt capable GPIO line (e.g. port D on MPC8323),
>> or when interrupt functionality is not used.
>>=20
>> Update the example to show a scenario where each bank supports a
>> different numbers of IRQs, or no IRQs at all.
>>=20
>> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
>> ---
>>  .../bindings/gpio/fsl,mpc8323-qe-pario-bank.yaml   | 69 +++++++++++++++=
++++++-
>>  1 file changed, 66 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/gpio/fsl,mpc8323-qe-pario=
-bank.yaml b/Documentation/devicetree/bindings/gpio/fsl,mpc8323-qe-pario-ba=
nk.yaml
>> index 1af99339ff40..0c849a5698f4 100644
>> --- a/Documentation/devicetree/bindings/gpio/fsl,mpc8323-qe-pario-bank.y=
aml
>> +++ b/Documentation/devicetree/bindings/gpio/fsl,mpc8323-qe-pario-bank.y=
aml
>> @@ -27,6 +27,17 @@ properties:
>>    "#gpio-cells":
>>      const: 2
>> =20
>> +  "#address-cells":
>> +    const: 0
>> +
>> +  "#interrupt-cells":
>> +    const: 2
>> +
>
> If this has interrupt-cells, then it is a nexus, thus why isn't this
> also a "interrupt-controller"?

Because these these banks are not interrupt controllers.
Interrupts are handled by the QE PIC, and the GPIO controller does not do a=
ny
interrupt handling itself.
In this setup, does it really needs an "interrupt-controller" property?

>
>> +  interrupt-map:
>> +    description: |
>> +      Specifies the mapping of GPIO lines to the parent interrupt contr=
oller, as the
>> +      GPIO controller does not do interrupt handling itself.
>> +
>>  required:
>>    - compatible
>>    - reg
>> @@ -37,9 +48,61 @@ additionalProperties: false
>> =20
>>  examples:
>>    - |
>> -    gpio-controller@1400 {
>> -        compatible =3D "fsl,mpc8360-qe-pario-bank", "fsl,mpc8323-qe-par=
io-bank";
>> -        reg =3D <0x1400 0x18>;
>
> I don't get why you rewrite existing example instead of adding new one.

I could yes.

>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    pic: interrupt-controller {
>> +      interrupt-controller;
>> +      #address-cells =3D <0>;
>> +      #interrupt-cells =3D <2>;
>> +    };
>
> Drop node, irrelevant.
>
>> +
>> +    gpio-controller@1418 {
>> +        #gpio-cells =3D <2>;
>> +        #address-cells =3D <0>;
>> +        #interrupt-cells =3D <2>;
>> +        compatible =3D "fsl,mpc8323-qe-pario-bank";
>> +        reg =3D <0x1418 0x18>;
>
> And now you are not following DTS coding style.
>
>>          gpio-controller;
>> +        interrupt-map =3D <
>> +          7 IRQ_TYPE_EDGE_FALLING  &pic 4 IRQ_TYPE_EDGE_FALLING
>> +          7 IRQ_TYPE_EDGE_BOTH     &pic 4 IRQ_TYPE_EDGE_BOTH
>> +          7 0                      &pic 4 IRQ_TYPE_NONE
>> +
>> +          9 IRQ_TYPE_EDGE_FALLING  &pic 5 IRQ_TYPE_EDGE_FALLING
>> +          9 IRQ_TYPE_EDGE_BOTH     &pic 5 IRQ_TYPE_EDGE_BOTH
>> +          9 0                      &pic 5 IRQ_TYPE_NONE
>> +
>> +          25 IRQ_TYPE_EDGE_FALLING &pic 6 IRQ_TYPE_EDGE_FALLING
>> +          25 IRQ_TYPE_EDGE_BOTH    &pic 6 IRQ_TYPE_EDGE_BOTH
>> +          25 0                     &pic 6 IRQ_TYPE_NONE
>> +
>> +          27 IRQ_TYPE_EDGE_FALLING &pic 7 IRQ_TYPE_EDGE_FALLING
>> +          27 IRQ_TYPE_EDGE_BOTH    &pic 7 IRQ_TYPE_EDGE_BOTH
>> +          27 0                     &pic 7 IRQ_TYPE_NONE
>> +        >;
>> +    };
>> +
>> +    gpio-controller@1430 {
>>          #gpio-cells =3D <2>;
>
> So two new examples? But old one was wrong?
>
>> +        #address-cells =3D <0>;
>> +        #interrupt-cells =3D <2>;
>> +        compatible =3D "fsl,mpc8323-qe-pario-bank";
>> +        reg =3D <0x1430 0x18>;
>> +        gpio-controller;
>> +        interrupt-map =3D <
>> +          24 IRQ_TYPE_EDGE_FALLING &pic 8 IRQ_TYPE_EDGE_FALLING
>> +          24 IRQ_TYPE_EDGE_BOTH    &pic 8 IRQ_TYPE_EDGE_BOTH
>> +          24 0                     &pic 8 IRQ_TYPE_NONE
>> +
>> +          29 IRQ_TYPE_EDGE_FALLING &pic 9 IRQ_TYPE_EDGE_FALLING
>> +          29 IRQ_TYPE_EDGE_BOTH    &pic 9 IRQ_TYPE_EDGE_BOTH
>> +          29 0                     &pic 9 IRQ_TYPE_NONE
>> +        >;
>> +    };
>> +
>> +    gpio-controller@1448 {
>> +        #gpio-cells =3D <2>;
>> +        compatible =3D "fsl,mpc8323-qe-pario-bank";
>
> Wait, three examples? But isn't this the same as previous one?

I wanted to outline that each bank do not have the same number of GPIO line=
s
that support interrupts.

>
>> +        reg =3D <0x1448 0x18>;
>> +        gpio-controller;
>>      };
>>=20
>> --=20
>> 2.55.0
>>=20

Thanks,
Paul.




--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


