Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkrhD46xdzDqwy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 14:40:12 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2H3ceuB095880
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 23:40:01 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 297ym530xq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 23:40:01 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 21:40:00 -0600
Subject: Re: [PATCH V2 09/11] powerpc/mm: Lower the max real address to 51 bits
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au
References: <1489660329-22501-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1489660329-22501-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1489699583.26634.29.camel@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 17 Mar 2017 09:09:52 +0530
MIME-Version: 1.0
In-Reply-To: <1489699583.26634.29.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <4b13983a-2eed-efbf-5869-0a5adffd19fa@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 17 March 2017 02:56 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2017-03-16 at 16:02 +0530, Aneesh Kumar K.V wrote:
>> Max value supported by hardware is 51 bits address. Radix page table define
>> a slot of 57 bits for future expansion. We restrict the value supported in
>> linux kernel 51 bits, so that we can use the bits between 57-51 for storing
>> hash linux page table bits. This is done in the next patch.
>
> All of them ? I would keep some for future backward compatibility. It's likely
> that a successor to P9 will have more physical address bits. I feel nervous
> limiting to precisely what P9 supports.
>

What do you want to keep as MAX PFN bits here ?. Any new expansion will 
eat into the software bits defined by Radix and hence can't be used
for generic features.


>> This will free up the software page table bits to be used for features
>> that are needed for both hash and radix. The current hash linux page table
>> format doesn't have any free software bits. Moving hash linux page table
>> specific bits to top of RPN field free up the software bits for other purpose.
>>

-aneesh
