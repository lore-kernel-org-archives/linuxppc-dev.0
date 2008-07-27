Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by ozlabs.org (Postfix) with ESMTP id 859FEDDDFD
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 14:04:46 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so4716507wfg.15
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 21:04:46 -0700 (PDT)
Date: Sat, 26 Jul 2008 20:11:19 -0400
From: Grant Likely <grant.likely@secretlab.ca>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] of: i2c: improve last resort compatible entry selection
Message-ID: <20080727001119.GB12191@secretlab.ca>
References: <20080714175437.GA5230@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080714175437.GA5230@polina.dev.rtsoft.ru>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 14, 2008 at 09:54:37PM +0400, Anton Vorontsov wrote:
> Currently of_i2c will select first compatible property as a last resort
> option. This isn't best choice though, because generic compatible entries
> are listed last, not first. For example, two compatible entries given for
> the MCU node:
> 
> "fsl,mc9s08qg8-mpc837xrdb", "fsl,mcu-mpc8349emitx";
> 
> Since no sane driver will ever match specific devices, what we want is
> to select most generic option (last). Then driver may call
> of_device_is_compatible() if it is really interested in details.
 
I highly suspect that this will actually be a rare condition and that
most of the time the driver you want will bind against the first entry
in the list (I'm basing this on what discussion I've seen on the list
and it seems to me that Jiri does want i2c devices to list the exact set
of chips that each driver binds against).

I'm inclined to leave it as is for now and instead handle the mpc837x
case with the fixup table in this file.  (Actually, this function has
been moved to of/base.c; so handle it in that function)

For the longer term, I think that this whole match method is a stop gap
solution until we figure out a tidy way to bind and provide device tree
data to i2c, SPI and platform devices.

g.

> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> 
> Other options are: start filling the exceptions list, or add  "linux,..."
> compatible entry to the device tree.
> 
>  drivers/of/of_i2c.c |   17 +++++++++++------
>  1 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
> index b2ccdcb..0d35a0a 100644
> --- a/drivers/of/of_i2c.c
> +++ b/drivers/of/of_i2c.c
> @@ -29,6 +29,7 @@ static int of_find_i2c_driver(struct device_node *node,
>  	int i, cplen;
>  	const char *compatible;
>  	const char *p;
> +	const char *last_wcomma = NULL;
>  
>  	/* 1. search for exception list entry */
>  	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
> @@ -45,7 +46,7 @@ static int of_find_i2c_driver(struct device_node *node,
>  	if (!compatible)
>  		return -ENODEV;
>  
> -	/* 2. search for linux,<i2c-type> entry */
> +	/* 2. search for linux,<i2c-type> entry, or remember last w/ comma */
>  	p = compatible;
>  	while (cplen > 0) {
>  		if (!strncmp(p, "linux,", 6)) {
> @@ -54,6 +55,12 @@ static int of_find_i2c_driver(struct device_node *node,
>  				    I2C_NAME_SIZE) >= I2C_NAME_SIZE)
>  				return -ENOMEM;
>  			return 0;
> +		} else {
> +			const char *comma;
> +
> +			comma = strchr(p, ',');
> +			if (comma)
> +				last_wcomma = comma + 1;
>  		}
>  
>  		i = strlen(p) + 1;
> @@ -61,12 +68,10 @@ static int of_find_i2c_driver(struct device_node *node,
>  		cplen -= i;
>  	}
>  
> -	/* 3. take fist compatible entry and strip manufacturer */
> -	p = strchr(compatible, ',');
> -	if (!p)
> +	/* 3. take last compatible entry w/ comma, manufacturer stripped */
> +	if (!last_wcomma)
>  		return -ENODEV;
> -	p++;
> -	if (strlcpy(info->type, p, I2C_NAME_SIZE) >= I2C_NAME_SIZE)
> +	if (strlcpy(info->type, last_wcomma, I2C_NAME_SIZE) >= I2C_NAME_SIZE)
>  		return -ENOMEM;
>  	return 0;
>  }
> -- 
> 1.5.5.4
