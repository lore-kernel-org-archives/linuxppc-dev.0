Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (gateway-1237.mvista.com [206.112.117.35])
	by ozlabs.org (Postfix) with SMTP id 7351DB7BEC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Dec 2009 23:37:15 +1100 (EST)
Message-ID: <4B1658C8.5020401@ru.mvista.com>
Date: Wed, 02 Dec 2009 15:08:40 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/5] powerpc/macio: Rework hotplug media bay support
References: <20091202003628.CF4321007E0@ozlabs.org>
In-Reply-To: <20091202003628.CF4321007E0@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	jeff@garzik.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

Benjamin Herrenschmidt wrote:

> The hotplug mediabay has tendrils deep into drivers/ide code
> which makes a libata port reather difficult. In addition it's
> ugly and could be done better.
>
> This reworks the interface between the mediabay and the rest
> of the world so that:
>
>    - Any macio_driver can now have a mediabay_event callback
> which will be called when that driver sits on a mediabay and
> it's been either plugged or unplugged. The device type is
> passed as an argument. We can now move all the IDE cruft
> into the IDE driver itself
>
>    - A check_media_bay() function can be used to take a peek
> at the type of device currently in the bay if any, a cleaner
> variant of the previous function with the same name.
>
>    - A pair of lock/unlock functions are exposed to allow the
> IDE driver to block the hotplug callbacks during the initial
> setup and probing of the bay in order to avoid nasty race
> conditions.
>
>    - The mediabay code no longer needs to spin on the status
> register of the IDE interface when it detects an IDE device,
> this is done just fine by the IDE code itself
>
> Overall, less code, simpler, and allows for another driver
> than our old drivers/ide based one.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>   

   Some grammar/style nitpicking...

> Index: linux-work/arch/powerpc/include/asm/mediabay.h
> ===================================================================
> --- linux-work.orig/arch/powerpc/include/asm/mediabay.h	2009-12-01 17:57:00.000000000 +1100
> +++ linux-work/arch/powerpc/include/asm/mediabay.h	2009-12-01 18:00:28.000000000 +1100
> @@ -17,26 +17,31 @@
>  #define MB_POWER	6	/* media bay contains a Power device (???) */
>  #define MB_NO		7	/* media bay contains nothing */
>  
> -/* Number of bays in the machine or 0 */
> -extern int media_bay_count;
> +struct macio_dev;
>  
> -#ifdef CONFIG_BLK_DEV_IDE_PMAC
> -#include <linux/ide.h>
> +#ifdef CONFIG_PMAC_MEDIABAY
>  
> -int check_media_bay_by_base(unsigned long base, int what);
> -/* called by IDE PMAC host driver to register IDE controller for media bay */
> -int media_bay_set_ide_infos(struct device_node *which_bay, unsigned long base,
> -			    int irq, ide_hwif_t *hwif);
> -
> -int check_media_bay(struct device_node *which_bay, int what);
> +/* Check the content type of the bay, returns MB_NO if the bay is still
> + * transitionning
> + */
>   

   Only "transitioning".

>  
> -int check_media_bay_by_base(unsigned long base, int what)
> +int check_media_bay(struct macio_dev *baydev)
>  {
> -	int	i;
> +	struct media_bay_info* bay;
> +	int id;
>  
> -	for (i=0; i<media_bay_count; i++)
> -		if (media_bays[i].mdev && base == (unsigned long) media_bays[i].cd_base) {
> -			if ((what == media_bays[i].content_id) && media_bays[i].state == mb_up)
> -				return 0;
> -			media_bays[i].cd_index = -1;
> -			return -EINVAL;
> -		} 
> +	if (baydev == NULL)
> +		return MB_NO;
>  
> -	return -ENODEV;
> +	/* This returns an instant snapshot, not locking, sine
>   

   Only "since".

> Index: linux-work/drivers/block/swim3.c
> ===================================================================
> --- linux-work.orig/drivers/block/swim3.c	2009-12-01 17:57:00.000000000 +1100
> +++ linux-work/drivers/block/swim3.c	2009-12-01 18:00:28.000000000 +1100
>   
[...]
> @@ -303,14 +303,13 @@ static int swim3_readbit(struct floppy_s
>  static void do_fd_request(struct request_queue * q)
>  {
>  	int i;
> -	for(i=0;i<floppy_count;i++)
> -	{
> -#ifdef CONFIG_PMAC_MEDIABAY
> -		if (floppy_states[i].media_bay &&
> -			check_media_bay(floppy_states[i].media_bay, MB_FD))
> +
> +	for(i=0; i<floppy_count; i++) {
>   

   You could insert spaces around operators here, while at it...

MBR, Sergei
