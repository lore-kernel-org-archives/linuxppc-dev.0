Return-Path: <jacek.anaszewski@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xh3CF4JTnzDqD0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 06:24:25 +1000 (AEST)
Received: by mail-wm0-x242.google.com with SMTP id e67so1716464wmd.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 13:24:25 -0700 (PDT)
Subject: Re: [PATCH] leds-PowerNV: Delete an error message for a failed memory
 allocation in powernv_led_create()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linux-leds@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>
References: <019499e0-68d8-b89d-f5d6-6aefd9cbaf04@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <d45c4034-1bb9-e812-8853-e56cf6f128de@gmail.com>
Date: Mon, 28 Aug 2017 22:23:38 +0200
MIME-Version: 1.0
In-Reply-To: <019499e0-68d8-b89d-f5d6-6aefd9cbaf04@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Markus,

Thanks for the patch.

On 08/27/2017 10:10 PM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 27 Aug 2017 22:00:22 +0200
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/leds/leds-powernv.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/leds/leds-powernv.c b/drivers/leds/leds-powernv.c
> index b2a98c7b521b..b1adbd70ce2e 100644
> --- a/drivers/leds/leds-powernv.c
> +++ b/drivers/leds/leds-powernv.c
> @@ -224,12 +224,8 @@ static int powernv_led_create(struct device *dev,
>  	powernv_led->cdev.name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s",
>  						powernv_led->loc_code,
>  						led_type_desc);
> -	if (!powernv_led->cdev.name) {
> -		dev_err(dev,
> -			"%s: Memory allocation failed for classdev name\n",
> -			__func__);
> +	if (!powernv_led->cdev.name)
>  		return -ENOMEM;
> -	}
>  
>  	powernv_led->cdev.brightness_set_blocking = powernv_brightness_set;
>  	powernv_led->cdev.brightness_get = powernv_brightness_get;
> 

Applied.

-- 
Best regards,
Jacek Anaszewski
