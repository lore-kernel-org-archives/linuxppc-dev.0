Return-Path: <linuxppc-dev+bounces-26941-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B34C79FB6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 13:45:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg29p4ZpQz2yrr;
	Wed, 09 Sep 2026 23:45:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788961502;
	cv=none; b=g/lWCnS6t7gjpvGoH46c5xPp404S/UKW+Ae1umLbq4vTndwzAjvYRYFej0s5vEtiULnGPsgyxoHCqgza5LNH4ic85MRdBd7+uAp0m+dIm//V0swIigvGKwnYlvu/2ybg8qGgGi9mBOvAAdqsz8Qi0+boanvUhlhutQIgMVQ2w+HViJE2YnxxNwm6DOwX1Y/NQuE4sIVZwvzgpE3+/N2/EYFpwKJIQ+3nesl30xBOPFGHe2alTEYCJeS70wsAQaWBsYmHovsUA3sbBH6d3PuzJDw87bbZMIGbK7c5FOlQclqGe5AxLtE4mcvdFZxHhKGtAJgs+WsP+BtXbGJ2uBSVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788961502; c=relaxed/relaxed;
	bh=311691/uGkvvFKIwGpWDg1KsCLWCsJMoqMq4WdR/uMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUuJWrVays65oNTXSoL0WC4gRXemrwOjwtfRSI+f+wJhgidDUkezmXDf3FGbQ5kb4YTAJFpxO9l29/8xWdbQM3vcS1pEDBytL8h7nZ75XtOxBQMuE5iOJxTnAV4kjlb+jPyT4tctXrE+yWD1i4cfXgbc2lQW4tkIvRF1/vf3YwvTXXDmW2DRZUJlYcfPkt1RMt1zURU/xioJqAt0ctWFeNG1B8fy+tLCoSyQNhXnhF9pdeLf+inLw1MZx4USF749Tak6GjlTAg5bAtV5+9JGyQmy1tRLpKzTIuV+hvHGA1jXoP4bxWzvNqNOgxgkVrvPYgtRwpHLYneO5lTv9xYkeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPYFSc7z; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPYFSc7z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg29m33ltz2yrW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 23:45:00 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 40FE543977;
	Wed,  9 Sep 2026 13:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1BB1F00A3A;
	Wed,  9 Sep 2026 13:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788961497;
	bh=311691/uGkvvFKIwGpWDg1KsCLWCsJMoqMq4WdR/uMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dPYFSc7zuElgqPOrUvKFlinRxJJKwheHPvZj90jo4KmpnxV33/ufuBhrNpkTSj7xj
	 2RyspHqXkazeIpBw80R2fnKH5h7xSTHlRroygAHqghJUHmdY3lokSSP79WG/GJiDoB
	 oyBdDww+Ucy2ezUGrlZcwr9zvzgw4CaTeveT7WW6/oC56HlygAVyaKSTf4loP/g25/
	 JbuxGE+JuFDJrB1jVccueZ0gS7opSWr84NdE4okUrMy+Eb+npKXAoyFyecgv0dupb+
	 nOt/5qmgDw055SNzS9Q9wTx7telYpSpj52eSu7BEqy7RFlRlIIZ2qyITJuChYmq+Ij
	 Bdwur7Kmdt/Pg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x4Ibe-00000002Iwf-0E2s;
	Wed, 09 Sep 2026 15:44:54 +0200
Date: Wed, 9 Sep 2026 15:44:54 +0200
From: Johan Hovold <johan@kernel.org>
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
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	patches@opensource.cirrus.com, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev
Subject: Re: [PATCH 09/14] mfd: remove unused lm3533 driver
Message-ID: <aqFi1qGC2QMzMAq9@hovoldconsulting.com>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-10-arnd@kernel.org>
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
In-Reply-To: <20260909132153.1596191-10-arnd@kernel.org>

On Wed, Sep 09, 2026 at 03:21:46PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This driver has apparently never had any users, as it does not support
> devicetree probing, and no lm3533_platform_data definition ever
> existed upstream.

I don't believe we ever required board files to be upstreamed?

There's also on-going work to enable devicetree support for this one:

	https://lore.kernel.org/lkml/20260617080031.99156-1-clamor95@gmail.com/

Johan

