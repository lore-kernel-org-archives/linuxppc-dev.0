Return-Path: <computersforpeace@gmail.com>
Received: from mail-oa0-x22a.google.com (mail-oa0-x22a.google.com
 [IPv6:2607:f8b0:4003:c02::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 817CB2C0096
 for <linuxppc-dev@ozlabs.org>; Sat,  4 Jan 2014 06:07:26 +1100 (EST)
Received: by mail-oa0-f42.google.com with SMTP id i4so16446886oah.15
 for <linuxppc-dev@ozlabs.org>; Fri, 03 Jan 2014 11:07:24 -0800 (PST)
Date: Fri, 3 Jan 2014 11:07:20 -0800
From: Brian Norris <computersforpeace@gmail.com>
To: Hou Zhiqiang <b48286@freescale.com>
Subject: Re: [PATCH v2] mtd: m25p80: Add Power Management support
Message-ID: <20140103190720.GH5631@ld-irv-0074>
References: <1386826716-20476-1-git-send-email-b48286@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386826716-20476-1-git-send-email-b48286@freescale.com>
Cc: Marek Vasut <marex@denx.de>, linuxppc-dev@ozlabs.org,
 linux-mtd@lists.infradead.org, scottwood@freescale.com,
 Mingkai.Hu@freescale.com, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 12, 2013 at 01:38:36PM +0800, Hou Zhiqiang wrote:
> Add PM support using callback function suspend and resume in
> .driver.pm of spi_driver.
> 
> Signed-off-by: Hou Zhiqiang <b48286@freescale.com>
> ---
> v2:
>  - Replace .driver.suspend and .driver.resume with .driver.pm
>  - Use CONFIG_PM_SLEEP instead of CONFIG_PM

Just noticed v2... My v1 comments still apply.

> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -1128,11 +1130,46 @@ static int m25p_remove(struct spi_device *spi)
...
> +static const struct dev_pm_ops m25p_pm = {
> +	SET_SYSTEM_SLEEP_PM_OPS(m25p_suspend, m25p_resume)
> +};

This could just be:

static SIMPLE_DEV_PM_OPS(m25p_pm_ops, m25p_suspend, m25p_resume);

>  
>  static struct spi_driver m25p80_driver = {
>  	.driver = {
>  		.name	= "m25p80",
>  		.owner	= THIS_MODULE,
> +		.pm	= &m25p_pm,
>  	},
>  	.id_table	= m25p_ids,
>  	.probe	= m25p_probe,

Brian
