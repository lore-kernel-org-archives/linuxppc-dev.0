Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 80261DDE28
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 20:22:05 +1100 (EST)
Date: Fri, 17 Oct 2008 11:21:25 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/7] i2c: add info->archdata field
Message-ID: <20081017112125.1f2c9d94@hyperion.delvare>
In-Reply-To: <20081016171253.GB5515@oksana.dev.rtsoft.ru>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<20081016171253.GB5515@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Anton,

On Thu, 16 Oct 2008 21:12:53 +0400, Anton Vorontsov wrote:
> If present the info->archdata is copied into the dev->archdata.
> Some (OpenFirmware) platforms need it.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/i2c/i2c-core.c |    3 +++
>  include/linux/i2c.h    |    2 ++
>  2 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 42e852d..5a485c2 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -266,6 +266,9 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
>  
>  	client->dev.platform_data = info->platform_data;
>  
> +	if (info->archdata)
> +		client->dev.archdata = *info->archdata;
> +
>  	client->flags = info->flags;
>  	client->addr = info->addr;
>  	client->irq = info->irq;
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 0611512..3e358d3 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -240,6 +240,7 @@ static inline void i2c_set_clientdata (struct i2c_client *dev, void *data)
>   * @flags: to initialize i2c_client.flags
>   * @addr: stored in i2c_client.addr
>   * @platform_data: stored in i2c_client.dev.platform_data
> + * @archdata: copied into i2c_client.dev.archdata
>   * @irq: stored in i2c_client.irq
>   *
>   * I2C doesn't actually support hardware probing, although controllers and
> @@ -259,6 +260,7 @@ struct i2c_board_info {
>  	unsigned short	flags;
>  	unsigned short	addr;
>  	void		*platform_data;
> +	struct dev_archdata	*archdata;
>  	int		irq;
>  };
>  

No objection from me:

Acked-by: Jean Delvare <khali@linux-fr.org>

Let me know if I should push this patch upstream myself.

-- 
Jean Delvare
