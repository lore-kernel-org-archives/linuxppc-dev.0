Return-Path: <linuxppc-dev+bounces-26942-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174EBC79FB7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 13:45:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg29x2nJQz2yvG;
	Wed, 09 Sep 2026 23:45:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788961509;
	cv=none; b=N+dJhGZIguqgsHyaPNGWCNpJEtSw+7YvUd9WN4hfdE3QIZGFDuoH/LpQ2/n2RTF68lvUZAsMhfW8kzHCm5YytcGDqa2cEdCgGKK49LHGFy548AvIypKwKDZbOkdTUAIS2fvAWpmw2p8lTnIoJNnyvF/TZKdl4E+bBwsHljTEl8t7oY86ngkHjDqUUQjpAPUhTiz+rEoFASnsPYegOiyOQK068L46SegYc9OujvTpAllGRNPj+KuUDT5F2qNWyjuQSbSgeBUwqUsu+5lYJTTKC+F7UFRtsF/IqMp0JrpKk5n2TjsIxYsSqGhVWrwNPdm1BXFdc2pPcgyGzsZU4OfK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788961509; c=relaxed/relaxed;
	bh=SddRT3djP09Ed0ShkS8xpytcBnp+LMCenJGnP73m0/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXSbjofp44+LsMrYTrwRhSzqm+mm1RruIMugL4h7mgTuI3JLPfHxNdhAzelDu/0gEG2pjjmPuMEuISnGJyrrlLNnBkAVKpjCklvWbRVv7MrCBqe9TxKyX1PXmaHPGrb47wACfDyhq9iNoBuosBcGt686QmMH2QOgol6vI0DHh+SG3jym2VZiuAAa8O9xX1tFVBlacXkAm4PgnMyxQLk8iZm5mITMBfL8HVuVx9HlE4ylifjK9mEjTRAdZOKs33FOhwTeoywRJij6NB5G9XIUndWthkzrXff9QWreMjiko+CE1fvikxec0X3uj6e8YEMIqd1ldkDW2ecyInyTrBmNQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qFOrBYn+; dkim-atps=neutral; spf=pass (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=alexandre.belloni@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qFOrBYn+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=alexandre.belloni@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg29v4fz0z2yrW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 23:45:05 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2E3924E41592;
	Wed,  9 Sep 2026 13:45:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E847760448;
	Wed,  9 Sep 2026 13:45:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6CCDC11C7AF3A;
	Wed,  9 Sep 2026 15:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788961494; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=SddRT3djP09Ed0ShkS8xpytcBnp+LMCenJGnP73m0/E=;
	b=qFOrBYn+NlO3vUgsMN69fPT6LsFBYJ9WZx3ZN0bi+TXRklU5lr5/kdcqj8w+UMRPRv0j5t
	1K3rOH7Bm7qvQu3jiyoKp6uHYGM8c6x1rhNO8aOD1Lqa6rFd6ssvwG5tRwPsppSGAGtRgd
	5b7gVfCUPfVEFQMfGBUsdERF2y+Dm2OOXl5ZKnXmxvHCRKffwFRioHPfWG2OwRUDNrwXtE
	ercet4pqf4lgc/m27S+AgsBlIdNPFQsq5ss03yxvE6jIxeHl0BvkjKMfvAs9dRYxJa2i7A
	gY/Zw554xS/+HkDK8qpgmxzcL+SfGlFij2ztErujl+hxzRnuQbt80smJlDX5gQ==
Date: Wed, 9 Sep 2026 15:44:43 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Sebastian Reichel <sre@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 01/14] mfd: remove unused 88pm80x driver
Message-ID: <20260909134443876d2166@mail.local>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-2-arnd@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909132153.1596191-2-arnd@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On 09/09/2026 15:21:38+0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This pair of drivers was originally added as companion chips for pxa/mmp
> SoCs, but the corresponding platform code was never merged, so it has
> been unused the entire time.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

