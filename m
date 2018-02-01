Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zX5Jf31bwzDqms
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 14:32:02 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w113T64x059303
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jan 2018 22:32:00 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fups181wu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jan 2018 22:31:59 -0500
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 31 Jan 2018 22:31:59 -0500
Subject: Re: [bug report] powerpc/mm/radix: Add tlbflush routines
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Dan Carpenter <dan.carpenter@oracle.com>
Cc: linuxppc-dev@lists.ozlabs.org
References: <20180131154521.GA21698@mwanda>
 <8ada45aa-9b29-408c-ba6f-c0938dce047b@c-s.fr>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 1 Feb 2018 09:01:48 +0530
MIME-Version: 1.0
In-Reply-To: <8ada45aa-9b29-408c-ba6f-c0938dce047b@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <4e6d70bd-a4c6-53af-9ca0-59ecb669c4ce@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 01/31/2018 09:31 PM, Christophe LEROY wrote:
> 
> 
> Le 31/01/2018 à 16:45, Dan Carpenter a écrit :
>> Hello Aneesh Kumar K.V,
>>
>> The patch 1a472c9dba6b: "powerpc/mm/radix: Add tlbflush routines"
>> from Apr 29, 2016, leads to the following static checker warning:
>>
>>     arch/powerpc/mm/tlb_nohash.c:218 __local_flush_tlb_page()
>>     warn: always true condition '(pid != ~0) => (0-u32max != u64max)'
>>
>> arch/powerpc/mm/tlb_nohash.c
>>     211  void __local_flush_tlb_page(struct mm_struct *mm, unsigned 
>> long vmaddr,
>>     212                              int tsize, int ind)
>>     213  {
>>     214          unsigned int pid;
>>     215
>>     216          preempt_disable();
>>     217          pid = mm ? mm->context.id : 0;
>>     218          if (pid != MMU_NO_CONTEXT)
>>                      ^^^^^^^^^^^^^^^^^^^^^
>>     219                  _tlbil_va(vmaddr, pid, tsize, ind);
>>     220          preempt_enable();
>>     221  }
>>
>> I don't know very much about PowerPC.  The static checker is guessing
>> which headers to pull in instead of relying on the build system so there
>> are a lot of false positives.  It's apparently using the
>> arch/powerpc/include/asm/book3s/64/tlbflush.h header which does:
>>
>> #define MMU_NO_CONTEXT ~0UL
>>
>> so it's UINT_MAX vs U64_MAX which is making the checker complain.
> 
> As far as I can see from arch/powerpc/include/asm/mmu-hash64.h, 
> mm->context.id is an unsigned long, so pid should also be an unsigned 
> long, not an unsigned int ?
> 
> Christophe
> 

yes.

We did similar fixup for book3s radix
in 9690c15742688e9cb5ee4aa0b08e458551ceea13 (powerpc/mm/radix: Fix 
always false comparison against MMU_NO_CONTEXT
)

-aneesh
