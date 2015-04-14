Return-Path: <j.anaszewski@samsung.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D8731A0176
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 01:30:37 +1000 (AEST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NMS0058OYSWAN50@mailout1.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 14 Apr 2015 16:24:32 +0100 (BST)
Message-id: <552D303A.5080506@samsung.com>
Date: Tue, 14 Apr 2015 17:20:26 +0200
From: Jacek Anaszewski <j.anaszewski@samsung.com>
MIME-version: 1.0
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] leds/powernv: Add driver for PowerNV platform
References: <20150320105921.14866.83209.stgit@localhost.localdomain>
 <20150320110328.14866.98225.stgit@localhost.localdomain>
In-reply-to: <20150320110328.14866.98225.stgit@localhost.localdomain>
Content-type: text/plain; charset=UTF-8; format=flowed
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

Hi Vasant,

On 03/20/2015 12:04 PM, Vasant Hegde wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>
> This patch implements LED driver for PowerNV platform using the existing
> generic LED class framework. It registers classdev structures for all
> individual LEDs detected on the system through LED specific device tree
> nodes. Device tree nodes specify what all kind of LEDs present on the
> same location code. It registers LED classdev structure for each of them.
>
> The platform level implementation of LED get and set state has been
> achieved through OPAL calls. These calls are made available for the
> driver by exporting from architecture specific codes.
>
> As per the LED class framework, the 'brightness_set' function should not
> sleep. Hence these functions have been implemented through global work
> queue tasks which might sleep on OPAL async call completion.

Wouldn't it be easier to implement synchronization on the OPAL side?

> All the system LEDs can be found in the same regular path /sys/class/leds/.
> There are two different kind of LEDs present for the same location code,
> one being the identify indicator and other one being the fault indicator.
> We don't use LED colors. Hence our LEDs have names in this format.
>
>          <location_code>:<ATTENTION|IDENTIFY|FAULT>
>
> Any positive brightness value would turn on the LED and a zero value
> would turn off the LED. The driver will return LED_FULL (255) for any
> turned on LED and LED_OFF for any turned off LED.
>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
> Tested-by: Stewart Smith <stewart@linux.vnet.ibm.com>
> ---
> Changes in v2:
>    - Added System Attention indicator support
>    - Moved common code to powernv_led_set_queue()
>
> -Vasant
>
>
>   arch/powerpc/platforms/powernv/opal.c |   12 +
>   drivers/leds/Kconfig                  |    9
>   drivers/leds/Makefile                 |    1
>   drivers/leds/leds-powernv.c           |  620 +++++++++++++++++++++++++++++++++
>   4 files changed, 641 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/leds/leds-powernv.c
>
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 142a08a..fbfd9c1 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -746,7 +746,7 @@ static void __init opal_irq_init(struct device_node *dn)
>
>   static int __init opal_init(void)
>   {
> -	struct device_node *np, *consoles;
> +	struct device_node *np, *consoles, *led;
>   	int rc;
>
>   	opal_node = of_find_node_by_path("/ibm,opal");
> @@ -772,6 +772,13 @@ static int __init opal_init(void)
>   	/* Create i2c platform devices */
>   	opal_i2c_create_devs();
>
> +	/* Create led platform devices */
> +	led = of_find_node_by_path("/ibm,opal/led");
> +	if (led) {
> +		of_platform_device_create(led, "opal_led", NULL);
> +		of_node_put(led);
> +	}
> +
>   	/* Find all OPAL interrupts and request them */
>   	opal_irq_init(opal_node);
>
> @@ -904,3 +911,6 @@ EXPORT_SYMBOL_GPL(opal_rtc_write);
>   EXPORT_SYMBOL_GPL(opal_tpo_read);
>   EXPORT_SYMBOL_GPL(opal_tpo_write);
>   EXPORT_SYMBOL_GPL(opal_i2c_request);
> +/* Export these symbols for PowerNV LED class driver */
> +EXPORT_SYMBOL_GPL(opal_leds_get_ind);
> +EXPORT_SYMBOL_GPL(opal_leds_set_ind);

Please split the above part to the separate patch and put it in the
series before this one.

> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 25b320d..a93223c 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -508,6 +508,15 @@ config LEDS_BLINKM
>   	  This option enables support for the BlinkM RGB LED connected
>   	  through I2C. Say Y to enable support for the BlinkM LED.
>
> +config LEDS_POWERNV
> +	tristate "LED support for PowerNV Platform"
> +	depends on LEDS_CLASS
> +	depends on PPC_POWERNV

OF dependency is missing here.

> +	help
> +	  This option enables support for the system LEDs present on
> +	  PowerNV platforms. Say 'y' to enable this support in kernel.
> +	  Say 'm' enable this support as module.

Please change the last line to:

To compile this driver as a module, choose M here: the module will
be called leds-powernv.


> +
>   config LEDS_SYSCON
>   	bool "LED support for LEDs on system controllers"
>   	depends on LEDS_CLASS=y
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index cbba921..604ffc9 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -58,6 +58,7 @@ obj-$(CONFIG_LEDS_BLINKM)		+= leds-blinkm.o
>   obj-$(CONFIG_LEDS_SYSCON)		+= leds-syscon.o
>   obj-$(CONFIG_LEDS_VERSATILE)		+= leds-versatile.o
>   obj-$(CONFIG_LEDS_MENF21BMC)		+= leds-menf21bmc.o
> +obj-$(CONFIG_LEDS_POWERNV)		+= leds-powernv.o
>
>   # LED SPI Drivers
>   obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
> diff --git a/drivers/leds/leds-powernv.c b/drivers/leds/leds-powernv.c
> new file mode 100644
> index 0000000..0c9f958
> --- /dev/null
> +++ b/drivers/leds/leds-powernv.c
> @@ -0,0 +1,620 @@
> +/*
> + * PowerNV LED Driver
> + *
> + * Copyright IBM Corp. 2015
> + *
> + * Author: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> + * Author: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#define PREFIX		"POWERNV_LED"
> +#define pr_fmt(fmt)	PREFIX ": " fmt

Wouldn't you mind using dev_* prefixed logging?
Unless you have a good reason not to do it.

> +
> +#include <linux/platform_device.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/list.h>

Please keep alphabetical order.

> +
> +#include <asm/opal.h>
> +
> +#define LED_STR_ATTENTION	":ATTENTION"
> +#define LED_STR_IDENT		":IDENTIFY"
> +#define LED_STR_FAULT		":FAULT"

Namespacing prefix is required here. LED is reserved for
LED subsystem global macros. How about POWERNV_LED_* ?

> +
> +/*
> + * LED operation state
> + *
> + * led_classdev_unregister resets the brightness values. However
> + * we want to retain the LED state across boot.

What boot are you thinking of here?

> Hence disable
> + * LED operation before calling led_classdev_unregister.
> + */

This comment is unclear for me, as this is static initialization,
unrelated to to any function call.

> +static bool led_disabled = false;

Static variables are initialized to 0 by default.

> +
> +/*
> + * LED type map
> + *
> + * Converts LED event type into it's description.
> + */
> +static const char *led_type_map[OPAL_SLOT_LED_TYPE_MAX] = {
> +	"Attention", "Identify", "Fault"
> +};
> +
> +/*
> + * LED set routines have been implemented as work queue tasks scheduled
> + * on the global work queue. Individual task calls OPAL interface to set
> + * the LED state which might sleep for some time. A lot of work queue
> + * tasks attempting to set the LED states can prevent each other from
> + * completing their task. So there is a need to restrict the total number
> + * of work queue tasks at any point in time related to LED.
> + */
> +#define MAX_LED_REQ_COUNT	100
> +static int led_req_count;
> +
> +/*
> + * LED classdev
> + *
> + * Each LED classdev structure registered on the platform will be put into
> + * a list which will be eventually used for de-registration purpose.
> + */
> +struct powernv_led {
> +	struct led_classdev cdev;
> +	struct list_head    link;
> +};
> +static LIST_HEAD(powernv_led_list);
> +static DEFINE_SPINLOCK(powernv_led_spinlock);
> +
> +/*
> + * LED set state command
> + *
> + * Each set LED state request will be saved and put into a list to be
> + * processed later by a work queue task.
> + */
> +struct powernv_led_cmd {
> +	struct led_classdev *led_cdev; /* Points to classdev structure */
> +	enum led_brightness value;     /* Brightness value */
> +	u64                 led_type;  /* Identify or Fault */
> +	struct list_head    link;
> +};
> +static LIST_HEAD(powernv_led_cmd_list);
> +static DEFINE_SPINLOCK(powernv_led_cmd_spinlock);
> +
> +/*
> + * LED set state task
> + *
> + * Each set LED state request added into the request list for post
> + * processing will be followed by one of this structure. The work
> + * struct here will be scheduled on the global work queue to process
> + * one of the requests from the request list. Though the order of
> + * execution is not guaraneteed.
> + */
> +struct powernv_led_work {
> +	struct work_struct work;      /* Individual task */
> +	bool               deletion;  /* Need deletion */
> +	struct list_head   link;
> +};
> +static LIST_HEAD(powernv_led_work_list);
> +static DEFINE_SPINLOCK(powernv_led_work_spinlock);
> +
> +/*
> + * powernv_led_compact_work_list
> + *
> + * This function goes through the entire list of scheduled powernv_led_work
> + * nodes and removes the nodes which have already processed one set LED
> + * state request from request list and has been marked for deletion. This is
> + * essential for cleaning the list before adding new elements into it. This
> + * also tracks the total number of pending tasks. Once it reaches the
> + * threshold the function will throttle till all the scheduled tasks completes
> + * execution during which the user space thread will block and will be
> + * prevented from queuing up more LED state change requests.
> + */

Did you test the driver with led-triggers?

> +static void powernv_led_compact_work_list(void)
> +{
> +	struct powernv_led_work *pwork, *pwork_ne;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&powernv_led_work_spinlock, flags);
> +	led_req_count = 0;
> +	list_for_each_entry_safe(pwork, pwork_ne,
> +				 &powernv_led_work_list, link) {
> +		if (pwork->deletion) {
> +			list_del(&pwork->link);
> +			kfree(pwork);
> +			continue;
> +		}
> +		led_req_count++;
> +	}
> +	spin_unlock_irqrestore(&powernv_led_work_spinlock, flags);
> +
> +	/* Throttle if the threshold reached */
> +	if (led_req_count == MAX_LED_REQ_COUNT) {
> +		list_for_each_entry(pwork, &powernv_led_work_list, link)
> +			flush_work(&pwork->work);
> +	}
> +}
> +
> +/*
> + * powernv_led_set
> + *
> + * This commits the state change of the requested LED through an OPAL call.
> + * This function is called from work queue task context when ever it gets
> + * scheduled. This function can sleep at opal_async_wait_response call.
> + */
> +static void powernv_led_set(struct led_classdev *led_cdev,
> +			    enum led_brightness value, u64 led_type)
> +{
> +	char *loc_code;
> +	int rc, token;
> +	u64 led_mask, max_led_type, led_value = 0;
> +	struct opal_msg msg;
> +
> +	/* Location code of the LED */
> +	loc_code = kasprintf(GFP_KERNEL, "%s", led_cdev->name);
> +	if (!loc_code) {
> +		pr_err(PREFIX "Memory allocation failed at %s\n", __func__);
> +		return;
> +	}
> +
> +	switch (led_type) {
> +	case OPAL_SLOT_LED_TYPE_ATTN:
> +		loc_code[strlen(loc_code) - strlen(LED_STR_ATTENTION)] = '\0';
> +		break;
> +	case OPAL_SLOT_LED_TYPE_ID:
> +		loc_code[strlen(loc_code) - strlen(LED_STR_IDENT)] = '\0';
> +		break;
> +	case OPAL_SLOT_LED_TYPE_FAULT:
> +		loc_code[strlen(loc_code) - strlen(LED_STR_FAULT)] = '\0';
> +		break;
> +	default:	/* Unknown LED type */
> +		goto out_loc;
> +	}

Above sequence is repeated in the function below - it could be wrapped
with a new function.

> +	/* Prepare for the OPAL call */
> +	max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
> +	led_mask = OPAL_SLOT_LED_STATE_ON << led_type;
> +	if (value)
> +		led_value = OPAL_SLOT_LED_STATE_ON << led_type;
> +
> +	/* OPAL async call */
> +	token = opal_async_get_token_interruptible();
> +	if (token < 0) {
> +		if (token != -ERESTARTSYS)
> +			pr_err("%s: Couldn't get the token, returning\n",
> +			       __func__);
> +		goto out_loc;
> +	}
> +
> +	rc = opal_leds_set_ind(token, loc_code,
> +			       led_mask, led_value, &max_led_type);
> +	if (rc != OPAL_ASYNC_COMPLETION) {
> +		pr_err("OPAL call opal_leds_set_ind failed for %s with %d\n",
> +		       loc_code, rc);
> +		goto out_token;
> +	}
> +
> +	rc = opal_async_wait_response(token, &msg);
> +	if (rc) {
> +		pr_err("%s: Failed to wait for the async response, %d\n",
> +			__func__, rc);
> +		goto out_token;
> +	}
> +
> +	rc = be64_to_cpu(msg.params[1]);
> +	if (rc != OPAL_SUCCESS)
> +		pr_err("Async call returned with failed status: %d\n", rc);
> +
> +out_token:
> +	opal_async_release_token(token);
> +
> +out_loc:
> +	kfree(loc_code);
> +}
> +
> +/*
> + * powernv_led_get
> + *
> + * This function fetches the LED state for a given LED type for
> + * mentioned LED classdev structure.
> + */
> +static enum led_brightness powernv_led_get(struct led_classdev *led_cdev,
> +					   u64 led_type)
> +{
> +	char *loc_code;
> +	int rc;
> +	u64 led_mask, led_value, max_led_type;
> +
> +	/* LED location code */
> +	loc_code = kasprintf(GFP_KERNEL, "%s", led_cdev->name);
> +	if (!loc_code) {
> +		pr_err("Memory allocation failed at: %s\n", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	switch (led_type) {
> +	case OPAL_SLOT_LED_TYPE_ATTN:
> +		loc_code[strlen(loc_code) - strlen(LED_STR_ATTENTION)] = '\0';
> +		break;
> +	case OPAL_SLOT_LED_TYPE_ID:
> +		loc_code[strlen(loc_code) - strlen(LED_STR_IDENT)] = '\0';
> +		break;
> +	case OPAL_SLOT_LED_TYPE_FAULT:
> +		loc_code[strlen(loc_code) - strlen(LED_STR_FAULT)] = '\0';
> +		break;
> +	default:	/* Unsupported LED type */
> +		goto led_fail;
> +	}
> +
> +	/* Fetch all LED status */
> +	led_mask = cpu_to_be64(0);
> +	led_value = cpu_to_be64(0);
> +	max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
> +
> +	rc = opal_leds_get_ind(loc_code, &led_mask, &led_value, &max_led_type);
> +	if (rc != OPAL_SUCCESS && rc != OPAL_PARTIAL) {
> +		pr_err("OPAL call opal_leds_get_ind failed with %d\n", rc);
> +		goto led_fail;
> +	}
> +
> +	led_mask = be64_to_cpu(led_mask);
> +	led_value = be64_to_cpu(led_value);
> +
> +	/* LED status available */
> +	if (!((led_mask >> led_type) & OPAL_SLOT_LED_STATE_ON)) {
> +		pr_err("%s LED status not available for %s\n",
> +		       led_type_map[led_type], loc_code);
> +		goto led_fail;
> +	}
> +
> +	/* LED status value */
> +	if ((led_value >> led_type) & OPAL_SLOT_LED_STATE_ON) {
> +		kfree(loc_code);
> +		return LED_FULL;
> +	}
> +
> +led_fail:
> +	kfree(loc_code);
> +	return LED_OFF;
> +}
> +
> +/*
> + * powernv_led_work_func
> + *
> + * This the function which will be executed by any LED work task on the
> + * global work queue. This function de-queues one of the request node
> + * from the request list, processes it and then deletes the request node.
> + * This also accesses it's own work list node and sets the deletion flag
> + * in there making itself a candidate for removal the next time the
> + * compact function gets called.
> + */
> +static void powernv_led_work_func(struct work_struct *work)
> +{
> +	struct powernv_led_work *pwork;
> +	struct powernv_led_cmd *req;
> +	unsigned long flags;
> +
> +	/* De-queue one request, process it and then delete */
> +	spin_lock_irqsave(&powernv_led_cmd_spinlock, flags);
> +	if (list_empty(&powernv_led_cmd_list)) {
> +		pr_err("Request list empty, but work queue task queued\n");
> +		spin_unlock_irqrestore(&powernv_led_cmd_spinlock, flags);
> +		return;
> +	}
> +
> +	req = list_first_entry(&powernv_led_cmd_list,
> +			       struct powernv_led_cmd, link);
> +	list_del(&req->link);
> +	spin_unlock_irqrestore(&powernv_led_cmd_spinlock, flags);
> +
> +	powernv_led_set(req->led_cdev, req->value, req->led_type);
> +	kfree(req);
> +
> +	/* Mark the work queue task for deletion */
> +	spin_lock_irqsave(&powernv_led_work_spinlock, flags);
> +	pwork = container_of(work, struct powernv_led_work, work);
> +	pwork->deletion = true;
> +	spin_unlock_irqrestore(&powernv_led_work_spinlock, flags);
> +}
> +
> +/*
> + * powernv_led_set_queue
> + *
> + * LED classdev 'brightness_set' function for LEDs
> + */
> +static void powernv_led_set_queue(struct led_classdev *led_cdev,
> +				  enum led_brightness value, u64 led_type)
> +{
> +	struct powernv_led_work *pwork;
> +	struct powernv_led_cmd *attn;
> +	unsigned long flags;
> +
> +	if (led_disabled)
> +		return;
> +
> +	/* Allocate the request */
> +	attn = kzalloc(sizeof(struct powernv_led_cmd), GFP_KERNEL);
> +	if (!attn) {
> +		pr_err("Memory allocation failed at: %s\n", __func__);
> +		return;
> +	}
> +
> +	/* Allocate the work */
> +	pwork = kzalloc(sizeof(struct powernv_led_work), GFP_KERNEL);
> +	if (!pwork) {
> +		pr_err("Memory allocation failed at: %s\n", __func__);
> +		kfree(attn);
> +		return;
> +	}
> +
> +	/* Prepare the request */
> +	attn->led_cdev = led_cdev;
> +	attn->value = value;
> +	attn->led_type = led_type;
> +
> +	/* Queue the request */
> +	spin_lock_irqsave(&powernv_led_cmd_spinlock, flags);
> +	list_add_tail(&attn->link, &powernv_led_cmd_list);
> +	spin_unlock_irqrestore(&powernv_led_cmd_spinlock, flags);
> +
> +	/* Compact the work list */
> +	powernv_led_compact_work_list();
> +
> +	/* Add the new task into the work list */
> +	spin_lock_irqsave(&powernv_led_work_spinlock, flags);
> +	list_add_tail(&pwork->link, &powernv_led_work_list);
> +	spin_unlock_irqrestore(&powernv_led_work_spinlock, flags);
> +
> +	/* Schedule the new task */
> +	INIT_WORK(&pwork->work, powernv_led_work_func);
> +	schedule_work(&pwork->work);
> +}
> +/*
> + * powernv_led_set_attn
> + *
> + * LED classdev 'brightness_set' function for attention LED.
> + */
> +static void powernv_led_set_attn(struct led_classdev *led_cdev,
> +				  enum led_brightness value)
> +{
> +	return powernv_led_set_queue(led_cdev, value,
> +				     OPAL_SLOT_LED_TYPE_ATTN);
> +}
> +
> +/*
> + * powernv_led_get_attn
> + *
> + * LED classdev 'brightness_get' function for attention LED.
> + */
> +static enum led_brightness powernv_led_get_attn(struct led_classdev *led_cdev)
> +{
> +	return powernv_led_get(led_cdev, OPAL_SLOT_LED_TYPE_ATTN);
> +}
> +
> +/*
> + * powernv_led_set_ident
> + *
> + * LED classdev 'brightness_set' function for identify LED types.
> + */
> +static void powernv_led_set_ident(struct led_classdev *led_cdev,
> +				  enum led_brightness value)
> +{
> +	return powernv_led_set_queue(led_cdev, value, OPAL_SLOT_LED_TYPE_ID);
> +}
> +
> +/*
> + * powernv_led_get_ident
> + *
> + * LED classdev 'brightness_get' function for identify LED types.
> + */
> +static enum led_brightness powernv_led_get_ident(struct led_classdev *led_cdev)
> +{
> +	return powernv_led_get(led_cdev, OPAL_SLOT_LED_TYPE_ID);
> +}
> +
> +/*
> + * powernv_led_set_fault
> + *
> + * LED classdev 'brightness_set' function for fault LED types.
> + */
> +static void powernv_led_set_fault(struct led_classdev *led_cdev,
> +				  enum led_brightness value)
> +{
> +	return powernv_led_set_queue(led_cdev, value,
> +				     OPAL_SLOT_LED_TYPE_FAULT);
> +}
> +
> +/*
> + * powernv_led_get_fault
> + *
> + * LED classdev 'brightness_get' function for fault LED types.
> + */
> +static enum led_brightness powernv_led_get_fault(struct led_classdev *led_cdev)
> +{
> +	return powernv_led_get(led_cdev, OPAL_SLOT_LED_TYPE_FAULT);
> +}
> +
> +/*
> + * has_led_type
> + *
> + * This function verifies whether the child LED device node supports certain
> + * type of LED or not. This will be used to register LEDclassdev structures
> + * for that particual type of LED for a given device tree node.
> + */
> +static bool has_led_type(struct device_node *cled, const char *led_type)
> +{
> +	bool result = false;
> +
> +	if (of_property_match_string(cled, "led-types", led_type) >= 0)
> +		result = true;
> +
> +	return result;
> +}
> +
> +/*
> + * power_led_classdev
> + *
> + * This function registers classdev structure for any given type of LED on
> + * a given child LED device node.
> + */
> +static int power_led_classdev(struct platform_device *pdev,
> +			      struct device_node *cled, u64 led_type)
> +{
> +	int rc;
> +	unsigned long flags;
> +	struct powernv_led *cpled;
> +
> +	cpled = kzalloc(sizeof(struct powernv_led), GFP_KERNEL);
> +	if (!cpled) {
> +		pr_err("Memory allocation failed at %s\n", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	/* Create the name for classdev */
> +	switch (led_type) {
> +	case OPAL_SLOT_LED_TYPE_ATTN:
> +		cpled->cdev.name = kasprintf(GFP_KERNEL, "%s%s",
> +					     cled->name, LED_STR_ATTENTION);

We have a 'label' DT property for naming LED Flash class devices.
Please refer to Documentation/devicetree/bindings/leds/common.txt.

> +		cpled->cdev.brightness_set = powernv_led_set_attn;
> +		cpled->cdev.brightness_get = powernv_led_get_attn;
> +		break;
> +	case OPAL_SLOT_LED_TYPE_ID:
> +		cpled->cdev.name = kasprintf(GFP_KERNEL, "%s%s",
> +					     cled->name, LED_STR_IDENT);
> +		cpled->cdev.brightness_set = powernv_led_set_ident;
> +		cpled->cdev.brightness_get = powernv_led_get_ident;
> +		break;
> +	case OPAL_SLOT_LED_TYPE_FAULT:
> +		cpled->cdev.name = kasprintf(GFP_KERNEL, "%s%s",
> +						cled->name, LED_STR_FAULT);
> +		cpled->cdev.brightness_set = powernv_led_set_fault;
> +		cpled->cdev.brightness_get = powernv_led_get_fault;
> +		break;
> +	default: /* Unsupported LED type */
> +		return -EINVAL;
> +	}
> +
> +	if (!cpled->cdev.name) {
> +		pr_err("Memory allocation failed for classdev name\n");
> +		return -ENOMEM;
> +	}
> +
> +	cpled->cdev.brightness = LED_OFF;
> +	cpled->cdev.max_brightness = LED_FULL;
> +	cpled->cdev.flags = LED_CORE_SUSPENDRESUME;
> +
> +	/* Register the classdev */
> +	rc = led_classdev_register(&pdev->dev, &cpled->cdev);
> +	if (rc) {
> +		pr_err("Classdev registration failed for %s\n",
> +		       cpled->cdev.name);
> +	} else {
> +		spin_lock_irqsave(&powernv_led_spinlock, flags);
> +		list_add_tail(&cpled->link, &powernv_led_list);
> +		spin_unlock_irqrestore(&powernv_led_spinlock, flags);
> +		pr_debug("Classdev registration successful for %s\n",
> +			 cpled->cdev.name);
> +	}
> +	return rc;
> +}
> +
> +/* Platform driver probe */
> +static int powernv_led_probe(struct platform_device *pdev)
> +{
> +	struct device_node *led, *cled;
> +	int rc = 0;
> +
> +	led = of_find_node_by_path("/ibm,opal/led");
> +	if (!led) {
> +		pr_err("LED parent device node not found\n");
> +		return -EINVAL;
> +	}
> +
> +	for_each_child_of_node(led, cled) {
> +		if (has_led_type(cled, LED_TYPE_ATTENTION))
> +			rc = power_led_classdev(pdev, cled,
> +						OPAL_SLOT_LED_TYPE_ATTN);
> +
> +		if (has_led_type(cled, LED_TYPE_IDENTIFY))
> +			rc = power_led_classdev(pdev, cled,
> +						OPAL_SLOT_LED_TYPE_ID);
> +
> +		if (has_led_type(cled, LED_TYPE_FAULT))
> +			rc = power_led_classdev(pdev, cled,
> +						OPAL_SLOT_LED_TYPE_FAULT);
> +	}
> +	return rc;
> +}
> +
> +/* Platform driver remove */
> +static int powernv_led_remove(struct platform_device *pdev)
> +{
> +	struct powernv_led *pled;
> +	struct powernv_led_work *pwork;
> +	unsigned long flags;
> +
> +	/* Disable LED operation */
> +	led_disabled = true;
> +
> +	pr_info("Unregister all classdev structures\n");
> +	list_for_each_entry(pled, &powernv_led_list, link)
> +		led_classdev_unregister(&pled->cdev);
> +
> +	pr_info("Wait for all work tasks to finish\n");
> +	list_for_each_entry(pwork, &powernv_led_work_list, link)
> +		flush_work(&pwork->work);
> +
> +	/* Free nodes from the work list */
> +	powernv_led_compact_work_list();
> +
> +	/* Free nodes from the classdev list */
> +	spin_lock_irqsave(&powernv_led_spinlock, flags);
> +	while (!list_empty(&powernv_led_list)) {
> +		pled = list_first_entry(&powernv_led_list,
> +					struct powernv_led, link);
> +		list_del(&pled->link);
> +		kfree(pled);
> +	}
> +	spin_unlock_irqrestore(&powernv_led_spinlock, flags);
> +
> +	/* Check for memory leaks */
> +	if (!list_empty(&powernv_led_work_list))
> +		pr_warn("Work list not empty, memory leak\n");
> +
> +	if (!list_empty(&powernv_led_cmd_list))
> +		pr_warn("Request list not empty, memory leak\n");
> +
> +	if (!list_empty(&powernv_led_list))
> +		pr_warn("Classdev list not empty, memory leak\n");
> +
> +	return 0;
> +}
> +
> +/* Platform driver property match */
> +static const struct of_device_id powernv_led_match[] = {
> +	{
> +		.compatible	= "ibm,opal-v3-led",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, powernv_led_match);
> +
> +static struct platform_driver powernv_led_driver = {
> +	.probe	= powernv_led_probe,
> +	.remove = powernv_led_remove,
> +	.driver = {
> +		.name = "powernv-led-driver",
> +		.owner = THIS_MODULE,
> +		.of_match_table = powernv_led_match,

Is somewhere DT documentation available for these leds?

> +	},
> +};
> +
> +module_platform_driver(powernv_led_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("PowerNV LED driver");
> +MODULE_AUTHOR("Anshuman Khandual <khandual@linux.vnet.ibm.com>");
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-leds" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards,
Jacek Anaszewski
