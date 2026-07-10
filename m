Return-Path: <linuxppc-dev+bounces-24003-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E753C44501
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 10:28:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxSjS3tyzz2ySg;
	Fri, 10 Jul 2026 20:28:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783679324;
	cv=none; b=fTqzpVPGOXWXGyhWPN+49wEOoDKAhyaqAD5iKOhlcuwjCEiPO1LvH0fLWwulcpaAKA/07/x2XgC0o2X/XXnLtHGUXLoR3lbCyoJvSjGBF95ZpQNYWSXtX67Xz8Tb5Imw9Z87R9PYCZNU1kcWYoNB8cwtTvvmokunyIdlFN7okJbmCy76R3MFNuCQ4bbJ0rUZF3BzlzslbEm53Zv2MEViPej2odSUK3rk6vTKCW22zhNaTORphlWQoWZnmN+xhzF9RP45oKomx4whP26giuG0lNjsp5OzYmTmFeJbeEq1RdZg6ASQl/wsfJX1/GzhVRynTonZGTKzArFdB/b2/meZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783679324; c=relaxed/relaxed;
	bh=7MUfl+qwpC1o7BVjkJfwBEdwVKVSN/Dl3tD+mqKLJFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdY1LuilgEhubnxEFX2+Y/zZjEHZzfV8FY3VFmbuknMYPWAHLnnPomNAvc2XCBOwYOXI6R7AH30v/8HA1G0FvE54KnhpruYApss9pg5VoH5F2AywW52MoZpUW8D46sKfbnF2o3Z83nAEHoGn78aTx/OFWMy9tA3rx0VR4tRyfgPydmaj8FSNx37dNzgADukazqpXp4uZuDI6/E9nZwcllpreY0SI5M0MKFDRoq7G+qL8Ri4eQoE1qD+5euT8o/wq+ufWCbvWzK/i8jUWfxq8LpZ4olFu5SSqwRLUHzk/DX2Cqgz2v8d71aOWcLw8aE/Ne/lAsDLfwrjPZMUuZ4gc3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPUq2UNY; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPUq2UNY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxSjR6kyDz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 20:28:43 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 79403601D9;
	Fri, 10 Jul 2026 10:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670D81F000E9;
	Fri, 10 Jul 2026 10:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783679321;
	bh=7MUfl+qwpC1o7BVjkJfwBEdwVKVSN/Dl3tD+mqKLJFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FPUq2UNYbkh7tvmcQ2svWUONIrBGEKCCzMCYNSDjhxFO0BtceBRYDuFQL/okwRfIn
	 7OdwRxfzEu/SweNWxSmYDocZDwNJzxgk50ivjVWoU6bgty6yqcJT6gY+kQMy9M60c0
	 ks9scJ+DDJtOvbDxW7r9s4kZpJr4+l6A2/50KPRJtac9VFcAoyYvuOESeR1uYNJIXN
	 HO6U1H6IMJ6jrgd7/Vd0XAPWgdjwKI4PIYFXZZA8833xGFlCKy4i78s8+ctYGAevHk
	 WVQ2tp6jMY9eKdBt96hZtQ5edJyOPjXw4l2yu6h6oFONU70wqRwI0uQqNv2nuBzI+v
	 jmQIGugLOB4VA==
Date: Fri, 10 Jul 2026 12:28:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Qiang Zhao <qiang.zhao@nxp.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v2 04/10] dt-bindings: soc: fsl: qe: Add support of IRQ
 in QE GPIO
Message-ID: <20260710-accurate-cherry-toad-5d20c3@quoll>
References: <20260708-qe-pic-gpios-v2-0-1972044cfbd1@bootlin.com>
 <20260708-qe-pic-gpios-v2-4-1972044cfbd1@bootlin.com>
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
In-Reply-To: <20260708-qe-pic-gpios-v2-4-1972044cfbd1@bootlin.com>

On Wed, Jul 08, 2026 at 12:15:17PM +0200, Paul Louvel wrote:
> Some QE GPIO pins have an associated interrupt line in the QE PIC to
> signal state changes on the pin.  Add the corresponding
> interrupt-controller / nexus properties to the QE GPIO binding.
> 
> Because the GPIO controller does not perform any interrupt handling
> itself, a nexus node (interrupt-map) is used to map each GPIO line
> supporting IRQ to the parent QE PIC interrupt domain.
> 
> As the QE PIC can be configured to generate an interrupt on either a
> high-to-low transition or any change in signal state, three
> interrupt-map entries are needed per GPIO pin that can yield an
> interrupt (falling, both, and the "none" case which defaults to both in
> QE PIC).  This overhead is necessary because the interrupt-map-pass-thru
> property is not part of the DT specification.
> 
> The interrupt-map property is optional: it is not required for GPIO
> banks that have no interrupt capable GPIO line (e.g. port D on MPC8323),
> or when interrupt functionality is not used.
> 
> Update the example to show a scenario where each bank supports a
> different numbers of IRQs, or no IRQs at all.
> 
> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
> ---
>  .../bindings/gpio/fsl,mpc8323-qe-pario-bank.yaml   | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


