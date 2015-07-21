Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 936431A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 16:56:26 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Tue, 21 Jul 2015 12:26:18 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id C05E83940075
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 12:26:07 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6L6tPdj56361100
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 12:25:26 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6L5c5DM031235
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 11:08:06 +0530
Message-ID: <55ADECD2.4010802@linux.vnet.ibm.com>
Date: Tue, 21 Jul 2015 12:25:14 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
CC: stewart@linux.vnet.ibm.com, arnd@arndb.de, cooloney@gmail.com,
 rpurdie@rpsys.net, linuxppc-dev@lists.ozlabs.org,
 Jacek Anaszewski <j.anaszewski@samsung.com>,
 linux-leds@vger.kernel.org, khandual@linux.vnet.ibm.com
Subject: Re: [PATCH v6 3/3] leds/powernv: Add driver for PowerNV platform
References: <1437129671-14078-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <1437129671-14078-4-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <55A91E67.6010200@samsung.com> <55A92B44.6020502@linux.vnet.ibm.com>
 <55AC193B.9060005@gmail.com> <55ADDE92.5040902@linux.vnet.ibm.com>
In-Reply-To: <55ADDE92.5040902@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/21/2015 11:24 AM, Vasant Hegde wrote:
> On 07/20/2015 03:10 AM, Jacek Anaszewski wrote:
>> Hi Vasant,
>>
> 
> Jacek,
> 
>> I've revised your patch and found few more issues.
>> Please refer to my comments below.
> 
> Thanks.
> 
> .../...
> 
>>>>
>>>> Please don't exceed 75 character line length limit.
>>>
>>> Ok. I will fix it.. But I thought 80 character is the limit.
>>
>> checkpatch.pl reports this.
> 
> Ah! I was running checkpatch.pl against source. Let me fix this.
> .../...
> 
>>>>> +/*
>>>>> + * LED set routines have been implemented as work queue tasks scheduled
>>>>> + * on the global work queue. Individual task calls OPAL interface to set
>>>>> + * the LED state which might sleep for some time.
>>>>> + */
>>>>> +struct powernv_led_data {
>>>>> +    struct led_classdev    cdev;
>>>>> +    char            *loc_code;    /* LED location code */
>>>>> +    int            led_type;    /* OPAL_SLOT_LED_TYPE_* */
>>>>> +    enum led_brightness    value;        /* Brightness value */
>>>>> +    struct mutex        lock;
>>
>> You're unnecessarily adding mutex for each LED class device.
>> The shared resource to protect is here powernv led interface,
>> so one mutex will suffice.
> 
> 
> Ok. Let me move that to common structure.
> 
>>
>>
>>>>> +    struct work_struct    work_led;    /* LED update workqueue */
>>>>> +};
>>>>> +
>>>>> +struct powernv_leds_priv {
>>>>> +    int num_leds;
>>>>> +    struct powernv_led_data powernv_leds[];
>>>>> +};
>>
>> powernv_led_data doesn't have to be retained in the array. You access
>> the array elements only upon creation of LED class devices. When using
>> managed resource allocation you don't need to bother with freeing
>> resources, so you don't need to keep reference to the data.
>>
>> I propose to drop struct powernv_leds_priv and instead introduce
>> a structure that would aggregate common driver data like mutex,
>> led_disable and max_led_type.
> 
> I still think we need two structures.. One for common driver data like mutex,
> led_disable etc and other one for led data itself .. like
> 	struct powernv_led_data {
> 		struct led_classdev     cdev;
> 		char                    *loc_code;     <-- pointer to DT node
> 		int                     led_type;       /* OPAL_SLOT_LED_TYPE_* */
> 		enum led_brightness     value;          /* Brightness value */
> 	};
> 
> 	struct powernv_led_common {
> 		bool led_disable;
> 		int 	max_led_type;
> 		struct mutex            lock;
> 	};

Jacek,

Alternatively I can club both into single structure like below

 	struct powernv_led_data {
 		struct led_classdev     cdev;
 		char                    *loc_code;     <-- pointer to DT node
 		int                     led_type;       /* OPAL_SLOT_LED_TYPE_* */
 		enum led_brightness     value;          /* Brightness value */

 		int 		*max_led_type;
 		struct mutex            *lock;
 	};

	static  bool 	led_disable;


In this case I've to keep led_disable outside the structure as I need to access
this variable in powernv_led_remove().

One remaining issue with these approach (where we don't have array of
powernv_led ) is,
powernv_let_set() function can sleep. Current code (v6) calls flush_work before
unloading
module. That way we are sure work is complete before unloading module.
With new approach, I'm not sure how I can make sure work is completed before
loading module. Does new workqueue approach has sleep functionality? Is there
way to make sure work is completed before
unloading module?

-Vasant
