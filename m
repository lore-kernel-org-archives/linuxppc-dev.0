Return-Path: <linuxppc-dev+bounces-23781-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CE3C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 08:20:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw9yD0QG3z3054;
	Wed, 08 Jul 2026 18:20:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783498820;
	cv=none; b=C9rG6C2gp3YPqXYN1+tpY/FhJ9PAgoH1z0/D+pRRyleqfkChHCoD8odM2SY9hCQcaLAKm2v+yi79GmWOHyNbezrcRlluBdJTKEAacJ9SxmJgCW8DqzljVK3ubELBxIZ8OTSNf6bHLQkLBtDmys8k6rOt7qQaJHXx98QRaGwXT0wIniTeQe8NRYWadV2KpVX+1M8544IyVOP9MhrcXKxaKzVuhUE2S/zJAxTb6oMxjf/lAJ1rwmy7rsxjNO7p/T7OMQZMmVGHUZ5obJls7zvqp3GxfZT6pvriRu5XEoKRKP3exQ9vmNLd8evzuMswygsp6wmhJA+O9FqiC8G2glBkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783498820; c=relaxed/relaxed;
	bh=tAM7j5fQB9lPdjO1SSxK15JUZTKVRDEjwTyBLBLdbg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lafg6sJ5uMWkWMSmBcPAiIsHGqlRQKjQKA48HmxOD6keiG6YYHFehEOPC0LML/DJISH8ZM1vTbRKj4xf2RRMyD4i1b4UtEp3dyV4hz14axgw8Mt0WeJQLF/VgI7X6lunM/MG0oEFMHV+Mh6MIpW1uViQcaWoeHVy9ESRnDqabdcphPYYfQAyraARFwfw5L9dASmehEug4J0ZiAjXS0BoUrWIGImEgEQKHCa95MWn4wjgyIgYX3qZTV/5Ux8ae+OdP6HECrxkvLrFf+aA6p7RHKMRyUu8iBZNy5rB6JXpRtHoU+KmlzmKgQi1cSDryAqYzBmeiSQfNuodM1nPGqW1/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aiHjG5Fo; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aiHjG5Fo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw9yC1gdxz3046
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 18:20:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 32C9C60008;
	Wed,  8 Jul 2026 08:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5931F000E9;
	Wed,  8 Jul 2026 08:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783498816;
	bh=tAM7j5fQB9lPdjO1SSxK15JUZTKVRDEjwTyBLBLdbg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aiHjG5FoMWjwkqplKSyC6Z0HRMTU0vi8VYoM0h6WQEMyNkW0Pu6OBQs1hn4xHwsJZ
	 WS2AFd1+l9Lo/dfo3xF2PvvVPu77/LmSweFm/64r0iT04caYhKxCl52rGl/zKuEnKG
	 2Qi7h2HKLOLGKbaLrT75Rpxjoj+iSFy1IaVV2bP0Nf+2GKDWNllUuxcmvkZKQ+zU3E
	 2vkf74sW5VJa6qdZY7sMfoct3fmm7u1rnR9UKI/1cQtDDdWAMURHFOsJDvzgE8XsfH
	 FZdMym29eHeeBNDHgVQnjCKLQWHVH7TRkUalXVugiwUs7hHkRQW0rCvmj+0ixxJABh
	 3ipFl2YVX7xBg==
Date: Wed, 8 Jul 2026 10:20:13 +0200
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
Subject: Re: [PATCH 04/12] dt-bindings: soc: fsl: qe: Add support of IRQ in
 QE GPIO
Message-ID: <20260708-glorious-electric-octopus-e80abe@quoll>
References: <20260703-qe-pic-gpios-v1-0-6c3e706e27dc@bootlin.com>
 <20260703-qe-pic-gpios-v1-4-6c3e706e27dc@bootlin.com>
 <20260706-elfish-cornflower-bullfinch-604e0a@quoll>
 <DJRCWXDUGFY8.1AIUFSEBFTG94@bootlin.com>
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
In-Reply-To: <DJRCWXDUGFY8.1AIUFSEBFTG94@bootlin.com>

On Mon, Jul 06, 2026 at 10:48:32AM +0200, Paul Louvel wrote:
> On Mon Jul 6, 2026 at 8:52 AM CEST, Krzysztof Kozlowski wrote:
> > On Fri, Jul 03, 2026 at 03:30:12PM +0200, Paul Louvel wrote:
> >> Some QE GPIO pins have an associated interrupt line in the QE PIC to
> >> signal state changes on the pin.  Add the corresponding
> >> interrupt-controller / nexus properties to the QE GPIO binding.
> >> 
> >> Because the GPIO controller does not perform any interrupt handling
> >> itself, a nexus node (interrupt-map) is used to map each GPIO line
> >> supporting IRQ to the parent QE PIC interrupt domain.
> >> 
> >> As the QE PIC can be configured to generate an interrupt on either a
> >> high-to-low transition or any change in signal state, three
> >> interrupt-map entries are needed per GPIO pin that can yield an
> >> interrupt (falling, both, and the "none" case which defaults to both in
> >> QE PIC).  This overhead is necessary because the interrupt-map-pass-thru
> >> property is not part of the DT specification.
> >> 
> >> The interrupt-map property is optional: it is not required for GPIO
> >> banks that have no interrupt capable GPIO line (e.g. port D on MPC8323),
> >> or when interrupt functionality is not used.
> >> 
> >> Update the example to show a scenario where each bank supports a
> >> different numbers of IRQs, or no IRQs at all.
> >> 
> >> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
> >> ---
> >>  .../bindings/gpio/fsl,mpc8323-qe-pario-bank.yaml   | 69 +++++++++++++++++++++-
> >>  1 file changed, 66 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/gpio/fsl,mpc8323-qe-pario-bank.yaml b/Documentation/devicetree/bindings/gpio/fsl,mpc8323-qe-pario-bank.yaml
> >> index 1af99339ff40..0c849a5698f4 100644
> >> --- a/Documentation/devicetree/bindings/gpio/fsl,mpc8323-qe-pario-bank.yaml
> >> +++ b/Documentation/devicetree/bindings/gpio/fsl,mpc8323-qe-pario-bank.yaml
> >> @@ -27,6 +27,17 @@ properties:
> >>    "#gpio-cells":
> >>      const: 2
> >>  
> >> +  "#address-cells":
> >> +    const: 0
> >> +
> >> +  "#interrupt-cells":
> >> +    const: 2
> >> +
> >
> > If this has interrupt-cells, then it is a nexus, thus why isn't this
> > also a "interrupt-controller"?
> 
> Because these these banks are not interrupt controllers.
> Interrupts are handled by the QE PIC, and the GPIO controller does not do any
> interrupt handling itself.
> In this setup, does it really needs an "interrupt-controller" property?

So this is interrupt-nexus, but not an interrupt-controller. If that's
the case of hardware, then it is fine/correct.

Best regards,
Krzysztof


