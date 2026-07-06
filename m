Return-Path: <linuxppc-dev+bounces-23587-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B2BC43602
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 06:48:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtw1P19SPz2yfS;
	Mon, 06 Jul 2026 16:48:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783320521;
	cv=none; b=JCIhKykUMX4ExdZ8h1FY+9HgA+8o6KMxgUtK9X7Kf0cJOgolvYM9/n24Ykdj9Zojrx/X3dM2v3nplkyMppQPyouZ8B7QhRcnDIXwJnxKL+o2oil4ODH1spV363mo3sK9k8NanPzrqMMdwej9I11/9cyZIMEVHq5myn3sg1VOwL5xNyFVxKvvA0pvfYZ+nnyxQcgUSt2l0FZ18QZ4/5qST9awhQia+vvTmw9EgbyO7lWOZc4Z6SZURQXn398X8JCWdkdRf6mnqxTJ112YKaQKVwEZ9AvU4tx0BZv/kKNnpOIgNmEmPJtzyS6CjpINxy2KI4av3JRE8mhMNK3fFSRkWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783320521; c=relaxed/relaxed;
	bh=FyC6uLd4SG/eFVU0+S/jOwpK4vgRdKg92Yml7ndQ0uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDagLLXZGp3cAn0Ds7TE2kgxnXJEPmqnzsMxWtDhTJCOAtCtrqSaNsrSatesD1oXlRNnGS8a7a8BQXG188EaTZMUOobGEkMlNy9tXC+8b/zVD2mph+I7G238VwMyKI9tSDzXeid8WZzo3Dsm3ozRoMMu8bMT2rT23C7cw9/TOjIJ3qDbGN883HtNmCOV8GExGDrYZZ9+1JbTmvcZH4HsfHkbLA+TWDEV7kC2lv06a3l1evVNf8/IjWnc+CEwHI6F6kM1KN1vE/f8mBTgABvXPs5eykk2dEQhoguVTm2dBs0Y+wX4vCVZ0vlhI+vEMRmrxKGtdZE0c4v57pb3ug11VA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aNpwPhaQ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aNpwPhaQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtw1N1BpTz2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 16:48:40 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C116E61383;
	Mon,  6 Jul 2026 06:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5F31F000E9;
	Mon,  6 Jul 2026 06:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783320517;
	bh=FyC6uLd4SG/eFVU0+S/jOwpK4vgRdKg92Yml7ndQ0uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aNpwPhaQw9RIwCkkdYM+Niad6l8inxvBTg0uE6F6r3bChE4b981OUFGWu1hzEQi4D
	 QtjyaZ0fsHh8nyTQd0PBJTpZa9R57N7+sV0jGHJTosRn+vuYgLLhF7jDDyCi5YrmYw
	 QAwj9EupMCxF4iKQxwo4eEmOSHweRJkgbmt0XHpZB4UvlTEFv7WvJWRCP/WtV/s0gu
	 m/5p0g9xtzBXKcpMnrMhT/IhJC4OOMgSSvBfdaNm6RDmZrZ/pnYyqTt2gY7+gRghSN
	 Zgo+d6oli8+2zZuQsiQ1QZ9M87MezP1ngGMO1lGmTvuTM51nlx+IVB4UUwYIjCRwYR
	 Fi0hf5vrgKTWw==
Date: Mon, 6 Jul 2026 08:48:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Qiang Zhao <qiang.zhao@nxp.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 03/12] dt-bindings: soc: fsl: qe: Convert QE GPIO to DT
 schema
Message-ID: <20260706-piquant-arboreal-panda-b810f2@quoll>
References: <20260703-qe-pic-gpios-v1-0-6c3e706e27dc@bootlin.com>
 <20260703-qe-pic-gpios-v1-3-6c3e706e27dc@bootlin.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260703-qe-pic-gpios-v1-3-6c3e706e27dc@bootlin.com>

On Fri, Jul 03, 2026 at 03:30:11PM +0200, Paul Louvel wrote:
> diff --git a/Documentation/devicetree/bindings/gpio/fsl,mpc8323-qe-pario-bank.yaml b/Documentation/devicetree/bindings/gpio/fsl,mpc8323-qe-pario-bank.yaml
> new file mode 100644
> index 000000000000..1af99339ff40
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/fsl,mpc8323-qe-pario-bank.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/fsl,mpc8323-qe-pario-bank.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale QUICC Engine Parallel I/O (QE PARIO) GPIO Bank
> +
> +maintainers:
> +  - Christophe Leroy <christophe.leroy@csgroup.eu>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,mpc8360-qe-pario-bank
> +              - fsl,mpc8569-qe-pario-bank

None of these were in the old binding. You need to mention and
explain (WHY) the changes you are doing to the binding during the
conversion.

> +          - const: fsl,mpc8323-qe-pario-bank
> +      - const: fsl,mpc8323-qe-pario-bank

Best regards,
Krzysztof


