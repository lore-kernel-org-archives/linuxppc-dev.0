Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4077xS6SyMzF0g8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2018 03:18:03 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2NGG5kt117282
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 12:18:01 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gw25y08c4-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 12:18:00 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Fri, 23 Mar 2018 16:17:59 -0000
Subject: Re: [PATCH] cxl: disable the lazy approach for irqs in POWERVM
 environment.
To: benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 fbarrat@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
References: <1521736674-13128-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1521771288.16434.326.camel@au1.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Fri, 23 Mar 2018 17:17:56 +0100
MIME-Version: 1.0
In-Reply-To: <1521771288.16434.326.camel@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <fd18ea29-18f9-ae02-4e26-535ee189f739@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 23/03/2018 à 03:14, Benjamin Herrenschmidt a écrit :
> On Thu, 2018-03-22 at 17:37 +0100, Christophe Lombard wrote:
>> The cxl driver cannot disable the interrupt at the device level and has
>> to use disable_irq[_nosync] instead.
>> To avoid the implementation of the lazy optimisation (the interrupt is
>> marked disabled, but the hardware is left unmasked), we can disable it,
>> for a particular irq line, by calling
>> 'irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY)'.
> 
> Why do you need that ? What's wrong with the lazy approach ? It makes
> disable_irq/enable_irq faster...
> 
> You shouldn't need that unless your device is generating a *LOT* of
> irqs while disabled.
> 

An issue on POWERVM (CAPI) has been introduced with the following patch
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bf22ff45bed664aefb5c4e43029057a199b7070c 

The PSL or AFU interrupts are never received by the cxl driver because 
the interrupts are never unmasked.

Without this patch (genirq: Avoid unnecessary low level irq function 
calls), the callback desc->irq_data.chip->irq_unmask(&desc->irq_data); 
(= ics_rtas_unmask_irq()) is called by default through irq_enable().

The cxl driver disables the interrupts before attaching the process 
element and enables the interrupts after that.

In the current code, irq_enable() unmasks the irq only if the irq state 
is IRQD_IRQ_MASKED but it does not.

Call irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY) allows forcing 
irq_disable() to update the irq state to IRQD_IRQ_MASKED and by default
irq_enable() will unmask the irq through ics_rtas_unmask_irq().




>> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
>> ---
>>   drivers/misc/cxl/guest.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
>> index f58b4b6c..dc476e1 100644
>> --- a/drivers/misc/cxl/guest.c
>> +++ b/drivers/misc/cxl/guest.c
>> @@ -389,6 +389,7 @@ static void disable_afu_irqs(struct cxl_context *ctx)
>>   		hwirq = ctx->irqs.offset[r];
>>   		for (i = 0; i < ctx->irqs.range[r]; hwirq++, i++) {
>>   			virq = irq_find_mapping(NULL, hwirq);
>> +			irq_set_status_flags(virq, IRQ_DISABLE_UNLAZY);
>>   			disable_irq(virq);
>>   		}
>>   	}
