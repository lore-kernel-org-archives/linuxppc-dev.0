Return-Path: <sfalco@harris.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 968B0B70DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 08:07:17 +1000 (EST)
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 86845DDDF0
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 08:07:15 +1000 (EST)
Message-ID: <4A414E07.5050303@harris.com>
Date: Tue, 23 Jun 2009 17:49:59 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
Subject: Re: [Question] m25p80 driver versus spi clock rate
References: <4A3FEE98.60700@harris.com>
	<200906231256.19736.david-b@pacbell.net>
	<4A413BB2.8060704@harris.com>
	<200906231408.26912.david-b@pacbell.net>
In-Reply-To: <200906231408.26912.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Stefan Roese <sr@denx.de>, linux-mtd@lists.infradead.org,
	Mike Frysinger <vapier.adi@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry to cross-post this to linuxppc-dev@ozlabs.org in the middle
of the story.  I started this in linux-mtd@lists.infradead.org, but
there are OF issues here, and I'd like the PPC folks to be aware of
the issues.

David Brownell wrote:
> On Tuesday 23 June 2009, Steven A. Falco wrote:
>> David Brownell wrote:
>> The linkage appears correct - max_speed_hz is set correctly for each
>> device.  The problem is that bitbang_work won't call spi_ppc4xx_setupxfer
>> unless speed_hz is non-zero, and m25p80 has no way to alter speed_hz.
> 
> Or alternatively:  that bitbang_work is missing an initial
> call to setup_xfer before the loop *starts* its work...
> 
> I think the issue is that few other users have used this
> code with multiple devices, which had such mismatches in
> device speed that they would have noticed this bug.
> 
> See if the below patch resolves this issue.
> 

Fascinating.  I now get a fatal error:

m25p80 spi0.0: invalid bits-per-word (0)

This message comes from spi_ppc4xx_setupxfer.  I believe your patch
is doing what you intended (i.e. forcing an initial call to
spi_ppc4xx_setupxfer), but it exposes an OF / SPI linkage problem.

Namely, of_register_spi_devices does not support a bits-per-word
property, so bits-per-word is zero.

Since we had never called spi_ppc4xx_setupxfer for the m25p80, we
never saw this until now...

Here is part of spi_ppc4xx_setupxfer:

	/*
	 * Allow platform reduce the interrupt load on the CPU during SPI
	 * transfers. We do not target maximum performance, but rather allow
	 * platform to limit SPI bus frequency and interrupt rate.
	 */
	bpw = t ? t->bits_per_word : spi->bits_per_word;
	cs->speed_hz = t ? min(t->speed_hz, spi->max_speed_hz) :
		spi->max_speed_hz;

	if (bpw != 8) {
		dev_err(&spi->dev, "invalid bits-per-word (%d)\n", bpw);
		return -EINVAL;
	}

	if (cs->speed_hz == 0) {
		dev_err(&spi->dev, "invalid speed_hz (must be non-zero)\n");
		return -EINVAL;
	}

Actually, the problem is not entirely with of_register_spi_devices.
bitbang_work will call spi_ppc4xx_setupxfer with a non-null 
spi_transfer.  So, the above code will always set bpw based on
t->bits_per_word.  If t->bits_per_word is zero, it wouldn't even matter
if of_register_spi_devices set spi->bits_per_word, because the
transfer would override it.

How about:

	bpw = t && t->bits_per_word ? t->bits_per_word : spi->bits_per_word;

Now, t->bits_per_word would have to be non-zero in order to override
spi->bits_per_word.

We would still need a patch to of_register_spi_devices to allow (require)
a bits-per-word property, along with device tree patches to add the
property.  But that should take care of it.

I'm adding the ppc list as a CC, since this is turning into an OF
discussion.

	Steve

> - Dave
> 
> 
> ---
>  drivers/spi/spi_bitbang.c |   22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> --- a/drivers/spi/spi_bitbang.c
> +++ b/drivers/spi/spi_bitbang.c
> @@ -258,6 +258,11 @@ static void bitbang_work(struct work_str
>  	struct spi_bitbang	*bitbang =
>  		container_of(work, struct spi_bitbang, work);
>  	unsigned long		flags;
> +	int			do_setup = -1;
> +	int			(*setup_transfer)(struct spi_device *,
> +					struct spi_transfer *);
> +
> +	setup_transfer = bitbang->setup_transfer;
>  
>  	spin_lock_irqsave(&bitbang->lock, flags);
>  	bitbang->busy = 1;
> @@ -269,8 +274,6 @@ static void bitbang_work(struct work_str
>  		unsigned		tmp;
>  		unsigned		cs_change;
>  		int			status;
> -		int			(*setup_transfer)(struct spi_device *,
> -						struct spi_transfer *);
>  
>  		m = container_of(bitbang->queue.next, struct spi_message,
>  				queue);
> @@ -286,19 +289,19 @@ static void bitbang_work(struct work_str
>  		tmp = 0;
>  		cs_change = (spi != bitbang->exclusive);
>  		status = 0;
> -		setup_transfer = NULL;
>  
>  		list_for_each_entry (t, &m->transfers, transfer_list) {
>  
> -			/* override or restore speed and wordsize */
> -			if (t->speed_hz || t->bits_per_word) {
> -				setup_transfer = bitbang->setup_transfer;
> +			/* override speed or wordsize? */
> +			if (t->speed_hz || t->bits_per_word)
> +				do_setup = 1;
> +
> +			/* init or override transfer params */
> +			if (do_setup != 0) {
>  				if (!setup_transfer) {
>  					status = -ENOPROTOOPT;
>  					break;
>  				}
> -			}
> -			if (setup_transfer) {
>  				status = setup_transfer(spi, t);
>  				if (status < 0)
>  					break;
> @@ -362,8 +365,9 @@ static void bitbang_work(struct work_str
>  		m->status = status;
>  
>  		/* restore speed and wordsize */
> -		if (setup_transfer)
> +		if (do_setup == 1)
>  			setup_transfer(spi, NULL);
> +		do_setup = 0;
>  
>  		/* normally deactivate chipselect ... unless no error and
>  		 * cs_change has hinted that the next message will probably


-- 
A: Because it makes the logic of the discussion difficult to follow.
Q: Why shouldn't I top post?
A: No.
Q: Should I top post?
