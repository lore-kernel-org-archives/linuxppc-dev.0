Return-Path: <fbarrat@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40j5n33ZCPzF2Dp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 20:24:38 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4BAO1VR041056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 06:24:36 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hw556tkmc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 06:24:35 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Fri, 11 May 2018 11:24:33 +0100
Subject: Re: [PATCH] misc: cxl: Change return type to vm_fault_t
To: Souptick Joarder <jrdr.linux@gmail.com>, fbarrat@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 willy@infradead.org
References: <20180417145354.GA31451@jordon-HP-15-Notebook-PC>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Fri, 11 May 2018 12:24:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180417145354.GA31451@jordon-HP-15-Notebook-PC>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <efed6e3d-b40b-9a96-4e7a-f5409c03c54f@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 17/04/2018 à 16:53, Souptick Joarder a écrit :
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
> 
> Reference id -> 1c8f422059ae ("mm: change return type to
> vm_fault_t")
> 
> previously cxl_mmap_fault returns VM_FAULT_NOPAGE as
> default value irrespective of vm_insert_pfn() return
> value. This bug is fixed with new vmf_insert_pfn()
> which will return VM_FAULT_ type based on err.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---

It looks ok, and it passed some basic testing.

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

   Fred


>   drivers/misc/cxl/context.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
> index 7ff315a..c6ec872 100644
> --- a/drivers/misc/cxl/context.c
> +++ b/drivers/misc/cxl/context.c
> @@ -128,11 +128,12 @@ void cxl_context_set_mapping(struct cxl_context *ctx,
>   	mutex_unlock(&ctx->mapping_lock);
>   }
> 
> -static int cxl_mmap_fault(struct vm_fault *vmf)
> +static vm_fault_t cxl_mmap_fault(struct vm_fault *vmf)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
>   	struct cxl_context *ctx = vma->vm_file->private_data;
>   	u64 area, offset;
> +	vm_fault_t ret;
> 
>   	offset = vmf->pgoff << PAGE_SHIFT;
> 
> @@ -169,11 +170,11 @@ static int cxl_mmap_fault(struct vm_fault *vmf)
>   		return VM_FAULT_SIGBUS;
>   	}
> 
> -	vm_insert_pfn(vma, vmf->address, (area + offset) >> PAGE_SHIFT);
> +	ret = vmf_insert_pfn(vma, vmf->address, (area + offset) >> PAGE_SHIFT);
> 
>   	mutex_unlock(&ctx->status_mutex);
> 
> -	return VM_FAULT_NOPAGE;
> +	return ret;
>   }
> 
>   static const struct vm_operations_struct cxl_mmap_vmops = {
> --
> 1.9.1
> 
