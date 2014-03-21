Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 54C502C0082
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2014 04:35:14 +1100 (EST)
Message-ID: <1395423296.12479.354.camel@snotra.buserror.net>
Subject: Re: [PATCH] mtd: m25p80: Modify the name of mtd_info
From: Scott Wood <scottwood@freescale.com>
To: Hou Zhiqiang <B48286@freescale.com>
Date: Fri, 21 Mar 2014 12:34:56 -0500
In-Reply-To: <1395400578-5637-1-git-send-email-B48286@freescale.com>
References: <1395400578-5637-1-git-send-email-B48286@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, mingkai.hu@freescale.com,
 linux-mtd@lists.infradead.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-03-21 at 19:16 +0800, Hou Zhiqiang wrote:
> @@ -1009,8 +1012,17 @@ static int m25p_probe(struct spi_device *spi)
>  
>  	if (data && data->name)
>  		flash->mtd.name = data->name;
> -	else
> -		flash->mtd.name = dev_name(&spi->dev);
> +	else{

Whitespace

> +		ret = of_address_to_resource(mnp, 0, &res);
> +		if (ret) {
> +			dev_err(&spi->dev, "failed to get spi master resource\n");
> +			return ret;
> +		}
> +		flash->mtd.name = kasprintf(GFP_KERNEL, "spi%x.%d",
> +				(unsigned)res.start, spi->chip_select);

Don't use "unsigned" by itself.  Don't cast physical addresses to
"unsigned int" -- use "unsigned long long".

-Scott
