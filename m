Return-Path: <jacek.anaszewski@gmail.com>
Received: from mail-wg0-x244.google.com (mail-wg0-x244.google.com
 [IPv6:2a00:1450:400c:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D7A81A05B9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 16:18:09 +1000 (AEST)
Received: by wgjf7 with SMTP id f7so1067067wgj.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2015 23:18:05 -0700 (PDT)
Message-ID: <55AC9244.5010407@gmail.com>
Date: Mon, 20 Jul 2015 08:16:36 +0200
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
 <55AC193B.9060005@gmail.com>
In-Reply-To: <55AC193B.9060005@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19.07.2015 23:40, Jacek Anaszewski wrote:
[...]
>>>> +/* Platform driver probe */
>>>> +static int powernv_led_probe(struct platform_device *pdev)
>>>> +{
>>>> +    int num_leds;
>>>> +    struct device_node *led_node;
>>>> +    struct powernv_leds_priv *priv;
>>>> +
>>>> +    led_node = of_find_node_by_path("/ibm,opal/leds");
>>>> +    if (!led_node) {
>>>> +        dev_err(&pdev->dev,
>>>> +            "%s: LED parent device node not found\n", __func__);
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    num_leds = powernv_leds_count(led_node);
>>>> +    if (num_leds <= 0) {
>>>> +        dev_err(&pdev->dev,
>>>> +            "%s: No location code found under LED node\n",
>>>> +            __func__);
>>>> +        return -EINVAL;
>>>> +    }
>
> You won't need to count the number of LEDs to register, just allocate
> memory for each LED during parsing with managed resource allocation
> API.

You can refer to drivers/leds/leds-bcm6328.c in order to gain
full picture on how this can look like.
struct powernv_led_data would have to carry the pointer to the
new common struct.

-- 
Best Regards,
Jacek Anaszewski
