Return-Path: <david-b@pacbell.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E8B77B7115
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 10:51:20 +1000 (EST)
Received: from n23a.bullet.mail.mud.yahoo.com (n23a.bullet.mail.mud.yahoo.com
	[68.142.207.189]) by ozlabs.org (Postfix) with SMTP id 298B6DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 10:51:19 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: Subject: [PATCH v8] spi: Add PPC4xx SPI driver
Date: Thu, 2 Jul 2009 17:44:27 -0700
References: <4A44F643.3050505@harris.com>
In-Reply-To: <4A44F643.3050505@harris.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200907021744.27636.david-b@pacbell.net>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 26 June 2009, Steven A. Falco wrote:
> +
> +       /*
> +        * If there are no chip selects at all, or if this is the special
> +        * case of a non-existent (dummy) chip select, do nothing.
> +        */
> +
> +       if (!hw->master->num_chipselect || hw->gpios[cs] == -EEXIST)
> +               return;
> +

I'm going to send this in, but please send a followup
patch making all this "non-existent (dummy) chip select"
stuff use the SPI_NO_CS flag.


> +       /*
> +        * A count of zero implies a single SPI device without any chip-select.
> +        * Note that of_gpio_count counts all gpios assigned to this spi master.
> +        * This includes both "null" gpio's and real ones.
> +        */
