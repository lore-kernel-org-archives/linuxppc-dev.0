Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 001/001 Updated] PMAC HD runtime blinking control
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Cedric Pradalier <cedric.pradalier@inrialpes.fr>
In-Reply-To: <20060123233823.3f0dbad5.cedric.pradalier@inrialpes.fr>
References: <20060122121907.792abc72.cedric.pradalier@free.fr>
	<1137898193.12998.83.camel@localhost.localdomain>
	<20060123233823.3f0dbad5.cedric.pradalier@inrialpes.fr>
Content-Type: text/plain
Date: Tue, 24 Jan 2006 00:47:16 +1100
Message-Id: <1138024037.4907.24.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The key I could not understand was that hwif->gendev is
> only initialised in the probe. So I had to move the
> device creation after that.
> 
> Currently, it is blinking by default. Should it be that
> way? I guess so, since it is activated by a kernel config
> option. It is easy to change if required.

Yes. In fact, by enabled default for ATA disks and by disabled for ATAPI
would make sense...

Also, we should think a bit about the file name... "blinking_led" isn't
terrific for something that will end up in a non-ppc specific location.
Or maybe on the contrary it's good ... what about "activity_led"
rather ?

> Anyway, here is the updated patch.
> 
> signed-off-by: Cedric Pradalier <cedric.pradalier@free.fr>
> ---
> --- drivers/ide/ppc/pmac.c.orig	2006-01-03 13:21:10.000000000 +1000
> +++ drivers/ide/ppc/pmac.c	2006-01-23 23:32:18.000000000 +1000
> @@ -36,6 +36,11 @@
>  #include <linux/pmu.h>
>  #include <linux/scatterlist.h>
>  
> +#ifdef CONFIG_BLK_DEV_IDE_PMAC_BLINK
> +#include <linux/device.h>
> +#include <asm/of_device.h>
> +#endif
> +
>  #include <asm/prom.h>
>  #include <asm/io.h>
>  #include <asm/dbdma.h>
> @@ -427,6 +432,15 @@ static void pmac_ide_kauai_selectproc(id
>  
>  #ifdef CONFIG_BLK_DEV_IDE_PMAC_BLINK
>  
> +MODULE_AUTHOR("Paul Mackerras & Ben. Herrenschmidt");
> +MODULE_DESCRIPTION("Support for IDE interfaces on PowerMacs");
> +MODULE_LICENSE("GPL");
> +
> +static int blinking_led = 1;
> +module_param_named(noblink,blinking_led, invbool, 0666);
> +MODULE_PARM_DESC(noblink,"Enable/Disable blinking led [Default: enabled]");
> +
> +
>  /* Set to 50ms minimum led-on time (also used to limit frequency
>   * of requests sent to the PMU
>   */
> @@ -437,8 +451,7 @@ static spinlock_t pmu_blink_lock;
>  static unsigned long pmu_blink_stoptime;
>  static int pmu_blink_ledstate;
>  static struct timer_list pmu_blink_timer;
> -static int pmu_ide_blink_enabled;
> -
> +static int pmu_ide_blink_enabled = 0;
>  
>  static void
>  pmu_hd_blink_timeout(unsigned long data)
> @@ -468,6 +481,8 @@ static void
>  pmu_hd_kick_blink(void *data, int rw)
>  {
>  	unsigned long flags;
> +	if (!blinking_led)
> +		return;
>  	
>  	pmu_blink_stoptime = jiffies + PMU_HD_BLINK_TIME;
>  	wmb();
> @@ -483,6 +498,26 @@ pmu_hd_kick_blink(void *data, int rw)
>  	spin_unlock_irqrestore(&pmu_blink_lock, flags);
>  }
>  
> +static ssize_t show_blinkingled_activity(struct device *dev, struct device_attribute *attr, char *buf)\
> +{  
> +	return sprintf(buf, "%c\n", blinking_led?'1':'0'); 
> +}
> +
> +static ssize_t set_blinkingled_activity(struct device *dev, struct device_attribute *attr, 
> +		const char *buf, size_t count)
> +{
> +	int blink;
> +	if (sscanf (buf, "%d", &blink) != 1)
> +		return -EINVAL;
> +	blinking_led = (blink != 0);
> +	printk(KERN_INFO "pmac blinking led initialized (blink %s)\n",
> +			blinking_led?"enabled":"disabled");
> +	return count;
> +}
> +
> +static DEVICE_ATTR (blinking_led, S_IRUGO | S_IWUSR, 
> +		show_blinkingled_activity, set_blinkingled_activity);
> +
>  static int
>  pmu_hd_blink_init(void)
>  {
> @@ -516,6 +551,9 @@ pmu_hd_blink_init(void)
>  	init_timer(&pmu_blink_timer);
>  	pmu_blink_timer.function = pmu_hd_blink_timeout;
>  
> +	printk(KERN_INFO "pmac blinking led initialized (blink %s)\n",
> +			blinking_led?"enabled":"disabled");
> +
>  	return 1;
>  }
>  
> @@ -1271,7 +1309,7 @@ static int
>  pmac_ide_setup_device(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif)
>  {
>  	struct device_node *np = pmif->node;
> -	int *bidp, i;
> +	int *bidp;
>  
>  	pmif->cable_80 = 0;
>  	pmif->broken_dma = pmif->broken_dma_warn = 0;
> @@ -1401,6 +1439,12 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
>  	/* We probe the hwif now */
>  	probe_hwif_init(hwif);
>  
> +#ifdef CONFIG_BLK_DEV_IDE_PMAC_BLINK
> +	/* We wait till here to have the gendev initialized in hwif */
> +	device_create_file (&hwif->gendev, &dev_attr_blinking_led);
> +#endif
> +
> +
>  	return 0;
>  }
>  
