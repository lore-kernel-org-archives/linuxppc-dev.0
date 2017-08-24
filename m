Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdG3k1d3MzDqNc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 17:23:14 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7O7JSTa124703
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 03:23:11 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2chjeyexkk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 03:23:10 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Thu, 24 Aug 2017 08:23:09 +0100
Subject: Re: [PATCH] cxl: Add support for POWER9 DD2
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com
References: <1503500286-1684-1-git-send-email-clombard@linux.vnet.ibm.com>
 <fec79e8f-bd3b-4e3f-55b8-7335b1ccb70a@au1.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Thu, 24 Aug 2017 09:23:05 +0200
MIME-Version: 1.0
In-Reply-To: <fec79e8f-bd3b-4e3f-55b8-7335b1ccb70a@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <662aff24-cb60-432c-a6b8-cd04e7498711@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 24/08/2017 à 07:24, Andrew Donnellan a écrit :
> On 24/08/17 00:58, Christophe Lombard wrote:
>> The PSL initialization sequence has been updated to DD2.
>> This patch adapts to the changes, retaining compatibility with DD1.
>>
>> Tests performed on some of the new hardware.
>
> If we're retaining compatibility with DD1 I assume it's been tested on 
> some of the old hardware too?

right, it's been tested on boston machine with dd1

>
> It seems this includes some changes to DD1 fix-ups as well.

correct

>
>>
>> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com> > ---
>>   drivers/misc/cxl/cxl.h |  2 ++
>>   drivers/misc/cxl/pci.c | 57 
>> +++++++++++++++++++++++++++++++-------------------
>>   2 files changed, 38 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
>> index b1afecc..0167df8 100644
>> --- a/drivers/misc/cxl/cxl.h
>> +++ b/drivers/misc/cxl/cxl.h
>> @@ -100,6 +100,8 @@ static const cxl_p1_reg_t CXL_XSL_FEC = {0x0158};
>>   static const cxl_p1_reg_t CXL_XSL_DSNCTL    = {0x0168};
>>   /* PSL registers - CAIA 2 */
>>   static const cxl_p1_reg_t CXL_PSL9_CONTROL  = {0x0020};
>> +static const cxl_p1_reg_t CXL_XSL9_INV      = {0x0110};
>> +static const cxl_p1_reg_t CXL_XSL9_DEF      = {0x0140};
>>   static const cxl_p1_reg_t CXL_XSL9_DSNCTL   = {0x0168};
>>   static const cxl_p1_reg_t CXL_PSL9_FIR1     = {0x0300};
>>   static const cxl_p1_reg_t CXL_PSL9_FIR2     = {0x0308};
>> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
>> index d18b3d9..a981c65 100644
>> --- a/drivers/misc/cxl/pci.c
>> +++ b/drivers/misc/cxl/pci.c
>> @@ -475,37 +475,52 @@ static int 
>> init_implementation_adapter_regs_psl9(struct cxl *adapter,
>>       psl_fircntl |= 0x1ULL; /* ce_thresh */
>>       cxl_p1_write(adapter, CXL_PSL9_FIR_CNTL, psl_fircntl);
>>   -    /* vccredits=0x1  pcklat=0x4 */
>> -    cxl_p1_write(adapter, CXL_PSL9_DSNDCTL, 0x0000000000001810ULL);
>> -
>> -    /*
>> -     * For debugging with trace arrays.
>> -     * Configure RX trace 0 segmented mode.
>> -     * Configure CT trace 0 segmented mode.
>> -     * Configure LA0 trace 0 segmented mode.
>> -     * Configure LA1 trace 0 segmented mode.
>> +    /* Setup the PSL to transmit packets on the PCIe before the
>> +     * CAPP is enabled
>>        */
>> -    cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8040800080000000ULL);
>> -    cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8040800080000003ULL);
>> -    cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8040800080000005ULL);
>> -    cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8040800080000006ULL);
>> +    cxl_p1_write(adapter, CXL_PSL9_DSNDCTL, 0x0001001000002A10ULL);
>> +
>> +    /* For debugging with trace arrays */
>> +    /* Configure RX trace 0 segmented mode */
>> +    cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8200000000000000ULL);
>> +    /* Configure RX trace 1 segmented mode */
>> +    cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0xAA00000000000001ULL);
>> +    /* Configure CT trace 0 segmented mode */
>> +    cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0xA2B8000000000003ULL);
>> +    /* Configure LA0 trace 0 segmented mode */
>> +    cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x83FFC00000000005ULL);
>> +    /* Configure JM0 trace 0 segmented mode */
>> +    cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8200000000000007ULL);
>> +    /* Configure DMA trace 0 segmented mode */
>> +    cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8200000000000008ULL);
>> +    /* Configure DMA trace 1 segmented mode */
>> +    cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8200000000000009ULL);
>>         /*
>>        * A response to an ASB_Notify request is returned by the
>>        * system as an MMIO write to the address defined in
>>        * the PSL_TNR_ADDR register
>>        */
>> -    /* PSL_TNR_ADDR */
>> +    /* keep the Reset Value: 0x00020000E0000000 */
>
> I was confused by this comment for a while - maybe keep PSL_TNR_ADDR 
> at the beginning of the comment, it's not completely clear from the 
> previous block alone.

okay, will do.

>
>> +
>> +    /* Enable XSL rty limit */
>> +    cxl_p1_write(adapter, CXL_XSL9_DEF, 0x51F8000000000005ULL);
>>   -    /* NORST */
>> -    cxl_p1_write(adapter, CXL_PSL9_DEBUG, 0x8000000000000000ULL);
>> +    /* Change XSL_INV dummy readtheshold */
>
> read threshold?
>
>> +    cxl_p1_write(adapter, CXL_XSL9_INV, 0x0000040007FFC200ULL);
>>   -    /* allocate the apc machines */
>> -    cxl_p1_write(adapter, CXL_PSL9_APCDEDTYPE, 0x40000003FFFF0000ULL);
>> +    if (phb_index == 3) {
>> +        /* disable machines 31-47 and 20-27 for DMA */
>> +        cxl_p1_write(adapter, CXL_PSL9_APCDEDTYPE, 
>> 0x40000FF3FFFF0000ULL);
>> +    }
>> +
>> +    /* Snoop machines */
>> +    cxl_p1_write(adapter, CXL_PSL9_APCDEDALLOC, 0x800F000200000000ULL);
>>   -    /* Disable vc dd1 fix */
>> -    if (cxl_is_power9_dd1())
>> -        cxl_p1_write(adapter, CXL_PSL9_GP_CT, 0x0400000000000001ULL);
>> +    if (cxl_is_power9_dd1()) {
>> +        /* Disabling deadlock counter CAR */
>> +        cxl_p1_write(adapter, CXL_PSL9_GP_CT, 0x0020000000000001ULL);
>> +    }
>>         return 0;
>>   }
>>
>
