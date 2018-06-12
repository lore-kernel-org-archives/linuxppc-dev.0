Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414ccC4FsBzF49q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 14:39:39 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5C4crUi194420
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 00:39:36 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jj6u815nv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 00:39:36 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 12 Jun 2018 05:39:34 +0100
Subject: Re: [PATCH] misc: ocxl: Change return type for fault handler
To: Souptick Joarder <jrdr.linux@gmail.com>, willy@infradead.org,
 fbarrat@linux.vnet.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: brajeswar.linux@gmail.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
References: <20180611202904.GA25538@jordon-HP-15-Notebook-PC>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 12 Jun 2018 14:39:27 +1000
MIME-Version: 1.0
In-Reply-To: <20180611202904.GA25538@jordon-HP-15-Notebook-PC>
Message-Id: <86dcb0d4-0539-13e3-1eb2-8e2482e8c07b@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/06/18 06:29, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
> 
> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
> 
> There is an existing bug when vm_insert_pfn() can return
> ENOMEM which was ignored and VM_FAULT_NOPAGE returned as
> default. The new inline vmf_insert_pfn() has removed
> this inefficiency by returning correct vm_fault_ type.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Looks okay to me

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   drivers/misc/ocxl/context.c | 22 +++++++++++-----------
>   drivers/misc/ocxl/sysfs.c   |  5 ++---
>   2 files changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
> index 909e880..98daf91 100644
> --- a/drivers/misc/ocxl/context.c
> +++ b/drivers/misc/ocxl/context.c
> @@ -83,7 +83,7 @@ int ocxl_context_attach(struct ocxl_context *ctx, u64 amr)
>   	return rc;
>   }
>   
> -static int map_afu_irq(struct vm_area_struct *vma, unsigned long address,
> +static vm_fault_t map_afu_irq(struct vm_area_struct *vma, unsigned long address,
>   		u64 offset, struct ocxl_context *ctx)
>   {
>   	u64 trigger_addr;
> @@ -92,15 +92,15 @@ static int map_afu_irq(struct vm_area_struct *vma, unsigned long address,
>   	if (!trigger_addr)
>   		return VM_FAULT_SIGBUS;
>   
> -	vm_insert_pfn(vma, address, trigger_addr >> PAGE_SHIFT);
> -	return VM_FAULT_NOPAGE;
> +	return vmf_insert_pfn(vma, address, trigger_addr >> PAGE_SHIFT);
>   }
>   
> -static int map_pp_mmio(struct vm_area_struct *vma, unsigned long address,
> +static vm_fault_t map_pp_mmio(struct vm_area_struct *vma, unsigned long address,
>   		u64 offset, struct ocxl_context *ctx)
>   {
>   	u64 pp_mmio_addr;
>   	int pasid_off;
> +	vm_fault_t ret;
>   
>   	if (offset >= ctx->afu->config.pp_mmio_stride)
>   		return VM_FAULT_SIGBUS;
> @@ -118,27 +118,27 @@ static int map_pp_mmio(struct vm_area_struct *vma, unsigned long address,
>   		pasid_off * ctx->afu->config.pp_mmio_stride +
>   		offset;
>   
> -	vm_insert_pfn(vma, address, pp_mmio_addr >> PAGE_SHIFT);
> +	ret = vmf_insert_pfn(vma, address, pp_mmio_addr >> PAGE_SHIFT);
>   	mutex_unlock(&ctx->status_mutex);
> -	return VM_FAULT_NOPAGE;
> +	return ret;
>   }
>   
> -static int ocxl_mmap_fault(struct vm_fault *vmf)
> +static vm_fault_t ocxl_mmap_fault(struct vm_fault *vmf)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
>   	struct ocxl_context *ctx = vma->vm_file->private_data;
>   	u64 offset;
> -	int rc;
> +	vm_fault_t ret;
>   
>   	offset = vmf->pgoff << PAGE_SHIFT;
>   	pr_debug("%s: pasid %d address 0x%lx offset 0x%llx\n", __func__,
>   		ctx->pasid, vmf->address, offset);
>   
>   	if (offset < ctx->afu->irq_base_offset)
> -		rc = map_pp_mmio(vma, vmf->address, offset, ctx);
> +		ret = map_pp_mmio(vma, vmf->address, offset, ctx);
>   	else
> -		rc = map_afu_irq(vma, vmf->address, offset, ctx);
> -	return rc;
> +		ret = map_afu_irq(vma, vmf->address, offset, ctx);
> +	return ret;
>   }
>   
>   static const struct vm_operations_struct ocxl_vmops = {
> diff --git a/drivers/misc/ocxl/sysfs.c b/drivers/misc/ocxl/sysfs.c
> index d9753a1..0ab1fd1 100644
> --- a/drivers/misc/ocxl/sysfs.c
> +++ b/drivers/misc/ocxl/sysfs.c
> @@ -64,7 +64,7 @@ static ssize_t global_mmio_read(struct file *filp, struct kobject *kobj,
>   	return count;
>   }
>   
> -static int global_mmio_fault(struct vm_fault *vmf)
> +static vm_fault_t global_mmio_fault(struct vm_fault *vmf)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
>   	struct ocxl_afu *afu = vma->vm_private_data;
> @@ -75,8 +75,7 @@ static int global_mmio_fault(struct vm_fault *vmf)
>   
>   	offset = vmf->pgoff;
>   	offset += (afu->global_mmio_start >> PAGE_SHIFT);
> -	vm_insert_pfn(vma, vmf->address, offset);
> -	return VM_FAULT_NOPAGE;
> +	return vmf_insert_pfn(vma, vmf->address, offset);
>   }
>   
>   static const struct vm_operations_struct global_mmio_vmops = {
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
