Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 09CFE1A1861
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 16:27:46 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 15 Apr 2015 11:57:44 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D16C2E0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 12:00:13 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3F6ReGk66846884
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 11:57:40 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3F6Qctr011810
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 11:56:40 +0530
Message-ID: <552E049D.2030604@linux.vnet.ibm.com>
Date: Wed, 15 Apr 2015 11:56:37 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v2 2/2] leds/powernv: Add driver for PowerNV platform
References: <20150320105921.14866.83209.stgit@localhost.localdomain>
 <20150320110328.14866.98225.stgit@localhost.localdomain>
 <552D303A.5080506@samsung.com>
In-Reply-To: <552D303A.5080506@samsung.com>
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

On 04/14/2015 08:50 PM, Jacek Anaszewski wrote:
> Hi Vasant,

Hi Jacek,

>>
>> This patch implements LED driver for PowerNV platform using the existing
>> generic LED class framework. It registers classdev structures for all
>> individual LEDs detected on the system through LED specific device tree
>> nodes. Device tree nodes specify what all kind of LEDs present on the
>> same location code. It registers LED classdev structure for each of them.
>>
>> The platform level implementation of LED get and set state has been
>> achieved through OPAL calls. These calls are made available for the
>> driver by exporting from architecture specific codes.
>>
>> As per the LED class framework, the 'brightness_set' function should not
>> sleep. Hence these functions have been implemented through global work
>> queue tasks which might sleep on OPAL async call completion.
> 
> Wouldn't it be easier to implement synchronization on the OPAL side?

We had thought about this.. But OPAL intern depends on service processor to
enable/disable indicator. So we can't make this as synchronous one.


.../...

>>
>> diff --git a/arch/powerpc/platforms/powernv/opal.c
>> b/arch/powerpc/platforms/powernv/opal.c
>> index 142a08a..fbfd9c1 100644
>> --- a/arch/powerpc/platforms/powernv/opal.c
>> +++ b/arch/powerpc/platforms/powernv/opal.c
>> @@ -746,7 +746,7 @@ static void __init opal_irq_init(struct device_node *dn)
>>
>>   static int __init opal_init(void)
>>   {
>> -    struct device_node *np, *consoles;
>> +    struct device_node *np, *consoles, *led;
>>       int rc;
>>
>>       opal_node = of_find_node_by_path("/ibm,opal");
>> @@ -772,6 +772,13 @@ static int __init opal_init(void)
>>       /* Create i2c platform devices */
>>       opal_i2c_create_devs();
>>
>> +    /* Create led platform devices */
>> +    led = of_find_node_by_path("/ibm,opal/led");
>> +    if (led) {
>> +        of_platform_device_create(led, "opal_led", NULL);
>> +        of_node_put(led);
>> +    }
>> +
>>       /* Find all OPAL interrupts and request them */
>>       opal_irq_init(opal_node);
>>
>> @@ -904,3 +911,6 @@ EXPORT_SYMBOL_GPL(opal_rtc_write);
>>   EXPORT_SYMBOL_GPL(opal_tpo_read);
>>   EXPORT_SYMBOL_GPL(opal_tpo_write);
>>   EXPORT_SYMBOL_GPL(opal_i2c_request);
>> +/* Export these symbols for PowerNV LED class driver */
>> +EXPORT_SYMBOL_GPL(opal_leds_get_ind);
>> +EXPORT_SYMBOL_GPL(opal_leds_set_ind);
> 
> Please split the above part to the separate patch and put it in the
> series before this one.

Sure. Will split it in next version.

> 
>> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
>> index 25b320d..a93223c 100644
>> --- a/drivers/leds/Kconfig
>> +++ b/drivers/leds/Kconfig
>> @@ -508,6 +508,15 @@ config LEDS_BLINKM
>>         This option enables support for the BlinkM RGB LED connected
>>         through I2C. Say Y to enable support for the BlinkM LED.
>>
>> +config LEDS_POWERNV
>> +    tristate "LED support for PowerNV Platform"
>> +    depends on LEDS_CLASS
>> +    depends on PPC_POWERNV
> 
> OF dependency is missing here.

Agree. Will fix.

> 
>> +    help
>> +      This option enables support for the system LEDs present on
>> +      PowerNV platforms. Say 'y' to enable this support in kernel.
>> +      Say 'm' enable this support as module.
> 
> Please change the last line to:
> 
> To compile this driver as a module, choose M here: the module will
> be called leds-powernv.
> 

Sure. Will fix.

> 
>> +
>>   config LEDS_SYSCON
>>       bool "LED support for LEDs on system controllers"
>>       depends on LEDS_CLASS=y
>> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
>> index cbba921..604ffc9 100644
>> --- a/drivers/leds/Makefile
>> +++ b/drivers/leds/Makefile
>> @@ -58,6 +58,7 @@ obj-$(CONFIG_LEDS_BLINKM)        += leds-blinkm.o
>>   obj-$(CONFIG_LEDS_SYSCON)        += leds-syscon.o
>>   obj-$(CONFIG_LEDS_VERSATILE)        += leds-versatile.o
>>   obj-$(CONFIG_LEDS_MENF21BMC)        += leds-menf21bmc.o
>> +obj-$(CONFIG_LEDS_POWERNV)        += leds-powernv.o
>>
>>   # LED SPI Drivers
>>   obj-$(CONFIG_LEDS_DAC124S085)        += leds-dac124s085.o
>> diff --git a/drivers/leds/leds-powernv.c b/drivers/leds/leds-powernv.c
>> new file mode 100644
>> index 0000000..0c9f958
>> --- /dev/null
>> +++ b/drivers/leds/leds-powernv.c
>> @@ -0,0 +1,620 @@
>> +/*
>> + * PowerNV LED Driver
>> + *
>> + * Copyright IBM Corp. 2015
>> + *
>> + * Author: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> + * Author: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
>> +
>> +#define PREFIX        "POWERNV_LED"
>> +#define pr_fmt(fmt)    PREFIX ": " fmt
> 
> Wouldn't you mind using dev_* prefixed logging?
> Unless you have a good reason not to do it.
> 

I don't see any specific reason to use pr_fmt. Will convert this to dev_*.


>> +
>> +#include <linux/platform_device.h>
>> +#include <linux/leds.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/slab.h>
>> +#include <linux/list.h>
> 
> Please keep alphabetical order.

Sure.

> 
>> +
>> +#include <asm/opal.h>
>> +
>> +#define LED_STR_ATTENTION    ":ATTENTION"
>> +#define LED_STR_IDENT        ":IDENTIFY"
>> +#define LED_STR_FAULT        ":FAULT"
> 
> Namespacing prefix is required here. LED is reserved for
> LED subsystem global macros. How about POWERNV_LED_* ?

Yep... Its my fault.. Makes sense to have POWERNV_*.

> 
>> +
>> +/*
>> + * LED operation state
>> + *
>> + * led_classdev_unregister resets the brightness values. However
>> + * we want to retain the LED state across boot.
> 
> What boot are you thinking of here?
> 
>> Hence disable
>> + * LED operation before calling led_classdev_unregister.
>> + */
> 
> This comment is unclear for me, as this is static initialization,
> unrelated to to any function call.
> 

I mean, we have to retain the state of LED across system reboot.

>> +static bool led_disabled = false;
> 
> Static variables are initialized to 0 by default.

Fixed.

.../...

>> +/*
>> + * powernv_led_compact_work_list
>> + *
>> + * This function goes through the entire list of scheduled powernv_led_work
>> + * nodes and removes the nodes which have already processed one set LED
>> + * state request from request list and has been marked for deletion. This is
>> + * essential for cleaning the list before adding new elements into it. This
>> + * also tracks the total number of pending tasks. Once it reaches the
>> + * threshold the function will throttle till all the scheduled tasks completes
>> + * execution during which the user space thread will block and will be
>> + * prevented from queuing up more LED state change requests.
>> + */
> 
> Did you test the driver with led-triggers?

I have tested set/reset LEDs .. not triggers as our user space dont' use that.

>> +
>> +    switch (led_type) {
>> +    case OPAL_SLOT_LED_TYPE_ATTN:
>> +        loc_code[strlen(loc_code) - strlen(LED_STR_ATTENTION)] = '\0';
>> +        break;
>> +    case OPAL_SLOT_LED_TYPE_ID:
>> +        loc_code[strlen(loc_code) - strlen(LED_STR_IDENT)] = '\0';
>> +        break;
>> +    case OPAL_SLOT_LED_TYPE_FAULT:
>> +        loc_code[strlen(loc_code) - strlen(LED_STR_FAULT)] = '\0';
>> +        break;
>> +    default:    /* Unknown LED type */
>> +        goto out_loc;
>> +    }
> 
> Above sequence is repeated in the function below - it could be wrapped
> with a new function.

Agree. Will fix.

.../...

>> +
>> +/*
>> + * power_led_classdev
>> + *
>> + * This function registers classdev structure for any given type of LED on
>> + * a given child LED device node.
>> + */
>> +static int power_led_classdev(struct platform_device *pdev,
>> +                  struct device_node *cled, u64 led_type)
>> +{
>> +    int rc;
>> +    unsigned long flags;
>> +    struct powernv_led *cpled;
>> +
>> +    cpled = kzalloc(sizeof(struct powernv_led), GFP_KERNEL);
>> +    if (!cpled) {
>> +        pr_err("Memory allocation failed at %s\n", __func__);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    /* Create the name for classdev */
>> +    switch (led_type) {
>> +    case OPAL_SLOT_LED_TYPE_ATTN:
>> +        cpled->cdev.name = kasprintf(GFP_KERNEL, "%s%s",
>> +                         cled->name, LED_STR_ATTENTION);
> 
> We have a 'label' DT property for naming LED Flash class devices.
> Please refer to Documentation/devicetree/bindings/leds/common.txt.
> 

In Power Systems LEDs are overloaded (meaning same LED is used for identify and
fault depending on their state  ---  blinking = identify and solid = fault).
Hence here append LED type info.


.../...

>> +
>> +static struct platform_driver powernv_led_driver = {
>> +    .probe    = powernv_led_probe,
>> +    .remove = powernv_led_remove,
>> +    .driver = {
>> +        .name = "powernv-led-driver",
>> +        .owner = THIS_MODULE,
>> +        .of_match_table = powernv_led_match,
> 
> Is somewhere DT documentation available for these leds?

These are PowerNV platform specific properties. I don't think its
specified/documented in kernel side.
These are documented in OPAL (firmware) side.


Thanks for valuable review. Will post v3 ASAP.

-Vasant
