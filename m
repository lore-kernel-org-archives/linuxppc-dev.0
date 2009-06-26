Return-Path: <david-b@pacbell.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 33167B6F44
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Jun 2009 14:05:05 +1000 (EST)
Received: from smtp101.sbc.mail.gq1.yahoo.com (smtp101.sbc.mail.gq1.yahoo.com
	[67.195.15.60]) by ozlabs.org (Postfix) with SMTP id 6DCC8DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jun 2009 14:05:01 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: Subject: [PATCH v7] spi: Add PPC4xx SPI driver
Date: Thu, 25 Jun 2009 21:04:46 -0700
References: <4A43CC2C.1030409@harris.com>
In-Reply-To: <4A43CC2C.1030409@harris.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200906252104.46189.david-b@pacbell.net>
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

On Thursday 25 June 2009, Steven A. Falco wrote:
> +       if (spi->mode & ~MODEBITS) {
> +               dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
> +                       spi->mode & ~MODEBITS);
> +               return -EINVAL;
> +       }

This wasn't tested against 2.6.30-rc1 was it?

See the recent fixup patch I sent.  There's a spi_master->modebits
mask that should have been initialized, and which eliminates the
need for tests like that ...

> +       dev_dbg(&spi->dev, "%s: mode %d, %u bpw, %d hz\n",
> +               __func__, spi->mode, spi->bits_per_word,
> +               spi->max_speed_hz);
> +

... also the SPI core now provides a *standard* format debug
message for that stuff.  It also handles one more thing, which
I expect to see fixed in a v8 of this patch ... :)

- Dave
