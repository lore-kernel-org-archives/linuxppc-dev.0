Return-Path: <boris.brezillon@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3yQTMS024xzDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 20:14:43 +1100 (AEDT)
Date: Mon, 30 Oct 2017 10:14:12 +0100
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 stewart@linux.vnet.ibm.com, dwmw2@infradead.org,
 computersforpeace@gmail.com, sjitindarsingh@gmail.com
Subject: Re: [PATCH v4 10/10] mtd: powernv_flash: Use
 opal_async_wait_response_interruptible()
Message-ID: <20171030101412.300b8c5d@bbrezillon>
In-Reply-To: <20171010033302.20854-11-cyrilbur@gmail.com>
References: <20171010033302.20854-1-cyrilbur@gmail.com>
 <20171010033302.20854-11-cyrilbur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 10 Oct 2017 14:33:02 +1100
Cyril Bur <cyrilbur@gmail.com> wrote:

> The OPAL calls performed in this driver shouldn't be using
> opal_async_wait_response() as this performs a wait_event() which, on
> long running OPAL calls could result in hung task warnings. wait_event()
> prevents timely signal delivery which is also undesirable.
> 
> This patch also attempts to quieten down the use of dev_err() when
> errors haven't actually occurred and also to return better information up
> the stack rather than always -EIO.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Have some minor comments (see below). Once addressed you can add

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  drivers/mtd/devices/powernv_flash.c | 57 +++++++++++++++++++++++--------------
>  1 file changed, 35 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
> index 3343d4f5c4f3..42383dbca5a6 100644
> --- a/drivers/mtd/devices/powernv_flash.c
> +++ b/drivers/mtd/devices/powernv_flash.c
> @@ -1,7 +1,7 @@
>  /*
>   * OPAL PNOR flash MTD abstraction
>   *
> - * Copyright IBM 2015
> + * Copyright IBM 2015-2017

Not a big deal, but this copyright update is not really related to the
change you describe in your commit message. Maybe this should be done
in a separate commit.

>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -89,33 +89,46 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
>  		return -EIO;
>  	}
>  
> -	if (rc == OPAL_SUCCESS)
> -		goto out_success;
> +	if (rc == OPAL_ASYNC_COMPLETION) {
> +		rc = opal_async_wait_response_interruptible(token, &msg);
> +		if (rc) {
> +			/*
> +			 * If we return the mtd core will free the
> +			 * buffer we've just passed to OPAL but OPAL
> +			 * will continue to read or write from that
> +			 * memory.
> +			 * It may be tempting to ultimately return 0
> +			 * if we're doing a read or a write since we
> +			 * are going to end up waiting until OPAL is
> +			 * done. However, because the MTD core sends
> +			 * us the userspace request in chunks, we need
> +			 * to it know we've been interrupted.

			   ^ 'it to' ?

> +			 */
> +			rc = -EINTR;
> +			if (opal_async_wait_response(token, &msg))
> +				dev_err(dev, "opal_async_wait_response() failed\n");
> +			goto out;
> +		}
> +		rc = opal_get_async_rc(msg);
> +	}
>  
> -	if (rc != OPAL_ASYNC_COMPLETION) {
> +	/*
> +	 * OPAL does mutual exclusion on the flash, it will return
> +	 * OPAL_BUSY.
> +	 * During firmware updates by the service processor OPAL may
> +	 * be (temporarily) prevented from accessing the flash, in
> +	 * this case OPAL will also return OPAL_BUSY.
> +	 * Both cases aren't errors exactly but the flash could have
> +	 * changed, userspace should be informed.
> +	 */
> +	if (rc != OPAL_SUCCESS && rc != OPAL_BUSY)
>  		dev_err(dev, "opal_flash_async_op(op=%d) failed (rc %d)\n",
>  				op, rc);
> -		rc = -EIO;
> -		goto out;
> -	}
>  
> -	rc = opal_async_wait_response(token, &msg);
> -	if (rc) {
> -		dev_err(dev, "opal async wait failed (rc %d)\n", rc);
> -		rc = -EIO;
> -		goto out;
> -	}
> -
> -	rc = opal_get_async_rc(msg);
> -out_success:
> -	if (rc == OPAL_SUCCESS) {
> -		rc = 0;
> -		if (retlen)
> +	if (rc == OPAL_SUCCESS && retlen)
>  			*retlen = len;

There's one too many tabs here.

> -	} else {
> -		rc = -EIO;
> -	}
>  
> +	rc = opal_error_code(rc);
>  out:
>  	opal_async_release_token(token);
>  	return rc;
