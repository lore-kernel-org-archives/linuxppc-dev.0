Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x4j5v6PV2zDr9R
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Jul 2017 06:01:07 +1000 (AEST)
Message-ID: <1499543997.29707.6.camel@kernel.crashing.org>
Subject: Re: [PATCH 5/5] mtd: powernv_flash: Use
 opal_async_wait_response_interruptible()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mtd@lists.infradead.org
Cc: stewart@linux.vnet.ibm.com, dwmw2@infradead.org
Date: Sat, 08 Jul 2017 14:59:57 -0500
In-Reply-To: <20170629065413.19845-6-cyrilbur@gmail.com>
References: <20170629065413.19845-1-cyrilbur@gmail.com>
 <20170629065413.19845-6-cyrilbur@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-29 at 16:54 +1000, Cyril Bur wrote:
> The OPAL calls performed in this driver shouldn't be using
> opal_async_wait_response() as this performs a wait_event() which, on
> long running OPAL calls could result in hung task warnings. wait_event()
> also prevents timely signal delivery which is also undesirable.
> 
> This patch also attempts to quieten down the use of dev_err() when
> errors haven't actually occurred and also to return better information up
> the stack rather than always -EIO.

So what happens when you get a signal then ? The async op is still in
progress, will the callers properly handle that ?

For example, for a read, OPAL will potentially still be writing to
the destination buffer. Are the callers expecting this ?

That sounds very broken to me ....

You should simply limit the amount of flash that can be affected by
a single call to avoid long hung tasks.

> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
>  drivers/mtd/devices/powernv_flash.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
> index 7b41af06f4fe..a7c5ae2b2898 100644
> --- a/drivers/mtd/devices/powernv_flash.c
> +++ b/drivers/mtd/devices/powernv_flash.c
> @@ -88,19 +88,23 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
>  	}
>  
>  	if (rc != OPAL_ASYNC_COMPLETION) {
> -		dev_err(dev, "opal_flash_async_op(op=%d) failed (rc %d)\n",
> -				op, rc);
> +		if (rc != OPAL_BUSY)
> +			dev_err(dev, "opal_flash_async_op(op=%d) failed (rc %d)\n",
> +					op, rc);
>  		opal_async_release_token(token);
> -		rc = -EIO;
> +		rc = opal_error_code(rc);
>  		goto out;
>  	}
>  
> -	rc = opal_async_wait_response(token, &msg);
> +	rc = opal_async_wait_response_interruptible(token, &msg);
>  	opal_async_release_token(token);
>  	mutex_unlock(&info->lock);
>  	if (rc) {
> -		dev_err(dev, "opal async wait failed (rc %d)\n", rc);
> -		return -EIO;
> +		if (rc == -ERESTARTSYS)
> +			rc = -EINTR;
> +		else
> +			dev_err(dev, "opal async wait failed (rc %d)\n", rc);
> +		return rc;
>  	}
>  
>  	rc = opal_get_async_rc(msg);
> @@ -109,7 +113,7 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
>  		if (retlen)
>  			*retlen = len;
>  	} else {
> -		rc = -EIO;
> +		rc = opal_error_code(rc);
>  	}
>  
>  	return rc;
