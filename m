Return-Path: <groeck7@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysyvB3xrwzDsNH
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Dec 2017 01:45:10 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id f12so4611148pgo.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Dec 2017 06:45:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] watchdog: core: make sure the watchdog_worker always works
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Wim Van Sebroeck <wim@iguana.be>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-watchdog@vger.kernel.org
References: <20171207103844.4C4BE6C6C4@po15668-vm-win7.idsi0.si.c-s.fr>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e0dd0c5f-f2ad-8e93-bf82-ec862d11f7cf@roeck-us.net>
Date: Thu, 7 Dec 2017 06:45:05 -0800
MIME-Version: 1.0
In-Reply-To: <20171207103844.4C4BE6C6C4@po15668-vm-win7.idsi0.si.c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/07/2017 02:38 AM, Christophe Leroy wrote:
> When running a command like 'chrt -f 99 dd if=/dev/zero of=/dev/null',
> the watchdog_worker fails to service the HW watchdog and the
> HW watchdog fires long before the watchdog soft timeout.
> 
> At the moment, the watchdog_worker is invoked as a delayed work.
> Delayed works are handled by non realtime kernel threads. The
> WQ_HIGHPRI flag only increases the niceness of that threads.
> 
> This patchs replaces the delayed work logic by hrtimer, in order to

s/patchs/patch/

> ensure that the watchdog_worker will already have priority.

always ?

> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   drivers/watchdog/watchdog_dev.c | 87 +++++++++++++++++++----------------------
>   1 file changed, 41 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 1e971a50d7fb..e9b234c4ff67 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -36,7 +36,7 @@
>   #include <linux/errno.h>	/* For the -ENODEV/... values */
>   #include <linux/fs.h>		/* For file operations */
>   #include <linux/init.h>		/* For __init/__exit/... */
> -#include <linux/jiffies.h>	/* For timeout functions */
> +#include <linux/hrtimer.h>
>   #include <linux/kernel.h>	/* For printk/panic/... */
>   #include <linux/kref.h>		/* For data references */
>   #include <linux/miscdevice.h>	/* For handling misc devices */
> @@ -46,7 +46,6 @@
>   #include <linux/slab.h>		/* For memory functions */
>   #include <linux/types.h>	/* For standard types (like size_t) */
>   #include <linux/watchdog.h>	/* For watchdog specific items */
> -#include <linux/workqueue.h>	/* For workqueue */
>   #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
>   
>   #include "watchdog_core.h"
> @@ -65,9 +64,9 @@ struct watchdog_core_data {
>   	struct cdev cdev;
>   	struct watchdog_device *wdd;
>   	struct mutex lock;
> -	unsigned long last_keepalive;
> -	unsigned long last_hw_keepalive;
> -	struct delayed_work work;
> +	ktime_t last_keepalive;
> +	ktime_t last_hw_keepalive;
> +	struct hrtimer timer;
>   	unsigned long status;		/* Internal status bits */
>   #define _WDOG_DEV_OPEN		0	/* Opened ? */
>   #define _WDOG_ALLOW_RELEASE	1	/* Did we receive the magic char ? */
> @@ -79,8 +78,6 @@ static dev_t watchdog_devt;
>   /* Reference to watchdog device behind /dev/watchdog */
>   static struct watchdog_core_data *old_wd_data;
>   
> -static struct workqueue_struct *watchdog_wq;
> -
>   static bool handle_boot_enabled =
>   	IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED);
>   
> @@ -107,18 +104,19 @@ static inline bool watchdog_need_worker(struct watchdog_device *wdd)
>   		(t && !watchdog_active(wdd) && watchdog_hw_running(wdd));
>   }
>   
> -static long watchdog_next_keepalive(struct watchdog_device *wdd)
> +static ktime_t watchdog_next_keepalive(struct watchdog_device *wdd)
>   {
>   	struct watchdog_core_data *wd_data = wdd->wd_data;
>   	unsigned int timeout_ms = wdd->timeout * 1000;
> -	unsigned long keepalive_interval;
> -	unsigned long last_heartbeat;
> -	unsigned long virt_timeout;
> +	ktime_t keepalive_interval;
> +	ktime_t last_heartbeat, latest_heartbeat;
> +	ktime_t virt_timeout;
>   	unsigned int hw_heartbeat_ms;
>   
> -	virt_timeout = wd_data->last_keepalive + msecs_to_jiffies(timeout_ms);
> +	virt_timeout = ktime_add(wd_data->last_keepalive,
> +				 ms_to_ktime(timeout_ms));
>   	hw_heartbeat_ms = min_not_zero(timeout_ms, wdd->max_hw_heartbeat_ms);
> -	keepalive_interval = msecs_to_jiffies(hw_heartbeat_ms / 2);
> +	keepalive_interval = ms_to_ktime(hw_heartbeat_ms / 2);
>   
>   	if (!watchdog_active(wdd))
>   		return keepalive_interval;
> @@ -128,8 +126,11 @@ static long watchdog_next_keepalive(struct watchdog_device *wdd)
>   	 * after the most recent ping from userspace, the last
>   	 * worker ping has to come in hw_heartbeat_ms before this timeout.
>   	 */
> -	last_heartbeat = virt_timeout - msecs_to_jiffies(hw_heartbeat_ms);
> -	return min_t(long, last_heartbeat - jiffies, keepalive_interval);
> +	last_heartbeat = ktime_sub(virt_timeout, ms_to_ktime(hw_heartbeat_ms));
> +	latest_heartbeat = ktime_sub(last_heartbeat, ktime_get());
> +	if (ktime_before(latest_heartbeat, keepalive_interval))
> +		return latest_heartbeat;
> +	return keepalive_interval;
>   }
>   
>   static inline void watchdog_update_worker(struct watchdog_device *wdd)
> @@ -137,29 +138,33 @@ static inline void watchdog_update_worker(struct watchdog_device *wdd)
>   	struct watchdog_core_data *wd_data = wdd->wd_data;
>   
>   	if (watchdog_need_worker(wdd)) {
> -		long t = watchdog_next_keepalive(wdd);
> +		ktime_t t = watchdog_next_keepalive(wdd);
>   
>   		if (t > 0)
> -			mod_delayed_work(watchdog_wq, &wd_data->work, t);
> +			hrtimer_start(&wd_data->timer, t, HRTIMER_MODE_REL);
>   	} else {
> -		cancel_delayed_work(&wd_data->work);
> +		hrtimer_cancel(&wd_data->timer);
>   	}
>   }
>   
>   static int __watchdog_ping(struct watchdog_device *wdd)
>   {
>   	struct watchdog_core_data *wd_data = wdd->wd_data;
> -	unsigned long earliest_keepalive = wd_data->last_hw_keepalive +
> -				msecs_to_jiffies(wdd->min_hw_heartbeat_ms);
> +	ktime_t earliest_keepalive, now;
>   	int err;
>   
> -	if (time_is_after_jiffies(earliest_keepalive)) {
> -		mod_delayed_work(watchdog_wq, &wd_data->work,
> -				 earliest_keepalive - jiffies);
> +	earliest_keepalive = ktime_add(wd_data->last_hw_keepalive,
> +				       ms_to_ktime(wdd->min_hw_heartbeat_ms));
> +	now = ktime_get();
> +
> +	if (ktime_after(earliest_keepalive, now)) {
> +		hrtimer_start(&wd_data->timer,
> +			      ktime_sub(earliest_keepalive, now),
> +			      HRTIMER_MODE_REL);
>   		return 0;
>   	}
>   
> -	wd_data->last_hw_keepalive = jiffies;
> +	wd_data->last_hw_keepalive = now;
>   
>   	if (wdd->ops->ping)
>   		err = wdd->ops->ping(wdd);  /* ping the watchdog */
> @@ -192,7 +197,7 @@ static int watchdog_ping(struct watchdog_device *wdd)
>   
>   	set_bit(_WDOG_KEEPALIVE, &wd_data->status);
>   
> -	wd_data->last_keepalive = jiffies;
> +	wd_data->last_keepalive = ktime_get();
>   	return __watchdog_ping(wdd);
>   }
>   
> @@ -203,17 +208,18 @@ static bool watchdog_worker_should_ping(struct watchdog_core_data *wd_data)
>   	return wdd && (watchdog_active(wdd) || watchdog_hw_running(wdd));
>   }
>   
> -static void watchdog_ping_work(struct work_struct *work)
> +enum hrtimer_restart watchdog_ping_work(struct hrtimer *timer)

static

>   {
>   	struct watchdog_core_data *wd_data;
>   
> -	wd_data = container_of(to_delayed_work(work), struct watchdog_core_data,
> -			       work);
> +	wd_data = container_of(timer, struct watchdog_core_data, timer);
>   
>   	mutex_lock(&wd_data->lock);
>   	if (watchdog_worker_should_ping(wd_data))
>   		__watchdog_ping(wd_data->wdd);
>   	mutex_unlock(&wd_data->lock);
> +
> +	return HRTIMER_NORESTART;

I am not sure if it is a good idea to execute the ping in this context.
After all, this code may block (eg if the ping is sent to an i2c device,
but also due to the use of a mutex). Looking into other drivers using
high resolution timers, it is common to have the actual work done by
a worker.
Of course, that might defeat the purpose of this exercise, so the
question is if it is possible to have a realtime worker. Can you explore ?

Thanks,
Guenter

>   }
>   
>   /*
> @@ -230,7 +236,7 @@ static void watchdog_ping_work(struct work_struct *work)
>   static int watchdog_start(struct watchdog_device *wdd)
>   {
>   	struct watchdog_core_data *wd_data = wdd->wd_data;
> -	unsigned long started_at;
> +	ktime_t started_at;
>   	int err;
>   
>   	if (watchdog_active(wdd))
> @@ -238,7 +244,7 @@ static int watchdog_start(struct watchdog_device *wdd)
>   
>   	set_bit(_WDOG_KEEPALIVE, &wd_data->status);
>   
> -	started_at = jiffies;
> +	started_at = ktime_get();
>   	if (watchdog_hw_running(wdd) && wdd->ops->ping)
>   		err = wdd->ops->ping(wdd);
>   	else
> @@ -919,10 +925,8 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
>   	wd_data->wdd = wdd;
>   	wdd->wd_data = wd_data;
>   
> -	if (!watchdog_wq)
> -		return -ENODEV;
> -
> -	INIT_DELAYED_WORK(&wd_data->work, watchdog_ping_work);
> +	hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	wd_data->timer.function = watchdog_ping_work;
>   
>   	if (wdd->id == 0) {
>   		old_wd_data = wd_data;
> @@ -958,7 +962,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
>   	}
>   
>   	/* Record time of most recent heartbeat as 'just before now'. */
> -	wd_data->last_hw_keepalive = jiffies - 1;
> +	wd_data->last_hw_keepalive = ktime_get();

Please assign ktime_sub(ktime_get(), 1);

Thanks,
Guenter

>   
>   	/*
>   	 * If the watchdog is running, prevent its driver from being unloaded,
> @@ -968,7 +972,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
>   		if (handle_boot_enabled) {
>   			__module_get(wdd->ops->owner);
>   			kref_get(&wd_data->kref);
> -			queue_delayed_work(watchdog_wq, &wd_data->work, 0);
> +			hrtimer_start(&wd_data->timer, 0, HRTIMER_MODE_REL);
>   		} else {
>   			pr_info("watchdog%d running and kernel based pre-userspace handler disabled\n",
>   					wdd->id);
> @@ -1006,7 +1010,7 @@ static void watchdog_cdev_unregister(struct watchdog_device *wdd)
>   		watchdog_stop(wdd);
>   	}
>   
> -	cancel_delayed_work_sync(&wd_data->work);
> +	hrtimer_cancel(&wd_data->timer);
>   
>   	kref_put(&wd_data->kref, watchdog_core_data_release);
>   }
> @@ -1111,13 +1115,6 @@ int __init watchdog_dev_init(void)
>   {
>   	int err;
>   
> -	watchdog_wq = alloc_workqueue("watchdogd",
> -				      WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
> -	if (!watchdog_wq) {
> -		pr_err("Failed to create watchdog workqueue\n");
> -		return -ENOMEM;
> -	}
> -
>   	err = class_register(&watchdog_class);
>   	if (err < 0) {
>   		pr_err("couldn't register class\n");
> @@ -1135,7 +1132,6 @@ int __init watchdog_dev_init(void)
>   err_alloc:
>   	class_unregister(&watchdog_class);
>   err_register:
> -	destroy_workqueue(watchdog_wq);
>   	return err;
>   }
>   
> @@ -1149,7 +1145,6 @@ void __exit watchdog_dev_exit(void)
>   {
>   	unregister_chrdev_region(watchdog_devt, MAX_DOGS);
>   	class_unregister(&watchdog_class);
> -	destroy_workqueue(watchdog_wq);
>   }
>   
>   module_param(handle_boot_enabled, bool, 0444);
> 
