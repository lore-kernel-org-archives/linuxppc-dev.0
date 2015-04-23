Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A7FE31A0BF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 14:58:35 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Thu, 23 Apr 2015 14:58:34 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E8338357804C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 14:58:31 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3N4wNph66912396
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 14:58:31 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3N4vvXc011771
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 14:57:57 +1000
Message-ID: <55387BC2.1050004@linux.vnet.ibm.com>
Date: Thu, 23 Apr 2015 10:27:38 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski81@gmail.com>
Subject: Re: [PATCH v3 3/3] leds/powernv: Add driver for PowerNV platform
References: <20150422234524.305b5324@ja.home>
In-Reply-To: <20150422234524.305b5324@ja.home>
Content-Type: text/plain; charset=windows-1252
Cc: stewart@linux.vnet.ibm.com, devicetree@vger.kernel.org, cooloney@gmail.com,
 rpurdie@rpsys.net, linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/23/2015 03:15 AM, Jacek Anaszewski wrote:
>> On 21.04.2015 07:50, Vasant Hegde wrote:
>> On 04/20/2015 08:57 PM, Jacek Anaszewski wrote:
>>> Hi Vasant,
>>>
>>

Jacek,

.../...

>>>>
>>>> All the system LEDs can be found in the same regular
>>>> path /sys/class/leds/. We don't use LED colors. Hence our LEDs have
>>>> names in this format.
>>>>
>>>>           <location_code>:<ATTENTION|IDENT|FAULT>
>>>
>>> I think that powernv prefix should be also present in the beginning.
>>> What would be the format of <location_code> ? Does it identify a LED
>>> uniquely.
>>
>> Location code is unique and its guaranteed that we don't clash here.
>> Also this is platform specific LEDs and I don't see any value by
>> prefixing "powernv". Hence I think its fine with current format.
>>
>> Sample location code : U78C9.001.RST0027-P1-C1
>>    Here "U78C9.001.RST0027" represents the system model
>>               P1 - Planar 1
>>               C1 - Card 1
> 
> I consulted ePAPR standard and all the characters used for location code
> are allowed. Nonetheless AFAIK no existing bindings use uppercase for
> node name.
> 

These are PowerNV platform specific properties..


> 
> We will need DT maintainer's ack here too, so cc DT list.
> Please CC devicetree@vger.kernel.org next time, especially for
> DT documentation patch.
> 

Sure. Next time I will CC DT mailing list.

@Ben,
  Any comments?

>> .../...
>>
>>>> +led {
>>>> +    compatible = "ibm,opal-v3-led";
>>>> +    phandle = <0x1000006b>;
>>>> +    linux,phandle = <0x1000006b>;
>>>> +    led-mode = "lightpath";
>>>> +
>>>> +    U78C9.001.RST0027-P1-C1 {
>>>
>>> DT node names should be in lowercase form.
>>> Is U78C9.001.RST0027-P1-C1 a location code?
>>
>> Yes ... Node presents the location code.. Platform provides these
>> location code in upper case. Hence our OPAL firmware exposes them in
>> upper case.
>>
>>>
>>>> +        led-types = "identify", "fault";
>>>> +        led-loc = "descendent";
>>>> +        phandle = <0x1000006f>;
>>>> +        linux,phandle = <0x1000006f>;
> 
> I think that all these properties will not be needed.

These properties are coming from our firmware which is static.

phandle property is default .. which is required to uniquely identify node
inside  DT.
led-loc property is not used today. If its not going to be used forever then I
can request
FW folks to remove it later.


> 
>>>> +    };
>>>> +    ...
>>>> +    ...
>>>> +};
>>>> +
>>>> +
>>>> +'compatible' property describes LEDs compatibility.
>>>
>>> compatible doesn't need to be mentioned here.
>>
>> Removed.
>>
>>>
>>>> +'led-mode' property describes service indicator mode
>>>> (lightpath/guidinglight).
>>>
>>> You don't parse this in the driver? What is its purpose?
>>
>> As mentioned in other thread, currently our driver doesn't parse
>> this. (As mode is provided by platform and its static).
>>
>> Do you want me to elaborate this property here?
> 
> I don't think so. At least for now :)

Ok.

> 
>> .../...
>>
>>>> +
>>>> +/*
>>>> + * By default unload path resets all the LEDs. But on PowerNV
>>>> platform
>>>> + * we want to retain LED state across reboot as these are
>>>> controlled by
>>>> + * firmware. Also service processor can modify the LEDs
>>>> independent of
>>>> + * OS. Hence avoid resetting LEDs in unload path.
>>>> + */
>>>> +static bool led_disabled;
>>>
>>> I think that we have to make it configurable from the Device Tree
>>> level. There could be a 'retain-state-removed' property introduced.
>>
>> Hmmm.. In my case, LED behavior is not going to change. Hence I don't
>> think we need this property.
> 
> Can you guarantee that the next version of the platform will have also
> the same requirements? What if it would be made available to choose
> that the LEDs are software-only controlled?

This design exists for ages.. IMO if we change this to software control (or
dynamic property which can be changed during runtime) then it completely defeats
the LED purpose. Hence I don't think it will change anytime.

> 
> If these are unjustified doubts, I'm ok with leaving the static
> variable.
> 
>>>
>>> There is also another implication - you define LED_CORE_SUSPENDRESUME
>>> flag. With current approach it wouldn't turn the led off on suspend.
>>> Please either drop the flag or assure correct behaviour on suspend.
>>
>> I will drop this.
>>
>>> You can also make this configurable like retain-state-suspended
>>> property in Documentation/devicetree/bindings/leds/leds-gpio.txt.
>>>
>>
>> .../...
>>
>>>> +
>>>> +    if (powernv_get_loc_code(led_type, loc_code) != 0)
>>>> +        goto out_loc;
>>>> +
>>>> +    /* Prepare for the OPAL call */
>>>> +    max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
>>>> +    led_mask = OPAL_SLOT_LED_STATE_ON << led_type;
>>>> +    if (value)
>>>> +        led_value = OPAL_SLOT_LED_STATE_ON << led_type;
>>>
>>>          led_value = led_mask;
>>
>> Fixed.
>>
>> .../...
>>
>>>> +
>>>> +/* Schedule work to update LED state */
>>>> +static void powernv_led_set_queue(struct led_classdev *led_cdev,
>>>> +                  enum led_brightness value, u64 led_type)
>>>
>>> It doesn't set any queue. It should be powernv_brightness_set.
>>
>> Make sense. Fixed.
>>
>> .../...
>>
>>>> +    /* Create the name for classdev */
>>>> +    switch (led_type) {
>>>> +    case OPAL_SLOT_LED_TYPE_ATTN:
>>>> +        powernv_led->cdev.name = kasprintf(GFP_KERNEL,
>>>> +                           "%s%s", node->name,
>>>> +                           POWERNV_LED_ATTN);
>>>
>>> LED name should be taken from of_node name or label property
>>> directly. Please refer to the other LED class drivers.
>>
>> Hmmm.. Our  current FW provides led-types property which tells
>> available type for given location code..
>> like
>>    led-types = "identify" "fault"..
>>
>> Can I use this ? So the names will be
>>     <location_code>:<identify|fault|attention>
> 
> I adressed this in the other message.
> 
>> And if this approach fine,  I can fix (assuming maintainer agrees :-)
>> ) firmware side to change identify -> ident.
> 
> Let's leave it. It seems to be platform specific.

Sure.

Thanks!
-Vasant
