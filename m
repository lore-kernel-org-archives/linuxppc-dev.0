Return-Path: <david-b@pacbell.net>
Received: from smtp112.sbc.mail.re2.yahoo.com (smtp112.sbc.mail.re2.yahoo.com
	[68.142.229.93]) by ozlabs.org (Postfix) with SMTP id 7F956DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 01:44:44 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] [PATCH] [SPI][POWERPC] spi_mpc83xx: fix
	prescale =?iso-8859-1?q?modulus=09calculation?=
Date: Mon, 6 Aug 2007 08:44:40 -0700
References: <20070806131014.GA6913@localhost.localdomain>
In-Reply-To: <20070806131014.GA6913@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708060844.40310.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 06 August 2007, Anton Vorontsov wrote:
> +
> +                       if (pm)
> +                               pm--;
> +                       else /* this floods dmesg if using mmc_spi, so dbg */
> +                               dev_dbg(&spi->dev, "Requested speed is too "
> +                                       "high: %d Hz. Will use %d Hz instead.\n",
> +                                       spi->max_speed_hz, mpc83xx_spi->spibrg / 4);

Except that's not worthy of any message whatsoever, so it shouldn't
even be a debug message:  user says "give me at most X", driver says
"fine", end of story.

I'm more bothered by the earlier message, which gives a rate higher
than X instead of cleanly failing.

- Dave
