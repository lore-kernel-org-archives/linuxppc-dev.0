Return-Path: <linuxppc-dev+bounces-24504-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F59C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 14:44:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3jvL3Vg5z2yWK;
	Tue, 21 Jul 2026 00:43:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784558638;
	cv=none; b=iJ+oYNcNT+G4glpRqGeprgvndZxU29wQnpvbtZg0UlMwFtc2ZD8GEAT5tI8gB5SmLog+Cbb1jwbi5EEYtIT8rjyC1j08pRuWLfhVlZAwnGHp7GTEs47uSTCF17/LlmTmmTnrmPjUCtzceFqNRluw8QNUIbenNf8KksoCFM6lRvbCZFbIfK8LTrjKFXTwNGpREucpM/UsHwtNc+1xifAIG7JSslWq8RUPj9kir73u6yz4WlWdS5QnrD0keunD9ru7ZqORXRm7VOyQGc7IkduniamD/WWErdpiI6D/f8Ix6UAtAxyeGdnwh9hxtKu93WB/2L+csJv1zhpGzSSzLtOhWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784558638; c=relaxed/relaxed;
	bh=BXhfFoqflgF82KRwFNK0K4F+WC7W4X52vQ4MqWkibHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhnfXQNo8tezaa4gHt+Ticz1va3UXBR1T/jRif03dH7NbbAug/9yIeOysA5qV0aL5UTohBSOV9uMuq5eZuQB4kryMp46NJkrFD3X9jrvrIwJHGE8oG8kU7kJmQoG4uU7mJoj4W4CZNupnQ8++CWRHnt0SwcQvA5RrnT7dOMTOd3GBCOgb1ZfFxQ2uSQXt5bBUiXWjpFBRLo+0GDf2RHxKjlM395CV6kWnedkjBvVC+3aJ9Eqk0JGfgK48H3HbQBKIcfj1UnWGh/fGFC8ZtI8jT4JpRYcv8kmBorZbZ7V7VSx8NGlBRJamf9T4oBHZDH0vCQdYtTxWmUHQJ6+5MA+6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=u87EBpi0; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=u87EBpi0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3jvK5cCVz2ySN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 00:43:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BXhfFoqflgF82KRwFNK0K4F+WC7W4X52vQ4MqWkibHk=; b=u87EBpi0W7PcezV9DBKXdXN4/P
	p9UYaLCZFtgUyOGYdytHLutMvSSNyvUcIgRfwGDopHvUqq9ZIlniLUGgYPwPRrDPsFmM1fCmmLkzn
	A985PR89vvPMIsZsJvQqT/OtMNtLd8+M4EQYIuLAiGvk2F3QoNojNtnckKSJnLpXICWU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wlpDY-00DHCs-Cz; Mon, 20 Jul 2026 16:43:40 +0200
Date: Mon, 20 Jul 2026 16:43:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>, brgl@kernel.org,
	driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org,
	linux-pm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 7/8] net: mv643xx: use platform_device_set_fwnode()
Message-ID: <86b2aba7-b049-47e6-bc94-6cb499b30ce4@lunn.ch>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-7-2dee93f42c54@oss.qualcomm.com>
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
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-7-2dee93f42c54@oss.qualcomm.com>

On Mon, Jul 20, 2026 at 11:24:54AM +0200, Bartosz Golaszewski wrote:
> Prefer the higher-level platform_device_set_fwnode() over the
> OF-specific platform_device_set_of_node() for dynamically allocated
> platform devices.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
> index 9caa1e47c174c9d7a161b7f2e2ee12a829b813d4..2f2d6cce8d852b9ec3ab42678a04a7915d1f00cc 100644
> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
> @@ -2780,7 +2780,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
>  		goto put_err;
>  	}
>  	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> -	platform_device_set_of_node(ppdev, pnp);
> +	platform_device_set_fwnode(ppdev, of_fwnode_handle(pnp));

This is definitely an OF only driver. There are no other calls to
fwnode functions in this driver, so this is the wrong thing to do.

Sorry, NACK.

       Andrew

