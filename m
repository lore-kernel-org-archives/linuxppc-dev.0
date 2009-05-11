Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <4A08939D.5050203@am.sony.com>
Date: Mon, 11 May 2009 14:07:41 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] ps3: remove driver_data direct access of struct device
References: <4A087DB9.50305@gmail.com>
In-Reply-To: <4A087DB9.50305@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Geert.Uytterhoeven@sonycom.com, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Roel,

On 05/11/2009 12:34 PM, Roel Kluin wrote:
> To avoid direct access to the driver_data pointer in struct device, the
> functions dev_get_drvdata() and dev_set_drvdata() should be used.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> Please review. especially note that I removed a
> kfree(dev->sbd.core.driver_data);
> Is that correct?

Comment below.

>  arch/powerpc/include/asm/ps3.h |    4 ++--
>  drivers/char/ps3flash.c        |   11 +++++------
>  drivers/scsi/ps3rom.c          |   10 +++++-----
>  drivers/video/ps3fb.c          |    6 +++---
>  4 files changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/ps3.h b/arch/powerpc/include/asm/ps3.h
> index cdb6fd8..a55717e 100644
> --- a/arch/powerpc/include/asm/ps3.h
> +++ b/arch/powerpc/include/asm/ps3.h
> @@ -421,12 +421,12 @@ static inline struct ps3_system_bus_driver *
>  static inline void ps3_system_bus_set_driver_data(
>  	struct ps3_system_bus_device *dev, void *data)
>  {
> -	dev->core.driver_data = data;
> +	dev_set_drvdata(&dev->core, data);
>  }
>  static inline void *ps3_system_bus_get_driver_data(
>  	struct ps3_system_bus_device *dev)
>  {
> -	return dev->core.driver_data;
> +	return dev_get_drvdata(&dev->core);
>  }
>  
>  /* These two need global scope for get_dma_ops(). */
> diff --git a/drivers/char/ps3flash.c b/drivers/char/ps3flash.c
> index afbe456..6083032 100644
> --- a/drivers/char/ps3flash.c
> +++ b/drivers/char/ps3flash.c
> @@ -108,7 +108,7 @@ static ssize_t ps3flash_read(struct file *file, char __user *buf, size_t count,
>  			     loff_t *pos)
>  {
>  	struct ps3_storage_device *dev = ps3flash_dev;
> -	struct ps3flash_private *priv = dev->sbd.core.driver_data;
> +	struct ps3flash_private *priv = dev_get_drvdata(&dev->sbd.core);

These should all be using ps3_system_bus_get_driver_data() and
ps3_system_bus_set_driver_data():

  struct ps3flash_private *priv = ps3_system_bus_get_driver_data(&dev->sbd)

> @@ -404,8 +404,7 @@ static int ps3flash_remove(struct ps3_system_bus_device *_dev)
>  
>  	misc_deregister(&ps3flash_misc);
>  	ps3stor_teardown(dev);
> -	kfree(dev->sbd.core.driver_data);
> -	dev->sbd.core.driver_data = NULL;
> +	dev_set_drvdata(&dev->sbd.core, NULL);

It seems that will result in a memory leak.  Why did you
think the kfree() should be removed?

Won't this work?

	kfree(ps3_system_bus_get_driver_data(&dev->sbd));
	ps3_system_bus_set_driver_data(&dev->sbd, NULL);

>  	ps3flash_dev = NULL;
>  	return 0;
>  }

-Geoff
