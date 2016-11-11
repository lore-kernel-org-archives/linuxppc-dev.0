Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFV4M0hCGzDvgG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 17:14:27 +1100 (AEDT)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tFV4L3j65z9t1P
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 17:14:26 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id y68so1287878pfb.1
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2016 22:14:26 -0800 (PST)
Subject: Re: [PATCH 2/3] Detect instruction fetch denied and report
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <1478007500-23624-1-git-send-email-bsingharora@gmail.com>
 <1478007500-23624-3-git-send-email-bsingharora@gmail.com>
 <877f8e2btr.fsf@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <6e780c3c-af62-4c5c-efb8-d75e15104d68@gmail.com>
Date: Fri, 11 Nov 2016 17:14:10 +1100
MIME-Version: 1.0
In-Reply-To: <877f8e2btr.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/11/16 03:09, Aneesh Kumar K.V wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> 
>> ISA 3 allows for prevention of instruction fetch and execution
>> of user mode pages. If such an error occurs, SRR1 bit 35
>> reports the error. We catch and report the error in do_page_fault()
>>
>> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
>> ---
>>  arch/powerpc/mm/fault.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index d0b137d..835fd03 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -404,6 +404,10 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>>  		    (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
>>  		     !(vma->vm_flags & (VM_READ | VM_WRITE))))
>>  			goto bad_area;
>> +
>> +		if (radix_enabled() && (regs->msr & SRR1_ISI_N_OR_G))
>> +			goto bad_area;
> 
> Why is this within radix_enabled() ? Hash can also generate an
> interrupt with that SRR1 value right ?
> 

Yes the bits are not specific to radix. I suspect the check above took
care of instruction exceptions, so we've never needed it before. I'll
remove the check

Balbir
