Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wLMdQ2y8vzDqFT
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 May 2017 20:42:02 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v47AYIUU090678
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 7 May 2017 06:41:45 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2aa1sprhsm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 May 2017 06:41:45 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Sun, 7 May 2017 11:41:43 +0100
Subject: Re: [RFC 2/2] cxl: Mark context requiring global TLBIs
To: Balbir Singh <bsingharora@gmail.com>, alistair@popple.id.au,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
References: <20170503142906.29220-1-fbarrat@linux.vnet.ibm.com>
 <20170503142906.29220-3-fbarrat@linux.vnet.ibm.com>
 <1493883553.7934.5.camel@gmail.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Sun, 7 May 2017 12:41:38 +0200
MIME-Version: 1.0
In-Reply-To: <1493883553.7934.5.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <6f269c40-c72a-8415-21e1-058c91a43f6b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 04/05/2017 à 09:39, Balbir Singh a écrit :
> On Wed, 2017-05-03 at 16:29 +0200, Frederic Barrat wrote:
>> The PSL needs to see all TLBI pertinent to the memory contexts used on
>> the cxl adapter. For the hash memory model, it was done by making all
>> TLBIs global as soon as the cxl driver is in us. For radix, we need
>> something similar, but we can refine and only convert to global the
>> invalidations for contexts actually used by the device.
>>
>> So mark the contexts being attached to the cxl adapter as requiring
>> global TLBIs.
>>
> <snip>
>> +#ifdef CONFIG_PPC_BOOK3S_64
>> +	if (ctx->mm)
>> +		mm_context_set_global_tlbi(&ctx->mm->context);
>
> Just curious and wondering
>
> Could we do mm_context_set_global_tlbi() before ->attach_process() that
> way we won't need atomic tests (set_bit() and test_bit())? May be a memory
> barrier would suffice. Not 100% sure, hence checking


You're right, I need to move mm_context_set_global_tlbi() before the 
attach and have a write memory barrier.
If the attach fails, then the context will still be marked for global 
TLBIs (some other driver may also set the bit for a different reason). 
But I would expect the life expectancy of a process designed to use an 
accelerator and failing to attach to be pretty short.

I still think we need the atomic set_bit() though, but that's really for 
the future and if somebody introduces new bits in the context 'flags'.

   Fred


> Balbir Singh.
>
