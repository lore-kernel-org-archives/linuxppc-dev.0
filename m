Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 4B163B7088
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 01:33:03 +1100 (EST)
Date: Thu, 8 Oct 2009 18:33:01 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RFC] misc/at24: add experimental OF support for the generic
	eeprom driver
Message-ID: <20091008143301.GA6084@oksana.dev.rtsoft.ru>
References: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-i2c@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 08, 2009 at 04:04:32PM +0200, Wolfram Sang wrote:
> As Anton introduced archdata support, I wondered if this is a suitable way to
> handle the platform_data/devicetree_property-dualism (at least for some
> drivers).

Yes, we handle OF in a similar way for mmc_spi driver. Though,

[...]
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -22,6 +22,9 @@
[...]
> +#ifdef CONFIG_OF_I2C
> +#include <linux/of.h>
> +#endif
[..]
> +#ifdef CONFIG_OF_I2C
> +static void at24_get_ofdata(struct i2c_client *client, struct at24_platform_data *chip)
> +{
> +	const u32 *val;
> +	struct device_node *node = dev_archdata_get_node(&client->dev.archdata);
> +
> +	if (node) {
> +		if (of_get_property(node, "read-only", NULL))
> +			chip->flags |= AT24_FLAG_READONLY;
> +		val = of_get_property(node, "pagesize", NULL);
> +		if (val)
> +			chip->page_size = *val;
> +	}
> +}
> +#else
> +static void at24_get_ofdata(struct i2c_client *client, struct at24_platform_data *chip)
> +{ }
> +#endif

#ifdefs are ugly in .c files. I'd suggest to move the OF code
into a separate file. As an example, see

commit 9c43df57910bbba540a6cb5c9132302a9ea5f41a
Author: Anton Vorontsov <avorontsov@ru.mvista.com>
Date:   Tue Dec 30 18:15:28 2008 +0300

    mmc_spi: Add support for OpenFirmware bindings

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
