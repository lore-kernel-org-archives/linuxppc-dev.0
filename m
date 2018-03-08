Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxZFX45x4zF1pR
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 13:28:48 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w282O4Qr088196
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Mar 2018 21:28:45 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gjpe2caar-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2018 21:28:44 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 7 Mar 2018 19:28:44 -0700
Subject: Re: [PATCH 1/2] powerpc/mm/keys: Move pte bits to correct headers
To: Ram Pai <linuxram@us.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
References: <20180307133645.29290-1-aneesh.kumar@linux.vnet.ibm.com>
 <20180307202831.GJ1060@ram.oc3035372033.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 8 Mar 2018 07:58:35 +0530
MIME-Version: 1.0
In-Reply-To: <20180307202831.GJ1060@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <38fd173d-9109-d602-377d-760c4d0fb6b7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/08/2018 01:58 AM, Ram Pai wrote:
> On Wed, Mar 07, 2018 at 07:06:44PM +0530, Aneesh Kumar K.V wrote:
>> Memory keys are supported only with hash translation mode. Instead of #ifdef in
>> generic code move the key related pte bits to respective headers
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/book3s/64/hash-4k.h  |  7 +++++++
>>   arch/powerpc/include/asm/book3s/64/hash-64k.h |  7 +++++++
>>   arch/powerpc/include/asm/book3s/64/pgtable.h  | 19 -------------------
>>   3 files changed, 14 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
>> index fc3dc6a93939..4103bfc7c223 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
>> @@ -33,6 +33,13 @@
>>   #define H_PAGE_THP_HUGE 0x0
>>   #define H_PAGE_COMBO	0x0
>>
>> +/* memory key bits, only 8 keys supported */
>> +#define H_PTE_PKEY_BIT0	0
>> +#define H_PTE_PKEY_BIT1	0
>> +#define H_PTE_PKEY_BIT2	_RPAGE_RSV3
>> +#define H_PTE_PKEY_BIT3	_RPAGE_RSV4
>> +#define H_PTE_PKEY_BIT4	_RPAGE_RSV5
>> +
> 
> 
> If CONFIG_PPC_MEM_KEYS is not defined, all of them have to be 0.  How is
> that handled here?

why? conditional defines of pte bits always results in error, like we 
check for an overloaded key bit in some code path and taking wrong action.

> 
>>   /* 8 bytes per each pte entry */
>>   #define H_PTE_FRAG_SIZE_SHIFT  (H_PTE_INDEX_SIZE + 3)
>>   #define H_PTE_FRAG_NR	(PAGE_SIZE >> H_PTE_FRAG_SIZE_SHIFT)
>> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
>> index e53728ff29a0..bb880c97b87d 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
>> @@ -16,6 +16,13 @@
>>   #define H_PAGE_BUSY	_RPAGE_RPN44     /* software: PTE & hash are busy */
>>   #define H_PAGE_HASHPTE	_RPAGE_RPN43	/* PTE has associated HPTE */
>>
>> +/* memory key bits. */
>> +#define H_PTE_PKEY_BIT0	_RPAGE_RSV1
>> +#define H_PTE_PKEY_BIT1	_RPAGE_RSV2
>> +#define H_PTE_PKEY_BIT2	_RPAGE_RSV3
>> +#define H_PTE_PKEY_BIT3	_RPAGE_RSV4
>> +#define H_PTE_PKEY_BIT4	_RPAGE_RSV5
>> +
> 
> same comment as above.
> 

-aneesh
