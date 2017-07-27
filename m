Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHwCN468zzDqnP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 11:59:44 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6R1wbfA069704
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 21:59:41 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2by364gp4h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 21:59:41 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 26 Jul 2017 19:59:40 -0600
Subject: Re: [PATCH 1/6] powerpc: Free up four 64K PTE bits in 4K backed HPTE
 pages
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, mhocko@kernel.org
References: <1500663129-10615-1-git-send-email-linuxram@us.ibm.com>
 <1500663129-10615-2-git-send-email-linuxram@us.ibm.com>
 <87lgnb1o57.fsf@linux.vnet.ibm.com>
 <20170726160651.GA5664@ram.oc3035372033.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 27 Jul 2017 07:29:32 +0530
MIME-Version: 1.0
In-Reply-To: <20170726160651.GA5664@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <0aef1bef-c4ad-f745-5efa-07c4c9ae11d5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/26/2017 09:36 PM, Ram Pai wrote:
> On Wed, Jul 26, 2017 at 04:05:48PM +0530, Aneesh Kumar K.V wrote:
>> Ram Pai <linuxram@us.ibm.com> writes:
>>

>>> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
>>> index 9732837..62e580c 100644
>>> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
>>> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
>>> @@ -12,18 +12,14 @@
>>>    */
>>>   #define H_PAGE_COMBO	_RPAGE_RPN0 /* this is a combo 4k page */
>>>   #define H_PAGE_4K_PFN	_RPAGE_RPN1 /* PFN is for a single 4k page */
>>> +#define H_PAGE_BUSY	_RPAGE_RPN42     /* software: PTE & hash are busy */
>>
>>
>> Why are we moving H_PAGE_BUSY. Right now 4k and 64k linux page table
>> format looks similar.
> 
> The goal is to clear off all the _RPAGE_RSV* bits so that they can be
> used for protection keys.  the aim is to keep the protection-bits in the
> _RPAGE_RSV* bits, so that they will work as-is whenever radix MMU enables
> protection keys.
> 
> Yes this makes the PTE format differ from 4k PTE. Hopefully it is a
> small inconvenience. The PTE format for 4K is anyway not exactly the
> same compared to 64K PTE format. For example, higher RPN bits are
> used on 4K but not on 64k. lower RPN bits are used on 64k but not
> on 4k.
I was wondering why in this patch ? You do in the next patch

--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -12,7 +12,7 @@
   */
  #define H_PAGE_COMBO	_RPAGE_RPN0 /* this is a combo 4k page */
  #define H_PAGE_4K_PFN	_RPAGE_RPN1 /* PFN is for a single 4k page */
-#define H_PAGE_BUSY	_RPAGE_RPN42     /* software: PTE & hash are busy */
+#define H_PAGE_BUSY	_RPAGE_RPN44     /* software: PTE & hash are busy */



-aneesh
