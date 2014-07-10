Return-Path: <kmadhu@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 269CF1A0156
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 17:46:50 +1000 (EST)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 10AA1140141
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2014 17:46:48 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <kmadhu@linux.vnet.ibm.com>;
 Thu, 10 Jul 2014 13:16:44 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id C43473940049
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2014 13:16:40 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6A7kscL63897778
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2014 13:16:55 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6A7kaO2030167
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2014 13:16:36 +0530
Message-ID: <53BE44DB.8080400@linux.vnet.ibm.com>
Date: Thu, 10 Jul 2014 13:16:35 +0530
From: Madhusudanan Kandasamy <kmadhu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc: Fail remap_4k_pfn() if PFN doesn't fit inside PTE
References: <53BD68FF.7000307@linux.vnet.ibm.com>
 <20140710084911.22cb58d4@canb.auug.org.au>
In-Reply-To: <20140710084911.22cb58d4@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stephen,

Thanks for the suggestion, I'll send a new patch.

On Thursday 10 July 2014 04:19 AM, Stephen Rothwell wrote:
> Hi Madhusudanan,
> 
> On Wed, 09 Jul 2014 21:38:31 +0530 Madhusudanan Kandasamy <kmadhu@linux.vnet.ibm.com> wrote:
>>
>> diff --git a/arch/powerpc/include/asm/pte-hash64-64k.h b/arch/powerpc/include/asm/pte-hash64-64k.h
>> index d836d94..10af7f1 100644
>> --- a/arch/powerpc/include/asm/pte-hash64-64k.h
>> +++ b/arch/powerpc/include/asm/pte-hash64-64k.h
>> @@ -74,8 +74,15 @@
>>  #define pte_pagesize_index(mm, addr, pte)	\
>>  	(((pte) & _PAGE_COMBO)? MMU_PAGE_4K: MMU_PAGE_64K)
>>
>> +static inline int bad_4k_pfn(void)
>> +{
>> +	WARN_ON(1);
>> +	return -EINVAL;
>> +}
>> +
>>  #define remap_4k_pfn(vma, addr, pfn, prot)				\
>> -	remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE,		\
>> -			__pgprot(pgprot_val((prot)) | _PAGE_4K_PFN))
>> +	((pfn >= (1UL << (64 - PTE_RPN_SHIFT))) ? bad_4k_pfn() :	\
>> +		remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE,	\
>> +			__pgprot(pgprot_val((prot)) | _PAGE_4K_PFN)))
>>
>>  #endif	/* __ASSEMBLY__ */
> 
> WARN_ON() returns the value it is passed, so no helper is needed:
> 
>  #define remap_4k_pfn(vma, addr, pfn, prot)				\
> -	remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE,		\
> -			__pgprot(pgprot_val((prot)) | _PAGE_4K_PFN))
> +	WARN_ON(((pfn >= (1UL << (64 - PTE_RPN_SHIFT)))) ? -EINVAL :	\
> +		remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE,	\
> +			__pgprot(pgprot_val((prot)) | _PAGE_4K_PFN)))
> 
