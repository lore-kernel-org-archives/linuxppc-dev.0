Return-Path: <boris.brezillon@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3yQSqR1fkHzDrcZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 19:50:27 +1100 (AEDT)
Date: Mon, 30 Oct 2017 09:50:14 +0100
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 stewart@linux.vnet.ibm.com, computersforpeace@gmail.com,
 dwmw2@infradead.org, sjitindarsingh@gmail.com
Subject: Re: [PATCH v4 02/10] mtd: powernv_flash: Don't treat OPAL_SUCCESS
 as an error
Message-ID: <20171030095014.7a77d827@bbrezillon>
In-Reply-To: <20171010033302.20854-3-cyrilbur@gmail.com>
References: <20171010033302.20854-1-cyrilbur@gmail.com>
 <20171010033302.20854-3-cyrilbur@gmail.com>
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

On Tue, 10 Oct 2017 14:32:54 +1100
Cyril Bur <cyrilbur@gmail.com> wrote:

> While this driver expects to interact asynchronously, OPAL is well
> within its rights to return OPAL_SUCCESS to indicate that the operation
> completed without the need for a callback. We shouldn't treat
> OPAL_SUCCESS as an error rather we should wrap up and return promptly to
> the caller.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
> I'll note here that currently no OPAL exists that will return
> OPAL_SUCCESS so there isn't the possibility of a bug today.
> ---
>  drivers/mtd/devices/powernv_flash.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
> index f9ec38281ff2..ca3ca6adf71e 100644
> --- a/drivers/mtd/devices/powernv_flash.c
> +++ b/drivers/mtd/devices/powernv_flash.c
> @@ -63,7 +63,6 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
>  	if (token < 0) {
>  		if (token != -ERESTARTSYS)
>  			dev_err(dev, "Failed to get an async token\n");
> -
>  		return token;
>  	}
>  
> @@ -83,21 +82,25 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
>  		return -EIO;
>  	}
>  
> +	if (rc == OPAL_SUCCESS)
> +		goto out_success;
> +
>  	if (rc != OPAL_ASYNC_COMPLETION) {
>  		dev_err(dev, "opal_flash_async_op(op=%d) failed (rc %d)\n",
>  				op, rc);
> -		opal_async_release_token(token);
> -		return -EIO;
> +		rc = -EIO;
> +		goto out;
>  	}
>  
>  	rc = opal_async_wait_response(token, &msg);
> -	opal_async_release_token(token);
>  	if (rc) {
>  		dev_err(dev, "opal async wait failed (rc %d)\n", rc);
> -		return -EIO;
> +		rc = -EIO;
> +		goto out;
>  	}
>  
>  	rc = opal_get_async_rc(msg);
> +out_success:
>  	if (rc == OPAL_SUCCESS) {
>  		rc = 0;
>  		if (retlen)
> @@ -106,6 +109,8 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
>  		rc = -EIO;
>  	}
>  
> +out:
> +	opal_async_release_token(token);
>  	return rc;
>  }
>  
