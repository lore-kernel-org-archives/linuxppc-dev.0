Return-Path: <linuxppc-dev+bounces-23777-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F413DC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 08:16:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw9sn4g6zz2yft;
	Wed, 08 Jul 2026 18:16:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783498589;
	cv=none; b=DraTxJIy0fw/aFIipLY4Y+f5pzS5Fz7VSZ2qnzEmic6/J2CgCKb9tOadc610it2/WRbN1TAREBHP+10f6PzW+UJWnhgm7/Hsm3+cHLNyjCDGV7SJWkDh+aZsm1qo8E19Wk3cI/u8Ox40vstZGEM+acR+wbu3F4Cu4CjFhQYBIRiT+AjRx1/cZsAhH8Xqy7rlP7x1HV3Omy9zfqhlUs1IZbQA6VuyYte7nPq9vITVKLOoTBLJNCQIhMTeuA3YFDWloseEBvpwPFFMXL4J1f+mtXiwClo1Z2bYszKeMAPcAqWomNPZ1MDvFU3ErVlGqDVwZ2bsum/9vySI5Lbst9x90A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783498589; c=relaxed/relaxed;
	bh=hoiMUfefIhO/22z4j/RgowkVzpgWaSO743dDSJkhiCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHn39o2FSFsoq2DLCaUokRCQIPl4BZS5UBzRa7E26Og2u/7L+GUnc0zq8nD4oYd0lSu132Ocv/gYDAUR2/hAFVS+XZer1Jx2foFWS4V7v0CoXiLywdFhNqOGcaf+7vIiQVUtT5WFov+mTsa01JHK97V/1CChXu3vE67Rm9jlk1d1YoG/AQZ7asiTYyAeT0AhOc6SchO/QPXkPpM0lABxV1PFF0yM7XH2wanNZzZtk3J5qLWha1HUG4Zv4YlWDT0hkVEDZi0hbZ4H0g04NMPFmYZQHBBKfb8p39mYaGGTvVO6KybEjM7AzMbVfhS4tOgCpr3CKnshl3aT+a1BmR4BdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0MFymXY; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0MFymXY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw9sm57Wyz2yS0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 18:16:28 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5E3DA60008;
	Wed,  8 Jul 2026 08:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5101B1F000E9;
	Wed,  8 Jul 2026 08:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783498586;
	bh=hoiMUfefIhO/22z4j/RgowkVzpgWaSO743dDSJkhiCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n0MFymXYZZ0jS7v+5t2t+hCR/lXLM4YqFOLdgP/saTZo6cFSxmGXL1WcMxAjYan1S
	 7CQH17anrzKsY0JUZ9rpJD2C4Tmel7FZQmxCDAFWmL2uOA3axxRRjDr6cnzt2r8jTR
	 8ghLgWPSXkztRp0Kk4ToF42x6QEUAkCSr46WYXE/woToUFsEdB4KCzJMuL3iU+R4OO
	 nJnRzOd8ZtTwTYpoZgWFa0dDYWfO3MX45OcACsOhqMAE4SsaSBlUfQKnxRlpC0YlcV
	 UId3uIo5PXmjAJ00OuFNzyuvJw/hk6Y7Tnl+VC0eXhA+rwMgArAis6nlVHpdNW7PKE
	 Rpu/Vcv8rsGzg==
Date: Wed, 8 Jul 2026 10:16:22 +0200
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
Subject: Re: [PATCH 02/12] dt-bindings: soc: fsl: qe: Set #interrupt-cells to
 2 to support interrupt type encoding
Message-ID: <20260708-spider-of-hypothetical-refinement-f7fbc3@quoll>
References: <20260703-qe-pic-gpios-v1-0-6c3e706e27dc@bootlin.com>
 <20260703-qe-pic-gpios-v1-2-6c3e706e27dc@bootlin.com>
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
In-Reply-To: <20260703-qe-pic-gpios-v1-2-6c3e706e27dc@bootlin.com>

On Fri, Jul 03, 2026 at 03:30:10PM +0200, Paul Louvel wrote:
> The QUICC Engine port interrupt controller can be configured to generate
> an interrupt on either a high-to-low transition or any change in the
> signal state on the related GPIOs.
> 
> Update the #interrupt-cells property to 2 so consumers can encode
> interrupt level information.
> 
> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
> ---
>  .../devicetree/bindings/interrupt-controller/fsl,qe-ports-ic.yaml     | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


