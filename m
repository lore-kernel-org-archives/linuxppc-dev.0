Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP07059d2zDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 13:13:00 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1G23jWT043311
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 21:12:57 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28mq9knm6c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 21:12:57 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 15 Feb 2017 19:12:56 -0700
Subject: Re: [PATCH 2/2] powerpc/mm/autonuma: Switch ppc64 to its own
 implementeation of saved write
To: Andrew Morton <akpm@linux-foundation.org>
References: <1486609259-6796-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1486609259-6796-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20170215134627.315dd734bd0000393a680cc9@linux-foundation.org>
Cc: Rik van Riel <riel@surriel.com>, Mel Gorman <mgorman@techsingularity.net>,
 paulus@ozlabs.org, benh@kernel.crashing.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 16 Feb 2017 07:42:46 +0530
MIME-Version: 1.0
In-Reply-To: <20170215134627.315dd734bd0000393a680cc9@linux-foundation.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <ac64eed6-06fc-642b-8e33-f4d6e6f4f0a5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 16 February 2017 03:16 AM, Andrew Morton wrote:
> On Thu,  9 Feb 2017 08:30:59 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> With this our protnone becomes a present pte with READ/WRITE/EXEC bit cleared.
>> By default we also set _PAGE_PRIVILEGED on such pte. This is now used to help
>> us identify a protnone pte that as saved write bit. For such pte, we will clear
>> the _PAGE_PRIVILEGED bit. The pte still remain non-accessible from both user
>> and kernel.
> I don't see how these patches differ from the ones which are presently
> in -mm.
>
> It helps to have a [0/n] email for a patch series and to put a version
> number in there as well.
>
>> +#define pte_mk_savedwrite pte_mk_savedwrite
>> +static inline pte_t pte_mk_savedwrite(pte_t pte)
>> +{
>> +	/*
>> +	 * Used by Autonuma subsystem to preserve the write bit
>> +	 * while marking the pte PROT_NONE. Only allow this
>> +	 * on PROT_NONE pte
>> +	 */
>> +	VM_BUG_ON((pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_RWX | _PAGE_PRIVILEGED)) !=
>> +		  cpu_to_be64(_PAGE_PRESENT | _PAGE_PRIVILEGED));
>> +	return __pte(pte_val(pte) & ~_PAGE_PRIVILEGED);
>> +}
>> +
>> +#define pte_savedwrite pte_savedwrite
>> +static inline bool pte_savedwrite(pte_t pte)
>> +{
>> +	/*
>> +	 * Saved write ptes are prot none ptes that doesn't have
>> +	 * privileged bit sit. We mark prot none as one which has
>> +	 * present and pviliged bit set and RWX cleared. To mark
>> +	 * protnone which used to have _PAGE_WRITE set we clear
>> +	 * the privileged bit.
>> +	 */
>> +	return !(pte_raw(pte) & cpu_to_be64(_PAGE_RWX | _PAGE_PRIVILEGED));
>> +}
>> +
>>   static inline pte_t pte_mkdevmap(pte_t pte)
>>   {
>>   	return __pte(pte_val(pte) | _PAGE_SPECIAL|_PAGE_DEVMAP);
> arch/powerpc/include/asm/book3s/64/pgtable.h doesn't have
> pte_mkdevmap().  What tree are you patching here?
>
>

I did post a V2 of this for which you replied
https://lkml.kernel.org/r/20170214162008.bd592c747fc5e167c10ce7b8@linux-foundation.org

I actually found the issue with this patch. I will be sending V3 after 
more testing.

-aneesh
