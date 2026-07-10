Return-Path: <linuxppc-dev+bounces-24002-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A975C44501
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 10:28:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxShz6Xqhz2yS4;
	Fri, 10 Jul 2026 20:28:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783679299;
	cv=none; b=CvrZ2dXqZpChYKWSMNlys9z1zg19A0DGdz1PW5inbgIErSsobzerTi4retJmrT6HqzLD3AcLvJFzTEydGOb+bTuoBib7VqjRtUXAWW2eX4dzbk21Nnnb1oqsWabyv9q8Gq4wQ49uk89LozZfANifbLMf5lWBEFXFbyAguQgzTQnmJxkBLK3uSWnfbTxoCvKwPD0uJobT0sAwMaV/MmFOb8dpkTyb/0br5G0kTlPoqE8I23VKPpziAaqKqkmg2dBvOGKQusb8a+vIClgMeAFhIesbf9M1iowmeqvUGN0LOA4lWkynMJljfO2rPN4An66H4jFTPYkz/c9E1ORK3xmOsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783679299; c=relaxed/relaxed;
	bh=BdmbeR+nXP2QOTmJSL448JaWOhpFdJafXIzincBL+Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAtdMgdxaxsQ4cIERX8LGBc+GRyXdTLZaasAynGMEdlqRhAfEoLBJwhO66pblvq0XPY68KRpFZOdFV9yYw7DH+/pH1d10285TqmR4nx33bHI1DJ1qDPRE8ONtz1OdphC6w8+YN/i/CADq+gse09xQvdM6uFWnVEZmXXQHC72IyYvoFmTT6PBLXPvYpSt5xZPqlFr3l0EwTeXtEn4f5ipd8EwSwIzyp7JWJ+tGT6QpLc7NYIaLvb9rE5OzpKY/lsieZqUXPsCKndeQtpDOB5oPICznkpJz0V9x0595BbipYIwhrjm8mMTnS96I6wsB76ZaJO09rhPk+Ml+ae/OBANJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E59VEGjD; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E59VEGjD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxShy5PdHz2yRF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 20:28:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1AC58601D9;
	Fri, 10 Jul 2026 10:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9C41F000E9;
	Fri, 10 Jul 2026 10:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783679295;
	bh=BdmbeR+nXP2QOTmJSL448JaWOhpFdJafXIzincBL+Qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E59VEGjD2WXB4bUGmJBQC7A1D/xBU5RjYM4hv1oGNHf73wKSUSUgQhTy1N4nDaoBX
	 BddUzBpETIjpA6lNNhR1qJN1AEWf2QBTyl4kyFEFrT9EO3NW7H+0TM2dTgp93U13nO
	 DNkMYFMJPkLBG1ezmd+ZFJ38c8HW/ylby25KSP9sMsmyc55zW8REh5t09dmnX3nDYU
	 2Giy5jGDIYrcBOCVI60C8CwuEttGo5D3aYIQiDgezd2qe9AygAwPJILlBaCVklIz90
	 23DTG35DsRTwPBotQQv5ENuLuq5JAN5jfOpdcdWGos9UMrdQIEcVm1w3D5y+nAEf1m
	 /CD0IiuhXfvEw==
Date: Fri, 10 Jul 2026 12:28:11 +0200
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
Subject: Re: [PATCH v2 03/10] dt-bindings: soc: fsl: qe: Convert QE GPIO to
 DT schema
Message-ID: <20260710-portable-thoughtful-uakari-4db7be@quoll>
References: <20260708-qe-pic-gpios-v2-0-1972044cfbd1@bootlin.com>
 <20260708-qe-pic-gpios-v2-3-1972044cfbd1@bootlin.com>
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
In-Reply-To: <20260708-qe-pic-gpios-v2-3-1972044cfbd1@bootlin.com>

On Wed, Jul 08, 2026 at 12:15:16PM +0200, Paul Louvel wrote:
> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Convert QE GPIO devicetree binding to DT schema. The old binding uses
> fsl,<chip>-qe-pario-bank because multiple MCP83XX SoC has support for
> these GPIO banks. The best practice is to list out every <chip> instead.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
> ---
>  .../bindings/gpio/fsl,mpc8323-qe-pario-bank.yaml   | 45 ++++++++++++++++++++++
>  .../bindings/soc/fsl/cpm_qe/qe/par_io.txt          | 26 +------------
>  2 files changed, 46 insertions(+), 25 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


