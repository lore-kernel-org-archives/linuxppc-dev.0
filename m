Return-Path: <linuxppc-dev+bounces-26943-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746CFC79FB6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 13:47:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg2Dq0HF7z2ysb;
	Wed, 09 Sep 2026 23:47:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788961658;
	cv=none; b=EzyzIM6V/nnqnw+JcJ1kaJnqgpMaguNYA1DHiKwPGssYVYzT8xCNia3RJp9chm1I6PwSsaBG8Mf69ufNULRMIU2mmo8PYGc27QdFtyqlpfgVr0a6wWc/1HigjF5UPhpc6OMO8pfpEHfyUjp8rfTwJ3MEjLJ0Bh4CGIhlOAMfXvGjRZ4ZW9XsWSqq4Fgld3LMxgBt2TfXVORzf0iZTYBtaC6IwFkdDlKE/cXdMPZd4DFoTAMj+ykLQhDaBJRidU01V7P+PwS+BBTeuZafTdshnRa21/I3wfge0yd3f4QMfo/J7pEhxof5bTuNJUe08w1Lo2tbOFx29EGuZzhOaPmlfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788961658; c=relaxed/relaxed;
	bh=UeQWrBHUsYzfR8OG1tLDH6xJ9uIj59JiQoZuHROubjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/QMkAqwDZZumEEn9+gE98lWntUaR2CociNt2xJqsCEExMZLaWkNGxXcKt+3EPFFbzJ/4JEWP8mRIsrF/ntSm9s+m8AizDIjfHgHW1yg9/8enA3v0hHbOpsfxovoQU7Ie7b3dj3zufbeu9TLUggteAijuvT3GAqEStg5g4YmTdrCOVAkps6up7A5ZWcVig4j8tHmggOK0wmAfV8QD7LQyRoBH/eGJ9pIY0l0RxOadx4iutgIqNdYYj553kx371ZnuqIeNDrCaGWPqeQbOFvzvrTZBdgJXJqUGnE1S9S1dJ4drf82tIGDD5MxK9DuvBsrRc5wqagYm1xWp69K5O1lDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=GCHpAQ+O; dkim-atps=neutral; spf=pass (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=alexandre.belloni@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=GCHpAQ+O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=alexandre.belloni@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg2Dp1N4kz2ysW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 23:47:38 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 18DAB4E41592;
	Wed,  9 Sep 2026 13:47:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D920F60448;
	Wed,  9 Sep 2026 13:47:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E878511C782BF;
	Wed,  9 Sep 2026 15:47:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788961652; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=UeQWrBHUsYzfR8OG1tLDH6xJ9uIj59JiQoZuHROubjw=;
	b=GCHpAQ+OrX4KfJhFAWkevTRLOtcTPUS8G9Z+Qk0T1XTKkFRt9FjGrGjCYhRGd9BtQhCjo/
	EjrkQN54tfMFRkO5+xmticdh9JQRCnP2A6n6eTLXDpmK7ohZQa0h2ZLHdz6McP4I8NsWd7
	Vhhg7eZxU5SjMneaW0TFE74yKyqTBm3QDE3kSX31z2V59Awjm5z2K1z2U17N9pizI0//yg
	GjoEmkXUvZsDmi3QmJQ5OdeX67P1EmPvSDqjVYKsmyBs8NvIaHtOqAOZbnt7yRBk6aq0Q9
	1TDtXjaJ35VLd+ubtK3nvQd8cnqvwUzV/I8u/lS/OxzWY95CvKOygSUOa+SMoQ==
Date: Wed, 9 Sep 2026 15:47:25 +0200
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
Subject: Re: [PATCH 07/14] mfd: remove unused lp8788 driver
Message-ID: <202609091347259a3b9fa4@mail.local>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-8-arnd@kernel.org>
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
In-Reply-To: <20260909132153.1596191-8-arnd@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On 09/09/2026 15:21:44+0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This driver was apparently never used upstream, and without devicetree
> support cannot be used by external board support.
> 
> The MAINTAINER entry was already removed in 2021 as the email address
> bounced.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>



-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

