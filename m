Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yM4jK1lrSzDql4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 07:33:24 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9OKW77F050042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 16:33:22 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dtc3225yf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 16:33:22 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 24 Oct 2017 16:33:21 -0400
Subject: Re: [PATCH v2 3/8] powerpc/mm: Separate ibm, dynamic-memory data from
 DT format
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <150850568437.9118.13945089249591962212.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <150850572658.9118.9227271506499547385.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <87po9d3wof.fsf@concordia.ellerman.id.au>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 24 Oct 2017 15:33:16 -0500
MIME-Version: 1.0
In-Reply-To: <87po9d3wof.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <4c265064-1584-a162-743f-be77d3a67c69@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/24/2017 01:08 AM, Michael Ellerman wrote:
> Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
> 
>> diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
>> new file mode 100644
>> index 000000000000..8ad7cf36b2c4
>> --- /dev/null
>> +++ b/arch/powerpc/mm/drmem.c
>> @@ -0,0 +1,84 @@
>> +/*
>> + * Dynamic reconfiguration memory support
>> + *
>> + * Copyright 2017 IBM Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
>> +
>> +#define pr_fmt(fmt) "drmem: " fmt
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/of.h>
>> +#include <linux/of_fdt.h>
>> +#include <linux/bootmem.h>
>> +#include <asm/prom.h>
>> +#include <asm/drmem.h>
>> +
>> +static struct drmem_lmb_info __drmem_info;
>> +struct drmem_lmb_info *drmem_info = &__drmem_info;
>> +
>> +int __init init_drmem_lmbs(unsigned long node)
>> +{
> 
> Something in here is blowing up for me.
> 
> This is a p8 LPAR, which uses petitboot so we kexec into the kernel,
> gives me:
> 
>   [   29.020618] kexec_core: Starting new kernel
>   [    0.000000] bootconsole [udbg0] enabled
>    -> early_setup(), dt_ptr: 0x1ec60000
>   [    0.000000] bootmem alloc of 3024 bytes failed!
>   [    0.000000] Kernel panic - not syncing: Out of memory
>   [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.14.0-rc2-gcc6-gf7212f8 #1
>   [    0.000000] Call Trace:
>   [    0.000000] [c000000000f57b80] [c000000000a2bae0] dump_stack+0xb0/0xf0 (unreliable)
>   [    0.000000] [c000000000f57bc0] [c0000000000fcdb0] panic+0x148/0x338
>   [    0.000000] [c000000000f57c60] [c000000000d4bb08] ___alloc_bootmem.part.1+0x3c/0x40
>   [    0.000000] [c000000000f57cc0] [c000000000d4bf18] __alloc_bootmem+0x3c/0x50
>   [    0.000000] [c000000000f57cf0] [c000000000d226c4] init_drmem_lmbs+0xf8/0x31c
>   [    0.000000] [c000000000f57d70] [c000000000d1a05c] early_init_dt_scan_memory_ppc+0x88/0x25c
>   [    0.000000] [c000000000f57e10] [0000000000d78e78] 0xd78e78
>   [    0.000000] [c000000000f57e70] [0000000000d1a92c] 0xd1a92c
>   [    0.000000] [c000000000f57f10] [0000000000d1be3c] 0xd1be3c
>   [    0.000000] [c000000000f57f90] [000000000000b13c] 0xb13c
>   [    0.000000] Rebooting in 180 seconds..
>   [    0.000000] System Halted, OK to turn off power
> 
> 

Looks like we're out of memory when trying to allocate the LMB array, not sure why.
I'll try to re-create this  on one of my systems.

I found a patch where you tried to remove traces of bootmem from a couple of
yearts ago. Not sure if it make a difference but should I be using
memblock_virt_alloc() instead of alloc_bootmem()?

-Nathan

> I'm at kernel summit so haven't had time to look any further sorry.
> 
> cheers
> 
