Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EA77FDDE06
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 08:46:43 +1000 (EST)
Date: Wed, 30 Apr 2008 15:46:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.25-git] spi_mpc83xx much improved driver
Message-Id: <20080430154631.b86797de.akpm@linux-foundation.org>
In-Reply-To: <200804301537.07965.david-b@pacbell.net>
References: <200804301537.07965.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: spi-devel-general@lists.sourceforge.net, 12o3l@tiscali.nl,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 30 Apr 2008 15:37:07 -0700
David Brownell <david-b@pacbell.net> wrote:

> From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> Date: Fri, 11 Apr 2008 18:57:21 +0200
> Subject: [PATCH] Much improved mpc83xx SPI driver.
> 
> The current driver may cause glitches on SPI CLK line since one must
> disable the SPI controller before changing any HW settings.  Fix this
> by implementing a local spi_transfer function that won't change speed
> and/or word size while CS is active.
> 
> While doing that heavy lifting a few other issues were addressed too:
>  - Make word size 16 and 32 work too.
>  - Honor bits_per_word and speed_hz in spi transaction.
>  - Optimize the common path.
> 
> This also stops using the "bitbang" framework (except for a few
> constants).
>
> ...
>
> +static void mpc83xx_spi_work(struct work_struct *work)
> +{
> +	struct mpc83xx_spi *mpc83xx_spi =
> +		container_of(work, struct mpc83xx_spi, work);
> +
> +	spin_lock_irq(&mpc83xx_spi->lock);

irq-safe.

> ...
>
> +	spin_lock(&mpc83xx_spi->lock);

not irq-safe.

Deliberate?
