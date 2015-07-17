Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BADB51A075D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 15:54:06 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Fri, 17 Jul 2015 15:54:04 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 134F23578055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 15:53:59 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6H5rpLg10485854
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 15:54:00 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6H5rPkd006213
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 15:53:26 +1000
Message-ID: <55A89835.7020702@linux.vnet.ibm.com>
Date: Fri, 17 Jul 2015 11:22:53 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
CC: stewart@linux.vnet.ibm.com, arnd@arndb.de, j.anaszewski81@gmail.com,
 cooloney@gmail.com, rpurdie@rpsys.net, linuxppc-dev@lists.ozlabs.org,
 linux-leds@vger.kernel.org, khandual@linux.vnet.ibm.com
Subject: Re: [PATCH v5 3/3] leds/powernv: Add driver for PowerNV platform
References: <1435740638-16259-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <1435740638-16259-4-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <55A4CFA0.6090306@samsung.com> <55A75541.4060008@linux.vnet.ibm.com>
 <55A76AF6.2090805@samsung.com>
In-Reply-To: <55A76AF6.2090805@samsung.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/16/2015 01:57 PM, Jacek Anaszewski wrote:
> Hi Vasan,
> 

Hello Jacek,

.../...

>>
>> I have added as
>> -  compatible : "ibm,opal-v3-led".
> 
> Please retain "Should be :".
> 

Done.

.../...

>>>
>>> Please parse the led type once upon initialization and add related
>>> property to the struct powernv_led_data that will hold the value.
>>
>> I thought we can get location code and type using class dev name itself. Hence I
>> didn't add these two properties to structure..
> 
> This way you are doing extra work for parsing the name each time
> the brightness is set.

Agreed. I have added them to structure now.

> 
>> Do you want me to add them to structure itself?
> 
> Yes, please add them.

Done.

> 
>>>
>>>> +    loc_code = powernv_get_location_code(led_cdev);
>>>> +    if (!loc_code)
>>>> +        return;
>>>
>>> The same situation as in case of led type.
>>>
>>>> +    /* Prepare for the OPAL call */
>>>> +    max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
>>>
>>> This value could be also calculated only once.
>>
>> Yeah. May be I can move this to powernv_leds_priv structure.
>>
>>>
>>>> +    led_mask = OPAL_SLOT_LED_STATE_ON << led_type;
>>>> +    if (value)
>>>> +        led_value = led_mask;
>>>> +
>>>> +    /* OPAL async call */
>>>> +    token = opal_async_get_token_interruptible();
>>>> +    if (token < 0) {
>>>> +        if (token != -ERESTARTSYS)
>>>> +            dev_err(led_cdev->dev,
>>>> +                "%s: Couldn't get OPAL async token\n",
>>>> +                __func__);
>>>> +        goto out_loc;
>>>> +    }
>>>> +
>>>> +    rc = opal_leds_set_ind(token, loc_code,
>>>> +                   led_mask, led_value, &max_led_type);
>>>> +    if (rc != OPAL_ASYNC_COMPLETION) {
>>>> +        dev_err(led_cdev->dev,
>>>> +            "%s: OPAL set LED call failed for %s [rc=%d]\n",
>>>> +            __func__, loc_code, rc);
>>>> +        goto out_token;
>>>> +    }
>>>> +
>>>> +    rc = opal_async_wait_response(token, &msg);
>>>> +    if (rc) {
>>>> +        dev_err(led_cdev->dev,
>>>> +            "%s: Failed to wait for the async response [rc=%d]\n",
>>>> +            __func__, rc);
>>>> +        goto out_token;
>>>> +    }
>>>> +
>>>> +    rc = be64_to_cpu(msg.params[1]);
>>>> +    if (rc != OPAL_SUCCESS)
>>>> +        dev_err(led_cdev->dev,
>>>> +            "%s : OAPL async call returned failed [rc=%d]\n",
>>>> +            __func__, rc);
>>>> +
>>>> +out_token:
>>>> +    opal_async_release_token(token);
>>>> +
>>>> +out_loc:
>>>> +    kfree(loc_code);
>>>> +}
>>>> +
>>>> +/*
>>>> + * This function fetches the LED state for a given LED type for
>>>> + * mentioned LED classdev structure.
>>>> + */
>>>> +static enum led_brightness powernv_led_get(struct led_classdev *led_cdev)
>>>> +{
>>>> +    char *loc_code;
>>>> +    int rc, led_type;
>>>> +    __be64 led_mask, led_value, max_led_type;
>>>> +
>>>> +    led_type = powernv_get_led_type(led_cdev);
>>>> +    if (led_type == -1)
>>>> +        return LED_OFF;
>>>> +
>>>> +    loc_code = powernv_get_location_code(led_cdev);
>>>> +    if (!loc_code)
>>>> +        return LED_OFF;
>>>> +
>>>> +    /* Fetch all LED status */
>>>> +    led_mask = cpu_to_be64(0);
>>>> +    led_value = cpu_to_be64(0);
>>>> +    max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
>>>> +
>>>> +    rc = opal_leds_get_ind(loc_code, &led_mask, &led_value, &max_led_type);
>>>> +    if (rc != OPAL_SUCCESS && rc != OPAL_PARTIAL) {
>>>> +        dev_err(led_cdev->dev,
>>>> +            "%s: OPAL get led call failed [rc=%d]\n",
>>>> +            __func__, rc);
>>>> +        goto led_fail;
>>>> +    }
>>>> +
>>>> +    led_mask = be64_to_cpu(led_mask);
>>>> +    led_value = be64_to_cpu(led_value);
>>>
>>> be64_to_cpu result should be assigned to the variable of u64/s64 type.
>>
>> PowerNV platform is capable of running both big/little endian mode.. But
>> presently our firmware is big endian. These variable contains big endian values.
>> Hence I have created as __be64 .. (This is the convention we follow in other
>> places as well).
> 
> It is correct that the argument is of __be64 type, but be64_to_cpu
> returns u64 type, whereas you assign it to  __be64.
> 

Got it .. Fixed.

>>>
>>>> +    /* LED status available */
>>>> +    if (!((led_mask >> led_type) & OPAL_SLOT_LED_STATE_ON)) {
>>>> +        dev_err(led_cdev->dev,
>>>> +            "%s: LED status not available for %s\n",
>>>> +            __func__, led_cdev->name);
>>>> +        goto led_fail;
>>>> +    }
>>>> +
>>>> +    /* LED status value */
>>>> +    if ((led_value >> led_type) & OPAL_SLOT_LED_STATE_ON) {
>>>> +        kfree(loc_code);
>>>> +        return LED_FULL;
>>>> +    }
>>>> +
>>>> +led_fail:
>>>> +    kfree(loc_code);
>>>> +    return LED_OFF;
>>>> +}
>>>> +
>>>> +/* Execute LED set task for given led classdev */
>>>> +static void powernv_deferred_led_set(struct work_struct *work)
>>>> +{
>>>> +    struct powernv_led_data *powernv_led =
>>>> +        container_of(work, struct powernv_led_data, work_led);
>>>> +
>>>> +    mutex_lock(&powernv_led->lock);
>>>> +    powernv_led_set(&powernv_led->cdev, powernv_led->value);
>>>> +    mutex_unlock(&powernv_led->lock);
>>>> +}
>>>> +
>>>> +/*
>>>> + * LED classdev 'brightness_get' function. This schedules work
>>>> + * to update LED state.
>>>> + */
>>>> +static void powernv_brightness_set(struct led_classdev *led_cdev,
>>>> +                   enum led_brightness value)
>>>> +{
>>>> +    struct powernv_led_data *powernv_led =
>>>> +        container_of(led_cdev, struct powernv_led_data, cdev);
>>>> +
>>>> +    /* Do not modify LED in unload path */
>>>> +    if (led_disabled)
>>>> +        return;
>>>> +
>>>> +    /* Prepare the request */
>>>> +    powernv_led->value = value;
>>>> +
>>>> +    /* Schedule the new task */
>>>> +    schedule_work(&powernv_led->work_led);
>>>> +}
>>>> +
>>>> +/* LED classdev 'brightness_get' function */
>>>> +static enum led_brightness
>>>> +powernv_brightness_get(struct led_classdev *led_cdev)
>>>> +{
>>>> +    return powernv_led_get(led_cdev);
>>>> +}
>>>> +
>>>> +
>>>> +/*
>>>> + * This function registers classdev structure for any given type of LED on
>>>> + * a given child LED device node.
>>>> + */
>>>> +static int powernv_led_create(struct device *dev,
>>>> +                  struct powernv_led_data *powernv_led,
>>>> +                  const char *led_name, const char *led_type_desc)
>>>> +{
>>>> +    int rc;
>>>> +
>>>> +    /* Create the name for classdev */
>>>> +    powernv_led->cdev.name = kasprintf(GFP_KERNEL, "%s:%s",
>>>> +                       led_name, led_type_desc);
>>>
>>> Please use devm_kasprintf.
>>
>> Done.
>>
>>>
>>>> +    if (!powernv_led->cdev.name) {
>>>> +        dev_err(dev,
>>>> +            "%s: Memory allocation failed for classdev name\n",
>>>> +            __func__);
>>>> +        return -ENOMEM;
>>>> +    }
>>>> +
>>>> +    /* Make sure LED type is supported */
>>>> +    if (powernv_get_led_type(&powernv_led->cdev) == -1) {
>>>> +        kfree(powernv_led->cdev.name);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    powernv_led->cdev.brightness_set = powernv_brightness_set;
>>>> +    powernv_led->cdev.brightness_get = powernv_brightness_get;
>>>> +    powernv_led->cdev.brightness = LED_OFF;
>>>> +    powernv_led->cdev.max_brightness = LED_FULL;
>>>> +
>>>> +    mutex_init(&powernv_led->lock);
>>>> +    INIT_WORK(&powernv_led->work_led, powernv_deferred_led_set);
>>>> +
>>>> +    /* Register the classdev */
>>>> +    rc = led_classdev_register(dev, &powernv_led->cdev);
>>>
>>> devm_led_classdev_register is also available.
>>
>> Looks like most of the existing drivers are using led_classdev_register
>> function..
>> Which one is preferred here?
> 
> It is quite new API, but it is now preferable.

Ok..Let me use new API.

-Vasant
