Return-Path: <haren@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zdpK1YPCzF0fC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 12:16:08 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w542C0bJ005326
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Jun 2018 22:16:06 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jcveb82wf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Jun 2018 22:16:05 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Sun, 3 Jun 2018 20:16:05 -0600
Date: Sun, 03 Jun 2018 19:15:55 -0700
From: Haren Myneni <haren@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: linuxppc-dev@lists.ozlabs.org, sukadev@linux.vnet.ibm.com
Subject: Re: powerpc/powernv: copy/paste - Mask XERS0 bit in CR
References: <1527740956.5945.12.camel@hbabu-laptop>
 <87r2lokuxb.fsf@concordia.ellerman.id.au>
In-Reply-To: <87r2lokuxb.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <5B14A0DB.9040704@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/03/2018 03:48 AM, Michael Ellerman wrote:
> Hi Haren,
> 
> Haren Myneni <haren@linux.vnet.ibm.com> writes:
>>     
>> NX can set 3rd bit in CR register for XER[SO] (Summation overflow)
>> which is not related to paste request. The current paste function
>> returns failure for the successful request when this bit is set.
>> So mask this bit and check the proper return status.
>>
>> Fixes: 2392c8c8c045 ("powerpc/powernv/vas: Define copy/paste interfaces")
>> Cc: stable@vger.kernel.org # v4.14+    
>> Signed-off-by: Haren Myneni <haren@us.ibm.com>
>>
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
> Unfortunately this no longer applies to my next branch, because those
> macros have been moved out of this header as part of an unrelated patch.
> 
> The following patch should work instead, can you please confirm by
> testing it?
> 
> diff --git a/arch/powerpc/platforms/powernv/copy-paste.h b/arch/powerpc/platforms/powernv/copy-paste.h
> index 3fa62de96d9c..c46a326776cf 100644
> --- a/arch/powerpc/platforms/powernv/copy-paste.h
> +++ b/arch/powerpc/platforms/powernv/copy-paste.h
> @@ -41,5 +41,7 @@ static inline int vas_paste(void *paste_address, int offset)
>  		: "b" (offset), "b" (paste_address)
>  		: "memory", "cr0");
> 
> -	return (cr >> CR0_SHIFT) & CR0_MASK;
> +
> +	/* We mask with 0xE to ignore SO */
> +	return (cr >> CR0_SHIFT) & 0xE;
>  }
> 
> 

Tested with this patch and it works.

Thanks
Haren

> cheers
> 
