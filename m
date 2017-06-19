Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrtDf27gSzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 00:10:58 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5JE91wf076325
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 10:10:56 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b6cye33j1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 10:10:55 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Mon, 19 Jun 2017 15:10:53 +0100
Subject: Re: [PATCH V2] cxl: Export library to support IBM XSL
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, vaibhav@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
References: <1497446944-15759-1-git-send-email-clombard@linux.vnet.ibm.com>
 <f02ffd47-9de4-98e7-d455-de2be271d0bd@linux.vnet.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Mon, 19 Jun 2017 16:10:51 +0200
MIME-Version: 1.0
In-Reply-To: <f02ffd47-9de4-98e7-d455-de2be271d0bd@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <f57fc67d-f468-2ccc-7762-7b22e17e9af6@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 15/06/2017 à 14:36, Frederic Barrat a écrit :
> Salut Christophe,
>
> A few comments below, nothing major...
>
> Le 14/06/2017 à 15:29, Christophe Lombard a écrit :
>> This patch exports a in-kernel 'library' API which can be called by
>> other drivers to help interacting with an IBM XSL on a POWER9 system.
>>
>> The XSL (Translation Service Layer) is a stripped down version of the
>> PSL (Power Service Layer) used in some cards such as the Mellanox CX5.
>> Like the PSL, it implements the CAIA architecture, but has a number
>> of differences, mostly in it's implementation dependent registers.
>>
>> The XSL also uses a special DMA cxl mode, which uses a slightly
>> different init sequence for the CAPP and PHB.
>>
>> Changelog[v2]
>>   - Rebase to latest upstream.
>>   - Return -EFAULT in case of NULL pointer in cxllib_handle_fault().
>>   - Reverse parameters when copro_handle_mm_fault() is called.
>>
>
>
> The change log shouldn't be part of the commit message, but below the 
> next "---"
>
>

sure.

>> +++ b/drivers/misc/cxl/cxllib.c
>> @@ -0,0 +1,241 @@
>> +/*
>> + * Copyright 2016 IBM Corp.
>
>
> Year need to be updated
>
>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
>> +
>> +#include <linux/hugetlb.h>
>> +#include <linux/sched/mm.h>
>> +#include "cxl.h"
>> +#include <misc/cxllib.h>
>> +#include <asm/pnv-pci.h>
>
> Ordering of the #include is messy:
> #include <linux/hugetlb.h>
> #include <linux/sched/mm.h>
> #include <asm/pnv-pci.h>
> #include <misc/cxllib.h>
> #include "cxl.h"
>
>
>
>> +int cxllib_set_device_dma(struct pci_dev *dev, unsigned long flags)
>> +{
>> +    int rc;
>> +
>> +    if (flags)
>> +        return -EINVAL;
>> +
>> +    rc = dma_set_mask(&dev->dev, DMA_BIT_MASK(64));
>> +    return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(cxllib_set_device_dma);
>
>
> A comment in cxllib_set_device_dma() would help:
>     /*
>      * When switching the PHB to capi mode, the TVT#1 entry for
>      * the Partitionable Endpoint is set in bypass mode, like
>      * in PCI mode.
>      * Configure the device dma to use TVT#1, which is done
>      * by calling dma_set_mask() with a mask large enough.
>      */
>
>
>
>> +
>> +int cxllib_get_PE_attributes(struct task_struct *task,
>> +         unsigned long translation_mode, struct cxllib_pe_attributes 
>> *attr)
>> +{
>> +    struct mm_struct *mm = NULL;
>> +
>> +    if (translation_mode != CXL_TRANSLATED_MODE &&
>> +        translation_mode != CXL_REAL_MODE)
>> +        return -EINVAL;
>> +
>> +    attr->sr = cxl_calculate_sr(false /* master */,
>> +                task == NULL /* kernel ctx */,
>> +                translation_mode == CXL_REAL_MODE,
>> +                true /* p9 */);
>> +    attr->lpid = mfspr(SPRN_LPID);
>> +    if (task) {
>> +        mm = get_task_mm(task);
>> +        if (mm == NULL)
>> +            return -EINVAL;
>> +        /*
>> +         * Caller is keeping a reference on mm_users for as long
>> +         * as XSL uses the memory context
>> +         */
>> +        attr->pid = mm->context.id;
>> +        mmput(mm);
>> +    } else {
>> +        attr->pid = 0;
>> +    }
>> +    attr->tid = 0;
>
>
> We'll need to remember to patch that function as welll (attr->tid) 
> when we add support for as_notify (even though Mellanox is not 
> expected to use as_notify in capi mode, just pci I believe)
>
>

yep.


>
>> +int cxllib_handle_fault(struct mm_struct *mm, u64 addr, u64 size, 
>> u64 flags)
>> +{
>> +    int rc;
>> +    u64 dar;
>> +    struct vm_area_struct *vma = NULL;
>> +    unsigned long page_size;
>> +
>> +    if (mm == NULL)
>> +        return -EFAULT;
>> +
>> +    down_read(&mm->mmap_sem);
>> +
>> +    for (dar = addr; dar < addr + size; dar += page_size) {
>> +        if (!vma || dar < vma->vm_start || dar > vma->vm_end) {
>> +            vma = find_vma(mm, addr);
>> +            if (!vma) {
>> +                pr_err("Can't find vma for addr %016llx\n", addr);
>> +                rc = -EFAULT;
>> +                goto out;
>> +            }
>> +            /* get the size of the pages allocated */
>> +            page_size = vma_kernel_pagesize(vma);
>> +        }
>> +
>> +        rc = cxl_handle_page_fault(true, mm, flags, dar);
>
>
> Why do we pass "true" for kernel parameter?
> Actually do we even need a kernel input parameter for 
> cxl_handle_page_fault() ? It seems that we can infer it based on mm. 
> If NULL, then we are in kernel space.
>
>

you are right. Previously, the test was based on the field ctx->kernel. 
This explains the kernel parameter.

>> diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
>> index c79e39b..9db63f3 100644
>> --- a/drivers/misc/cxl/fault.c
>> +++ b/drivers/misc/cxl/fault.c
>> @@ -132,18 +132,16 @@ static int cxl_handle_segment_miss(struct 
>> cxl_context *ctx,
>>       return IRQ_HANDLED;
>>   }
>>
>> -static void cxl_handle_page_fault(struct cxl_context *ctx,
>> -                  struct mm_struct *mm, u64 dsisr, u64 dar)
>> +int cxl_handle_page_fault(bool kernel_context,
>> +              struct mm_struct *mm, u64 dsisr, u64 dar)
>>   {
>>       unsigned flt = 0;
>>       int result;
>>       unsigned long access, flags, inv_flags = 0;
>>
>> -    trace_cxl_pte_miss(ctx, dsisr, dar);
>> -
>>       if ((result = copro_handle_mm_fault(mm, dar, dsisr, &flt))) {
>>           pr_devel("copro_handle_mm_fault failed: %#x\n", result);
>> -        return cxl_ack_ae(ctx);
>> +        return result;
>>       }
>>
>>       if (!radix_enabled()) {
>> @@ -156,7 +154,7 @@ static void cxl_handle_page_fault(struct 
>> cxl_context *ctx,
>>               access |= _PAGE_WRITE;
>>
>>           access |= _PAGE_PRIVILEGED;
>> -        if ((!ctx->kernel) || (REGION_ID(dar) == USER_REGION_ID))
>> +        if (!kernel_context || (REGION_ID(dar) == USER_REGION_ID))
>>               access &= ~_PAGE_PRIVILEGED;
>>
>>           if (dsisr & DSISR_NOHPTE)
>> @@ -166,8 +164,7 @@ static void cxl_handle_page_fault(struct 
>> cxl_context *ctx,
>>           hash_page_mm(mm, dar, access, 0x300, inv_flags);
>>           local_irq_restore(flags);
>>       }
>> -    pr_devel("Page fault successfully handled for pe: %i!\n", ctx->pe);
>> -    cxl_ops->ack_irq(ctx, CXL_PSL_TFC_An_R, 0);
>> +    return 0;
>>   }
>>
>>   /*
>> @@ -261,9 +258,15 @@ void cxl_handle_fault(struct work_struct 
>> *fault_work)
>>
>>       if (cxl_is_segment_miss(ctx, dsisr))
>>           cxl_handle_segment_miss(ctx, mm, dar);
>> -    else if (cxl_is_page_fault(ctx, dsisr))
>> -        cxl_handle_page_fault(ctx, mm, dsisr, dar);
>> -    else
>> +    else if (cxl_is_page_fault(ctx, dsisr)) {
>> +        trace_cxl_pte_miss(ctx, dsisr, dar);
>> +        if (cxl_handle_page_fault(ctx->kernel, mm, dsisr, dar)) {
>> +            cxl_ack_ae(ctx);
>> +        } else {
>> +            pr_devel("Page fault successfully handled for pe: 
>> %i!\n", ctx->pe);
>> +            cxl_ops->ack_irq(ctx, CXL_PSL_TFC_An_R, 0);
>> +        }
>
>
> Could we have that code in a wrapper before calling 
> cxl_handle_page_fault()? It would keep the code cleaner and in line 
> with what we do for cxl_handle_segment_miss().
>

We can try to to that.


>
>
>> +++ b/include/misc/cxllib.h
>> @@ -0,0 +1,132 @@
>> +/*
>> + * Copyright 2016 IBM Corp.
>
>
> Year update.
>
>
>> +/*
>> + * Get the Process Element structure for the given thread
>> + *
>> + * Input:
>> + *    pid: points the struct pid for the given thread (i.e. linux pid)
>> + *    translation_mode: whether addresses should be translated
>> + */
>> +struct cxllib_pe_attributes {
>> +    u64 sr;
>> +    u32 lpid;
>> +    u32 tid;
>> +    u32 pid;
>> +};
>> +#define CXL_TRANSLATED_MODE 0
>> +#define CXL_REAL_MODE 1
>> +
>> +int cxllib_get_PE_attributes(struct task_struct *task,
>> +         unsigned long translation_mode, struct cxllib_pe_attributes 
>> *attr);
>
>
> Description in comment no longer matches reality.
> /*
>  * Get the Process Element structure for the given thread
>  *
>  * Input:
>  *    task: task_struct for the context of the translation
>  *    translation_mode: whether addresses should be translated
>  * Output:
>  *    attr: attributes to fill up the Process Element structure from CAIA
>  */
>
>
> Thanks,
>
>   Fred
