Return-Path: <computersforpeace@gmail.com>
Received: from mail-ig0-x231.google.com (mail-ig0-x231.google.com
 [IPv6:2607:f8b0:4001:c05::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 95FF12C00A5
 for <linuxppc-dev@ozlabs.org>; Sat,  4 Jan 2014 06:00:56 +1100 (EST)
Received: by mail-ig0-f177.google.com with SMTP id uy17so1787997igb.4
 for <linuxppc-dev@ozlabs.org>; Fri, 03 Jan 2014 11:00:53 -0800 (PST)
Date: Fri, 3 Jan 2014 11:00:49 -0800
From: Brian Norris <computersforpeace@gmail.com>
To: Hou Zhiqiang <b48286@freescale.com>
Subject: Re: [PATCH] mtd: m25p80: Add Power Management support
Message-ID: <20140103190049.GG5631@ld-irv-0074>
References: <1386749970-22021-1-git-send-email-b48286@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386749970-22021-1-git-send-email-b48286@freescale.com>
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

On Wed, Dec 11, 2013 at 04:19:30PM +0800, Hou Zhiqiang wrote:
> Add PM support using callback function suspend and resume in .driver of
> spi_driver.
> 
> Signed-off-by: Hou Zhiqiang <b48286@freescale.com>
> ---
>  drivers/mtd/devices/m25p80.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index 7eda71d..b0c2b8c 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -66,6 +66,8 @@
>  
>  /* Used for Spansion flashes only. */
>  #define	OPCODE_BRWR		0x17	/* Bank register write */
> +#define	OPCODE_DP		0xb9	/* Enter deep power down mode */
> +#define	OPCODE_RES		0xab	/* Exit deep power down mode */

Where did you get these opcodes from? They are not in the Spansion
datasheets I'm reading. And in fact, they are overloaded as RES (Read
Electronic Signature, 0xab) and Bank Register Access (0xb9) in the
datasheet I'm looking at. So this patch is wrong.

Also, can you describe the purpose of these "deep power down" modes?
I've never seen PM states where the *flash* needs to be put into a lower
power mode. Typically the flash is pretty low-power when idle, and it
may even be powered off completely when the system enters a lower-power
state. Anyway, please describe why this patch is needed.

>  
>  /* Status Register bits. */
>  #define	SR_WIP			1	/* Write in progress */
> @@ -1128,11 +1130,46 @@ static int m25p_remove(struct spi_device *spi)
>  	return mtd_device_unregister(&flash->mtd);
>  }
>  
> +#ifdef CONFIG_PM
> +static int m25p_suspend(struct device *dev, pm_message_t mesg)
> +{
> +	struct m25p *flash = dev_get_drvdata(dev);
> +	int ret;
> +
> +	flash->command[0] = OPCODE_DP;

As mentioned above, this opcode is not recognized by many flash
supported in this driver. So we might want one or more of the following:

 (1) to assign different suspend/resume opcodes for use in
     m25p_suspend/resume
 (2) to provide over-loadable callbacks so that different flash could
     use different suspend/resume routines

And of course, we need to avoid sending these commands at all to
unsupported flash.

> +	mutex_lock(&flash->lock);
> +	/* Wait until finished previous write/erase command. */
> +	ret = wait_till_ready(flash);
> +	if (ret) {
> +		mutex_unlock(&flash->lock);
> +		return ret;
> +	}
> +	ret = spi_write(flash->spi, flash->command, 1);
> +	mutex_unlock(&flash->lock);
> +
> +	return ret;
> +}
> +
> +static int m25p_resume(struct device *dev)
> +{
> +	struct m25p *flash = dev_get_drvdata(dev);
> +	int ret;
> +
> +	flash->command[0] = OPCODE_RES;
> +	ret = spi_write(flash->spi, flash->command, 1);
> +
> +	return ret;
> +}
> +#endif /* CONFIG_PM */
>  
>  static struct spi_driver m25p80_driver = {
>  	.driver = {
>  		.name	= "m25p80",
>  		.owner	= THIS_MODULE,
> +#ifdef CONFIG_PM
> +		.suspend = m25p_suspend,
> +		.resume = m25p_resume,
> +#endif
>  	},
>  	.id_table	= m25p_ids,
>  	.probe	= m25p_probe,

Brian
