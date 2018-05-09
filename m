Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40h4Bt0mvfzF2S2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 04:09:58 +1000 (AEST)
Date: Wed, 9 May 2018 10:29:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, jdelvare@suse.com,
 stewart@linux.vnet.ibm.com
Subject: Re: [PATCH 2/3] hwmon: (ibmpowernv): Add support to read 64 bit
 sensors
Message-ID: <20180509172926.GA20996@roeck-us.net>
References: <1525688738-9185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1525688738-9185-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525688738-9185-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 07, 2018 at 03:55:37PM +0530, Shilpasri G Bhat wrote:
> The firmware has supported for reading sensor values of size u32.
> This patch adds support to use newer firmware functions which allows
> to read the sensors of size u64.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

I won't apply for the time being since it depends on patch 1/3 which is
outside hwmon.

> ---
>  drivers/hwmon/ibmpowernv.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index 5ccdd0b..74d9b5a 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -101,9 +101,10 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
>  	struct sensor_data *sdata = container_of(devattr, struct sensor_data,
>  						 dev_attr);
>  	ssize_t ret;
> -	u32 x;
> +	u64 x;
> +
> +	ret =  opal_get_sensor_data_u64(sdata->id, &x);
>  
> -	ret = opal_get_sensor_data(sdata->id, &x);
>  	if (ret)
>  		return ret;
>  
> @@ -114,7 +115,7 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
>  	else if (sdata->type == POWER_INPUT)
>  		x *= 1000000;
>  
> -	return sprintf(buf, "%u\n", x);
> +	return sprintf(buf, "%llu\n", x);
>  }
>  
>  static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
