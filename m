Return-Path: <linuxppc-dev+bounces-15668-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E8ED30CC0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Jan 2026 20:42:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drLlm3t0hz2xWJ;
	Wed, 14 Jan 2026 07:42:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768336948;
	cv=none; b=Tv3crt0o6bl3KO3fW5+YAbDaqtpFJy7cxQnCW5N1AgEMx6VyRoJGeglgYTwZCzaapfVq+WW54DqNTWU3i25yn+q+OMaCTa1YC+sn33Av08fZdkESNPTFntxIgFMOt+V0VBwQgQVTi03WL+LfVkXrMKHenbW1+xdcSxelWHILUhS6+2BSMzG8++y9yZGdHlOdSg3Y+YJRP5SlwUS0MrtURe8vioeIs2JjVHU0k4c75dPZR+x25MKWnOF4oLkC9E6mY5mKo+G3O9sePwT2RHi/gtmw73Y9xpG1q7M5l3KcGt8+rl7DVCEMTIGo+iizukxl6vBCyas+7KS4M6m/+ABt9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768336948; c=relaxed/relaxed;
	bh=fnkEvyTsfBoXP0YgwuOjsk3/Xv+b54KBkYtfEw+96xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0b7pKny1RXfcMgyUTeLNGGnp8lKozDgUvF8GdMd73Mg+WWQhY7Ste2G3AwjW1yFJxEK8bqC/Km5OJcUnn9z5BAAewwPEv06goJeSzUPaehB/ih2kiZFIX/qCe7uXJaRicXKcEeiMJlrv8TYODug9skgZqYcKXvCW3NHuYJH9oegRNWC+2GFEM0hNIFkvQpqJvkrc9bKYr5pAQy4M28EYybfewybXyxjOow81Wtyu1IOyvM/ryMTRo17Alh60EgBi4wfNObEf+kfpANQDdublqAHS2DY7qQrEpGpkOY5T6e8tI/SiUc4m+4iVxWkoCcK3vsgJPJ1RB5kZftdnJEhXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mt8lscux; dkim-atps=neutral; spf=pass (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=maxime.chevallier@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mt8lscux;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=maxime.chevallier@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drLll1yLXz2xQB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2026 07:42:25 +1100 (AEDT)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 980C7C1ECB5;
	Tue, 13 Jan 2026 20:41:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 015F860701;
	Tue, 13 Jan 2026 20:42:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C8B74103C8516;
	Tue, 13 Jan 2026 21:42:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768336939; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=fnkEvyTsfBoXP0YgwuOjsk3/Xv+b54KBkYtfEw+96xU=;
	b=mt8lscux4bYZ22tNIJoS1PHq+74DAfQZ11meqCpS6mTEyVR6N1GRRm5nsgyTBnVT6ayAsl
	jSXaAWVRBMgkKD4aH8cWZo+ooG0XUshTdPyEpKMXs7U3hTN/gVRW1OFMcmrD4MVqNORaLF
	hyIIvqbp0aZCkn7cab96M+pzBG0xitQR5OYzxtZdgY3OsgJ82tLpMoFhPYYASl66o2GksE
	ZbmV74zdCS3MsJkdDsaquH4UL3K/aAlF0nIQt52PSLDTV4/Mwqpe60obJpoVpdH8LwrvNy
	gHj8E3OfrYqWTP3kdUF6NqIw8Ii8gZJ2xPB5149vRr00x/TXgylo34VcqJx15g==
Message-ID: <0c321643-eb54-494e-901e-45829e57938d@bootlin.com>
Date: Tue, 13 Jan 2026 21:42:09 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: freescale: ucc_geth: Return early when TBI found
 can't be found
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Pei Xiao <xiaopei01@kylinos.cn>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Dan Carpenter <dan.carpenter@linaro.org>,
 kernel test robot <lkp@intel.com>
References: <20260113074316.145077-1-maxime.chevallier@bootlin.com>
 <d89cb3a7-3a55-4bdf-805a-b3386572b220@bootlin.com>
 <aWaSnRbINHoAerGo@shell.armlinux.org.uk>
 <6b8aebe7-495e-40e5-a99d-57f8f7b2e683@bootlin.com>
 <aWalAMC2FWKlXK0E@shell.armlinux.org.uk>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <aWalAMC2FWKlXK0E@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell,

On 13/01/2026 21:03, Russell King (Oracle) wrote:
> On Tue, Jan 13, 2026 at 08:24:49PM +0100, Maxime Chevallier wrote:
>> Hi Russell,
>>> Traditionally, we've represented the SerDes using drivers/phy rather
>>> than the drivers/net/phy infrastructure, mainly because implementations
>>> hvaen't provided anything like an 802.3 PHY register set, but moreover
>>> because the SerDes tends to be generic across ethernet, PCIe, USB, SATA
>>> etc (basically, anything that is a high speed balanced pair serial
>>> communication) and thus the "struct phy" from drivers/phy can be used
>>> by any of these subsystems.
>>>
>>
>> True, and I completely agree with that. The reason I didn't touch that
>> when porting to phylink is that the device I'm using, that has a
>> Motorola/Freescale/NXP MPC832x, doesn't have that TBI/RTBI block, so I
>> can't test that at all should we move to a more modern SerDes driver
>> (modern w.r.t when this driver was written) :(
> 
> Over the last few days, I've been adding "generic" stmmac SerDes
> support (which basically means not in the platform glue) to replace
> the qcom-ethqos stuff, and while doing so, the thought did cross my
> mind whether I should be adding that to phylink rather than stmmac.

You mean controlling the generic PHY (phy_power_on / off,
phy_set_mode_ext and so on) from phylink instead of the MAC driver, like
we also do in mvneta / mvpp2 ?

That would also interest the Meta folks working on fbnic I guess :)

Maxime


