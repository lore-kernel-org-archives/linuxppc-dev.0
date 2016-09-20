Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdZX24TvYzDsfh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 17:44:18 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id n24so570961pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 00:44:18 -0700 (PDT)
Subject: Re: [2/2] Detect instruction fetch denied and report
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org
References: <3sdY0t2gfYz9svs@ozlabs.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <104b6975-6615-e723-e46a-36e98dc46db2@gmail.com>
Date: Tue, 20 Sep 2016 17:44:12 +1000
MIME-Version: 1.0
In-Reply-To: <3sdY0t2gfYz9svs@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 20/09/16 16:35, Michael Ellerman wrote:
> On Mon, 2016-22-08 at 01:56:57 UTC, Balbir Singh wrote:
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index a4db22f..f162e77 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -404,6 +404,10 @@ good_area:
>>  		    (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
>>  		     !(vma->vm_flags & (VM_READ | VM_WRITE))))
>>  			goto bad_area;
>> +#ifdef CONFIG_PPC_RADIX_MMU
> 
> We shouldn't need the #ifdef, radix_enabled() will be false.
> 
>> +		if (radix_enabled() && regs->msr & PPC_BIT(35))
>> +			goto bad_area;
> 
> Is it really architected as radix only?
> 
> Personally I dislike PPC_BIT(), I'd rather you just used 0x10000000. That way
> when I'm staring at a register dump I have some chance of spotting that mask.
> 
> Also brackets around the bitwise & would make me feel more comfortable.
> 
> cheers
> 


Will make the changes and submit

Balbir
