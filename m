Return-Path: <clg@kaod.org>
Received: from 7.mo177.mail-out.ovh.net (7.mo177.mail-out.ovh.net
 [46.105.61.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQwLt58ChzDr8j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 04:31:00 +1100 (AEDT)
Received: from player792.ha.ovh.net (b7.ovh.net [213.186.33.57])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id AA79596279
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 18:11:12 +0100 (CET)
Subject: Re: [PATCH 07/13] ocxl: Add AFU interrupt support
To: benh@au1.ibm.com, Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, alastair@au1.ibm.com
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
 <d7666f69b09f1e5dc713bf0524912184c978b963.1513608243.git.fbarrat@linux.vnet.ibm.com>
 <1513656340.2743.3.camel@au1.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e8bbbe40-56cf-29b9-0274-7f8f3e87f376@kaod.org>
Date: Tue, 23 Jan 2018 17:10:59 +0000
MIME-Version: 1.0
In-Reply-To: <1513656340.2743.3.camel@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/19/2017 04:05 AM, Benjamin Herrenschmidt wrote:
> On Mon, 2017-12-18 at 16:21 +0100, Frederic Barrat wrote:
>> Add user APIs through ioctl to allocate, free, and be notified of an
>> AFU interrupt.
>>
>> For opencapi, an AFU can trigger an interrupt on the host by sending a
>> specific command targeting a 64-bit object handle. On POWER9, this is
>> implemented by mapping a special page in the address space of a
>> process and a write to that page will trigger an interrupt.
> 
> We need to figure out how that plays with KVM. +Cedric..
> 
> For all those "generic xive" interrupts, whether they are used for
> OpenCAPI, plain guest IPIs, NX interrupts etc... but also for actual
> pass-through ones, we'll need a mechanism to map the trigger and ESB
> pages into qemu.
It seems feasible to use a common driver, at least for QEMU/KVM 
and OCXL, to expose the ESB pages of a range of IRQ numbers. Fred 
has already defined a user API, a set of ioctl which allocate, free 
one IRQ and also associate an IRQ with an eventfd for handling. 
The VMA is populated on demand. 

This XIVE IRQ "device", that I don't know how to name, defines 
generic IRQ sources and handlers for a given range. We would need 
a couple of properties to describe it in a device tree, 

  - "ibm,xive-lisn-ranges" for the range.
  
Anymore ? 

The current code needs some changes to distinguish the XIVE IRQ 
driver from the OCXL one, range support should be added, using a 
bitmap to track allocation I guess.

>From a OCXL perspective, the XIVE IRQ device driver would be 
instantiated from the OCXL one using an ioctl returning an fd,
like KVM does with KVM devices. User space would then alloc, free, 
associate IRQs and mmap the ESB pages to configure the OpenCAPI 
device. As for QEMU, I think we could add an extra KVM device, 
QEMU does not need the 'associate' feature though.

Such devices could theoretically be defined by the firmware for 
general purpose also, and be used through a char device. This is 
a possibility.


> We can't have a bazillion VMAs and KVM memory regions either, so we'll
> need some kind of mechanism/driver which allows for a single fairly
> large mmap'ed VMA which can then be "populated" with interrupt control
> pages.

yes. the full address range should mmapped for the IRQ range defined
for the device. access to pages not populated would return EFAULT.  
 
> The issue of course is that we can't really do a "generic" system that
> allows to map any interrupt, it's a security issue. So we need the
> interrupt "owner" to be the one allowing this. VFIO for PCI for
> example, possibly a specific VFIO variant for OpenCAPI, something else
> for guest IPIs ?
If we have defined ranges per devices, that should be enough no ?

Thanks,

C. 
 
> Food for thoughts...
> 
> Ben.
> 
>>
>> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/pnv-ocxl.h   |   3 +
>>  arch/powerpc/platforms/powernv/ocxl.c |  30 +++++
>>  drivers/misc/ocxl/afu_irq.c           | 204 ++++++++++++++++++++++++++++++++++
>>  drivers/misc/ocxl/context.c           |  40 ++++++-
>>  drivers/misc/ocxl/file.c              |  33 ++++++
>>  drivers/misc/ocxl/link.c              |  28 +++++
>>  drivers/misc/ocxl/ocxl_internal.h     |   7 ++
>>  include/uapi/misc/ocxl.h              |   9 ++
>>  8 files changed, 352 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/misc/ocxl/afu_irq.c
>>
>> diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
>> index 5a7ae7f28209..1e26f0a39500 100644
>> --- a/arch/powerpc/include/asm/pnv-ocxl.h
>> +++ b/arch/powerpc/include/asm/pnv-ocxl.h
>> @@ -37,4 +37,7 @@ extern int pnv_ocxl_spa_setup(struct pci_dev *dev, void *spa_mem, int PE_mask,
>>  extern void pnv_ocxl_spa_release(void *platform_data);
>>  extern int pnv_ocxl_spa_remove_pe(void *platform_data, int pe_handle);
>>  
>> +extern int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr);
>> +extern void pnv_ocxl_free_xive_irq(u32 irq);
>> +
>>  #endif /* _ASM_PVN_OCXL_H */
>> diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
>> index 6c79924b95c8..96cafba6aef1 100644
>> --- a/arch/powerpc/platforms/powernv/ocxl.c
>> +++ b/arch/powerpc/platforms/powernv/ocxl.c
>> @@ -9,6 +9,7 @@
>>  
>>  #include <asm/pnv-ocxl.h>
>>  #include <asm/opal.h>
>> +#include <asm/xive.h>
>>  #include <misc/ocxl-config.h>
>>  #include "pci.h"
>>  
>> @@ -487,3 +488,32 @@ int pnv_ocxl_spa_remove_pe(void *platform_data, int pe_handle)
>>  	return rc;
>>  }
>>  EXPORT_SYMBOL_GPL(pnv_ocxl_spa_remove_pe);
>> +
>> +int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr)
>> +{
>> +	__be64 flags, trigger_page;
>> +	s64 rc;
>> +	u32 hwirq;
>> +
>> +	hwirq = xive_native_alloc_irq();
>> +	if (!hwirq)
>> +		return -ENOENT;
>> +
>> +	rc = opal_xive_get_irq_info(hwirq, &flags, NULL, &trigger_page, NULL,
>> +				NULL);
>> +	if (rc || !trigger_page) {
>> +		xive_native_free_irq(hwirq);
>> +		return -ENOENT;
>> +	}
>> +	*irq = hwirq;
>> +	*trigger_addr = be64_to_cpu(trigger_page);
>> +	return 0;
>> +
>> +}
>> +EXPORT_SYMBOL_GPL(pnv_ocxl_alloc_xive_irq);
>> +
>> +void pnv_ocxl_free_xive_irq(u32 irq)
>> +{
>> +	xive_native_free_irq(irq);
>> +}
>> +EXPORT_SYMBOL_GPL(pnv_ocxl_free_xive_irq);
>> diff --git a/drivers/misc/ocxl/afu_irq.c b/drivers/misc/ocxl/afu_irq.c
>> new file mode 100644
>> index 000000000000..0b217a854837
>> --- /dev/null
>> +++ b/drivers/misc/ocxl/afu_irq.c
>> @@ -0,0 +1,204 @@
>> +/*
>> + * Copyright 2017 IBM Corp.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/eventfd.h>
>> +#include <asm/pnv-ocxl.h>
>> +#include "ocxl_internal.h"
>> +
>> +struct afu_irq {
>> +	int id;
>> +	int hw_irq;
>> +	unsigned int virq;
>> +	char *name;
>> +	u64 trigger_page;
>> +	struct eventfd_ctx *ev_ctx;
>> +};
>> +
>> +static int irq_offset_to_id(struct ocxl_context *ctx, u64 offset)
>> +{
>> +	return (offset - ctx->afu->irq_base_offset) >> PAGE_SHIFT;
>> +}
>> +
>> +static u64 irq_id_to_offset(struct ocxl_context *ctx, int id)
>> +{
>> +	return ctx->afu->irq_base_offset + (id << PAGE_SHIFT);
>> +}
>> +
>> +static irqreturn_t afu_irq_handler(int virq, void *data)
>> +{
>> +	struct afu_irq *irq = (struct afu_irq *) data;
>> +
>> +	if (irq->ev_ctx)
>> +		eventfd_signal(irq->ev_ctx, 1);
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int setup_afu_irq(struct ocxl_context *ctx, struct afu_irq *irq)
>> +{
>> +	int rc;
>> +
>> +	irq->virq = irq_create_mapping(NULL, irq->hw_irq);
>> +	if (!irq->virq) {
>> +		pr_err("irq_create_mapping failed\n");
>> +		return -ENOMEM;
>> +	}
>> +	pr_debug("hw_irq %d mapped to virq %u\n", irq->hw_irq, irq->virq);
>> +
>> +	irq->name = kasprintf(GFP_KERNEL, "ocxl-afu-%u", irq->virq);
>> +	if (!irq->name) {
>> +		irq_dispose_mapping(irq->virq);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	rc = request_irq(irq->virq, afu_irq_handler, 0, irq->name, irq);
>> +	if (rc) {
>> +		kfree(irq->name);
>> +		irq->name = NULL;
>> +		irq_dispose_mapping(irq->virq);
>> +		pr_err("request_irq failed: %d\n", rc);
>> +		return rc;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static void release_afu_irq(struct afu_irq *irq)
>> +{
>> +	free_irq(irq->virq, irq);
>> +	irq_dispose_mapping(irq->virq);
>> +	kfree(irq->name);
>> +}
>> +
>> +int ocxl_afu_irq_alloc(struct ocxl_context *ctx, u64 *irq_offset)
>> +{
>> +	struct afu_irq *irq;
>> +	int rc;
>> +
>> +	irq = kzalloc(sizeof(struct afu_irq), GFP_KERNEL);
>> +	if (!irq)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * We limit the number of afu irqs per context and per link to
>> +	 * avoid a single process or user depleting the pool of IPIs
>> +	 */
>> +
>> +	mutex_lock(&ctx->irq_lock);
>> +
>> +	irq->id = idr_alloc(&ctx->irq_idr, irq, 0, MAX_IRQ_PER_CONTEXT,
>> +			GFP_KERNEL);
>> +	if (irq->id < 0) {
>> +		rc = -ENOSPC;
>> +		goto err_unlock;
>> +	}
>> +
>> +	rc = ocxl_link_irq_alloc(ctx->afu->fn->link, &irq->hw_irq,
>> +				&irq->trigger_page);
>> +	if (rc)
>> +		goto err_idr;
>> +
>> +	rc = setup_afu_irq(ctx, irq);
>> +	if (rc)
>> +		goto err_alloc;
>> +
>> +	*irq_offset = irq_id_to_offset(ctx, irq->id);
>> +
>> +	mutex_unlock(&ctx->irq_lock);
>> +	return 0;
>> +
>> +err_alloc:
>> +	ocxl_link_free_irq(ctx->afu->fn->link, irq->hw_irq);
>> +err_idr:
>> +	idr_remove(&ctx->irq_idr, irq->id);
>> +err_unlock:
>> +	mutex_unlock(&ctx->irq_lock);
>> +	kfree(irq);
>> +	return rc;
>> +}
>> +
>> +static void afu_irq_free(struct afu_irq *irq, struct ocxl_context *ctx)
>> +{
>> +	if (ctx->mapping)
>> +		unmap_mapping_range(ctx->mapping,
>> +				irq_id_to_offset(ctx, irq->id),
>> +				1 << PAGE_SHIFT, 1);
>> +	release_afu_irq(irq);
>> +	if (irq->ev_ctx)
>> +		eventfd_ctx_put(irq->ev_ctx);
>> +	ocxl_link_free_irq(ctx->afu->fn->link, irq->hw_irq);
>> +	kfree(irq);
>> +}
>> +
>> +int ocxl_afu_irq_free(struct ocxl_context *ctx, u64 irq_offset)
>> +{
>> +	struct afu_irq *irq;
>> +	int id = irq_offset_to_id(ctx, irq_offset);
>> +
>> +	mutex_lock(&ctx->irq_lock);
>> +
>> +	irq = idr_find(&ctx->irq_idr, id);
>> +	if (!irq) {
>> +		mutex_unlock(&ctx->irq_lock);
>> +		return -EINVAL;
>> +	}
>> +	idr_remove(&ctx->irq_idr, irq->id);
>> +	afu_irq_free(irq, ctx);
>> +	mutex_unlock(&ctx->irq_lock);
>> +	return 0;
>> +}
>> +
>> +void ocxl_afu_irq_free_all(struct ocxl_context *ctx)
>> +{
>> +	struct afu_irq *irq;
>> +	int id;
>> +
>> +	mutex_lock(&ctx->irq_lock);
>> +	idr_for_each_entry(&ctx->irq_idr, irq, id)
>> +		afu_irq_free(irq, ctx);
>> +	mutex_unlock(&ctx->irq_lock);
>> +}
>> +
>> +int ocxl_afu_irq_set_fd(struct ocxl_context *ctx, u64 irq_offset, int eventfd)
>> +{
>> +	struct afu_irq *irq;
>> +	struct eventfd_ctx *ev_ctx;
>> +	int rc = 0, id = irq_offset_to_id(ctx, irq_offset);
>> +
>> +	mutex_lock(&ctx->irq_lock);
>> +	irq = idr_find(&ctx->irq_idr, id);
>> +	if (!irq) {
>> +		rc = -EINVAL;
>> +		goto unlock;
>> +	}
>> +
>> +	ev_ctx = eventfd_ctx_fdget(eventfd);
>> +	if (IS_ERR(ev_ctx)) {
>> +		rc = -EINVAL;
>> +		goto unlock;
>> +	}
>> +
>> +	irq->ev_ctx = ev_ctx;
>> +unlock:
>> +	mutex_unlock(&ctx->irq_lock);
>> +	return rc;
>> +}
>> +
>> +u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, u64 irq_offset)
>> +{
>> +	struct afu_irq *irq;
>> +	int id = irq_offset_to_id(ctx, irq_offset);
>> +	u64 addr = 0;
>> +
>> +	mutex_lock(&ctx->irq_lock);
>> +	irq = idr_find(&ctx->irq_idr, id);
>> +	if (irq)
>> +		addr = irq->trigger_page;
>> +	mutex_unlock(&ctx->irq_lock);
>> +	return addr;
>> +}
>> diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
>> index 0bc0dd97d784..19575269ed22 100644
>> --- a/drivers/misc/ocxl/context.c
>> +++ b/drivers/misc/ocxl/context.c
>> @@ -38,6 +38,8 @@ int ocxl_context_init(struct ocxl_context *ctx, struct ocxl_afu *afu,
>>  	mutex_init(&ctx->mapping_lock);
>>  	init_waitqueue_head(&ctx->events_wq);
>>  	mutex_init(&ctx->xsl_error_lock);
>> +	mutex_init(&ctx->irq_lock);
>> +	idr_init(&ctx->irq_idr);
>>  	/*
>>  	 * Keep a reference on the AFU to make sure it's valid for the
>>  	 * duration of the life of the context
>> @@ -87,6 +89,19 @@ int ocxl_context_attach(struct ocxl_context *ctx, u64 amr)
>>  	return rc;
>>  }
>>  
>> +static int map_afu_irq(struct vm_area_struct *vma, unsigned long address,
>> +		u64 offset, struct ocxl_context *ctx)
>> +{
>> +	u64 trigger_addr;
>> +
>> +	trigger_addr = ocxl_afu_irq_get_addr(ctx, offset);
>> +	if (!trigger_addr)
>> +		return VM_FAULT_SIGBUS;
>> +
>> +	vm_insert_pfn(vma, address, trigger_addr >> PAGE_SHIFT);
>> +	return VM_FAULT_NOPAGE;
>> +}
>> +
>>  static int map_pp_mmio(struct vm_area_struct *vma, unsigned long address,
>>  		u64 offset, struct ocxl_context *ctx)
>>  {
>> @@ -125,7 +140,10 @@ static int ocxl_mmap_fault(struct vm_fault *vmf)
>>  	pr_debug("%s: pasid %d address 0x%lx offset 0x%llx\n", __func__,
>>  		ctx->pasid, vmf->address, offset);
>>  
>> -	rc = map_pp_mmio(vma, vmf->address, offset, ctx);
>> +	if (offset < ctx->afu->irq_base_offset)
>> +		rc = map_pp_mmio(vma, vmf->address, offset, ctx);
>> +	else
>> +		rc = map_afu_irq(vma, vmf->address, offset, ctx);
>>  	return rc;
>>  }
>>  
>> @@ -133,6 +151,19 @@ static const struct vm_operations_struct ocxl_vmops = {
>>  	.fault = ocxl_mmap_fault,
>>  };
>>  
>> +static int check_mmap_afu_irq(struct ocxl_context *ctx,
>> +			struct vm_area_struct *vma)
>> +{
>> +	/* only one page */
>> +	if (vma_pages(vma) != 1)
>> +		return -EINVAL;
>> +
>> +	/* check offset validty */
>> +	if (!ocxl_afu_irq_get_addr(ctx, vma->vm_pgoff << PAGE_SHIFT))
>> +		return -EINVAL;
>> +	return 0;
>> +}
>> +
>>  static int check_mmap_mmio(struct ocxl_context *ctx,
>>  			struct vm_area_struct *vma)
>>  {
>> @@ -146,7 +177,10 @@ int ocxl_context_mmap(struct ocxl_context *ctx, struct vm_area_struct *vma)
>>  {
>>  	int rc;
>>  
>> -	rc = check_mmap_mmio(ctx, vma);
>> +	if ((vma->vm_pgoff << PAGE_SHIFT) < ctx->afu->irq_base_offset)
>> +		rc = check_mmap_mmio(ctx, vma);
>> +	else
>> +		rc = check_mmap_afu_irq(ctx, vma);
>>  	if (rc)
>>  		return rc;
>>  
>> @@ -231,6 +265,8 @@ void ocxl_context_free(struct ocxl_context *ctx)
>>  	idr_remove(&ctx->afu->contexts_idr, ctx->pasid);
>>  	mutex_unlock(&ctx->afu->contexts_lock);
>>  
>> +	ocxl_afu_irq_free_all(ctx);
>> +	idr_destroy(&ctx->irq_idr);
>>  	/* reference to the AFU taken in ocxl_context_init */
>>  	ocxl_afu_put(ctx->afu);
>>  	kfree(ctx);
>> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
>> index a51386eff4f5..0a73e2c11ba6 100644
>> --- a/drivers/misc/ocxl/file.c
>> +++ b/drivers/misc/ocxl/file.c
>> @@ -110,12 +110,17 @@ static long afu_ioctl_attach(struct ocxl_context *ctx,
>>  }
>>  
>>  #define CMD_STR(x) (x == OCXL_IOCTL_ATTACH ? "ATTACH" :			\
>> +			x == OCXL_IOCTL_IRQ_ALLOC ? "IRQ_ALLOC" :	\
>> +			x == OCXL_IOCTL_IRQ_FREE ? "IRQ_FREE" :		\
>> +			x == OCXL_IOCTL_IRQ_SET_FD ? "IRQ_SET_FD" :	\
>>  			"UNKNOWN")
>>  
>>  static long afu_ioctl(struct file *file, unsigned int cmd,
>>  		unsigned long args)
>>  {
>>  	struct ocxl_context *ctx = file->private_data;
>> +	struct ocxl_ioctl_irq_fd irq_fd;
>> +	u64 irq_offset;
>>  	long rc;
>>  
>>  	pr_debug("%s for context %d, command %s\n", __func__, ctx->pasid,
>> @@ -130,6 +135,34 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
>>  				(struct ocxl_ioctl_attach __user *) args);
>>  		break;
>>  
>> +	case OCXL_IOCTL_IRQ_ALLOC:
>> +		rc = ocxl_afu_irq_alloc(ctx, &irq_offset);
>> +		if (!rc) {
>> +			rc = copy_to_user((u64 *) args, &irq_offset,
>> +					sizeof(irq_offset));
>> +			if (rc)
>> +				ocxl_afu_irq_free(ctx, irq_offset);
>> +		}
>> +		break;
>> +
>> +	case OCXL_IOCTL_IRQ_FREE:
>> +		rc = copy_from_user(&irq_offset, (u64 *) args,
>> +				sizeof(irq_offset));
>> +		if (rc)
>> +			return -EFAULT;
>> +		rc = ocxl_afu_irq_free(ctx, irq_offset);
>> +		break;
>> +
>> +	case OCXL_IOCTL_IRQ_SET_FD:
>> +		rc = copy_from_user(&irq_fd, (u64 *) args, sizeof(irq_fd));
>> +		if (rc)
>> +			return -EFAULT;
>> +		if (irq_fd.reserved)
>> +			return -EINVAL;
>> +		rc = ocxl_afu_irq_set_fd(ctx, irq_fd.irq_offset,
>> +					irq_fd.eventfd);
>> +		break;
>> +
>>  	default:
>>  		rc = -EINVAL;
>>  	}
>> diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
>> index 6b184cd7d2a6..5f12564eea99 100644
>> --- a/drivers/misc/ocxl/link.c
>> +++ b/drivers/misc/ocxl/link.c
>> @@ -608,3 +608,31 @@ int ocxl_link_remove_pe(void *link_handle, int pasid)
>>  	mutex_unlock(&spa->spa_lock);
>>  	return rc;
>>  }
>> +
>> +int ocxl_link_irq_alloc(void *link_handle, int *hw_irq, u64 *trigger_addr)
>> +{
>> +	struct link *link = (struct link *) link_handle;
>> +	int rc, irq;
>> +	u64 addr;
>> +
>> +	if (atomic_dec_if_positive(&link->irq_available) < 0)
>> +		return -ENOSPC;
>> +
>> +	rc = pnv_ocxl_alloc_xive_irq(&irq, &addr);
>> +	if (rc) {
>> +		atomic_inc(&link->irq_available);
>> +		return rc;
>> +	}
>> +
>> +	*hw_irq = irq;
>> +	*trigger_addr = addr;
>> +	return 0;
>> +}
>> +
>> +void ocxl_link_free_irq(void *link_handle, int hw_irq)
>> +{
>> +	struct link *link = (struct link *) link_handle;
>> +
>> +	pnv_ocxl_free_xive_irq(hw_irq);
>> +	atomic_inc(&link->irq_available);
>> +}
>> diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
>> index e07f7d523275..829369c5f004 100644
>> --- a/drivers/misc/ocxl/ocxl_internal.h
>> +++ b/drivers/misc/ocxl/ocxl_internal.h
>> @@ -197,4 +197,11 @@ extern void ocxl_context_free(struct ocxl_context *ctx);
>>  extern int ocxl_sysfs_add_afu(struct ocxl_afu *afu);
>>  extern void ocxl_sysfs_remove_afu(struct ocxl_afu *afu);
>>  
>> +extern int ocxl_afu_irq_alloc(struct ocxl_context *ctx, u64 *irq_offset);
>> +extern int ocxl_afu_irq_free(struct ocxl_context *ctx, u64 irq_offset);
>> +extern void ocxl_afu_irq_free_all(struct ocxl_context *ctx);
>> +extern int ocxl_afu_irq_set_fd(struct ocxl_context *ctx, u64 irq_offset,
>> +			int eventfd);
>> +extern u64 ocxl_afu_irq_get_addr(struct ocxl_context *ctx, u64 irq_offset);
>> +
>>  #endif /* _OCXL_INTERNAL_H_ */
>> diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
>> index 71fa387f2efd..488e75228c33 100644
>> --- a/include/uapi/misc/ocxl.h
>> +++ b/include/uapi/misc/ocxl.h
>> @@ -39,9 +39,18 @@ struct ocxl_ioctl_attach {
>>  	__u64 reserved3;
>>  };
>>  
>> +struct ocxl_ioctl_irq_fd {
>> +	__u64 irq_offset;
>> +	__s32 eventfd;
>> +	__u32 reserved;
>> +};
>> +
>>  /* ioctl numbers */
>>  #define OCXL_MAGIC 0xCA
>>  /* AFU devices */
>>  #define OCXL_IOCTL_ATTACH	_IOW(OCXL_MAGIC, 0x10, struct ocxl_ioctl_attach)
>> +#define OCXL_IOCTL_IRQ_ALLOC	_IOR(OCXL_MAGIC, 0x11, __u64)
>> +#define OCXL_IOCTL_IRQ_FREE	_IOW(OCXL_MAGIC, 0x12, __u64)
>> +#define OCXL_IOCTL_IRQ_SET_FD	_IOW(OCXL_MAGIC, 0x13, struct ocxl_ioctl_irq_fd)
>>  
>>  #endif /* _UAPI_MISC_OCXL_H */
> 
