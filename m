Return-Path: <aris@cathedrallabs.org>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 46A0767B66
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 23:44:58 +1000 (EST)
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id
	k8KDiufM021766
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 09:44:56 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id
	k8KDiu4v004034
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 09:44:56 -0400
Received: from localhost.localdomain (vpn-51-24.sfbay.redhat.com [10.14.51.24]
	(may be forged))
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id k8KDighR015162
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 09:44:54 -0400
Received: from aris by localhost.localdomain with local (Exim 4.63)
	(envelope-from <aris@cathedrallabs.org>) id 1GQ2NT-0000r2-Gp
	for linuxppc-dev@ozlabs.org; Wed, 20 Sep 2006 10:44:39 -0300
Date: Wed, 20 Sep 2006 10:44:39 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] adb: create class devices for each handler
Message-ID: <20060920134439.GB23803@cathedrallabs.org>
References: <20060808154535.GB3363@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060808154535.GB3363@cathedrallabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This patch creates a class device for each registered ADB handler
> (currently only adbhid) such as /sys/classes/adb/keyboard0/,
> /sys/classes/adb/mouse0/. This is needed for the next patch, to create
> a sysfs entry to make SYSRQ key configurable on ADB based machines.
any comments on this one?

> Signed-off-by: Aristeu S. Rozanski F. <aris@cathedrallabs.org>
> Acked-by: Michael Hanselmann <linux-kernel@hansmi.ch>
> 
> Index: ppc-2.6/drivers/macintosh/adb.c
> ===================================================================
> --- ppc-2.6.orig/drivers/macintosh/adb.c	2006-08-03 23:51:35.000000000 -0300
> +++ ppc-2.6/drivers/macintosh/adb.c	2006-08-03 23:56:00.000000000 -0300
> @@ -102,11 +102,22 @@
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
>  	void (*handler)(unsigned char *, int, struct pt_regs *, int);
>  	int original_address;
>  	int handler_id;
>  	int busy;
> +	char name[16];
> +	struct class_device *device;
>  } adb_handler[16];
>  
>  /*
> @@ -541,6 +552,15 @@
>  			write_lock_irq(&adb_handler_lock);
>  			adb_handler[i].handler = handler;
>  			write_unlock_irq(&adb_handler_lock);
> +
> +			snprintf(adb_handler[i].name,
> +				sizeof(adb_handler[i].name), "%s%i",
> +				adb_device_id_string[default_id], ids->nids);
> +			adb_handler[i].device = class_device_create(
> +							adb_dev_class, NULL,
> +							MKDEV(0, 0), NULL,
> +							adb_handler[i].name);
> +			ids->device[ids->nids] = adb_handler[i].device;
>  			ids->id[ids->nids++] = i;
>  		}
>  	}
> @@ -563,6 +583,7 @@
>  		}
>  		ret = 0;
>  		adb_handler[index].handler = NULL;
> +		class_device_del(adb_handler[index].device);
>  	}
>  	write_unlock_irq(&adb_handler_lock);
>  	up(&adb_handler_sem);
> Index: ppc-2.6/include/linux/adb.h
> ===================================================================
> --- ppc-2.6.orig/include/linux/adb.h	2006-08-03 23:51:35.000000000 -0300
> +++ ppc-2.6/include/linux/adb.h	2006-08-03 23:57:56.000000000 -0300
> @@ -3,6 +3,7 @@
>   */
>  #ifndef __ADB_H
>  #define __ADB_H
> +#include <linux/device.h>
>  
>  /* ADB commands */
>  #define ADB_BUSRESET		0
> @@ -58,6 +59,7 @@
>  struct adb_ids {
>  	int nids;
>  	unsigned char id[16];
> +	struct class_device *device[16];
>  };
>  
>  /* Structure which encapsulates a low-level ADB driver */
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

-- 
Aristeu
