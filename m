Return-Path: <linuxppc-dev+bounces-23595-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCDAC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 09:03:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtz1N2xvpz2xpn;
	Mon, 06 Jul 2026 19:03:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783328632;
	cv=none; b=TcmDPEXP5wJeUip5JqSoWz9t82fKgWGZgnmc5frFt5ghb6HUz1EvIKoDlhiAGaen01BmHTKWfmsErF6XA4E5RvQYPn2HiPAwcZJslp3z8j4TPcm+7roVY+k3JXd7YoQJ4IsId20QN8f3N/rs00RIQ/CIHj2LKDztKi4A1q1TJFzOkLhvYlj/01F1IEvXg5p3fpDEFH2T795eqws/Kg9bU+F1abUjGm3ENlH0SEJOlDQI0qMk7m6KUWICcw+RuECPz6gilHjokAbHsuyFUTR8px089xTZ0yXl/phMZo9uP1BSM/i+aSnP8yVPvr10+Y/qQmCC2MO1q8YCJL+ooOT8mg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783328632; c=relaxed/relaxed;
	bh=EzXpYPV0PFB6TX9ZDcqY7ctXsxYzZyik5uIt1kgj5dk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eiiH6jpfBzdu2wHybln170g5JIZpoStfEVRO1LIksSaJbFDm+nZseTfQ/JR/oG995HKrbo31C4xV/2u7/dvROc1s8ujHa7SpVhOPBxVkbhCldnZH+Rcnp1ITD3w+Od9LS6HwPpdYM1jvtXTq/lxFDGOD8aXENDrv0rE8hOT7MHRgBa+CRflsuXfaqETxJ7/fx/emyTu9B3/Qnof446OFuaxjERP0EJrvW6YYk3gkPosAntXLZMYPxKcDYf6AfDOnXZipzRyYAF8JSAIA2V3yVIgHIIptNocYswF3MaapAiISJNwBkMld8jM4zneS7nSNDAm+NrBoevJUQHRXoL2i7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WIuz54pu; dkim-atps=neutral; spf=pass (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WIuz54pu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=paul.louvel@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtz1M22sVz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 19:03:49 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 962DA4E40CA6;
	Mon,  6 Jul 2026 09:03:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6142F601A2;
	Mon,  6 Jul 2026 09:03:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 91CB311BB9D70;
	Mon,  6 Jul 2026 11:03:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783328624; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EzXpYPV0PFB6TX9ZDcqY7ctXsxYzZyik5uIt1kgj5dk=;
	b=WIuz54puOIXvKsy0eg8hrSFIjyHK/usc7xVOrM0SNdZJgw12G3lKlHqewYnbWQemzWZMkt
	/II90sH6P0vbNirv6FCXYhRej6fzQU8Fc/UkcuengFjODFKvrQQZxobS8ssaQuzaKQ4zXa
	JMxB0yGF8nyVXi5OBQS4EZUXkUIcuMfrMp08oeRMPF73D4WLEo+HBEinnD+Gq4Qf2szNi+
	kR3dCEPtfXTAeXiuUh7UmXx99vauQZkyFHOgz0Qzo0vbNt0z3K3W7885eviRaI2SRAp9y0
	uRX5EZxDHaOWHj5kh80o0rtJCECCug1X7xc239ItstJdjNdLjPkp+u0i2wOVQw==
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
Date: Mon, 06 Jul 2026 11:03:40 +0200
Message-Id: <DJRD8IJUMKXJ.20CSZPRGGL3KE@bootlin.com>
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
Subject: Re: [PATCH 03/12] dt-bindings: soc: fsl: qe: Convert QE GPIO to DT
 schema
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Paul Louvel"
 <paul.louvel@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260703-qe-pic-gpios-v1-0-6c3e706e27dc@bootlin.com>
 <20260703-qe-pic-gpios-v1-3-6c3e706e27dc@bootlin.com>
 <20260706-piquant-arboreal-panda-b810f2@quoll>
In-Reply-To: <20260706-piquant-arboreal-panda-b810f2@quoll>
X-Last-TLS-Session-Version: TLSv1.3

Hi Krzysztof,

On Mon Jul 6, 2026 at 8:48 AM CEST, Krzysztof Kozlowski wrote:
> On Fri, Jul 03, 2026 at 03:30:11PM +0200, Paul Louvel wrote:
>> diff --git a/Documentation/devicetree/bindings/gpio/fsl,mpc8323-qe-pario=
-bank.yaml b/Documentation/devicetree/bindings/gpio/fsl,mpc8323-qe-pario-ba=
nk.yaml
>> new file mode 100644
>> index 000000000000..1af99339ff40
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/fsl,mpc8323-qe-pario-bank.y=
aml
>> @@ -0,0 +1,45 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/gpio/fsl,mpc8323-qe-pario-bank.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Freescale QUICC Engine Parallel I/O (QE PARIO) GPIO Bank
>> +
>> +maintainers:
>> +  - Christophe Leroy <christophe.leroy@csgroup.eu>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - fsl,mpc8360-qe-pario-bank
>> +              - fsl,mpc8569-qe-pario-bank
>
> None of these were in the old binding. You need to mention and
> explain (WHY) the changes you are doing to the binding during the
> conversion.

Ok.

>
>> +          - const: fsl,mpc8323-qe-pario-bank
>> +      - const: fsl,mpc8323-qe-pario-bank
>
> Best regards,
> Krzysztof

Thanks,
Paul.


--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


