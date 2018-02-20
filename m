Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmGpQ0CwYzF15s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 10:21:33 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1KNIeL9050353
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 18:21:31 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g8tk7wjvf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 18:21:31 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 20 Feb 2018 23:21:28 -0000
Subject: Re: [PATCH] ocxl: Fix potential bad errno on irq allocation
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: dan.carpenter@oracle.com
References: <20180216130118.26008-1-fbarrat@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 21 Feb 2018 10:21:24 +1100
MIME-Version: 1.0
In-Reply-To: <20180216130118.26008-1-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c62394de-8ea4-9d8d-41be-ffea79199678@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17/02/18 00:01, Frederic Barrat wrote:
> Fix some issues found by a static checker:
> 
> When allocating an AFU interrupt, if the driver cannot copy the output
> parameters to userland, the errno value was not set to EFAULT
> 
> Remove a (now) useless cast.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   drivers/misc/ocxl/file.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
> index 2dd2db9bc1c9..337462e1569f 100644
> --- a/drivers/misc/ocxl/file.c
> +++ b/drivers/misc/ocxl/file.c
> @@ -133,8 +133,10 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
>   		if (!rc) {
>   			rc = copy_to_user((u64 __user *) args, &irq_offset,
>   					sizeof(irq_offset));
> -			if (rc)
> +			if (rc) {
>   				ocxl_afu_irq_free(ctx, irq_offset);
> +				return -EFAULT;
> +			}
>   		}
>   		break;
> 
> @@ -329,7 +331,7 @@ static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
> 
>   	used += sizeof(header);
> 
> -	rc = (ssize_t) used;
> +	rc = used;
>   	return rc;
>   }
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
