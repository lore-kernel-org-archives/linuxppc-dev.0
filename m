Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wKG6X6qBfzDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 May 2017 01:29:55 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v45FSwY5005928
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 May 2017 11:29:51 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a8v0pr83f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 May 2017 11:29:51 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 5 May 2017 16:29:49 +0100
Subject: Re: [PATCH] cxl: Unlock on error in probe
To: Dan Carpenter <dan.carpenter@oracle.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <20170505053458.csrwd2kjber44r4o@mwanda>
Cc: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Fri, 5 May 2017 17:29:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170505053458.csrwd2kjber44r4o@mwanda>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <88932312-cbb5-40b0-da84-430535314389@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 05/05/2017 à 07:34, Dan Carpenter a écrit :
> We should unlock if get_cxl_adapter() fails.
>
> Fixes: 594ff7d067ca ("cxl: Support to flash a new image on the adapter from a guest")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Thanks!

   Fred



> diff --git a/drivers/misc/cxl/flash.c b/drivers/misc/cxl/flash.c
> index 7c61c70ba3f6..37475abea3e6 100644
> --- a/drivers/misc/cxl/flash.c
> +++ b/drivers/misc/cxl/flash.c
> @@ -401,8 +401,10 @@ static int device_open(struct inode *inode, struct file *file)
>  	if (down_interruptible(&sem) != 0)
>  		return -EPERM;
>
> -	if (!(adapter = get_cxl_adapter(adapter_num)))
> -		return -ENODEV;
> +	if (!(adapter = get_cxl_adapter(adapter_num))) {
> +		rc = -ENODEV;
> +		goto err_unlock;
> +	}
>
>  	file->private_data = adapter;
>  	continue_token = 0;
> @@ -446,6 +448,8 @@ static int device_open(struct inode *inode, struct file *file)
>  		free_page((unsigned long) le);
>  err:
>  	put_device(&adapter->dev);
> +err_unlock:
> +	up(&sem);
>
>  	return rc;
>  }
>
