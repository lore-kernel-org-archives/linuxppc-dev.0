Return-Path: <linuxppc-dev+bounces-3764-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0869E7716C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Dec 2024 02:13:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y31JY2Qlpz3026;
	Wed,  4 Dec 2024 13:13:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733278381;
	cv=none; b=TlPkqH0zVZDDzOfAkzy8PALjXA7Ye/D0HU+0Nvxh9lzKpxZefc5dVMtxHAS+dxvxkoVO9XUemyRJQ2nDypxSdiAMX8lrgCC+6q0hOvJKd/oU/otMs0CebcRFdZ5iapEaixJIUV1gOr0DvR0fm3+clPXXtkJrPdMbsKWYBjpqtvU0g96Gp96qlP0EURiikxpUwL2hJeP9LtAnNH1oA2kxS63Wiwk83baKRY9k/SCdpkprEivln8j9jankGhosQN6sQ12tGm8K1zBz41oXH1k5HVorB9bVaLEIhdMfhsIa/6Sbj7vT6z/WNeP6Ksg2zDPxOGglgSbZbjvseQw+6mYemA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733278381; c=relaxed/relaxed;
	bh=pHK0bIhHd1w9mxfIUlOYvQ9+doQOP9AE+twlL5gInvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxEf69hzxNRFrd5aKdSsnjz5dPFlQLrXSpQc7iEkMmgHJYVYmLTQgBz8nltm28vehYW+nT01MbfUmzznCKUTSfoTkT/9pDvHg8PhXskoeARtYC0hztaX/17XdkrIAjRoCQsby71mDvh3z07QXhWHJVfHGLbuCcACjrmq9GYBZcuoVjUgXbLFqhDcuqU0qm5zH4yAsFREu243i5VY1X4nZA6dMQeF39HbS1LGRxCF9LqgFlDbFxIQGGuYU1aC7VmvgldCKnSTqi+62eKTXUe/yRDH8To4jXkSMVX81bDdBdeQzrfj9hf8BIVPIpBuw9bNK4lxUg6ZPJG4NXf+v9XdYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=pS0cvsX1; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=pS0cvsX1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y31JX32Jxz309W
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2024 13:13:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pHK0bIhHd1w9mxfIUlOYvQ9+doQOP9AE+twlL5gInvk=; b=pS0cvsX1lotpceJXuCs/uT77rj
	C5Rtl+fE/THt9xXx4N2ok37im8zDIahySax/ZhF3ciuyDoup07npK5JqnQ8AIieZT90BJGu48VEF6
	77ZH177IIsQgvCUsfXd0MHbqcu8n22L387wA2JYYLGFfq3Y+elglJtEI8V3i9reh74Xw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIesf-00F9fr-KT; Wed, 04 Dec 2024 03:12:45 +0100
Date: Wed, 4 Dec 2024 03:12:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v3 08/10] net: freescale: ucc_geth: Move the
 serdes configuration around
Message-ID: <38636fbf-f047-4764-bb04-104ecac2481b@lunn.ch>
References: <20241203124323.155866-1-maxime.chevallier@bootlin.com>
 <20241203124323.155866-9-maxime.chevallier@bootlin.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203124323.155866-9-maxime.chevallier@bootlin.com>

On Tue, Dec 03, 2024 at 01:43:19PM +0100, Maxime Chevallier wrote:
> The uec_configure_serdes() function deals with serialized linkmodes
> settings. It's used during the link bringup sequence. It is planned to
> be used during the phylink conversion for mac configuration, but it
> needs to me moved around in the process. To make the phylink port
> clearer, this commit moves the function without any feature change.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

