Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 63CEC1A0025
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 15:50:56 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Tue, 21 Apr 2015 11:20:53 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id A29031258059
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 11:22:46 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3L5om6J65667312
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 11:20:49 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3L5olxg010992
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 11:20:48 +0530
Message-ID: <5535E52C.6030908@linux.vnet.ibm.com>
Date: Tue, 21 Apr 2015 11:20:36 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v3 3/3] leds/powernv: Add driver for PowerNV platform
References: <20150420075558.12371.6697.stgit@localhost.localdomain>
 <20150420080124.12371.41528.stgit@localhost.localdomain>
 <55351AEE.70806@samsung.com>
In-Reply-To: <55351AEE.70806@samsung.com>
Content-Type: text/plain; charset=utf-8
Cc: stewart@linux.vnet.ibm.com, cooloney@gmail.com, rpurdie@rpsys.net,
 linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/20/2015 08:57 PM, Jacek Anaszewski wrote:
> Hi Vasant,
> 

Jacek,

Thanks for the review.

> Thanks for the update.
> 
> On 04/20/2015 10:01 AM, Vasant Hegde wrote:
>> This patch implements LED driver for PowerNV platform using the existing
>> generic LED class framework.
>>
>> PowerNV platform has below type of LEDs:
>>    - System attention
>>        Indicates there is a problem with the system that needs attention.
>>    - Identify
>>        Helps the user locate/identify a particular FRU or resource in the
>>        system.
>>    - Fault
>>        Indicates there is a problem with the FRU or resource at the
>>        location with which the indicator is associated.
>>
>> We registers classdev structures for all individual LEDs detected on the
> 
> s/registers/register

Fixed.

> 
>> system through LED specific device tree nodes. Device tree nodes specify
>> what  all kind of LEDs present on the same location code.It registers
>> LED classdev structure for each of them.
>>
>> All the system LEDs can be found in the same regular path /sys/class/leds/.
>> We don't use LED colors. Hence our LEDs have names in this format.
>>
>>          <location_code>:<ATTENTION|IDENT|FAULT>
> 
> I think that powernv prefix should be also present in the beginning.
> What would be the format of <location_code> ? Does it identify a LED
> uniquely.

Location code is unique and its guaranteed that we don't clash here. Also this
is platform specific LEDs and I don't see any value by prefixing "powernv".
Hence I think its fine with current format.

Sample location code : U78C9.001.RST0027-P1-C1
  Here "U78C9.001.RST0027" represents the system model
             P1 - Planar 1
             C1 - Card 1

.../...

>> +led {
>> +    compatible = "ibm,opal-v3-led";
>> +    phandle = <0x1000006b>;
>> +    linux,phandle = <0x1000006b>;
>> +    led-mode = "lightpath";
>> +
>> +    U78C9.001.RST0027-P1-C1 {
> 
> DT node names should be in lowercase form.
> Is U78C9.001.RST0027-P1-C1 a location code?

Yes ... Node presents the location code.. Platform provides these location code
in upper case. Hence our OPAL firmware exposes them in upper case.

> 
>> +        led-types = "identify", "fault";
>> +        led-loc = "descendent";
>> +        phandle = <0x1000006f>;
>> +        linux,phandle = <0x1000006f>;
>> +    };
>> +    ...
>> +    ...
>> +};
>> +
>> +
>> +'compatible' property describes LEDs compatibility.
> 
> compatible doesn't need to be mentioned here.

Removed.

> 
>> +'led-mode' property describes service indicator mode (lightpath/guidinglight).
> 
> You don't parse this in the driver? What is its purpose?

As mentioned in other thread, currently our driver doesn't parse this. (As mode
is provided by platform and its static).

Do you want me to elaborate this property here?

.../...

>> +
>> +/*
>> + * By default unload path resets all the LEDs. But on PowerNV platform
>> + * we want to retain LED state across reboot as these are controlled by
>> + * firmware. Also service processor can modify the LEDs independent of
>> + * OS. Hence avoid resetting LEDs in unload path.
>> + */
>> +static bool led_disabled;
> 
> I think that we have to make it configurable from the Device Tree level.
> There could be a 'retain-state-removed' property introduced.

Hmmm.. In my case, LED behavior is not going to change. Hence I don't think we
need this property.

> 
> There is also another implication - you define LED_CORE_SUSPENDRESUME
> flag. With current approach it wouldn't turn the led off on suspend.
> Please either drop the flag or assure correct behaviour on suspend.

I will drop this.

> You can also make this configurable like retain-state-suspended
> property in Documentation/devicetree/bindings/leds/leds-gpio.txt.
> 

.../...

>> +
>> +    if (powernv_get_loc_code(led_type, loc_code) != 0)
>> +        goto out_loc;
>> +
>> +    /* Prepare for the OPAL call */
>> +    max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
>> +    led_mask = OPAL_SLOT_LED_STATE_ON << led_type;
>> +    if (value)
>> +        led_value = OPAL_SLOT_LED_STATE_ON << led_type;
> 
>         led_value = led_mask;

Fixed.

.../...

>> +
>> +/* Schedule work to update LED state */
>> +static void powernv_led_set_queue(struct led_classdev *led_cdev,
>> +                  enum led_brightness value, u64 led_type)
> 
> It doesn't set any queue. It should be powernv_brightness_set.

Make sense. Fixed.

.../...

>> +    /* Create the name for classdev */
>> +    switch (led_type) {
>> +    case OPAL_SLOT_LED_TYPE_ATTN:
>> +        powernv_led->cdev.name = kasprintf(GFP_KERNEL,
>> +                           "%s%s", node->name,
>> +                           POWERNV_LED_ATTN);
> 
> LED name should be taken from of_node name or label property directly.
> Please refer to the other LED class drivers.

Hmmm.. Our  current FW provides led-types property which tells available type
for given location code..
like
  led-types = "identify" "fault"..

Can I use this ? So the names will be
   <location_code>:<identify|fault|attention>

And if this approach fine,  I can fix (assuming maintainer agrees :-) ) firmware
side to change identify -> ident.


.../...


>> +        list_add_tail(&powernv_led->link, &powernv_led_list);
> 
> You don't need a list. powernv_led can be allocated with devm_kzalloc
> and it will be released on remove automatically.


Sure. .will look into it.

-Vasant
