Return-Path: <jacek.anaszewski@gmail.com>
Received: from mail-wi0-x244.google.com (mail-wi0-x244.google.com
 [IPv6:2a00:1450:400c:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 99B891A09A6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 07:41:44 +1000 (AEST)
Received: by wijp15 with SMTP id p15so845669wij.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2015 14:41:41 -0700 (PDT)
Message-ID: <55AC193B.9060005@gmail.com>
Date: Sun, 19 Jul 2015 23:40:11 +0200
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
MIME-Version: 1.0
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
CC: Jacek Anaszewski <j.anaszewski@samsung.com>,
 linux-leds@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 stewart@linux.vnet.ibm.com, arnd@arndb.de, cooloney@gmail.com,
 rpurdie@rpsys.net, khandual@linux.vnet.ibm.com, mpe@ellerman.id.au,
 benh@kernel.crashing.org
Subject: Re: [PATCH v6 3/3] leds/powernv: Add driver for PowerNV platform
References: <1437129671-14078-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <1437129671-14078-4-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <55A91E67.6010200@samsung.com> <55A92B44.6020502@linux.vnet.ibm.com>
In-Reply-To: <55A92B44.6020502@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Vasant,

I've revised your patch and found few more issues.
Please refer to my comments below.


On 17.07.2015 18:20, Vasant Hegde wrote:
> On 07/17/2015 08:55 PM, Jacek Anaszewski wrote:
>> Hi Vasant,
>
> Hi Jacek,
>
>
> .../...
>
>
>>> As per the LED class framework, the 'brightness_set' function should not
>>> sleep. Hence these functions have been implemented through global work
>>> queue tasks which might sleep on OPAL async call completion.
>>>
>>> The platform level implementation of LED get and set state has been achieved
>>
>> Please don't exceed 75 character line length limit.
>
> Ok. I will fix it.. But I thought 80 character is the limit.

checkpatch.pl reports this.

>>
>>> through OPAL calls. These calls are made available for the driver by
>>> exporting from architecture specific codes.
>>>
>
> .../...
>
>>> +
>>> +#include <asm/opal.h>
>>> +
>>> +/*
>>> + * By default unload path resets all the LEDs. But on PowerNV platform
>>> + * we want to retain LED state across reboot as these are controlled by
>>> + * firmware. Also service processor can modify the LEDs independent of
>>> + * OS. Hence avoid resetting LEDs in unload path.
>>> + */
>>> +static bool led_disabled;
>>
>> Please move this to the struct powernv_leds_priv.
>
> Hmmm.. Ok. Will update and use platform_get_drvdata to access platform_get_drvdata.
>>
>>> +
>>> +/* Map LED type to description. */
>>> +struct led_type_map {
>>> +    const int    type;
>>> +    const char    *desc;
>>> +};
>>> +static const struct led_type_map led_type_map[] = {
>>> +    {OPAL_SLOT_LED_TYPE_ID,        POWERNV_LED_TYPE_IDENTIFY},
>>> +    {OPAL_SLOT_LED_TYPE_FAULT,    POWERNV_LED_TYPE_FAULT},
>>> +    {OPAL_SLOT_LED_TYPE_ATTN,    POWERNV_LED_TYPE_ATTENTION},
>>> +    {-1,                NULL},
>>> +};
>>> +
>>> +/*
>>> + * LED set routines have been implemented as work queue tasks scheduled
>>> + * on the global work queue. Individual task calls OPAL interface to set
>>> + * the LED state which might sleep for some time.
>>> + */
>>> +struct powernv_led_data {
>>> +    struct led_classdev    cdev;
>>> +    char            *loc_code;    /* LED location code */
>>> +    int            led_type;    /* OPAL_SLOT_LED_TYPE_* */
>>> +    enum led_brightness    value;        /* Brightness value */
>>> +    struct mutex        lock;

You're unnecessarily adding mutex for each LED class device.
The shared resource to protect is here powernv led interface,
so one mutex will suffice.


>>> +    struct work_struct    work_led;    /* LED update workqueue */
>>> +};
>>> +
>>> +struct powernv_leds_priv {
>>> +    int num_leds;
>>> +    struct powernv_led_data powernv_leds[];
>>> +};

powernv_led_data doesn't have to be retained in the array. You access
the array elements only upon creation of LED class devices. When using
managed resource allocation you don't need to bother with freeing
resources, so you don't need to keep reference to the data.

I propose to drop struct powernv_leds_priv and instead introduce
a structure that would aggregate common driver data like mutex,
led_disable and max_led_type.

>>> +
>>> +static __be64 max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
>>
>> The C standard prohibits initialization of global objects with non-constant
>> values. Section 6.7.8 of the C99 standard states:
>>
>> "All the expressions in an initializer for an object that has static storage
>> duration shall be constant expressions or string literals."
>>
>> Compilation succeeds when using powerpc64-linux-gcc because then
>> the following version of macro is used:
>>
>> #define cpu_to_be64(x) (x)
>>
>> and not
>>
>> #define cpu_to_be64(x) swab64(x)
>>
>> Please move max_led_type also to the struct powernv_leds_priv
>> and initialize it dynamically.
>
> Yeah.. I should have added this to structure itself. Will fix.
>
>>
>>> +
>>> +
>>> +static inline int sizeof_powernv_leds_priv(int num_leds)
>>> +{
>>> +    return sizeof(struct powernv_leds_priv) +
>>> +        (sizeof(struct powernv_led_data) * num_leds);
>>> +}
>>> +/* Returns OPAL_SLOT_LED_TYPE_* for given led type string */
>>> +static int powernv_get_led_type(const char *led_type_desc)
>>> +{
>>> +    int i;
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(led_type_map); i++)
>>> +        if (!strcmp(led_type_map[i].desc, led_type_desc))
>>> +            return led_type_map[i].type;
>>> +
>>> +    return -1;
>>> +}
>>> +
>>> +/*
>>> + * This commits the state change of the requested LED through an OPAL call.
>>> + * This function is called from work queue task context when ever it gets
>>> + * scheduled. This function can sleep at opal_async_wait_response call.
>>> + */
>>> +static void powernv_led_set(struct powernv_led_data *powernv_led)
>>> +{
>>> +    int rc, token;
>>> +    u64 led_mask, led_value = 0;
>>> +    __be64 max_type;
>>> +    struct opal_msg msg;
>>> +    struct device *dev = powernv_led->cdev.dev;
>>> +
>>> +    /* Prepare for the OPAL call */
>>> +    max_type = max_led_type;
>>> +    led_mask = OPAL_SLOT_LED_STATE_ON << powernv_led->led_type;
>>> +    if (powernv_led->value)
>>> +        led_value = led_mask;
>>> +
>>> +    /* OPAL async call */
>>> +    token = opal_async_get_token_interruptible();
>>> +    if (token < 0) {
>>> +        if (token != -ERESTARTSYS)
>>> +            dev_err(dev, "%s: Couldn't get OPAL async token\n",
>>> +                __func__);
>>> +        return;
>>> +    }
>>> +
>>> +    rc = opal_leds_set_ind(token, powernv_led->loc_code,
>>> +                   led_mask, led_value, &max_type);
>>> +    if (rc != OPAL_ASYNC_COMPLETION) {
>>> +        dev_err(dev, "%s: OPAL set LED call failed for %s [rc=%d]\n",
>>> +            __func__, powernv_led->loc_code, rc);
>>> +        goto out_token;
>>> +    }
>>> +
>>> +    rc = opal_async_wait_response(token, &msg);
>>> +    if (rc) {
>>> +        dev_err(dev,
>>> +            "%s: Failed to wait for the async response [rc=%d]\n",
>>> +            __func__, rc);
>>> +        goto out_token;
>>> +    }
>>> +
>>> +    rc = be64_to_cpu(msg.params[1]);
>>> +    if (rc != OPAL_SUCCESS)
>>> +        dev_err(dev, "%s : OAPL async call returned failed [rc=%d]\n",
>>> +            __func__, rc);
>>> +
>>> +out_token:
>>> +    opal_async_release_token(token);
>>> +}
>>> +
>>> +/*
>>> + * This function fetches the LED state for a given LED type for
>>> + * mentioned LED classdev structure.
>>> + */
>>> +static enum led_brightness
>>> +powernv_led_get(struct powernv_led_data *powernv_led)
>>> +{
>>> +    int rc;
>>> +    __be64 mask, value, max_type;
>>> +    u64 led_mask, led_value;
>>> +    struct device *dev = powernv_led->cdev.dev;
>>> +
>>> +    /* Fetch all LED status */
>>> +    mask = cpu_to_be64(0);
>>> +    value = cpu_to_be64(0);
>>> +    max_type = max_led_type;
>>> +
>>> +    rc = opal_leds_get_ind(powernv_led->loc_code,
>>> +                   &mask, &value, &max_type);
>>> +    if (rc != OPAL_SUCCESS && rc != OPAL_PARTIAL) {
>>> +        dev_err(dev, "%s: OPAL get led call failed [rc=%d]\n",
>>> +            __func__, rc);
>>> +        return LED_OFF;
>>> +    }
>>> +
>>> +    led_mask = be64_to_cpu(mask);
>>> +    led_value = be64_to_cpu(value);
>>> +
>>> +    /* LED status available */
>>> +    if (!((led_mask >> powernv_led->led_type) & OPAL_SLOT_LED_STATE_ON)) {
>>> +        dev_err(dev, "%s: LED status not available for %s\n",
>>> +            __func__, powernv_led->cdev.name);
>>> +        return LED_OFF;
>>> +    }
>>> +
>>> +    /* LED status value */
>>> +    if ((led_value >> powernv_led->led_type) & OPAL_SLOT_LED_STATE_ON)
>>> +        return LED_FULL;
>>> +
>>> +    return LED_OFF;
>>> +}
>>> +
>>> +/* Execute LED set task for given led classdev */
>>> +static void powernv_deferred_led_set(struct work_struct *work)
>>> +{
>>> +    struct powernv_led_data *powernv_led =
>>> +        container_of(work, struct powernv_led_data, work_led);
>>> +
>>> +    mutex_lock(&powernv_led->lock);
>>> +    powernv_led_set(powernv_led);
>>> +    mutex_unlock(&powernv_led->lock);
>>> +}
>>> +
>>> +/*
>>> + * LED classdev 'brightness_get' function. This schedules work
>>> + * to update LED state.
>>> + */
>>> +static void powernv_brightness_set(struct led_classdev *led_cdev,
>>> +                   enum led_brightness value)
>>> +{
>>> +    struct powernv_led_data *powernv_led =
>>> +        container_of(led_cdev, struct powernv_led_data, cdev);
>>> +
>>> +    /* Do not modify LED in unload path */
>>> +    if (led_disabled)
>>> +        return;
>>> +
>>> +    /* Prepare the request */
>>> +    powernv_led->value = value;
>>> +
>>> +    /* Schedule the new task */
>>> +    schedule_work(&powernv_led->work_led);
>>> +}
>>> +
>>> +/* LED classdev 'brightness_get' function */
>>> +static enum led_brightness
>>> +powernv_brightness_get(struct led_classdev *led_cdev)
>>> +{
>>> +    struct powernv_led_data *powernv_led =
>>> +        container_of(led_cdev, struct powernv_led_data, cdev);
>>> +
>>> +    return powernv_led_get(powernv_led);
>>> +}
>>> +
>>> +
>>> +/*
>>> + * This function registers classdev structure for any given type of LED on
>>> + * a given child LED device node.
>>> + */
>>> +static int powernv_led_create(struct device *dev,
>>> +                  struct powernv_led_data *powernv_led,
>>> +                  const char *led_name, const char *led_type_desc)
>>> +{
>>> +    int rc;
>>> +
>>> +    /* Make sure LED type is supported */
>>> +    powernv_led->led_type = powernv_get_led_type(led_type_desc);
>>> +    if (powernv_led->led_type == -1) {
>>> +        dev_warn(dev, "%s: No support for led type : %s\n",
>>> +             __func__, led_type_desc);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    /* Location code of the LED */
>>> +    powernv_led->loc_code = kasprintf(GFP_KERNEL, "%s", led_name);
>>
>> DT node name is available all the time, you don't need another variable
>> for it.
>
> Yes.. But then we have to traverse through  DT node get location code in
> powernv_led_get() and powernv_led_set() function. something like
> 	for_each_child_of_node(led_node, np) {
> 		if (!strstr(np->name, powernv_led->cdev.name) {
> 			/* Process get/set LED */
> 			break;
> 		}
> 	}
> 	
> Hence I thought of adding that to structure itself.

I meant that you can store the pointer to the DT node name, which
is a location code name and you don't need to allocate new memory
for the string.

> 			
>>
>>> +    if (!powernv_led->loc_code) {
>>> +        dev_err(dev, "%s: Memory allocation failed\n", __func__);
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>> +    /* Create the name for classdev */
>>> +    powernv_led->cdev.name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s",
>>> +                        led_name, led_type_desc);
>>> +    if (!powernv_led->cdev.name) {
>>> +        dev_err(dev,
>>> +            "%s: Memory allocation failed for classdev name\n",
>>> +            __func__);
>>> +        kfree(powernv_led->loc_code);
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>> +    powernv_led->cdev.brightness_set = powernv_brightness_set;
>>> +    powernv_led->cdev.brightness_get = powernv_brightness_get;
>>> +    powernv_led->cdev.brightness = LED_OFF;
>>> +    powernv_led->cdev.max_brightness = LED_FULL;
>>> +
>>> +    mutex_init(&powernv_led->lock);
>>> +    INIT_WORK(&powernv_led->work_led, powernv_deferred_led_set);
>>> +
>>> +    /* Register the classdev */
>>> +    rc = devm_led_classdev_register(dev, &powernv_led->cdev);
>>> +    if (rc) {
>>> +        dev_err(dev, "%s: Classdev registration failed for %s\n",
>>> +            __func__, powernv_led->cdev.name);
>>> +        kfree(powernv_led->loc_code);
>>> +        kfree(powernv_led->cdev.name);

You don't need to explicitly free the memory allocated with
devm_kasprintf if this will result in probe failure - all allocations
committed with managed resource allocation will be unrolled then.

>>> +    }
>>> +
>>> +    return rc;
>>> +}
>>> +
>>> +/* Go through LED device tree node and register LED classdev structure */
>>> +static int powernv_led_classdev(struct platform_device *pdev,
>>> +                struct device_node *led_node,
>>> +                struct powernv_leds_priv *priv, int num_leds)
>>> +{
>>> +    const char *cur = NULL;
>>> +    int i, rc = -1;
>>> +    struct property *p;
>>> +    struct device_node *np;
>>> +    struct powernv_led_data *powernv_led;
>>> +    struct device *dev = &pdev->dev;
>>> +
>>> +    for_each_child_of_node(led_node, np) {
>>> +        p = of_find_property(np, "led-types", NULL);
>>> +        if (!p)
>>> +            continue;
>>> +
>>> +        while ((cur = of_prop_next_string(p, cur)) != NULL) {
>>> +            powernv_led = &priv->powernv_leds[priv->num_leds++];
>>> +            if (priv->num_leds > num_leds) {
>>> +                rc = -ENOMEM;
>>> +                goto classdev_fail;
>>> +            }
>>> +            rc = powernv_led_create(dev,
>>> +                        powernv_led, np->name, cur);
>>> +            if (rc)
>>> +                goto classdev_fail;
>>> +        } /* while end */
>>> +    }
>>> +
>>> +    platform_set_drvdata(pdev, priv);
>>> +    return rc;
>>> +
>>> +classdev_fail:
>>> +    for (i = priv->num_leds - 2; i >= 0; i--) {
>>> +        powernv_led = &priv->powernv_leds[i];
>>> +        devm_led_classdev_unregister(dev, &powernv_led->cdev);

Upon driver detach all LED class devices registered with devm prefixed
API will be unregistered automatically.

>>> +        kfree(powernv_led->loc_code);
>>> +        mutex_destroy(&powernv_led->lock);
>>> +    }
>>> +
>>> +    return rc;
>>> +}
>>> +
>>> +/*
>>> + * We want to populate LED device for each LED type. Hence we
>>> + * have to calculate count explicitly.
>>> + */
>>> +static int powernv_leds_count(struct device_node *led_node)
>>> +{
>>> +    const char *cur = NULL;
>>> +    int num_leds = 0;
>>> +    struct property *p;
>>> +    struct device_node *np;
>>> +
>>> +    for_each_child_of_node(led_node, np) {
>>> +        p = of_find_property(np, "led-types", NULL);
>>> +        if (!p)
>>> +            continue;
>>> +
>>> +        while ((cur = of_prop_next_string(p, cur)) != NULL)
>>> +            num_leds++;
>>> +    }
>>> +
>>> +    return num_leds;
>>> +}
>>> +
>>> +/* Platform driver probe */
>>> +static int powernv_led_probe(struct platform_device *pdev)
>>> +{
>>> +    int num_leds;
>>> +    struct device_node *led_node;
>>> +    struct powernv_leds_priv *priv;
>>> +
>>> +    led_node = of_find_node_by_path("/ibm,opal/leds");
>>> +    if (!led_node) {
>>> +        dev_err(&pdev->dev,
>>> +            "%s: LED parent device node not found\n", __func__);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    num_leds = powernv_leds_count(led_node);
>>> +    if (num_leds <= 0) {
>>> +        dev_err(&pdev->dev,
>>> +            "%s: No location code found under LED node\n",
>>> +            __func__);
>>> +        return -EINVAL;
>>> +    }

You won't need to count the number of LEDs to register, just allocate
memory for each LED during parsing with managed resource allocation
API.

>>> +
>>> +    priv = devm_kzalloc(&pdev->dev,
>>> +                sizeof_powernv_leds_priv(num_leds), GFP_KERNEL);
>>> +    if (!priv)
>>> +        return -ENOMEM;
>>> +
>>> +    return powernv_led_classdev(pdev, led_node, priv, num_leds);
>>> +}
>>> +
>>> +/* Platform driver remove */
>>> +static int powernv_led_remove(struct platform_device *pdev)
>>> +{
>>> +    int i;
>>> +    struct powernv_led_data *powernv_led;
>>> +    struct powernv_leds_priv *priv;
>>> +
>>> +    /* Disable LED operation */
>>> +    led_disabled = true;
>>> +
>>> +    priv = platform_get_drvdata(pdev);
>>> +

Here you will only need mutex_destroy.

Please also drop work queue, as it is going to be supported
by the LED core, when the patch set [1] will be merged.

>>> +    for (i = 0; i < priv->num_leds; i++) {
>>> +        powernv_led = &priv->powernv_leds[i];
>>> +        devm_led_classdev_unregister(&pdev->dev, &powernv_led->cdev);
>>> +        flush_work(&powernv_led->work_led);
>>> +        kfree(powernv_led->loc_code);
>>> +        mutex_destroy(&powernv_led->lock);
>>> +    }
>>> +
>>> +    dev_info(&pdev->dev, "PowerNV led module unregistered\n");
>>> +    return 0;
>>> +}
>>> +
>>> +/* Platform driver property match */
>>> +static const struct of_device_id powernv_led_match[] = {
>>> +    {
>>> +        .compatible    = "ibm,opal-v3-led",
>>> +    },
>>> +    {},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, powernv_led_match);
>>> +
>>> +static struct platform_driver powernv_led_driver = {
>>> +    .probe    = powernv_led_probe,
>>> +    .remove = powernv_led_remove,
>>> +    .driver = {
>>> +        .name = "powernv-led-driver",
>>> +        .owner = THIS_MODULE,
>>> +        .of_match_table = powernv_led_match,
>>> +    },
>>> +};
>>> +
>>> +module_platform_driver(powernv_led_driver);
>>> +
>>> +MODULE_LICENSE("GPL");
>>
>> If you want to be consistent with what you declare in the beginnig
>> then it should be:
>>
>> MODULE_LICENSE("GPL v2")
>
> Fixed.
>
> Thanks!
> -Vasant
>
>

[1] https://lkml.org/lkml/2015/7/17/151

-- 
Best Regards,
Jacek Anaszewski
