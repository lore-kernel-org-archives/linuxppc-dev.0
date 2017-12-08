Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ytTG66dpyzDrb1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Dec 2017 21:33:18 +1100 (AEDT)
Subject: Re: [PATCH] watchdog: core: make sure the watchdog_worker always works
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-watchdog@vger.kernel.org
References: <20171207103844.4C4BE6C6C4@po15668-vm-win7.idsi0.si.c-s.fr>
 <e0dd0c5f-f2ad-8e93-bf82-ec862d11f7cf@roeck-us.net>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <2e864485-0bf9-0e14-2d86-f0d7fb89c3a0@c-s.fr>
Date: Fri, 8 Dec 2017 11:33:12 +0100
MIME-Version: 1.0
In-Reply-To: <e0dd0c5f-f2ad-8e93-bf82-ec862d11f7cf@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 07/12/2017 à 15:45, Guenter Roeck a écrit :
> On 12/07/2017 02:38 AM, Christophe Leroy wrote:
>> When running a command like 'chrt -f 99 dd if=/dev/zero of=/dev/null',
>> the watchdog_worker fails to service the HW watchdog and the
>> HW watchdog fires long before the watchdog soft timeout.
>>
>> At the moment, the watchdog_worker is invoked as a delayed work.
>> Delayed works are handled by non realtime kernel threads. The
>> WQ_HIGHPRI flag only increases the niceness of that threads.
>>
>> This patchs replaces the delayed work logic by hrtimer, in order to
> 
> s/patchs/patch/
> 
>> ensure that the watchdog_worker will already have priority.
> 
> always ?
> 
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   drivers/watchdog/watchdog_dev.c | 87 
>> +++++++++++++++++++----------------------
>>   1 file changed, 41 insertions(+), 46 deletions(-)
>>

[snip]

> 
> I am not sure if it is a good idea to execute the ping in this context.
> After all, this code may block (eg if the ping is sent to an i2c device,
> but also due to the use of a mutex). Looking into other drivers using
> high resolution timers, it is common to have the actual work done by
> a worker.
> Of course, that might defeat the purpose of this exercise, so the
> question is if it is possible to have a realtime worker. Can you explore ?

kthread_delayed_work is likely our solution:
- 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b56c0d8937e665a27d90517ee7a746d0aa05af46
- 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=22597dc3d97b1ead2aca201397415a1a84bf2b26

I submitted v2 of the patch based on that instead of hrtimer. Also 
implies less modifications to the code.

Christophe

> 
> Thanks,
> Guenter
> 
>>   }
>>   /*
>> @@ -230,7 +236,7 @@ static void watchdog_ping_work(struct work_struct 
>> *work)
>>   static int watchdog_start(struct watchdog_device *wdd)
>>   {
>>       struct watchdog_core_data *wd_data = wdd->wd_data;
>> -    unsigned long started_at;
>> +    ktime_t started_at;
>>       int err;
>>       if (watchdog_active(wdd))
>> @@ -238,7 +244,7 @@ static int watchdog_start(struct watchdog_device 
>> *wdd)
>>       set_bit(_WDOG_KEEPALIVE, &wd_data->status);
>> -    started_at = jiffies;
>> +    started_at = ktime_get();
>>       if (watchdog_hw_running(wdd) && wdd->ops->ping)
>>           err = wdd->ops->ping(wdd);
>>       else
>> @@ -919,10 +925,8 @@ static int watchdog_cdev_register(struct 
>> watchdog_device *wdd, dev_t devno)
>>       wd_data->wdd = wdd;
>>       wdd->wd_data = wd_data;
>> -    if (!watchdog_wq)
>> -        return -ENODEV;
>> -
>> -    INIT_DELAYED_WORK(&wd_data->work, watchdog_ping_work);
>> +    hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>> +    wd_data->timer.function = watchdog_ping_work;
>>       if (wdd->id == 0) {
>>           old_wd_data = wd_data;
>> @@ -958,7 +962,7 @@ static int watchdog_cdev_register(struct 
>> watchdog_device *wdd, dev_t devno)
>>       }
>>       /* Record time of most recent heartbeat as 'just before now'. */
>> -    wd_data->last_hw_keepalive = jiffies - 1;
>> +    wd_data->last_hw_keepalive = ktime_get();
> 
> Please assign ktime_sub(ktime_get(), 1);
> 
> Thanks,
> Guenter
> 
>>       /*
>>        * If the watchdog is running, prevent its driver from being 
>> unloaded,
>> @@ -968,7 +972,7 @@ static int watchdog_cdev_register(struct 
>> watchdog_device *wdd, dev_t devno)
>>           if (handle_boot_enabled) {
>>               __module_get(wdd->ops->owner);
>>               kref_get(&wd_data->kref);
>> -            queue_delayed_work(watchdog_wq, &wd_data->work, 0);
>> +            hrtimer_start(&wd_data->timer, 0, HRTIMER_MODE_REL);
>>           } else {
>>               pr_info("watchdog%d running and kernel based 
>> pre-userspace handler disabled\n",
>>                       wdd->id);
>> @@ -1006,7 +1010,7 @@ static void watchdog_cdev_unregister(struct 
>> watchdog_device *wdd)
>>           watchdog_stop(wdd);
>>       }
>> -    cancel_delayed_work_sync(&wd_data->work);
>> +    hrtimer_cancel(&wd_data->timer);
>>       kref_put(&wd_data->kref, watchdog_core_data_release);
>>   }
>> @@ -1111,13 +1115,6 @@ int __init watchdog_dev_init(void)
>>   {
>>       int err;
>> -    watchdog_wq = alloc_workqueue("watchdogd",
>> -                      WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
>> -    if (!watchdog_wq) {
>> -        pr_err("Failed to create watchdog workqueue\n");
>> -        return -ENOMEM;
>> -    }
>> -
>>       err = class_register(&watchdog_class);
>>       if (err < 0) {
>>           pr_err("couldn't register class\n");
>> @@ -1135,7 +1132,6 @@ int __init watchdog_dev_init(void)
>>   err_alloc:
>>       class_unregister(&watchdog_class);
>>   err_register:
>> -    destroy_workqueue(watchdog_wq);
>>       return err;
>>   }
>> @@ -1149,7 +1145,6 @@ void __exit watchdog_dev_exit(void)
>>   {
>>       unregister_chrdev_region(watchdog_devt, MAX_DOGS);
>>       class_unregister(&watchdog_class);
>> -    destroy_workqueue(watchdog_wq);
>>   }
>>   module_param(handle_boot_enabled, bool, 0444);
>>
