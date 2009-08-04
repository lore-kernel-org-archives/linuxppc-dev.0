Return-Path: <david-b@pacbell.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DF0B3B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 10:28:33 +1000 (EST)
Received: from n13a.bullet.mail.mud.yahoo.com (n13a.bullet.mail.mud.yahoo.com
	[68.142.207.51]) by ozlabs.org (Postfix) with SMTP id E4A63DDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 10:28:32 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/6] mtd: m25p80: Convert to device table matching
Date: Mon, 3 Aug 2009 19:54:50 -0700
References: <20090731003957.GA23982@oksana.dev.rtsoft.ru>
	<20090731004100.GB8371@oksana.dev.rtsoft.ru>
In-Reply-To: <20090731004100.GB8371@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200908031954.50955.david-b@pacbell.net>
Cc: Ben Dooks <ben@fluff.org>, linux-kernel@vger.kernel.org,
	lm-sensors@lm-sensors.org, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, Jean Delvare <khali@linux-fr.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 30 July 2009, Anton Vorontsov wrote:
> This patch converts the m25p80 driver so that now it uses .id_table
> for device matching, making it properly detect devices on OpenFirmware
> platforms (prior to this patch the driver misdetected non-JEDEC chips,
> seeing all chips as "m25p80").

I suspect "detect" is a misnomer there.  It only "detects" JEDEC chips.
All others got explicit declarations ... so if there's misbehavior for
other chips, it's because those declarations were poorly handled.  Maybe
they were not properly flagged as non-JDEC

 
> Also, now jedec_probe() only does jedec probing, nothing else. If it
> is not able to detect a chip, NULL is returned and the driver fall
> backs to the information specified by the platform (platform_data, or
> exact ID).

I'd rather keep the warning, so there's a clue about what's really
going on:  JEDEC chip found, but its ID is not handled.


> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/mtd/devices/m25p80.c |  146 +++++++++++++++++++++++-------------------
>  1 files changed, 80 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index 10ed195..0d74b38 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> 			... deletia ...

> @@ -481,74 +480,83 @@ struct flash_info {
>  #define	SECT_4K		0x01		/* OPCODE_BE_4K works uniformly */
>  };
>  
> +#define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors, _flags)	\
> +	((kernel_ulong_t)&(struct flash_info) {				\
> +		.jedec_id = (_jedec_id),				\
> +		.ext_id = (_ext_id),					\
> +		.sector_size = (_sector_size),				\
> +		.n_sectors = (_n_sectors),				\
> +		.flags = (_flags),					\
> +	})

Anonymous inlined structures ... kind of ugly, but I can
understand why you might not want to declare and name a
few dozen single-use structures.


>  
>  /* NOTE: double check command sets and memory organization when you add
>   * more flash chips.  This current list focusses on newer chips, which
>   * have been converging on command sets which including JEDEC ID.
>   */
> -static struct flash_info __devinitdata m25p_data [] = {
> -
> +static const struct spi_device_id m25p_ids[] = {
>  	/* Atmel -- some are (confusingly) marketed as "DataFlash" */
> -	{ "at25fs010",  0x1f6601, 0, 32 * 1024, 4, SECT_4K, },
> -	{ "at25fs040",  0x1f6604, 0, 64 * 1024, 8, SECT_4K, },
> +	{ "at25fs010",  INFO(0x1f6601, 0, 32 * 1024, 4, SECT_4K) },
> +	{ "at25fs040",  INFO(0x1f6604, 0, 64 * 1024, 8, SECT_4K) },
>  
> 		... deletia ...
>  

> @@ -596,6 +602,7 @@ static struct flash_info *__devinit jedec_probe(struct spi_device *spi)
>   */
>  static int __devinit m25p_probe(struct spi_device *spi)
>  {
> +	const struct spi_device_id	*id;
>  	struct flash_platform_data	*data;
>  	struct m25p			*flash;
>  	struct flash_info		*info;
> @@ -608,32 +615,38 @@ static int __devinit m25p_probe(struct spi_device *spi)
>  	 */
>  	data = spi->dev.platform_data;
>  	if (data && data->type) {

At this point I wonder why you're not changing the probe sequence
more.  Get "id" and then "id" here.  If it's for "m25p80" assume
it's an old-style board init and do the current logic.  Else just
verify "info".

There's a new error case of course:  new-style but data->type
doesn't match id->name.


> -		for (i = 0, info = m25p_data;
> -				i < ARRAY_SIZE(m25p_data);
> -				i++, info++) {
> -			if (strcmp(data->type, info->name) == 0)
> -				break;
> +		for (i = 0; i < ARRAY_SIZE(m25p_ids) - 1; i++) {
> +			id = &m25p_ids[i];
> +			info = (void *)m25p_ids[i].driver_data;
> +			if (strcmp(data->type, id->name))
> +				continue;
> +			break;
>  		}
>  
>  		/* unrecognized chip? */
> -		if (i == ARRAY_SIZE(m25p_data)) {
> +		if (i == ARRAY_SIZE(m25p_ids) - 1) {

Better:  "if (info == NULL) ..."   You've got all the pointers
in hand; don't use indices.

>  			DEBUG(MTD_DEBUG_LEVEL0, "%s: unrecognized id %s\n",
>  					dev_name(&spi->dev), data->type);
>  			info = NULL;
>  
>  		/* recognized; is that chip really what's there? */
>  		} else if (info->jedec_id) {
> -			struct flash_info	*chip = jedec_probe(spi);
> +			id = jedec_probe(spi);
>  
> -			if (!chip || chip != info) {
> +			if (id != &m25p_ids[i]) {

Again, don't use indices except during the lookup.

>  				dev_warn(&spi->dev, "found %s, expected %s\n",
> -						chip ? chip->name : "UNKNOWN",
> -						info->name);
> +						id ? id->name : "UNKNOWN",
> +						m25p_ids[i].name);
>  				info = NULL;
>  			}
>  		}
> -	} else
> -		info = jedec_probe(spi);
> +	} else {
> +		id = jedec_probe(spi);
> +		if (!id)
> +			id = spi_get_device_id(spi);
> +
> +		info = (void *)id->driver_data;
> +	}
>  
>  	if (!info)
>  		return -ENODEV;
