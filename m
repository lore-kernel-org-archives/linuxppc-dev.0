Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whmPC5LWRzDqLN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 19:20:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, andrew.donnellan@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org, vaibhav@linux.vnet.ibm.com,
 clombard@linux.vnet.ibm.com, philippe.bergheaud@fr.ibm.com
Subject: Re: [PATCH] cxl: Fix error path on bad ioctl
In-Reply-To: <20170602161523.14052-1-fbarrat@linux.vnet.ibm.com>
References: <20170602161523.14052-1-fbarrat@linux.vnet.ibm.com>
Date: Tue, 06 Jun 2017 19:20:11 +1000
Message-ID: <878tl5qxpw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> Fix error path if we can't copy user structure on
> CXL_IOCTL_START_WORK ioctl.

To be clear the error is that returning via the out label will unlock
cxl->status_mutex, which has not been locked.

Please spell it out for me :)

This should be:

  Fixes: 0712dc7e73e5 ("cxl: Fix issues when unmapping contexts")

Am I right?

cheers

> diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
> index 17b433f1ce23..caa44adfa60e 100644
> --- a/drivers/misc/cxl/file.c
> +++ b/drivers/misc/cxl/file.c
> @@ -160,10 +160,8 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
>  	/* Do this outside the status_mutex to avoid a circular dependency with
>  	 * the locking in cxl_mmap_fault() */
>  	if (copy_from_user(&work, uwork,
> -			   sizeof(struct cxl_ioctl_start_work))) {
> -		rc = -EFAULT;
> -		goto out;
> -	}
> +			   sizeof(struct cxl_ioctl_start_work)))
> +		return -EFAULT;
>  
>  	mutex_lock(&ctx->status_mutex);
>  	if (ctx->status != OPENED) {
> -- 
> 2.11.0
