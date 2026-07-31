Return-Path: <linuxppc-dev+bounces-25188-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59F2C55172
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 22:47:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBh6P4xt2z2xlV;
	Sat, 01 Aug 2026 08:47:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785538061;
	cv=none; b=Jdp1tnCVynBZO23yQOureeJojCV0+RCLy+QtpWT5HQef4EpP3js4SiWRMI4G4R+bzouKUuyGlU2TT/fygBmdONDAboMaO53znVN0Je0+I2ex+3Wi2O1xVomTb2Lv0QKaENUf+PVq8LOV4W3PCdoRFKDVxAdK5zoxpF3AQzPwl0xyHkCuNo+JXaKriihD6AdLc6CMpDzTffBPeUAZuAQKY3RZLnp9Lf7p8B9CDVVH4YFUWjme2zPVJegHdsOvLjJbTJsShqRLKQWHjHDTXBWxD5Sq6tBzrsFt+q6sEypm9/HhtWpqpQJdIXddkgK9ZxHczfJqsfUWCLbIp2lq8Szz1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785538061; c=relaxed/relaxed;
	bh=EO8CFlkuOm9CFa5xTcXOHUlgLuaD/l88nHO6R3HiCps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5Qk+J8m64bsdhid9e4omk4Blm7YwiYrWR6v7ZbbKAKdLbTo8FbSi+rYMh1r0l0dGOiPpSjt4s4HLP7zr4/7iePbuWteDKjkUBbEy8qw+DTdJodsFjtyJSlduQV5alxSmv1zNKW5psphy3zftOAkZvDcZ2tjbO9fTsYzAaAB2oRRZx6VJQc0Kjusl/5azbcf2aY+lMW4XLCsZRXJuhhfD0peHfhGTl/mBpDoR548XclgsQT0bmvCCsLL/AZ701vZGItJQ9zyg7jKpIYUelepJjvQCaBqRpXWPtO45uELeH0ESaaqhJU/4eV+c66BUu64xswYxyEyk7XgfGHkK7fxeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PexFx1TJ; dkim-atps=neutral; spf=pass (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=herve.codina@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PexFx1TJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=herve.codina@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBh6N2fscz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Aug 2026 08:47:38 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C24781A1376;
	Fri, 31 Jul 2026 22:47:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D082E6039A;
	Fri, 31 Jul 2026 22:47:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 13D9F11C16E20;
	Sat,  1 Aug 2026 00:47:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785538039; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EO8CFlkuOm9CFa5xTcXOHUlgLuaD/l88nHO6R3HiCps=;
	b=PexFx1TJHg8/pnR7hv6ujSMs80MZ4tEyoitcfQ3BjIvW8TXDrp88xGAXYYNCSMhQYHppTx
	HdLBZIVU3XnXTJ/1baRwzNk1dpjYpxxCgMBmTa7bALDUpLzdGaPoZthLES2j8Gw6fq9K4d
	eWxNGk43xYyCrhvBbanKeIbc8BL0IF7xgMaLwoxBzr+iLbCMLmSHtKyprcBa9dA6BL392G
	FVtMhBuhSwiCvXfST0di7W8GfpsayaS5U9JSs/Js1bHh5bCWB6czVdFdBKOKSQjFbUo9/G
	I0NDhPxzle8yjtoYwagWSALBSc4wGSuiKqPP5YfuDiwU8WpnWcTCzRAMa8e0Pw==
Date: Sat, 1 Aug 2026 00:47:17 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>, Paul
 Louvel <paul.louvel@bootlin.com>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2] soc: fsl: qe: properly scan GPIO nodes at startup
Message-ID: <20260801004717.73c06683@bootlin.com>
In-Reply-To: <a1db12ef75bf881dd5fba893a37db0c8517eca1b.1785414349.git.chleroy@kernel.org>
References: <a1db12ef75bf881dd5fba893a37db0c8517eca1b.1785414349.git.chleroy@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Christophe,

On Thu, 30 Jul 2026 14:29:36 +0200
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> Before commit 156460811def ("soc: fsl: qe: Change GPIO driver to a
> proper platform driver") qe_add_gpiochips() was walking the device
> tree to find all nodes with compatible "fsl,mpc8323-qe-pario-bank".
> 
> After that commit the discovery is handled by the platform core,
> therefore it is necessary to call of_platform_default_populate() on
> the par_io node.
> 
> Fixes: 156460811def ("soc: fsl: qe: Change GPIO driver to a proper platform driver")
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> ---
> v2: Use of_find_node_by_type() instead of of_find_node_by_name() as the "par_io" type is documented while the "par_io" name is not.
> ---
>  drivers/soc/fsl/qe/qe_io.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

