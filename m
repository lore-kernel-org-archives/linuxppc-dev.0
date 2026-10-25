Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCFD606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Oct 2026 05:19:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jC4nd1Mwtz2yFj;
	Sun, 25 Oct 2026 16:19:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4190:8020::34"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792905589;
	cv=none; b=aeZfowllWmgVZ1yYviiDqmZGT1LwVTpfvpBYukKfMqkDeToXoSOLqbzLE7HoMYO/nc8aiF+RvKeUSOMan3K76BS4UITKxuEj6YtzK/xX3+RPYbWaTPVb15UIBI0OcIC56Lw4dNfT4oAD6s0q81qjLsCHYgV6C7/fgavKhkX+bHb80zWwpbt/znjCqJ4TZeRIxyvVp/AsMPnfPs9ZK5AUIjncVN3wZBOTXo3jxmFGOgdJaPTZCybkPPeYeAPAS651O7wS3/n64xHKHqAIiqlemt7YHozIZXnoh8QsC+LHTe8b3VYcwbAA6xTox9LX948kAXTHG0idpkedYnqAJtCaPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792905589; c=relaxed/relaxed;
	bh=8e88usUcYauyf3azJlO/PIAv73piHOHPPh8TVgMWY7s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mLEDdyXaL0AxQFEkEohpjB08SBfUuVZQh9anRarGpP+JYAqDd0d5exIdSaelarYaC5EQDh20RItbtgUb1DCWncGecK+F7JqnqV1HfnDJgwgAwkyBMi0JLo+IMh6lrp94e1B3hw8fOYGLt0H4RuodqtyEgeEghHuKnokv7HN1lbCk2VGT3c4qlhzHuv3rMDKjSwxEyX6Ba8w1eSld94T7EShcLVqLSukvGkVfnVotppv6bNyIqIiZGnocliE537GoGpIPhYWOgFLzZ0QmW815PsMv/hNOzcJdIHTN0P9V5HszFVba70LNXhGvl967+uJ3leQ8AqLHEWF5A4K6nxqtlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none (client-ip=2001:4190:8020::34; helo=angie.orcam.me.uk; envelope-from=macro@orcam.me.uk; receiver=lists.ozlabs.org) smtp.mailfrom=orcam.me.uk
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=orcam.me.uk (client-ip=2001:4190:8020::34; helo=angie.orcam.me.uk; envelope-from=macro@orcam.me.uk; receiver=lists.ozlabs.org)
X-Greylist: delayed 574 seconds by postgrey-1.37 at boromir; Sun, 25 Oct 2026 16:19:47 AEDT
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jC4nb61rxz2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Oct 2026 16:19:47 +1100 (AEDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id EAB0892009C; Sun, 25 Oct 2026 06:10:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id DDFC292009B;
	Sun, 25 Oct 2026 05:10:03 +0000 (GMT)
Date: Sun, 25 Oct 2026 05:10:03 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: James Hilliard <james.hilliard1@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Tony Lindgren <tony@atomide.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Richard Genoud <richard.genoud@bootlin.com>, 
    Nicolas Ferre <nicolas.ferre@microchip.com>, 
    Alexandre Belloni <alexandre.belloni@bootlin.com>, 
    Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
    Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
    =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
    Sascha Hauer <s.hauer@pengutronix.de>, 
    Pengutronix Kernel Team <kernel@pengutronix.de>, 
    Fabio Estevam <festevam@gmail.com>, Timur Tabi <timur@kernel.org>, 
    linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
    linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 2/5] serial: serialize asynchronous write wakeups with
 the port lock
In-Reply-To: <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
Message-ID: <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk>
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com> <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 24 Oct 2026, James Hilliard wrote:

> uart_write_wakeup() expects the UART port lock to be held. Several worker,
> DMA completion and interrupt paths call it without that lock, including
> indirect calls from uart_handle_cts_change() and the transmit helpers.

 Fair enough, and thank you for the cleanup and spotting the issue in the 
first place, however...

> diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
> index b4e1b90e5960..b15f76acd06b 100644
> --- a/drivers/tty/serial/sb1250-duart.c
> +++ b/drivers/tty/serial/sb1250-duart.c
> @@ -454,10 +454,12 @@ static irqreturn_t sbd_interrupt(int irq, void *dev_id)
>  
>  		if (intstat & M_DUART_ISR_RX)
>  			sbd_receive_chars(sport);
> -		if (intstat & M_DUART_ISR_IN)
> -			sbd_status_handle(sport);
> -		if (intstat & M_DUART_ISR_TX)
> -			sbd_transmit_chars(sport);
> +		scoped_guard(uart_port_lock_irqsave, uport) {
> +			if (intstat & M_DUART_ISR_IN)
> +				sbd_status_handle(sport);
> +			if (intstat & M_DUART_ISR_TX)
> +				sbd_transmit_chars(sport);
> +		}

... why do you think the whole functions need to be called with the lock 
held while they may or may not call the handlers in question even?  I 
think we should avoid excessive locking where possible to avoid holding 
execution elsewhere unnecessarily, shouldn't we?

  Maciej

