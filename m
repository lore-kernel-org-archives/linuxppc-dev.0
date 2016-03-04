Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 144571A045E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 22:23:23 +1100 (AEDT)
Received: from localhost
 by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 11:23:19 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 99C2517D8059
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 11:23:26 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u24BN0Gb3146006
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 11:23:00 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u24BN02J020844
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 04:23:00 -0700
Subject: Re: [PATCH] cxl: Add cxl_read_adapter_vpd() to the kernel API
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <1453223694-5190-1-git-send-email-fbarrat@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <56D97013.2010703@linux.vnet.ibm.com>
Date: Fri, 4 Mar 2016 12:22:59 +0100
MIME-Version: 1.0
In-Reply-To: <1453223694-5190-1-git-send-email-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The point of this patch was to break a dependency with cxlflash, so that 
they could drop their powerVM changes independently from cxl.

Since this hasn't hit upstream or next yet, change of plan: we've agreed 
with cxlflash that the cxl powerVM patchset will do the (small) 
modification to cxlflash (and remove the now obsolete cxl_get_phys_dev() 
kernel API, as discussed in this thread with Mikey). So no more 
dependencies.
It will be part of the powerVM patchset v6

   Fred


Le 19/01/2016 18:14, Frederic Barrat a écrit :
> Introduce a new API to read the VPD of the adapter. In bare-metal, a
> kernel driver can find out the adapter pci_dev behind the AFU device
> and call pci_read_vpd() directly, but it won't work in a (powerVM)
> guest.
> Current implementation is a stub to allow existing drivers (cxlflash)
> to start using it.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> ---
>   drivers/misc/cxl/api.c | 8 ++++++++
>   include/misc/cxl.h     | 5 +++++
>   2 files changed, 13 insertions(+)
>
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index ea3eeb7..c73aa3a 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -363,3 +363,11 @@ void cxl_perst_reloads_same_image(struct cxl_afu *afu,
>   	afu->adapter->perst_same_image = perst_reloads_same_image;
>   }
>   EXPORT_SYMBOL_GPL(cxl_perst_reloads_same_image);
> +
> +ssize_t cxl_read_adapter_vpd(struct pci_dev *afu_dev, void *buf, size_t count)
> +{
> +	struct device *parent = cxl_get_phys_dev(afu_dev);
> +
> +	return pci_read_vpd(to_pci_dev(parent), 0, count, buf);
> +}
> +EXPORT_SYMBOL_GPL(cxl_read_adapter_vpd);
> diff --git a/include/misc/cxl.h b/include/misc/cxl.h
> index f2ffe5b..3f9e84f 100644
> --- a/include/misc/cxl.h
> +++ b/include/misc/cxl.h
> @@ -210,4 +210,9 @@ ssize_t cxl_fd_read(struct file *file, char __user *buf, size_t count,
>   void cxl_perst_reloads_same_image(struct cxl_afu *afu,
>   				  bool perst_reloads_same_image);
>
> +/*
> + * Read the VPD of the adapter where the AFU pci dev resides
> + */
> +ssize_t cxl_read_adapter_vpd(struct pci_dev *afu_dev, void *buf, size_t count);
> +
>   #endif /* _MISC_CXL_H */
>
