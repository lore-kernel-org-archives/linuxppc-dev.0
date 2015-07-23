Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D9E91A0186
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 18:08:51 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Thu, 23 Jul 2015 13:38:45 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id CC26C125804B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 13:41:41 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6N88cMw46006496
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 13:38:39 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6N8828t017031
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 13:38:03 +0530
Message-ID: <55B0A0E1.1090803@linux.vnet.ibm.com>
Date: Thu, 23 Jul 2015 13:38:01 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-leds@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, j.anaszewski@samsung.com
CC: stewart@linux.vnet.ibm.com, arnd@arndb.de, j.anaszewski81@gmail.com,
 cooloney@gmail.com, rpurdie@rpsys.net, khandual@linux.vnet.ibm.com,
 mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: Re: [PATCH v7 3/3] leds/powernv: Add driver for PowerNV platform
References: <1437576767-28496-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <1437576767-28496-4-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <55B09DFB.2080108@gmail.com>
In-Reply-To: <55B09DFB.2080108@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2015 01:25 PM, Jacek Anaszewski wrote:
> Hi Vasant,
> 

Jacek,

.../...

>> +/* PowerNV LED data */
>> +struct powernv_led_data {
>> +    struct led_classdev    cdev;
>> +    char            *loc_code;    /* LED location code */
>> +    int            led_type;    /* OPAL_SLOT_LED_TYPE_* */
>> +    enum led_brightness    value;        /* Brightness value */
> 
> You don't need 'value' as brightness value is already stored in
> cdev.brightness.
> 

Agree. I'll remove.

>> +/*
>> + * LED classdev 'brightness_get' function. This schedules work
>> + * to update LED state.
>> + */
>> +static void powernv_brightness_set(struct led_classdev *led_cdev,
>> +                   enum led_brightness value)
>> +{
>> +    struct powernv_led_data *powernv_led =
>> +        container_of(led_cdev, struct powernv_led_data, cdev);
>> +
>> +    /* Do not modify LED in unload path */
>> +    if (led_disabled)
>> +        return;
>> +
>> +    /* Prepare the request */
>> +    powernv_led->value = value;
>> +
>> +     return powernv_led_set(powernv_led);
> 
> Isn't mutex_lock/unlock missing here?

Yes. I realized this after sending out the patch. I will fix this.
.../...

>> +
>> +    max_led_type = devm_kzalloc(dev, sizeof(*max_led_type), GFP_KERNEL);
>> +    if (!max_led_type)
>> +        return -ENOMEM;
>> +
>> +    mutex_init(lock);
>> +    *max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
>> +
>> +    platform_set_drvdata(pdev, lock);
> 
> Setting only lock as drvdata looks odd to me and I haven't noticed
> anyone doing that.
> I'd prefer to put lock, led_disabled and max_led_type in a common
> struct and set it as drvdata. I know that I accepted this design, but
> I didn't take into account these details.

Yeah. Even I looked into existing code and I don't see anyone using like this.
Since it's void * and we just need lock, I added like this.

If I break this into two structure, then I've to use platform_get_drvdata() call
in multiple functions like powernv_brightness_set() to get max_let_type etc. Is
that fine?

-Vasant
