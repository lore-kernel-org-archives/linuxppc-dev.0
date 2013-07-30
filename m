Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
 [209.85.212.172])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 590FB2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 21:19:52 +1000 (EST)
Received: by mail-wi0-f172.google.com with SMTP id hj13so1972453wib.17
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 04:19:45 -0700 (PDT)
Message-ID: <51F7A152.3030602@linaro.org>
Date: Tue, 30 Jul 2013 13:19:46 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Subject: Re: [PATCH] cpuidle: fix unremovable issue for module driver
References: <1375167319-12821-1-git-send-email-dongsheng.wang@freescale.com>
 <51F7872F.30101@linaro.org>
 <ABB05CD9C9F68C46A5CEDC7F15439259FEF32C@039-SN2MPN1-021.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259FEF32C@039-SN2MPN1-021.039d.mgd.msft.net>
Content-Type: text/plain; charset=UTF-8
Cc: "rjw@sisk.pl" <rjw@sisk.pl>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/30/2013 12:48 PM, Wang Dongsheng-B40534 wrote:
> 
> 
>> -----Original Message-----
>> From: Daniel Lezcano [mailto:daniel.lezcano@linaro.org]
>> Sent: Tuesday, July 30, 2013 5:28 PM
>> To: Wang Dongsheng-B40534
>> Cc: rjw@sisk.pl; linux-pm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
>> Subject: Re: [PATCH] cpuidle: fix unremovable issue for module driver
>>
>> On 07/30/2013 08:55 AM, Dongsheng Wang wrote:
>>> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>>>
>>> After __cpuidle_register_device, the cpu incs are added up, but decs
>>> are not, thus the module refcount is not match. So the module "exit"
>>> function can not be executed when we do remove operation. Move
>>> module_put into __cpuidle_register_device to fix it.
>>
>> Sorry, I still don't get it :/
>>
>> register->module_get
>> unregister->module_put
>>
>> you change it by:
>>
>> register->module_get
>> register->module_put
>> unregister->none
>>
>> which is wrong.
>>
> module_get->set per cpu incs=1
> module_put->set per cpu decs=1
> 
> module_refcount-> incs - decs;
> 
> "unregister" usually call in module->exit function. 
> But if module_refcount is not zero, the module->exit() cannot be executed.

Ok, IIUC, the refcount is decremented in the unregister function but
this one is never called because the refcount is not zero.

Funny, that means the module format was *never* used at all as it does
not work.

I am wondering if we shouldn't just remove the module support for
cpuidle. Rafael ?

> See, kernel/module.c +874
> delete_module()-->try_stop_module();

Thanks, I believe I understand the refcount mechanism.

> Test Log:
> root:~# rmmod cpuidle-e500
> module_refcount: incs[9], decs[1]
> rmmod: can't unload 'cpuidle_e500': Resource temporarily unavailable
> 
>> Can you describe the problem you are facing ? (a bit more than "I can't
>> unload the module").
>>
>>> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
>>>
>>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>>> index d75040d..e964ada 100644
>>> --- a/drivers/cpuidle/cpuidle.c
>>> +++ b/drivers/cpuidle/cpuidle.c
>>> @@ -351,11 +351,8 @@ EXPORT_SYMBOL_GPL(cpuidle_disable_device);
>>>
>>>  static void __cpuidle_unregister_device(struct cpuidle_device *dev)
>>> {
>>> -	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
>>> -
>>>  	list_del(&dev->device_list);
>>>  	per_cpu(cpuidle_devices, dev->cpu) = NULL;
>>> -	module_put(drv->owner);
>>>  }
>>>
>>>  static int __cpuidle_device_init(struct cpuidle_device *dev) @@
>>> -384,6 +381,8 @@ static int __cpuidle_register_device(struct
>> cpuidle_device *dev)
>>>  	per_cpu(cpuidle_devices, dev->cpu) = dev;
>>>  	list_add(&dev->device_list, &cpuidle_detected_devices);
>>>
>>> +	module_put(drv->owner);
>>> +
>>>  	ret = cpuidle_coupled_register_device(dev);
>>>  	if (ret) {
>>>  		__cpuidle_unregister_device(dev);
>>>



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
