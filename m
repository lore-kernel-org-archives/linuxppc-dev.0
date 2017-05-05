Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wK3Ny0lpFzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 17:26:41 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v457PQQL016205
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 May 2017 03:26:31 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a8f9uvc06-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 May 2017 03:26:21 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 5 May 2017 17:15:14 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v457F4ZU1048994
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 May 2017 17:15:12 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v457Eemh008568
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 May 2017 17:14:40 +1000
Subject: Re: [PATCH] cxl: Unlock on error in probe
To: Dan Carpenter <dan.carpenter@oracle.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <20170505053622.0670F124037@b01ledav002.gho.pok.ibm.com>
Cc: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 5 May 2017 17:14:15 +1000
MIME-Version: 1.0
In-Reply-To: <20170505053622.0670F124037@b01ledav002.gho.pok.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <a4c0a3f6-f631-0998-ddd0-ca2efd4f1bfd@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/05/17 15:34, Dan Carpenter wrote:
> We should unlock if get_cxl_adapter() fails.
>
> Fixes: 594ff7d067ca ("cxl: Support to flash a new image on the adapter from a guest")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
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

sem is a global and it looks like it's intended to be held after 
device_open() returns and only released in device_close(), so this looks 
wrong.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
