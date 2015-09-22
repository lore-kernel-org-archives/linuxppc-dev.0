Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A36141A0B33
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 16:48:25 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 22 Sep 2015 12:18:23 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id CFB76E0063
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 12:17:57 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8M6mIwh66846724
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 12:18:18 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8M6mIF8026881
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 12:18:18 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/31] powerpc/mm: Update page table format for book3s 64
In-Reply-To: <1442872135.19102.184.camel@freescale.com>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442872135.19102.184.camel@freescale.com>
Date: Tue, 22 Sep 2015 12:18:17 +0530
Message-ID: <877fnj3q6m.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> writes:

> On Mon, 2015-09-21 at 12:10 +0530, Aneesh Kumar K.V wrote:
>> Hi All,
>> 
>> This patch series attempt to update book3s 64 linux page table format to
>> make it more flexible. Our current pte format is very restrictive and we
>> overload multiple pte bits. This is due to the non-availability of free bits
>> in pte_t. We use pte_t to track the validity of 4K subpages. This patch
>> series free up pte_t of 11 bits by moving 4K subpage tracking to the
>> lower half of PTE page. The pte format is updated such that we have a
>> better method for identifying a pte entry at pmd level. This will also 
>> enable
>> us to implement hugetlb migration(not yet done in this series). 
>> 
>> Before making the changes to the pte format, I am splitting the
>> pte header definition such that we now have the below layout for headers
>> 
>> book3s
>>    32
>>      hash.h pgtable.h 
>>    64
>>      hash.h  pgtable.h hash-4k.h hash-64k.h
>> booke
>>   32
>>      pgtable.h pte-40x.h pte-44x.h pte-8xx.h pte-fsl-booke.h
>>   64
>>     pgtable-4k.h  pgtable-64k.h  pgtable.h
>
> 40x and 8xx are not booke.  Is there a better name that can be used for this 
> directory?  Maybe "nohash", similar to arch/powerpc/mm/tlb_nohash.c?
>

I looked at Documentation/powerpc/cpu_families.txt to name the headers.
It lists then below booke.

-aneesh
