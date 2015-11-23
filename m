Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 293291A02A1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 20:03:36 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 19:03:35 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 134E02CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 20:03:34 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAN93PED56885266
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 20:03:34 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAN931l9002015
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 20:03:01 +1100
Message-ID: <5652D633.4060203@linux.vnet.ibm.com>
Date: Mon, 23 Nov 2015 14:32:43 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.orv
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] leds: powernv: Implement brightness_set_blocking op
References: <1448034066-22978-1-git-send-email-j.anaszewski@samsung.com>
In-Reply-To: <1448034066-22978-1-git-send-email-j.anaszewski@samsung.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/20/2015 09:11 PM, Jacek Anaszewski wrote:
> Since brightness setting can sleep for this driver, implement
> brightness_set_blocking op, instead of brightness_set.
> It makes this driver compatible with LED triggers.

Hello  Jacek,

Thanks for the patch. Looks good.. I will test this patch later this week and
update you the results.

I assume this patch is on top of LED git tree.

-Vasant

> 
> Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
> Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> ---
>  drivers/leds/leds-powernv.c |   16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/leds/leds-powernv.c b/drivers/leds/leds-powernv.c
> index 1e75e1f..dd76f34 100644
> --- a/drivers/leds/leds-powernv.c
> +++ b/drivers/leds/leds-powernv.c
> @@ -77,7 +77,7 @@ static int powernv_get_led_type(const char *led_type_desc)
>   * This function is called from work queue task context when ever it gets
>   * scheduled. This function can sleep at opal_async_wait_response call.
>   */
> -static void powernv_led_set(struct powernv_led_data *powernv_led,
> +static int powernv_led_set(struct powernv_led_data *powernv_led,
>  			    enum led_brightness value)
>  {
>  	int rc, token;
> @@ -99,7 +99,7 @@ static void powernv_led_set(struct powernv_led_data *powernv_led,
>  		if (token != -ERESTARTSYS)
>  			dev_err(dev, "%s: Couldn't get OPAL async token\n",
>  				__func__);
> -		return;
> +		return token;
>  	}
>  
>  	rc = opal_leds_set_ind(token, powernv_led->loc_code,
> @@ -125,6 +125,7 @@ static void powernv_led_set(struct powernv_led_data *powernv_led,
>  
>  out_token:
>  	opal_async_release_token(token);
> +	return rc;
>  }
>  
>  /*
> @@ -173,20 +174,23 @@ static enum led_brightness powernv_led_get(struct powernv_led_data *powernv_led)
>   * LED classdev 'brightness_get' function. This schedules work
>   * to update LED state.
>   */
> -static void powernv_brightness_set(struct led_classdev *led_cdev,
> +static int powernv_brightness_set(struct led_classdev *led_cdev,
>  				   enum led_brightness value)
>  {
>  	struct powernv_led_data *powernv_led =
>  		container_of(led_cdev, struct powernv_led_data, cdev);
>  	struct powernv_led_common *powernv_led_common = powernv_led->common;
> +	int rc;
>  
>  	/* Do not modify LED in unload path */
>  	if (powernv_led_common->led_disabled)
> -		return;
> +		return 0;
>  
>  	mutex_lock(&powernv_led_common->lock);
> -	powernv_led_set(powernv_led, value);
> +	rc = powernv_led_set(powernv_led, value);
>  	mutex_unlock(&powernv_led_common->lock);
> +
> +	return rc;
>  }
>  
>  /* LED classdev 'brightness_get' function */
> @@ -227,7 +231,7 @@ static int powernv_led_create(struct device *dev,
>  		return -ENOMEM;
>  	}
>  
> -	powernv_led->cdev.brightness_set = powernv_brightness_set;
> +	powernv_led->cdev.brightness_set_blocking = powernv_brightness_set;
>  	powernv_led->cdev.brightness_get = powernv_brightness_get;
>  	powernv_led->cdev.brightness = LED_OFF;
>  	powernv_led->cdev.max_brightness = LED_FULL;
> 
