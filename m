Return-Path: <groeck7@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yyGC24x5wzDrc3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 01:28:46 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id y6so3513169pgp.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 06:28:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2] watchdog: core: make sure the watchdog worker always
 works
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Wim Van Sebroeck <wim@iguana.be>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-watchdog@vger.kernel.org
References: <20171208101835.EEB866BA61@localhost.localdomain>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <155345f8-87e2-1d87-3db8-7d1520b6ebc5@roeck-us.net>
Date: Thu, 14 Dec 2017 06:28:41 -0800
MIME-Version: 1.0
In-Reply-To: <20171208101835.EEB866BA61@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/08/2017 02:18 AM, Christophe Leroy wrote:
> When running a command like 'chrt -f 50 dd if=/dev/zero of=/dev/null',
> the watchdog_worker fails to service the HW watchdog and the
> HW watchdog fires long before the watchdog soft timeout.
> 
> At the moment, the watchdog_worker is invoked as a delayed work.
> Delayed works are handled by non realtime kernel threads. The
> WQ_HIGHPRI flag only increases the niceness of that threads.
> 
> This patch replaces the delayed work logic by kthread delayed work,
> and sets the associated kernel task to SCHED_FIFO with the highest
> priority, in order to ensure that the watchdog worker will run as
> soon as possible.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   v2: Use kthread_delayed_work instead of hrtimer
> 
>   drivers/watchdog/watchdog_dev.c | 48 +++++++++++++++++++++++------------------
>   1 file changed, 27 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 1e971a50d7fb..3dcb86f18055 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -39,6 +39,7 @@
>   #include <linux/jiffies.h>	/* For timeout functions */
>   #include <linux/kernel.h>	/* For printk/panic/... */
>   #include <linux/kref.h>		/* For data references */
> +#include <linux/kthread.h>	/* For kthread_delayed_work */
>   #include <linux/miscdevice.h>	/* For handling misc devices */
>   #include <linux/module.h>	/* For module stuff/... */
>   #include <linux/mutex.h>	/* For mutexes */
> @@ -46,9 +47,10 @@
>   #include <linux/slab.h>		/* For memory functions */
>   #include <linux/types.h>	/* For standard types (like size_t) */
>   #include <linux/watchdog.h>	/* For watchdog specific items */
> -#include <linux/workqueue.h>	/* For workqueue */
>   #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
>   
> +#include <uapi/linux/sched/types.h>	/* For struct sched_param */
> +
>   #include "watchdog_core.h"
>   #include "watchdog_pretimeout.h"
>   
> @@ -67,7 +69,7 @@ struct watchdog_core_data {
>   	struct mutex lock;
>   	unsigned long last_keepalive;
>   	unsigned long last_hw_keepalive;
> -	struct delayed_work work;
> +	struct kthread_delayed_work work;
>   	unsigned long status;		/* Internal status bits */
>   #define _WDOG_DEV_OPEN		0	/* Opened ? */
>   #define _WDOG_ALLOW_RELEASE	1	/* Did we receive the magic char ? */
> @@ -79,7 +81,7 @@ static dev_t watchdog_devt;
>   /* Reference to watchdog device behind /dev/watchdog */
>   static struct watchdog_core_data *old_wd_data;
>   
> -static struct workqueue_struct *watchdog_wq;
> +static struct kthread_worker *watchdog_kworker;
>   
>   static bool handle_boot_enabled =
>   	IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED);
> @@ -140,9 +142,10 @@ static inline void watchdog_update_worker(struct watchdog_device *wdd)
>   		long t = watchdog_next_keepalive(wdd);
>   
>   		if (t > 0)
> -			mod_delayed_work(watchdog_wq, &wd_data->work, t);
> +			kthread_mod_delayed_work(watchdog_kworker,
> +						 &wd_data->work, t);
>   	} else {
> -		cancel_delayed_work(&wd_data->work);
> +		kthread_cancel_delayed_work_sync(&wd_data->work);
>   	}
>   }
>   
> @@ -154,8 +157,8 @@ static int __watchdog_ping(struct watchdog_device *wdd)
>   	int err;
>   
>   	if (time_is_after_jiffies(earliest_keepalive)) {
> -		mod_delayed_work(watchdog_wq, &wd_data->work,
> -				 earliest_keepalive - jiffies);
> +		kthread_mod_delayed_work(watchdog_kworker, &wd_data->work,
> +					 earliest_keepalive - jiffies);
>   		return 0;
>   	}
>   
> @@ -203,12 +206,13 @@ static bool watchdog_worker_should_ping(struct watchdog_core_data *wd_data)
>   	return wdd && (watchdog_active(wdd) || watchdog_hw_running(wdd));
>   }
>   
> -static void watchdog_ping_work(struct work_struct *work)
> +static void watchdog_ping_work(struct kthread_work *work)
>   {
>   	struct watchdog_core_data *wd_data;
>   
> -	wd_data = container_of(to_delayed_work(work), struct watchdog_core_data,
> -			       work);
> +	wd_data = container_of(container_of(work, struct kthread_delayed_work,
> +					    work),
> +			       struct watchdog_core_data, work);
>   
>   	mutex_lock(&wd_data->lock);
>   	if (watchdog_worker_should_ping(wd_data))
> @@ -919,10 +923,10 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
>   	wd_data->wdd = wdd;
>   	wdd->wd_data = wd_data;
>   
> -	if (!watchdog_wq)
> +	if (IS_ERR_OR_NULL(watchdog_kworker))
>   		return -ENODEV;
>   
> -	INIT_DELAYED_WORK(&wd_data->work, watchdog_ping_work);
> +	kthread_init_delayed_work(&wd_data->work, watchdog_ping_work);
>   
>   	if (wdd->id == 0) {
>   		old_wd_data = wd_data;
> @@ -968,7 +972,8 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
>   		if (handle_boot_enabled) {
>   			__module_get(wdd->ops->owner);
>   			kref_get(&wd_data->kref);
> -			queue_delayed_work(watchdog_wq, &wd_data->work, 0);
> +			kthread_queue_delayed_work(watchdog_kworker,
> +						   &wd_data->work, 0);
>   		} else {
>   			pr_info("watchdog%d running and kernel based pre-userspace handler disabled\n",
>   					wdd->id);
> @@ -1006,7 +1011,7 @@ static void watchdog_cdev_unregister(struct watchdog_device *wdd)
>   		watchdog_stop(wdd);
>   	}
>   
> -	cancel_delayed_work_sync(&wd_data->work);
> +	kthread_cancel_delayed_work_sync(&wd_data->work);
>   
>   	kref_put(&wd_data->kref, watchdog_core_data_release);
>   }
> @@ -1110,13 +1115,14 @@ void watchdog_dev_unregister(struct watchdog_device *wdd)
>   int __init watchdog_dev_init(void)
>   {
>   	int err;
> +	struct sched_param param = {.sched_priority = MAX_RT_PRIO - 1,};
>   
> -	watchdog_wq = alloc_workqueue("watchdogd",
> -				      WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
> -	if (!watchdog_wq) {
> -		pr_err("Failed to create watchdog workqueue\n");
> -		return -ENOMEM;
> +	watchdog_kworker = kthread_create_worker(0, "watchdogd");
> +	if (IS_ERR(watchdog_kworker)) {
> +		pr_err("Failed to create watchdog kworker\n");
> +		return PTR_ERR(watchdog_kworker);
>   	}
> +	sched_setscheduler(watchdog_kworker->task, SCHED_FIFO, &param);
>   
>   	err = class_register(&watchdog_class);
>   	if (err < 0) {
> @@ -1135,7 +1141,7 @@ int __init watchdog_dev_init(void)
>   err_alloc:
>   	class_unregister(&watchdog_class);
>   err_register:
> -	destroy_workqueue(watchdog_wq);
> +	kthread_destroy_worker(watchdog_kworker);
>   	return err;
>   }
>   
> @@ -1149,7 +1155,7 @@ void __exit watchdog_dev_exit(void)
>   {
>   	unregister_chrdev_region(watchdog_devt, MAX_DOGS);
>   	class_unregister(&watchdog_class);
> -	destroy_workqueue(watchdog_wq);
> +	kthread_destroy_worker(watchdog_kworker);
>   }
>   
>   module_param(handle_boot_enabled, bool, 0444);
> 
