Return-Path: <haren@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40XQx53rPzzF24D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2018 17:46:33 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3R7iu8F127502
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2018 03:46:27 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hkvkjqac5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2018 03:46:27 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Fri, 27 Apr 2018 03:46:26 -0400
Date: Fri, 27 Apr 2018 00:46:17 -0700
From: Haren Myneni <haren@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: paste - Mask XERSO bit in CR
References: <1524725319.26204.4.camel@hbabu-laptop>
 <871sf15fl4.fsf@concordia.ellerman.id.au>
In-Reply-To: <871sf15fl4.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Message-Id: <5AE2D549.9010105@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/26/2018 11:27 PM, Michael Ellerman wrote:
> Haren Myneni <haren@linux.vnet.ibm.com> writes:
>>     
>> NX can set 3rd bit in CR register for XER[SO] (Summation overflow)
>> which is not used for paste return value. So. mask this bit to get
>> proper return status.
> 
> This sounds like a bug fix, but I can't tell from the change log.
> 
> What happens if we don't merge this patch? Is it bad?
> 
> Should I add:
> 
>   Fixes: 2392c8c8c045 ("powerpc/powernv/vas: Define copy/paste interfaces")
>   Cc: stable@vger.kernel.org # v4.14+

Thanks for your review. 

Yes, it is a bug, We should ignore XER[SO] from the return status which is nothing to with NX. Otherwise, successful paste instruction will be returned as failure when this bit is set. Not easy to reproduce. We did not see this bug on P9 NX 842 so far, but noticed this issue few times when testing user space NX gzip with 32 threads and 1 million requests per thread. We added similar fix on P8 (with icswx) and can happen on P9 NX842. 

P8 fix - 6333ed8f26cf crypto: nx-842 - Mask XERS0 bit in return value

paste (powerISA V3.0b page#855): 

CR0 Description
0b000||XERSO Data transfer failed due to a
sequence error or a conflict with
tlbie or some implementation-
specific problem.
0b001||XERSO Data transfer successful

I will resend patch with more description.

Thanks
Haren

> 
> 
> cheers
> 
>> diff --git a/arch/powerpc/platforms/powernv/copy-paste.h b/arch/powerpc/platforms/powernv/copy-paste.h
>> index c9a5036..82392e3 100644
>> --- a/arch/powerpc/platforms/powernv/copy-paste.h
>> +++ b/arch/powerpc/platforms/powernv/copy-paste.h
>> @@ -9,7 +9,8 @@
>>  #include <asm/ppc-opcode.h>
>>  
>>  #define CR0_SHIFT	28
>> -#define CR0_MASK	0xF
>> +#define CR0_MASK	0xE /* 3rd bit undefined or set for XER[SO] */
>> +
>>  /*
>>   * Copy/paste instructions:
>>   *
> 
