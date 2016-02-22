Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CECB91A05D5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 04:57:13 +1100 (AEDT)
Received: from localhost
 by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 22 Feb 2016 17:57:09 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4236C17D8042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 17:57:27 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1MHv6mX3997962
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 17:57:06 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1MHv59o013319
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 12:57:06 -0500
Subject: Re: Fwd: [PATCH v4 11/18] cxl: Separate bare-metal fields in adapter
 and AFU data structures
To: manoj@linux.vnet.ibm.com
References: <1455658751-16970-12-git-send-email-fbarrat@linux.vnet.ibm.com>
 <56CA2CD1.7020908@linux.vnet.ibm.com> <56CA60E8.6090607@linux.vnet.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>, michael.neuling@au1.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <56CB4BF0.2040906@linux.vnet.ibm.com>
Date: Mon, 22 Feb 2016 18:57:04 +0100
MIME-Version: 1.0
In-Reply-To: <56CA60E8.6090607@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Manoj,

Point taken. Those constants are all defined in the architecture 
document (CAIA). We should probably use more macros there.
However, since those were not introduced by this patch, I'll put it in 
my todo list for the future, but don't intend to address it in this 
patchset.

   Fred

Le 22/02/2016 02:14, Manoj Kumar a écrit :
> Christophe, Fred: Perhaps none of these comments below are specific
> to your patch, but clarification would help the next reviewer.
>
> --
> Manoj Kumar
>
>> Subject: [PATCH v4 11/18] cxl: Separate bare-metal fields in adapter and
>
>>
>> -    WARN_ON(afu->spa_size > 0x100000); /* Max size supported by the
>> hardware */
>> +    WARN_ON(afu->native->spa_size > 0x100000); /* Max size supported by
>> the hardware */
>
> Would prefer to see a MACRO defined, instead of the literal 0x1000000
>
>
>>
>>       cxl_p1_write(adapter, CXL_PSL_ErrIVTE, 0x0000000000000000);
>
> Same as above.
>
>
>>       p1n_base = p1_base(dev) + 0x10000 + (afu->slice * p1n_size);
>
> Same as above.
>
>>
>> @@ -621,7 +622,7 @@ static int cxl_read_afu_descriptor(struct cxl_afu
>> *afu)
>>       afu->pp_size = AFUD_PPPSA_LEN(val) * 4096;
>
> Both val and pp_size are 64bit quantities. Not clear how the overflow
> during multiplication is going to be handled.
>
>
>>       afu->crs_len = AFUD_CR_LEN(val) * 256;
>
> What do the 4096 and 256 represent?
>
>
>>       /* Convert everything to bytes, because there is NO WAY I'd look
>> at the
>>        * code a month later and forget what units these are in ;-) */
>> -    adapter->ps_off = ps_off * 64 * 1024;
>> +    adapter->native->ps_off = ps_off * 64 * 1024;
>>       adapter->ps_size = ps_size * 64 * 1024;
>> -    adapter->afu_desc_off = afu_desc_off * 64 * 1024;
>> -    adapter->afu_desc_size = afu_desc_size *64 * 1024;
>> +    adapter->native->afu_desc_off = afu_desc_off * 64 * 1024;
>> +    adapter->native->afu_desc_size = afu_desc_size * 64 * 1024;
>
> Is this (64k) page size related?
>
>
