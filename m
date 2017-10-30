Return-Path: <boris.brezillon@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3yQSrQ6rp2zDrjD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 19:51:18 +1100 (AEDT)
Date: Mon, 30 Oct 2017 09:51:06 +0100
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 stewart@linux.vnet.ibm.com, computersforpeace@gmail.com,
 dwmw2@infradead.org, sjitindarsingh@gmail.com
Subject: Re: [PATCH v4 03/10] mtd: powernv_flash: Remove pointless goto in
 driver init
Message-ID: <20171030095106.7130c418@bbrezillon>
In-Reply-To: <20171010033302.20854-4-cyrilbur@gmail.com>
References: <20171010033302.20854-1-cyrilbur@gmail.com>
 <20171010033302.20854-4-cyrilbur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 10 Oct 2017 14:32:55 +1100
Cyril Bur <cyrilbur@gmail.com> wrote:

Can you please add a short description here?

Once done you can add

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
>  drivers/mtd/devices/powernv_flash.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
> index ca3ca6adf71e..4dd3b5d2feb2 100644
> --- a/drivers/mtd/devices/powernv_flash.c
> +++ b/drivers/mtd/devices/powernv_flash.c
> @@ -227,21 +227,20 @@ static int powernv_flash_probe(struct platform_device *pdev)
>  	int ret;
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> -	if (!data) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> +	if (!data)
> +		return -ENOMEM;
> +
>  	data->mtd.priv = data;
>  
>  	ret = of_property_read_u32(dev->of_node, "ibm,opal-id", &(data->id));
>  	if (ret) {
>  		dev_err(dev, "no device property 'ibm,opal-id'\n");
> -		goto out;
> +		return ret;
>  	}
>  
>  	ret = powernv_flash_set_driver_info(dev, &data->mtd);
>  	if (ret)
> -		goto out;
> +		return ret;
>  
>  	dev_set_drvdata(dev, data);
>  
> @@ -250,10 +249,7 @@ static int powernv_flash_probe(struct platform_device *pdev)
>  	 * with an ffs partition at the start, it should prove easier for users
>  	 * to deal with partitions or not as they see fit
>  	 */
> -	ret = mtd_device_register(&data->mtd, NULL, 0);
> -
> -out:
> -	return ret;
> +	return mtd_device_register(&data->mtd, NULL, 0);
>  }
>  
>  /**
