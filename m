Return-Path: <jacek.anaszewski@gmail.com>
Received: from mail-wi0-x242.google.com (mail-wi0-x242.google.com
 [IPv6:2a00:1450:400c:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 131CD1A01C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 19:57:25 +1000 (AEST)
Received: by wicmm11 with SMTP id mm11so2236862wic.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 02:57:21 -0700 (PDT)
Message-ID: <55AE1723.6040806@gmail.com>
Date: Tue, 21 Jul 2015 11:55:47 +0200
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
MIME-Version: 1.0
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
CC: stewart@linux.vnet.ibm.com, arnd@arndb.de, cooloney@gmail.com,
 rpurdie@rpsys.net, linuxppc-dev@lists.ozlabs.org,
 Jacek Anaszewski <j.anaszewski@samsung.com>,
 linux-leds@vger.kernel.org, khandual@linux.vnet.ibm.com
Subject: Re: [PATCH v6 3/3] leds/powernv: Add driver for PowerNV platform
References: <1437129671-14078-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <1437129671-14078-4-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <55A91E67.6010200@samsung.com> <55A92B44.6020502@linux.vnet.ibm.com>
 <55AC193B.9060005@gmail.com> <55ADDE92.5040902@linux.vnet.ibm.com>
 <55ADECD2.4010802@linux.vnet.ibm.com>
In-Reply-To: <55ADECD2.4010802@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vasant,

On 21.07.2015 08:55, Vasant Hegde wrote:
> On 07/21/2015 11:24 AM, Vasant Hegde wrote:
>> On 07/20/2015 03:10 AM, Jacek Anaszewski wrote:
>>> Hi Vasant,
>>>
>>
>> Jacek,
>>
>>> I've revised your patch and found few more issues.
>>> Please refer to my comments below.
>>
>> Thanks.
>>
>> .../...
>>
>>>>>
>>>>> Please don't exceed 75 character line length limit.
>>>>
>>>> Ok. I will fix it.. But I thought 80 character is the limit.
>>>
>>> checkpatch.pl reports this.
>>
>> Ah! I was running checkpatch.pl against source. Let me fix this.
>> .../...
>>
>>>>>> +/*
>>>>>> + * LED set routines have been implemented as work queue tasks scheduled
>>>>>> + * on the global work queue. Individual task calls OPAL interface to set
>>>>>> + * the LED state which might sleep for some time.
>>>>>> + */
>>>>>> +struct powernv_led_data {
>>>>>> +    struct led_classdev    cdev;
>>>>>> +    char            *loc_code;    /* LED location code */
>>>>>> +    int            led_type;    /* OPAL_SLOT_LED_TYPE_* */
>>>>>> +    enum led_brightness    value;        /* Brightness value */
>>>>>> +    struct mutex        lock;
>>>
>>> You're unnecessarily adding mutex for each LED class device.
>>> The shared resource to protect is here powernv led interface,
>>> so one mutex will suffice.
>>
>>
>> Ok. Let me move that to common structure.
>>
>>>
>>>
>>>>>> +    struct work_struct    work_led;    /* LED update workqueue */
>>>>>> +};
>>>>>> +
>>>>>> +struct powernv_leds_priv {
>>>>>> +    int num_leds;
>>>>>> +    struct powernv_led_data powernv_leds[];
>>>>>> +};
>>>
>>> powernv_led_data doesn't have to be retained in the array. You access
>>> the array elements only upon creation of LED class devices. When using
>>> managed resource allocation you don't need to bother with freeing
>>> resources, so you don't need to keep reference to the data.
>>>
>>> I propose to drop struct powernv_leds_priv and instead introduce
>>> a structure that would aggregate common driver data like mutex,
>>> led_disable and max_led_type.
>>
>> I still think we need two structures.. One for common driver data like mutex,
>> led_disable etc and other one for led data itself .. like
>> 	struct powernv_led_data {
>> 		struct led_classdev     cdev;
>> 		char                    *loc_code;     <-- pointer to DT node
>> 		int                     led_type;       /* OPAL_SLOT_LED_TYPE_* */
>> 		enum led_brightness     value;          /* Brightness value */
>> 	};
>>
>> 	struct powernv_led_common {
>> 		bool led_disable;
>> 		int 	max_led_type;
>> 		struct mutex            lock;
>> 	};
>
> Jacek,
>
> Alternatively I can club both into single structure like below
>
>   	struct powernv_led_data {
>   		struct led_classdev     cdev;
>   		char                    *loc_code;     <-- pointer to DT node
>   		int                     led_type;       /* OPAL_SLOT_LED_TYPE_* */
>   		enum led_brightness     value;          /* Brightness value */
>
>   		int 		*max_led_type;
>   		struct mutex            *lock;
>   	};
>
> 	static  bool 	led_disable;
>
>
> In this case I've to keep led_disable outside the structure as I need to access
> this variable in powernv_led_remove().

OK, this looks good to me.

>
> One remaining issue with these approach (where we don't have array of
> powernv_led ) is,
> powernv_let_set() function can sleep. Current code (v6) calls flush_work before
> unloading
> module. That way we are sure work is complete before unloading module.
> With new approach, I'm not sure how I can make sure work is completed before
> loading module.

led_classdev_unregister calls cancel_work_sync so brightness_set op
will not be called after driver detach.

 >  Does new workqueue approach has sleep functionality? Is there
> way to make sure work is completed before
> unloading module?

It is approached from the other side - we are making sure that
work will not be executed after driver detach.

-- 
Best Regards,
Jacek Anaszewski
