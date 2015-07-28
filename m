Return-Path: <jacek.anaszewski@gmail.com>
Received: from mail-wi0-x235.google.com (mail-wi0-x235.google.com
 [IPv6:2a00:1450:400c:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 81EA91A05A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 16:40:18 +1000 (AEST)
Received: by wibxm9 with SMTP id xm9so142049819wib.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 23:40:14 -0700 (PDT)
Message-ID: <55B72369.5040102@gmail.com>
Date: Tue, 28 Jul 2015 08:38:33 +0200
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
MIME-Version: 1.0
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 linux-leds@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 j.anaszewski@samsung.com, mpe@ellerman.id.au
CC: rpurdie@rpsys.net, cooloney@gmail.com, khandual@linux.vnet.ibm.com,
 j.anaszewski81@gmail.com, arnd@arndb.de, stewart@linux.vnet.ibm.com,
 benh@kernel.crashing.org
Subject: Re: [PATCH v8 3/3] leds/powernv: Add driver for PowerNV platform
References: <1437801670-23705-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <1437801670-23705-4-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <55B5540B.1000301@gmail.com> <55B5A853.3080909@linux.vnet.ibm.com>
In-Reply-To: <55B5A853.3080909@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vasant,

I've found one more formatting issue below.

On 27.07.2015 05:41, Vasant Hegde wrote:
[...]
>>> +
>>> +/*
>>> + * This function registers classdev structure for any given type of LED on
>>> + * a given child LED device node.
>>> + */
>>> +static int powernv_led_create(struct device *dev,
>>> +                  struct powernv_led_data *powernv_led,
>>> +                  const char *led_type_desc)
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
>>> +    /* Create the name for classdev */
>>> +    powernv_led->cdev.name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s",
>>> +                        powernv_led->loc_code,
>>> +                        led_type_desc);
>>> +    if (!powernv_led->cdev.name) {
>>> +        dev_err(dev,
>>> +            "%s: Memory allocation failed for classdev name\n",
>>> +            __func__);
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>> +    powernv_led->cdev.brightness_set = powernv_brightness_set;
>>> +    powernv_led->cdev.brightness_get = powernv_brightness_get;
>>> +    powernv_led->cdev.brightness = LED_OFF;
>>> +    powernv_led->cdev.max_brightness = LED_FULL;
>>> +
>>> +    /* Register the classdev */
>>> +    rc = devm_led_classdev_register(dev, &powernv_led->cdev);
>>> +    if (rc) {
>>> +        dev_err(dev, "%s: Classdev registration failed for %s\n",
>>> +            __func__, powernv_led->cdev.name);
>>> +    }

Braces are not needed here,

>>> +
>>> +    return rc;
>>> +}

-- 
Best Regards,
Jacek Anaszewski
