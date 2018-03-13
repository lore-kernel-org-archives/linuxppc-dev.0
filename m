Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400qYH0cc4zDr5K
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 20:38:42 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2D9YCwO030443
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 05:38:40 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gpanqca7h-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 05:38:34 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 13 Mar 2018 09:38:32 -0000
Subject: Re: [PATCH 2/2] misc: ocxl: use put_device() instead of
 device_unregister()
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, sudeep.dutt@intel.com,
 ashutosh.dixit@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org,
 andrew.donnellan@au1.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1520849284.git.arvind.yadav.cs@gmail.com>
 <8c4d28703e408b71284af68d07c117e7b8c8a75a.1520849284.git.arvind.yadav.cs@gmail.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Tue, 13 Mar 2018 10:38:27 +0100
MIME-Version: 1.0
In-Reply-To: <8c4d28703e408b71284af68d07c117e7b8c8a75a.1520849284.git.arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c1b768e0-c5d6-a0bf-f756-6f7bff159bea@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 12/03/2018 à 12:36, Arvind Yadav a écrit :
> if device_register() returned an error! Always use put_device()
> to give up the reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---

OK, device_unregister() calls put_device() but also other actions that 
we can skip in this case.

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


>   drivers/misc/ocxl/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/ocxl/pci.c b/drivers/misc/ocxl/pci.c
> index 0051d9e..21f4254 100644
> --- a/drivers/misc/ocxl/pci.c
> +++ b/drivers/misc/ocxl/pci.c
> @@ -519,7 +519,7 @@ static struct ocxl_fn *init_function(struct pci_dev *dev)
>   	rc = device_register(&fn->dev);
>   	if (rc) {
>   		deconfigure_function(fn);
> -		device_unregister(&fn->dev);
> +		put_device(&fn->dev);
>   		return ERR_PTR(rc);
>   	}
>   	return fn;
> 
