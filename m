Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 707D2DDE1C
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 09:22:39 +1000 (EST)
Subject: Re: [PATCH 1/2] adb: create class devices for each adb device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Aristeu Rozanski <aris@ruivo.org>
In-Reply-To: <20070716205319.GC30232@cathedrallabs.org>
References: <20070716205319.GC30232@cathedrallabs.org>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 09:22:33 +1000
Message-Id: <1184628153.25235.111.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-07-16 at 16:53 -0400, Aristeu Rozanski wrote:
> This patch adds a class device for each adb device that has a handler.
> The class device contents will be accessible by /sys/class/adb/<handler>N
> directory. This patch is needed in order to add an class device
> attribute to all keyboards that will determine the sysrq key for each
> keyboard.

I don't think class device is the right approach. Classes are supposed
to be a functional binding, ie, in this case, input devices. ADB is a
bus, and as such, you should create an adb bus type and and adb_device
that is an extension of struct device, not struct class device.

There's also the question of what to do on ADB resets (such as when
doing a sleep/wakeup cycle). Should we wipe out all devices and
re-created them, thus loosing any settings ? Or should we have some way
to attempt at re-matching existing ones ?

Cheers,
Ben.

> Signed-of-by: Aristeu Rozanski <aris@ruivo.org>
> 
> --- linus-2.6.orig/drivers/macintosh/adb.c	2007-05-11 10:09:13.000000000 -0400
> +++ linus-2.6/drivers/macintosh/adb.c	2007-05-11 10:09:36.000000000 -0400
> @@ -102,11 +102,21 @@
>  static void adbdev_init(void);
>  static int try_handler_change(int, int);
>  
> +static char *adb_device_id_string[] = {
> +	[ADB_DONGLE] = "dongle",
> +	[ADB_KEYBOARD] = "keyboard",
> +	[ADB_MOUSE] = "mouse",
> +	[ADB_TABLET] = "tablet",
> +	[ADB_MODEM] = "modem",
> +	[ADB_MISC] = "misc",
> +};
> +
>  static struct adb_handler {
>  	void (*handler)(unsigned char *, int, int);
>  	int original_address;
>  	int handler_id;
>  	int busy;
> +	char name[16];
>  } adb_handler[16];
>  
>  /*
> @@ -508,6 +518,9 @@
>  		if ((adb_handler[i].original_address == default_id) &&
>  		    (!handler_id || (handler_id == adb_handler[i].handler_id) || 
>  		    try_handler_change(i, handler_id))) {
> +		    	int rc;
> +			struct class_device *cdev;
> +
>  			if (adb_handler[i].handler != 0) {
>  				printk(KERN_ERR
>  				       "Two handlers for ADB device %d\n",
> @@ -517,7 +530,26 @@
>  			write_lock_irq(&adb_handler_lock);
>  			adb_handler[i].handler = handler;
>  			write_unlock_irq(&adb_handler_lock);
> -			ids->id[ids->nids++] = i;
> +
> +			snprintf(adb_handler[i].name,
> +				sizeof(adb_handler[i].name), "%s%i",
> +				adb_device_id_string[default_id], ids->nids);
> +
> +			cdev = &ids->id[ids->nids].cdev;
> +			cdev->class = adb_dev_class;
> +			class_device_initialize(cdev);
> +			snprintf(cdev->class_id, sizeof(cdev->class_id), "%s",
> +				 adb_handler[i].name);
> +			rc = class_device_add(cdev);
> +			if (rc) {
> +				printk(KERN_WARNING "adb: unable to add class "
> +				       "device\n");
> +				for (i = ids->nids - 1; i >= 0; i--)
> +					class_device_del(&ids->id[i].cdev);
> +				ids->nids = 0;
> +				return 0;
> +			}
> +			ids->id[ids->nids++].id = i;
>  		}
>  	}
>  	up(&adb_handler_sem);
> @@ -525,9 +557,9 @@
>  }
>  
>  int
> -adb_unregister(int index)
> +adb_unregister(int index, struct adb_ids *ids)
>  {
> -	int ret = -ENODEV;
> +	int i, ret = -ENODEV;
>  
>  	down(&adb_handler_sem);
>  	write_lock_irq(&adb_handler_lock);
> @@ -539,6 +571,8 @@
>  		}
>  		ret = 0;
>  		adb_handler[index].handler = NULL;
> +		for (i = 0; i < ids->nids; i++)
> +			class_device_del(&ids->id[i].cdev);
>  	}
>  	write_unlock_irq(&adb_handler_lock);
>  	up(&adb_handler_sem);
> --- linus-2.6.orig/include/linux/adb.h	2007-05-11 10:09:13.000000000 -0400
> +++ linus-2.6/include/linux/adb.h	2007-05-11 10:09:36.000000000 -0400
> @@ -3,6 +3,7 @@
>   */
>  #ifndef __ADB_H
>  #define __ADB_H
> +#include <linux/device.h>
>  
>  /* ADB commands */
>  #define ADB_BUSRESET		0
> @@ -57,7 +58,11 @@
>  
>  struct adb_ids {
>  	int nids;
> -	unsigned char id[16];
> +	struct adb_id {
> +		unsigned char id;
> +		struct class_device cdev;
> +		void *priv;
> +	} id[16];
>  };
>  
>  /* Structure which encapsulates a low-level ADB driver */
> @@ -91,7 +96,7 @@
>  		int flags, int nbytes, ...);
>  int adb_register(int default_id,int handler_id,struct adb_ids *ids,
>  		 void (*handler)(unsigned char *, int, int));
> -int adb_unregister(int index);
> +int adb_unregister(int index, struct adb_ids *ids);
>  void adb_poll(void);
>  void adb_input(unsigned char *, int, int);
>  int adb_reset_bus(void);
> --- linus-2.6.orig/drivers/macintosh/adbhid.c	2007-05-11 10:09:19.000000000 -0400
> +++ linus-2.6/drivers/macintosh/adbhid.c	2007-05-11 10:10:15.000000000 -0400
> @@ -875,7 +875,7 @@
>  	adb_register(ADB_MISC, 0, &buttons_ids, adbhid_buttons_input);
>  
>  	for (i = 0; i < keyboard_ids.nids; i++) {
> -		int id = keyboard_ids.id[i];
> +		int id = keyboard_ids.id[i].id;
>  
>  		adb_get_infos(id, &default_id, &org_handler_id);
>  
> @@ -902,7 +902,7 @@
>  	}
>  
>  	for (i = 0; i < buttons_ids.nids; i++) {
> -		int id = buttons_ids.id[i];
> +		int id = buttons_ids.id[i].id;
>  
>  		adb_get_infos(id, &default_id, &org_handler_id);
>  		reg |= adbhid_input_reregister(id, default_id, org_handler_id,
> @@ -912,7 +912,7 @@
>  	/* Try to switch all mice to handler 4, or 2 for three-button
>  	   mode and full resolution. */
>  	for (i = 0; i < mouse_ids.nids; i++) {
> -		int id = mouse_ids.id[i];
> +		int id = mouse_ids.id[i].id;
>  		int mouse_kind;
>  
>  		adb_get_infos(id, &default_id, &org_handler_id);
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
