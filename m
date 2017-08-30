Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xj6dC4GjbzDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 00:02:07 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7UE1cUp053741
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 10:02:04 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cnu6n9wwu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 10:01:29 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 30 Aug 2017 14:59:58 +0100
Subject: Re: [PATCH v2 1/3] powerpc/mm: Export flush_all_mm()
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, andrew.donnellan@au1.ibm.com,
 clombard@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com
Cc: alistair@popple.id.au
References: <20170830101550.16821-1-fbarrat@linux.vnet.ibm.com>
 <87inh519fl.fsf@concordia.ellerman.id.au>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 15:59:53 +0200
MIME-Version: 1.0
In-Reply-To: <87inh519fl.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <77b082b9-0e6e-ed38-3a4e-af7797990ef3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 30/08/2017 à 15:17, Michael Ellerman a écrit :
> Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:
> 
>> With the optimizations introduced by commit a46cc7a90fd8
>> ("powerpc/mm/radix: Improve TLB/PWC flushes"), flush_tlb_mm() no
>> longer flushes the page walk cache with radix. This patch introduces
>> flush_all_mm(), which flushes everything, tlb and pwc, for a given mm.
>>
>> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>> ---
>> Changelog:
>> v2: this patch is new
>>
>>   arch/powerpc/include/asm/book3s/64/tlbflush-hash.h  |  8 ++++++++
>>   arch/powerpc/include/asm/book3s/64/tlbflush-radix.h |  3 +++
>>   arch/powerpc/include/asm/book3s/64/tlbflush.h       | 15 +++++++++++++++
>>   arch/powerpc/mm/tlb-radix.c                         |  6 ++++--
>>   4 files changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
>> index 2f6373144e2c..c5d89d271a96 100644
>> --- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
>> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
>> @@ -65,6 +65,14 @@ static inline void hash__flush_tlb_mm(struct mm_struct *mm)
>>   {
>>   }
>>   
>> +static inline void hash__local_flush_all_mm(struct mm_struct *mm)
>> +{
>> +}
>> +
>> +static inline void hash__flush_all_mm(struct mm_struct *mm)
>> +{
>> +}
> 
> It's not clear why it makes sense for these to be empty. Either for the
> general idea of the "flush_all_mm()" API, or for your intended use by
> CXL.

I was not too sure what to do for hash, but the idea is that the new 
flush_all_mm() is really the equivalent of the old flush_tlb_mm() from 
before Ben's optimizations for radix, and that was/still is an empty 
operation on hash, so I kept it that way.

We don't support hash for capi2 yet. Adding it will definitely require 
some work in that area, as the current approach (use count on the driver 
and all TLBIs becoming global when the driver is in use) won't hold much 
longer.

   Fred
